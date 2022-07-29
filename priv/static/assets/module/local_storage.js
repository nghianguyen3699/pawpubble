
function setStorage(key, value, config, PAGE_STORAGE_KEY) {
    config[key] = value
    localStorage.setItem(PAGE_STORAGE_KEY, JSON.stringify(config))
}


export {setStorage}