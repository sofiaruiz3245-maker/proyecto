import { useState } from "react";
import Header from "./components/Header";
import Footer from "./components/Footer";
import Home from "./pages/Home";
import Carrito from "./components/Carrito";
import LoginModal from "./components/LoginModal"; // Login
import "./App.css";

export default function App() {
  const [carritoAbierto, setCarritoAbierto] = useState(false);
  const [loginAbierto, setLoginAbierto] = useState(false); // Login: controla el modal

  return (
    <div className="app-container">
      <Header
        setCarritoAbierto={setCarritoAbierto}
        setLoginAbierto={setLoginAbierto}
      />

      <main>
        <Home setCarritoAbierto={setCarritoAbierto} />
      </main>

      {carritoAbierto && (
        <div className="modal-overlay" onClick={() => setCarritoAbierto(false)}>
          <div className="modal-content" onClick={(e) => e.stopPropagation()}>
            <button className="btn-cerrar" onClick={() => setCarritoAbierto(false)}>
              ✕
            </button>
            <Carrito />
          </div>
        </div>
      )}

      {/* Login: modal de inicio de sesión */}
      {loginAbierto && (
        <LoginModal onClose={() => setLoginAbierto(false)} />
      )}

      <Footer />
    </div>
  );
}