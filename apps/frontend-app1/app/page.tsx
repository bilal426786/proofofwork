export default function Home() {
  const stats = [
    { label: "Total Users", value: "12,430", change: "+8.2%" },
    { label: "Revenue", value: "$84,200", change: "+12.5%" },
    { label: "Active Sessions", value: "1,024", change: "+3.1%" },
    { label: "Uptime", value: "99.98%", change: "+0.02%" },
  ];

  return (
    <main className="min-h-screen bg-slate-900 text-slate-100 p-8">
      <div className="max-w-6xl mx-auto">
        {/* Header */}
        <div className="mb-10 border-b border-slate-700 pb-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-xs font-mono text-indigo-400 uppercase tracking-widest mb-1">Monorepo · Frontend App 1</p>
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
            <div key={s.label} className="bg-slate-800 border border-slate-700 rounded-xl p-5">
              <p className="text-slate-400 text-xs uppercase tracking-wider mb-1">{s.label}</p>
              <p className="text-2xl font-bold text-white">{s.value}</p>
              <p className="text-emerald-400 text-sm mt-1">{s.change} this month</p>
            </div>
          ))}
        </div>

        {/* API Status */}
        <div className="bg-slate-800 border border-slate-700 rounded-xl p-6">
          <h2 className="text-lg font-semibold mb-4">Backend Services</h2>
          <div className="space-y-3">
            {[
              { name: "Backend API 1 (Laravel)", port: "8001", path: "/api/health" },
              { name: "Backend API 2 (Laravel)", port: "8002", path: "/api/health" },
            ].map((svc) => (
              <div key={svc.name} className="flex items-center justify-between py-3 border-b border-slate-700/50 last:border-0">
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
                  Ping
                </a>
              </div>
            ))}
          </div>
        </div>

        <p className="text-center text-slate-600 text-sm mt-8 font-mono">
          Next.js 15 · App Router · Tailwind CSS · Docker
        </p>
      </div>
    </main>
  );
}
