const Inbox = artifacts.require('Inbox')

contract('inbox',accounts=>{

    it('getMessage',async ()=>{

        const instance = await Inbox.deployed();
        const message = await instance.getMessage.call();
        assert.equal(message,'HI')

    });

})