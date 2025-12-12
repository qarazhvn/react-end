// src/hooks/useAuth.js
import { useSelector } from 'react-redux';
import { useMemo } from 'react';

/**
 * Custom hook for authentication state and user info
 * @returns {object} Auth state and helper functions
 */
function useAuth() {
  const auth = useSelector((state) => state.auth);

  // Memoize computed values to avoid unnecessary recalculations
  const computedAuth = useMemo(() => {
    return {
      isAuthenticated: auth.isAuthenticated,
      isLoading: auth.loading,
      user: auth.user,
      token: auth.token,
      
      // Helper functions
      isAdmin: () => auth.user?.role_name === 'Admin',
      isModerator: () => auth.user?.role_name === 'Moderator',
      isSeller: () => auth.user?.role_name === 'Seller',
      isCustomer: () => auth.user?.role_name === 'Customer',
      
      hasRole: (role) => auth.user?.role_name === role,
      hasAnyRole: (roles) => roles.includes(auth.user?.role_name),
      
      getUserId: () => auth.user?.user_id,
      getUsername: () => auth.user?.username,
      getEmail: () => auth.user?.email,
    };
  }, [auth]);

  return computedAuth;
}

export default useAuth;
