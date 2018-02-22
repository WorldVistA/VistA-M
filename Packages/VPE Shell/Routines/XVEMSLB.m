XVEMSLB ;DJB/VSHL**VA KERNEL Library Functions - String [8/18/95 1:31pm];2017-08-15  5:03 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
STRING ;;;
 ;;; STRING FUNCTIONS - XLFSTR
 ;;;
 ;;; UP(x)......Uppercase
 ;;;      Convert string in x to all uppercase letters
 ;;;      Ex: W $$UP^XLFSTR("freedom")    --> "FREEDOM"
 ;;;
 ;;; LOW(x).....Lowercase
 ;;;      Comvert string in x to all lowercase letters
 ;;;      Ex: W $$LOW^XLFSTR("JUSTICE")   --> "justice"
 ;;;
 ;;; STRIP(x,y).....Strip a string
 ;;;      Strip all instances of character y in string x
 ;;;      Ex: W $$STRIP^XLFSTR("hello","e")   --> "hllo"
 ;;;
 ;;; REPEAT(x,y)....Repeat a string
 ;;;      Repeat the value of x for y number of times
 ;;;      Ex: W $$REPEAT^XLFSTR("-",10)   --> "----------"
 ;;;
 ;;; INVERT(x)....Invert a string
 ;;;      Invert the order of characters in string x
 ;;;      Ex: W $$INVERT^XLFSTR("ABC")   --> "CBA"
 ;;;
 ;;; REPLACE(in,.spec)....Replace strings
 ;;;      Replace specified strings
 ;;;      in  input string
 ;;;      spec  an array passed by reference
 ;;;      Ex: SET spec("aa")="a",spec("pqr")="alabama"
 ;;;          $$REPLACE^XLFSTR("aaaaaaapqraaaaaaa",.spec)   --> "aaaaalabamaaaaa"
 ;;;          SET spec("F")="File",spec("M")="Man"
 ;;;          $$REPLACE^XLFSTR("FM",.spec)  --> "FileMan"
 ;;;
 ;;; RJ(s,i,p)...Right Justify
 ;;; LJ(s,i,p)...Left Justify
 ;;; CJ(s,i,p)...Center Justify
 ;;;      Right,left,center Justify a character string
 ;;;      s = character string
 ;;;      i = field size
 ;;;      p = pad character(optional)
 ;;;      Ex: W "[",$$RJ^XLFSTR("SAM",10),"]"  --> [        SAM]
 ;;;          W "[",$$RJ^XLFSTR("SAM",10,"-"),"]"  --> [--------SAM]
 ;;;          W "[",$$LJ^XLFSTR("DON",10),"]"  --> [DON        ]
 ;;;          W "[",$$CJ^XLFSTR("SUE",10),"]"  --> [    SUE    ]
 ;;;***
