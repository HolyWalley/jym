<script>
  let training;
  let excercises = [];
  let sets = [];

  export let params;

  fetch(`http://localhost:9292/api/v1/trainings/${params.id}`)
    .then(response => response.json())
    .then(data => training = data)

  fetch(`http://localhost:9292/api/v1/trainings/${params.id}/sets`)
    .then(response => response.json())
    .then(data => sets = data)

  fetch(`http://localhost:9292/api/v1/excercises`)
    .then(response => response.json())
    .then(data => excercises = data)

  let repsCount;
  let weightValue;
  let excercise;

  async function handleSetLog() {
    const trainingSet = {
      reps: repsCount,
      weight: weightValue,
      excercise_id: excercise.id
    }

    const response = await fetch(`http://localhost:9292/api/v1/trainings/${params.id}/sets`, {
      method: 'POST',
      mode: 'cors',
      credentials: 'omit',
      cache: 'no-cache',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ training_set: trainingSet })
    })

    sets = [ ...sets, await response.json() ]
  }
</script>

<div class="container">
  <h1>{ training?.name }</h1>
  <h3>Sets</h3>
  <table>
    <thead>
      <tr>
        <th>ID</th>
        <th>Reps</th>
        <th>Weight</th>
        <th>Excercise</th>
      </tr>
    </thead>
    <tbody>
      {#each sets as set}
        <tr>
          <td>{set.id}</td>
          <td>{set.reps}</td>
          <td>{set.weight}</td>
          <td>{set.excercise.name}</td>
        </tr>
      {/each}
    </tbody>
  </table>

  <div>
    <input bind:value={repsCount} placeholder="Reps" />
    <input bind:value={weightValue} placeholder="Weight" />
    <select bind:value={excercise} required>
      <option disabled>Excercise</option>
      {#each excercises as excercise}
        <option value={excercise}>{excercise.name}</option>
      {/each}
    </select>
    <button on:click={ handleSetLog }>Log</button>
  </div>
</div>

<style>
  .container {
    display: flex;
    flex-direction: column;
  }
</style>
