import Lightbox from "bs5-lightbox"

document.addEventListener("turbo:load", () => {
    document.querySelectorAll(".photo-icon").forEach(el => el.addEventListener("click", Lightbox.initialize))
})