export default function Home() {
  const features = [
    { icon: "▲", title: "Next.js 15.3 JS",  desc: "App Router with React 19, Server Components, and JS-first setup — no TypeScript overhead."   },
    { icon: "🐘", title: "Laravel 12",       desc: "Two dedicated Laravel 12 APIs on PHP 8.4 with predis Redis client wired up via Docker."       },
    { icon: "⚡", title: "Redis 7.4",        desc: "Single Redis instance shared across both Laravel apps for cache, sessions, and queues."       },
    { icon: "🗄️", title: "MySQL 9.1",        desc: "Two isolated MySQL 9.1 databases — one per Laravel app — with healthcheck-gated startup."    },
    { icon: "🌐", title: "Nginx 1.27",       desc: "Latest Nginx Alpine proxying PHP-FPM for both backends with gzip and security headers."       },
    { icon: "🐳", title: "Docker Compose",   desc: "One command to spin up all 9 services: 2 Next.js · 2 Laravel · 2 Nginx · 2 MySQL · 1 Redis." },
  ];

  return (
    <main className="min-h-screen bg-stone-50 text-stone-900">
      {/* Nav */}
      <nav className="border-b border-stone-200 bg-white/80 backdrop-blur-sm sticky top-0 z-10">
        <div className="max-w-5xl mx-auto px-6 py-4 flex items-center justify-between">
          <span className="font-bold text-stone-900 tracking-tight">
            Monorepo · <span className="text-violet-600">App 2</span>
          </span>
          <div className="flex gap-3 items-center">
            <a href="http://localhost:3000" className="text-sm text-stone-500 hover:text-violet-600 transition-colors">← App 1</a>
            <span className="text-xs font-mono bg-violet-100 text-violet-700 px-3 py-1 rounded-full">port 3001</span>
          </div>
        </div>
      </nav>

      {/* Hero */}
      <section className="max-w-5xl mx-auto px-6 pt-20 pb-16 text-center">
        <p className="text-xs font-mono uppercase tracking-widest text-violet-500 mb-4">
          Frontend App 2 · Next.js 15 · JavaScript
        </p>
        <h1 className="text-5xl md:text-6xl font-black text-stone-900 leading-tight mb-6">
          Built to ship.<br />
          <span className="text-violet-600">Wired to scale.</span>
        </h1>
        <p className="text-lg text-stone-500 max-w-2xl mx-auto mb-10">
          Production-grade monorepo: 2 Next.js frontends, 2 Laravel backends, Redis cache layer,
          Nginx proxies, isolated MySQL databases — all running locally with one command.
        </p>
        <div className="flex flex-wrap gap-3 justify-center">
          <a href="http://localhost:3000" className="bg-stone-900 text-white px-6 py-3 rounded-xl font-medium hover:bg-stone-700 transition-colors">
            ← Visit App 1
          </a>
          <a href="http://localhost:8001/api/health" target="_blank" rel="noreferrer"
            className="border border-stone-300 text-stone-700 px-6 py-3 rounded-xl font-medium hover:border-violet-400 hover:text-violet-600 transition-colors">
            API 1 Health
          </a>
          <a href="http://localhost:8002/api/health" target="_blank" rel="noreferrer"
            className="border border-stone-300 text-stone-700 px-6 py-3 rounded-xl font-medium hover:border-violet-400 hover:text-violet-600 transition-colors">
            API 2 Health
          </a>
          <a href="http://localhost:8001/api/redis-demo" target="_blank" rel="noreferrer"
            className="bg-red-500 text-white px-6 py-3 rounded-xl font-medium hover:bg-red-400 transition-colors">
            ⚡ Redis Demo
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
              <p className="text-stone-500 text-sm leading-relaxed">{f.desc}</p>
            </div>
          ))}
        </div>
      </section>

      <footer className="border-t border-stone-200 py-6 text-center text-stone-400 text-sm font-mono">
        Next.js 15.3 · React 19 · Laravel 12 · PHP 8.4 · MySQL 9.1 · Redis 7.4 · Nginx 1.27 · Node 22
      </footer>
    </main>
  );
}
