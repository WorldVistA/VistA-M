ALPBUTL ;OIFO-DALLAS MW,SED,KC-BCMA BCBU REPORT FUNCTIONS AND UTILITIES ;01/01/03
 ;;3.0;BAR CODE MED ADMIN;**8**;Mar 2004
 ;
DEFPRT() ; fetch and return default printer...
 ; returns default printer entry from Device file based on entry in
 ; DEFAULT MAR PRINTER field in BCMA BACKUP PARAMETERS file (53.71)
 N X
 S X=+$O(^ALPB(53.71,0))
 I X=0 Q ""
 Q $P($G(^%ZIS(1,+$P(^ALPB(53.71,X,0),"^",3),0)),U)
 ;
DEFDAYS() ; fetch and return default days for MAR printing...
 ; returns default number of days to print MARs based on entry in
 ; DEFAULT DAYS FOR MAR field in BCMA BACKUP PARAMETERS file (53.71)
 ; if null or undefined, returns default of 3 (days)
 N X
 S X=+$O(^ALPB(53.71,0))
 I X=0 Q 7
 Q +$P(^ALPB(53.71,X,0),"^",2)
 ;
MLRANGE(IEN) ; find first and last Med Log entries' date/time...
 ; IEN = patient's record number in file 53.7
 ; returns a delimited string = first Med Log date/time^last Med Log date/time
 N FIRST,LAST
 S FIRST=$O(^ALPB(53.7,IEN,"AMLOG",""))
 I FIRST="" Q "^"
 S FIRST=FIRST\1
 S LAST=$O(^ALPB(53.7,IEN,"AMLOG",""),-1)
 I LAST'="" S LAST=LAST\1
 I FIRST=LAST Q FIRST_"^"
 Q FIRST_"^"_LAST
 ;
PAD(STRING,SPACES) ; pad a string...
 ; STRING = a string passed by reference
 ; SPACES = number of spaces to concatenate onto STRING
 ; returns STRING padded with SPACES number of blank spaces
 N I,RESULT
 I $G(STRING)="" S STRING=" "
 I $G(SPACES)="" Q STRING
 S RESULT=STRING F I=$L(RESULT):1:SPACES S RESULT=RESULT_" "
 Q RESULT
 ;
FDAYS(START,DAYS,SPACE) ; format a sequence of DAYS beginning with START separated by SPACE...
 ; START = a date in FileMan internal format from which the formatted string will start
 ; DAYS  = the number of consecutive days to return in the formatted string
 ; SPACE = the number of spaces between each number in the formatted string
 ;         (if not passed, defaults to 4 spaces)
 ; returns a formatted string (example: 1    2    3)
 N DIM,I,J,RESULT,TODAY
 I $G(START)=""!($G(DAYS)="") Q ""
 I $G(SPACE)="" S SPACE=4
 S (RESULT,TODAY)=+$E(START,6,7)
 F I=1:1:SPACE S RESULT=RESULT_" "
 S DIM=$$DIM(START)
 F I=DAYS-1:-1:1 D
 .S TODAY=TODAY+1
 .I TODAY>DIM S TODAY=1
 .S RESULT=RESULT_$S(TODAY<10:"0"_TODAY,1:TODAY)
 .I I>1 D
 ..F J=1:1:SPACE S RESULT=RESULT_" "
 Q RESULT
 ;
