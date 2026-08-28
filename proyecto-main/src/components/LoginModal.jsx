// --- Login: modal con login y registro, sin página aparte ---
import { useContext, useState } from "react";
import { AuthContext } from "../context/AuthContext";
import { useIdioma } from "../context/IdiomaContext"; // Idioma

export default function LoginModal({ onClose }) {
  const { login, registrar } = useContext(AuthContext);
  const { t } = useIdioma();
  const [modoRegistro, setModoRegistro] = useState(false);
  const [nombre, setNombre] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");

  const handleSubmit = (e) => {
    e.preventDefault();
    const mensaje = modoRegistro
      ? registrar(nombre, email, password)
      : login(email, password);

    if (mensaje) {
      setError(mensaje);
      return;
    }
    onClose();
  };

  const cambiarModo = () => {
    setModoRegistro((prev) => !prev);
    setError("");
  };

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div className="modal-content" onClick={(e) => e.stopPropagation()}>
        <button className="btn-cerrar" onClick={onClose}>✕</button>
        <h2 className="login-title">
          {modoRegistro ? t("login.crearCuenta", "Crear cuenta") : t("login.iniciarSesion", "Iniciar sesión")}
        </h2>

        <form className="login-form" onSubmit={handleSubmit}>
          {modoRegistro && (
            <div className="login-field">
              <label htmlFor="nombre">{t("login.nombre", "Nombre")}</label>
              <input
                id="nombre"
                type="text"
                placeholder="Tu nombre"
                value={nombre}
                onChange={(e) => setNombre(e.target.value)}
                required
              />
            </div>
          )}

          <div className="login-field">
            <label htmlFor="email">{t("login.correo", "Correo electrónico")}</label>
            <input
              id="email"
              type="email"
              placeholder="tucorreo@ejemplo.com"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
            />
          </div>

          <div className="login-field">
            <label htmlFor="password">{t("login.contrasena", "Contraseña")}</label>
            <input
              id="password"
              type="password"
              placeholder="••••••••"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
              minLength={4}
            />
          </div>

          {error && <p className="login-error">{error}</p>}

          <button type="submit" className="btn-login">
            {modoRegistro ? t("login.registrarme", "Registrarme") : t("login.entrar", "Entrar")}
          </button>
        </form>

        <p className="login-switch">
          {modoRegistro ? t("login.yaTienesCuenta", "¿Ya tienes cuenta?") : t("login.noTienesCuenta", "¿No tienes cuenta?")}{" "}
          <button type="button" className="login-switch-btn" onClick={cambiarModo}>
            {modoRegistro ? t("login.iniciaSesionLink", "Inicia sesión") : t("login.registrate", "Regístrate")}
          </button>
        </p>
      </div>
    </div>
  );
}
