export default function Home() {
  const features = [
    { icon: "⚡", title: "Fast by Default", desc: "Next.js 15 with React Server Components and streaming." },
    { icon: "🐘", title: "Laravel Backend", desc: "Two dedicated Laravel APIs wired up via Docker Compose." },
    { icon: "🐳", title: "Docker Native", desc: "One command to spin up the entire stack locally." },
    { icon: "🗂️", title: "True Monorepo", desc: "All apps in one repo, shared configs, single source of truth." },
  ];

  return (
    <main className="min-h-screen bg-stone-50 text-stone-900">
      {/* Nav */}
      <nav className="border-b border-stone-200 bg-white/80 backdrop-blur-sm sticky top-0 z-10">
        <div className="max-w-5xl mx-auto px-6 py-4 flex items-center justify-between">
          <span className="font-bold text-stone-900 tracking-tight">Monorepo · <span className="text-violet-600">App 2</span></span>
          <span className="text-xs font-mono bg-violet-100 text-violet-700 px-3 py-1 rounded-full">port 3001</span>
        </div>
      </nav>

      {/* Hero */}
      <section className="max-w-5xl mx-auto px-6 pt-20 pb-16 text-center">
        <p className="text-xs font-mono uppercase tracking-widest text-violet-500 mb-4">Frontend App 2 · Next.js 15</p>
        <h1 className="text-5xl md:text-6xl font-black text-stone-900 leading-tight mb-6">
          Built to ship. Umme<br />
          <span className="text-violet-600">Wired to scale. kalsoom</span>
        </h1>
        <p className="text-lg text-stone-500 max-w-2xl mx-auto mb-10">
          A production-grade monorepo with two Next.js frontends, two Laravel backends, Nginx reverse proxy, and Docker Compose — running locally with a single command.
        </p>
        <div className="flex flex-wrap gap-3 justify-center">
          <a href="http://localhost:3000" className="bg-stone-900 text-white px-6 py-3 rounded-xl font-medium hover:bg-stone-700 transition-colors">
            ← Visit App 1
          </a>
          <a href="http://localhost:8001/api/health" target="_blank" rel="noreferrer" className="border border-stone-300 text-stone-700 px-6 py-3 rounded-xl font-medium hover:border-violet-400 hover:text-violet-600 transition-colors">
            API 1 Health
          </a>
          <a href="http://localhost:8002/api/health" target="_blank" rel="noreferrer" className="border border-stone-300 text-stone-700 px-6 py-3 rounded-xl font-medium hover:border-violet-400 hover:text-violet-600 transition-colors">
            API 2 Health
          </a>
        </div>
      </section>

      {/* Features */}
      <section className="max-w-5xl mx-auto px-6 pb-20">
        <div className="grid md:grid-cols-2 gap-5">
          {features.map((f) => (
            <div key={f.title} className="bg-white border border-stone-200 rounded-2xl p-6 hover:border-violet-300 transition-colors">
              <span className="text-3xl mb-3 block">{f.icon}</span>
              <h3 className="font-bold text-lg mb-1">{f.title}</h3>
              <p className="text-stone-500 text-sm">{f.desc}</p>
            </div>
          ))}
        </div>
      </section>

      <footer className="border-t border-stone-200 py-6 text-center text-stone-400 text-sm font-mono">
        Next.js 15 · Tailwind CSS · Laravel 11 · Docker Compose
      </footer>
    </main>
  );
}
