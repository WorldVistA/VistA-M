PSSHFREQ ;WOIFO/AV - VALIDATES FREQUENCY FOR DOSING ;09/20/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**136**;9/30/97;Build 89
 ;
 ;
 QUIT
 ;;
VALFREQ(FREQ) ;
 ;
 NEW PSS,RSLT
 ;
 SET FREQ=$$TRIM(FREQ)
 ;
 ; Invalid frequency exit routine
 IF FREQ="" QUIT 0
 ;
 SET FREQ=$$UPPER(FREQ)
 ;
 ; Determine if frequency has decimals, if so invalid
 IF FREQ["." QUIT 0
 ; Determine if frequency is a number, if so it is valid
 IF FREQ?1.N QUIT 1
 ;
 ; Determine if frequency is one of the special frequency strings
 SET RSLT=$$SMPLFREQ(FREQ)
 IF RSLT=1 QUIT RSLT
 ;
 SET PSS("length")=$LENGTH(FREQ)
 SET PSS("firstCharacter")=$EXTRACT(FREQ,1,1)
 SET PSS("lastCharacter")=$EXTRACT(FREQ,PSS("length"),PSS("length"))
 ;
 ; Frequency must meet the following criteria else quit
 ; Length must be less than or equal to 4 or more than or equal to 3
 IF PSS("length")>4 QUIT 0
 IF PSS("length")<3 QUIT 0
 ; First character must be a Q or X
 ;IF (PSS("firstCharacter")'="Q")&&(PSS("firstCharacter")'="X") QUIT 0
 I "XQ"'[PSS("firstCharacter") Q 0
 ;
 SET PSS("result")=1
 IF PSS("length")=4  DO
 . ; Take two middle characters and ensure they are numbers
 . SET PSS("chrTemp1")=$EXTRACT(FREQ,2,2)
 . SET PSS("chrTemp2")=$EXTRACT(FREQ,3,3)
 . ; ASCII number characters are 48 - 57
 . SET PSS("intTemp1")=$ASCII(PSS("chrTemp1"))-48
 . SET PSS("intTemp2")=$ASCII(PSS("chrTemp2"))-48
 . ;
 . ; Ensure the two middle chars are numbers
 . IF PSS("intTemp1")<0 SET PSS("result")=0
 . IF PSS("intTemp1")>9 SET PSS("result")=0
 . IF PSS("intTemp2")<0 SET PSS("result")=0
 . IF PSS("intTemp2")>9 SET PSS("result")=0
 . QUIT
 ;
 IF PSS("length")=3  DO
 . ; Take two middle characters 
 . SET PSS("chrTemp1")=$EXTRACT(FREQ,2,2)
 . ; ASCII number characters are 48 - 57
 . SET PSS("intTemp1")=$ASCII(PSS("chrTemp1"))-48
 . ;
 . ; Ensure the middle char is a number
 . IF PSS("intTemp1")<0 SET PSS("result")=0
 . IF PSS("intTemp1")>9 SET PSS("result")=0
 . QUIT
 ;
 IF PSS("result")=0 QUIT 0
 ;
 ; validate the first and last character
 ; If Q is first character
 SET PSS("qResult")=""
 IF PSS("firstCharacter")="Q"  DO
 . IF PSS("lastCharacter")="D" SET PSS("qResult")=1 QUIT
 . IF PSS("lastCharacter")="W" SET PSS("qResult")=1 QUIT
 . IF PSS("lastCharacter")="L" SET PSS("qResult")=1 QUIT
 . IF PSS("lastCharacter")="H" SET PSS("qResult")=1 QUIT
 . IF PSS("qResult")="" SET PSS("qResult")=0
 . QUIT
 ;
 IF PSS("qResult")'="" QUIT PSS("qResult")
 ;
 ; If X is first character
 SET PSS("xResult")=""
 IF PSS("firstCharacter")="X"  DO
 . IF PSS("lastCharacter")="D" SET PSS("xResult")=1 QUIT
 . IF PSS("lastCharacter")="W" SET PSS("xResult")=1 QUIT
 . IF PSS("lastCharacter")="L" SET PSS("xResult")=1 QUIT
 . IF PSS("xResult")="" SET PSS("xResult")=0
 . QUIT
 IF PSS("xResult")'="" QUIT PSS("xResult")
 ;
 QUIT 0
 ;;
SMPLFREQ(FREQ) ;
 ; @DESC Determines if the frequency is one of the special
 ; frequency strings that is accepted
 ; 
 ; @FREQ Frequency passed in
 ; 
 ; @RETURNS 1 if is valid frequency or 0 if not one of special
 ; frequencies
 ; 
 NEW VAL,RSLT,FREQS
 ;
 ; Hash of valid frequencies
 SET FREQS("QD")=""
 SET FREQS("BID")=""
 SET FREQS("TID")=""
 SET FREQS("QID")=""
 SET FREQS("QAM")=""
 SET FREQS("QSHIFT")=""
 SET FREQS("QOD")=""
 SET FREQS("QHS")=""
 SET FREQS("QPM")=""
 ;
 SET VAL=""
 SET RSLT=0
 FOR  SET VAL=$ORDER(FREQS(VAL)) QUIT:VAL=""  DO
 . ; Iterate through valid frequencies and determine
 . ; if frequency parameter is a match return 1
 . IF FREQ=VAL SET RSLT=1 QUIT
 . QUIT
 ;
 QUIT RSLT
 ;;
TRIM(TEXT) ;
 ;Trims the leading and trailing whitespace from a String
 ;
 ;Trim leading whitespace
 SET TEXT=$$TRIMLEAD(TEXT)
 ;Trim trailing whitespace
 SET TEXT=$$TRIMEND(TEXT)
 QUIT TEXT
 ;;
TRIMLEAD(TEXT) ;
 ;Trims the leading whitespace from a String
 ;
 NEW LENGTH,N,FLAG,CHAR,TEMPTEXT,MOD
 ;
 ;Ensure the String contains a value
 IF $DATA(TEXT)=0 SET TEXT="" QUIT TEXT
 SET LENGTH=$LENGTH(TEXT)
 ;Ensure the String is not empty
 IF LENGTH=0 QUIT TEXT
 ;
 ;Initialize the flag
 S FLAG=0,N=0,MOD=0
 ;Loop through
 FOR  SET N=N+1 QUIT:N>LENGTH!(FLAG=1)  DO
 .SET CHAR=$EXTRACT(TEXT,N)
 .IF CHAR=" " SET TEMPTEXT=$EXTRACT(TEXT,N+1,LENGTH),MOD=1
 .IF CHAR'=" "  SET FLAG=1
 .QUIT  ;End for loop
 ;Save the new text to the passed in variable
 IF MOD=1 SET TEXT=TEMPTEXT
 QUIT TEXT
 ;;
TRIMEND(TEXT) ;
 ;Trims the trailing whitespace from a String
 ;
 NEW LENGTH,N,FLAG,CHAR,TEMPTEXT,MOD
 ;
 ;Ensure the String contains a value
 IF $DATA(TEXT)=0 SET TEXT="" QUIT TEXT
 SET LENGTH=$LENGTH(TEXT)
 ;Ensure the String is not empty
 IF LENGTH=0 QUIT TEXT
 ;
 ;Initialize the flag, counter, and modification indicator variables
 S FLAG=0,N=LENGTH+1,MOD=0
 ;Loop through
 FOR  SET N=N-1 QUIT:N=0!(FLAG=1)  DO
 .SET CHAR=$EXTRACT(TEXT,N)
 .;WRITE !,"CHAR: ",CHAR
 .IF CHAR=" " SET TEMPTEXT=$EXTRACT(TEXT,1,N-1),MOD=1
 .IF CHAR'=" "  SET FLAG=1
 .QUIT   ;End for loop
 ;Save the new text to the passed in variable
 IF MOD=1 SET TEXT=TEMPTEXT
 QUIT TEXT
 ;;
UPPER(TEXT) ;
 ; @DESC Converts lowercase characters to uppercase
 ;
 ; @TEXT Text to be converted
 ; 
 ; @RETURNS Text in all UPPPERCASE
 ;
 NEW LOWER,UPPER
 ;
 SET LOWER="abcdefghijklmnopqrstuvwxyz"
 SET UPPER="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 SET TEXT=$TRANSLATE(TEXT,LOWER,UPPER)
 ;
 QUIT TEXT
 ;;
