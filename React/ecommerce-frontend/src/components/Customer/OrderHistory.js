import React, { useEffect, useState } from 'react';
import { ordersAPI } from '../../services/apiService';
import { Table, Tag, message } from 'antd';
import { Link } from 'react-router-dom';

function OrdersList() {
    const [orders, setOrders] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchOrders = async () => {
            try {
                const response = await ordersAPI.getUserOrders();
                setOrders(response.data);
            } catch (err) {
                console.error(err);
                message.error('Failed to load orders');
            } finally {
                setLoading(false);
            }
        };
        fetchOrders();
    }, []);

    const columns = [
        {
            title: 'Order ID',
            dataIndex: 'order_id',
            key: 'order_id',
            sorter: (a, b) => a.order_id - b.order_id,
            render: (text, record) => (
                <Link to={`http://localhost:3000/customer/dashboard/orders/${record.order_id}`}>
                    {text}
                </Link>
            ),
        },
        {
            title: 'Date',
            dataIndex: 'order_date',
            key: 'order_date',
            sorter: (a, b) => new Date(a.order_date) - new Date(b.order_date),
        },
        {
            title: 'Status',
            dataIndex: 'status',
            key: 'status',
            filters: [
                { text: 'Paid', value: 'Paid' },
                { text: 'In Progress', value: 'In Progress' },
            ],
            onFilter: (value, record) => record.status === value,
            render: (status) => (
                <Tag color={status === 'Paid' ? 'green' : 'red'}>
                    {status.toUpperCase()}
                </Tag>
            ),
        },
        {
            title: 'Total Amount',
            dataIndex: 'total_amount',
            key: 'total_amount',
            sorter: (a, b) => a.total_amount - b.total_amount,
        },
        {
            title: 'Payment Method',
            dataIndex: 'payment_method',
            key: 'payment_method',
            filters: [
                { text: 'Credit Card', value: 'Credit Card' },
                { text: 'PayPal', value: 'PayPal' },
                { text: 'Bank Transfer', value: 'Bank Transfer' },
            ],
            onFilter: (value, record) => record.payment_method === value,
        },
    ];

    return (
        <div>
            <h2>Your Orders</h2>
            <Table
                dataSource={orders}
                columns={columns}
                rowKey="order_id"
                loading={loading}
            />
        </div>
    );
}

export default OrdersList;
