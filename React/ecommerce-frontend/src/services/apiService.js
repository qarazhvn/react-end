// src/services/apiService.js
import axios from 'axios';

// Base API configuration - nginx will proxy to backend
const API_BASE_URL = '/api';

// Create axios instance with default config
const apiClient = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Request interceptor to add auth token
apiClient.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
      console.log(`[API] Request to ${config.url} with token: ${token.substring(0, 20)}...`);
    } else {
      console.log(`[API] Request to ${config.url} without token`);
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Response interceptor for error handling
apiClient.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      // Token expired or invalid
      localStorage.removeItem('token');
      window.location.href = '/login';
    }
    return Promise.reject(error);
  }
);

// Products API
export const productsAPI = {
  getAll: (params = {}) => {
    return apiClient.get('/products', { params });
  },
  
  getById: (id) => {
    return apiClient.get(`/products/${id}`);
  },
  
  create: (productData) => {
    return apiClient.post('/products', productData);
  },
  
  update: (id, productData) => {
    return apiClient.put(`/products/${id}`, productData);
  },
  
  delete: (id) => {
    return apiClient.delete(`/products/${id}`);
  },
  
  getSellerProducts: () => {
    return apiClient.get('/seller/products');
  },
  
  // Reviews
  getReviews: (productId) => {
    return apiClient.get(`/products/${productId}/reviews`);
  },
  
  addReview: (productId, reviewData) => {
    return apiClient.post(`/products/${productId}/reviews`, reviewData);
  },
  
  // Product Images
  uploadImage: (productId, formData) => {
    return apiClient.post(`/products/${productId}/image`, formData, {
      headers: { 'Content-Type': 'multipart/form-data' }
    });
  },
  
  deleteImage: (productId) => {
    return apiClient.delete(`/products/${productId}/image`);
  },
  
  // Product Images (old API - можно удалить если не используется)
  getImages: (productId) => {
    return apiClient.get(`/products/${productId}/images`);
  },
  
  addImage: (productId, imageData) => {
    return apiClient.post(`/products/${productId}/images`, imageData);
  },
};

// Categories API
export const categoriesAPI = {
  getAll: () => {
    return apiClient.get('/categories');
  },
  
  getById: (id) => {
    return apiClient.get(`/categories/${id}`);
  },
  
  create: (categoryData) => {
    return apiClient.post('/categories', categoryData);
  },
  
  update: (id, categoryData) => {
    return apiClient.put(`/categories/${id}`, categoryData);
  },
  
  delete: (id) => {
    return apiClient.delete(`/categories/${id}`);
  },
};

// Orders API
export const ordersAPI = {
  getUserOrders: () => {
    return apiClient.get('/orders');
  },
  
  getById: (id) => {
    return apiClient.get(`/orders/${id}`);
  },
  
  checkout: (orderData) => {
    return apiClient.post('/orders/checkout', orderData);
  },
  
  updateStatus: (id, status) => {
    return apiClient.patch(`/orders/${id}/status`, { status });
  },
  
  getSellerOrders: () => {
    return apiClient.get('/seller/orders');
  },
  
  getOrderItems: (orderId) => {
    return apiClient.get(`/orders/${orderId}/items`);
  },
  
  addOrderItems: (orderId, items) => {
    return apiClient.post(`/orders/${orderId}/items`, items);
  },
};

// Admin API
export const adminAPI = {
  getAllUsers: () => {
    return apiClient.get('/admin/users');
  },
  
  deleteUser: (userId) => {
    return apiClient.delete(`/admin/users/${userId}`);
  },
  
  updateUserRole: (userId, roleData) => {
    return apiClient.put(`/admin/users/${userId}/role`, roleData);
  },
  
  getAllRoles: () => {
    return apiClient.get('/admin/roles');
  },
  
  createRole: (roleData) => {
    return apiClient.post('/admin/roles', roleData);
  },
  
  getAuditLogs: () => {
    return apiClient.get('/audit-logs');
  },
};

// Payments API
export const paymentsAPI = {
  getUserPayments: () => {
    return apiClient.get('/payments');
  },
  
  createPayment: (paymentData) => {
    return apiClient.post('/payments', paymentData);
  },
};

// User Addresses API
export const addressesAPI = {
  getUserAddresses: () => {
    return apiClient.get('/addresses');
  },
  
  addAddress: (addressData) => {
    return apiClient.post('/addresses', addressData);
  },
};

export default apiClient;
