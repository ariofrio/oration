## Roadmap

**Version 0.4:** The Azure release

 - Both: More useful (stack traces) error reporting on frontend.
 - Azure: It works again.
 - Azure: Do logging in the code, not in the service definition.
 - Azure: Test suite for harness and apps.

**Version 0.5:** The AppEngine release
 - Both: Clean up the Cicero frontend API.
 - AppEngine: Support for Java.
 - AppEngine: Add a README.md with instructions (or a link).
 - AppEngine: Test suite for apps.

**Version 1.0**

 - Azure: Upload logging to a service like [Logentries][] (they have native
   support for Python and Java) [Loggly][], or [PaperTrail][].
 - Both: Support `stdout`-based apps with wrapper that modifies `sys.argv`
   and uses StringIO (Python), or supplies arguments to `main()` and uses 
   `System.setOut()` (Java).

  [logentries]: http://logentries.com/
  [loggly]: http://loggly.com/
  [papertrail]: http://papertrailapp.com/
