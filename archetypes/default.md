---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: true
# slug: "{{ replace .Name "-" " " | title }}"
slug: "{{ substr (md5 (printf "%s%s" .Date (replace .TranslationBaseName "-" " " | title))) 4 8 }}"
author: "Chris-dc"
description: ""
summary: ""
---

