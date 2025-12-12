import React, { useEffect, useState } from 'react';
import { Form, Input, Button, message, Spin, Upload, Avatar } from 'antd';
import { UploadOutlined, UserOutlined } from '@ant-design/icons';
import useAuth from '../../hooks/useAuth';
import profileService from '../../services/profileService';
import useProfilePicture from '../../hooks/useProfilePicture';

function Profile() {
  const { user } = useAuth();
  const [loading, setLoading] = useState(false);
  const [form] = Form.useForm();
  const { uploading, uploadProfilePicture, deleteProfilePicture } = useProfilePicture();

  const getAvatarUrl = (avatarUrl) => {
    if (!avatarUrl) return undefined;
    // Always return relative path - nginx will proxy to backend
    return avatarUrl;
  };

  useEffect(() => {
    if (user) {
      form.setFieldsValue({
        username: user.username,
        email: user.email,
        role_name: user.role_name
      });
    }
  }, [user, form]);

  const handleFinish = async (values) => {
    setLoading(true);
    try {
      await profileService.updateProfile(values);
      message.success('Profile updated successfully');
    } catch (err) {
      console.error('Error updating profile:', err);
      message.error('Failed to update profile');
    } finally {
      setLoading(false);
    }
  };

  if (!user) {
    return <Spin size="large" />;
  }

  const handleAvatarUpload = async (file) => {
    const result = await uploadProfilePicture(file);
    if (result.success) {
      message.success('Avatar uploaded successfully');
      window.location.reload(); // Reload to get updated user data
    } else {
      message.error(result.error || 'Failed to upload avatar');
    }
    return false; // Prevent default upload behavior
  };

  const handleAvatarDelete = async () => {
    const result = await deleteProfilePicture();
    if (result.success) {
      message.success('Avatar deleted successfully');
      window.location.reload();
    } else {
      message.error(result.error || 'Failed to delete avatar');
    }
  };

  return (
    <div>
      <h2>Your Profile</h2>
      
      {/* Avatar Section */}
      <div style={{ textAlign: 'center', marginBottom: 24 }}>
        <Avatar 
          size={120} 
          src={getAvatarUrl(user.avatar_url)} 
          icon={<UserOutlined />}
          style={{ marginBottom: 16 }}
        />
        <div>
          <Upload
            beforeUpload={handleAvatarUpload}
            showUploadList={false}
            accept="image/*"
          >
            <Button icon={<UploadOutlined />} loading={uploading}>
              Upload Avatar
            </Button>
          </Upload>
          {user.avatar_url && (
            <Button 
              danger 
              onClick={handleAvatarDelete} 
              style={{ marginLeft: 8 }}
            >
              Delete Avatar
            </Button>
          )}
        </div>
      </div>

      <Form
        form={form}
        layout="vertical"
        onFinish={handleFinish}
        style={{ maxWidth: 600, margin: '0 auto' }}
      >
        <Form.Item
          label="Username"
          name="username"
          rules={[{ required: true, message: 'Please enter your username!' }]}
        >
          <Input />
        </Form.Item>
        <Form.Item
          label="Email"
          name="email"
          rules={[
            { required: true, message: 'Please enter your email!' },
            { type: 'email', message: 'Please enter a valid email!' },
          ]}
        >
          <Input />
        </Form.Item>
        <Form.Item
          label="Role"
          name="role_name"
        >
          <Input disabled />

        </Form.Item>
        <Form.Item>
          <Button type="primary" htmlType="submit" loading={loading}>
            Save Changes
          </Button>
        </Form.Item>
      </Form>
    </div>
  );
}

export default Profile;
