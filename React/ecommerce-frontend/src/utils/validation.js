// src/utils/validation.js

/**
 * Validation utility functions for forms
 */

// Email validation regex
const EMAIL_REGEX = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

// Password must have: 8+ chars, 1 special char, 1 number
const PASSWORD_REGEX = /^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,}$/;

/**
 * Validate email format
 * @param {string} email
 * @returns {boolean}
 */
export const validateEmail = (email) => {
  if (!email || typeof email !== 'string') {
    return false;
  }
  return EMAIL_REGEX.test(email.trim());
};

/**
 * Validate password complexity
 * Requirements: 8+ chars, at least 1 special character, at least 1 number
 * @param {string} password
 * @returns {object} { valid: boolean, errors: string[] }
 */
export const validatePassword = (password) => {
  const errors = [];

  if (!password) {
    return { valid: false, errors: ['Password is required'] };
  }

  if (password.length < 8) {
    errors.push('Password must be at least 8 characters long');
  }

  if (!/[0-9]/.test(password)) {
    errors.push('Password must contain at least one number');
  }

  if (!/[!@#$%^&*]/.test(password)) {
    errors.push('Password must contain at least one special character (!@#$%^&*)');
  }

  return {
    valid: errors.length === 0,
    errors,
  };
};

/**
 * Check if passwords match
 * @param {string} password
 * @param {string} repeatPassword
 * @returns {boolean}
 */
export const passwordsMatch = (password, repeatPassword) => {
  return password === repeatPassword && password.length > 0;
};

/**
 * Validate username
 * @param {string} username
 * @returns {object} { valid: boolean, error: string }
 */
export const validateUsername = (username) => {
  if (!username || username.trim().length < 3) {
    return {
      valid: false,
      error: 'Username must be at least 3 characters long',
    };
  }

  if (username.length > 50) {
    return {
      valid: false,
      error: 'Username must not exceed 50 characters',
    };
  }

  return { valid: true, error: null };
};

/**
 * Comprehensive form validation for registration
 * @param {object} formData - { username, email, password, repeatPassword }
 * @returns {object} { valid: boolean, errors: object }
 */
export const validateRegistrationForm = (formData) => {
  const { username, email, password, repeatPassword } = formData;
  const errors = {};

  // Username validation
  const usernameValidation = validateUsername(username);
  if (!usernameValidation.valid) {
    errors.username = usernameValidation.error;
  }

  // Email validation
  if (!validateEmail(email)) {
    errors.email = 'Please enter a valid email address';
  }

  // Password validation
  const passwordValidation = validatePassword(password);
  if (!passwordValidation.valid) {
    errors.password = passwordValidation.errors.join('. ');
  }

  // Repeat password validation
  if (!passwordsMatch(password, repeatPassword)) {
    errors.repeatPassword = 'Passwords do not match';
  }

  return {
    valid: Object.keys(errors).length === 0,
    errors,
  };
};

/**
 * Comprehensive form validation for login
 * @param {object} formData - { username, password }
 * @returns {object} { valid: boolean, errors: object }
 */
export const validateLoginForm = (formData) => {
  const { username, password } = formData;
  const errors = {};

  if (!username || username.trim().length === 0) {
    errors.username = 'Username is required';
  }

  if (!password || password.length === 0) {
    errors.password = 'Password is required';
  }

  return {
    valid: Object.keys(errors).length === 0,
    errors,
  };
};

/**
 * Get password strength indicator
 * @param {string} password
 * @returns {string} 'weak' | 'medium' | 'strong'
 */
export const getPasswordStrength = (password) => {
  if (!password) return 'weak';

  let strength = 0;

  // Length check
  if (password.length >= 8) strength++;
  if (password.length >= 12) strength++;

  // Complexity checks
  if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
  if (/[0-9]/.test(password)) strength++;
  if (/[!@#$%^&*]/.test(password)) strength++;

  if (strength <= 2) return 'weak';
  if (strength <= 4) return 'medium';
  return 'strong';
};
