# Research Protocol

The rules that govern *how* `mastery-research` researches and what counts as a good source. Load this when running the skill.

## Source hierarchy (prefer top-down)

Always reach for the highest available tier before settling for a lower one. Prefer **primary sources**.

1. **Official documentation** — the maintainers' own docs.
2. **Standards, RFCs, specs, academic papers** — the normative definition of the thing.
3. **Highly respected books** — canonical, widely cited.
4. **Well-known courses** — university or industry-recognized.
5. **Conference talks** — from maintainers or recognized practitioners.
6. **Articles from recognized practitioners** — named authorities, not anonymous SEO posts.
7. **Market usage & modern industry practice** — what real teams actually do today.

**Never** rest a claim on a single generic blog post. If only blogs cover something, triangulate across several and say so.

## Source selection (exact deliverables)

### Bibliography references (minimum 2)

Select **at least two**; add more when the subject genuinely warrants it. For **each**, fill every field:

- **Title**
- **Author**
- **Publication year**
- **Why this reference matters** — its specific contribution to mastering the subject.
- **What parts are still relevant** — concretely, which chapters/ideas hold up.
- **What parts may be outdated** — concretely, what to read with caution or skip.

### Notorious specialists (minimum 2)

Select **at least two**; add more when the subject genuinely warrants it. For **each**, fill every field:

- **Name**
- **Credentials**
- **Main contributions**
- **Public material available** — books, talks, repos, courses, blog (with where to find it).
- **Why this person is a strong teacher/reference** for this subject.
- **Whether their content is still aligned with the current market** — say so plainly.

## Market validation (be skeptical)

Validate the subject against today's reality. Address each:

- **Current adoption** — who uses it, how widely, growing or shrinking.
- **Modern best practices** — what good looks like in 2020s+ work.
- **Tooling ecosystem** — the tools a competent person actually uses.
- **Common professional use cases** — where it shows up in real jobs.
- **Recent changes** — what shifted lately and why.
- **Outdated practices to avoid** — patterns that were once standard and now hurt.
- **Skills expected from someone competent today** — the real bar.

**Skepticism rule:** if an authority, book, or framework is *famous but outdated*, say so explicitly. Reputation is not currency. There is almost always at least one sacred cow worth flagging — find it.

## Mastery depth rules

Scale the curriculum to the selected level. Each level **includes** the ones below it.

### Deep — strong professional competence
The learner can **use the subject effectively in real projects**. Focus: practical fluency, the common 80% of real work, standard tooling, the mistakes that bite beginners.

### Very Deep — advanced professional ability
The learner can **design, review, optimize, explain, and debug complex situations**. Focus: tradeoffs, non-obvious failure modes, performance, reviewing others' work, architecting solutions.

### Extremely Deep — specialist-level understanding
The learner reaches **specialist depth**. Focus: history, **internals**, deep tradeoffs, advanced patterns, edge cases, current research, architecture, **limitations**, and **future direction**. Explain *why* things are the way they are, not just how to use them.

## Anti-vagueness rules

Every curriculum item must be **concrete and checkable**. Replace fillers with specifics.

| Banned (vague) | Required (concrete) |
|---|---|
| "Learn the basics" | Name the exact concepts, in order, with a one-line outcome each. |
| "Understand advanced concepts" | Name the patterns/internals and *what problem each solves*. |
| "Practice with examples" | Specify the exercise, its input/output, and the success criterion. |

A reader who only had `CONTEXT.md` should be able to teach the subject from it. If a section could be copy-pasted onto any other subject unchanged, it is too vague — rewrite it.
