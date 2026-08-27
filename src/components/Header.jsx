import { useContext } from "react";
import { CartContext } from "../context/CartContext";
import { AuthContext } from "../context/AuthContext"; // Login

export default function Header({ setCarritoAbierto, setLoginAbierto }) {
  const { cart } = useContext(CartContext);
  const { usuario, logout, isAuthenticated } = useContext(AuthContext); // Login

  const totalItems = cart.reduce(
    (acc, item) => acc + (item.cantidad || item.quantity || 1),
    0
  );

  return (
    <header className="header">
      <div className="logo-container">
        <div>
          <span className="logo-text">Urban Vibe</span>
          <span className="logo-dot">.</span>
          <p className="logo-subtitle">Moda urbana para todos los días</p>
        </div>
      </div>

      <nav className="header-nav">
        <a href="#inicio">Inicio</a>
        <a href="#productos">Colección</a>
        <a href="#nosotros">Nosotros</a>
      </nav>

      {/* Login: agrupado con el carrito en la esquina derecha */}
      <div className="header-actions">
        {isAuthenticated ? (
          <button className="cart-icon-button" onClick={logout}>
            Hola, {usuario.nombre} — Cerrar sesión
          </button>
        ) : (
          <button className="cart-icon-button" onClick={() => setLoginAbierto(true)}>
            Iniciar sesión
          </button>
        )}

        <button
          className="cart-icon-button"
          onClick={() => setCarritoAbierto(true)}
          aria-label="Abrir carrito de compras"
        >
          <div className="cart-btn-content">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <circle cx="9" cy="21" r="1"></circle>
              <circle cx="20" cy="21" r="1"></circle>
              <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
            </svg>
            <span>Carrito</span>
          </div>
          {totalItems > 0 && <span className="cart-badge">{totalItems}</span>}
        </button>
      </div>
    </header>
  );
}