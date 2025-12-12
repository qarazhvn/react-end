import React, { useEffect, useState, useCallback } from 'react';
import { categoriesAPI } from '../../services/apiService';
import { Table, Button, Modal, Form, Input, message, Popconfirm } from 'antd';

function CategoriesManagement() {
    const [categories, setCategories] = useState([]);
    const [isModalVisible, setIsModalVisible] = useState(false);
    const [loading, setLoading] = useState(true);

    const fetchCategories = useCallback(async () => {
        setLoading(true);
        try {
            const response = await categoriesAPI.getAll();
            setCategories(response.data);
        } catch (err) {
            console.error(err);
            message.error('Failed to load categories');
        } finally {
            setLoading(false);
        }
    }, []);

    useEffect(() => {
        fetchCategories();
    }, [fetchCategories]);

    const handleDelete = async (categoryId) => {
        try {
            await categoriesAPI.delete(categoryId);
            message.success('Category deleted successfully');
            fetchCategories();
        } catch (err) {
            console.error(err);
            message.error('Failed to delete category');
        }
    };

    const handleAddCategory = async (values) => {
        try {
            await categoriesAPI.create(values);
            message.success('Category added successfully');
            setIsModalVisible(false);
            fetchCategories();
        } catch (err) {
            console.error(err);
            message.error('Failed to add category');
        }
    };

    const columns = [
        { title: 'Category ID', dataIndex: 'category_id', key: 'category_id', sorter: (a, b) => a.category_id - b.category_id },
        { title: 'Name', dataIndex: 'name', key: 'name', sorter: (a, b) => a.name.localeCompare(b.name) },
        { title: 'Description', dataIndex: 'description', key: 'description', sorter: (a, b) => a.description?.localeCompare(b.description) },
        {
            title: 'Action',
            key: 'action',
            render: (_, record) => (
                <Button danger onClick={() => handleDelete(record.category_id)}>
                    Delete
                </Button>
            ),
        },
    ];

    return (
        <div>
            <h2>Manage Categories</h2>
            <Button type="primary" onClick={() => setIsModalVisible(true)} style={{ marginBottom: 16 }}>
                Add Category
            </Button>
            <Table
                dataSource={categories}
                columns={columns}
                rowKey="category_id"
                loading={loading}
                pagination={{ pageSize: 10 }}
            />

            {/* Модальное окно для добавления категории */}
            <Modal
                title="Add New Category"
                visible={isModalVisible}
                onCancel={() => setIsModalVisible(false)}
                footer={null}
            >
                <Form onFinish={handleAddCategory} layout="vertical">
                    <Form.Item
                        name="name"
                        label="Category Name"
                        rules={[{ required: true, message: 'Please input the category name!' }]}
                    >
                        <Input />
                    </Form.Item>
                    <Form.Item
                        name="description"
                        label="Description"
                    >
                        <Input.TextArea rows={4} />
                    </Form.Item>
                    <Form.Item>
                        <Button type="primary" htmlType="submit" block>
                            Add Category
                        </Button>
                    </Form.Item>
                </Form>
            </Modal>
        </div>
    );
}

export default CategoriesManagement;
