#!/bin/bash

curl -i -X POST "http://localhost:3000/addDriver"\
	-H "Content-Type: application/json"\
	-d "$(cat ./addDriver.json)"
