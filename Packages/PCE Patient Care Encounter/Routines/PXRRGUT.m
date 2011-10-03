PXRRGUT ;ISL/PKR - General utilities for PCE Encounter reports. ;2/26/98
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**8,18,48**;Aug 12, 1996
 ;
 ;=======================================================================
EOR ;End of report display.
 I $E(IOST)="C",IO=IO(0) D
 . S DIR(0)="EA"
 . S DIR("A")="End of the report. Press ENTER/RETURN to continue..."
 . W !
 . D ^DIR K DIR
 Q
 ;
 ;=======================================================================
EXIT ;Clean things up.
 D ^%ZISC
 D HOME^%ZIS
 K DIRUT,DTOUT,DUOUT
 K ^TMP(PXRRXTMP)
 K ^XTMP(PXRRXTMP)
 Q
 ;
 ;=======================================================================
VLIST(SLIST,LIST,MESSAGE) ;Make sure all the elements of LIST are in
 ;SLIST.  If they are, then LIST is valid.  The elements of LIST can be
 ;separated by commas and spaces.
 N IC,LE,LEN,VALID
 S LIST=$TR(LIST,",","")
 S LIST=$TR(LIST," ","")
 ;Make the test case insensitive.
 S SLIST=$$UP^XLFSTR(SLIST)
 S LIST=$$UP^XLFSTR(LIST)
 S VALID=1
 S LEN=$L(LIST)
 I LEN=0 D
 . W !,"The list is empty!"
 . S VALID=0
 F IC=1:1:LEN D
 . S LE=$E(LIST,IC,IC)
 . I SLIST'[LE D
 .. W !,LE,MESSAGE
 .. S VALID=0
 Q VALID
 ;
 ;=======================================================================
USTRINS(STRING,CHAR) ;Given a string, which is assumed to be in alphabetical
 ;order and a character which is not already in the string insert the
 ;character into the string in alphabetical order. For example:
 ;STRING CHAR RETURNS
 ;CEQ     A    ACEQ
 ;CEQ     E    CEQ
 ;CEQ     F    CEFQ
 ;CEQ     T    CEQT
 ;
 N CH1,CH2,DONE,IC,LEN,STR
 S LEN=$L(STRING)
 ;Special case of empty STRING.
 I LEN=0 Q CHAR
 ;
 S DONE=0
 S STR=""
 S CH1=$E(STRING,1,1)
 I (CH1]CHAR) S STR=STR_CHAR_CH1,DONE=1
 E  S STR=STR_CH1
 I CH1=CHAR S DONE=1
 ;
 ;Special case of STRING of length 1.
 I (LEN=1)&('DONE) S STR=STR_CHAR,DONE=1
 ;
 F IC=2:1:LEN D
 . S CH2=$E(STRING,IC,IC)
 . I DONE S STR=STR_CH2
 . E  D
 .. I (CHAR]CH1)&(CH2]CHAR) S STR=STR_CHAR_CH2,DONE=1
 .. E  S STR=STR_CH2
 .. I CH2=CHAR S DONE=1
 .. S CH1=CH2
 ;
 ;If we made it all the way through the loop and we are still not
 ;done then append CHAR.
 I ('DONE) S STR=STR_CHAR
 Q STR
 ;
