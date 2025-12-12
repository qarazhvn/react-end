// src/pages/CartPage.js
import React, { useEffect } from 'react';
import { Table, Button, message, Empty, Spin, Card } from 'antd';
import { useNavigate } from 'react-router-dom';
import useCart from '../hooks/useCart';
import useAuth from '../hooks/useAuth';

function CartPage() {
    const navigate = useNavigate();
    const { isAuthenticated } = useAuth();
    const { 
        cartItems, 
        loading, 
        loadCart, 
        removeFromCart, 
        updateQuantity,
        clearCart,
        getTotalPrice,
        checkout
    } = useCart();

    useEffect(() => {
        loadCart();
    }, [loadCart]);

    const handleRemove = async (itemId, productId) => {
        try {
            await removeFromCart(itemId, productId);
            message.success('Item removed from cart');
        } catch (err) {
            console.error(err);
            message.error('Failed to remove item');
        }
    };

    const handleDecreaseQuantity = async (itemId, productId, currentQuantity) => {
        if (currentQuantity <= 1) {
            message.warning('Minimum quantity is 1');
            return;
        }
        try {
            await updateQuantity(itemId, productId, currentQuantity - 1);
        } catch (err) {
            console.error(err);
            message.error('Failed to update quantity');
        }
    };

    const handleIncreaseQuantity = async (itemId, productId, currentQuantity) => {
        try {
            await updateQuantity(itemId, productId, currentQuantity + 1);
        } catch (err) {
            console.error(err);
            message.error('Failed to update quantity');
        }
    };

    const handleClearCart = async () => {
        try {
            await clearCart();
            message.success('Cart cleared');
        } catch (err) {
            console.error(err);
            message.error('Failed to clear cart');
        }
    };

    const handleCheckout = async () => {
        if (!isAuthenticated) {
            message.warning('Please login to checkout');
            navigate('/login');
            return;
        }

        try {
            await checkout();
            message.success('Order placed successfully!');
            navigate('/customer/dashboard/orders');
        } catch (err) {
            console.error(err);
            message.error('Failed to checkout');
        }
    };

    const columns = [
        {
            title: 'Product',
            dataIndex: 'product_name',
            key: 'product_name',
            render: (text, record) => (
                <div style={{ display: 'flex', alignItems: 'center' }}>
                    <img 
                        src={record.product_image_url || '/placeholder.jpg'} 
                        alt={text}
                        style={{ width: 50, height: 50, objectFit: 'cover', marginRight: 12, borderRadius: 4 }}
                    />
                    <span>{text}</span>
                </div>
            ),
        },
        {
            title: 'Price',
            dataIndex: 'product_price',
            key: 'product_price',
            render: (price) => `$${parseFloat(price).toFixed(2)}`,
        },
        {
            title: 'Quantity',
            dataIndex: 'quantity',
            key: 'quantity',
            render: (quantity, record) => (
                <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                    <Button 
                        size="small" 
                        onClick={() => handleDecreaseQuantity(record.item_id, record.product_id, quantity)}
                    >
                        -
                    </Button>
                    <span style={{ minWidth: 30, textAlign: 'center' }}>{quantity}</span>
                    <Button 
                        size="small" 
                        onClick={() => handleIncreaseQuantity(record.item_id, record.product_id, quantity)}
                    >
                        +
                    </Button>
                </div>
            ),
        },
        {
            title: 'Subtotal',
            key: 'subtotal',
            render: (_, record) => `$${(record.product_price * record.quantity).toFixed(2)}`,
        },
        {
            title: 'Action',
            key: 'action',
            render: (_, record) => (
                <Button 
                    danger 
                    onClick={() => handleRemove(record.item_id, record.product_id)}
                >
                    Remove
                </Button>
            ),
        },
    ];

    if (loading) {
        return (
            <div style={{ 
                display: 'flex', 
                justifyContent: 'center', 
                alignItems: 'center', 
                minHeight: 400 
            }}>
                <Spin size="large" />
            </div>
        );
    }

    if (!cartItems || cartItems.length === 0) {
        return (
            <div style={{ 
                maxWidth: 1200, 
                margin: '40px auto', 
                padding: '0 24px' 
            }}>
                <Card>
                    <Empty 
                        description="Your cart is empty" 
                        style={{ padding: '60px 0' }}
                    />
                    <div style={{ textAlign: 'center', marginTop: 20 }}>
                        <Button 
                            type="primary" 
                            onClick={() => navigate('/')}
                        >
                            Continue Shopping
                        </Button>
                    </div>
                </Card>
            </div>
        );
    }

    return (
        <div style={{ 
            maxWidth: 1200, 
            margin: '40px auto', 
            padding: '0 24px' 
        }}>
            <Card 
                title={<h2 style={{ margin: 0 }}>Shopping Cart</h2>}
                extra={
                    <Button danger onClick={handleClearCart}>
                        Clear Cart
                    </Button>
                }
            >
                <Table
                    dataSource={cartItems}
                    columns={columns}
                    rowKey={(record) => record.item_id || record.product_id}
                    pagination={false}
                    style={{ marginBottom: 24 }}
                />
                
                <div style={{ 
                    display: 'flex', 
                    justifyContent: 'space-between', 
                    alignItems: 'center',
                    marginTop: 24,
                    paddingTop: 24,
                    borderTop: '2px solid #f0f0f0'
                }}>
                    <div>
                        <Button onClick={() => navigate('/')}>
                            Continue Shopping
                        </Button>
                    </div>
                    <div style={{ textAlign: 'right' }}>
                        <div style={{ fontSize: 24, fontWeight: 'bold', marginBottom: 16 }}>
                            Total: ${getTotalPrice().toFixed(2)}
                        </div>
                        <Button 
                            type="primary" 
                            size="large"
                            onClick={handleCheckout}
                            disabled={cartItems.length === 0}
                        >
                            {isAuthenticated ? 'Proceed to Checkout' : 'Login to Checkout'}
                        </Button>
                    </div>
                </div>
            </Card>
        </div>
    );
}

export default CartPage;
