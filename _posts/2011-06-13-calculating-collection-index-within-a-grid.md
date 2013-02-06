---
layout: post
title: Calculating Collection Index Within a Grid
---

In my latest iOS app that I'm building I have the need for a grid view. iOS out of the box does not have a grid control, however I did find the awesome [DTGridView](http://danieltull.co.uk/blog/2009/10/28/dtgridview/) by Daniel Tull. This grid view uses the same concepts as the well known `UITableView` and recycles the grid cells to maintain memory over a large dataset.

With a grid view there will always come to a point where you will want to know the selected cell. In a table view this is really simple as the row index is equal to your collection index; however in a grid view this involves a little math. The math is not straight forward, but even us developers have brain block and can't even work out the simplest of equations.

For example given the following grid we want to work out the selected index at row 3 column 2:

	  |  0  1  2
	-------------
	0 |  0  1  2
	1 |  3  4  5
	2 |  6  7  8
	3 |  9  10 11
	
Ok so the answer from the grid above is 11 and the equation for this problem is:

	n * r + c
	

* n = number of columns
* r = row index
* c = column index

So in our problem:

	3 * 3 + 2 = 11
	
Correct!

This should work for any grid with any number of rows and columns. Remember that both the collection and grid have a zero based index.

Special thanks to [James Lynch](http://usingsystembeginner.blogspot.com/) for helping with figuring this out last thing on a Friday afternoon!
