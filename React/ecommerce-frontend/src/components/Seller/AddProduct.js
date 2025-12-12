import React, { useEffect, useState } from 'react';
import { productsAPI, categoriesAPI } from '../../services/apiService';
import { Form, Input, InputNumber, Button, Select, message, Upload } from 'antd';
import { UploadOutlined } from '@ant-design/icons';

const { Option } = Select;

function AddProduct() {
    const [form] = Form.useForm();
    const [categories, setCategories] = useState([]);
    const [loading, setLoading] = useState(false);
    const [imageFile, setImageFile] = useState(null);

    useEffect(() => {
        const fetchCategories = async () => {
            try {
                const response = await categoriesAPI.getAll();
                setCategories(response.data);
            } catch (err) {
                console.error('Error fetching categories:', err);
                message.error('Failed to load categories');
            }
        };
        fetchCategories();
    }, []);

    const handleImageChange = (info) => {
        if (info.fileList.length > 0) {
            setImageFile(info.fileList[0].originFileObj);
        } else {
            setImageFile(null);
        }
        return false; // Prevent auto upload
    };

    const onFinish = async (values) => {
        setLoading(true);
        try {
            // Create product first
            const response = await productsAPI.create(values);
            const productId = response.data.product_id;
            message.success(`Product added successfully with ID: ${productId}`);

            // Upload image if selected
            if (imageFile) {
                const formData = new FormData();
                formData.append('image', imageFile);
                
                try {
                    await productsAPI.uploadImage(productId, formData);
                    message.success('Image uploaded successfully');
                } catch (err) {
                    console.error('Error uploading image:', err);
                    message.warning('Product created but image upload failed');
                }
            }

            form.resetFields();
            setImageFile(null);
        } catch (err) {
            console.error('Error adding product:', err);
            message.error('Failed to add product');
        } finally {
            setLoading(false);
        }
    };

    return (
        <Form form={form} onFinish={onFinish} layout="vertical">
            <Form.Item
                name="name"
                label="Product Name"
                rules={[{ required: true, message: 'Please enter the product name' }]}
            >
                <Input />
            </Form.Item>
            <Form.Item
                name="description"
                label="Description"
            >
                <Input.TextArea />
            </Form.Item>
            <Form.Item
                name="price"
                label="Price"
                rules={[{ required: true, message: 'Please enter the price' }]}
            >
                <InputNumber min={0} step={0.01} style={{ width: '100%' }} />
            </Form.Item>
            <Form.Item
                name="stock"
                label="Stock"
                rules={[{ required: true, message: 'Please enter the stock quantity' }]}
            >
                <InputNumber min={0} style={{ width: '100%' }} />
            </Form.Item>
            <Form.Item
                name="category_id"
                label="Category"
                rules={[{ required: true, message: 'Please select a category' }]}
            >
                <Select placeholder="Select a category">
                    {categories.map(category => (
                        <Option key={category.category_id} value={category.category_id}>
                            {category.name}
                        </Option>
                    ))}
                </Select>
            </Form.Item>
            <Form.Item label="Product Image">
                <Upload
                    beforeUpload={() => false}
                    onChange={handleImageChange}
                    maxCount={1}
                    accept="image/*"
                    listType="picture"
                >
                    <Button icon={<UploadOutlined />}>Select Image</Button>
                </Upload>
            </Form.Item>
            <Form.Item>
                <Button type="primary" htmlType="submit" loading={loading}>Add Product</Button>
            </Form.Item>
        </Form>
    );
}

export default AddProduct;
