import { fetchAddressByPostalCode } from '@/services/postal-code/postal-code';
import { showToast, setIsLoading } from '@/services/ui/message';

const elements = document.querySelectorAll<HTMLElement>(
  '[data-app-element-postal-code]',
);

elements.forEach((el) => {
  const all = JSON.parse(el.dataset.appElementPostalCode);
  console.log(all);

  const postalCodeEl = document.getElementById(
    all.postal_code,
  ) as HTMLInputElement;

  const prefectureEl = document.getElementById(
    all.prefecture,
  ) as HTMLInputElement;

  const cityEl = document.getElementById(
    all.city,
  ) as HTMLInputElement;

  const addressLine1El = document.getElementById(
    all.address_line1,
  ) as HTMLInputElement;

  el.addEventListener('click', async () => {
    console.log(postalCodeEl.value);

    const result = await fetchAddressByPostalCode(postalCodeEl.value);
    //console.log(result);
    if (result.success) {
      console.log(result.data);
      prefectureEl.value = result.data.prefcode;
      cityEl.value = result.data.address2;
      addressLine1El.value = result.data.address3;
    } else {
      showToast(result.message, 'alert');
    }
  });
});
