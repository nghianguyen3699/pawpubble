import { getAddress } from "/assets/module/fetch.js";

const $ = document.querySelector.bind(document)
const $$ = document.querySelectorAll.bind(document)

const meta = document.querySelector('meta[name="csrf-token"]');
const token = meta.content;

var titleContent = $$('.title_content')
var mainContent = $$('.main_content')

var emailEle = $('#email')
var phoneNumEle = $('#phone_number')
var inforProfileEle = $('#infor_profile')
var changeEmailEle = $('#change_email')
var changePhoneEle = $('#change_phone')
var oldEmailEle = $('#old_email')
var oldPhoneEle = $('#old_phone')
var phoneInputEle = $('.phone_input')
var emailInputEle = $('.email_input')
var oldEmailInputEle = $('.email_old_input')
var oldPhoneInputEle = $('.phone_old_input')
var errorEmailEle = $('.error_email')
var errorPhoneEle = $('.error_phone')
var oldErrorEmailEle = $('.error_old_email')
var oldErrorPhoneEle = $('.error_old_phone')
var changeEmailBtn = $('.change-email_button')
var changePhoneBtn = $('.change-phone_button')
var changeAddressBtn = $('.change-address_button')
var backAddressBtn = $('.back-address_button')
var backStep1Btn = $$('.back_icon_step1')
var checkOldEmailBtn = $('.check_old_email_btn')
var checkOldPhoneBtn = $('.check_old_phone_btn')
var submitEmailBtn = $('.submit_email')
var submitPhoneBtn = $('.submit_phone')
var avatarFormEle = $('#avatar_form')
var avatarInputFile = $('#avatar')
var fileImg = $('#avatar_image')
var submitAvatarBtn = $('.submit_avatar')
var uploadImageBtn = $('.upload_image')
var imageNameEle = $('.image_name')
var imageNameTitleEle = $('.image_name_title')
var removeImageDemoBtn = $('.remove_image_demo')
var removeAvatarBtn = $('.remove_avatar')
var emptyAvatarEle = $('.empty_avatar')
var provinceAddressSelectEle = $('#province')
var districtAddressSelectEle = $('#district')
var wardAddressSelectEle = $('#ward')
var addressMainEle = $('#address_main')
var changeAddressEle = $('.change_address')

var listAllAddress = null 


function start() {
    getAddress(renderAddress)
    transform()
    newEmailAndPhone()
    validateEmail(emailInputEle, errorEmailEle, submitEmailBtn)
    validateEmail(oldEmailInputEle, oldErrorEmailEle, checkOldEmailBtn)
    validatePhoneNumber(phoneInputEle, errorPhoneEle, submitPhoneBtn)
    validatePhoneNumber(oldPhoneInputEle, oldErrorPhoneEle, checkOldPhoneBtn)
    checkMatchEmailAndPhone()
    loadFileDemo()
    removeDemoAvatar()
}

start()


function transform(params) {
    titleContent.forEach( (ele) => {
        ele.addEventListener('click', () => {
            mainContent.forEach( (item) => {
                if (ele.getAttribute('name') == item.id) {
                    item.classList.remove('hidden')
                } else {
                    item.classList.add('hidden')
                }
            })
            
        })
    })
}
// -----------------------------PROFILE------------------------------//

