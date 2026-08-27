// --- Idioma: carga /locales/{idioma}.json y expone t(clave, textoOriginal) ---
import { createContext, useContext, useEffect, useState } from "react";

const IdiomaContext = createContext(null);

function leerIdiomaInicial() {
  return localStorage.getItem("urbanVibeIdioma") || "es";
}

export function IdiomaProvider({ children }) {
  const [idioma, setIdioma] = useState(leerIdiomaInicial);
  const [traducciones, setTraducciones] = useState({});

  useEffect(() => {
    let cancelado = false;

    async function cargarIdioma() {
      try {
        const respuesta = await fetch(`/locales/${idioma}.json`);
        const datos = await respuesta.json();
        if (!cancelado) setTraducciones(datos);
      } catch (error) {
        console.warn("No se pudieron cargar las traducciones.", error);
        if (!cancelado) setTraducciones({});
      }
    }

    cargarIdioma();
    localStorage.setItem("urbanVibeIdioma", idioma);

    return () => {
      cancelado = true;
    };
  }, [idioma]);

  const alternarIdioma = () => {
    setIdioma((actual) => (actual === "es" ? "en" : "es"));
  };

  // Devuelve la traducción si ya cargó; mientras tanto usa el texto en español del JSX
  const t = (clave, textoOriginal) => traducciones[clave] || textoOriginal;

  return (
    <IdiomaContext.Provider value={{ idioma, alternarIdioma, t }}>
      {children}
    </IdiomaContext.Provider>
  );
}

export function useIdioma() {
  return useContext(IdiomaContext);
}
