<template>
  <div>
    <ul>
      <li v-for="(message, key) in messages" :key="key">{{message}}</li>
    </ul>
    <input v-model="chatMessage" />
    <button @click="sendMessage()">Submit</button>
  </div>
</template>

<script>
import {Socket} from "phoenix"

export default {
  data() {
    return {
      chatMessage: "",
      channel: null,
      messages: []
    }
  },
  created() {
    let socket = new Socket("/socket", {params: {token: window.userToken}})
    socket.connect()

    this.channel = socket.channel("room:lobby", {})
    this.channel.join()
      .receive("ok", resp => { console.log("Joined successfully in Vue", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })

    this.channel.on('shout', payload => this.messages.push(payload.message))
  },
  methods: {
    sendMessage() {
      if (this.chatMessage) {
        this.channel.push('shout', { message: this.chatMessage })
      }
    }
  }

  
}
</script>