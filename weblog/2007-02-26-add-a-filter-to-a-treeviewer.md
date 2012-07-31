---
date: '2007-02-26 22:57:57'
layout: post
slug: add-a-filter-to-a-treeviewer
status: publish
title: Add a filter to a TreeViewer
wordpress_id: '144'
tags:
- eclipse
- java
- jmx
---

In [eclipse-jmx](http://code.google.com/p/eclipse-jmx/), a plug-in to manage Java applications through JMX, I have a view which displays registered MBeans using a TreeViewer.  
Since there can be many MBeans to display (e.g. more than 200 just for Tomcat), it is tedious to navigate in the Tree by expanding many nodes before finding the MBeans I want to manage.
To make it more usable, I wanted to add a filter text to the view to show only the MBeans which are interesting to me.

UI-wise, I wanted something like the Filtered Extensions of the PDE Editor:

![Filtered Extensions in the PDE Editor](http://download.eclipse.org/eclipse/downloads/drops/S-3.3M1-200608101230/images/filtered_extensions.png)

It shows only the extensions matching the filter text (and also displays the extensions categories).  


Since this screenshot was from [Eclipse 3.3M1 New & Noteworthy](http://download.eclipse.org/eclipse/downloads/drops/S-3.3M1-200608101230/eclipse-news-M1.html), I thought that this filter was not available for Eclipse 3.2 (or that it was specific to PDE).  
It turns out that I was wrong, it works on Eclipse 3.2, and it takes only 2 lines to add such behavior to any TreeViewer  using a [PatternFilter](http://help.eclipse.org/help32/topic/org.eclipse.platform.doc.isv/reference/api/org/eclipse/ui/dialogs/PatternFilter.html) and a [FilteredTree](http://help.eclipse.org/help32/topic/org.eclipse.platform.doc.isv/reference/api/org/eclipse/ui/dialogs/FilteredTree.html) (which are from the `org.eclipse.ui.workbench` plug-in).

Plain Old TreeViewer
-------------------------

The code to create the TreeViewer is straightforward:

<pre><code class='java'>public void createPartControl(Composite parent) {
    ...
    viewer = new TreeViewer(parent, SWT.MULTI | SWT.H_SCROLL | SWT.V_SCROLL);
    ...
}
</code></pre>

which, in eclipse-jmx, gives:

![MBean Explorer from eclipse-jmx 0.1.1](http://jmesnil.net/img/e-jmx/mbean-explorer-hierarchical_0.1.0.png)

PatternFilter & FilteredTree
-----------------------------------


To filter the tree's nodes, the code to change is minimal:

<pre><code class='java'>public void createPartControl(Composite parent) {
    ...
    PatternFilter patternFilter = new PatternFilter();
    final FilteredTree filter = new FilteredTree(parent, SWT.MULTI
            | SWT.H_SCROLL | SWT.V_SCROLL, patternFilter);
    viewer = filter.getViewer();
    ...
}
</code></pre>

With these 2 lines, a filter widget is displayed on top of the tree and the tree's nodes are automatically filtered based on the filter text:

![MBean Explorer from eclipse-jmx 0.1.2 with filter](http://jmesnil.net/img/e-jmx/mbean-explorer-filter_0.1.2.png)

Screenshot has been taken on Eclipse 3.3M5 which uses native search widgets (if one is available) to display the filter control.
It works also on Eclipse 3.2 but does not look so good.

By default, PatternFilter will display any nodes of the Tree whose label matches the filter text. By extending it, it is very simple to have more complex filter matching algorithm.   
It is the case in [eclipse-jmx](http://code.google.com/p/eclipse-jmx/): it displays any node whose descendant's leaves have an ObjectName which matches the filter text.

Kudos to the workbench team for this little UI nugget!
