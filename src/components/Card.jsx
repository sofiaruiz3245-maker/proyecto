import { useContext } from 'react';
import { CartContext } from '../context/CartContext';

function Card({ producto }) {
  const { addToCart } = useContext(CartContext);

  return (
    <article className="product-card">
      <div className="product-image">
        <span className="product-tag">{producto.etiqueta}</span>
        <button className="heart" aria-label={`Guardar ${producto.nombre}`}>♡</button>
        <img src={producto.imagen} alt={producto.nombre} />
      </div>

      <div className="product-info">
        <span className="product-category">{producto.categoria}</span>
        <h3>{producto.nombre}</h3>
        <div className="price-row">
          <strong>${producto.precio.toLocaleString("es-CO")}</strong>
        </div>
        <button className="buy-button" onClick={() => addToCart(producto)}>
          <span>+</span> Agregar al carrito
        </button>
      </div>
    </article>
  );
}

export default Card;
