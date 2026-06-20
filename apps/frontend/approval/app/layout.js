import "./globals.css";

export const metadata = {
  title: "App Two — Platform",
  description: "Frontend App 2 — Monorepo",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
