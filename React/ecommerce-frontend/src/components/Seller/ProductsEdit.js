import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { productsAPI, categoriesAPI } from '../../services/apiService';
import { Form, Input, InputNumber, Button, message, Typography, Select, Spin, Upload, Image } from 'antd';
import { UploadOutlined, DeleteOutlined } from '@ant-design/icons';

const { Title } = Typography;
const { Option } = Select;

function ProductsEdit() {
    const { id } = useParams();
    const [product, setProduct] = useState(null);
    const [categories, setCategories] = useState([]);
    const [loading, setLoading] = useState(true);
    const [saving, setSaving] = useState(false);
    const [uploading, setUploading] = useState(false);
    const [imageFile, setImageFile] = useState(null);
    const [form] = Form.useForm();

    const getImageUrl = (imageUrl) => {
        if (!imageUrl) return undefined;
        if (imageUrl.startsWith('http')) return imageUrl;
        return imageUrl;
    };

    useEffect(() => {
        const fetchData = async () => {
            try {
                const [productRes, categoriesRes] = await Promise.all([
                    productsAPI.getById(id),
                    categoriesAPI.getAll()
                ]);
                setProduct(productRes.data.product);
                setCategories(categoriesRes.data);
                form.setFieldsValue({
                    ...productRes.data.product,
                    category_name: productRes.data.product.category_name,
                });
            } catch (err) {
                console.error('Error fetching data:', err);
                message.error('Failed to load product data');
            } finally {
                setLoading(false);
            }
        };
        fetchData();
    }, [id, form]);

    const handleImageChange = (info) => {
        if (info.fileList.length > 0) {
            setImageFile(info.fileList[0].originFileObj);
        } else {
            setImageFile(null);
        }
        return false;
    };

    const handleImageUpload = async () => {
        if (!imageFile) {
            message.warning('Please select an image first');
            return;
        }

        setUploading(true);
        try {
            const formData = new FormData();
            formData.append('image', imageFile);
            const response = await productsAPI.uploadImage(id, formData);
            message.success('Image uploaded successfully');
            setProduct({ ...product, image_url: response.data.image_url });
            setImageFile(null);
        } catch (err) {
            console.error('Error uploading image:', err);
            message.error('Failed to upload image');
        } finally {
            setUploading(false);
        }
    };

    const handleImageDelete = async () => {
        setUploading(true);
        try {
            await productsAPI.deleteImage(id);
            message.success('Image deleted successfully');
            setProduct({ ...product, image_url: null });
        } catch (err) {
            console.error('Error deleting image:', err);
            message.error('Failed to delete image');
        } finally {
            setUploading(false);
        }
    };

    const handleUpdate = async (values) => {
        setSaving(true);
        try {
            await productsAPI.update(id, values);
            message.success('Product updated successfully');
        } catch (err) {
            console.error('Error updating product:', err);
            message.error('Failed to update product');
        } finally {
            setSaving(false);
        }
    };

    return (
        <div style={{ padding: '20px' }}>
            <Spin spinning={loading} tip="Loading..." size="large">
                {!loading && (
                    <div>
                        <Title level={2}>Edit Product</Title>
                        <Form
                            form={form}
                            onFinish={handleUpdate}
                            layout="vertical"
                        >
                            <Form.Item name="name" label="Product Name" rules={[{ required: true }]}>
                                <Input />
                            </Form.Item>
                            <Form.Item name="description" label="Description">
                                <Input.TextArea rows={4} />
                            </Form.Item>
                            <Form.Item name="price" label="Price" rules={[{ required: true }]}>
                                <InputNumber min={0} step={0.01} style={{ width: '100%' }} />
                            </Form.Item>
                            <Form.Item name="stock" label="Stock" rules={[{ required: true }]}>
                                <InputNumber min={0} style={{ width: '100%' }} />
                            </Form.Item>
                            <Form.Item name="category_name" label="Category" rules={[{ required: true }]}>
                                <Select placeholder="Select a category">
                                    {categories.map((category) => (
                                        <Option key={category.category_id} value={category.name}>
                                            {category.name}
                                        </Option>
                                    ))}
                                </Select>
                            </Form.Item>

                            {/* Product Image Section */}
                            <Form.Item label="Product Image">
                                {product?.image_url && (
                                    <div style={{ marginBottom: 16 }}>
                                        <Image
                                            width={200}
                                            src={getImageUrl(product.image_url)}
                                            alt="Product"
                                        />
                                        <div style={{ marginTop: 8 }}>
                                            <Button 
                                                danger 
                                                icon={<DeleteOutlined />}
                                                onClick={handleImageDelete}
                                                loading={uploading}
                                            >
                                                Delete Image
                                            </Button>
                                        </div>
                                    </div>
                                )}
                                <Upload
                                    beforeUpload={() => false}
                                    onChange={handleImageChange}
                                    maxCount={1}
                                    accept="image/*"
                                    listType="picture"
                                >
                                    <Button icon={<UploadOutlined />}>Select New Image</Button>
                                </Upload>
                                {imageFile && (
                                    <Button 
                                        type="primary" 
                                        onClick={handleImageUpload}
                                        loading={uploading}
                                        style={{ marginTop: 8 }}
                                    >
                                        Upload Selected Image
                                    </Button>
                                )}
                            </Form.Item>

                            <Form.Item>
                                <Button type="primary" htmlType="submit" loading={saving}>
                                    Save Changes
                                </Button>
                            </Form.Item>
                        </Form>
                    </div>
                )}
            </Spin>
        </div>
    );
}

export default ProductsEdit;
