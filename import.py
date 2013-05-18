import sys, os

if len(sys.argv) > 1:
    # Just copy specified files
    all_files = sys.argv[1:]
else:
    # Import all files that aren't this one (and aren't already dotted)
    all_files = os.listdir('.')
    all_files = filter(lambda f: not f.startswith('.'), all_files)
    all_files.remove('import.py')

print "Importing: %s" % ', '.join(all_files)

def df(f):
    """Desired absolute path to dotfile"""
    return os.path.join(os.environ['HOME'], '.'+f)

for f in all_files:
    # Make .old file if it exists already
    if os.path.isfile(df(f)):
        print "Exists: %s" % df(f)
        os.system('cp %s %s.old' % (df(f), df(f)))
    else: print "Doesn't exist: %s" % df(f)
    os.system('cp %s %s' % (f, df(f)))

print "Done."
