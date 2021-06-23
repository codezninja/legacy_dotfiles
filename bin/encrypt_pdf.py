#!/usr/bin/python
# coding: utf-8

import os, sys
from Quartz import PDFDocument, kCGPDFContextAllowsCopying, kCGPDFContextAllowsPrinting, kCGPDFContextUserPassword, kCGPDFContextOwnerPassword
from CoreFoundation import (NSURL)

password = input("Enter your value: ")
copyPassword = password # Password for copying and printing
openPassword = copyPassword # Password to open the file.
# Set openPassword as '' to allow opening with no password.

def encrypt(filename):
    filename =filename.decode('utf-8')
    if not filename:
        print 'Unable to open input file'
        sys.exit(2)
    shortName = os.path.splitext(filename)[0]
    outputfile = shortName+".pdf"
    pdfURL = NSURL.fileURLWithPath_(filename)
    pdfDoc = PDFDocument.alloc().initWithURL_(pdfURL)
    if pdfDoc :
        options = {
            kCGPDFContextAllowsCopying: False,
            kCGPDFContextAllowsPrinting: False,
            kCGPDFContextOwnerPassword: copyPassword,
            kCGPDFContextUserPassword: openPassword}
        pdfDoc.writeToFile_withOptions_(outputfile, options)
    return

if __name__ == "__main__":
    for filename in sys.argv[1:]:
        encrypt(filename)
