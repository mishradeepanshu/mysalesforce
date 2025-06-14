import { LightningElement,track } from 'lwc';
import productImage from '@salesforce/resourceUrl/sampleproductimage';

export default class EcommerceProductUI extends LightningElement {

    @track products = [
        {
          id: 1,
          name: 'Candle Support',
          image: 'https://growbiz3-dev-ed--c.develop.vf.force.com/resource/1736771861000/sampleproductimage',
          price: 65.0,
          originalPrice: null,
          isOnSale: false,
        },
        {
          id: 2,
          name: 'Ceramic Pumpkin',
          image: productImage,
          price: 59.0,
          originalPrice: 99.0,
          isOnSale: true,
        },
        {
          id: 3,
          name: 'Paper Pumpkin',
          image: productImage,
          price: 17.0,
          originalPrice: null,
          isOnSale: false,
        },
      ];
    
      handleAddToCart(event) {
        const productId = event.target.dataset.id;
        const product = this.products.find((p) => p.id === parseInt(productId));
        console.log(`Added ${product.name} to the cart.`);
        console.log(productImage);
      }
}
