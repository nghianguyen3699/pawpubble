const $ = document.querySelector.bind(document)
const $$ = document.querySelectorAll.bind(document)

const meta = document.querySelector('meta[name="csrf-token"]');
const token = meta.content;

const introduceSlide = $$('.introduce_slide')
const introduceSlideList = $('.introduce_slide_list')
const introduceSlideBtnNext = $('.introduce_slide_next_btn')
const introduceSlideBtnPrevious = $('.introduce_slide_previous_btn')
const pointSlide = $$('.point_slide')
var currentIntroduceSlide = 0


function start(params) {
    silde()
}

start()

function silde(params) {
    changePointSlide()
    introduceSlide.forEach((ele, index) => {
        ele.style.transform = `translateX(${100*index}%)`
    })
    introduceSlideBtnNext.addEventListener('click', () => {
        introduceSlide.forEach( (slide, index) => {
            slide.style.transform = `translateX(${100*(index - currentIntroduceSlide) - 100}%)`
        })
        if (currentIntroduceSlide < introduceSlide.length -1) {
            currentIntroduceSlide ++
        } else {
            currentIntroduceSlide = 0
            introduceSlide.forEach((ele, index) => {
                ele.style.transform = `translateX(${100*index}%)`
            })
        }
        changePointSlide()
    })
    introduceSlideBtnPrevious.addEventListener('click', () => {
        if (currentIntroduceSlide == 0) {
            currentIntroduceSlide = introduceSlide.length
        }
        console.log(currentIntroduceSlide);
        introduceSlide.forEach( (slide, index) => {
            slide.style.transform = `translateX(${100*(index - currentIntroduceSlide) + 100}%)`
        })
        currentIntroduceSlide --
        changePointSlide()

    })

}

function changePointSlide(params) {
    pointSlide.forEach( (ele, index) => {
        if (index == currentIntroduceSlide) {
            ele.classList.remove('bg-gray-500')
            ele.classList.add('bg-white')
        } else {
            ele.classList.remove('bg-white')
            ele.classList.add('bg-gray-500')

        }
    })
}