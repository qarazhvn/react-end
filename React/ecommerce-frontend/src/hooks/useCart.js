// src/hooks/useCart.js
import { useState, useEffect, useCallback } from 'react';
import cartService from '../services/cartService';
import useAuth from './useAuth';

/**
 * Custom hook for managing cart (localStorage for guests, backend for logged-in users)
 * @returns {object} Cart state and functions
 */
function useCart() {
  const [cartItems, setCartItems] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const { isAuthenticated } = useAuth();

  // Load cart items
  const loadCart = useCallback(async () => {
    setLoading(true);
    setError(null);

    try {
      if (isAuthenticated) {
        // Load from backend for logged-in users
        const response = await cartService.getCartItems();
        setCartItems(response || []);
      } else {
        // Load from localStorage for guests
        const localCart = cartService.getLocalCart();
        setCartItems(localCart);
      }
    } catch (err) {
      console.error('Error loading cart:', err);
      setError(err.message || 'Failed to load cart');
      setCartItems([]);
    } finally {
      setLoading(false);
    }
  }, [isAuthenticated]);

  // Add item to cart
  const addToCart = useCallback(async (productId, quantity = 1) => {
    setLoading(true);
    setError(null);

    try {
      if (isAuthenticated) {
        await cartService.addCartItem(productId, quantity);
      } else {
        cartService.addToLocalCart(productId, quantity);
      }
      await loadCart();
      return { success: true };
    } catch (err) {
      console.error('Error adding to cart:', err);
      setError(err.message || 'Failed to add to cart');
      return { success: false, error: err.message };
    } finally {
      setLoading(false);
    }
  }, [isAuthenticated, loadCart]);

  // Remove item from cart
  const removeFromCart = useCallback(async (itemId, productId) => {
    setLoading(true);
    setError(null);

    try {
      if (isAuthenticated) {
        await cartService.deleteCartItem(itemId);
      } else {
        cartService.removeFromLocalCart(productId);
      }
      await loadCart();
      return { success: true };
    } catch (err) {
      console.error('Error removing from cart:', err);
      setError(err.message || 'Failed to remove from cart');
      return { success: false, error: err.message };
    } finally {
      setLoading(false);
    }
  }, [isAuthenticated, loadCart]);

  // Update item quantity
  const updateQuantity = useCallback(async (itemId, productId, quantity) => {
    setLoading(true);
    setError(null);

    try {
      if (isAuthenticated) {
        if (quantity > cartItems.find(item => item.item_id === itemId)?.quantity) {
          await cartService.increaseQuantity(itemId);
        } else {
          await cartService.decreaseQuantity(itemId);
        }
      } else {
        cartService.updateLocalCartQuantity(productId, quantity);
      }
      await loadCart();
      return { success: true };
    } catch (err) {
      console.error('Error updating quantity:', err);
      setError(err.message || 'Failed to update quantity');
      return { success: false, error: err.message };
    } finally {
      setLoading(false);
    }
  }, [isAuthenticated, cartItems, loadCart]);

  // Clear cart
  const clearCart = useCallback(() => {
    if (!isAuthenticated) {
      cartService.clearLocalCart();
      setCartItems([]);
    }
  }, [isAuthenticated]);

  // Checkout
  const checkout = useCallback(async () => {
    setLoading(true);
    setError(null);

    try {
      const result = await cartService.checkout();
      await loadCart(); // Reload cart after checkout
      return result;
    } catch (err) {
      console.error('Error during checkout:', err);
      setError(err.message || 'Failed to checkout');
      throw err;
    } finally {
      setLoading(false);
    }
  }, [loadCart]);

  // Calculate total items
  const getTotalItems = useCallback(() => {
    return cartItems.reduce((total, item) => total + (item.quantity || 0), 0);
  }, [cartItems]);

  // Calculate total price
  const getTotalPrice = useCallback(() => {
    return cartItems.reduce((total, item) => {
      return total + ((item.price || 0) * (item.quantity || 0));
    }, 0);
  }, [cartItems]);

  // Load cart on mount and when auth changes
  useEffect(() => {
    loadCart();
  }, [loadCart]);

  return {
    cartItems,
    loading,
    error,
    addToCart,
    removeFromCart,
    updateQuantity,
    clearCart,
    checkout,
    loadCart,
    getTotalItems,
    getTotalPrice,
    itemCount: getTotalItems(),
  };
}

export default useCart;
