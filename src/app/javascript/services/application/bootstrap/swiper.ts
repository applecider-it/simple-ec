import Swiper from "swiper";
import "swiper/css/bundle";
import { Autoplay, Pagination } from "swiper/modules";

console.log("SlideShow setup");

const swiper = new Swiper(".swiper1", {
    modules: [Autoplay, Pagination],
    loop: true,
    speed: 1000,

    autoplay: {
        delay: 4000,
        disableOnInteraction: false,
    },
    pagination: {
        el: ".swiper-pagination1",
        clickable: true,
    },
});
