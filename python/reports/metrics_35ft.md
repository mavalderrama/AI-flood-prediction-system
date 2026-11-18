# Pronóstico de inundación — Mississippi River at Baton Rouge (umbral 35 ft)

Generado por `python/train.py`. Datos diarios USGS 07374000 (nivel), 07289000 (caudal en Vicksburg),
07022000 (caudal en Thebes) y lluvia diaria de KBTR.
Split cronológico: train ≤ 2016-12-31, validación ≤ 2020-12-31, test después.

**F1 inicio** = F1 solo en días en que el río NO está ya inundado (predecir que la inundación
continúa es trivial; esta métrica mide si el modelo anticipa una inundación nueva).
**Eventos avisados** = inicios de inundación con al menos una alarma en los H días previos.

## Horizonte 1 día(s)

| Modelo | F1 inicio (val) | P / R / F1 inicio (test) | F1 global (test) | Eventos avisados (test) | Anticipación mediana | Falsas alarmas/año |
|---|---|---|---|---|---|---|
| persistencia | 0.00 | 0.00 / 0.00 / 0.00 | 0.95 | 0/4 | 0 d | 0.0 |
| tendencia | 1.00 | 0.50 / 0.75 / 0.60 | 0.97 | 3/4 | 1 d | 0.2 |
| logistica | 0.60 | 0.20 / 1.00 / 0.33 | 0.91 | 4/4 | 1 d | 1.0 |
| MLP solo local | 1.00 | 0.67 / 1.00 / 0.80 | 0.98 | 4/4 | 1 d | 0.3 |
| MLP | 1.00 | 0.36 / 1.00 / 0.53 | 0.95 | 4/4 | 1 d | 0.5 |
| MLP Q8.24 (FPGA) | 1.00 | 0.36 / 1.00 / 0.53 | 0.95 | 4/4 | 1 d | 0.5 |

Configuración MLP elegida en validación: `{'hidden': 4, 'l2': 0.001, 'seed': 0}`; concordancia float vs Q8.24 en test: 1.0000 (máx. |Δscore| = 0.0105).

## Horizonte 3 día(s)

| Modelo | F1 inicio (val) | P / R / F1 inicio (test) | F1 global (test) | Eventos avisados (test) | Anticipación mediana | Falsas alarmas/año |
|---|---|---|---|---|---|---|
| persistencia | 0.00 | 0.00 / 0.00 / 0.00 | 0.91 | 0/4 | 0 d | 0.0 |
| tendencia | 0.87 | 0.50 / 1.00 / 0.67 | 0.90 | 4/4 | 3 d | 0.7 |
| logistica | 0.88 | 0.30 / 0.92 / 0.45 | 0.87 | 4/4 | 3 d | 1.4 |
| MLP solo local | 1.00 | 0.43 / 1.00 / 0.60 | 0.91 | 4/4 | 3 d | 1.5 |
| MLP | 0.96 | 0.32 / 0.92 / 0.48 | 0.87 | 4/4 | 3 d | 1.0 |
| MLP Q8.24 (FPGA) | 0.96 | 0.32 / 0.92 / 0.48 | 0.87 | 4/4 | 3 d | 1.0 |

Configuración MLP elegida en validación: `{'hidden': 6, 'l2': 0.001, 'seed': 2}`; concordancia float vs Q8.24 en test: 1.0000 (máx. |Δscore| = 0.0118).

## Horizonte 5 día(s)

| Modelo | F1 inicio (val) | P / R / F1 inicio (test) | F1 global (test) | Eventos avisados (test) | Anticipación mediana | Falsas alarmas/año |
|---|---|---|---|---|---|---|
| persistencia | 0.00 | 0.00 / 0.00 / 0.00 | 0.87 | 0/4 | 0 d | 0.0 |
| tendencia | 0.89 | 0.44 / 0.95 / 0.60 | 0.84 | 4/4 | 5 d | 1.2 |
| logistica | 0.93 | 0.33 / 0.85 / 0.47 | 0.83 | 4/4 | 4 d | 1.4 |
| MLP solo local | 0.90 | 0.32 / 1.00 / 0.48 | 0.82 | 4/4 | 5 d | 2.0 |
| MLP | 0.95 | 0.39 / 0.90 / 0.55 | 0.87 | 4/4 | 5 d | 1.0 |
| MLP Q8.24 (FPGA) | 0.95 | 0.39 / 0.90 / 0.55 | 0.87 | 4/4 | 5 d | 1.0 |

Configuración MLP elegida en validación: `{'hidden': 4, 'l2': 0.001, 'seed': 0}`; concordancia float vs Q8.24 en test: 1.0000 (máx. |Δscore| = 0.0096).

## Horizonte 7 día(s)

| Modelo | F1 inicio (val) | P / R / F1 inicio (test) | F1 global (test) | Eventos avisados (test) | Anticipación mediana | Falsas alarmas/año |
|---|---|---|---|---|---|---|
| persistencia | 0.00 | 0.00 / 0.00 / 0.00 | 0.84 | 0/4 | 0 d | 0.0 |
| tendencia | 0.80 | 0.39 / 0.89 / 0.54 | 0.75 | 4/4 | 6 d | 1.2 |
| logistica | 0.93 | 0.26 / 0.89 / 0.40 | 0.73 | 4/4 | 6 d | 1.9 |
| MLP solo local | 0.83 | 0.29 / 1.00 / 0.45 | 0.76 | 4/4 | 7 d | 2.6 |
| MLP | 0.92 | 0.24 / 0.89 / 0.38 | 0.72 | 4/4 | 6 d | 1.9 |
| MLP Q8.24 (FPGA) | 0.92 | 0.24 / 0.93 / 0.39 | 0.72 | 4/4 | 7 d | 1.9 |

Configuración MLP elegida en validación: `{'hidden': 4, 'l2': 0.01, 'seed': 0}`; concordancia float vs Q8.24 en test: 0.9990 (máx. |Δscore| = 0.0070).
