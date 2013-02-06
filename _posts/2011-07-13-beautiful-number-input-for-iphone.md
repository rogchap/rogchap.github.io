---
layout: post
title: Beautiful Number Input for iPhone
---

Most text/number input is done with a `UIFextField`, but the text in the field can not be styled very well (ie. no shadow). It also has a blinking cursor which sometimes you just don't want.

I wanted to enter a number using the number pad, have a nice drop shadow on the text, no blinking cursor and as an added bonus would show the currency symbol at the start of the number:

![Sreenshot](https://github.com/rogchap/SampleProjects/raw/master/NumberInput/Screenshot.png)

## Hidden UITextField

The trick here is to have a `UITextField` with a `UILabel` in front. The `UILabel` needs to have a background color so to hide the text and cursor being entered into the text field.

Then all we need to do is hook up the `EditingChanged` event on the text field to then update our styled label:

{% highlight objc %}
- (IBAction)textChanged:(id)sender {

	int number = [_numberTextField.text intValue];

	// make sure we don't go beyond INT32_MAX
	if (number == INT32_MAX) {
		number = _currentNumber;
 		_numberTextField.text = [NSString stringWithFormat:@"%d", number];
	}

	_currentNumber = number;
	_numberLabel.text = [NSString stringWithFormat:@"%@%d", [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol], _currentNumber];
}
{% endhighlight %}

## Source on GitHub

Once again I've added a source project on GitHub so you can try it out for yourself:

[https://github.com/rogchap/SampleProjects/tree/master/NumberInput](https://github.com/rogchap/SampleProjects/tree/master/NumberInput)

## Not just Numbers

This technique will work on regular text too, and not just number. If you use this technique in any of your projects let me know as I would love to take a look at you implementation. :)

