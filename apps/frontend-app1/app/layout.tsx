import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "App One — Dashboard",
  description: "Frontend App 1",
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
