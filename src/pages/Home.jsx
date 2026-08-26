import { useMemo, useState } from "react";
import Card from "../components/Card";

import camisa from "../assets/productos/camisa.png.jpeg";
import camisa1 from "../assets/productos/camisa1.png.jpeg";
import camisa2 from "../assets/productos/camisa2.png.jpeg";
import camisa3 from "../assets/productos/camisa3.png.jpeg";
import camisa4 from "../assets/productos/camisa4.png.jpeg";
import camisa5 from "../assets/productos/camisa5.png.jpeg";
import sudadera from "../assets/productos/sudadera.png.jpeg";
import pantalon from "../assets/productos/pantalon.png.jpeg";
import pantalon1 from "../assets/productos/pantalon1.png.jpeg";
import pantalon2 from "../assets/productos/pantalon2.png.jpeg";
import conjunto1 from "../assets/productos/conjunto1.png.jpeg";
import conjunto2 from "../assets/productos/conjunto2.png.jpeg";
import conjunto3 from "../assets/productos/conjunto3.png.jpeg";
import conjunto4 from "../assets/productos/conjunto4.png.jpeg";

const productos = [
  {
    id: 1,
    nombre: "Camiseta básica",
    precio: 35000,
    imagen: camisa,
    categoria: "Camisas",
    etiqueta: "NUEVO",
  },
  {
    id: 2,
    nombre: "Sudadera urbana",
    precio: 60000,
    imagen: sudadera,
    categoria: "Sudaderas",
    etiqueta: "POPULAR",
  },
  {
    id: 3,
    nombre: "Jean clásico",
    precio: 80000,
    imagen: pantalon,
    categoria: "Pantalones",
    etiqueta: "NUEVO",
  },
  {
    id: 4,
    nombre: "Camiseta estampada",
    precio: 38000,
    imagen: camisa1,
    categoria: "Camisas",
    etiqueta: "NUEVO",
  },
  {
    id: 5,
    nombre: "Camiseta oversize",
    precio: 42000,
    imagen: camisa2,
    categoria: "Camisas",
    etiqueta: "NUEVO",
  },
  {
    id: 6,
    nombre: "Camiseta gráfica",
    precio: 39000,
    imagen: camisa3,
    categoria: "Camisas",
    etiqueta: "NUEVO",
  },
  {
    id: 7,
    nombre: "Camiseta manga larga",
    precio: 45000,
    imagen: camisa4,
    categoria: "Camisas",
    etiqueta: "NUEVO",
  },
  {
    id: 8,
    nombre: "Camiseta deportiva",
    precio: 37000,
    imagen: camisa5,
    categoria: "Camisas",
    etiqueta: "NUEVO",
  },
  {
    id: 9,
    nombre: "Conjunto casual",
    precio: 95000,
    imagen: conjunto1,
    categoria: "Sudaderas",
    etiqueta: "POPULAR",
  },
  {
    id: 10,
    nombre: "Conjunto deportivo",
    precio: 98000,
    imagen: conjunto2,
    categoria: "Sudaderas",
    etiqueta: "NUEVO",
  },
  {
    id: 11,
    nombre: "Conjunto urbano",
    precio: 100000,
    imagen: conjunto3,
    categoria: "Sudaderas",
    etiqueta: "NUEVO",
  },
  {
    id: 12,
    nombre: "Conjunto premium",
    precio: 105000,
    imagen: conjunto4,
    categoria: "Sudaderas",
    etiqueta: "POPULAR",
  },
  {
    id: 13,
    nombre: "Pantalón cargo",
    precio: 75000,
    imagen: pantalon1,
    categoria: "Pantalones",
    etiqueta: "NUEVO",
  },
  {
    id: 14,
    nombre: "Pantalón jogger",
    precio: 70000,
    imagen: pantalon2,
    categoria: "Pantalones",
    etiqueta: "NUEVO",
  },
];

function Home({ agregarAlCarrito, abrirCarrito }) {
  const [categoria, setCategoria] = useState("Todos");

  const productosFiltrados = useMemo(
    () =>
      categoria === "Todos"
        ? productos
        : productos.filter((producto) => producto.categoria === categoria),
    [categoria]
  );

  return (
    <main>
      {/* SECCIÓN PRINCIPAL */}
      <section className="hero" id="inicio">
        <div className="hero-content">
          <span className="eyebrow">COLECCIÓN 2026</span>

          <h1>
            Tu estilo.
            <br />
            <span>Tu momento.</span>
          </h1>

          <p>
            Ropa moderna, cómoda y con personalidad para que todos los días
            tengas algo que decir.
          </p>

          <div className="hero-actions">
            <a href="#productos" className="primary-button">
              Explorar colección <span>→</span>
            </a>

            <button className="secondary-button" onClick={abrirCarrito}>
              Ver carrito
            </button>
          </div>

          <div className="hero-features">
            <span>✓ Calidad garantizada</span>
            <span>✓ Envíos a todo Colombia</span>
            <span>✓ Pago seguro</span>
          </div>
        </div>

        <div className="hero-visual">
          <div className="blob"></div>

          <div className="hero-card card-one">
            <img src={sudadera} alt="Sudadera urbana" />
          </div>

          <div className="hero-card card-two">
            <img src={camisa} alt="Camiseta básica" />
          </div>

          <div className="floating-label">
            ★ Favoritos
            <br />
            <b>de la temporada</b>
          </div>
        </div>
      </section>

      {/* SECCIÓN DE PRODUCTOS */}
      <section className="products-section" id="productos">
        <div className="section-heading">
          <div>
            <span className="section-eyebrow">DESCUBRE</span>
            <h2>Nuestra colección</h2>
          </div>

          <p>
            Prendas esenciales para crear looks que se sienten tan bien como
            se ven.
          </p>
        </div>

        <div className="categories">
          {["Todos", "Camisas", "Pantalones", "Sudaderas"].map((item) => (
            <button
              key={item}
              className={
                categoria === item ? "category active" : "category"
              }
              onClick={() => setCategoria(item)}
            >
              {item}
            </button>
          ))}
        </div>

        <div className="product-grid">
          {productosFiltrados.map((producto) => (
            <Card
              key={producto.id}
              producto={producto}
              alComprar={agregarAlCarrito}
            />
          ))}
        </div>
      </section>

      {/* SECCIÓN SOBRE NOSOTROS */}
      <section className="about" id="nosotros">
        <div>
          <span className="section-eyebrow">SOBRE NOSOTROS</span>

          <h2>
            Moda sencilla,
            <br />
            <span>personalidad enorme.</span>
          </h2>
        </div>

        <p>
          En <b>Urban Vibe</b> creemos que vestirse bien no tiene que ser
          complicado. Seleccionamos prendas modernas, cómodas y versátiles
          para jóvenes que quieren expresar su personalidad y crear su propio
          estilo sin dejar de sentirse ellos mismos.
        </p>
      </section>
    </main>
  );
}

export default Home;