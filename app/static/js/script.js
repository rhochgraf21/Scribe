var socket = io.connect('http://' + document.domain + ':' + location.port);

socket.on('transcription', function(data) {
    document.getElementById('transcription').innerText = data.text;
});

navigator.mediaDevices.getUserMedia({ audio: true, video: false })
    .then(function(stream) {
        const audioContext = new AudioContext();
        const mediaStreamAudioSourceNode = audioContext.createMediaStreamSource(stream);
        const scriptProcessorNode = audioContext.createScriptProcessor(4096, 1, 1);
        mediaStreamAudioSourceNode.connect(scriptProcessorNode);
        scriptProcessorNode.connect(audioContext.destination);
        scriptProcessorNode.onaudioprocess = function(audioProcessingEvent) {
            const inputBuffer = audioProcessingEvent.inputBuffer;
            const inputData = inputBuffer.getChannelData(0);
            const buffer = new Int16Array(inputData.length);
            for (let i = 0; i < inputData.length; i++) {
                buffer[i] = inputData[i] * 32767;
            }
            socket.emit('audio', { 'audio': buffer.buffer });
        };
    })
    .catch(function(err) {
        console.error('Could not initialize media devices.', err);
    });