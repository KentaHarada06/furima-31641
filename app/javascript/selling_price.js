function add_tax_cal (){
  const taxRate = 0.1
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener('input', () => {
    const inputValue = priceInput.value;
    const addTaxPrice = document.getElementById("add-tax-price");
    let taxPrice = inputValue * taxRate
    addTaxPrice.innerHTML = `${taxPrice}`;
    const addProfit = document.getElementById("profit");
    let profitPrice = inputValue - taxPrice
    addProfit.innerHTML = `${profitPrice}`;
  })
}
window.addEventListener('load', add_tax_cal);