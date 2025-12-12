import React, { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { categoriesAPI } from '../../services/apiService';
import { Form, Input, Button, message, Spin } from 'antd';

function EditCategory() {
    const { id } = useParams();
    const navigate = useNavigate();
    const [loading, setLoading] = useState(true);
    const [saving, setSaving] = useState(false);
    const [form] = Form.useForm();

    useEffect(() => {
        const fetchCategory = async () => {
            try {
                const res = await categoriesAPI.getById(id);
                form.setFieldsValue(res.data);
            } catch (err) {
                console.error('Error fetching category:', err);
                message.error('Failed to load category');
            } finally {
                setLoading(false);
            }
        };
        fetchCategory();
    }, [id, form]);

    const handleUpdate = async (values) => {
        setSaving(true);
        try {
            await categoriesAPI.update(id, values);
            message.success('Category updated successfully');
            navigate('/moderator/dashboard/categories');
        } catch (err) {
            console.error('Error updating category:', err);
            message.error('Failed to update category');
        } finally {
            setSaving(false);
        }
    };

    return (
        <div style={{ padding: '20px' }}>
            <h2>Edit Category</h2>
            <Spin spinning={loading}>
                <Form
                    form={form}
                    onFinish={handleUpdate}
                    layout="vertical"
                >
                    <Form.Item name="name" label="Category Name" rules={[{ required: true }]}>
                        <Input />
                    </Form.Item>
                    <Form.Item name="description" label="Description">
                        <Input.TextArea rows={4} />
                    </Form.Item>
                    <Form.Item>
                        <Button type="primary" htmlType="submit" loading={saving}>
                            Save Changes
                        </Button>
                    </Form.Item>
                </Form>
            </Spin>
        </div>
    );
}

export default EditCategory;
