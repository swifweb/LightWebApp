import JavaScriptKitEmbedded
import String16

@_expose(wasm, "main")
func main() {
    var helloText = getElementById("helloText")
    helloText?.innerHTML = String16("Embedded Swift App").jsValue
    jsprint("Hello world")
    if let btn = getElementById("btn") {
        let clickClosure = JSClosure({ _ in
            jsprint("onclick ✅✅✅")
            return JSValue.undefined
        })
        btn[dynamicMember: "addEventListener"].function?.callAsFunction(this: btn.object!, String16("click").jsValue, clickClosure.jsValue)
    }
}

// Shortcut to `console.log`
func jsprint(_ str: String16) {
    JSObject.global.console.log.function?.callAsFunction(str.jsValue)
}

// Shortcut to `document.getElementById`
func getElementById(_ id: String16) -> JSValue? {
    guard let documentObject = JSObject.global.document.object else { return nil }
    let getElementById = JSObject.global.document.getElementById.function
    return getElementById?.callAsFunction(this: documentObject, id.jsValue)
}

// The following code is a hack to make JavaScriptKit compile
// since in the current `swift-wasm-DEVELOPMENT-SNAPSHOT-2024-06-14`
// snapshot _cdecl won't be taken from a dependency

@_cdecl("_call_host_function_impl")
func __call_host_function_impl(
    _ hostFuncRef: JSHFR,
    _ argv: UnsafePointer<RJSV>, _ argc: Int32,
    _ callbackFuncRef: JSOR
) -> Bool { _call_host_function_impl(hostFuncRef, argv, argc, callbackFuncRef) }
@_cdecl("_free_host_function_impl")
func __free_host_function_impl(_ hostFuncRef: JSHFR) {
    _free_host_function_impl(hostFuncRef)
}
@_cdecl("_library_features")
func __library_features() -> Int32 { _library_features() }