const DriversContract = artifacts.require('DriversContract')

contract('DriversContract', () => {
    it('Testing the add driver function', async () => {
        const newDriversContract = await DriversContract.deployed()
        await newDriversContract.addDriver(
            'name 1',
            'car make 1',
            'registraion number 1',
            'email address 1',
            'residential address 1'
        )
        await newDriversContract.addDriver(
            'name 2',
            'car make 2',
            'registraion number 2',
            'email address 2',
            'residential address 2'
        )
        const result1 = await newDriversContract.driverPool(0)
        const result2 = await newDriversContract.driverPool(1)
        const count = await newDriversContract.driverCount()
        assert(result1.name === 'name 1')
        assert(result1.carMake === 'car make 1')
        assert(result1.regNumber === 'registraion number 1')
        assert(result1.email === 'email address 1')
        assert(result1.resAddress === 'residential address 1')
        assert(result2.name === 'name 2')
        assert(result2.carMake === 'car make 2')
        assert(result2.regNumber === 'registraion number 2')
        assert(result2.email === 'email address 2')
        assert(result2.resAddress === 'residential address 2')
    })
})
