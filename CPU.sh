#!/bin/bash

watch -n 5 -t 'ps h -p '$1' -o %cpu'