FMONS(START,DAYS,SPACE) ; format a sequence of months given a START date separated by SPACE...
 ; START = a date in FileMan internal format the month of which will be the string starting point
 ; DAYS  = the number of days that will be displayed
 ; SPACE = the number of spaces between each month (defaults to 1 space)
 ; returns a string equal to the month or months depending upon the number of days passed
 ; for example:  if START=3021031 (Oct 31, 2002) and DAYS=3 then two month names will be
 ;               returned:  OCT NOV
 N DIM,I,J,MON,MON1,NEXTMON,RESULT,TODAY,XSPACE
 I $G(START)=""!($G(DAYS)="") Q ""
 I $G(SPACE)="" S SPACE=4
 S (XSPACE,XSTRIP)=""
 F I=1:1:SPACE+1 S XSPACE=XSPACE_"*",XSTRIP=XSTRIP_" "
 S DIM=$$DIM(START),TODAY=+$E(START,6,7),MON1=+$E(START,4,5)
 S (RESULT,MON)=$$MONN(MON1)
 I (TODAY+DAYS)<DIM!(TODAY+DAYS=DIM) Q RESULT
 F I=1:1:DAYS D
 .S RESULT=RESULT_XSPACE
 .S TODAY=TODAY+1
 .I TODAY<DIM!(TODAY=DIM) Q
 .S MON1=MON1+1
 .I MON1>12 S MON1=1
 .S MON=$$MONN(MON1),RESULT=RESULT_MON
 .S DIM=$$DIM($E(START,1,3)_$S(MON1<10:"0"_MON1,1:MON1)),TODAY=0
 F I=$L(RESULT):-1 Q:$E(RESULT,I)'="*"!(I=0)
 S RESULT=$E(RESULT,1,I),RESULT=$TR(RESULT,XSPACE,XSTRIP)
 Q RESULT
 ;
FDATES(START,DAYS,RESULTS) ;
 N I,X,X1,X2
 S RESULTS(0)=" "_$E(START,4,5)_"/"_$E(START,6,7)_" ",RESULTS(1)=START
 F I=1:1:DAYS-1 D
 .S X1=START,X2=I
 .D C^%DTC
 .S RESULTS(I+1)=X,RESULTS(0)=RESULTS(0)_" "_$E(X,4,5)_"/"_$E(X,6,7)_" "
 .K X,X1,X2
 Q
 ;
DIM(X) ; number of days in a specified month...
 ; X = a date in internal FileMan format (can be partial: YYYMM)
 ; returns a number representing the number of days in month X
 I $G(X)="" Q 0
 N DAYS,MON,YEAR
 S MON=+$E(X,4,5)
 I MON<1 Q 0
 S DAYS=$S(MON=1:31,MON=2:28,MON=3:31,MON=4:30,MON=5:31,MON=6:30,MON=7:31,MON=8:31,MON=9:30,MON=10:31,MON=11:30,MON=12:31,1:0)
 ; if passed date is in Feb, check for leap year and adjust days if needed...
 I MON=2 D
 .S YEAR=+$E(X,1,3)+1700
 .I $$LEAP^XLFDT2(YEAR) S DAYS=29
 Q DAYS
 ;
MONN(X) ; month name...
 ; X = month number (1-12)
 ; returns name of month specified in X
 I $G(X)="" Q ""
 S X=+X
 Q $S(X=1:"JAN",X=2:"FEB",X=3:"MAR",X=4:"APR",X=5:"MAY",X=6:"JUN",X=7:"JUL",X=8:"AUG",X=9:"SEP",X=10:"OCT",X=11:"NOV",X=12:"DEC",1:"")
 ;
FDATE(X) ; special format for a FileMan date/time...
 ; X = date and time (time is optional) in FileMan format
 ; returns the FileMan date/time in the format MM/DD/YY@HH:MM
 N DATE,FMDATE
 S DATE=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 S FMDATE=$$FMTE^XLFDT(X)
 I $P(FMDATE,"@",2)'="" S DATE=DATE_"@"_$P($P(FMDATE,"@",2),":")_":"_$P($P(FMDATE,"@",2),":",2)
 Q DATE
 ;
WARDLIST(DTYPE) ; list of wards on file...
 ; DTYPE = 'C' for vertical (columnar) list
 ;         'L' for horizontal list
 I $G(DTYPE)="" S DTYPE="L"
 N ALPBWARD
 W !,"Wards with BCMA Backup Data on this workstation:",!
 S ALPBWARD=""
 F  S ALPBWARD=$O(^ALPB(53.7,"AW",ALPBWARD)) Q:ALPBWARD=""  D
 .I DTYPE="L" D  Q
 ..I $X+$L(ALPBWARD)>IOM W !
 ..W ALPBWARD
 ..I $O(^ALPB(53.7,"AW",ALPBWARD))'="" W ", "
 .W !?5,ALPBWARD
 Q
 ;
