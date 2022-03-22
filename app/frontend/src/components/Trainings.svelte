<script>
  import page from 'page'

  let trainings = [];
  let name;

  fetch('http://localhost:9292/api/v1/trainings')
    .then(response => response.json())
    .then(data => trainings = data)

  async function handleStartTraining() {
    const training = { name }

    const response = await fetch('http://localhost:9292/api/v1/trainings', {
      method: 'POST',
      mode: 'cors',
      credentials: 'omit',
      cache: 'no-cache',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ training })
    });

    const newTraining = await response.json()
    trainings = [...trainings, newTraining]

    page(`/trainings/${newTraining.id}`)
  }

  async function handleTrainingClick( id ) {
    page(`/trainings/${id}`)
  }
</script>

<div class="container">
  <table>
    <thead>
      <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Date</th>
      </tr>
    </thead>
    <tbody>
      {#each trainings as training}
        <tr class="training" on:click={() => handleTrainingClick(training.id)}>
          <td>{training.id}</td>
          <td>{training.name}</td>
          <td>{training.started_at}</td>
        </tr>
      {/each}
    </tbody>
  </table>

  <div>
    <input bind:value={name} name="name" type="text" placeholder="Name">
    <button on:click={handleStartTraining} type="submit">Start</button>
  </form>
</div>

<style>
  .container {
    display: flex;
    flex-direction: column;
  }

  .training {
    cursor: pointer;
  }
</style>
