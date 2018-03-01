# Homebrew

## Files
There are two lists

 * casks: list of casks recipes
 * packages: list of packages

## Instructions

1. [Install Homebrew](https://brew.sh/index_it)
  
  ```
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  ```
2. Install packages and cask recipes

  ```
  brew install $(cat packages)
  brew cask install $(cat casks)
  ``` 
  or
  
  ```
  brew install $(<packages)
  brew cask install $(<casks)
  ```

