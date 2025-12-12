import authService from '../../services/authService';
import cartService from '../../services/cartService';

export const loadUser = () => async (dispatch) => {
    const token = authService.getToken();
    if (!token) {
        return dispatch({ type: 'AUTH_ERROR' });
    }

    try {
        const userData = await authService.getCurrentUser();
        dispatch({
            type: 'USER_LOADED',
            payload: userData,
        });
        console.log('User loaded:', userData);
    } catch (err) {
        console.error('Load user error:', err);
        dispatch({
            type: 'AUTH_ERROR',
        });
        authService.logout();
    }
};

export const register = (userData) => async (dispatch) => {
    try {
        const data = await authService.register(userData);
        dispatch({
            type: 'REGISTER_SUCCESS',
            payload: data,
        });

        // Load user after registration
        dispatch(loadUser());
    } catch (err) {
        console.error('Registration error:', err);
        dispatch({
            type: 'REGISTER_FAIL',
            payload: err?.message || 'Registration failed',
        });
        throw err;
    }
};

export const login = (credentials) => async (dispatch) => {
    try {
        console.log('[AUTH] Starting login...');
        const data = await authService.login(credentials);
        console.log('[AUTH] Login successful, token received:', data.token?.substring(0, 20));
        
        // Dispatch LOGIN_SUCCESS with token
        dispatch({
            type: 'LOGIN_SUCCESS',
            payload: data,
        });

        // Load user after login - token is already set by authService.login()
        console.log('[AUTH] Loading user data...');
        await dispatch(loadUser());

        // Merge local cart with backend cart
        try {
            const mergeResult = await cartService.mergeLocalCartWithBackend();
            if (mergeResult.merged) {
                console.log(mergeResult.message);
                // You can dispatch an action to show a notification to the user
                dispatch({
                    type: 'CART_MERGED',
                    payload: mergeResult,
                });
            }
        } catch (mergeError) {
            console.error('Cart merge error:', mergeError);
            // Non-critical error, don't block login
        }
    } catch (err) {
        console.error('Login error:', err);
        dispatch({
            type: 'LOGIN_FAIL',
            payload: err?.message || 'Login failed',
        });
        throw err;
    }
};

export const logout = () => (dispatch) => {
    authService.logout();
    dispatch({ type: 'LOGOUT' });
};
