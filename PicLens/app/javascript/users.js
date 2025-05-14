document.addEventListener('DOMContentLoaded', function() {
  const avatarRadios = document.querySelectorAll('input[name="user[photo_profile]"]');
  const urlInput = document.getElementById('custom_photo_url');
  const fileInput = document.getElementById('user_profile_picture');
  
  if (avatarRadios.length > 0) {
    avatarRadios.forEach(radio => {
      if (radio.id !== 'custom_photo_url') {
        radio.addEventListener('change', function() {
          if (this.checked) {
            urlInput.value = this.value;
          }
        });
      }
    });
    
    if (urlInput) {
      urlInput.addEventListener('input', function() {
        avatarRadios.forEach(radio => {
          if (radio.id !== 'custom_photo_url') {
            radio.checked = false;
          }
        });
      });
    }
    
    if (fileInput) {
      fileInput.addEventListener('change', function() {
        if (this.value) {
          urlInput.value = '';
          avatarRadios.forEach(radio => {
            if (radio.id !== 'custom_photo_url') {
              radio.checked = false;
            }
          });
        }
      });
    }
  }
}); 