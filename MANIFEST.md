# Manifest

336 skills from 28 plugin bundles, installed into `~/.claude/skills/` by `install.sh`.

## Not included

- **figma** — byte-identical to the figma plugin already installed (v2.2.157).
- **8 skills from `my-personal-skills`** (`docs`, `docx`, `pdf`, `pptx`, `xlsx`,
  `import-memory`, `morning`, `skill-creator`) — they shadow Anthropic built-ins.
- **All hooks.** `claude-mem`, `impeccable` and `superpowers` ship hooks that run
  code automatically; only their skills were taken.

## Renamed

- `ui-ux-pro-max/design-system` → `design-system-pro-max` (clashed with `design/design-system`).

## Licensing

Keep this repository **private**. Most bundles are MIT, but eight ship no licence
file at all, which defaults to all rights reserved:

- `animation-components` — no licence file
- `authoring-motion` — no licence file
- `core-3d-animation` — no licence file
- `design` — no licence file
- `extended-3d-scroll` — no licence file
- `figma` — no licence file
- `meta-skills` — no licence file
- `my-personal-skills` — no licence file

## Skills by source bundle

### animation-components (unlicensed)

  animated-component-libraries animejs lottie-animations react-spring-physics 
  scroll-reveal-libraries 

### authoring-motion (unlicensed)

  blender-web-pipeline rive-interactive spline-interactive substance-3d-texturing 

### claude-mem (Apache)

  agent-cost-report babysit ccs-align cloud-sync design-is do handoff how-it-works 
  knowledge-agent learn-codebase make-plan mem-search mode-creator oh-my-issues pathfinder 
  smart-explore standup timeline-report version-bump weekly-digests what-the wowerpoint 

### core-3d-animation (unlicensed)

  babylonjs-engine gsap-scrolltrigger motion-framer react-three-fiber threejs-webgl 

### cowork-plugin-management (Apache)

  cowork-plugin-customizer create-cowork-plugin 

### design (unlicensed)

  accessibility-review design-critique design-handoff design-system research-synthesis 
  user-research ux-copy 

### emil-kowalski-skills (MIT)

  animate animate-expo animation-vocabulary apple-design ask-sonner emil-design-eng 
  find-animation-opportunities improve-animations mobile-native pick-ui-library prototype 
  review-animations write-swift 

### extended-3d-scroll (unlicensed)

  aframe-webxr barba-js lightweight-3d-effects locomotive-scroll pixijs-2d playcanvas-engine 

### garden-skills (MIT)

  beautiful-article gpt-image-2 kb-retriever web-design-engineer web-video-presentation 

### impeccable (Apache)

  impeccable 

### interaction-design (MIT)

  animation-principles conversational-ux doherty-threshold error-handling-ux 
  feedback-patterns fitts-law form-design gesture-patterns hicks-law interfaces-that-feel 
  jakobs-law loading-states micro-interaction-spec millers-law navigation-patterns 
  onboarding-design peak-end-rule search-ux serial-position-effect state-machine teslers-law 
  zeigarnik-effect 

### mengto-3d (MIT)

  3d-cloth-material 3d-falling-leaves 3d-four-seasons 3d-high-poly-models 
  3d-high-resolution-textures 3d-metal-material 3d-orbit-inspect-demo 3d-paper-material 
  3d-retina-resolution 3d-sky-background 3d-sky-rays 3d-ultra-realistic-water 
  3d-underwater-god-rays 3d-virtual-tour 3d-wood-lighting-scorecard 3d-wood-material 

### mengto-codex (MIT)

  article-prompts-to-skills audit-reference-originality audit-verify-explain-grade-5 
  browser-video-recording build-daily-inspiration-sites codex-gpt-image-2-5-flare 
  daily-ui-inspiration-capture elevenlabs-tts generate-reference-inspired-brand-worlds 
  html-to-interaction-prompts implement-fog-of-war iterate-until-verified 
  optimize-web-animations performance-profiling publish-project-to-github 
  stitched-full-page-capture video-to-superprompt web-technique-to-skill write-like-meng-on-x 
  x-bookmark-quote-posts 

### mengto-game-development (MIT)

  author-game-levels build-game-audio-feedback build-game-camera-controls 
  build-game-changelog build-game-inventory build-game-map-editor build-game-monster-system 
  build-hybrid-game-assets build-isometric-arpg build-mobile-threejs-games 
  build-rigged-game-assets build-threejs-enemy-systems build-vesperfall-review-assets 
  create-game-vfx design-action-combat design-game-encounters fire-smoke-skill-vfx 
  game-dev-combat-animation game-dev-combat-skill-polish ice-frost-skill-vfx 
  lightning-energy-skill-vfx optimize-threejs-games ship-web-games test-playable-web-games 
  tune-enemy-ai water-crystal-skill-vfx 

