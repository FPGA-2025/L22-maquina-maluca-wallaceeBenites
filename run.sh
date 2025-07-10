#!/bin/bash

iverilog -o tb *.v
./tb
