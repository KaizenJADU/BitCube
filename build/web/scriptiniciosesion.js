const inputs = document.querySelectorAll('.input');

function add_focus() {
    let parent = this.parentNode;
    parent.classList.add('active');
}

function add_blur() {
    let parent = this.parentNode;
    if (this.value == "") {
        parent.classList.remove('active');
    }
}

inputs.forEach(item => {
    item.addEventListener('focus', add_focus);
    item.addEventListener('blur', add_blur);
});


