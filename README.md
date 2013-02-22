# Utilities and Scripts for Haskell iOS Development

GHC build scripts based on the ghc-ios [wiki][ghc-ios] and
[ghc-ios-simple-setup][].

## Building GHC (iOS) Cross Compiler With These Scripts

Assuming this repository is in `~/ghc-ios-util`:

  1. Follow the [wiki][ghc-ios] instructions for installing
     dependencies (Xcode command line tools, LLVM, etc.).

  2. Check out the [ghc-ios](https://github.com/ghc-ios/ghc) repo:

        git clone https://github.com/ghc-ios/ghc.git ghc-ios
        cd ghc-ios
        ./sync-all get

  3. Update all "sub" repositories to the correct versions:

        sh ~/ghc-ios/util/ghc/checkout.sh

  4. Compile GHC:

        sh ~/ghc-ios/util/ghc/compile.sh

  5. Install:

        sudo mkdir -p /usr/local/ghc-ios
        sudo chown $USER /usr/local/ghc-ios
        make install

[ghc-ios]: https://github.com/ghc-ios/ghc/wiki
[simple]: https://github.com/jfischoff/ghc-ios-simple-setup
