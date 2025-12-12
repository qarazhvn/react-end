import React, { useEffect, useState, useCallback } from 'react';
import { ordersAPI } from '../../services/apiService';
import { Table, Tag, Typography, message } from 'antd';

const { Title } = Typography;

function MyOrders() {
    const [orders, setOrders] = useState([]);
    const [loading, setLoading] = useState(true);

    const fetchOrders = useCallback(async () => {
        setLoading(true);
        try {
            const res = await ordersAPI.getSellerOrders();
            setOrders(res.data);
        } catch (err) {
            console.error('Error fetching orders:', err);
            message.error('Failed to load orders');
        } finally {
            setLoading(false);
        }
    }, []);

    useEffect(() => {
        fetchOrders();
    }, [fetchOrders]);

    const columns = [
        {
            title: 'Order ID',
            dataIndex: 'order_id',
            key: 'order_id',
        },
        {
            title: 'Product Name',
            dataIndex: 'product_name',
            key: 'product_name',
        },
        {
            title: 'Quantity',
            dataIndex: 'quantity',
            key: 'quantity',
        },
        {
            title: 'Price',
            dataIndex: 'price',
            key: 'price',
            render: (price) => `$${price.toFixed(2)}`,
        },
        {
            title: 'Total Amount',
            dataIndex: 'total_amount',
            key: 'total_amount',
            render: (totalAmount) => `$${totalAmount.toFixed(2)}`,
        },
        {
            title: 'Order Date',
            dataIndex: 'order_date',
            key: 'order_date',
            render: (date) => new Date(date).toLocaleDateString(),
        },
        {
            title: 'Status',
            dataIndex: 'status',
            key: 'status',
            render: (status) => (
                <Tag color={status === 'Paid' ? 'green' : 'red'}>
                    {status.toUpperCase()}
                </Tag>
            ),
        },
    ];

    return (
        <div>
            <Title level={2}>My Orders</Title>
            <Table
                dataSource={orders}
                columns={columns}
                rowKey="order_item_id"
                loading={loading}
                pagination={{ pageSize: 10 }}
            />
        </div>
    );
}

export default MyOrders;
