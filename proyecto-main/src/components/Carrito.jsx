import { useContext, useState } from "react";
import { CartContext } from "../context/CartContext";
import { useIdioma } from "../context/IdiomaContext"; // Idioma

export default function Carrito({ setCarritoAbierto }) {
  const { cart, removeFromCart, updateQuantity, clearCart, total } =
    useContext(CartContext);
  const { t } = useIdioma();

  const [comprado, setComprado] = useState(false);

  const handleProcederPago = () => {
    setComprado(true);
    clearCart();
  };

  const handleCerrarTodo = () => {
    setComprado(false);
    if (setCarritoAbierto) {
      setCarritoAbierto(false);
    }
  };

  return (
    <div className="cart-modal-inner">
      {comprado ? (
        <div style={{ textAlign: "center", padding: "30px 10px" }}>
          <div style={{ fontSize: "50px", marginBottom: "10px" }}>✅</div>
          <h2 style={{ fontSize: "24px", color: "#2e7d32", marginBottom: "10px" }}>
            {t("carrito.pagoTitulo", "¡Pago Concretado!")}
          </h2>
          <p style={{ color: "#555", marginBottom: "25px" }}>
            {t("carrito.pagoDescripcion", "Tu compra ha sido realizada con éxito. ¡Muchas gracias por tu pedido!")}
          </p>
          <button type="button" className="btn-checkout" onClick={handleCerrarTodo}>
            {t("carrito.aceptar", "Aceptar y Seguir Comprando")}
          </button>
        </div>
      ) : (
        <>
          <div className="cart-header">
            <h2>{t("carrito.titulo", "Tu Carrito")}</h2>
            {cart.length > 0 && (
              <button className="btn-clear-all" onClick={clearCart}>
                {t("carrito.vaciar", "Vaciar carrito")}
              </button>
            )}
          </div>

          {cart.length === 0 ? (
            <div className="cart-empty">
              <p>{t("carrito.vacio", "Tu carrito está vacío 🛒")}</p>
            </div>
          ) : (
            <>
              <div className="cart-list">
                {cart.map((item) => {
                  const cantidad = item.cantidad || item.quantity || 1;
                  return (
                    <div key={item.id} className="cart-item">
                      <img src={item.imagen} alt={item.nombre} className="cart-item-img" />

                      <div className="cart-item-details">
                        <h4 className="cart-item-title">{item.nombre}</h4>
                        <span className="cart-item-price">
                          ${(item.precio * cantidad).toLocaleString("es-CO")}
                        </span>
                      </div>

                      <div className="cart-item-controls">
                        <div className="quantity-picker">
                          <button type="button" onClick={() => updateQuantity(item.id, cantidad - 1)}>-</button>
                          <span>{cantidad}</span>
                          <button type="button" onClick={() => updateQuantity(item.id, cantidad + 1)}>+</button>
                        </div>

                        <button
                          type="button"
                          className="btn-delete"
                          onClick={() => removeFromCart(item.id)}
                          title={t("carrito.eliminar", "Eliminar producto")}
                        >
                          🗑️
                        </button>
                      </div>
                    </div>
                  );
                })}
              </div>

              <div className="cart-footer">
                <div className="cart-total-row">
                  <span>{t("carrito.total", "Total a pagar:")}</span>
                  <strong>${total.toLocaleString("es-CO")}</strong>
                </div>
                <button type="button" className="btn-checkout" onClick={handleProcederPago}>
                  {t("carrito.proceder", "Proceder al pago")}
                </button>
              </div>
            </>
          )}
        </>
      )}
    </div>
  );
}
