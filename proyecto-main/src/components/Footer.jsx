import { useIdioma } from "../context/IdiomaContext"; // Idioma

function Footer() {
  const { t } = useIdioma();

  return (
    <footer className="footer" id="contacto">
      <div>
        <div className="footer-logo">
          Urban<b>Vibe</b>
        </div>

        <p>{t("footer.tagline", "Estilo que habla por ti.")}</p>
      </div>

      <div className="footer-links">
        <a href="#inicio">{t("nav.inicio", "Inicio")}</a>
        <a href="#productos">{t("nav.coleccion", "Colección")}</a>
        <a href="#nosotros">{t("nav.nosotros", "Nosotros")}</a>
      </div>

      <div className="footer-copy">
        <p>{t("footer.copy", "© 2026 Urban Vibe")}</p>
        <p>{t("footer.derechos", "Todos los derechos reservados")}</p>
      </div>
    </footer>
  );
}

export default Footer;
