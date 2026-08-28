import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App.jsx';
import './index.css';
import { CartProvider } from './context/CartContext.jsx';
import { AuthProvider } from './context/AuthContext.jsx'; // Login
import { IdiomaProvider } from './context/IdiomaContext.jsx'; // Idioma

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <IdiomaProvider>
      <AuthProvider> {/* Login: da acceso al usuario en toda la app */}
        <CartProvider>
          <App />
        </CartProvider>
      </AuthProvider>
    </IdiomaProvider>
  </React.StrictMode>
);
