import { getColorPlants, colorData } from '/assets/module/fetch.js'
import { getSizePlants, sizeData } from '/assets/module/fetch.js'
import { getCategoryPlants } from '/assets/module/fetch.js'
import { getPlantProduct } from '/assets/module/fetch.js'
import { getCart } from '/assets/module/fetch.js'

import { renderColorEle, renderSizeEle, renderDesCategoryEle } from '/assets/module/render.js'

const $ = document.querySelector.bind(document)
const $$ = document.querySelectorAll.bind(document)


const meta = document.querySelector('meta[name="csrf-token"]');
const token = meta.content;

var plantsListData = null

var cartData = null

var listCategoryData = null
var currentProductId = null
var currentProductObj = null
var currentPlantProduct = {
    category: 'Classic Tees',
    color: null,
    size: null,
    quantity: 1
}
var listColor = []
var listSize = []
var priceProductEle = $('#price_product')
var imgMainProductEle = $('#img_main_product')
var listCategory = $('#plant_category')
var quantityEle = $('#quantity')
var cartListEle = $('#cart_list')
var totalPriceCartEle = $('.total_price_cart')
var listCheckboxCartEle = null
var listRemoveItemCartEle = null



function start() {
    getCategoryPlants(renderCategoryPlants);
    getPlantProduct(queryProduct)
    getColorPlants()
    getSizePlants()
    setTimeout(() => {
        getCart(renderCart)
        addProductIntoCart()
    }, 2000);

}

start()


function renderCategoryPlants(categorys) {
    var htmlsCategory = categorys.data.map(function (category){
        return `
                <img src="${category.img}" class="item-category hover:cursor-pointer w-full border-2 rounded">
            `;
    })
    listCategory.innerHTML = htmlsCategory.join('')
    listCategoryData = categorys
}


function queryProduct(plantsData) {
    plantsListData = plantsData
    var nameProductEle = $('#name_product')
    // console.log(priceProductEle);

    var nameCategoryEle = $('#name_category')
    var itemsCategoryEle =  $$('.item-category')
    var desCategoryEle = $('#description_category')

    var nameColor = $('#name_color')
    var listColorEle = $('#list_color')
    var colorBlockEle = $('#color_block')
    var itemsColorEle = $$('.item-color')
    
    var nameSize = $('#name_size')
    var listSizeEle = $('#list_size')
    var sizeBlockEle = $('#size_block')
    var itemsSizeEle = $$('.item-size')
    // console.log(sizeData);
    
    // ------------------------render data first load-------------------------
    var listFirstCate = plantsData.data.filter( o => o.category.name === plantsData.data[0].category.name)
    
    currentPlantProduct.category = listFirstCate[0].category.name
    currentPlantProduct.color = listFirstCate[0].color.name
    currentPlantProduct.size = listFirstCate[0].size.name

    getInforProduct(plantsData, currentPlantProduct, currentProductId, priceProductEle)

    // console.log(currentPlantProduct);
    // console.log(currentProductId);
    listFirstCate.forEach((e) => {
        listColor.push(e.color)
        if (e.size != null) {
            listSize.push(e.size.name)
            
        } else {
            listSize.push(e.size)
        }
    })
    listColor = uniqBy(listColor, JSON.stringify);
    listSize = uniqBy(listSize, JSON.stringify);
    renderColorEle(listColor, listColorEle)
    renderSizeEle(listSize, listSizeEle)
    listColor = []
    listSize = []
    itemsColorEle = $$('.item-color')
    itemsSizeEle = $$('.item-size')
// -----------------------------------------------------------------------
    itemsCategoryEle.forEach((itemCategory) => {
        itemCategory.onclick = () => {
            focusEle(itemsCategoryEle, itemCategory)
            var srcImg = itemCategory.getAttribute('src')
            listCategoryData.data.forEach((itemCategoryData) => {
                if (itemCategoryData.img == srcImg) {
                    nameCategoryEle.innerHTML = `${itemCategoryData.name}`
                    nameProductEle.innerHTML = `Aloe ${itemCategoryData.name}`
                    renderDesCategoryEle(desCategoryEle, itemCategoryData.description)

                    currentPlantProduct.category = itemCategoryData.name
                    checkCategory(plantsData, itemCategoryData.name)
                    // console.log(listCategoryData);
                }
            })
            getInforProduct(plantsData, currentPlantProduct, currentProductId, priceProductEle)
            plantsData.data.forEach((plantData) => {
                if (nameCategoryEle.textContent == plantData.category.name) {
                    listColor.push(plantData.color)
                    if (plantData.size != null) {
                        listSize.push(plantData.size.name)
                        
                    } else {
                        listSize.push(plantData.size)
                    }
                }
            })

            listColor = uniqBy(listColor, JSON.stringify);
            listSize = uniqBy(listSize, JSON.stringify);

            sizeBlockEle.classList.remove('hidden')
            colorBlockEle.classList.remove('hidden')
            switch (true) {
                case (listColor[0] == null && listSize[0] == null):
                    sizeBlockEle.classList.add('hidden')
                    colorBlockEle.classList.add('hidden')
                    break;
                case (listColor[0] == null && listSize[0] != null):
                    colorBlockEle.classList.add('hidden')
                    renderSizeEle(listSize, listColorEle)
                    break;
                case (listSize[0] == null && listColor[0] != null):
                    sizeBlockEle.classList.add('hidden')
                    renderColorEle(listColor, listColorEle)
                    break;
                default:
                    renderSizeEle(listSize, listSizeEle)
                    renderColorEle(listColor, listColorEle)
                    break;
            }
            itemsColorEle = $$('.item-color')
            handleClickColorAndSize(colorData, itemsColorEle, nameColor, plantsData, currentPlantProduct, currentProductId)
            
            itemsSizeEle = $$('.item-size')
            handleClickColorAndSize(sizeData, itemsSizeEle, nameSize, plantsData, currentPlantProduct, currentProductId)

            listColor = []
            listSize = []
        }
    })
    itemsCategoryEle[0].classList.add('border-blue-700')

    itemsColorEle[0].classList.add('border-blue-700')
    handleClickColorAndSize(colorData, itemsColorEle, nameColor, plantsData, currentPlantProduct, currentProductId)

    itemsSizeEle[0].classList.add('border-blue-700')
    handleClickColorAndSize(sizeData, itemsSizeEle, nameSize, plantsData, currentPlantProduct, currentProductId)


}


