function Header({ carrito, abrirCarrito }) {
  return (
    <header className="header">
      <a
        className="logo"
        href="#inicio"
        aria-label="Urban Vibe, inicio"
      >

        <span>
          Urban <b>Vibe</b>
        </span>
      </a>

      <nav className="nav">
        <a href="#inicio">Inicio</a>
        <a href="#productos">Productos</a>
        <a href="#nosotros">Nosotros</a>
        <a href="#contacto">Contacto</a>
      </nav>

      <button className="cart-button" onClick={abrirCarrito}>
        <span className="cart-icon">🛍️</span>
        <span className="cart-text">Carrito</span>
        <span className="cart-count">{carrito}</span>
      </button>
    </header>
  );
}

export default Header;