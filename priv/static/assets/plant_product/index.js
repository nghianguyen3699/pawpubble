const $ = document.querySelector.bind(document)
const $$ = document.querySelectorAll.bind(document)

var quantityProductEle = $('#quantity_product')
var itemProductsEle = $$('.item_product')
var sortProductEle = $('#sort')
var colorCheckEle = $$('.color_input')
var categoryEle = $('#category')
var listCategoryEle = $('#list_category')
var targetItemsEle = $$('.target_item')
var categoryItemsEle = $$('.category_item')
var categoryNameEle = $$('.category_name')
var listFilterEle = $('#list_filter')

const PAGE_STORAGE_KEY = 'PAGE PLANTS'
var config = JSON.parse(localStorage.getItem(PAGE_STORAGE_KEY)) || {}

var sortColorId = ""
var filterCategory = ""
var categoryStorage = ""
var categoryDetailStorage = ""
var listCategoryShow = []

function start() {
    getSort()
    checkedColor()
    countProduct()
    categoryFilter()
    resetStorage()
    currentFilter()
    sort()
    colorFilter()
    showFilterSelected()
}

start()

function setSort(key, value) {
    config[key] = value
    localStorage.setItem(PAGE_STORAGE_KEY, JSON.stringify(config))
}

function getSort() {
    sortProductEle.value = config.sort
}

function countProduct() {
  quantityProductEle.textContent = itemProductsEle.length
}

function sort() {
    sortProductEle.onchange = () => {
        setSort("sort_color", "")
        setSort("sort", sortProductEle.value)
        if (sortProductEle.value == "") {
            window.location.href = "/plants"
        } else {
            window.location.href = "?sort=" + sortProductEle.value
        }
    }
}

function colorFilter() {
    colorCheckEle.forEach( (i) => {
        i.onclick = () => {
            setSort("sort", "")
            if (i.checked == true) {
                if (config.sort_color == "") {
                    sortColorId = config.sort_color + i.value;
                } else {
                    sortColorId = config.sort_color + "_" + i.value;
                }
                setSort("sort_color", sortColorId)
                console.log(config.sort_color);
                window.location.href = "?sort_color=" + config.sort_color
                    
                
            }
            else {
                sortColorId = config.sort_color.slice(0, - (i.value.length + 1));
                setSort("sort_color", sortColorId)
                if (config.sort_color == "") {
                    window.location.href = "/plants"
                } else {
                    window.location.href = "?sort_color=" + config.sort_color
                }
            }
        }
        
    })
}
function checkedColor() {
    config.sort_color.split("_").filter( i => i).forEach( (e) => {
        colorCheckEle.forEach( (i) => {
            if (i.value == e) {
                i.checked = true
            }
        })
    })
}

function categoryFilter(params) {
    categoryEle.onclick = () => {
        listCategoryEle.classList.toggle("hidden")
        if (category.getElementsByTagName("i")[0].classList.contains("fa-minus")) {
            category.getElementsByTagName("i")[0].classList.remove("fa-minus")
            category.getElementsByTagName("i")[0].classList.add("fa-plus")
        } else { 
            category.getElementsByTagName("i")[0].classList.remove("fa-plus")
            category.getElementsByTagName("i")[0].classList.add("fa-minus")
            
        }
    }

    targetItemsEle.forEach((i) => {
        i.onclick = () => {
            var value = i.getElementsByTagName("span")[0].getAttribute("value")
            setSort("filter", value)
            window.location.href = "?filter=" + value
        }
    })
}

