import { getCart,
         getPlantProduct,
         getShipping
        } from '/assets/module/fetch.js'

import { renderCart } from '/assets/layout/main.js'

const $ = document.querySelector.bind(document)
const $$ = document.querySelectorAll.bind(document)

const meta = document.querySelector('meta[name="csrf-token"]');
const token = meta.content;

var plantsListData = null
var cartData = null

var cartListEle = $('#list_item')
var listRemoveItemCartEle = null
var totalItemCartEle = $('.total_item_cart')
var listCheckboxItemCart = null
var totalPriceItemsSelected = $('.total_price_items_selected')
var subtotalOrderEle = $('.subtotal_order')
var totalItemSelectedEle = $('.total_item_selected')
var totalPriceAllCostEle = $('.total_price_all_cost')
var shippingTaxEle = $('.shipping_tax')
var optionShipping = $('.option_shipping')
var checkoutBtnEle = $('.checkout_btn')
var valueShipping = null
var idShipping = 1
var totalPriceAllCost = 0
var totalOrder = $('.total_order')
var shippingOrderEle = $('.shipping_order')
var quantityProductOrderEle = $('.quantity_product_order')
var quantityProductOrderInp = $('#order_session_quantity')
var totalPriceInp = $('#order_session_total_price')
var confirmOrderBtn = $('.confirm_order_btn')
var orderCodeInp = $('#order_session_order_code')
var checkoutMainEle = $('#checkout_main')
var backToCartBtn = $('.back_to_cart_btn')
var cartMainEle = $('#cart_main')
var listItemOrderEle = $('.list_item_order')

var listCart = [];
var itemSelected = [];
var itemOrder = []

function start(params) {
    getPlantProduct(getproduct)
    getShipping(renderShippingELe)
    // setTimeout(() => {
    //     getCart(renderCartMain);
    // }, 1000);
    // selectOptionShipping()
    // checkBtnCheckout()
    checkout()
    confirmOrder()
    backToCart()
}

start()

async function getproduct(data) {
    plantsListData = await data
    getCart(renderCartMain)
}


function renderCartMain(cartDataApi) {
    // console.log(plantsListData);
    // var colorItemCart = $$
    listCart = [];
    cartData = cartDataApi
    cartData.data.forEach((item) => {
        var itemCart = plantsListData.data.find((o) => o.id == item.product_id);
        itemCart.quantityIncart = item.quantity
        itemCart.totalPrice = (itemCart.quantityIncart * parseFloat(itemCart.price)).toFixed(2)
        listCart.push(itemCart);
    })

    // console.log(listCart);
    // listCart = listCart.reverse();
    totalItemCartEle.textContent = `${listCart.length} Items`
    var htmlsItemCart = listCart.reverse().map((item, index) => {
        // console.log(item.color.name);
        return `
                <div class="flex items-center hover:bg-gray-100 -mx-8 px-6 py-5">
                    <div class="flex items-start h-32">
                        <input class="check_item_cart h-4 w-4 border border-gray-300 rounded-sm bg-white checked:bg-blue-600 checked:border-blue-600 focus:outline-none transition duration-200 mt-1 align-top bg-no-repeat bg-center bg-contain float-left mr-2 cursor-pointer" type="checkbox" value="" id="">
                    </div>
                    <div class="infor_item flex w-2/5">
                        <div class="w-28">
                            <img class="h-24" src="${item.img}" alt="">
                        </div>
                        <div class="description_item flex flex-col justify-between ml-4 flex-grow">
                            <span class="font-bold text-m">${item.name}</span>
                            <span class="text-gray-500 text-s">${item.concept.name}</span>
                            <span class="text-red-500 text-s">
                                Category: ${item.category.name}
                            </span>
                            <span class="text-red-500 text-s color_item_cart ${item.color == null ? 'hidden' : ''} text-m font-normal text-gray-400 py-1">
                                Color: ${item.color == null ? '' : item.color.name}
                            </span>
                            <span class="text-red-500 text-s size_item_cart ${item.size == null ? 'hidden' : ''} text-m font-normal text-gray-400 py-1">
                                Size: ${item.size == null ? '' : item.size.name}
                            </span>
                            <span class="hidden sku text-red-500 text-s size_item_cart ${item.size == null ? 'hidden' : ''} text-m font-normal text-gray-400 py-1">
                                ${item.sku}
                            </span>
                            <a class="remove_item_btn font-semibold hover:text-red-500 text-gray-500 text-s cursor-pointer">Remove</a>
                        </div>
                    </div>
                    <div class="flex justify-center w-1/5 text-gray-600 text-l">
                        <svg class="quantity_minus_btn fill-current w-3 cursor-pointer" viewBox="0 0 448 512">
                            <path d="M416 208H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h384c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z"/>
                        </svg>

                        <input class="quantity_item mx-2 border text-center w-8" type="text" value="${item.quantityIncart}">

                        <svg class="quantity_plus_btn fill-current text-gray-600 w-3 cursor-pointer" viewBox="0 0 448 512">
                            <path d="M416 208H272V64c0-17.67-14.33-32-32-32h-32c-17.67 0-32 14.33-32 32v144H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h144v144c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32V304h144c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z"/>
                        </svg>
                    </div>
                    <span class="price_item text-center w-1/5 font-semibold text-xl">$${item.price}</span>
                    <span class="total_price_item text-center w-1/5 font-semibold text-xl">$${parseFloat(item.price * item.quantityIncart).toFixed(2)}</span>
                </div>
                `
        
    })
    cartListEle.innerHTML = htmlsItemCart.join('')
    changeQuantityItemCartBTN()
    listRemoveItemCartEle = $$('.remove_item_btn')
    removeItemCart()
    listCheckboxItemCart = $$('.check_item_cart')
    selectItemCart()
}

