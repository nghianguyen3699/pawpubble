import { getCart } from '/assets/module/fetch.js'
import { getPlantProduct } from '/assets/module/fetch.js'
import { setStorage } from '/assets/module/local_storage.js'
import { removeDuplicates } from '/assets/component.js'

const $ = document.querySelector.bind(document)
const $$ = document.querySelectorAll.bind(document)

const meta = document.querySelector('meta[name="csrf-token"]');
const token = meta.content;

var cartListEle = $('#cart_list')
var totalPriceCartEle = $('.total_price_cart')
var cartMain = $('.cart_icon')
var cartContainer = $('.cart_container')
var checkboxAllCart = $('#checkbox_all_item_cart')
var cartCountEle = $('.cart_count')
var listCheckboxCartEle = null
var listRemoveItemCartEle = null
var minusQuantityBtn = null
var plusQuantityBtn 
var listCart = [];

var PAGE_STORAGE_KEY = "CART_HEADER"
var config = JSON.parse(localStorage.getItem(PAGE_STORAGE_KEY)) || {}
totalPrice = 0

var totalPrice = 0.00
var quantityItem = 0
var priceItem = 0
var itemSelected = config.itemChecked

var plantsListData = null
var cartData = null

function start() {
    getPlantProduct(plantsApi => plantsListData = plantsApi.data.filter( o => o.name == "Aloe"))
    focusCart()
    setTimeout(() => {
        getCart(renderCart)
    },1000)
}

start()


function renderCart(cartDataApi) {
    
    cartData = cartDataApi
    cartData.data.forEach((item) => {
        var itemCart = plantsListData.find((o) => o.id == item.product_id);
        itemCart.quantityIncart = item.quantity
        itemCart.idItem = item.id
        listCart.push(itemCart);
    })
    var htmlsItemCart = listCart.map((item) => {
        // console.log(item.color.name);
        return `
                    <div class="cart_item flex justify-center items-start py-4" style="min-width: 420px; ">
                        <div class="">
                            <input class="check_item_cart_header h-4 w-4 border border-gray-300 rounded-sm bg-white checked:bg-green-500 checked:border-blue-600 focus:outline-none transition duration-200 mt-1 align-top bg-no-repeat bg-center bg-contain float-left mr-2 cursor-pointer" type="checkbox" value="" id="">
                        </div>
                        <img src="${item.img}" alt="" class="w-20">
                        <div class="flex flex-col pl-4 flex-nowrap" style="min-width: 280px; ">
                            <span class="-title text-xl font-bold">
                                ${item.name}
                            </span>
                            <span class="text-m font-normal text-gray-400 py-1">
                                ${item.concept.name}
                            </span>
                            <span class="text-m font-normal text-gray-400 py-1">
                                Category: ${item.category.name}
                            </span>
                            <span class="color_item_cart ${item.color == null ? 'hidden' : ''} text-m font-normal text-gray-400 py-1">
                                Color: ${item.color == null ? '' : item.color.name}
                            </span>
                            <span class="size_item_cart ${item.size == null ? 'hidden' : ''} text-m font-normal text-gray-400 py-1">
                                Size: ${item.size == null ? '' : item.size.name}
                            </span>
                            <div class="">
                                <span class="flex justify-start items-center text-xl font-medium text-red-500">
                                    <span>$</span>
                                    <span class="">
                                        ${item.price}
                                    </span>
                                </span>
                            </div>
                            <div class="flex items-center">
                                <div class="flex justify-between items-center border-2" style="min-width: 100px">
                                    <div class="minus_quantity text-xl" style="padding: 5px 7px">
                                        <i class="fas fa-minus"></i>
                                    </div>
                                    <span class="">${item.quantityIncart}</span>
                                    <div class="plus_quantity text-xl" style="padding: 5px 7px">
                                        <i class="fas fa-plus"></i>
                                    </div>
                                </div>
                                <span class="delete_item pl-3 cursor-pointer hover:underline hover:text-red-700">Remove item</span>
                            </div>
                            <div class="sku_product hidden">${item.sku}</div>
                        </div>
                    </div>
                `
        
    })
        // console.log(htmlsItemCart);
    //     cartListEle.appendChild(htmlsItemCart)
    cartListEle.innerHTML = htmlsItemCart.join('')
    listCheckboxCartEle = $$('.check_item_cart_header')
    listRemoveItemCartEle = $$('.delete_item')
    checkboxCart()
    removeItemCart()
    minusQuantityBtn = $$('.minus_quantity')
    plusQuantityBtn = $$('.plus_quantity')
    changeQuantityCart()
    if (checkAllStatusCheckbox(listCheckboxCartEle) == true) {
        checkboxAllCart.checked = true
    }
    cartCountEle.textContent = listCheckboxCartEle.length
    
}

