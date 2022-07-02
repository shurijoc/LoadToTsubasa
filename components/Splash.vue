<template>
  <div
      :style="`height: ${height}px;`"
      class="if-full has-background-success is-flex is-justify-content-center is-align-items-center"
    >
    <div>
      <h1 class="title has-text-white">本田翼の電話番号を知りたいがために総当りで電話をかけるサイトです{{dots}}</h1>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Splash',
  data () {
    return {
      height: 0,
      dots: ''
    }
  },
  props: {
    checked: {
      type: Boolean,
      default: false
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
      this.$emit('showDashboard');
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
}
</script>
