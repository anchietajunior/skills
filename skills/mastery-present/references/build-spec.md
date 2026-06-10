# Build Spec

How to turn a `CONTEXT.md` (21 sections, written by `mastery-research`) into the single
`index.html` by filling `templates/index.template.html`. Load this when the skill runs.

The template owns the **design**; this spec owns the **content rules**. Never restyle the
template, never add external dependencies, never ship placeholder text.

---

## 1. CONTEXT.md → HTML section map

`CONTEXT.md`'s English headers are the contract. Map them onto the template's sections:

| Template section (`id`)        | Fed by CONTEXT section(s)                                   |
|--------------------------------|------------------------------------------------------------|
| Hero                           | §1 Subject Overview · §2 Starting Point · §3 Mastery Level  |
| What you'll master             | §3 (target capability) · §12 Knowledge Map (headline scope) |
| How to study this guide        | §4 Learning Philosophy                                     |
| Prerequisites                  | §2 User Starting Point                                     |
| Foundations                    | §12.1 Foundations                                         |
| Core concepts                  | §12.2 Core Concepts                                       |
| Intermediate concepts          | §12.3 Intermediate Concepts                               |
| Advanced concepts              | §12.4 Advanced Concepts                                   |
| Expert concepts                | §12.5 Expert · §12.6 History · §12.7 Ecosystem · §12.8 Future |
| Mental models                  | §14 Mental Models                                         |
| Common mistakes                | §15 Misconceptions · §11 Outdated/Dangerous               |
| Real-world applications        | §16 Applications · §8 Market · §9 Still-relevant · §10 Needs-context |
| Practice exercises             | §17 Exercises · §18 Suggested Projects                    |
| Capstone project               | §19 Capstone                                              |
| Mastery checklist              | §20 Mastery Checklist                                     |
| Final retention plan           | §13 Roadmap (revisit cadence) → spaced recall + final proof |
| Sources & further study        | §6 Bibliography · §7 Specialists · §21 References          |

§5 (Source Hierarchy), §9, §10 inform tone and caveats throughout; weave named specialists
(§7) and books (§6) into the body where they earned the idea, not only into Sources.

If a CONTEXT section is empty or missing, do not invent it — note the gap to the user at the
end (see SKILL.md final response) and either omit that template section or keep it minimal.

---

## 2. Depth scaling (from CONTEXT §3)

Each level **includes** the ones below it. Respect the level — do not pad a Deep guide with
internals it doesn't need, and do not starve an Extremely Deep guide of them.

- **Deep** — practical professional competence. Keep Foundations → Intermediate rich;
  **you may delete** the *Advanced* and *Expert* sections (and their TOC `<li>`s). Focus on
  correct usage, the common 80%, standard tooling, beginner-biting mistakes.
- **Very Deep** — keep *Advanced* (tradeoffs, failure modes, performance, reviewing others'
  work, architecture). You may keep *Expert* thin or drop it.
- **Extremely Deep** — keep **all** sections. Expert must carry history (§12.6), internals,
  edge cases, limitations, competing approaches, and future direction (§12.8). Explain *why*,
  not just *how*.

When you remove a section, also remove its `<li>` from `#tocSource` so anchors don't break.

---

## 3. Per-concept teaching pattern

Every important concept (each named topic in §12.x) becomes one `.concept` block. The full
pattern lives in the template's `<!-- EXAMPLE -->`. Use the subsections that add value, but
**every concept must include all four** of:

1. **Explanation** — simple first, then technical if the level needs it. Jargon defined inline.
2. **Practical example** — real and specific to the subject, in a `.code-block` when it's code.
3. **A common mistake** — in a `.callout-warning`. The exact wrong turn + the fix.
4. **An exercise** — in an `.exercise-card`, with input, expected output, and a "Done when:" line.

Optional, when they earn their place: *Why it matters*, *Mental model / analogy*, *Tradeoffs*,
*Reflection questions*. Don't apply subsections mechanically — a one-paragraph concept with an
example and a mistake beats a ten-header skeleton.

**Teach incrementally.** Each concept connects to an earlier one ("recall X from Foundations —
this extends it"). Never introduce a term you haven't defined.

---

## 4. Learning-UX requirements

The page must keep the reader active, not passive.

- **Study instructions** (How to study section): reading order, one section per sitting,
  recall-before-reread. State plainly that re-reading feels productive but active recall is
  what sticks.
- **Reading rhythm**: break long sections with `<h3>`s and whitespace; no walls of text.
- **Checkpoints**: after Foundations, Core, and each heavy section, add a `.checkpoint` with
  the three questions — *Can you explain it in your own words? Apply it without looking? Say
  when it's the wrong tool?* — adapted to that section's content.
- **Active recall**: phrase checkpoint and reflection prompts as questions that force retrieval,
  not "review the above".
- **Deliberate practice**: exercises require *doing/building/explaining*, never "read more".
- **Final proof of mastery**: the retention section ends with ONE concrete task (build / explain
  / debug / teach) that proves understanding. Keep the template's closing line verbatim:
  *"You are not done when you finish reading. You are done when you can explain, apply, debug
  and teach this without the guide."*

---

## 5. Component cheatsheet

Use the bundled classes; don't invent new ones.

| Need | Class | Notes |
|------|-------|-------|
| Neutral aside | `.callout` | generic note |
| Pitfall / outdated practice | `.callout-warning` | one per real trap; §11 sacred cow goes here |
| Key intuition | `.callout-insight` | the load-bearing idea |
| Boxed task in prose | `.callout-exercise` | lightweight; for full tasks prefer `.exercise-card` |
| Self-test gate | `.checkpoint` | bulleted recall questions |
| Standalone exercise | `.exercise-card` | `.tag` + `<h4>` + task + `.meta` "Done when:" |
| Self-assessment list | `.mastery-checklist` | "I can …" statements |
| Code | `.code-block` (block) / `<code>` (inline) | wrap comments in `<span class="cmt">` |

Always give a callout a `.callout__label`. Keep contrast accessible (the palette already is).

---

## 6. Hero tokens

Fill these in the template: `{{LANG}}` (html lang: `en` / `pt-br`), `{{SUBJECT_TITLE}}`,
`{{SUBJECT_LEDE}}` (one or two sentences: what it is + the end capability), `{{MASTERY_LEVEL}}`,
`{{STARTING_POINT}}` (e.g. "absolute zero" / "some experience"), `{{SECTION_COUNT}}` (count the
sections you kept), `{{READING_TIME}}` (rough estimate, e.g. "45 min"). Search the file for `{{`
and confirm none remain.

---

## 7. Anti-slop quality bar (run before delivering)

- [ ] Zero `{{TOKENS}}`, zero `<!-- FILL -->` / `<!-- EXAMPLE -->` comments, zero placeholder text.
- [ ] Every `.concept` has explanation + example + mistake + exercise.
- [ ] Every code example is real and specific to *this* subject — never `foo()/bar()` filler.
- [ ] At least one outdated practice from §11 is named in Common mistakes.
- [ ] Depth matches §3; removed sections are also removed from the TOC.
- [ ] Every TOC anchor resolves to an existing `id`; nothing dead.
- [ ] Reads like a calm long-form essay, not a landing page: no hype, no motivational filler,
      no emoji-as-decoration, no giant card grids.
- [ ] Opens correctly as a single self-contained file (no external requests).
- [ ] Could a learner reach the stated mastery level using only this page? If not, deepen.

A section that could be pasted onto any other subject unchanged is too vague — rewrite it.
