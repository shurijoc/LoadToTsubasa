<template>
  <div>
    <transition name="fade">
      <section
        v-if="checked"
        class="section">
        <div class="container">
          <div class="columns">
            <div class="column">
              <h3 class="is-size-4">LoadToTsubasa</h3>
              <div class="card">
                <div class="card-content is-flex is-justify-content-space-around">
                  <CurrentTel/>
                  <div class="divider is-vertical"></div>

                  <TotalYes/>

                  <div class="divider is-vertical"></div>

                  <Progress/>
                </div>
              </div>
            </div>
          </div>
          <HowToUse/>
        </div>
      </section>
    </transition>

    <transition name="fade">
      <Splash
          v-if="!checked"
      />
    </transition>
  </div>
</template>

<script lang="ts">
import Vue from 'vue'

export default Vue.extend({
  name: 'IndexPage',
  data () {
    return {
      checked: false,
      height: 0,
      dots: ''
    }
  },
  mounted () {
    this.handleResize()
    window.addEventListener('resize', this.handleResize)
    setTimeout(this.show, 5000)
    setInterval(this.handleDots, 500)
  },
  methods: {
    show () {
      this.checked = true
    },
    handleResize () {
      this.height = window.innerHeight
    },
    handleDots () {
      if (this.dots === '...') {
        this.dots = '.'
      } else {
        this.dots += '.'
      }
    }
  }
})
</script>
