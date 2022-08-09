// ----------------------COLOR---------------------------------------
var colorApi = 'https://pawpubble.herokuapp.com/api/colors'

var colorData = null

function getColorPlants() {
    fetch(colorApi)
        .then(response => response.json())
        .then(color => colorData = color)
        .catch(err => console.error(err))
}
export { getColorPlants, colorData };
// ----------------------COLOR---------------------------------------

// ----------------------SIZE----------------------------------------
var sizeApi = 'https://pawpubble.herokuapp.com/api/sizes'

var sizeData = null

function getSizePlants() {
    fetch(sizeApi)
        .then(response => response.json())
        .then(size => sizeData = size)
        .catch(err => console.error(err))
}
export { getSizePlants, sizeData };
// ----------------------SIZE----------------------------------------

// ----------------------CATEGORY------------------------------------
var categoryApi = 'https://pawpubble.herokuapp.com/api/categorys'
function getCategoryPlants(callback) {
    fetch(categoryApi)
        .then(response => response.json())
        .then(callback)
        .catch(err => console.error(err))
}
export { getCategoryPlants };
// ----------------------CATEGORY------------------------------------

// ----------------------PRODUCT------------------------------------
var plantApi = 'https://pawpubble.herokuapp.com/api/products/plants'

function getPlantProduct(callback) {
    fetch(plantApi)
        .then(response => response.json())
        .then(callback)
        .catch(err => console.error(err))
}
export { getPlantProduct };
// ----------------------PRODUCT------------------------------------

// ----------------------CART---------------------------------------
var cartApi = 'https://pawpubble.herokuapp.com/api/carts '

function getCart(callback) {
    fetch(cartApi)
        .then(response => response.json())
        .then(callback)
        .catch(err => console.error(err))
}
export { getCart };
// ----------------------CART---------------------------------------

// ----------------------SHIPPING---------------------------------------
var shippingApi = 'https://pawpubble.herokuapp.com/api/shippings '

function getShipping(callback) {
    fetch(shippingApi)
        .then(response => response.json())
        .then(callback)
        .catch(err => console.error(err))
}
export { getShipping };
// ----------------------SHIPPING---------------------------------------

// ----------------------ADDRESS----------------------------------------
var addressApi = 'https://raw.githubusercontent.com/nghianguyen3699/vietnam_address/main/nested-divisions.json'

function getAddress(callback) {
    fetch(addressApi)
        .then(response => response.json())
        .then(callback)
        .catch(err => console.error(err))
}
export { getAddress }
// ----------------------ADDRESS----------------------------------------

// ----------------------ADDRESS----------------------------------------
var sizeClotherApi = 'https://pawpubble.herokuapp.com/api/size_clothers'

var sizeClotherData = null

function getSizeClother(callback) {
    fetch(sizeClotherApi)
        .then(response => response.json())
        .then(sizeClother => sizeClotherData = sizeClother)
        .catch(err => console.error(err))
}
export { getSizeClother, sizeClotherData }
// ----------------------ADDRESS----------------------------------------


