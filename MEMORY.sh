#!/bin/bash

watch -n 5 'ps h -p '$1' -o %mem'
