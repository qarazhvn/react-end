// src/hooks/useProfilePicture.js
import { useState, useCallback, useRef, useEffect } from 'react';
import profileService from '../services/profileService';

/**
 * Custom hook for profile picture upload with compression via Web Worker
 * @returns {object} Upload state and functions
 */
function useProfilePicture() {
  const [uploading, setUploading] = useState(false);
  const [error, setError] = useState(null);
  const [progress, setProgress] = useState(0);
  const workerRef = useRef(null);

  // Initialize Web Worker
  useEffect(() => {
    workerRef.current = new Worker('/imageCompressionWorker.js');
    
    return () => {
      if (workerRef.current) {
        workerRef.current.terminate();
      }
    };
  }, []);

  /**
   * Compress image file using Web Worker
   * @param {File} file - Image file
   * @param {number} maxWidth - Max width in pixels
   * @param {number} maxHeight - Max height in pixels
   * @param {number} quality - Quality (0-1)
   * @returns {Promise<Blob>} Compressed image blob
   */
  const compressImage = useCallback((file, maxWidth = 800, maxHeight = 800, quality = 0.7) => {
    return new Promise((resolve, reject) => {
      if (!workerRef.current) {
        reject(new Error('Web Worker not initialized'));
        return;
      }

      const handleMessage = (e) => {
        const { success, blob, error, originalSize, compressedSize, compressionRatio } = e.data;
        
        if (success) {
          console.log(`Image compressed: ${originalSize} bytes → ${compressedSize} bytes (${compressionRatio}% reduction)`);
          resolve(blob);
        } else {
          reject(new Error(error || 'Compression failed'));
        }
        
        // Clean up listener
        workerRef.current.removeEventListener('message', handleMessage);
      };

      workerRef.current.addEventListener('message', handleMessage);
      workerRef.current.postMessage({ file, maxWidth, maxHeight, quality });
    });
  }, []);

  /**
   * Validate image file
   * @param {File} file
   * @returns {object} { valid: boolean, error: string }
   */
  const validateImage = useCallback((file) => {
    const validTypes = ['image/jpeg', 'image/jpg', 'image/png'];
    const maxSize = 5 * 1024 * 1024; // 5MB

    if (!file) {
      return { valid: false, error: 'No file selected' };
    }

    if (!validTypes.includes(file.type)) {
      return { valid: false, error: 'Only JPG and PNG files are allowed' };
    }

    if (file.size > maxSize) {
      return { valid: false, error: 'File size must be less than 5MB' };
    }

    return { valid: true, error: null };
  }, []);

  /**
   * Upload profile picture
   * @param {File} file - Image file
   * @param {boolean} compress - Whether to compress the image
   * @returns {Promise<object>} Upload result
   */
  const uploadProfilePicture = useCallback(async (file, compress = true) => {
    setUploading(true);
    setError(null);
    setProgress(0);

    try {
      // Validate file
      const validation = validateImage(file);
      if (!validation.valid) {
        throw new Error(validation.error);
      }

      setProgress(20);

      // Compress image if requested
      let fileToUpload = file;
      if (compress) {
        setProgress(40);
        const compressedBlob = await compressImage(file);
        fileToUpload = new File([compressedBlob], file.name, { type: file.type });
      }

      setProgress(60);

      // Upload to backend
      const result = await profileService.uploadAvatar(fileToUpload);

      setProgress(100);
      return { success: true, data: result };
    } catch (err) {
      console.error('Upload error:', err);
      setError(err.message || 'Failed to upload profile picture');
      return { success: false, error: err.message };
    } finally {
      setUploading(false);
      setTimeout(() => setProgress(0), 1000);
    }
  }, [compressImage, validateImage]);

  /**
   * Delete profile picture
   * @returns {Promise<object>} Delete result
   */
  const deleteProfilePicture = useCallback(async () => {
    setUploading(true);
    setError(null);

    try {
      const result = await profileService.deleteAvatar();
      return { success: true, data: result };
    } catch (err) {
      console.error('Delete error:', err);
      setError(err.message || 'Failed to delete profile picture');
      return { success: false, error: err.message };
    } finally {
      setUploading(false);
    }
  }, []);

  return {
    uploading,
    error,
    progress,
    uploadProfilePicture,
    deleteProfilePicture,
    validateImage,
    compressImage,
  };
}

export default useProfilePicture;
