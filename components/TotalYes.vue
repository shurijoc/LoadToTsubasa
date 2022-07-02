<template>
  <div class="content">
    <section class="section">
      <div class="container">
        <div class="progress-circle is-success" value="100" max="100">
          <div class="progress-inner">
            <p class="mb-0">
              <span class="is-size-2">{{ totalYes }}</span>
              <span class="is-size-6">人</span>
            </p>
            <p class="is-size-6 has-text-grey">本田翼の数</p>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
export default {
  name: 'TotalYes',
  data () {
    return {
      totalYes: 10,
    }
  },
}
</script>
