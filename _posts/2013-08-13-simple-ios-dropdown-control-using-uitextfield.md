---
layout: post
title: Simple iOS Dropdown Control using UITextField
published: false
---

The Native iOS controls do not specifically have a native control for a dropdown. What we want is a control that behaves like a HTML dropdown that uses a `UIPickerControl`.

`UITextField` is the "go to" for text input, but we can utilise the `inputView` property to display the `UIPickerControl` and then the `rightView` property to make the text field look like a dropdown.

 This is what we are looking to achieve:

![Native iOS dropdown]({{site.url}}/images/)