function checkboxCart() {
    if (config.itemChecked.length == 0) {
        totalPrice = 0
        setStorage("totalPrice", totalPrice, config, PAGE_STORAGE_KEY)
    }
    listCheckboxCartEle.forEach((checkbox, index) => {
        if (config.itemChecked.length != 0) {
            config.itemChecked.forEach((e) => {
                if (index == e) {
                    checkbox.checked = true;
                    console.log(index, e);
                    priceItem = listCart[index].price
                    quantityItem = listCart[index].quantityIncart
                    totalPrice += priceItem*quantityItem
                    setStorage("totalPrice", totalPrice, config, PAGE_STORAGE_KEY)
                    totalPriceCartEle.textContent = `$${config.totalPrice.toFixed(2)}`
                }
            })
        }
        checkbox.onclick = () => {
            
            if (checkbox.checked) {
                itemSelected.push(index)
            } else {
                var i = itemSelected.indexOf(index);
                if (i !== -1) {
                itemSelected.splice(i, 1)
                }
            }
            itemSelected = removeDuplicates(itemSelected)
            setStorage("itemChecked", itemSelected, config, PAGE_STORAGE_KEY)
            if (checkAllStatusCheckbox(listCheckboxCartEle) == true) {
                checkboxAllCart.checked = true
            }
            listCheckboxCartEle.forEach((ele) => {
                if (ele.checked == false) {
                    checkboxAllCart.checked = false
                } 
            })
            // priceItem = parseFloat(checkbox.parentNode.parentNode.childNodes[5].childNodes[11].childNodes[1].childNodes[3].textContent.trim());
            // quantityItem = parseFloat(parseInt(checkbox.parentNode.parentNode.childNodes[5].childNodes[13].childNodes[1].childNodes[3].textContent.trim()))
            priceItem = listCart[index].price
            quantityItem = listCart[index].quantityIncart
            if (checkbox.checked == true) {
                totalPrice += parseFloat(priceItem)*quantityItem
                console.log(totalPrice);
                setStorage("totalPrice", totalPrice, config, PAGE_STORAGE_KEY)
                totalPriceCartEle.textContent = `$${config.totalPrice.toFixed(2)}`
            } else {
                totalPrice -= parseFloat(priceItem)*quantityItem
                setStorage("totalPrice", totalPrice, config, PAGE_STORAGE_KEY)
                totalPriceCartEle.textContent = `$${config.totalPrice.toFixed(2)}`
            }
        }

    })
    checkboxAllCart.onclick = () => {
        if (checkboxAllCart.checked == true) {
            var unCheckedbox = []
            listCheckboxCartEle.forEach((checkbox, index) => {
                if (checkbox.checked == false) {
                    unCheckedbox.push(checkbox)
                }
            })
            unCheckedbox.forEach((checkbox, index) => {
                itemSelected.push(index)
                checkbox.checked = true
                quantityItem = listCart[index].quantityIncart
                priceItem = listCart[index].price
                totalPrice += parseFloat(priceItem)*quantityItem
                setStorage("totalPrice", totalPrice, config, PAGE_STORAGE_KEY)
                totalPriceCartEle.textContent = `$${config.totalPrice.toFixed(2)}`

            })

            itemSelected = removeDuplicates(itemSelected)
            setStorage("itemChecked", itemSelected, config, PAGE_STORAGE_KEY)
        } else {
            listCheckboxCartEle.forEach((checkbox) => {
                checkbox.checked = false
            })
            itemSelected = []
            setStorage("itemChecked", itemSelected, config, PAGE_STORAGE_KEY)
            totalPrice = 0
            setStorage("totalPrice", totalPrice, config, PAGE_STORAGE_KEY)
            totalPriceCartEle.textContent = `$${config.totalPrice.toFixed(2)}`
        }
        // console.log(totalPrice);
    }
    
}
function checkAllStatusCheckbox(array) {
    return Array.from(array).every((ele) => {
        if (ele.checked == true) {
            return true
        } else {
            return false
        }
    })
}

