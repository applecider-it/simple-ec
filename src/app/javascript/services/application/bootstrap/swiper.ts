import Swiper from "swiper";
import "swiper/css/bundle";
import { Autoplay, Pagination } from "swiper/modules";

console.log("SlideShow setup");

const swiper = new Swiper(".app-feature-swiper1", {
    modules: [Autoplay, Pagination],
    loop: true,
    speed: 1000,

    autoplay: {
        delay: 4000,
        disableOnInteraction: false,
    },
    pagination: {
        el: ".app-feature-swiper1-pagination",
        clickable: true,
    },
});
