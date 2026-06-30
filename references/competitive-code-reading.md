# Competitive Code Reading Patterns

How to efficiently extract design patterns from competitor source code.

## The 30-Minute Protocol

For each competitor, spend at most 30 minutes:
1. **5 min**: Read README for positioning and feature list
2. **10 min**: Find and read the core architecture file (graph.py, main.go, engine.py)
3. **10 min**: Read ONE concrete implementation (not all of them)
4. **5 min**: Extract 3-5 patterns worth adopting

## What to Look For

| Component Type | Pattern to Extract | Example |
|---------------|-------------------|---------|
| **Architecture** | How modules connect | LangGraph StateGraph → our ThreadPool pipeline |
| **Data Model** | State structures | TypedDict with Annotated reducers → our dataclass |
| **Scoring** | Quality/confidence metrics | 0-1.0 confidence per pattern → added to our findings |
| **Pipeline** | Stage management | Stage-based with progress % and resume → our stage_pipeline |
| **API Design** | User-facing interface | `# @param` annotations → our declarative strategy |
| **Risk Control** | Safety boundaries | Engine-managed stopLoss → our backtest engine |

## Real Examples (2026-06-19)

### SkillSpector (NVIDIA 7.4K⭐) → genesisix-hermes

**Read**: `graph.py` (LangGraph workflow), `static_patterns_prompt_injection.py` (one analyzer), `state.py` (state model)

**Extracted**:
1. Modular analyzer pipeline (each category is independent module)
2. Confidence scoring per pattern (0.6-0.95, not just severity)
3. Meta-analyzer for cross-validation (dedup + severity boost)
4. Pydantic models for structured output

**Written**: `analyzer_pipeline.py` (291 lines), verified with self-test

### QuantDinger (8.1K⭐) → Stratapro

**Read**: `docs/examples/dual_ma_with_params.py` (strategy example), `services/backtest.py` (engine)

**Extracted**:
1. Declarative strategy with `# @param` and `# @strategy` annotations
2. Four-way signal model (open_long, open_short, close_long, close_short)
3. Edge detection: `edge()` function for trigger-on-true-only-once
4. Engine-managed risk: stopLoss/takeProfit by engine, not strategy

**Written**: `scripts/backtest_engine.py` (255 lines), self-test: dual MA crossover 252 days, +1.97%

### KrillinAI (10.3K⭐) → ideasphere

**Read**: `internal/service/audio2subtitle.go` (core pipeline), `service/` directory listing

**Extracted**:
1. Stage-based processing with progress percentage per stage
2. Pipeline state serialization for resume (JSON checkpoint)
3. Concurrent segment processing (errgroup pattern)
4. YouTube subtitle extraction as input source

**Written**: `scripts/stage_pipeline.py` (330 lines), self-test: 5-stage pipeline serialization verified

## Anti-Patterns (what NOT to do)

1. **Don't just read READMEs** — you'll get features list, not design patterns
2. **Don't try to read ALL source files** — pick the architecture file + ONE implementation
3. **Don't copy code verbatim** — extract the PATTERN, rewrite in your style
4. **Don't delegate "clone + analyze + improve + push"** — it times out. Break into steps.
5. **Don't report "did competitive analysis" without specifics** — always include line counts and test results
