import { createContext, useState, useEffect } from 'react';

export const CartContext = createContext();

export const CartProvider = ({ children }) => {
  const [cart, setCart] = useState(() => {
    try {
      const saved = localStorage.getItem('urbanVibeCarrito');
      return saved ? JSON.parse(saved) : [];
    } catch {
      return [];
    }
  });

  useEffect(() => {
    localStorage.setItem('urbanVibeCarrito', JSON.stringify(cart));
  }, [cart]);

  const addToCart = (product) => {
    setCart((prevCart) => {
      const existe = prevCart.find((item) => item.id === product.id);
      if (existe) {
        return prevCart.map((item) =>
          item.id === product.id
            ? { ...item, cantidad: (item.cantidad || item.quantity || 1) + 1 }
            : item
        );
      }
      return [...prevCart, { ...product, cantidad: 1 }];
    });
  };

  const removeFromCart = (id) => {
    setCart((prevCart) => prevCart.filter((item) => item.id !== id));
  };

  const updateQuantity = (id, nuevaCantidad) => {
    if (nuevaCantidad <= 0) {
      removeFromCart(id);
      return;
    }
    setCart((prevCart) =>
      prevCart.map((item) =>
        item.id === id ? { ...item, cantidad: nuevaCantidad } : item
      )
    );
  };

  const clearCart = () => setCart([]);

  const total = cart.reduce((acc, item) => {
    const qty = item.cantidad || item.quantity || 1;
    const price = Number(item.precio) || 0;
    return acc + price * qty;
  }, 0);

  return (
    <CartContext.Provider
      value={{ cart, addToCart, removeFromCart, updateQuantity, clearCart, total }}
    >
      {children}
    </CartContext.Provider>
  );
};