export function setupVideoValidation() {
    const videoInput = document.getElementById('videoFile');
    if (!videoInput) return;

    videoInput.addEventListener('change', function(event) {
        const file = event.target.files[0];
        if (file) {
            const video = document.createElement('video');
            video.preload = 'metadata';
            video.onloadedmetadata = function() {
                window.URL.revokeObjectURL(this.src);
                if (video.duration > 600) {
                    alert('動画は10分以内でなければなりません。');
                    event.target.value = '';
                }
            };
            video.src = URL.createObjectURL(file);
        }
    });
}
