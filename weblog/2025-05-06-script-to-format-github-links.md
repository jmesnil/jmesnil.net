---
layout: post
title: "Script to format GitHub links"
date: '2025-05-06 09:47:36'
category: 
tags: []
---

Almost all my code contributions go in various GitHub projects, either the original repositories or my forks.

Every time I use an URL to a GitHub issue or PR in Google Docs, Markdown or Asciidoc document, I update the link text
to be more descriptive so instead of displaying the raw URL as [https://github.com/wildfly/wildfly.org/pull/787](https://github.com/wildfly/wildfly.org/pull/787), it is displayed as
[[wildfly/wildfly.org#787] Add Jeff Mesnil GPG Signing info](https://github.com/wildfly/wildfly.org/pull/787).

I'm changing these links so often that I wrote a simple bash script to do it for me.
The script can take an GitHub issue or PR argument and will output the corresponding text: `[<org>/<repo>#<pr_or_issue>] <title>`:

```
#!/bin/bash

# Get URL from argument or clipboard
if [ -n "$1" ]; then
    URL="$1"
elif command -v pbpaste &>/dev/null; then
    URL="$(pbpaste)"
else
    echo "No URL provided and pbpaste is not available."
    exit 1
fi

# Extract repo and number from GitHub issue or PR URL
if [[ "$URL" =~ github\.com/([^/]+/[^/]+)/(issues|pull)/([0-9]+) ]]; then
    REPO="${BASH_REMATCH[1]}"
    NUMBER="${BASH_REMATCH[3]}"
else
    echo "Invalid GitHub issue or pull request URL: $URL"
    exit 1
fi

# Fetch and parse the <title> content
HTML_TITLE=$(curl -s "$URL" | sed -n 's:.*<title>\(.*\)</title>.*:\1:p' | head -n1)

# Decode HTML entities
HTML_TITLE=$(echo "$HTML_TITLE" | sed -e "s/&#39;/'/g" -e 's/&quot;/\"/g' -e 's/&amp;/\&/g')

# Remove ' by AUTHOR' (before any dot)
HTML_TITLE=$(echo "$HTML_TITLE" | sed -E 's/ by [^·]+//')

# Remove everything after the first literal '·' (U+00B7), regardless of spacing
CLEAN_TITLE=$(echo "$HTML_TITLE" | sed 's/·.*//')

# Final formatted output
OUTPUT="[$REPO#$NUMBER] $CLEAN_TITLE"

# Copy to clipboard
if command -v pbcopy &>/dev/null; then
    echo "$OUTPUT" | pbcopy
else
    echo "Warning: Clipboard tool not found."
fi

# Output to terminal
echo "$OUTPUT"

afplay /System/Library/Sounds/Tink.aiff
```

To make it even simpler to use on my Mac, if there are no argument, it will instead use the content from the clipboard with `pbpaste`.
It also copies the title to the clibpboard with `pbcopy` and play a sound when it is finished.

I saved this script as a "Format GitHub Link" shortcut with Apple Shortcuts to further streamline its use:

<figure>
<img src="#{ site.img_base_url }images/2025-05-format-github-link-screenhsot.png" alt="Screenshot of the shortcut">
<figcaption>Run the script as an Apple Shortcut
</figcaption>
</figure>

Now, When I want to add a GitHub link to a document, all I need to do is:

1. copy its link address (`⌘ C`)
2. paste it in my doc (`⌘ V`)
3. use the Spotligh launcher to run the script (`⌘ <space bar> > "Format"`)
4. After I hear the sound, copy the formatted title from the clipboard (`⌘ V`)

