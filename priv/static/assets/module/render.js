// ----------------------COLOR---------------------------------------
function renderColorEle(listColor, listColorEle){
    var htmlsCodeColor = listColor.map((codeColor) => {
        return `
                <span class="item-color code-color w-10 h-10 p-1 rounded-full border-2 hover:cursor-pointer" style="background-color:${codeColor.code}"></span>
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

// ----------------------SIZE CLOTHER---------------------------------------
function renderSizeClotherEle(listSizeClother, listSizeClotherEle, unitOfMeasure) {
    var htmlsSizeClother = listSizeClother.map( (sizeClother) => {
        switch (unitOfMeasure) {
            case "Inches":
                return `
                        <tr class="border-b-2">
                            <td class="py-2">${sizeClother.size}</td>
                            <td class="py-2">${sizeClother.shirt_length_in}in</td>
                            <td class="py-2">${sizeClother.chest_width_in}in</td>
                        </tr>
                    `
                break;
            case "Centimeters":
                return `
                        <tr class="border-b-2">
                            <td class="py-2">${sizeClother.size}</td>
                            <td class="py-2">${sizeClother.shirt_length_cm}cm</td>
                            <td class="py-2">${sizeClother.chest_width_cm}cm</td>
                        </tr>
                    `
        }


    })
    listSizeClotherEle.innerHTML = htmlsSizeClother.join('')
}


export { renderColorEle, renderSizeEle, renderDesCategoryEle, renderSizeClotherEle }