function newEmailAndPhone(params) {
    changeEmailBtn.addEventListener('click', () => {
        inforProfileEle.classList.add('hidden')
        oldEmailEle.classList.remove('hidden')
        avatarFormEle.classList.add('hidden')
    })
    changePhoneBtn.addEventListener('click', () => {
        inforProfileEle.classList.add('hidden')
        oldPhoneEle.classList.remove('hidden')
        avatarFormEle.classList.add('hidden')
    })
    backStep1Btn.forEach( (ele, index) => {
        ele.addEventListener('click', () => {
            inforProfileEle.classList.remove('hidden')
            avatarFormEle.classList.remove('hidden')
            if (index == 0) {
                oldEmailEle.classList.add('hidden')              
            } else {
                oldPhoneEle.classList.add('hidden')
            }
        })
    })

}
function validateEmail(emailInput, errorEmail, btnSubmit) {
    if (errorEmail.classList.contains('email_invalid')) {
        errorEmail.textContent = "email is invalid"
        emailInput.classList.remove('border-red-600')
        onAndOffBtn(errorEmail, btnSubmit)
    }
    emailInput.addEventListener('blur', () => {
        if (emailInput.value.match(/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i)) {
            errorEmail.classList.add('hidden')
            emailInput.classList.remove('border-red-600')
            onAndOffBtn(errorEmail, btnSubmit)
        } else {
            errorEmail.classList.remove('hidden')
            emailInput.classList.add('border-red-600')
            onAndOffBtn(errorEmail, btnSubmit)
        }
    })
    emailInput.addEventListener('keyup', () => {
        errorEmail.classList.add('hidden')
        emailInput.classList.remove('border-red-600')
        onAndOffBtn(errorEmail, btnSubmit)
    })
}
function validatePhoneNumber(phoneInput, errorPhone, btnSubmit) {
    if (errorPhone.classList.contains('phone_invalid')) {
        errorPhone.textContent = "phone is invalid"
        phoneInput.classList.remove('border-red-600')
        // avatarFormEle.classList.add('hidden')
        onAndOffBtn(errorPhone, btnSubmit)
    }
    let length = 0
    phoneInput.addEventListener('blur', () => {
        if (phoneInput.value.length < 12) {
            errorPhone.classList.remove('hidden')
            phoneInput.classList.add('border-red-600')
            onAndOffBtn(errorPhone, btnSubmit)
        }
        if (phoneInput.value.charAt(3) != " " || phoneInput.value.charAt(7) != " ") {
            phoneInput.value = phoneInput.value.replaceAt(3, `${" " + phoneInput.value.charAt(3)}`)
            phoneInput.value = phoneInput.value.replaceAt(7, `${" " + phoneInput.value.charAt(7)}`)
            // if (phoneInput.value.length == ) {
                
            // }
        }
    })
    phoneInput.addEventListener('keyup', () => {
        let lengthPhoneNumber = phoneInput.value.length
        if (lengthPhoneNumber == 3 || lengthPhoneNumber == 7) {
            if (phoneInput.value.length > length) {
                phoneInput.value = phoneInput.value + " "
            }
        };
        length = phoneInput.value.length
        errorPhone.classList.add('hidden')
        phoneInput.classList.remove('border-red-600')
        onAndOffBtn(errorPhone, btnSubmit)
    })

}

function onAndOffBtn(errorEle, btn) {
    if (errorEle.classList.contains('hidden') == false) {
        btn.addEventListener('click', stopIt)
        btn.classList.remove('bg-green-400', 'hover:bg-green-600')
        btn.classList.add('bg-green-200', 'text-gray-500')
    } else {
        btn.removeEventListener('click', stopIt)
        btn.classList.add('bg-green-400', 'hover:bg-green-600')
        btn.classList.remove('bg-green-200', 'text-gray-500')
    }
}

function stopIt(e) {
    e.preventDefault();
    e.stopPropagation();
}

String.prototype.replaceAt = function(index, replacement) {
    if (index >= this.length) {
        return this.valueOf();
    }
 
    return this.substring(0, index) + replacement + this.substring(index + 1);
}

function checkMatchEmailAndPhone(params) {
    // checkOldEmailBtn.addEventListener('click', () => {
    //     window.location.href = "?oldEmail=" + oldEmailEle.value
    // })
    oldEmailInputEle.addEventListener('blur', () => {
        checkOldEmailBtn.href = "?oldemail=" + oldEmailInputEle.value
    })
    oldPhoneInputEle.addEventListener('blur', () => {
        let hrefOldPhone = oldPhoneInputEle.value.replace(/\s+/g, '')
        checkOldPhoneBtn.href = "?oldphone=" + hrefOldPhone
    })

}

