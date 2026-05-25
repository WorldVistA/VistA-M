PSSHFREQ ;WOIFO/AV - VALIDATES FREQUENCY FOR DOSING ; Sep 20, 2007@16:00
 ;;1.0;PHARMACY DATA MANAGEMENT;**136,254**;9/30/97;Build 109
 ;
 ;
 Q
 ;;
VALFREQ(FREQ) ; Validate Dosing Check Frequencies
 ; Input: FREQ - Frequency to be validated (e.g., "3XD", "Q5D", "Q1W", etc.)
 ;Output: VALFREQ - 1: Valid Frequency | 0: Invalid Frequency
 S FREQ=$$UP^XLFSTR($$TRIM(FREQ)) I FREQ=""!(FREQ[".") Q 0
 I FREQ?.N Q 1
 I (" QD BID TID QID QAM QSHIFT QOD QHS QPM QDAY QWEEK QMONTH "[(" "_FREQ_" ")) Q 1
 I $$FREQCHK^PSSJSV(FREQ)'="" Q 1
 Q 0
 ;
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
