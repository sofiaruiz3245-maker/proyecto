// --- Login: registro + inicio de sesión con usuarios guardados en localStorage ---
import { createContext, useState } from 'react';

export const AuthContext = createContext();

const CLAVE_USUARIOS = 'urbanVibeUsuarios';
const CLAVE_SESION = 'urbanVibeUsuario';

function leerSesionInicial() {
  try {
    const datos = localStorage.getItem(CLAVE_SESION);
    return datos ? JSON.parse(datos) : null;
  } catch {
    return null;
  }
}

function obtenerUsuarios() {
  try {
    const datos = localStorage.getItem(CLAVE_USUARIOS);
    return datos ? JSON.parse(datos) : [];
  } catch {
    return [];
  }
}

export const AuthProvider = ({ children }) => {
  const [usuario, setUsuario] = useState(leerSesionInicial);

  const guardarSesion = (datos) => {
    localStorage.setItem(CLAVE_SESION, JSON.stringify(datos));
    setUsuario(datos);
  };

  // Crea una cuenta nueva (si el correo no existe) y deja la sesión iniciada
  const registrar = (nombre, email, password) => {
    const correo = email.trim().toLowerCase();
    const usuarios = obtenerUsuarios();

    if (usuarios.some((u) => u.correo === correo)) {
      return 'Ya existe una cuenta con ese correo.';
    }
    if (password.length < 4) {
      return 'La contraseña debe tener al menos 4 caracteres.';
    }

    const nuevo = { nombre: nombre.trim(), correo, password };
    localStorage.setItem(CLAVE_USUARIOS, JSON.stringify([...usuarios, nuevo]));
    guardarSesion({ nombre: nuevo.nombre, correo: nuevo.correo });
    return null;
  };

  // Valida las credenciales contra los usuarios ya registrados
  const login = (email, password) => {
    const correo = email.trim().toLowerCase();
    const usuarios = obtenerUsuarios();
    const encontrado = usuarios.find((u) => u.correo === correo && u.password === password);

    if (!encontrado) return 'Correo o contraseña incorrectos.';

    guardarSesion({ nombre: encontrado.nombre, correo: encontrado.correo });
    return null;
  };

  const logout = () => {
    localStorage.removeItem(CLAVE_SESION);
    setUsuario(null);
  };

  return (
    <AuthContext.Provider
      value={{ usuario, registrar, login, logout, isAuthenticated: !!usuario }}
    >
      {children}
    </AuthContext.Provider>
  );
};