function renderShippingELe(shippingDataApi) {
    var htmlsShipping = shippingDataApi.data.map((item, index) => {

        return `<option value='${item.value}' idshipping='${item.id}' ${ index == 0 ? 'selected="selected"' : ''}>${item.name} - $${item.value}</option>`
    })
    optionShipping.innerHTML = htmlsShipping.join('')
}

function changeQuantityItemCartBTN() {
    var quantityListMinusBtnEl = $$('.quantity_minus_btn')
    var totalPrice = null
    quantityListMinusBtnEl.forEach((itemBtn, index) => {
        var quantity = parseInt(itemBtn.parentNode.childNodes[3].value)
        if (quantity == 1) {
            itemBtn.classList.add('text-gray-300')
            itemBtn.addEventListener('click', (e) => {e.preventDefault()})
        }
        itemBtn.onclick = () => {
            quantity = parseInt(itemBtn.parentNode.childNodes[3].value)
            if (quantity == 1) {
                itemBtn.classList.add('text-gray-300')
                itemBtn.addEventListener('click', (e) => {e.preventDefault()})
            } else {
                quantity -= 1
                var indexSelectItem = listCart.length - (index + 1)
                listCart[indexSelectItem].quantityIncart = quantity
                // listCart[indexSelectItem].totalPrice = (quantity * parseFloat(listCart[indexSelectItem].price)).toFixed(2)
                for (let i = 1; i < itemBtn.parentNode.parentNode.childNodes.length; i += 2) {
                    if (itemBtn.parentNode.parentNode.childNodes[i].classList.contains('price_item')) {
                        totalPrice = parseFloat(itemBtn.parentNode.parentNode.childNodes[i].textContent.trim().slice(1)) * quantity
                        itemBtn.parentNode.parentNode.childNodes[i+2].textContent = `$${totalPrice.toFixed(2)}`
                        listCart[indexSelectItem].totalPrice = totalPrice.toFixed(2)
                    }
                    
                }
                getProductBySKU(itemBtn)
                if (quantity == 1) {
                    itemBtn.classList.add('text-gray-300')
                }
                itemBtn.parentNode.childNodes[3].setAttribute('value', quantity)
            }
        }
    })
    var quantityListPlusBtnEl = $$('.quantity_plus_btn')
    // console.log(quantityListPlusBtnEl);
    quantityListPlusBtnEl.forEach((itemBtn, index) => {
        itemBtn.onclick = () => {
            var quantity = parseInt(itemBtn.parentNode.childNodes[3].value)
            quantity += 1
            var indexSelectItem = listCart.length - (index + 1)
            listCart[indexSelectItem].quantityIncart = quantity
            for (let i = 1; i < itemBtn.parentNode.parentNode.childNodes.length; i += 2) {
                if (itemBtn.parentNode.parentNode.childNodes[i].classList.contains('price_item')) {
                    totalPrice = parseFloat(itemBtn.parentNode.parentNode.childNodes[i].textContent.trim().slice(1)) * quantity
                    itemBtn.parentNode.parentNode.childNodes[i+2].textContent = `$${totalPrice.toFixed(2)}`
                    listCart[indexSelectItem].totalPrice = totalPrice.toFixed(2)
                }
                
            }
            getProductBySKU(itemBtn)
            itemBtn.parentNode.childNodes[3].setAttribute('value', quantity)
            if (quantity == 2) {
                itemBtn.parentNode.childNodes[1].removeEventListener('click', (e) => {e.preventDefault()});
                itemBtn.parentNode.childNodes[1].classList.remove('text-gray-300')
            }
        }
    })
}
function getProductBySKU(itemBtn) {
    var skuProduct = null
    for (let i = 1; i < itemBtn.parentNode.parentNode.childNodes.length; i += 2 ) {
        if (itemBtn.parentNode.parentNode.childNodes[i].classList.contains('infor_item')) {
            for (let y = 1; y < itemBtn.parentNode.parentNode.childNodes[i].childNodes.length; y += 2) {
                if (itemBtn.parentNode.parentNode.childNodes[i].childNodes[y].classList.contains('description_item')) {
                    for (let u = 1; u < itemBtn.parentNode.parentNode.childNodes[i].childNodes[y].childNodes.length; u += 2) {
                        if (itemBtn.parentNode.parentNode.childNodes[i].childNodes[y].childNodes[u].classList.contains('sku')) {
                            skuProduct = itemBtn.parentNode.parentNode.childNodes[i].childNodes[y].childNodes[u].textContent.trim();
                        }
                        
                    }
                }
                
            }
        }
        
    }
    var product = plantsListData.data.find((o) => o.sku == skuProduct)
    cartData.data.forEach(item => {
        if (item.product_id == product.id) {
            if (itemBtn.classList.contains('quantity_minus_btn')) {
                item.quantity --
            } else {
                item.quantity ++
            }
            const data = {
                id: item.id,
                quantity: item.quantity
            };
            fetch(`/carts/${item.id}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': token
                },
                body: JSON.stringify(data),
            })
            .then(response => response.text())
            .then(data => {
                console.log('Success:', data);
            })
            .catch((error) => {
                console.error('Error:', error);
            });
        }
    })
}

function removeItemCart(params) {
    var skuProduct = null
    // console.log(listRemoveItemCartEle);
    listRemoveItemCartEle.forEach(removeItem => {
        removeItem.onclick = () => {   
            for (let i = 1; i < removeItem.parentNode.childNodes.length; i += 2) {
                if (removeItem.parentNode.childNodes[i].classList.contains('sku')) {
                    skuProduct = removeItem.parentNode.childNodes[i].textContent.trim();
                }
            }
            var product = plantsListData.data.find((o) => o.sku == skuProduct)
            cartData.data.forEach(item => {
                if (item.product_id == product.id) {
                    const data = {
                        id: item.id
                    };
                    fetch(`/carts/${item.id}`, {
                        method: 'DELETE',
                        headers: {
                            'Content-Type': 'application/json',
                            'X-CSRF-TOKEN': token
                        },
                        body: JSON.stringify(data),
                    })
                    .then(response => response.text())
                    .then(data => {
                        console.log('Success:', data);
                        getCart(renderCartMain)
                        getCart(renderCart)
                    })
                    .catch((error) => {
                        console.error('Error:', error);
                    });
                }
            })
            
        }
    })
}

function selectItemCart(params) {
    var totalPrice = 0
    var totalItem = 0
    
    valueShipping = parseFloat(optionShipping.value) 
    optionShipping.onchange = () => {
        for (let i = 0; i < optionShipping.childNodes.length; i++) {
            if (optionShipping.childNodes[i].getAttribute('value') == optionShipping.value) {
                idShipping = optionShipping.childNodes[i].getAttribute('idshipping')                
            }
            
        }
        valueShipping = parseFloat(optionShipping.value)
        // 
        console.log(totalPriceAllCost);
        if (totalPrice == 0) {
            totalPriceAllCostEle.innerHTML = `$${totalPriceAllCost.toFixed(2)}`
        } else {
            totalPriceAllCost = totalPrice + valueShipping
            totalPriceAllCostEle.innerHTML = `$${totalPriceAllCost.toFixed(2)}`
        }
        // console.log(totalPriceAllCost);
    }
    listCheckboxItemCart.forEach((item, index) => {
        // console.log(item);
        item.addEventListener('click', () => {
            // var indexSelectItem = index
            for (let i = 1; i < item.parentNode.parentNode.childNodes.length; i += 2) {
                if (item.parentNode.parentNode.childNodes[i].classList.contains('total_price_item')) {
                    if (item.checked) {
                        totalPrice += parseFloat(item.parentNode.parentNode.childNodes[i].textContent.trim().slice(1))
                        totalItem ++
                        totalPriceAllCost = totalPrice + valueShipping
                        totalPriceAllCostEle.innerHTML = `$${totalPriceAllCost.toFixed(2)}`
                        itemSelected.push(listCart[index])

                    } else {
                        totalPrice -= parseFloat(item.parentNode.parentNode.childNodes[i].textContent.trim().slice(1))
                        totalItem --
                        itemSelected = itemSelected.filter(item => item !== listCart[index])
                        if (totalPrice == 0) {
                            totalPriceAllCost = 0
                            totalPriceAllCostEle.innerHTML = `$${totalPriceAllCost.toFixed(2)}`
                            
                        } else {
                            totalPriceAllCost = totalPrice + valueShipping
                            totalPriceAllCostEle.innerHTML = `$${totalPriceAllCost.toFixed(2)}`

                        }
        // console.log(totalPriceAllCost);
                    }
                }
            }
            totalPriceItemsSelected.innerHTML = `${totalPrice.toFixed(2)}$`
            totalItemSelectedEle.innerHTML = `Items ${totalItem}`
            checkBtnCheckout()
        })
    })
        
}

function checkout(params) {
    checkoutBtnEle.addEventListener('click', () => {
        console.log(checkoutMainEle);
        checkoutMainEle.classList.remove('hidden')
        cartMainEle.classList.add('hidden')
        shippingOrderEle.setAttribute('value', idShipping)
        totalPriceInp.setAttribute('value', totalPriceAllCost.toFixed(2))
        shippingTaxEle.textContent = `Shipping Tax: $${valueShipping}`
        subtotalOrderEle.textContent = `Subtotal: $${totalPriceItemsSelected.textContent.slice(0, -1)}`
        totalOrder.textContent = `Total: $${totalPriceAllCost.toFixed(2)}`
        renderItemOrder()
//         var url = new URLSearchParams({
//             id1: 5,
//             quantityIncart1: 6,
//             id2: 4,
//             quantityIncart2: 7
//         }).toString()
//         console.log(url);
        // window.location.href = `/checkout?${itemSelected}`
        
    })
}
function confirmOrder(params) {
    confirmOrderBtn.addEventListener('click', () => {
        var date = new Date();
        var components = [
            date.getYear(),
            date.getMonth(),
            date.getDate(),
            date.getHours(),
            date.getMinutes(),
            date.getSeconds(),
            date.getMilliseconds()
        ];

        var order_number = components.join("");
        // console.log(itemOrder);
        // console.log(order_number);
        orderCodeInp.setAttribute('value', order_number)
        const data = {
            products: itemOrder,
            order_code: order_number
        };
        console.log(data);
        fetch(`/orders/product`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': token
            },
            body: JSON.stringify(data),
        })
        .then(response => response.text())
        .then(data => {
            console.log('Success:', data);
        })
        .catch((error) => {
            console.error('Error:', error);
        });
    })
}

function renderItemOrder(params) {    
    quantityProductOrderEle.textContent = `ITEM ${itemSelected.length}`
    quantityProductOrderInp.setAttribute('value',itemSelected.length)
    var htmlsItemOrder = itemSelected.map((item) => {
        var productData = new Object({
            product_id: item.id,
            quantity: item.quantityIncart           
        });
        itemOrder.push(productData)
        return `
        <div class="flex space-x-4 w-full">
            <div class="w-56">
                <img src="${item.img}" alt="image" class="w-56">
            </div>
            <div class="w-full">
                <h2 class="text-xl font-bold">${item.name}</h2>
                <p class="text-sm">${item.category.name}</p>
                <p class="text-sm ${item.size == null ? 'hidden' : ''}">Size: ${item.size == null ? '' : item.size.name}</p>
                <p class="text-sm ${item.color == null ? 'hidden' : ''}">Color: ${item.color == null ? '' : item.color.name}</p>
                <p class="text-sm">Quantity: ${item.quantityIncart}</p>             
                <span class="text-red-600">Price</span> $${item.totalPrice}
            </div>
        </div>
        `
    })
    listItemOrderEle.innerHTML = htmlsItemOrder.join('')
    // checkBtnCheckout()
}
function backToCart(params) {
    backToCartBtn.addEventListener('click', () => {
        checkoutMainEle.classList.add('hidden')
        cartMainEle.classList.remove('hidden')
    })
}
function checkBtnCheckout() {
    if (parseInt(totalItemSelectedEle.textContent.replace('Items ', "")) == 0) {
        checkoutBtnEle.classList.add('pointer-events-none')
        checkoutBtnEle.classList.add('opacity-50')
        
    } else {
        checkoutBtnEle.classList.remove('pointer-events-none')
        checkoutBtnEle.classList.remove('opacity-50')
    }
}

export { renderCartMain }