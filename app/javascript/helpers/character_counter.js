const countCharacters = () => {
    const characterCountReplacer = (count) => {
        return `(characters: ${count})`
    }

    let textFields = document.querySelectorAll('.character-counter--js')
    textFields.forEach((item) => {
        item.setAttribute('aria-describedby', `charCounter[${item.id}]`)
        const helpNode = document.createElement('small')
        helpNode.innerHTML = characterCountReplacer(item.value.length)
        helpNode.classList.add('form-text', 'text-muted')
        helpNode.id = `charCounter[${item.id}]`
        item.after(helpNode)

        item.addEventListener("input", (e) => {
            helpNode.innerHTML = characterCountReplacer(e.target.value.length)
        })
    })
}

export {countCharacters}
