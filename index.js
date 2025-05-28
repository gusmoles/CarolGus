// Surprise button functionality
document.querySelector('#surpriseBtn').addEventListener('click', function() {
    document.querySelector('#surpriseModal').classList.remove('hidden');
});

// Close modal
document.querySelector('#closeModal').addEventListener('click', function() {
    document.querySelector('#surpriseModal').classList.add('hidden');
});

// Also make the first button work
document.querySelector('.btn-love').addEventListener('click', function() {
    document.querySelector('#surpriseModal').classList.remove('hidden');
});

// Close modal when clicking outside
document.querySelector('#surpriseModal').addEventListener('click', function(e) {
    if (e.target === this) {
        this.classList.add('hidden');
    }
}); 