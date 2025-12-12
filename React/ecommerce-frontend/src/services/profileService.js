// src/services/profileService.js
import apiClient from './apiService';

const profileService = {
  // Get current user profile
  getProfile: async () => {
    try {
      const response = await apiClient.get('/users/me');
      return response.data;
    } catch (error) {
      throw error.response?.data || error.message;
    }
  },

  // Update user profile
  updateProfile: async (profileData) => {
    try {
      const response = await apiClient.put('/users/me', profileData);
      return response.data;
    } catch (error) {
      throw error.response?.data || error.message;
    }
  },

  // Upload profile picture (avatar)
  uploadAvatar: async (file) => {
    try {
      const formData = new FormData();
      formData.append('avatar', file);

      const response = await apiClient.post('/users/me/avatar', formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      });

      return response.data;
    } catch (error) {
      throw error.response?.data || error.message;
    }
  },

  // Delete profile picture
  deleteAvatar: async () => {
    try {
      const response = await apiClient.delete('/users/me/avatar');
      return response.data;
    } catch (error) {
      throw error.response?.data || error.message;
    }
  },

  // Get user addresses
  getAddresses: async () => {
    try {
      const response = await apiClient.get('/addresses');
      return response.data;
    } catch (error) {
      throw error.response?.data || error.message;
    }
  },

  // Add new address
  addAddress: async (addressData) => {
    try {
      const response = await apiClient.post('/addresses', addressData);
      return response.data;
    } catch (error) {
      throw error.response?.data || error.message;
    }
  },
};

export default profileService;
