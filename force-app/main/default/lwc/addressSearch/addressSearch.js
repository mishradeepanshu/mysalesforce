import { LightningElement, track, wire } from 'lwc';
import getAddressSet from '@salesforce/apex/AddressSearchController.getAddressSet';
import saveAddressDetailsbyId from '@salesforce/apex/AddressSearchController.saveAddressDetailsbyId';
import getAddressDetailsByPlaceId from '@salesforce/apex/AddressSearchController.getAddressDetailsByPlaceId';




export default class AddressSearch extends LightningElement {
    @track showModal = false;
    @track searchKey = '';
    @track addressList = [];
    @track addressDetails = {};

    openModal() {
        this.showModal = true;
    }

    closeModal() {
        this.showModal = false;
    }

    handleKeyPress(event) {
        this.searchKey = event.target.value;
        getAddressSet({ SearchText: this.searchKey })
            .then(result => {
                console.log('i am here', result);
                const addresses = JSON.parse(result).predictions;
                this.addressList = addresses.map(address => ({
                    main_text: address.structured_formatting.main_text,
                    secondary_text: address.structured_formatting.secondary_text,
                    place_id: address.place_id
                }));
            })
            .catch(error => {
                console.error('Error fetching address suggestions', error);
            });
    }

    selectAddress(event) {
        const placeId = event.currentTarget.dataset.value;
        console.log('Selected Place ID:', placeId);
    
        getAddressDetailsByPlaceId({ PlaceID: placeId })
            .then(result => {
                console.log('Address Details:', result);
                const address = JSON.parse(result).result;
                console.log(JSON.stringify(address));
    
                let streetNumber = '';
                let route = '';
                let city = '';
                let state = '';
                let postalCode = '';
                let country = '';
    
                address.address_components.forEach(component => {
                    if (component.types.includes('street_number')) {
                        streetNumber = component.long_name;
                    }
                    if (component.types.includes('route')) {
                        route = component.long_name;
                    }
                    if (component.types.includes('locality')) {
                        city = component.long_name;
                    }
                    if (component.types.includes('administrative_area_level_1')) {
                        state = component.short_name;
                    }
                    if (component.types.includes('postal_code')) {
                        postalCode = component.long_name;
                    }
                    if (component.types.includes('country')) {
                        country = component.long_name;
                    }
                });
    
                this.addressDetails = {
                    Street__c: `${streetNumber} ${route}`,
                    City__c: city,
                    State__c: state,
                    PostalCode__c: postalCode,
                    Country__c: country
                };
    
                console.log('Parsed Address Details:', JSON.stringify(this.addressDetails));
                this.closeModal();
            })
            .catch(error => {
                console.error('Error fetching address details', error);
            });
    }
    

    saveAddress() {
        const recordId = '';
        saveAddressDetailsbyId({
            id: recordId,
            addDetails: this.addressDetails
        })
        .then(() => {
            const event = new ShowToastEvent({
                title: 'Success',
                message: 'Address details updated successfully!',
                variant: 'success'
            });
            this.dispatchEvent(event);
        })
        .catch(error => {
            console.error('Error saving address', error);
        });
    }
}
