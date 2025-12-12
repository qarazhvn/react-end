// routes/routes.go
package routes

import (
    "github.com/gorilla/mux"
    "github.com/Tasherokk/GolangProject.git/controllers"
    "github.com/Tasherokk/GolangProject.git/middleware"
)

func RegisterRoutes(router *mux.Router) {
    // IMPORTANT: Register more specific routes BEFORE general ones
    
    // Публичные маршруты (без аутентификации)
    router.HandleFunc("/api/register", controllers.RegisterUser).Methods("POST")
    router.HandleFunc("/api/login", controllers.LoginUser).Methods("POST")
    router.HandleFunc("/api/products", controllers.GetAllProducts).Methods("GET")
    router.HandleFunc("/api/products/{product_id:[0-9]+}", controllers.GetProductByID).Methods("GET")
    router.HandleFunc("/api/categories", controllers.GetAllCategories).Methods("GET")
    router.HandleFunc("/api/categories/{category_id:[0-9]+}", controllers.GetCategoryByID).Methods("GET")
    router.HandleFunc("/api/products/{product_id:[0-9]+}/reviews", controllers.GetReviewsByProduct).Methods("GET")

    // Authenticated routes - регистрируем напрямую с middleware
    authAPI := router.PathPrefix("/api").Subrouter()
    authAPI.Use(middleware.AuthMiddleware)

    // User routes
    authAPI.HandleFunc("/users/me", controllers.GetCurrentUser).Methods("GET")
    authAPI.HandleFunc("/users/me", controllers.UpdateUser).Methods("PUT")
    authAPI.HandleFunc("/users/me", controllers.DeleteUser).Methods("DELETE")
    authAPI.HandleFunc("/users/me/avatar", controllers.UploadAvatar).Methods("POST")
    authAPI.HandleFunc("/users/me/avatar", controllers.DeleteAvatar).Methods("DELETE")

    // Product management (authenticated)
    authAPI.HandleFunc("/products", controllers.CreateProduct).Methods("POST")
    authAPI.HandleFunc("/products/{product_id:[0-9]+}", controllers.UpdateProduct).Methods("PUT")
    authAPI.HandleFunc("/products/{product_id:[0-9]+}", controllers.DeleteProduct).Methods("DELETE")
    authAPI.HandleFunc("/products/{product_id:[0-9]+}/image", controllers.UploadProductImage).Methods("POST")
    authAPI.HandleFunc("/products/{product_id:[0-9]+}/image", controllers.DeleteProductImage).Methods("DELETE")
    authAPI.HandleFunc("/seller/products", controllers.GetSellerProducts).Methods("GET")

    // Category management (authenticated)
    authAPI.HandleFunc("/categories", controllers.CreateCategory).Methods("POST")
    authAPI.HandleFunc("/categories/{category_id:[0-9]+}", controllers.UpdateCategory).Methods("PUT")
    authAPI.HandleFunc("/categories/{category_id:[0-9]+}", controllers.DeleteCategory).Methods("DELETE")

    // Orders
    authAPI.HandleFunc("/orders", controllers.GetUserOrders).Methods("GET")
    authAPI.HandleFunc("/orders/checkout", controllers.CreateOrder).Methods("POST")
    authAPI.HandleFunc("/orders/{order_id:[0-9]+}", controllers.GetOrderByID).Methods("GET")
    authAPI.HandleFunc("/orders/{order_id:[0-9]+}/status", controllers.UpdateOrderStatus).Methods("PATCH")
    authAPI.HandleFunc("/seller/orders", controllers.GetSellerOrders).Methods("GET")
    authAPI.HandleFunc("/orders/{order_id:[0-9]+}/items", controllers.GetOrderItems).Methods("GET")
    authAPI.HandleFunc("/orders/{order_id:[0-9]+}/items", controllers.AddOrderItems).Methods("POST")

    // Cart
    authAPI.HandleFunc("/cart", controllers.GetUserCart).Methods("GET")
    authAPI.HandleFunc("/cart/items", controllers.GetCartItems).Methods("GET")
    authAPI.HandleFunc("/cart/items", controllers.AddCartItem).Methods("POST")
    authAPI.HandleFunc("/cart/items/{item_id:[0-9]+}", controllers.DeleteCartItem).Methods("DELETE")
    authAPI.HandleFunc("/cart/items/{item_id:[0-9]+}/decrease", controllers.DecreaseCartItemQuantity).Methods("PATCH")
    authAPI.HandleFunc("/cart/items/{item_id:[0-9]+}/increase", controllers.IncreaseCartItemQuantity).Methods("PATCH")

    // Payments
    authAPI.HandleFunc("/payments", controllers.GetUserPayments).Methods("GET")
    authAPI.HandleFunc("/payments", controllers.CreatePayment).Methods("POST")

    // Reviews (creating requires auth)
    authAPI.HandleFunc("/products/{product_id:[0-9]+}/reviews", controllers.CreateReview).Methods("POST")

    // Addresses
    authAPI.HandleFunc("/addresses", controllers.GetUserAddresses).Methods("GET")
    authAPI.HandleFunc("/addresses", controllers.AddUserAddress).Methods("POST")

    // Product images
    authAPI.HandleFunc("/products/{product_id:[0-9]+}/images", controllers.GetProductImages).Methods("GET")
    authAPI.HandleFunc("/products/{product_id:[0-9]+}/images", controllers.AddProductImage).Methods("POST")

    // Admin routes
    adminRoutes := authAPI.PathPrefix("/admin").Subrouter()
    adminRoutes.Use(middleware.AdminOnly)
    adminRoutes.HandleFunc("/roles", controllers.GetAllRoles).Methods("GET")
    adminRoutes.HandleFunc("/roles", controllers.CreateRole).Methods("POST")
    adminRoutes.HandleFunc("/users/{user_id:[0-9]+}/role", controllers.UpdateUserRole).Methods("PUT")
    adminRoutes.HandleFunc("/users/{user_id:[0-9]+}", controllers.DeleteUserByID).Methods("DELETE")
    adminRoutes.HandleFunc("/users", controllers.GetAllUsers).Methods("GET")
    adminRoutes.HandleFunc("/audit-logs", controllers.GetAuditLogs).Methods("GET")
	
}
