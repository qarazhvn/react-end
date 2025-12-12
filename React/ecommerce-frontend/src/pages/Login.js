import React, { useState } from 'react';
import { useDispatch } from 'react-redux';
import { login } from '../store/actions/authActions';
import { Form, Input, Button, Alert } from 'antd';
import { useNavigate, Link } from 'react-router-dom';

function Login() {
    const dispatch = useDispatch();
    const [error, setError] = useState(null);
    const [loading, setLoading] = useState(false);
    const navigate = useNavigate();

    const onFinish = async (values) => {
        setLoading(true);
        setError(null);

        try {
            await dispatch(login(values));
            navigate('/');
        } catch (err) {
            setError(err?.message || 'Invalid credentials');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div style={{ maxWidth: 400, margin: '0 auto', padding: '50px 0' }}>
            <h2>Login</h2>
            {error && <Alert message={error} type="error" showIcon style={{ marginBottom: 16 }} />}
            
            <Form onFinish={onFinish} layout="vertical">
                <Form.Item
                    label="Username"
                    name="username"
                    rules={[
                        { required: true, message: 'Please input your username!' },
                        { min: 3, message: 'Username must be at least 3 characters' },
                    ]}
                >
                    <Input placeholder="Username" />
                </Form.Item>

                <Form.Item
                    label="Password"
                    name="password"
                    rules={[
                        { required: true, message: 'Please input your password!' },
                    ]}
                >
                    <Input.Password placeholder="Password" />
                </Form.Item>

                <Form.Item>
                    <Button type="primary" htmlType="submit" block loading={loading}>
                        Login
                    </Button>
                </Form.Item>

                <div style={{ textAlign: 'center' }}>
                    Don't have an account? <Link to="/register">Register now</Link>
                </div>
            </Form>
        </div>
    );
}

export default Login;
