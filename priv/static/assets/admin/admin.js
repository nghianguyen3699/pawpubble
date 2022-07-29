const $ = document.querySelector.bind(document)
const $$ = document.querySelectorAll.bind(document)

const meta = document.querySelector('meta[name="csrf-token"]');
const token = meta.content;

const PAGE_STORAGE_KEY = 'PAGE ADMIN'

var navigaEle = $$('.item_naviga')
var mainContentEle = $$('.main_content')
var titleEle = $('#title')
var currentPage = 'user'
var config = JSON.parse(localStorage.getItem(PAGE_STORAGE_KEY)) || {}
var paginationEle = $('.pagination')
var pageItemsEle = $$('.page-item')

function start() {
    addClassPagination()
    loadNav()
    changeNav()
    changeHrefPage()
}
start()

function setPage(key, value) {
    config[key] = value
    localStorage.setItem(PAGE_STORAGE_KEY, JSON.stringify(config))
}
function loadNav(params) {
    mainContentEle.forEach((ele) => {
        if (ele.id != config.currentPage) {
            ele.classList.add('hidden')
        }
        else {
            titleEle.textContent = ele.id.toUpperCase()
            ele.classList.remove('hidden')
        }
    })
}
function addClassPagination(params) {
    // paginationEle.classList.add('flex', 'justify-center', 'items-center', 'mt-8')
    pageItemsEle.forEach(ele => {
        ele.parentNode.classList.add('flex', 'justify-center', 'items-center', 'mt-8')
        ele.classList.add('ml-4', 'p-2', 'border')
        if (ele.classList.contains('active')) {
            ele.classList.add('bg-red-400', 'text-white')
        }
    });
}
function changeNav() {
    navigaEle.forEach(item => {
        
        item.addEventListener('click', () => {
            // console.log(item.name);
            setPage('currentPage', item.name)
            
            navigaEle.forEach(item => {
                item.classList.remove('border-blue-600', 'border-b-2')
            })
            item.classList.add('border-blue-600', 'border-b-2')
            mainContentEle.forEach((ele) => {
                // console.log(ele.id);
                if (ele.id != item.getAttribute('name')) {
                    ele.classList.add('hidden')
                }
                else {
                    titleEle.textContent = ele.id.toUpperCase()
                    ele.classList.remove('hidden')
                }
                
            })
        
    });
    })
}

function changeHrefPage(params) {
    var pageLink = Array.from($$('.page-link'))

    pageLink.forEach((item, index) => {
        if (item.textContent == '…') {
            pageLink.splice(index, 1)
        }
    })
    pageLink.forEach((item) => {
        let url = window.location.search
        let oldHref = ""
        console.log(url.split('='));
        switch (item.textContent) {
            case "Next":
                oldHref = "page=" + (parseInt(url.split('=').pop()) + 1)
                break;
            case "Prev":
                oldHref = "page=" + (parseInt(url.split('=').pop()) - 1)
                break;
            default:
                oldHref = "page=" + item.textContent
                break;
        }
        if (url.includes('&page')) {
            url = url.split('&').slice(0, -1).join().replaceAll(',', '&')
        } 
        if (url != '') {
            if (url.includes('?page=')) {
                item.href = "?" + oldHref
            } else {
                item.href = url + "&" + oldHref
            }
        }
        // console.log(item);
    })
    
}