function currentFilter(params) {
     
    categoryItemsEle.forEach( (i) => {
        if (config.category != "") {
            config.category.split("_").forEach( (c) => {
                if (i.getElementsByTagName('input')[0].value == c) {
                    i.getElementsByTagName('input')[0].checked = true
                }
            })
        }
        i.onclick = () => {
            var listChildCategory = Array.from(i.parentNode.getElementsByTagName('input')).slice(1)
            categoryDetailStorage = config.category_detail
            listChildCategory.forEach( (e) => {
                if (config.category_detail.includes(e.value)) {
                    categoryDetailStorage = config.category_detail.replace(e.value, '')
                    setSort("category_detail", categoryDetailStorage)
                } else {
                    categoryDetailStorage += ("_" + e.value)
                    console.log(categoryDetailStorage);
                }
                
            })
            if (categoryDetailStorage.includes("__")) {
                categoryDetailStorage = categoryDetailStorage.replace("__", '_')
            }
            if (categoryDetailStorage.charAt(0) == "_") {
                categoryDetailStorage = categoryDetailStorage.slice(1)
            }
            switch (true) {
                case categoryDetailStorage.charAt(0) == "_":
                    categoryDetailStorage = categoryDetailStorage.slice(1)
                    setSort("category_detail", categoryDetailStorage)
                break;
                case categoryDetailStorage.charAt(categoryDetailStorage.length - 1) == "_":
                    categoryDetailStorage = categoryDetailStorage.slice(0, -1)
                    setSort("category_detail", categoryDetailStorage)
                break;
            }
            setSort("category_detail", categoryDetailStorage)
            
            var value = i.getElementsByTagName('input')[0].value
            
            if (config.category != "") {
                    if (config.category.includes(value)) {
                        categoryStorage = config.category.replace(value, '')
                        // listChildCategory.forEach( (child) => {
                        //     console.log(child.value);
                        //     categoryDetailStorage = config.category_detail.replace(child.value, '')
                        // })
                        // console.log(categoryDetailStorage);
                        // setSort("category_detail", categoryDetailStorage)
                        
                        if (categoryStorage.includes("__")) {
                            categoryStorage = categoryStorage.replace("__", '_')
                        }
                        switch (true) {
                            case categoryStorage.charAt(0) == "_":
                                categoryStorage = categoryStorage.slice(1)
                                setSort("category", categoryStorage)
                                break;
                            case categoryStorage.charAt(categoryStorage.length - 1) == "_":
                                categoryStorage = categoryStorage.slice(0, -1)
                                setSort("category", categoryStorage)
                            break;
                            default:
                                categoryStorage
                                setSort("category", categoryStorage)
                                break;
                        }
                    } else {
                        categoryStorage = config.category + "_" + value
                        setSort("category", categoryStorage)
                    }
                // })
            } else {
                categoryStorage = value
                setSort("category", categoryStorage)
            }
            const href = window.location.search.split("&")
            // console.log(href[2]);
            if (config.category == "") {
                window.location.href = href[0]
            } else {
                if (href[2] != undefined) {
                    window.location.href = href[0] + "&category=" + categoryStorage + href[2]
                    
                } else {
                    window.location.href = href[0] + "&category=" + categoryStorage + "&category_detail=" + categoryDetailStorage
                }
            }
            // [...i.parentNode.getElementsByClassName('category_name')].forEach( (c) => {
            //     c.classList.toggle('hidden')
            // })
            // if (i.getElementsByTagName('input')[0].checked == false) {
            //     i.getElementsByTagName('input')[0].checked = true
                
            // }
            // else {
            //     i.getElementsByTagName('input')[0].checked = false

            // }
        }
    })
    categoryNameEle.forEach( (i) => {
        if (config.category_detail != "") {
            config.category_detail.split("_").forEach( (c) => {
                if (i.getElementsByTagName('input')[0].value == c) {
                    i.getElementsByTagName('input')[0].checked = true
                }
            })
        }
        i.onclick = () => {
            var checkFalseCheckbox = Array.from(i.parentNode.getElementsByTagName('input')).slice(1).every((i) => {
                if (i.checked == false) {
                    return true
                } else {
                    return false
                }
            })
            if (checkFalseCheckbox == true) {
                categoryStorage = config.category.replace(i.parentNode.childNodes[1].getElementsByTagName('input')[0].value, '')
                console.log(categoryStorage);
                setSort("category", categoryStorage)
            }
            // console.log(config.category);
            

            var value = i.getElementsByTagName('input')[0].value
            
            if (config.category_detail != "") {
                    if (config.category_detail.includes(value)) {
                        categoryDetailStorage = config.category_detail.replace(value, '')
                        if (categoryDetailStorage.includes("__")) {
                            categoryDetailStorage = categoryDetailStorage.replace("__", '_')
                        }
                        switch (true) {
                            case categoryDetailStorage.charAt(0) == "_":
                                categoryDetailStorage = categoryDetailStorage.slice(1)
                                setSort("category_detail", categoryDetailStorage)
                                break;
                            case categoryDetailStorage.charAt(categoryDetailStorage.length - 1) == "_":
                                categoryDetailStorage = categoryDetailStorage.slice(0, -1)
                                setSort("category_detail", categoryDetailStorage)
                            break;
                            default:
                                categoryDetailStorage
                                setSort("category_detail", categoryDetailStorage)
                                break;
                        }
                    } else {
                        categoryDetailStorage = config.category_detail + "_" + value
                        setSort("category_detail", categoryDetailStorage)
                    }
                // })
            } else {
                categoryDetailStorage = value
                setSort("category_detail", categoryDetailStorage)
            }
            
            // console.log(window.location.search.split("&")[0] + "&" + window.location.search.split("&")[1]);
            if (config.category_detail == "") {
                window.location.href = window.location.search.split("&")[0] + "&" + window.location.search.split("&")[1]
            } else {
                window.location.href = window.location.search.split("&")[0] + "&" + window.location.search.split("&")[1] + "&category_detail=" + categoryDetailStorage
            }
        }
    })
}

function showFilterSelected(params) {
    listCategoryShow.push(config.filter)
    listCategoryShow = listCategoryShow.concat(config.category.split('_'))
    // console.log(listCategoryShow);
    var htmlFilter = listCategoryShow.map( (item) => {
        return `<div class="filter_items mt-1 ml-1 border border-gray-600 rounded flex justify-center items-center">
                    <span class="text-sm mr-2 ml-1">${item}</span>
                    <i class="text-sm mt-1 mr-1 text-red-400 fas fa-times"></i>
                </div>`
    })
    
    listFilterEle.innerHTML = htmlFilter.join('')

    var itemsFilter = $$('.filter_item')
    itemsFilter.forEach( (item, index) => {
        item.onclick = () => {
            
        }
    })

}

function resetStorage(params) {
    if (window.location.search.includes("category") == false) {
        setSort("category", "")
    }
    if (window.location.search.includes("filter") == false) {
        setSort("filter", "")
    }
    if (window.location.search.includes("category_detail") == false) {
        setSort("category_detail", "")
    }
}