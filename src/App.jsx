import { useEffect, useMemo, useState } from "react";
import Header from "./components/Header";
import Footer from "./components/Footer";
import Home from "./pages/Home";
import Carrito from "./components/Carrito";
import "./App.css";

export default function App() {
  const [carrito, setCarrito] = useState(() => {
    try {
      return JSON.parse(localStorage.getItem("urbanVibeCarrito")) || [];
    } catch {
      return [];
    }
  });

  const [carritoAbierto, setCarritoAbierto] = useState(false);

  useEffect(() => {
    localStorage.setItem("urbanVibeCarrito", JSON.stringify(carrito));
  }, [carrito]);

  function agregarAlCarrito(producto) {
    setCarrito((actual) => {
      const existe = actual.find((item) => item.id === producto.id);

      if (existe) {
        return actual.map((item) =>
          item.id === producto.id
            ? { ...item, cantidad: item.cantidad + 1 }
            : item
        );
      }

      return [...actual, { ...producto, cantidad: 1 }];
    });

    setCarritoAbierto(true);
  }

  function cambiarCantidad(id, cambio) {
    setCarrito((actual) =>
      actual
        .map((item) =>
          item.id === id
            ? { ...item, cantidad: item.cantidad + cambio }
            : item
        )
        .filter((item) => item.cantidad > 0)
    );
  }

  function eliminarDelCarrito(id) {
    setCarrito((actual) => actual.filter((item) => item.id !== id));
  }

  function vaciarCarrito() {
    setCarrito([]);
  }

  const totalItems = useMemo(
    () => carrito.reduce((total, item) => total + item.cantidad, 0),
    [carrito]
  );

  return (
    <div className="app">
      <Header
        carrito={totalItems}
        abrirCarrito={() => setCarritoAbierto(true)}
      />

      <Home
        agregarAlCarrito={agregarAlCarrito}
        abrirCarrito={() => setCarritoAbierto(true)}
      />

      <Carrito
        carrito={carrito}
        abierto={carritoAbierto}
        cerrar={() => setCarritoAbierto(false)}
        cambiarCantidad={cambiarCantidad}
        eliminarDelCarrito={eliminarDelCarrito}
        vaciarCarrito={vaciarCarrito}
      />

      <Footer />
    </div>
  );
}