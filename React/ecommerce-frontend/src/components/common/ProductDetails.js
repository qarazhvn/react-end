import React, { useEffect, useState, useCallback } from 'react';
import { useParams } from 'react-router-dom';
import apiClient from '../../services/apiService';
import { Card, Row, Col, Typography, Skeleton, Button, message, List, Rate, Form, Input, Avatar } from 'antd';
import { UserOutlined } from '@ant-design/icons';
import { useSelector } from 'react-redux';
import useCart from '../../hooks/useCart';

const { Title, Text, Paragraph } = Typography;

function ProductDetails() {
    const { id } = useParams();
    const [product, setProduct] = useState(null);
    const [reviews, setReviews] = useState([]);
    const [loading, setLoading] = useState(true);
    const [submittingReview, setSubmittingReview] = useState(false);
    const { addToCart } = useCart();

    const getAvatarUrl = (avatarUrl) => {
        if (!avatarUrl) return undefined;
        // Always return relative path - nginx will proxy to backend
        return avatarUrl;
    };

    const auth = useSelector((state) => state.auth);
    const { user } = auth;

    const loadProductDetails = useCallback(async () => {
        try {
            const response = await apiClient.get(`/products/${id}`);
            setProduct(response.data.product);
            setReviews(response.data.reviews || []);
            console.log('Reviews loaded:', response.data.reviews); // Debug
        } catch (err) {
            console.error('Error loading product details:', err);
            message.error('Failed to load product details');
        } finally {
            setLoading(false);
        }
    }, [id]);

    useEffect(() => {
        loadProductDetails();
    }, [loadProductDetails]);

    const handleAddToCart = async (productId) => {
        try {
            await addToCart(productId, 1);
            message.success('Product added to cart successfully');
        } catch (err) {
            console.error('Error adding product to cart:', err);
            message.error('Failed to add product to cart');
        }
    };

    const handleSubmitReview = async (values) => {
        setSubmittingReview(true);
        try {
            await apiClient.post(`/products/${id}/reviews`, values);
            message.success('Review submitted successfully');
            await loadProductDetails();
        } catch (err) {
            console.error('Error submitting review:', err);
            message.error(err.response?.data || 'Failed to submit review');
        } finally {
            setSubmittingReview(false);
        }
    };

    if (loading) {
        return <Skeleton active />;
    }

    if (!product) {
        return <p>Product not found</p>;
    }

    return (
        <Row justify="center" style={{ padding: '50px 0' }}>
            <Col xs={24} sm={16} md={12} lg={10}>
                <Card
                    hoverable
                    cover={
                        <div
                            style={{
                                height: '300px',
                                display: 'flex',
                                alignItems: 'center',
                                justifyContent: 'center',
                                backgroundColor: '#f5f5f5',
                            }}
                        >
                            <img
                                alt={product.name}
                                src={product.image_url || '/placeholder.jpg'}
                                style={{ maxHeight: '100%', maxWidth: '100%' }}
                            />
                        </div>
                    }
                    actions={[
                        <Button
                            type="primary"
                            onClick={() => handleAddToCart(product.product_id)}
                            disabled={product.stock === 0}
                        >
                            Add to Cart
                        </Button>,
                    ].filter(Boolean)}
                >
                    <Title level={3}>{product.name}</Title>
                    <Text type="secondary" style={{ display: 'block', marginBottom: '10px' }}>
                        Category: {product.category_name}
                    </Text>
                    <Paragraph style={{ marginTop: '10px' }}>
                        <Text strong>Description:</Text>
                        <br />
                        {product.description || 'No description available.'}
                    </Paragraph>
                    <div style={{ marginTop: '20px' }}>
                        <Text strong style={{ fontSize: '18px' }}>
                            Price: ${product.price}
                        </Text>
                    </div>
                    <div style={{ marginTop: '10px' }}>
                        <Text>Stock: {product.stock}</Text>
                    </div>
                </Card>
            </Col>
            <Col xs={24} sm={16} md={12} lg={10} style={{ marginTop: '20px' }}>
                <Card title="Customer Reviews">
                    {reviews.length > 0 ? (
                        <List
                            dataSource={reviews}
                            renderItem={(review) => (
                                <List.Item>
                                    <List.Item.Meta
                                        avatar={
                                            <Avatar 
                                                src={getAvatarUrl(review.avatar_url)} 
                                                icon={<UserOutlined />}
                                            />
                                        }
                                        title={
                                            <div>
                                                <Text style={{ fontWeight: 'bold', marginRight: 8 }}>
                                                    {review.author_name}
                                                </Text>
                                                <Rate disabled value={review.rating} />
                                                <Text style={{ marginLeft: '10px', color: '#999' }}>
                                                    {new Date(review.created_at).toLocaleDateString()}
                                                </Text>
                                            </div>
                                        }
                                        description={review.comment}
                                    />
                                </List.Item>
                            )}
                        />
                    ) : (
                        <Text>No reviews yet.</Text>
                    )}
                </Card>
                {user?.role_name === 'Customer' && (
                    <Card title="Write a Review" style={{ marginTop: '20px' }}>
                        <Form onFinish={handleSubmitReview}>
                            <Form.Item
                                name="rating"
                                rules={[
                                    { required: true, message: 'Please provide a rating' },
                                ]}
                            >
                                <Rate />
                            </Form.Item>
                            <Form.Item
                                name="comment"
                                rules={[
                                    { required: true, message: 'Please write a comment' },
                                    { max: 500, message: 'Comment cannot exceed 500 characters' },
                                ]}
                            >
                                <Input.TextArea rows={4} placeholder="Your review" maxLength={500} />
                            </Form.Item>
                            <Form.Item>
                                <Button type="primary" htmlType="submit" loading={submittingReview}>
                                    Submit Review
                                </Button>
                            </Form.Item>
                        </Form>
                    </Card>
                )}
            </Col>
        </Row>
    );
}

export default ProductDetails;
