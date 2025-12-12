import React, { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { ordersAPI, paymentsAPI } from '../../services/apiService';
import { Table, Button, message, Modal, Select } from 'antd';

const { Option } = Select;

function OrderDetails() {
    const { id } = useParams();
    const navigate = useNavigate();
    const [orderItems, setOrderItems] = useState([]);
    const [loading, setLoading] = useState(true);
    const [isPaid, setIsPaid] = useState(false);
    const [paymentModalVisible, setPaymentModalVisible] = useState(false);
    const [selectedPaymentMethod, setSelectedPaymentMethod] = useState('');

    useEffect(() => {
        const fetchOrderDetails = async () => {
            setLoading(true);
            try {
                const res = await ordersAPI.getOrderItems(id);
                setOrderItems(res.data.items || []);
                setIsPaid(res.data.status === 'Paid');
            } catch (err) {
                console.error(err);
                message.error('Failed to load order details');
                setOrderItems([]);
            } finally {
                setLoading(false);
            }
        };
        fetchOrderDetails();
    }, [id]);

    const openPaymentModal = () => setPaymentModalVisible(true);
    const closePaymentModal = () => setPaymentModalVisible(false);

    const handlePayment = async () => {
        if (!selectedPaymentMethod) {
            message.error('Please select a payment method');
            return;
        }

        const totalAmount = orderItems.reduce(
            (sum, item) => sum + item.price * item.quantity,
            0
        );
        
        const order_id = parseInt(id, 10);
        try {
            await paymentsAPI.createPayment({
                order_id: order_id,
                amount: totalAmount,
                payment_method: selectedPaymentMethod,
            });
            message.success('Payment recorded successfully');
            setIsPaid(true);
            closePaymentModal();
        } catch (err) {
            console.error('Error recording payment:', err);
            message.error('Failed to record payment');
        }
    };

    const columns = [
        { title: 'Product Name', dataIndex: 'product_name', key: 'product_name' },
        { title: 'Product ID', dataIndex: 'product_id', key: 'product_id' },
        { title: 'Quantity', dataIndex: 'quantity', key: 'quantity' },
        { title: 'Price', dataIndex: 'price', key: 'price' },
        { title: 'Total', key: 'total', render: (_, record) => record.quantity * record.price },
    ];

    return (
        <div>
            <h2>Order Details for Order ID: {id}</h2>
            <Table
                dataSource={orderItems}
                columns={columns}
                rowKey="order_item_id"
                loading={loading}
            />
            <div style={{ marginTop: 16 }}>
                <Button
                    type="primary"
                    onClick={openPaymentModal}
                    disabled={isPaid}
                >
                    {isPaid ? 'Order Paid' : 'Pay for Order'}
                </Button>
                <Button
                    type="default"
                    onClick={() => navigate('/customer/dashboard/orders')}
                    style={{ marginLeft: 8 }}
                >
                    Back to Orders
                </Button>
            </div>

            <Modal
                title="Select Payment Method"
                open={paymentModalVisible}
                onCancel={closePaymentModal}
                onOk={handlePayment}
                okText="Pay"
                cancelText="Cancel"
            >
                <Select
                    style={{ width: '100%' }}
                    placeholder="Choose a payment method"
                    onChange={(value) => setSelectedPaymentMethod(value)}
                >
                    <Option value="Credit Card">Credit Card</Option>
                    <Option value="PayPal">PayPal</Option>
                    <Option value="Bank Transfer">Bank Transfer</Option>
                </Select>
            </Modal>
        </div>
    );
}

export default OrderDetails;
