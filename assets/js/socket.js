import {Socket} from "phoenix";

const socket = new Socket("/socket");
socket.connect();

const channel = socket.channel("room:lobby");
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) });

const chatInput = document.getElementById('message-texteditor');
const messagesContainer = document.getElementById("messages");
const user_id = document.getElementById('user-id-value');

chatInput.addEventListener("keypress", event => {
  if(event.keyCode === 13) {
    channel.push("new_msg", {body: chatInput.value, user_id: user_id.value});
    chatInput.value = "";
  }
});

channel.on("new_msg", (payload) => {
  console.log(payload)
  const messageItem = document.createElement("p");
  const current_datetime = new Date();

  messageItem.setAttribute('style', 'margin-bottom: 0');

  const template = `
    <p>
      <span style="font-size:12px;color: gray">[10/03/2019]</span>
      <i style="font-weight: bold">${payload.body}</i>
    </p>
  `;

  messageItem.innerHTML = template;
  messagesContainer.appendChild(messageItem);
})

export default socket;
