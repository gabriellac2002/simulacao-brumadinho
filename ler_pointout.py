"""Le icfd_pointout.0001.dat (sondas do ICFD) e mostra tempo, velocidade e pressao.
Uso: python ler_pointout.py [arquivo]   -> imprime tabela e salva sondas.png / sondas.csv
"""
import re, sys, math
f = sys.argv[1] if len(sys.argv) > 1 else "icfd_pointout.0001.dat"
rows = {}  # ponto -> lista (t, x, y, z, vx, vy, vz, p)
t = None
for l in open(f):
    m = re.search(r"at time\s+([-+0-9.Ee]+)", l)
    if m: t = float(m.group(1)); continue
    p = l.split()
    if t is not None and len(p) >= 12 and p[0].isdigit():
        v = list(map(float, p[1:]))
        rows.setdefault(int(p[0]), []).append((t, v[0], v[1], v[2], v[3], v[4], v[5], v[9]))
with open("sondas.csv", "w") as o:
    o.write("ponto,t,x,y,z,vx,vy,vz,|v|,pressao\n")
    for k, r in rows.items():
        for t, x, y, z, vx, vy, vz, pr in r:
            o.write(f"{k},{t},{x},{y},{z},{vx},{vy},{vz},{math.sqrt(vx*vx+vy*vy+vz*vz)},{pr}\n")
print(f"{'t(s)':>7} | " + " | ".join(f"P{k} (x={r[0][1]:.3f} y={r[0][2]:.3f})  |v| m/s   p Pa" for k, r in rows.items()))
n = min(len(r) for r in rows.values())
for i in range(0, n, max(1, n // 40)):
    line = f"{rows[1][i][0]:7.3f} | "
    for k, r in rows.items():
        t, x, y, z, vx, vy, vz, pr = r[i]
        line += f"{math.sqrt(vx*vx+vy*vy+vz*vz):8.3f} {pr:9.1f}  | "
    print(line)
try:
    import matplotlib; matplotlib.use("Agg"); import matplotlib.pyplot as plt
    fig, ax = plt.subplots(2, 1, figsize=(9, 7), sharex=True)
    for k, r in rows.items():
        ax[0].plot([a[0] for a in r], [math.sqrt(a[4]**2+a[5]**2+a[6]**2) for a in r], label=f"P{k} y={r[0][2]:.3f}")
        ax[1].plot([a[0] for a in r], [a[7] for a in r], label=f"P{k} y={r[0][2]:.3f}")
    ax[0].set_ylabel("|velocidade| (m/s)"); ax[1].set_ylabel("pressao (Pa)"); ax[1].set_xlabel("tempo (s)")
    ax[0].legend(); ax[0].grid(True); ax[1].grid(True); fig.tight_layout(); fig.savefig("sondas.png", dpi=120)
    print("salvo: sondas.png, sondas.csv")
except Exception as e:
    print("sem grafico:", e, "- tabela em sondas.csv")
