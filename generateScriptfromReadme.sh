#!/bin/bash

README=${1:-README.md}  

sed '/^.*step.*()/,/^}$/!d' $README