function loadFileDemo(){
    checkSubmitBtnImageFile(avatarInputFile, submitAvatarBtn)
    checkRemoveBtnImageFile(fileImg, removeAvatarBtn)
    avatarInputFile.addEventListener('change', function(){
        if (fileImg.classList.contains('hidden')) {
            fileImg.classList.remove('hidden')
            emptyAvatarEle.classList.add('hidden')
        }
        var image = avatarInputFile.files[0]
        checkSubmitBtnImageFile(avatarInputFile, submitAvatarBtn)
        if (image) {
            fileImg.src = URL.createObjectURL(image)
            uploadImageBtn.classList.remove('bg-gray-100', 'hover:bg-gray-200', 'border-gray-300')
            uploadImageBtn.classList.add('bg-green-400', 'hover:bg-green-500', 'border-green-700')
            if (image.name.length > 20) {
                imageNameTitleEle.classList.remove('hidden')
                imageNameEle.textContent = image.name.slice(0, 9) + ".." + image.name.slice(-11)
            }
            
        }
    })
}
function checkSubmitBtnImageFile(InputFile, submitBtn) {

    if (InputFile.files[0]) {
        submitBtn.removeEventListener("click", stopIt)
        submitBtn.classList.add('bg-green-400', 'hover:bg-green-600')
        submitBtn.classList.remove('bg-green-200', 'text-gray-500')
        removeImageDemoBtn.classList.remove('hidden')
    } else {
        submitBtn.addEventListener("click", stopIt)
        submitBtn.classList.remove('bg-green-400', 'hover:bg-green-600')
        submitBtn.classList.add('bg-green-200', 'text-gray-500')
    }
}

function checkRemoveBtnImageFile(fileImg, removeBtn) {
    if (fileImg.classList.contains('hidden')) {
        removeBtn.addEventListener('click', stopIt)
        removeBtn.classList.remove('bg-red-500', 'hover:bg-red-600')
        removeBtn.classList.add('bg-red-200', 'text-gray-500')
    } else {
        removeBtn.removeEventListener('click', stopIt)
        removeBtn.classList.add('bg-red-500', 'hover:bg-red-600')
        removeBtn.classList.remove('bg-red-200', 'text-gray-500')
    }
}

function removeDemoAvatar(params) {
    var currentAvatar = false
    if (fileImg.classList.contains('hidden') == false) {
        currentAvatar = fileImg.src
    }
    removeImageDemoBtn.addEventListener('click', function() {
        avatarInputFile.value = null
        checkSubmitBtnImageFile(avatarInputFile, submitAvatarBtn)
        uploadImageBtn.classList.add('bg-gray-100', 'hover:bg-gray-200', 'border-gray-300')
        uploadImageBtn.classList.remove('bg-green-400', 'hover:bg-green-500', 'border-green-700')
        removeImageDemoBtn.classList.add('hidden')
        imageNameTitleEle.classList.add('hidden')
        if (currentAvatar == false) {
            fileImg.classList.add('hidden')
            emptyAvatarEle.classList.remove('hidden')
        } else {
            fileImg.src = currentAvatar
        }
    })
}

// -----------------------------PROFILE------------------------------//

function renderAddress(addressDataApi) {
    listAllAddress = addressDataApi
    var htmlsProvince = addressDataApi.map((item, index) => {
        return `
            ${index == 0 ? 
                `<option value="">Choose Province</option> 
                 <option value="${item.name}">${item.name}</option>`
              : `<option value="${item.name}">${item.name}</option>`
            }
        
        `
    })
    provinceAddressSelectEle.innerHTML = htmlsProvince.join('')

    provinceAddressSelectEle.addEventListener('change', () =>{
        listAllAddress.forEach((e) => {
            if (e.name == provinceAddressSelectEle.value) {
                console.log(e);
                var htmlsDistrict = e.districts.map((item, index) => {
                    return `
                        ${index == 0 ? 
                            `<option value="">Choose District</option> 
                             <option value="${item.name}">${item.name}</option>`
                          : `<option value="${item.name}">${item.name}</option>`
                        }
                    
                    `
                })
                districtAddressSelectEle.innerHTML = htmlsDistrict.join('')
                districtAddressSelectEle.addEventListener('change', () => {
                    e.districts.forEach((i) => {
                        if (i.name == districtAddressSelectEle.value) {
                            var htmlsWards = i.wards.map((item, index) => {
                                return `
                                    ${index == 0 ? 
                                        `<option value="">Choose District</option> 
                                         <option value="${item.name}">${item.name}</option>`
                                      : `<option value="${item.name}">${item.name}</option>`
                                    }
                                
                                `
                            })
                            wardAddressSelectEle.innerHTML = htmlsWards.join('')
                        }
                    })
                })
            }
        })
    })
    changeAddressBtn.addEventListener('click', () => {
        addressMainEle.classList.add('hidden')
        changeAddressEle.classList.remove('hidden')
    })
    backAddressBtn.addEventListener('click', () => {
        addressMainEle.classList.remove('hidden')
        changeAddressEle.classList.add('hidden')
    })
}