function renderCart(cartDataApi) {
    // console.log(cartData);
    var listCart = [];
    cartData = cartDataApi
    cartData.data.forEach((item) => {
        // console.log(item);
        var itemCart = plantsListData.data.find((o) => o.id == item.product_id);
        itemCart.quantityIncart = item.quantity
        listCart.push(itemCart);
        // console.log(listCart);
    })
    var htmlsItemCart = listCart.map((item) => {
        // console.log(item.color.name);
        return `
                    <div class="cart_item flex flex justify-center items-start py-4">
                        <div class="">
                            <input class="check_item_cart h-4 w-4 border border-gray-300 rounded-sm bg-white checked:bg-blue-600 checked:border-blue-600 focus:outline-none transition duration-200 mt-1 align-top bg-no-repeat bg-center bg-contain float-left mr-2 cursor-pointer" type="checkbox" value="" id="">
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
                                    <div class="text-xl" style="padding: 5px 7px">
                                        <i class="fas fa-minus"></i>
                                    </div>
                                    <span class="">${item.quantityIncart}</span>
                                    <div class="text-xl" style="padding: 5px 7px">
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
    cartListEle.innerHTML = htmlsItemCart.reverse().join('')
    listCheckboxCartEle = $$('.check_item_cart')
    checkboxCart()

    listRemoveItemCartEle = $$('.delete_item')
    removeItemCart()
}
// --------------------------mini function------------------------

function uniqBy(a, key) {
    var index = [];
    return a.filter(function (item) {
        var k = key(item);
        return index.indexOf(k) >= 0 ? false : index.push(k);
    });
}

function focusEle(eles, ele) {
    eles.forEach((element) => {
        element.classList.remove('border-blue-700')
    })
        ele.classList.add('border-blue-700')
}



function getInforProduct(plantsData, currentPlantProduct, currentProductId, priceProductEle) {
    plantsData.data.forEach((item) => {
        switch (true) {
            case currentPlantProduct.color == undefined:
                if (item.category.name == currentPlantProduct.category) {
                    currentProductId = item.id
                }
                break;
            case currentPlantProduct.size == undefined:
                if (item.category.name == currentPlantProduct.category && item.color.name == currentPlantProduct.color) {
                    currentProductId = item.id
                }
                break;
            default:
                if (item.category.name == currentPlantProduct.category && item.color.name == currentPlantProduct.color && item.size.name == currentPlantProduct.size) {
                    currentProductId = item.id
                }
                break;
        }
    })
    currentProductObj = plantsData.data.filter( o => o.id === currentProductId)[0]
    // console.log(plantsData.data);
    priceProductEle.textContent = `${currentProductObj.price}`
    imgMainProductEle.setAttribute('src',currentProductObj.img)
    quantity.onchange = () => {
        currentPlantProduct.quantity = parseInt(quantity.value)
        currentProductObj.quantityATC = currentPlantProduct.quantity
    }
    currentProductObj.quantityATC = currentPlantProduct.quantity
}

function handleClickColorAndSize(data, elements, name, plantsData, currentPlantProduct, currentProductId) {
    elements.forEach((item) => {
        item.onclick = () => {
            focusEle(elements, item)
            data.data.forEach((i) => {
                switch (true) {
                    case (i.rgb !== undefined):
                        if (i.rgb == item.style.backgroundColor) {
                            currentPlantProduct.color = i.name
                            name.textContent = `${i.name}`
                        }
                        break;
                    default:
                        if (i.name == item.textContent) {
                            currentPlantProduct.size = i.name
                            name.textContent = `${i.name}`
                        }
                        break;
                }
            })
            getInforProduct(plantsData, currentPlantProduct, currentProductId, priceProductEle)
        }
    })
}

function checkCategory(plantsData, category) {
    var listSameCategory = []
    plantsData.data.forEach((item) => {
        if (item.category.name == category) {
            // console.log(item.color);
            listSameCategory.push(item)
            switch (true) {
                case listSameCategory[0].color == null:
                    currentPlantProduct.color = null
                    currentPlantProduct.size = null
                    break;
                case listSameCategory[0].size == null:
                    currentPlantProduct.color = listSameCategory[0].color.name
                    currentPlantProduct.size = null
                    break;
                default:
                    currentPlantProduct.color = listSameCategory[0].color.name
                    currentPlantProduct.size = listSameCategory[0].size.name
                    break;
            }
        }
    })
}

function addProductIntoCart(params) { 
    var btnAddToCartEle = $("#btn_add-to-cart")
    // console.log(currentProductObj)
    btnAddToCartEle.onclick = () => {
        const data = currentProductObj;
        console.log(data);

        fetch(`/carts`, {
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
            getCart(renderCart)
        })
        .catch((error) => {
            console.error('Error:', error);
        });
    }
}

function checkboxCart(params) {
    // console.log(listCheckboxCartEle);
    var checkboxAllCart = $('#checkbox_all_item_cart')
    var totalPrice = 0.00
    listCheckboxCartEle.forEach((checkbox) => {
        checkbox.onclick = () => {
            priceItem = parseFloat(checkbox.parentNode.parentNode.childNodes[5].childNodes[11].childNodes[1].childNodes[3].textContent.trim());
            quantityItem = parseFloat(parseInt(checkbox.parentNode.parentNode.childNodes[5].childNodes[13].childNodes[1].childNodes[3].textContent.trim()))
            if (checkbox.checked == true) {
                totalPrice += priceItem*quantityItem
                totalPriceCartEle.textContent = totalPrice.toFixed(2)
                // console.log(totalPrice.toFixed(2));
            } else {
                totalPrice -= priceItem*quantityItem
                totalPriceCartEle.textContent = totalPrice.toFixed(2)
                // console.log(totalPrice.toFixed(2));
            }
        }

    })
    checkboxAllCart.onclick = () => {
        listCheckboxCartEle.forEach((checkbox) => {
            checkbox.checked = true
            quantityItem = parseFloat(parseInt(checkbox.parentNode.parentNode.childNodes[5].childNodes[13].childNodes[1].childNodes[3].textContent.trim()))
            priceItem = parseFloat(checkbox.parentNode.parentNode.childNodes[5].childNodes[11].childNodes[1].childNodes[3].textContent.trim());
            totalPrice += priceItem*quantityItem
            totalPriceCartEle.textContent = totalPrice.toFixed(2)
        })
        // console.log(totalPrice);
    }
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

