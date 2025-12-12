// src/services/cartService.js
import apiClient from './apiService';

const CART_STORAGE_KEY = 'guest_cart';

// Cart Service
const cartService = {
  // ==================== Backend API ====================
  
  // Get cart items from backend (for logged-in users)
  getCartItems: async () => {
    try {
      const response = await apiClient.get('/cart/items');
      return response.data;
    } catch (error) {
      throw error.response?.data || error.message;
    }
  },

  // Add item to cart (backend)
  addCartItem: async (productId, quantity = 1) => {
    try {
      const response = await apiClient.post('/cart/items', {
        product_id: productId,
        quantity: quantity,
      });
      return response.data;
    } catch (error) {
      throw error.response?.data || error.message;
    }
  },

  // Delete cart item (backend)
  deleteCartItem: async (itemId) => {
    try {
      const response = await apiClient.delete(`/cart/items/${itemId}`);
      return response.data;
    } catch (error) {
      throw error.response?.data || error.message;
    }
  },

  // Increase cart item quantity
  increaseQuantity: async (itemId) => {
    try {
      const response = await apiClient.patch(`/cart/items/${itemId}/increase`);
      return response.data;
    } catch (error) {
      throw error.response?.data || error.message;
    }
  },

  // Decrease cart item quantity
  decreaseQuantity: async (itemId) => {
    try {
      const response = await apiClient.patch(`/cart/items/${itemId}/decrease`);
      return response.data;
    } catch (error) {
      throw error.response?.data || error.message;
    }
  },

  // Get user cart
  getUserCart: async () => {
    try {
      const response = await apiClient.get('/cart');
      return response.data;
    } catch (error) {
      throw error.response?.data || error.message;
    }
  },

  // Checkout (create order from cart)
  checkout: async () => {
    try {
      const response = await apiClient.post('/orders/checkout');
      return response.data;
    } catch (error) {
      throw error.response?.data || error.message;
    }
  },

  // ==================== LocalStorage (for guests) ====================
  
  // Get cart from localStorage
  getLocalCart: () => {
    try {
      const cart = localStorage.getItem(CART_STORAGE_KEY);
      return cart ? JSON.parse(cart) : [];
    } catch (error) {
      console.error('Error reading local cart:', error);
      return [];
    }
  },

  // Save cart to localStorage
  saveLocalCart: (cartItems) => {
    try {
      localStorage.setItem(CART_STORAGE_KEY, JSON.stringify(cartItems));
    } catch (error) {
      console.error('Error saving local cart:', error);
    }
  },

  // Add item to local cart
  addToLocalCart: (productId, quantity = 1) => {
    const cart = cartService.getLocalCart();
    const existingItem = cart.find(item => item.product_id === productId);

    if (existingItem) {
      existingItem.quantity += quantity;
    } else {
      cart.push({ product_id: productId, quantity });
    }

    cartService.saveLocalCart(cart);
    return cart;
  },

  // Remove item from local cart
  removeFromLocalCart: (productId) => {
    const cart = cartService.getLocalCart();
    const updatedCart = cart.filter(item => item.product_id !== productId);
    cartService.saveLocalCart(updatedCart);
    return updatedCart;
  },

  // Update quantity in local cart
  updateLocalCartQuantity: (productId, quantity) => {
    const cart = cartService.getLocalCart();
    const item = cart.find(item => item.product_id === productId);

    if (item) {
      if (quantity <= 0) {
        return cartService.removeFromLocalCart(productId);
      }
      item.quantity = quantity;
      cartService.saveLocalCart(cart);
    }

    return cart;
  },

  // Clear local cart
  clearLocalCart: () => {
    localStorage.removeItem(CART_STORAGE_KEY);
  },

  // ==================== Merge Logic ====================
  
  // Merge local cart with backend cart after login
  mergeLocalCartWithBackend: async () => {
    try {
      const localCart = cartService.getLocalCart();
      
      if (localCart.length === 0) {
        return { merged: false, message: 'No local cart to merge' };
      }

      // Add each local cart item to backend
      const mergePromises = localCart.map(item =>
        cartService.addCartItem(item.product_id, item.quantity)
      );

      await Promise.all(mergePromises);

      // Clear local cart after successful merge
      cartService.clearLocalCart();

      return {
        merged: true,
        message: 'Your local cart was merged with your account.',
        itemsCount: localCart.length,
      };
    } catch (error) {
      console.error('Error merging cart:', error);
      throw error;
    }
  },
};

export default cartService;
