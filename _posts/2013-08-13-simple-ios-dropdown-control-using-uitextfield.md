---
layout: post
title: Simple iOS Dropdown Control using UITextField
---

The Native iOS controls do not specifically have a native control for a dropdown. What we want is a control that behaves like a HTML dropdown that uses a `UIPickerControl` in Safari.

`UITextField` is the "go to" for text input, but we can utilise the `inputView` property to display the `UIPickerControl` and then the `rightView` property to make the text field look like a dropdown.

 This is what we are looking to achieve:

![Native iOS dropdown]({{site.url}}/images/dropdown.jpg)

## The Arrow View

To create the dropdown arrow we create a `UIView` for the right hand side of the `UITextField`. You could use an `UIImageView` but I've chosen to subclass `UIView` and draw my own arrow in `drawInRect:`:

{% gist 6289895 RCDropdownArrowView.h %}
{% gist 6289895 RCDropdownArrowView.m %}


## Subclass UITextField

By subclass-ing `UITextField` we can easily add the `UIPickerControl` as the  `inputView` as well as the arrow view as the `rightView`.

{% gist 6289895 RCDropdown.h %}
{% gist 6289895 RCDropdown.m %}

## Usage

Within interface builder I can easily add `UITextField` controls to my view and change it's class to `RCDropdown`. All that is left to do is setup the data source for the picker control:

{% gist 6289895 RCRegisterViewController.m %}

I use the `tag` property in case I require multiple dropdowns.

## Additions

Things that are not included that would be nice is to have the arrow respond to touch events and the picker to use a "tick" image for selection as per Safari's dropdown picker.