### mengto-illustration (MIT)

  illustration-bold-pop illustration-flat illustration-flat-with-black 
  illustration-framed-panel illustration-grainy-gouache illustration-halftone-line 
  illustration-ink-sketch illustration-isometric-mono illustration-line-interior 
  illustration-one-line illustration-outlined-cartoon illustration-teal-spot 
  illustration-two-colour-brush illustration-vintage-emblem 

### mengto-media-assets (MIT)

  aura-asset-images unsplash-asset-images 

### mengto-ui-quality (MIT)

  audit-ai-design-slop design-first-ui-prompting no-ai-design-slop 

### mengto-web-design-extras (MIT)

  fire-paper-loader horizontal-scroll-scenes paper-cinder-transition 

### mengto-web-design (MIT)

  add-mouse-driven-orbit add-shader-cursor-trail agency-grid-layout-minimal 
  ambient-section-particles animation-on-scroll animation-systems atmosphere-background 
  background-grid-webgl beam-glow-states beautiful-shadows blue-cloudy-clean-modern 
  blue-laser-clean-glass-layout book-serif-index bright-green-tech-system-webgl 
  build-awwwards-quality-sites build-interactive-particle-trail build-threejs-scroll-worlds 
  build-wireframe-scan-reveal cinematic-gsap-lenis-motion-system 
  cinematic-scroll-storytelling clean-minimal-beige-light-mode cobejs company-logos 
  container-lines corner-diagonals corner-lasers css-alpha-masking css-border-gradient 
  dark-blue-contrasting-clean dark-glass-clean-layout dither-background 
  dither-laser-dark-mode documentary-brutalist-agency editorial-portfolio-chapters 
  editorial-service-booking editorial-tech falling-leaves framed-grid-layout 
  framed-tech-dark-border-gradient funky-purple-container-tech glass-dark-mode-clock 
  glass-dark-ui globe-gl globe-particles gooey-blob-system gsap 
  gsap-scrolltrigger-storytelling high-contrast-skeuomorphic-clean image-first-grid-layout 
  landing-page light-mode-paper-technical liquid-metal-border marquee-loop masked-reveal 
  matterjs mesh-gradient-dark-blue-clean nested-container-clean-agency 
  nested-container-frames number-details operational-enterprise-ai orange-clean-paper-saas 
  pointer-trail-emitter pricing-page product-proof-saas progressive-blur reveal-hover-effect 
  scroll-progress-timeline scroll-scrubbed-visual-sequence scroll-scrubbed-word-reveal 
  scroll-world-storytelling shaders-cursor-ripples skeuomorphic-ui solar-duotone-bold 
  split-layout-technical staggered-word-reveal tailwindcss tech-green-dark-mode-modern 
  technical-wireframe-info-layout thinking-orbs threejs threejs-landscape threejs-towers 
  threejs-weather unicorn-studio vantajs webgl-3d-object webgl-landing-steering webgl-laser 

### mengto-workflow (MIT)

  workflow-progress-screenshots workflow-score-to-target workflow-ship-change 
  workflow-threads-manager 

### meta-skills (unlicensed)

  modern-web-design web3d-integration-patterns 

### my-personal-skills (unlicensed)

  blender-assembly brag brag-slim cli-serve doc-coauthoring docs docx frontend-design 
  google-workspace hallmark import-memory landing-page-design morning omni-auth 
  omni-inference openmontage pdf pptx remotion-motion-graphics scroll-craft scroll-world 
  skill-creator web-artifacts-builder xlsx 

### no-ai-slop (MIT)

  no-ai-slop 

### superpowers (MIT)

  brainstorming diagnosing-superpowers dispatching-parallel-agents executing-plans 
  finishing-a-development-branch receiving-code-review requesting-code-review 
  subagent-driven-development systematic-debugging test-driven-development 
  using-git-worktrees using-superpowers verification-before-completion writing-plans 
  writing-skills 

### tastemaker (MIT)

  tastemaker 

### ui-design (MIT)

  aesthetic-usability color-system dark-mode-design data-visualization illustration-style 
  law-of-closure law-of-common-region law-of-continuity law-of-figure-ground law-of-proximity 
  law-of-similarity layout-grid platform-conventions readable-measure responsive-design 
  spacing-system typography-scale visual-hierarchy von-restorff-effect 

### ui-ux-pro-max (MIT)

  banner-design brand design design-system slides ui-styling ui-ux-pro-max 

### visual-critique (MIT)

  critique-affordance critique-brand-consistency critique-color critique-composition 
  critique-information-density critique-typography critique-visual-hierarchy 

