# Install Python2 and Python3 + libraries

pip install -r ./requirements.txt

if ! type "python3" > /dev/null; then
    brew install python3
fi
    python3 --version
    mkdir ~/.virtualenvs
    # base python3 environment
    python3 -m venv ~/.virtualenvs/base
    source ~/.virtualenvs/base/bin/activate
    pip3 install -r ./requirements.txt
    deactivate
