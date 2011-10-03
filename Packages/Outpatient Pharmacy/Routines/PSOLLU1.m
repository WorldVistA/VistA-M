PSOLLU1 ;BHAM/RJS - LASER LABEL UTILITIES ;11/22/02
 ;;7.0;OUTPATIENT PHARMACY;**120,141,161**;DEC 1997
 ;
FONT(RLN,TEXT) ;
 ;--------------------------------------------------------------------
 ;VARIABLES:
 ;    INPUT:
 ; REQUIRED: RLN - Relates to a value used to determine the max
 ;                   line length.
 ;            TEXT - Can contain a string and the $L(TEXT) is used
 ;                    to calculate the font size.
 ;   RETURN:
 ;             FONT - This is the calculated optimal font size.
 ;                    F8, F9, F10 or F12 will be returned. 
 ;--------------------------------------------------------------------
 D STRT(RLN,TEXT,"",.FONT) Q FONT
 Q
 ;
STRT(RLN,TEXT,LNTH,FONT) ;
 ;  The LETTER array contains all the number of character per inch
 ;  for the different font sizes that can be used.
 N LN,LETTER,TXTIDX,SIZ,FNTIDX,LTTR,A
 S LETTER(1)="22^16^14^13^10",LETTER("!")="40^32^28^25^21"
 S LETTER(2)="22^16^14^13^10",LETTER("@")="11^8^7^7^5"
 S LETTER(3)="22^16^14^13^10",LETTER("#")="19^16^14^12^10"
 S LETTER(4)="22^16^14^13^10",LETTER("$")="20^18^16^14^12"
 S LETTER(5)="22^16^14^13^10",LETTER("%")="14^13^11^10^8"
 S LETTER(6)="22^16^14^13^10"
 S LETTER(7)="22^16^14^13^10",LETTER("&")="22^16^14^12^10"
 S LETTER(8)="22^16^14^13^10",LETTER("*")="30^23^20^18^15"
 S LETTER(9)="22^16^14^13^10",LETTER("(")="32^27^24^21^18"
 S LETTER(0)="22^16^14^13^10",LETTER(")")="32^27^24^21^18"
 S LETTER($C(34))="30^27^24^21^18",LETTER("'")="45^40^36^32^27"
 S LETTER("`")="30^27^24^21^18",LETTER("~")="18^15^13^12^10"
 S LETTER(",")="40^32^28^25^21",LETTER("<")="18^15^13^12^10"
 S LETTER(".")="35^27^24^21^18",LETTER(">")="18^15^13^12^10"
 S LETTER(";")="40^32^28^25^21",LETTER(":")="40^32^28^25^21"
 S LETTER("?")="22^16^14^12^10",LETTER("/")="40^32^28^25^21"
 S LETTER("[")="40^32^28^25^21",LETTER("{")="35^26^23^21^17"
 S LETTER("\")="40^32^28^25^21",LETTER("|")="42^34^30^27^23"
 S LETTER("]")="40^32^28^25^21",LETTER("}")="35^26^23^21^17"
 S LETTER("_")="20^15^14^12^10",LETTER("-")="30^27^24^21^18"
 S LETTER("=")="20^15^14^12^10",LETTER("+")="22^18^16^14^12"
 S LETTER(" ")="40^32^28^25^21"
 S LETTER("a")="19^16^14^12^10",LETTER("A")="16^13^11^10^8"
 S LETTER("b")="19^16^14^12^10",LETTER("B")="16^13^11^10^8"
 S LETTER("c")="22^18^16^14^12",LETTER("C")="15^13^11^10^8"
 S LETTER("d")="20^16^14^12^10",LETTER("D")="15^13^11^10^8"
 S LETTER("e")="20^16^14^12^10",LETTER("E")="16^13^11^10^8"
 S LETTER("f")="40^32^28^25^21",LETTER("F")="18^14^13^11^9"
 S LETTER("g")="20^16^14^12^10",LETTER("G")="14^11^10^9^7"
 S LETTER("h")="20^16^14^12^10",LETTER("H")="15^13^11^10^8"
 S LETTER("i")="50^40^36^32^27",LETTER("I")="40^32^28^25^21"
 S LETTER("j")="50^40^36^32^27",LETTER("J")="22^18^16^14^12"
 S LETTER("k")="24^18^16^14^12",LETTER("K")="16^13^11^10^8"
 S LETTER("l")="50^40^36^32^27",LETTER("L")="20^16^14^12^10"
 S LETTER("m")="13^10^9^8^7",LETTER("M")="13^11^10^9^7"
 S LETTER("n")="20^16^14^12^10",LETTER("N")="15^13^11^10^8"
 S LETTER("o")="20^16^14^12^10",LETTER("O")="14^11^10^9^7"
 S LETTER("p")="20^16^14^12^10",LETTER("P")="16^13^11^10^8"
 S LETTER("q")="20^16^14^12^10",LETTER("Q")="14^11^10^9^7"
 S LETTER("r")="35^32^28^25^21",LETTER("R")="15^13^11^10^8"
 S LETTER("s")="22^18^16^14^12",LETTER("S")="16^13^11^10^8"
 S LETTER("t")="40^32^28^25^21",LETTER("T")="18^14^13^11^9"
 S LETTER("u")="20^16^14^12^10",LETTER("U")="15^13^11^10^8"
 S LETTER("v")="23^18^16^14^12",LETTER("V")="16^13^11^10^8"
 S LETTER("w")="14^12^11^9^8",LETTER("W")="11^9^8^7^6"
 S LETTER("x")="23^18^16^14^12",LETTER("X")="16^13^11^10^8"
 S LETTER("y")="23^18^16^14^12",LETTER("Y")="16^13^11^10^8"
 S LETTER("z")="23^18^16^14^12",LETTER("Z")="18^14^13^11^9"
 ;
 ;  The LN array contains the length in inches for the different 
 ;  sections of the laser label.
 S LN("RX#")=3.126
 S LN("RXVAMC")=2.626
 S LN("DRG")=3.376
 S LN("SIG")=3.126
 S LN("WRN")=1.99
 S LN("ML")=2.376
 S LN("ML2")=1.76
 S LN("SEC2")=4.1876
 S LN("SEC2X")=LN("SEC2")
 S LN("SIG2")=LN("SEC2")
 S LN("SEC2B")=LN("WRN")
 S LN("FULL")=8.1876
 ;
 ; The LNTH array is used in calculating the length of the text
 ; for each of the different font sizes.
 S (LNTH(6),LNTH(8),LNTH(9),LNTH(10),LNTH(12))=""
 ;
 ; This section walks the TEXT string and extracts the each character
 ; then uses the LETTER array to lookup the number of characters per
 ; inch and calculates the length of the TEXT for each font.
 F TXTIDX=1:1:$L(TEXT) D
 .S LTTR=$E(TEXT,TXTIDX),A=$G(LETTER(LTTR),"18^16^14^12^10")
 .S LNTH(6)=LNTH(6)+(1/$P(A,U))
 .S LNTH(8)=LNTH(8)+(1/($P(A,U,2)))
 .S LNTH(9)=LNTH(9)+(1/($P(A,U,3)))
 .S LNTH(10)=LNTH(10)+(1/($P(A,U,4)))
 .S LNTH(12)=LNTH(12)+(1/($P(A,U,5)))
 ;
 ; This section determines what would be the optimal font for the TEXT
 I RLN="WRN" D  Q
 . I LNTH(12)<LN(RLN) S FONT="F12" Q
 . I LNTH(10)<(LN(RLN)*2) S FONT="F10" Q
 . I LNTH(9)<(LN(RLN)*2.5) S FONT="F9" Q
 . I LNTH(8)<(LN(RLN)*2.6) S FONT="F8" Q
 . S FONT="F6"
 S FONT="F0"
 I LNTH(8)<LN(RLN) S FONT="F8"
 I LNTH(9)<LN(RLN) S FONT="F9"
 I LNTH(10)<LN(RLN) S FONT="F10"
 I LNTH(12)<LN(RLN) S FONT="F12"
 Q
ADD ; Calculate the length and pad "_" to the end of TEXT for change of address
 ; then return FONT and TEXT to calling program.
 N NEEDED,CNT,DASH
 S NEEDED=LN("SEC2X")-LNTH(10)
 S CNT=NEEDED*12\1
 S DASH="________________________________________________________________________________________________________________"
 S TEXT2=TEXT_" "_$E(DASH,1,CNT)
 S FONT="F10"
 Q