WARDSEL(WARD,RESULTS) ; find a selected ward...
 ; WARD = a string representing a ward input by the user
 ; RESULTS = an array passed by reference in which possible matches are stored
 ; returns possible matches for the WARD in RESULTS
 N ALPBWARD,ALPBX
 S RESULTS(0)=0
 S ALPBWARD=""
 F  S ALPBWARD=$O(^ALPB(53.7,"AW",ALPBWARD)) Q:ALPBWARD=""  D
 .I ALPBWARD=WARD D  Q
 ..S RESULTS(0)=RESULTS(0)+1,RESULTS(RESULTS(0))=ALPBWARD
 .I ALPBWARD[WARD D
 ..S RESULTS(0)=RESULTS(0)+1,RESULTS(RESULTS(0))=ALPBWARD
 ; if a straight lookup failed, let's try making any alphas
 ; entered by the user uppercase and try it once more...
 I RESULTS(0)=0 D
 .S WARD=$$UP^XLFSTR(WARD)
 .S ALPBWARD=""
 .F  S ALPBWARD=$O(^ALPB(53.7,"AW",ALPBWARD)) Q:ALPBWARD=""  D
 ..I ALPBWARD=WARD D  Q
 ...S RESULTS(0)=RESULTS(0)+1,RESULTS(RESULTS(0))=ALPBWARD
 ..I ALPBWARD[WARD D
 ...S RESULTS(0)=RESULTS(0)+1,RESULTS(RESULTS(0))=ALPBWARD
 Q
 ;
OTYP(CODE) ; expand order type for printing...
 ; CODE = a character representing an order type
 ; returns expanded order type from ^DD(53.79,6,0)
 I $G(CODE)="" Q ""
 Q $S(CODE="U":"UNIT DOSE",CODE="V":"IV",CODE="P":"PENDING",1:CODE)
 ;
ORDS(IEN,DATE,RESULTS) ; retrieve orders for a given patient...
 ; IEN  = patient's record number in file 53.7
 ; DATE = the date/time used to determine whether all or only current
 ;        orders are returned:
 ;        >passed as a date/time in FileMan internal format -- only orders
 ;          with a stop date/time equal to or greater than DATE are returned
 ;        >passed = "" then all orders are returned regardless of status
 ; returns RESULTS(order# ien) -- note:  RESULTS(0)=count of active orders
 I +$G(IEN)=0 S RESULTS(0)=0 Q
 N ALPBX,ALPBY,ORDERDAT,ORDERIEN,ORDERST
 S (ORDERIEN,RESULTS(0))=0
 F  S ORDERIEN=$O(^ALPB(53.7,IEN,2,ORDERIEN)) Q:'ORDERIEN  D
 .S ORDERDAT(0)=$G(^ALPB(53.7,IEN,2,ORDERIEN,0))
 .S ORDERDAT(1)=$G(^ALPB(53.7,IEN,2,ORDERIEN,1))
 .S ORDERDAT(3)=$G(^ALPB(53.7,IEN,2,ORDERIEN,3))
 .S ORDERDAT(4)=$G(^ALPB(53.7,IEN,2,ORDERIEN,4))
 .S ORDERST=$P($P(ORDERDAT(0),"^",3),"~")
 .; is this order current?...
 .I $G(DATE)'=""&($P(ORDERDAT(1),"^",2)<$G(DATE)) K ORDERDAT Q
 .; if current, is it still active?...
 .I $G(DATE)'=""&(ORDERST'="CM")&(ORDERST'="ZS")&(ORDERST'="ZU") K ORDERDAT Q
 .S RESULTS(0)=RESULTS(0)+1
 .S RESULTS(ORDERIEN)=$P(ORDERDAT(0),"^")
 .S RESULTS("B",$P(ORDERDAT(0),"^"))=ORDERIEN
 .S RESULTS(ORDERIEN,1)=$S($P(ORDERDAT(3),"^")="V":"IV",$P(ORDERDAT(3),"^")="U":"UD",1:$P(ORDERDAT(3),"^"))
 .S RESULTS(ORDERIEN,2)=ORDERST
 .S RESULTS(ORDERIEN,3,0)=0
 .;S RESULTS(ORDERIEN,4)=$P($G(ORDERDAT(4)),"^",3)
 .S RESULTS(ORDERIEN,4)=$G(ORDERDAT(4))
 .I +$O(^ALPB(53.7,IEN,2,ORDERIEN,7,0)) D
 ..S ALPBX=0
 ..F  S ALPBX=$O(^ALPB(53.7,IEN,2,ORDERIEN,7,ALPBX)) Q:'ALPBX  D
 ...S ALPBY=RESULTS(ORDERIEN,3,0)+1
 ...S RESULTS(ORDERIEN,3,ALPBY)=$P(^ALPB(53.7,IEN,2,ORDERIEN,7,ALPBX,0),"^",2)
 ...S RESULTS(ORDERIEN,3,0)=ALPBY
 .I +$O(^ALPB(53.7,IEN,2,ORDERIEN,8,0)) D
 ..S ALPBX=0
 ..F  S ALPBX=$O(^ALPB(53.7,IEN,2,ORDERIEN,8,ALPBX)) Q:'ALPBX  D
 ...S ALPBY=RESULTS(ORDERIEN,3,0)+1
 ...S RESULTS(ORDERIEN,3,ALPBY)=$P(^ALPB(53.7,IEN,2,ORDERIEN,8,ALPBX,0),"^",2)_" (Additive)"
 ...S RESULTS(ORDERIEN,3,0)=ALPBY
 .I +$O(^ALPB(53.7,IEN,2,ORDERIEN,9,0)) D
 ..S ALPBX=0
 ..F  S ALPBX=$O(^ALPB(53.7,IEN,2,ORDERIEN,9,ALPBX)) Q:'ALPBX  D
 ...S ALPBY=RESULTS(ORDERIEN,3,0)+1
 ...S RESULTS(ORDERIEN,3,ALPBY)=$P(^ALPB(53.7,IEN,2,ORDERIEN,9,ALPBX,0),"^",2)_" (Solution)"
 ...S RESULTS(ORDERIEN,3,0)=ALPBY
 Q
 ;
DELPT(IEN) ; delete a patient's entire record...
 ; IEN = patient's record number in file 53.7
 N DA,DIK,X,Y
 S DA=IEN,DIK="^ALPB(53.7,"
 D ^DIK
 ; after deleting the patient, check for any error log
 ; entries and delete them...
 D CLEAN^ALPBUTL1(IEN)
 Q
 ;
DELORD(IEN,OIEN) ; delete an order from a patient's record...
 ; IEN  = patient's record number in file 53.7
 ; OIEN = order number's record number
 N DA,DIK,X,Y
 S DA=OIEN,DA(1)=IEN,DIK="^ALPB(53.7,"_DA(1)_",2,"
 D ^DIK
 Q
 ;
STATUS ; return last update date/time and count of any errors...
 N ALPBCNT,ALPBPARM
 S ALPBPARM=+$O(^ALPB(53.71,0))
 I ALPBPARM=0 W !,"NOTICE!  There is no entry in the BCMA BACKUP PARAMETERS FILE!" Q
 W !,"BCMA Backup System was last updated: ",$S($P($G(^ALPB(53.71,ALPBPARM,2)),"^")'="":$$FMTE^XLFDT($P(^ALPB(53.71,ALPBPARM,2),"^")),1:"UNKNOWN")
 S ALPBCNT=$$ERRCT^ALPBUTL2()
 I ALPBCNT>0 W !,"NOTICE! ",ALPBCNT_" filing error"_$S(ALPBCNT=1:" has",1:"s have")_" been logged."
 Q
