import React, { useEffect, useState, useMemo, useCallback } from 'react';
import apiClient from '../services/apiService';
import { Row, Col, Card, Select, Button, message, Input, Pagination, Tag, Empty, Skeleton } from 'antd';
import { ShoppingCartOutlined, SearchOutlined } from '@ant-design/icons';
import { Link } from 'react-router-dom';
import { useSelector } from 'react-redux';
import useDebounce from '../hooks/useDebounce';
import usePagination from '../hooks/usePagination';
import useCart from '../hooks/useCart';

const { Option } = Select;
const { Search } = Input;

function HomePage() {
    const [products, setProducts] = useState([]);
    const [categories, setCategories] = useState([]);
    const [selectedCategory, setSelectedCategory] = useState('all');
    const [sortOrder, setSortOrder] = useState('default');
    const [searchTerm, setSearchTerm] = useState('');
    const [loading, setLoading] = useState(true);

    const debouncedSearchTerm = useDebounce(searchTerm, 500);

    const auth = useSelector((state) => state.auth);
    const { user } = auth;

    // Загрузка продуктов и категорий
    useEffect(() => {
        const fetchData = async () => {
            setLoading(true);
            try {
                const [productsRes, categoriesRes] = await Promise.all([
                    apiClient.get('/products'),
                    apiClient.get('/categories')
                ]);
                setProducts(productsRes.data);
                setCategories(categoriesRes.data);
            } catch (err) {
                console.error('Error loading data:', err);
                message.error('Failed to load products');
            } finally {
                setLoading(false);
            }
        };
        fetchData();
    }, []);

    // Фильтрация, поиск и сортировка с мемоизацией
    const filteredProducts = useMemo(() => {
        let result = [...products];

        // Поиск
        if (debouncedSearchTerm) {
            result = result.filter(product =>
                product.name.toLowerCase().includes(debouncedSearchTerm.toLowerCase()) ||
                product.description?.toLowerCase().includes(debouncedSearchTerm.toLowerCase())
            );
        }

        // Фильтр по категории
        if (selectedCategory !== 'all') {
            result = result.filter(product => product.category_name === selectedCategory);
        }

        // Сортировка
        if (sortOrder === 'asc') {
            result.sort((a, b) => a.price - b.price);
        } else if (sortOrder === 'desc') {
            result.sort((a, b) => b.price - a.price);
        }

        return result;
    }, [products, debouncedSearchTerm, selectedCategory, sortOrder]);

    const { currentPage, pageSize, goToPage, changePageSize } = usePagination(filteredProducts.length, 8);
    const { addToCart } = useCart();

    // Get correct image URL (handle both old http URLs and new /uploads paths)
    const getImageUrl = (imageUrl) => {
        if (!imageUrl) return undefined;
        if (imageUrl.startsWith('http')) return imageUrl; // Old URLs from database
        return imageUrl; // New local paths (nginx will proxy /uploads/)
    };

    // Пагинация
    const paginatedProducts = useMemo(() => {
        const startIndex = (currentPage - 1) * pageSize;
        const endIndex = startIndex + pageSize;
        return filteredProducts.slice(startIndex, endIndex);
    }, [filteredProducts, currentPage, pageSize]);

    const handleAddToCart = useCallback(async (productId) => {
        try {
            await addToCart(productId, 1);
            message.success('Product added to cart successfully');
        } catch (err) {
            console.error('Error adding product to cart:', err);
            message.error('Failed to add product to cart');
        }
    }, [addToCart]);

    return (
        <div style={{ background: '#fafafa', minHeight: '100vh' }}>
            {/* Hero Section */}
            <div style={{
                background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
                padding: '80px 24px',
                marginBottom: '60px',
                textAlign: 'center',
                color: 'white',
                position: 'relative',
                overflow: 'hidden'
            }}>
                <div style={{
                    position: 'absolute',
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    background: 'url("data:image/svg+xml,%3Csvg width=\'60\' height=\'60\' viewBox=\'0 0 60 60\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Cg fill=\'none\' fill-rule=\'evenodd\'%3E%3Cg fill=\'%23ffffff\' fill-opacity=\'0.05\'%3E%3Cpath d=\'M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z\'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E")',
                    opacity: 0.4
                }}></div>
                <div style={{ position: 'relative', zIndex: 1, maxWidth: 1200, margin: '0 auto' }}>
                    <h1 style={{
                        fontSize: '48px',
                        fontWeight: '700',
                        margin: '0 0 16px 0',
                        letterSpacing: '-1px',
                        color: 'white'
                    }}>
                        Discover Premium Products
                    </h1>
                    <p style={{
                        fontSize: '20px',
                        opacity: 0.95,
                        maxWidth: '600px',
                        margin: '0 auto 32px',
                        fontWeight: '300'
                    }}>
                        Experience quality and style with our curated collection
                    </p>
                    
                    {/* Search Bar in Hero */}
                    <div style={{ maxWidth: '600px', margin: '0 auto' }}>
                        <Search
                            placeholder="Search for products..."
                            value={searchTerm}
                            onChange={(e) => setSearchTerm(e.target.value)}
                            size="large"
                            allowClear
                            style={{ 
                                borderRadius: '50px',
                                overflow: 'hidden'
                            }}
                        />
                    </div>
                </div>
            </div>

            <div style={{ maxWidth: 1400, margin: '0 auto', padding: '0 24px' }}>
                {/* Filter Bar */}
                <div style={{ 
                    marginBottom: 40,
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'space-between',
                    flexWrap: 'wrap',
                    gap: '16px',
                    background: 'white',
                    padding: '20px 24px',
                    borderRadius: '12px',
                    boxShadow: '0 2px 8px rgba(0,0,0,0.04)'
                }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '12px', flexWrap: 'wrap' }}>
                        <span style={{ fontSize: '14px', color: '#8c8c8c', fontWeight: 500 }}>Filter:</span>
                        <Select
                            style={{ width: 200 }}
                            value={selectedCategory}
                            onChange={(value) => {
                                setSelectedCategory(value);
                                goToPage(1);
                            }}
                            bordered={false}
                        >
                            <Option value="all">All Categories</Option>
                            {categories.map(category => (
                                <Option key={category.category_id} value={category.name}>
                                    {category.name}
                                </Option>
                            ))}
                        </Select>
                    </div>

                    <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                        <span style={{ fontSize: '14px', color: '#8c8c8c', fontWeight: 500 }}>Sort by:</span>
                        <Select
                            style={{ width: 180 }}
                            value={sortOrder}
                            onChange={(value) => setSortOrder(value)}
                            bordered={false}
                        >
                            <Option value="default">Featured</Option>
                            <Option value="asc">Price: Low to High</Option>
                            <Option value="desc">Price: High to Low</Option>
                        </Select>
                    </div>

                    <div style={{ fontSize: '14px', color: '#595959', fontWeight: 500 }}>
                        {filteredProducts.length} {filteredProducts.length === 1 ? 'Product' : 'Products'}
                    </div>
                </div>

                {/* Loading State */}
                {loading ? (
                    <Row gutter={[24, 24]}>
                        {[1, 2, 3, 4, 5, 6, 7, 8].map((item) => (
                            <Col key={item} xs={24} sm={12} md={8} lg={6}>
                                <Card
                                    style={{
                                        borderRadius: '16px',
                                        border: 'none',
                                        overflow: 'hidden'
                                    }}
                                >
                                    <Skeleton.Image 
                                        active 
                                        style={{ width: '100%', height: '280px' }} 
                                    />
                                    <div style={{ padding: '20px' }}>
                                        <Skeleton active paragraph={{ rows: 3 }} />
                                    </div>
                                </Card>
                            </Col>
                        ))}
                    </Row>
                ) : filteredProducts.length === 0 ? (
                    /* Empty State */
                    <div style={{ 
                        background: 'white', 
                        borderRadius: '16px', 
                        padding: '80px 40px',
                        textAlign: 'center'
                    }}>
                        <Empty
                            image={Empty.PRESENTED_IMAGE_SIMPLE}
                            imageStyle={{ height: 120 }}
                            description={
                                <div>
                                    <h3 style={{ fontSize: '20px', fontWeight: 600, color: '#262626', marginBottom: '8px' }}>
                                        {searchTerm || selectedCategory !== 'all' 
                                            ? 'No products found' 
                                            : 'No products available'}
                                    </h3>
                                    <p style={{ fontSize: '14px', color: '#8c8c8c' }}>
                                        {searchTerm || selectedCategory !== 'all'
                                            ? 'Try adjusting your filters or search terms'
                                            : 'Check back later for new products'}
                                    </p>
                                </div>
                            }
                        >
                            {(searchTerm || selectedCategory !== 'all') && (
                                <Button 
                                    type="primary" 
                                    size="large"
                                    icon={<SearchOutlined />}
                                    onClick={() => {
                                        setSearchTerm('');
                                        setSelectedCategory('all');
                                    }}
                                    style={{
                                        marginTop: '16px',
                                        borderRadius: '12px',
                                        height: '48px',
                                        padding: '0 32px'
                                    }}
                                >
                                    Clear Filters
                                </Button>
                            )}
                        </Empty>
                    </div>
                ) : (
                    /* Products Grid */
            <Row gutter={[24, 24]}>
                {paginatedProducts.map(product => (
                    <Col key={product.product_id} xs={24} sm={12} md={8} lg={6}>
                        <Card
                            hoverable
                            style={{
                                borderRadius: '16px',
                                overflow: 'hidden',
                                border: 'none',
                                boxShadow: '0 4px 12px rgba(0,0,0,0.08)',
                                transition: 'all 0.4s cubic-bezier(0.4, 0, 0.2, 1)',
                                height: '100%',
                                display: 'flex',
                                flexDirection: 'column',
                                background: 'white'
                            }}
                            bodyStyle={{ 
                                padding: '20px',
                                flex: 1,
                                display: 'flex',
                                flexDirection: 'column'
                            }}
                            onMouseEnter={(e) => {
                                e.currentTarget.style.boxShadow = '0 12px 32px rgba(0,0,0,0.12)';
                                e.currentTarget.style.transform = 'translateY(-8px)';
                            }}
                            onMouseLeave={(e) => {
                                e.currentTarget.style.boxShadow = '0 4px 12px rgba(0,0,0,0.08)';
                                e.currentTarget.style.transform = 'translateY(0)';
                            }}
                            cover={
                                <div style={{ 
                                    position: 'relative', 
                                    overflow: 'hidden',
                                    backgroundColor: '#f5f5f5',
                                    height: '280px'
                                }}>
                                    <img 
                                        alt={product.name} 
                                        src={product.image_url ? getImageUrl(product.image_url) : '/placeholder.jpg'}
                                        style={{ 
                                            height: '100%', 
                                            width: '100%',
                                            objectFit: 'cover',
                                            transition: 'transform 0.6s cubic-bezier(0.4, 0, 0.2, 1)'
                                        }}
                                        onError={(e) => {
                                            e.target.src = '/placeholder.jpg';
                                        }}
                                        onMouseEnter={(e) => {
                                            e.target.style.transform = 'scale(1.1)';
                                        }}
                                        onMouseLeave={(e) => {
                                            e.target.style.transform = 'scale(1)';
                                        }}
                                    />
                                    {product.stock < 10 && product.stock > 0 && (
                                        <Tag 
                                            color="orange" 
                                            style={{ 
                                                position: 'absolute', 
                                                top: 16, 
                                                right: 16,
                                                fontWeight: '600',
                                                fontSize: '12px',
                                                padding: '4px 12px',
                                                borderRadius: '20px',
                                                border: 'none'
                                            }}
                                        >
                                            Only {product.stock} left
                                        </Tag>
                                    )}
                                    {product.stock === 0 && (
                                        <Tag 
                                            color="red" 
                                            style={{ 
                                                position: 'absolute', 
                                                top: 16, 
                                                right: 16,
                                                fontWeight: '600',
                                                fontSize: '12px',
                                                padding: '4px 12px',
                                                borderRadius: '20px',
                                                border: 'none'
                                            }}
                                        >
                                            Out of Stock
                                        </Tag>
                                    )}
                                </div>
                            }
                        >
                            <div style={{ flex: 1, display: 'flex', flexDirection: 'column' }}>
                                <div style={{ 
                                    fontSize: '11px', 
                                    color: '#bfbfbf',
                                    textTransform: 'uppercase',
                                    letterSpacing: '1px',
                                    fontWeight: '600',
                                    marginBottom: '8px'
                                }}>
                                    {product.category_name}
                                </div>
                                <Link 
                                    to={`/products/${product.product_id}`}
                                    style={{ 
                                        fontSize: '17px',
                                        fontWeight: '600',
                                        color: '#262626',
                                        marginBottom: '12px',
                                        display: 'block',
                                        lineHeight: '1.4',
                                        minHeight: '48px',
                                        transition: 'color 0.3s ease'
                                    }}
                                    onMouseEnter={(e) => e.currentTarget.style.color = '#667eea'}
                                    onMouseLeave={(e) => e.currentTarget.style.color = '#262626'}
                                >
                                    {product.name}
                                </Link>
                                <div style={{ 
                                    fontSize: '24px',
                                    fontWeight: '700',
                                    color: '#262626',
                                    marginBottom: '16px',
                                    letterSpacing: '-0.5px'
                                }}>
                                    ${parseFloat(product.price).toFixed(2)}
                                </div>
                                <Button
                                    type="primary"
                                    icon={<ShoppingCartOutlined />}
                                    onClick={() => handleAddToCart(product.product_id)}
                                    disabled={product.stock === 0}
                                    block
                                    size="large"
                                    style={{
                                        borderRadius: '12px',
                                        fontWeight: '600',
                                        height: '48px',
                                        marginTop: 'auto',
                                        background: product.stock === 0 ? '#d9d9d9' : 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
                                        border: 'none',
                                        boxShadow: product.stock === 0 ? 'none' : '0 4px 12px rgba(102, 126, 234, 0.3)',
                                        transition: 'all 0.3s ease'
                                    }}
                                    onMouseEnter={(e) => {
                                        if (product.stock > 0) {
                                            e.currentTarget.style.boxShadow = '0 6px 20px rgba(102, 126, 234, 0.4)';
                                            e.currentTarget.style.transform = 'translateY(-2px)';
                                        }
                                    }}
                                    onMouseLeave={(e) => {
                                        if (product.stock > 0) {
                                            e.currentTarget.style.boxShadow = '0 4px 12px rgba(102, 126, 234, 0.3)';
                                            e.currentTarget.style.transform = 'translateY(0)';
                                        }
                                    }}
                                >
                                    {product.stock === 0 ? 'Out of Stock' : 'Add to Cart'}
                                </Button>
                            </div>
                        </Card>
                    </Col>
                ))}
            </Row>
                )}

            {/* Пагинация */}
            {!loading && filteredProducts.length > 0 && (
            <div style={{ marginTop: 60, marginBottom: 60, textAlign: 'center' }}>
                <Pagination
                    current={currentPage}
                    pageSize={pageSize}
                    total={filteredProducts.length}
                    onChange={(page, size) => {
                        if (size !== pageSize) {
                            changePageSize(size);
                        } else {
                            goToPage(page);
                        }
                    }}
                    showSizeChanger
                    showTotal={(total) => `${total} ${total === 1 ? 'product' : 'products'} found`}
                    pageSizeOptions={['8', '12', '24', '48']}
                    style={{
                        background: 'white',
                        padding: '20px',
                        borderRadius: '12px',
                        display: 'inline-block',
                        boxShadow: '0 2px 8px rgba(0,0,0,0.04)'
                    }}
                />
            </div>
            )}
            </div>
        </div>
    );
}

export default HomePage;
