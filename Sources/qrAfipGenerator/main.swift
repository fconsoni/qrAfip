import QRCore

do {
    try QRCore().run()
} catch let error as QRError {
    print(error.description())
} catch {
    print(error)
}

