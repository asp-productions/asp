---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
type: "people"
draft: true

type: file
name: banner
label: Banner
description: Provide a banner image for this post
hidden: false
default "/uploads/2017/12/31/placeholder.jpg"
config:
  maxSize: 10
---
