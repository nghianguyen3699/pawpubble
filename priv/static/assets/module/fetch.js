// ----------------------COLOR---------------------------------------
var colorApi = 'http://localhost:4000/api/colors'

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
var sizeApi = 'http://localhost:4000/api/sizes'

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
var categoryApi = 'http://localhost:4000/api/categorys'
function getCategoryPlants(callback) {
    fetch(categoryApi)
        .then(response => response.json())
        .then(callback)
        .catch(err => console.error(err))
}
export { getCategoryPlants };
// ----------------------CATEGORY------------------------------------

// ----------------------PRODUCT------------------------------------
var plantApi = 'http://localhost:4000/api/products/plants'

function getPlantProduct(callback) {
    fetch(plantApi)
        .then(response => response.json())
        .then(callback)
        .catch(err => console.error(err))
}
export { getPlantProduct };
// ----------------------PRODUCT------------------------------------

// ----------------------CART---------------------------------------
var cartApi = 'http://localhost:4000/api/carts '

function getCart(callback) {
    fetch(cartApi)
        .then(response => response.json())
        .then(callback)
        .catch(err => console.error(err))
}
export { getCart };
// ----------------------CART---------------------------------------

// ----------------------SHIPPING---------------------------------------
var shippingApi = 'http://localhost:4000/api/shippings '

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