function changeQuantityCart(params) {
    minusQuantityBtn.forEach( (ele, index) => {
        var quantityOld = parseInt(ele.parentNode.childNodes[3].textContent)
        if (quantityOld == 1) {
            ele.getElementsByTagName('i')[0].classList.add('text-gray-300')
        }
        ele.addEventListener('click', () => {
            quantityOld = parseInt(ele.parentNode.childNodes[3].textContent)
            if (quantityOld >= 2) {
                listCart[index].quantityIncart = parseInt(ele.parentNode.childNodes[3].textContent) - 1
                quantityItem = listCart[index].quantityIncart
                priceItem = listCart[index].price
                if (ele.parentNode.parentNode.parentNode.parentNode.getElementsByClassName('check_item_cart_header')[0].checked) {
                    totalPrice -= parseFloat(priceItem)
                    setStorage("totalPrice", totalPrice, config, PAGE_STORAGE_KEY)
                    totalPriceCartEle.textContent = `$${config.totalPrice.toFixed(2)}`  
                }
                ele.parentNode.childNodes[3].textContent = listCart[index].quantityIncart
                if (parseInt(ele.parentNode.childNodes[3].textContent) <= 1) {
                    ele.getElementsByTagName('i')[0].classList.add('text-gray-300')
                }
                updateCart(index)
            }
        })
    });
    plusQuantityBtn.forEach( (ele, index) => {
        ele.addEventListener('click', () => {
            if (ele.parentNode.childNodes[1].getElementsByTagName('i')[0].classList.contains('text-gray-300')) {
                ele.parentNode.childNodes[1].getElementsByTagName('i')[0].classList.remove('text-gray-300')
            }
            priceItem = listCart[index].price
            listCart[index].quantityIncart = parseInt(ele.parentNode.childNodes[3].textContent) + 1
            console.log(ele.parentNode.parentNode.parentNode.parentNode);
            if (ele.parentNode.parentNode.parentNode.parentNode.getElementsByClassName('check_item_cart_header')[0].checked) {
                totalPrice += parseFloat(priceItem)
                setStorage("totalPrice", totalPrice, config, PAGE_STORAGE_KEY)
                totalPriceCartEle.textContent = `$${config.totalPrice.toFixed(2)}` 
            }
            ele.parentNode.childNodes[3].textContent = listCart[index].quantityIncart
            updateCart(index)
        })
    });
}

function removeItemCart(params) {
    var skuProduct = null
    listRemoveItemCartEle.forEach(removeItem => {
        removeItem.onclick = () => {          
            skuProduct = removeItem.parentNode.parentNode.childNodes[15].textContent.trim()
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

function updateCart(index) {
    // update quantity items
    const data = {
        id: listCart[index].idItem,
        quantity: listCart[index].quantityIncart
    };

    fetch(`/carts/${listCart[index].idItem}`, {
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
        // cartListEle.innerHTML = ""
        // getCart(renderCart)
    })
    .catch((error) => {
        console.error('Error:', error);
    });
}

function focusCart(params) {
    cartMain.addEventListener('click', () => {
        cartContainer.classList.toggle('hidden')
    })
}

export { renderCart }