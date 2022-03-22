<script>
  import router from "page"
  import Trainings from './components/Trainings.svelte'
  import About from './components/About.svelte'
  import Training from './components/Training.svelte'

  let page;
  let params;

  router('/trainings', () => page = Trainings)
  router('/about', () => page = About)
  router('/trainings/:id', (ctx, next) => {
    params = ctx.params
    next()
  }, () => page = Training)

  router.start();
</script>

<main>
  <svelte:component this={page} params={ params } />
</main>

<style>
  main {
    text-align: center;
    padding: 1em;
    max-width: 240px;
    margin: 0 auto;
  }

  @media (min-width: 640px) {
    main {
      max-width: none;
    }
  }
</style>
