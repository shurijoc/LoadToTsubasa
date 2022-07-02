<template>
  <div class="content is-flex is-align-items-center	is-justify-content-center is-flex-flow-column">
    <p class="is-size-5 has-text-grey">現在の荷電状況</p>
    <p class="is-size-3">
      <i class="fa-solid fa-phone" :class="phoneIconClass"></i>
      {{ phoneNumber }}
    </p>
  </div>
</template>

<script>
export default {
  name: 'CurrentTel',
  data () {
    return {
      isCalling: false,
      phoneNumber: "080-0000-0000"
    }
  },
  computed: {
    phoneIconClass() {
      if (this.isCalling) {
        return 'fa-shake'
      } else {
        return ''
      }
    },
  },
  methods: {
    changeIsCalling() {
      this.isCalling = !this.isCalling
      return
    }
  },
  created () {
    setInterval(this.changeIsCalling, 3000);
  },
}
</script>
