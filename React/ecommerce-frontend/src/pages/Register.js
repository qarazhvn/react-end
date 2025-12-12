import React, { useState } from 'react';
import { useDispatch } from 'react-redux';
import { register } from '../store/actions/authActions';
import { useNavigate } from 'react-router-dom';
import { Form, Input, Button, Select, Alert, Progress } from 'antd';
import { validateEmail, validatePassword, getPasswordStrength } from '../utils/validation';

const { Option } = Select;

function Register() {
    const dispatch = useDispatch();
    const [error, setError] = useState(null);
    const [loading, setLoading] = useState(false);
    const [passwordStrength, setPasswordStrength] = useState('weak');
    const navigate = useNavigate();
    const [form] = Form.useForm();

    // Password strength indicator colors
    const strengthColors = {
        weak: '#ff4d4f',
        medium: '#faad14',
        strong: '#52c41a',
    };

    const strengthPercent = {
        weak: 33,
        medium: 66,
        strong: 100,
    };

    const handlePasswordChange = (e) => {
        const password = e.target.value;
        const strength = getPasswordStrength(password);
        setPasswordStrength(strength);
    };

    const onFinish = async (values) => {
        setLoading(true);
        setError(null);

        try {
            await dispatch(register(values));
            navigate('/');
        } catch (err) {
            setError(err?.message || 'Registration failed');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div style={{ maxWidth: 400, margin: '0 auto', padding: '50px 0' }}>
            <h2>Register</h2>
            {error && <Alert message={error} type="error" showIcon style={{ marginBottom: 16 }} />}
            
            <Form form={form} onFinish={onFinish} layout="vertical">
                <Form.Item
                    label="Username"
                    name="username"
                    rules={[
                        { required: true, message: 'Please input your username!' },
                        { min: 3, message: 'Username must be at least 3 characters long' },
                        { max: 50, message: 'Username must not exceed 50 characters' },
                    ]}
                >
                    <Input placeholder="Username" />
                </Form.Item>

                <Form.Item
                    label="Email"
                    name="email"
                    rules={[
                        { required: true, message: 'Please input your email!' },
                        {
                            validator: (_, value) => {
                                if (!value || validateEmail(value)) {
                                    return Promise.resolve();
                                }
                                return Promise.reject(new Error('Please enter a valid email address'));
                            },
                        },
                    ]}
                >
                    <Input type="email" placeholder="Email" />
                </Form.Item>

                <Form.Item
                    label="Password"
                    name="password"
                    rules={[
                        { required: true, message: 'Please input your password!' },
                        {
                            validator: (_, value) => {
                                if (!value) return Promise.resolve();
                                
                                const validation = validatePassword(value);
                                if (validation.valid) {
                                    return Promise.resolve();
                                }
                                return Promise.reject(new Error(validation.errors.join('. ')));
                            },
                        },
                    ]}
                >
                    <Input.Password 
                        placeholder="Password" 
                        onChange={handlePasswordChange}
                    />
                </Form.Item>

                {form.getFieldValue('password') && (
                    <div style={{ marginBottom: 16 }}>
                        <div style={{ fontSize: 12, marginBottom: 4 }}>
                            Password strength: <strong style={{ color: strengthColors[passwordStrength] }}>
                                {passwordStrength.toUpperCase()}
                            </strong>
                        </div>
                        <Progress 
                            percent={strengthPercent[passwordStrength]} 
                            strokeColor={strengthColors[passwordStrength]}
                            showInfo={false}
                            size="small"
                        />
                        <div style={{ fontSize: 11, color: '#888', marginTop: 4 }}>
                            Password must: be 8+ characters, contain 1 number, contain 1 special character (!@#$%^&*)
                        </div>
                    </div>
                )}

                <Form.Item
                    label="Repeat Password"
                    name="repeatPassword"
                    dependencies={['password']}
                    rules={[
                        { required: true, message: 'Please confirm your password!' },
                        ({ getFieldValue }) => ({
                            validator(_, value) {
                                if (!value || getFieldValue('password') === value) {
                                    return Promise.resolve();
                                }
                                return Promise.reject(new Error('Passwords do not match!'));
                            },
                        }),
                    ]}
                >
                    <Input.Password placeholder="Repeat Password" />
                </Form.Item>

                <Form.Item
                    label="Role"
                    name="role_name"
                    rules={[{ required: true, message: 'Please select your role!' }]}
                >
                    <Select placeholder="Select a role">
                        <Option value="Customer">Customer</Option>
                        <Option value="Seller">Seller</Option>
                    </Select>
                </Form.Item>

                <Form.Item>
                    <Button type="primary" htmlType="submit" block loading={loading}>
                        Register
                    </Button>
                </Form.Item>
            </Form>
        </div>
    );
}

export default Register;
