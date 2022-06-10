const IPFS = require('ipfs')
const express = require('express')
const OrbitDB = require('orbit-db')
const Identities = require('orbit-db-identity-provider')

const SphericalLawOfCosines = (lat1, lon1, lat2, lon2) => {
    const φ1 = lat1 * Math.PI / 180, φ2 = lat2 * Math.PI / 180, Δλ = (lon2 - lon1) * Math.PI / 180, R = 6371e3;
    const dist = Math.acos(Math.sin(φ1) * Math.sin(φ2) + Math.cos(φ1) * Math.cos(φ2) * Math.cos(Δλ)) * R;
    return dist;
}

const main = async () => {
    const ipfs = await IPFS.create({
        host: 'ipfs.infura.io',
        port: 5001,
        protocol: 'https'
    })
    const identity = await Identities.createIdentity({ id: 'test1' })
    const orbitdb = await OrbitDB.createInstance(ipfs, { identity })
    const optionsToWrite = {
        accessController: {
            type: 'orbitdb',
            write: [orbitdb.identity.id, identity.publicKey],
        },
    }
    const db = await orbitdb.docs('test', optionsToWrite)

    const app = express()

    app.use(express.json())

    app.post('/addDriver', async (req, res) => {
        const data = req.body
        console.log(data)
        await db.put(data)
    })

    app.get('/getDriverBy_id', async (req, res) => {
        const data = req.body
        const _id = data._id
        const query = db.query(doc => doc._id === _id)
        res.send(query)
    })

    app.get('/getCloseDrivers', async (req, res) => {
        const data = req.body
        riderLat = data.lat
        riderLong = data.long
        const query = db.query(doc => {
            driverLat = doc.lat
            driverLong = doc.long
            return SphericalLawOfCosines(riderLat, riderLong, driverLat, driverLong) < 500
        })
        res.send(query)
    })

    app.listen(3000, () => {
        console.log('Server listening on port 3000 👂')
    })
}

main()
