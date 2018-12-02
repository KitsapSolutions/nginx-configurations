## Notes on naming.

I prefer to name variables and methods with what the stated effect is going to be.

In the first version of the cache busting I named it "skip_cache". Good enough for that time.

However, the actual statement from Nginx is "BYPASS". And due to the application I am busting cache on is Wordpress...

So "skip_cache" becomes "wp_bypass_cache".

Make sense?

### TODO

Refactor the cache code into it's own wp-bypass-cache.conf file.
