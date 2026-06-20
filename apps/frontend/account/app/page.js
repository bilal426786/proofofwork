export default function Home() {
  const stats = [
    { label: "Total Users",     value: "12,430", change: "+8.2%"  },
    { label: "Revenue",         value: "$84,200", change: "+12.5%" },
    { label: "Active Sessions", value: "1,024",  change: "+3.1%"  },
    { label: "Uptime",          value: "99.98%", change: "+0.02%" },
  ];

  const services = [
    { name: "Backend API 1",  port: "8001", path: "/api/health",    label: "Health"     },
    { name: "Backend API 2",  port: "8002", path: "/api/health",    label: "Health"     },
    { name: "API 1 Redis",    port: "8001", path: "/api/redis-demo", label: "Redis Demo" },
    { name: "API 2 Redis",    port: "8002", path: "/api/redis-demo", label: "Redis Demo" },
  ];

  const stack = [
    { icon: "▲", label: "Next.js 15.3",   color: "text-white"       },
    { icon: "🐘", label: "Laravel 12",     color: "text-indigo-400"  },
    { icon: "🗄️", label: "MySQL 9.1",      color: "text-blue-400"    },
    { icon: "⚡", label: "Redis 7.4",      color: "text-red-400"     },
    { icon: "🌐", label: "Nginx 1.27",     color: "text-green-400"   },
    { icon: "🐳", label: "Node 22 LTS",    color: "text-cyan-400"    },
  ];

  return (
    <main className="min-h-screen bg-slate-950 text-slate-100 p-8">
      <div className="max-w-6xl mx-auto">

        {/* Header */}
        <div className="mb-10 border-b border-slate-800 pb-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-xs font-mono text-indigo-400 uppercase tracking-widest mb-1">
                Monorepo · Frontend App 1 · Next.js 15 JS
              </p>
              <h1 className="text-4xl font-bold text-white">Command Center</h1>
            </div>
            <span className="flex items-center gap-2 bg-emerald-900/40 text-emerald-400 text-sm px-4 py-2 rounded-full border border-emerald-700">
              <span className="w-2 h-2 bg-emerald-400 rounded-full animate-pulse" />
              Online
            </span>
          </div>
        </div>

        {/* Stats */}
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-10">
          {stats.map((s) => (
            <div key={s.label} className="bg-slate-900 border border-slate-800 rounded-xl p-5">
              <p className="text-slate-500 text-xs uppercase tracking-wider mb-1">{s.label}</p>
              <p className="text-2xl font-bold text-white">{s.value}</p>
              <p className="text-emerald-400 text-sm mt-1">{s.change} this month</p>
            </div>
          ))}
        </div>

        {/* Stack badges */}
        <div className="bg-slate-900 border border-slate-800 rounded-xl p-5 mb-6">
          <h2 className="text-sm font-mono text-slate-400 uppercase tracking-wider mb-4">Stack</h2>
          <div className="flex flex-wrap gap-3">
            {stack.map((s) => (
              <span key={s.label} className={`flex items-center gap-1.5 bg-slate-800 px-3 py-1.5 rounded-lg text-sm font-mono ${s.color}`}>
                <span>{s.icon}</span>
                {s.label}
              </span>
            ))}
          </div>
        </div>

        {/* Services */}
        <div className="bg-slate-900 border border-slate-800 rounded-xl p-6">
          <h2 className="text-lg font-semibold mb-4">Backend Services</h2>
          <div className="space-y-0">
            {services.map((svc) => (
              <div key={svc.name + svc.path} className="flex items-center justify-between py-3 border-b border-slate-800/60 last:border-0">
                <div>
                  <p className="font-medium text-slate-200">{svc.name}</p>
                  <p className="text-slate-500 text-sm font-mono">localhost:{svc.port}{svc.path}</p>
                </div>
                <a
                  href={`http://localhost:${svc.port}${svc.path}`}
                  target="_blank"
                  rel="noreferrer"
                  className="text-xs bg-indigo-600 hover:bg-indigo-500 px-3 py-1.5 rounded-lg transition-colors"
                >
                  {svc.label}
                </a>
              </div>
            ))}
          </div>
        </div>

        <p className="text-center text-slate-700 text-sm mt-8 font-mono">
          Next.js 15 · Laravel 12 · MySQL 9 · Redis 7 · Nginx 1.27 · Node 22
        </p>
      </div>
    </main>
  );
}
