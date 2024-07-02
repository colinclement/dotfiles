if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -f /Library/Frameworks/Python.framework/Versions/3.12/bin ]; then
    # Setting PATH for Python 3.12
    # The original version is saved in .zprofile.pysave
    PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:${PATH}"
    export PATH
fi
