var socket = io.connect('http://' + document.domain + ':' + location.port);

socket.on('message', function(data) {
    switch(data.action) {
        case 'connect':
            console.log(data.message);
            break;
        case 'disconnect':
            console.log(data.message);
            break;
        case 'update':
            console.log(data.message);
            break;
        default:
            console.log(data.message);
            break;
    }   
});