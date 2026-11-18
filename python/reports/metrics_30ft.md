# Pronóstico de inundación — Mississippi River at Baton Rouge (umbral 30 ft)

Generado por `python/train.py`. Datos diarios USGS 07374000 (nivel), 07289000 (caudal en Vicksburg),
07022000 (caudal en Thebes) y lluvia diaria de KBTR.
Split cronológico: train ≤ 2016-12-31, validación ≤ 2020-12-31, test después.

**F1 inicio** = F1 solo en días en que el río NO está ya inundado (predecir que la inundación
continúa es trivial; esta métrica mide si el modelo anticipa una inundación nueva).
**Eventos avisados** = inicios de inundación con al menos una alarma en los H días previos.

## Horizonte 1 día(s)

| Modelo | F1 inicio (val) | P / R / F1 inicio (test) | F1 global (test) | Eventos avisados (test) | Anticipación mediana | Falsas alarmas/año |
|---|---|---|---|---|---|---|
| persistencia | 0.00 | 0.00 / 0.00 / 0.00 | 0.98 | 0/9 | 0 d | 0.0 |
| tendencia | 0.94 | 1.00 / 0.67 / 0.80 | 0.99 | 6/9 | 1 d | 0.0 |
| logistica | 0.67 | 0.50 / 0.44 / 0.47 | 0.97 | 4/9 | 1 d | 0.5 |
| MLP solo local | 1.00 | 0.86 / 0.67 / 0.75 | 0.99 | 6/9 | 1 d | 0.2 |
| MLP | 1.00 | 0.83 / 0.56 / 0.67 | 0.99 | 5/9 | 1 d | 0.2 |
| MLP Q8.24 (FPGA) | 0.94 | 0.83 / 0.56 / 0.67 | 0.99 | 5/9 | 1 d | 0.2 |

Configuración MLP elegida en validación: `{'hidden': 4, 'l2': 0.001, 'seed': 0}`; concordancia float vs Q8.24 en test: 1.0000 (máx. |Δscore| = 0.0115).

## Horizonte 3 día(s)

| Modelo | F1 inicio (val) | P / R / F1 inicio (test) | F1 global (test) | Eventos avisados (test) | Anticipación mediana | Falsas alarmas/año |
|---|---|---|---|---|---|---|
| persistencia | 0.00 | 0.00 / 0.00 / 0.00 | 0.95 | 0/9 | 0 d | 0.0 |
| tendencia | 0.84 | 0.66 / 0.78 / 0.71 | 0.96 | 9/9 | 3 d | 1.0 |
| logistica | 0.87 | 0.75 / 0.44 / 0.56 | 0.96 | 6/9 | 2 d | 0.5 |
| MLP solo local | 0.96 | 0.81 / 0.93 / 0.86 | 0.98 | 9/9 | 3 d | 0.7 |
| MLP | 0.92 | 0.79 / 0.85 / 0.82 | 0.98 | 9/9 | 3 d | 0.5 |
| MLP Q8.24 (FPGA) | 0.92 | 0.79 / 0.85 / 0.82 | 0.98 | 9/9 | 3 d | 0.5 |

Configuración MLP elegida en validación: `{'hidden': 6, 'l2': 0.0001, 'seed': 2}`; concordancia float vs Q8.24 en test: 1.0000 (máx. |Δscore| = 0.0103).

## Horizonte 5 día(s)

| Modelo | F1 inicio (val) | P / R / F1 inicio (test) | F1 global (test) | Eventos avisados (test) | Anticipación mediana | Falsas alarmas/año |
|---|---|---|---|---|---|---|
| persistencia | 0.00 | 0.00 / 0.00 / 0.00 | 0.94 | 0/9 | 0 d | 0.0 |
| tendencia | 0.74 | 0.46 / 0.75 / 0.57 | 0.90 | 9/9 | 5 d | 1.5 |
| logistica | 0.85 | 0.78 / 0.57 / 0.66 | 0.95 | 8/9 | 3 d | 0.7 |
| MLP solo local | 0.82 | 0.68 / 0.77 / 0.72 | 0.96 | 9/9 | 4 d | 1.2 |
| MLP | 0.89 | 0.83 / 0.80 / 0.81 | 0.98 | 9/9 | 4 d | 0.7 |
| MLP Q8.24 (FPGA) | 0.89 | 0.83 / 0.80 / 0.81 | 0.98 | 9/9 | 4 d | 0.7 |

Configuración MLP elegida en validación: `{'hidden': 4, 'l2': 0.001, 'seed': 2}`; concordancia float vs Q8.24 en test: 1.0000 (máx. |Δscore| = 0.0079).

## Horizonte 7 día(s)

| Modelo | F1 inicio (val) | P / R / F1 inicio (test) | F1 global (test) | Eventos avisados (test) | Anticipación mediana | Falsas alarmas/año |
|---|---|---|---|---|---|---|
| persistencia | 0.00 | 0.00 / 0.00 / 0.00 | 0.92 | 0/9 | 0 d | 0.0 |
| tendencia | 0.72 | 0.51 / 0.67 / 0.58 | 0.89 | 9/9 | 5 d | 1.2 |
| logistica | 0.83 | 0.79 / 0.63 / 0.70 | 0.94 | 9/9 | 4 d | 0.7 |
| MLP solo local | 0.77 | 0.71 / 0.75 / 0.73 | 0.96 | 9/9 | 5 d | 1.5 |
| MLP | 0.83 | 0.74 / 0.70 / 0.72 | 0.94 | 9/9 | 4 d | 0.9 |
| MLP Q8.24 (FPGA) | 0.83 | 0.74 / 0.70 / 0.72 | 0.94 | 9/9 | 4 d | 0.9 |

Configuración MLP elegida en validación: `{'hidden': 4, 'l2': 0.01, 'seed': 0}`; concordancia float vs Q8.24 en test: 1.0000 (máx. |Δscore| = 0.0068).
