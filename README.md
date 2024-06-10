How to use

1. Download latest Swift Wasm Development snapshot from [this](https://github.com/swiftwasm/swift/tags) page. Match it with the one that you find in `.vscode/setings/json`
2. Open it in VSCode with [Swift extension](https://marketplace.visualstudio.com/items?itemName=sswg.swift-lang) installed.
3. Open `Sources/LightWebApp.swift` and hit `Cmd+S` in order to make it build
4. Make sure it builds successfully
5. Make sure pytho3 is installed (`which python3` should give you a path to it)
5. Go to `Run and Debug` tab (Shift + Cmd + D) and run `Run hosting (LightWebApp)`
6. Open `http://127.0.0.1:8000/` in the browser and check that it shows `Embedded Swift App` in the center of the page and prints `Hello world` in the console
