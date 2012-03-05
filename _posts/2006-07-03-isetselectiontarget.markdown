---
date: '2006-07-03 15:29:00'
layout: post
slug: isetselectiontarget
status: publish
title: ⚑ Eclipse's ISetSelectionTarget interface
wordpress_id: '137'
tags:
- eclipse
---

I just found a new Interface in Eclipse which I found quite handy.

Let's say that you have an action which creates a new resource and you want to notify
views that they have to show this resource.

The key interface is [ISetSelectionTarget](http://help.eclipse.org/help31/topic/org.eclipse.platform.doc.isv/reference/api/org/eclipse/ui/part/ISetSelectionTarget.html).
If your views respond to this interface (by implementation or adaptation), they can then receive a `selectReveal(ISelection selection)` message.

For example, one of my view implements ISetSelectionTarget and defines the method:

        public void selectReveal(ISelection selection) {
           StructuredSelection ssel = convertSelection(selection);
           if (!ssel.isEmpty()) {
              viewer.getControl().setRedraw(false);
              viewer.setSelection(ssel, true);
              viewer.getControl().setRedraw(true);
           }
        }

How do you send this `selectReveal()` message from your action?  
An example is found in the JDT, in the `org.eclipse.ui.wizards.newresource.BasicNewResourceWizard` class:

      public static void selectAndReveal(IResource resource, IWorkbenchWindow window) {
        // validate the input
        if (window == null || resource == null)
            return;
        IWorkbenchPage page = window.getActivePage();
        if (page == null)
            return;

        // get all the view and editor parts
        List parts = new ArrayList();
        IWorkbenchPartReference refs[] = page.getViewReferences();
        for (int i = 0; i < refs.length; i++) {
            IWorkbenchPart part = refs[i].getPart(false);
            if (part != null)
                parts.add(part);
        }
        refs = page.getEditorReferences();
        for (int i = 0; i < refs.length; i++) {
            if (refs[i].getPart(false) != null)
                parts.add(refs[i].getPart(false));
        }

        final ISelection selection = new StructuredSelection(resource);
        Iterator itr = parts.iterator();
        while (itr.hasNext()) {
            IWorkbenchPart part = (IWorkbenchPart) itr.next();

            // get the part's ISetSelectionTarget implementation
            ISetSelectionTarget target = null;
            if (part instanceof ISetSelectionTarget)
                target = (ISetSelectionTarget) part;
            else
                target = (ISetSelectionTarget) part.getAdapter(ISetSelectionTarget.class);

            if (target != null) {
                // select and reveal resource
                final ISetSelectionTarget finalTarget = target;
                window.getShell().getDisplay().asyncExec(new Runnable() {
                    public void run() {
                        finalTarget.selectReveal(selection);
                    }
                });
            }
        }
      }

However, your code does not need to be that generic. If you already know which view may
be interested to be notified, you can use

    IViewPart part = page.findView(viewId):

to retrieve the interested `IViewPart` and after checking that it will respond to `ISetSelectionTarget`
(either by implementation or adaptation), you can send it a  `selectReveal()` message directly.

