// Write your JavaScript code.
const connection = new signalR.HubConnectionBuilder()
    .withUrl("/chatHub")
    .configureLogging(signalR.LogLevel.Information)
    .build();

connection.on("ReceiveMessage", (user, message) => {
    const encodedMsg = user + "说：" + message;
    if (message == "ok") {
        window.location.reload();
    }
});



connection.start().catch(err => console.error(err.toString()));