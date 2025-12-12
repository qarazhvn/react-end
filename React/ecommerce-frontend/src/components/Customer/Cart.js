import React, { useEffect } from 'react';
import { Table, Button, message, Empty, Spin } from 'antd';
import useCart from '../../hooks/useCart';

function Cart() {
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

    const handleRemove = async (itemId) => {
        try {
            await removeFromCart(itemId);
            message.success('Item removed from cart');
        } catch (err) {
            console.error(err);
            message.error('Failed to remove item');
        }
    };

    const handleDecreaseQuantity = async (itemId, currentQuantity) => {
        if (currentQuantity <= 1) {
            message.warning('Minimum quantity is 1');
            return;
        }
        try {
            await updateQuantity(itemId, currentQuantity - 1);
            message.success('Item quantity decreased');
        } catch (err) {
            console.error(err);
            message.error('Failed to decrease item quantity');
        }
    };

    const handleIncreaseQuantity = async (itemId, currentQuantity, stock) => {
        if (currentQuantity >= stock) {
            message.error('Cannot add more items than available in stock');
            return;
        }
        try {
            await updateQuantity(itemId, currentQuantity + 1);
            message.success('Item quantity increased');
        } catch (err) {
            console.error(err);
            message.error('Failed to increase item quantity');
        }
    };

    const handleCheckout = async () => {
        try {
            const result = await checkout();
            message.success(`Order created successfully. Order ID: ${result.order_id}`);
        } catch (err) {
            console.error('Error during checkout:', err);
            message.error('Failed to complete checkout');
        }
    };

    const columns = [
        { title: 'Product', dataIndex: 'product_name', key: 'product_name' },
        { title: 'Quantity', dataIndex: 'quantity', key: 'quantity' },
        { title: 'Price', dataIndex: 'price', key: 'price' },
        {
            title: 'Action',
            key: 'action',
            render: (_, record) => (
                <>
                    <Button 
                        onClick={() => handleDecreaseQuantity(record.cart_item_id, record.quantity)} 
                        disabled={record.quantity <= 1}
                    >
                        -
                    </Button>
                    <Button 
                        onClick={() => handleIncreaseQuantity(record.cart_item_id, record.quantity, record.stock)} 
                        style={{ marginLeft: 8 }} 
                        disabled={record.quantity >= record.stock}
                    >
                        +
                    </Button>
                    <Button 
                        onClick={() => handleRemove(record.cart_item_id)} 
                        style={{ marginLeft: 8 }}
                        danger
                    >
                        Remove
                    </Button>
                </>
            ),
        },
    ];

    return (
        <div>
            <h2>Your Cart</h2>
            {cartItems.length === 0 && !loading ? ( // Если корзина пуста и данные загружены
                <Empty description="Your cart is empty" />
            ) : (
                <Table
                    dataSource={cartItems}
                    columns={columns}
                    rowKey="cart_item_id"
                    loading={loading} // Показать индикатор загрузки
                />
            )}
            <Button
                type="primary"
                onClick={handleCheckout}
                disabled={cartItems.length === 0} // Блокируем кнопку, если корзина пуста
                style={{ marginTop: 16 }}
            >
                Proceed to Checkout
            </Button>
        </div>
    );
}

export default Cart;
