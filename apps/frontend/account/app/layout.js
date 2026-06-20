import "./globals.css";

export const metadata = {
  title: "App One — Command Center",
  description: "Frontend App 1 — Monorepo",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
