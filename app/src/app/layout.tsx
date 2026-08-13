import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import Navigation from "@/components/Navigation";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "ChoreQuest",
  description: "Family chore and rewards management application.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html
      lang="en"
      className={`${geistSans.variable} ${geistMono.variable} h-full antialiased`}
    >
      <body className="min-h-screen bg-gray-50 text-gray-900">
        <div className="min-h-screen md:flex">
          <aside className="border-b bg-white p-6 md:min-h-screen md:w-64 md:border-b-0 md:border-r">
            <Navigation />
          </aside>

          <main className="min-w-0 flex-1 p-6 md:p-10">
            {children}
          </main>
        </div>
      </body>
    </html>
  );
}
