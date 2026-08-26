function Carrito({
  carrito,
  abierto,
  cerrar,
  cambiarCantidad,
  eliminarDelCarrito,
  vaciarCarrito,
}) {
  const subtotal = carrito.reduce(
    (total, item) => total + item.precio * item.cantidad,
    0
  );
  const envio = carrito.length === 0 || subtotal >= 150000 ? 0 : 8000;
  const total = subtotal + envio;

  function finalizarCompra() {
    if (!carrito.length) return;
    alert(
      `¡Gracias por tu compra!\\nTotal: $${total.toLocaleString("es-CO")}\\n\\nEste botón simula el proceso de pago.`
    );
    vaciarCarrito();
    cerrar();
  }

  return (
    <>
      {abierto && <div className="cart-overlay" onClick={cerrar}></div>}

      <aside className={`cart-drawer ${abierto ? "open" : ""}`}>
        <div className="cart-header">
          <div>
            <span className="cart-eyebrow">TU COMPRA</span>
            <h2>Mi carrito 🛍️</h2>
          </div>
          <button className="close-cart" onClick={cerrar} aria-label="Cerrar carrito">
            ×
          </button>
        </div>

        {carrito.length === 0 ? (
          <div className="empty-cart">
            <div className="empty-icon">🛒</div>
            <h3>Tu carrito está vacío</h3>
            <p>Agrega tus prendas favoritas y aparecerán aquí.</p>
            <button className="continue-button" onClick={cerrar}>
              Ver productos
            </button>
          </div>
        ) : (
          <>
            <div className="cart-items">
              {carrito.map((producto) => (
                <div className="cart-item" key={producto.id}>
                  <img src={producto.imagen} alt={producto.nombre} />
                  <div className="cart-item-info">
                    <h3>{producto.nombre}</h3>
                    <p>${producto.precio.toLocaleString("es-CO")}</p>
                    <div className="quantity">
                      <button onClick={() => cambiarCantidad(producto.id, -1)}>−</button>
                      <span>{producto.cantidad}</span>
                      <button onClick={() => cambiarCantidad(producto.id, 1)}>+</button>
                    </div>
                  </div>
                  <div className="cart-item-right">
                    <strong>
                      ${(producto.precio * producto.cantidad).toLocaleString("es-CO")}
                    </strong>
                    <button
                      className="delete"
                      onClick={() => eliminarDelCarrito(producto.id)}
                      aria-label={`Eliminar ${producto.nombre}`}
                    >
                      🗑️
                    </button>
                  </div>
                </div>
              ))}
            </div>

            <div className="cart-summary">
              <div><span>Subtotal</span><strong>${subtotal.toLocaleString("es-CO")}</strong></div>
              <div>
                <span>Envío</span>
                <strong>{envio === 0 ? "GRATIS" : `$${envio.toLocaleString("es-CO")}`}</strong>
              </div>
              <small>Envío gratis en compras desde $150.000</small>
              <div className="total-row">
                <span>Total</span>
                <strong>${total.toLocaleString("es-CO")}</strong>
              </div>

              <button className="checkout" onClick={finalizarCompra}>
                Finalizar compra <span>→</span>
              </button>
              <button className="clear-cart" onClick={vaciarCarrito}>
                Vaciar carrito
              </button>
            </div>
          </>
        )}
      </aside>
    </>
  );
}

export default Carrito;
