// ----------------------COLOR---------------------------------------
function renderColorEle(listColor, listColorEle){
    var htmlsCodeColor = listColor.map((codeColor) => {
        return `
                <span class="item-color code-color w-12 h-12 rounded-full border-2 hover:cursor-pointer" style="background-color:${codeColor.code}"></span>
            `
    })
    listColorEle.innerHTML = htmlsCodeColor.join('')
}
// ----------------------COLOR---------------------------------------

// ----------------------SIZE---------------------------------------

function renderSizeEle(listSize, listSizeEle){
    var htmlsSize = listSize.map((size) => {
        return `
                <div class="item-size w-full h-14 flex justify-center items-center border-2 rounded hover:cursor-pointer">${size}</div>
            `
    })
    listSizeEle.innerHTML = htmlsSize.join('')
}
// ----------------------SIZE---------------------------------------

// ----------------------DECRIPTION CATEGORY---------------------------------------
function renderDesCategoryEle(listDes, listDescription) {
    var htmlsDesCate = listDescription.split(',').map( (description) => {
        return `
             <li class="mb-3 ml-6">${description}</li>
            `
    })
    listDes.innerHTML = htmlsDesCate.join('')
}
// ----------------------DECRIPTION CATEGORY---------------------------------------

// ----------------------SHIPPING---------------------------------------


export { renderColorEle, renderSizeEle, renderDesCategoryEle }