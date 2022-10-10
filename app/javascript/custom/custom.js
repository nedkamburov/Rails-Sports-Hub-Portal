const dropdownTrigger = document.querySelector('#dropdownMenuButton')
const dropdown = document.querySelector('.dropdown-menu')
dropdownTrigger.addEventListener('click', () => {
    dropdown.classList.toggle('show')
})