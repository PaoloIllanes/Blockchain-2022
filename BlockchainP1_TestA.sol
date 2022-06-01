// SPDX-License-Identifier:GPL-3.0
pragma solidity 0.8.0;
contract BlockchainP1_TestA{

     bool private closed = false;
     address private owner;
     event clientBuying(string name, address wallet, uint quantity);

    struct Product{
        uint id;
        string name;
        uint stock;
        uint price;
    }

     mapping(uint =>Product) public myProducts;
    


     constructor(){
        owner = msg.sender;
    }



    function addProduct(Product memory product)public{
         require(msg.sender == owner,"Solo el owner puede agregar un producto");
         require(bytes(product.name).length > 5, "El nombre del producto debe tener mas de 5 caracteres");
        myProducts[product.id] = Product(product.id, product.name, 0, product.price);

    }
    
    function increaseStock(uint productId, uint stockUnits)public{
         require(msg.sender == owner,"Solo el owner puede aumentar el stock.");
         myProducts[productId].stock += stockUnits;

    }

    function closeShop(bool state)public{
         require(msg.sender == owner,"Solo el owner puede cerrar la tienda.");
         closed = state;

    }

    function withdrawAllMoney() public {
        require(msg.sender == owner,"Solo el owner puede cerrar la tienda.");
        require(!closed,"La tienda esta cerrada.");
        payable(msg.sender).transfer(address(this).balance);
    }
    

   function buyProduct(uint id, uint units) public payable{
        require(!closed,"La tienda esta cerrada");
        Product memory product = myProducts[id];
        require((units * product.price) <= convertWeiToEther(msg.value), "No tienes suficiente dinero en tu cartera.");
        require(units <= product.stock, "No hay stock del producto.");
        
        myProducts[product.id].stock -= units;
        emit clientBuying(product.name , msg.sender, units);
        if(units > 10) {
            payable(msg.sender).transfer(product.price*(units-1));
        }else{
            payable(msg.sender).transfer(product.price*(units));
        }
    }

    function convertWeiToEther(uint amountInWei) private pure returns(uint) {
        return amountInWei / 10*18;
    }




}