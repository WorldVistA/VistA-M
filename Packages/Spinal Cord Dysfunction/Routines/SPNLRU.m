SPNLRU ;ISC-SF/GB-SCD UTILITIES FOR REPORT PRINTING ;6/23/95  12:04
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
MEDIAN(TOTITEMS,ARRAY)  ; Function returns median value of array.  Info at end.
 N EVEN,TARGET,NUMITEMS,MEDIAN,VALUE
 Q:'TOTITEMS 0
 S EVEN='(TOTITEMS#2) ; Is number of items even or odd?
 S TARGET=(TOTITEMS+1)\2 ; Which item do we want to reach?
 S VALUE=-1,NUMITEMS=0 ; Step thru array, looking for target.
 F  S @("VALUE=$O("_ARRAY_VALUE_"))") D  Q:NUMITEMS'<TARGET
 . S @("NUMITEMS=NUMITEMS+$G("_ARRAY_VALUE_"))")
 I VALUE="" W !,"MEDIAN:  We hit the end of the array, but shouldn't have" Q 0
 S MEDIAN=VALUE
 I EVEN,(NUMITEMS=TARGET) D  ; May need to get next value and average.
 . S @("VALUE=$O("_ARRAY_VALUE_"))")
 . S MEDIAN=(MEDIAN+VALUE)/2
 Q MEDIAN
 ; The median value in an array of an odd number of items is
 ; the value of the middle item.  (If there are 5 items, the 3rd is
 ; the median.)
 ; The median value in an array of an even number of items is the
 ; average of the two middle items.  (If there are 6 items, the median
 ; is the average of the 3rd and 4th items.)
 ; Example:
 ;                  values   number of items per value
 ;                       |   |
 ; S GBTEST(1,"CT","IP",30)=3
 ; S GBTEST(1,"CT","IP",148)=1
 ; S GBTEST(1,"CT","IP",160)=1
 ; S GBTEST(1,"CT","IP",365)=1
 ; So we've got 3 items with a value of 30, and 1 item each at 148,
 ; 160, and 365.
 ; S TOTITEMS=6   (That's 3+1+1+1)
 ; Now invoke the function.  The first arg is the total number of items.
 ; The second arg is the 'root' of the array up to, but not including
 ; the values.  The root must be in quotes.
 ; S MEDVAL=$$MEDIAN(TOTITEMS,"GBTEST(1,""CT"",""IP"",")
 ; (MEDVAL should be 89)
GETNAME(DFN,NAME,SSN) ;
 N VADM,VA,I ; I need to do this because DEM^VADPT kills I, which is
 ;      used as a looping variable by many routines which call GETNAME.
 I $D(^DPT(DFN,0)) D
 . ; If the user has the correct key...
 . I $D(^XUSEC("SPNL SCD PTS",DUZ)) D
 . . D DEM^VADPT
 . . S NAME=$E(VADM(1),1,30)
 . . S SSN=VA("PID")
 . E  D
 . . S NAME="Not Revealed"
 . . S SSN=""
 E  D
 . S NAME="Not in PATIENT FILE!"
 . S SSN=""
 Q
CENTER(STRING,LINELEN) ; Function centers a string
 N POSN,LBLANKS
 I '$D(LINELEN) S LINELEN=IOM
 S POSN=(LINELEN-$L(STRING))\2
 I POSN<2 Q STRING
 S LBLANKS="",$P(LBLANKS," ",POSN-1)=""
 Q LBLANKS_STRING
PAD(STRING,LINELEN) ; Function pads a string with spaces on the right
 N BLANKS,NUMBLANK
 I '$D(LINELEN) S LINELEN=IOM
 S NUMBLANK=LINELEN-$L(STRING)
 I NUMBLANK<1 Q STRING
 S BLANKS="",$P(BLANKS," ",NUMBLANK)=""
 Q STRING_BLANKS
HEADER(TITLE,ABORT) ;
 N DIR,DIRUT,I,TODAY,LENTITLE
 ; If we are printing to the screen and we are not printing the
 ; first page of the report, "Press return to continue..."
 S SPNPAGE=SPNPAGE+1
 I $G(IOST)["C-"&(SPNPAGE'=1) D  Q:ABORT
 . S DIR(0)="E"
 . D ^DIR
 . I $D(DIRUT) S ABORT=1
 W @IOF
 I $G(IOST)'["C-" D
 . S TODAY=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 . S TITLE(1)=TODAY_$E(TITLE(1),$L(TODAY)+1,999)
 . S LENTITLE=$L(TITLE(1))
 . S TITLE(1)=TITLE(1)_$J("Page "_SPNPAGE,IOM-LENTITLE)
 S I="" F  S I=$O(TITLE(I)) Q:I=""  W !,TITLE(I)
 W !
 I IOST'["C-" S TITLE(1)=$E(TITLE(1),1,LENTITLE)
 Q
