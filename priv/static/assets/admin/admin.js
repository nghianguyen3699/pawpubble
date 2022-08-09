const $ = document.querySelector.bind(document)
const $$ = document.querySelectorAll.bind(document)

const meta = document.querySelector('meta[name="csrf-token"]');
const token = meta.content;

const PAGE_STORAGE_KEY = 'PAGE ADMIN'
var config = JSON.parse(localStorage.getItem(PAGE_STORAGE_KEY)) || {}

if (config.currentPage == undefined) {
    setPage('currentPage', 'user')
}

var navigaEle = $$('.item_naviga')
var mainContentEle = $$('.main_content')
var titleEle = $('#title')
var currentPage = 'user'
var paginationEle = $('.pagination')
var pageItemsEle = $$('.page-item')
var billOfLadingNoInputEle = $(".bill_lading_input")
var attsSearchEle = $('#atts_order')
var billLadingMainEle = $('.bill_lading_main')

function start() {
    addClassPagination()
    loadNav()
    changeNav()
    changeHrefPage()
    updateBillOfLadingNo()
    editBillOfLadingNo()
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
        if (item.getElementsByTagName('span')[0].textContent.toLowerCase() == config.currentPage) {
            item.parentNode.classList.add('bg-green-600')
            
        } else {
            item.parentNode.classList.remove('bg-green-600')
        }
        item.addEventListener('click', () => {
            // console.log(item.name);
            setPage('currentPage', item.name)          
        
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

function updateBillOfLadingNo(params) { 
    var btnUpdateNo = $$(".update_bill_lading_btn")
    btnUpdateNo.forEach( (ele) => {
        
        ele.onclick = () => {
            var idOrder = ele.parentNode.parentNode.parentNode.parentNode.childNodes[1].textContent.trim()
            var billOfLadingNoInputEle = ele.parentNode.parentNode.getElementsByTagName('input')
            // console.log(idOrder.textContent.trim());
            // console.log(billOfLadingNoInputEle);
            const data = {
                bill_of_lading_no: billOfLadingNoInputEle[0].value
            };
    
            fetch(`/admin/update-order/${idOrder}`, {
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
                location.reload();
            })
            .catch((error) => {
                console.error('Error:', error);
            });
        }
    })

}

function editBillOfLadingNo(params) {
    var editBillOfLadingNoBtn = $$('.edit_bill_lading_btn')
    editBillOfLadingNoBtn.forEach(ele => {
        ele.addEventListener('click', () => {
            ele.classList.toggle('hidden')
            ele.parentNode.getElementsByTagName('span')[0].classList.toggle('hidden')
            ele.parentNode.getElementsByClassName('bill_lading_input')[0].classList.toggle('hidden')
            ele.parentNode.getElementsByClassName('option_btn_bill_lading')[0].classList.toggle('hidden')
            ele.parentNode.getElementsByClassName('cancel_edit_bill_lading_btn')[0].classList.remove('hidden')
        })
    });
    
    var cancelEditBillLadingBtn = $$('.cancel_edit_bill_lading_btn')
    cancelEditBillLadingBtn.forEach(ele => {
        ele.addEventListener('click', () => {
            console.log(ele);
            ele.classList.toggle('hidden')
            ele.parentNode.classList.toggle('hidden')
            ele.parentNode.parentNode.getElementsByClassName('bill_lading_input')[0].classList.toggle('hidden')
            
            ele.parentNode.parentNode.getElementsByClassName('edit_bill_lading_btn')[0].classList.toggle('hidden')
            ele.parentNode.parentNode.getElementsByTagName('span')[0].classList.toggle('hidden')
            ele.parentNode.parentNode.getElementsByClassName('bill_lading_input')[0].classList.add('hidden')
            ele.parentNode.parentNode.getElementsByClassName('option_btn_bill_lading')[0].classList.add('hidden')
        })
    })
        // cancelEditBillLadingBtn.forEach

}