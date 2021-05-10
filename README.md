# Cacstore - Backend

A little store concept to all cactus lovers 🌵🌵

## Arquitecture

### Domain

This part of the system is responsable to declare the main entities of the store. It also contain the business logic, including use cases and abstraction of repositories.  

#### Entities

- Product: id, name, description, price, sale_price, category
- Cart: id, products, subtotal, coupons, total
- Coupon: id, code, type_of_discount, discount
- Order: id, user, products, total, status
- User: id, first_name, last_name, phone, password

### Actions

- Product:
  -- Create product
  -- Get one product
  -- Get all products
  -- Get all products of category
  -- Edit product
  -- Delete product
- Cart:
  -- Create cart
  -- Add product to cart
  -- Remove product from cart
  -- Add coupon to cart
  -- Remove coupon from cart
  -- Get cart totals
- Coupon:
  -- Create coupon
  -- Edit coupon
  -- Delete coupon
  -- Find coupon by code
- Order:
  -- Create order
  -- Change status of order
  -- Delete order
  -- Get all order
  -- Get all orders by user
- User:
  -- Create user
  -- Log in
  -- Log out
  -- Edit user
  -- Remove user
  -- Get all users
  -- Get user profile
