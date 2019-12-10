import {Socket} from "phoenix";

let socket = new Socket("/socket");
socket.connect();

let channel = socket.channel("room:lobby", {});
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) });

const chatInput = document.getElementById('message-texteditor');
const messagesContainer = document.getElementById("messages");

chatInput.addEventListener("keypress", event => {
  if(event.keyCode === 13) {
    channel.push("new_msg", {body: chatInput.value});
    chatInput.value = "";
  }
});

channel.on("new_msg", payload => {
  const messageItem = document.createElement("p");
  const current_datetime = new Date();
  const dateFormated =
    current_datetime.getFullYear() + "-" +
    (current_datetime.getMonth() + 1) + "-" +
    current_datetime.getDate() + " " +
    current_datetime.getHours() + ":" +
    current_datetime.getMinutes() + ":" +
    current_datetime.getSeconds();

  messageItem.setAttribute('style', 'margin-bottom: 0');
  messageItem.innerText = `[${dateFormated}] ${payload.body}`;
  messagesContainer.appendChild(messageItem);
})

export default socket;
