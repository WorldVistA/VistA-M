PRSXP79 ;WCIOFO/MGD-MANDATORY HOURS REPORT ;08/14/2002
 ;;4.0;PAID;**79**;Sep 21, 1995
 ;
 Q
 ;
 ; This program will create a report on the number of Normal Hours
 ; Unscheduled Hours, Overtime Hours and Compensatory Hours worked
 ; by nurses from the years 1997 through 2001.
 ;
 ; This program is read only and will not alter any VistA/PAID data.
 ;
 ; For more details see the patch description on FORUM.
 ;
START ; Main Driver
 ;
 K ^TMP($J),TMP
 N STANUM,TMP,U
 S U="^"
 W !!,"This report may take over an hour to run."
 D NOW^%DTC
 S Y=%
 D DD^%DT
 W !!,Y
 W !,">>>> Starting to compile reports.",!!
 ;
 ; Get Station Number
 ;
 S STANUM=$$KSP^XUPARAM("INST")_","
 S STANUM=$$GET1^DIQ(4,STANUM,99)
 ;
 D RPT
 W !!,">>>> Reports completed.  Mail messages sent."
 D NOW^%DTC
 S Y=%
 D DD^%DT
 W !,Y
 K %,TMP,^TMP($J),Y
 Q
 ;----------------------------------------------------------------;
RPT ; Reports                                                        ;
 ;----------------------------------------------------------------;
 ;
 N OCC,DATA0,EMP,PRS,SSN,STA,VISN
 ;
 ; Create Temporary Global listing of employees with OCCUPATION SERIES
 ; & TITLE Codes beginning with 0605,0610,0620 and 0621
 ;
EMP S EMP=0
 F  S EMP=$O(^PRSPC(EMP)) Q:'EMP  D
 . S DATA0=$G(^PRSPC(EMP,0))
 . Q:DATA0=""
 . S OCC=$E($P(DATA0,U,17),1,4)
 . I OCC="0605"!(OCC="0610")!(OCC="0620")!(OCC="0621") D
 . . S SSN=$P(DATA0,U,34)
 . . I SSN="" S SSN=$P(DATA0,U,9)
 . . Q:SSN=""
 . . S STA=+$P(DATA0,U,7)
 . . Q:'STA
 . . ;
 . . ; Get the VISN number from the employee's STATION NUMBER (#6)
 . . ;
 . . D PARENT^XUAF4("PRS",STA,"VISN")
 . . S (PRS,VISN)=""
 . . S PRS=$O(PRS("P",PRS))
 . . Q:'PRS
 . . S VISN=$P(PRS("P",PRS),U,1)
 . . Q:VISN=""
 . . S ^TMP($J,OCC,EMP)=SSN_"^"_VISN_"^"_STA
 Q:'$D(^TMP($J))
 ;
 ; Get IEN for year in files
 ;
IEN N IEN458,IEN459,PP,PRSD,XPDIDTOT,YEAR
 S PRSD("TOT")=131 ; # of pay period processed
 S PRSD("IE")=0    ; # of Items Evaluated
 S XPDIDTOT=PRSD("TOT") ; Set total for Status Bar
 S PRSD("UPD")=5 ; Initial % required to update Status Bar
 F YEAR=97,98,99,"00","01" D
 . F PP="01","02","03","04","05","06","07","08","09",10:1:27 D
 . . ;
 . . ; The following code will update the % Complete Status Bar
 . . ; during the installation of the patch.
 . . ;
 . . S PRSD("IE")=PRSD("IE")+1
 . . S PRSD("%")=PRSD("IE")*100/PRSD("TOT") ; Calculate % complete
 . . ;
 . . ; Check if Status Bar should be updated
 . . ;
 . . I PRSD("%")>PRSD("UPD") D
 . . . D UPDATE^XPDID(PRSD("IE"))  ; Update Status Bar
 . . . S PRSD("UPD")=PRSD("UPD")+5 ; Increase update criteria by 5%
 . . ;
 . . ; Get IEN for the TIME & ATTENDANCE RECORDS (#458) file
 . . S IEN458=""
 . . S IEN458=$O(^PRST(458,"B",YEAR_"-"_PP,IEN458))
 . . Q:'IEN458
 . . ;
 . . ; Get IEN for the PAID PAYRUN DATA (#459) file
 . . ;
 . . S IEN459=""
 . . S IEN459=$O(^PRST(459,"B",YEAR_"-"_PP,IEN459))
 . . Q:'IEN459
 . . D GETDATA
 D STORE^PRSXP79A
 D XMIT^PRSXP79A
 Q
 ;
GETDATA ; Loop through OCC codes checking for data in the TIME & ATTENDANCE
 ; RECORDS (#458) and PAID PAYRUN DATA (#459) files.
 ;
 N ZERO459,DATA
 F OCC="0605","0610","0620","0621" D
 . S EMP=""
 . F  S EMP=$O(^TMP($J,OCC,EMP)) Q:'EMP  D
 . . ;
 . . ; Load SSN, VISN and STA
 . . ;
 . . S DATA=$G(^TMP($J,OCC,EMP))
 . . Q:DATA=""
 . . S SSN=$P(DATA,U,1),VISN=$P(DATA,U,2),STA=$P(DATA,U,3)
 . . Q:SSN=""!(VISN="")!(STA="")
 . . ;
 . . ; Quit if they didn't have an entry in the TIME & ATTENDANCE
 . . ; RECORDS (#458) file for the pay period in question
 . . ;
 . . Q:'$D(^PRST(458,IEN458,"E",EMP,0))
 . . ;
 . . ; Quit if they didn't have an entry in the PAID PAYRUN DATA (#459)
 . . ; file for the pay period in question
 . . ;
 . . S ZERO459=$G(^PRST(459,IEN459,"P",EMP,0))
 . . Q:ZERO459=""
 . . ;
 . . ; Quit if the employee was Intermittent during the pay period
 . . ; in question
 . . ;
 . . Q:$P(ZERO459,U,6)=3
 . . ;
 . . ; Verify that the employee's SUBACCT CODE (#8) during the pay 
 . . ; period in question corresponds to one of the SUBACCT CODEs
 . . ; assigned to nurses (i.e. 60 - 67)
 . . ;
 . . Q:$P(ZERO459,U,9)<60&($P(ZERO459,U,9)>67)
 . . ;
 . . D REVDAY
 Q
REVDAY ; Review each day in the pay period to determine if any work
 ; was performed
 N COUNTED,DAY,EXCEPT,TINFO,TOUR1,TOUR2,TOURS,YR
 S COUNTED=0
 F DAY=1:1:14 D
 . S TINFO=$G(^PRST(458,IEN458,"E",EMP,"D",DAY,0))
 . S TOUR1=$G(^PRST(458,IEN458,"E",EMP,"D",DAY,1))
 . S TOUR2=$G(^PRST(458,IEN458,"E",EMP,"D",DAY,4))
 . S EXCEPT=$G(^PRST(458,IEN458,"E",EMP,"D",DAY,2))
 . ;
 . ; Quit if no data for any tour or exception
 . ;
 . Q:TOUR1=""&(TOUR2="")&(EXCEPT="")
 . ;
 . ; Quit if it is the employee's day off and there are no exceptions
 . ;
 . Q:$P(TINFO,U,2)=1&(TOUR2="")&(EXCEPT="")
 . ;
 . ; Record Normal Hours scheduled to work
 . ;
 . I $P(TINFO,U,2)'=1  D
 . . ;
 . . ; Update Normal Hours worked for report # 1
 . . ;
 . . S $P(^TMP($J,"RPT1",SSN,YEAR,OCC,VISN,STA),U,3)=$P($G(^TMP($J,"RPT1",SSN,YEAR,OCC,VISN,STA)),U,3)+$P(TINFO,U,8)
 . . ;
 . . ; Check if it is the last pay period of the year
 . . ;
 . . I PP=26 S $P(^TMP($J,"RPT1",SSN,YEAR,OCC,VISN,STA),U,2)="Y"
 . . I PP>25&(YEAR="00")!(PP<25&(YEAR="01")) D
 . . . S $P(^TMP($J,"RPT2",SSN,OCC,VISN,STA),U,2)="Y"
 . . ;
 . . ; Update employee count
 . . ;
 . . I 'COUNTED D
 . . . S $P(^TMP($J,"RPT1",SSN,YEAR,OCC,VISN,STA),U,1)=$P($G(^TMP($J,"RPT1",SSN,YEAR,OCC,VISN,STA)),U,1)+1
 . . . I PP>25&(YEAR="00")!(PP<25&(YEAR="01")) D
 . . . . S $P(^TMP($J,"RPT2",SSN,OCC,VISN,STA),U,1)=$P($G(^TMP($J,"RPT2",SSN,OCC,VISN,STA)),U,1)+1
 . . . S COUNTED=1
 . ;
 . ; Quit if there is no second tour or exceptions
 . ;
 . Q:TOUR2=""&(EXCEPT="")
 . ;
 . ; Otherwise check Tour 2 and the exceptions for other types of time
 . ; to include in the report.  Then check the exceptions for any types 
 . ; of approved leave that would remove hours from the report.
 . ;
 . F TOURS="TOUR2","EXCEPT" D
 . . ;
SEG . . ; Loop through segments of tour or exception
 . . ;
 . . N ADDSUB,ALLTOUR,CODE,CODE2,END,HRSWRK,SEG,START,TOUR,X
 . . Q:@TOURS=""
 . . F SEG=1:4:21 D
 . . . S (ALLTOUR,TOUR)=0
 . . . S START=$P(@TOURS,U,SEG)
 . . . S END=$P(@TOURS,U,SEG+1)
 . . . S CODE=$P(@TOURS,U,SEG+2)
 . . . S CODE2=4
 . . . S ADDSUB=1
 . . . ;
 . . . ; Quit if the start or stop time is missing
 . . . ;
 . . . Q:START=""!(END="")
 . . . ;
 . . . ; Check for any RG, OT or CT in Tour 2
 . . . ;
 . . . I TOURS="TOUR2",("123678"[CODE!(CODE="")) D
 . . . . S CODE=$S(CODE="":3,"3568"[CODE:3,CODE=1:5,CODE=2:6,1:9)
 . . . . S CODE2=$S(CODE=5:3,CODE=6:3,1:4)
 . . . ;
 . . . ; Check for any Unscheduled Regular (RG), OT, CT in 
 . . . ; the Exceptions
 . . . ;
 . . . I TOURS="EXCEPT",("^RG^OT^CT^"[("^"_CODE_"^")) D
 . . . . S CODE=$S(CODE="RG":4,CODE="OT":5,CODE="CT":6,1:9)
 . . . . S CODE2=$S(CODE=5:3,CODE=6:3,1:4)
 . . . ;
 . . . ; Check for any approved type of leave
 . . . ;
 . . . I TOURS="EXCEPT",("^AA^AD^AL^CB^CU^DL^HX^ML^NL^NP^RL^SL^TV^UN^WP^"[("^"_CODE_"^")) D
 . . . . S CODE=$S("^AA^AD^AL^CB^CU^DL^HX^ML^NL^NP^RL^SL^TV^UN^WP^"[("^"_CODE_"^"):3,1:9)
 . . . . S ADDSUB=-1
 . . . . ;
 . . . . ; Was the leave for the whole day?
 . . . . ;
 . . . . S TOUR=$P(TOUR1,U,SEG,SEG+1)
 . . . . I START_"^"_END=TOUR D
 . . . . . S HRSWRK=$P(TINFO,U,8)*ADDSUB,ALLTOUR=1
 . . . ;
 . . . ; Quit if invalid code
 . . . ;
 . . . Q:CODE>8
 . . . ;
 . . . ; Calculate how much time to add or subtract and store value
 . . . ;
 . . . I ALLTOUR'=1 D
 . . . . S X=START_"^"_END
 . . . . D CNV^PRSATIM
 . . . . I $P(Y,U,2)<$P(Y,U,1) S $P(Y,"^",2)=$P(Y,"^",2)+1440
 . . . . S HRSWRK=(($P(Y,U,2)-$P(Y,U,1))/60)*ADDSUB
 . . . S $P(^TMP($J,"RPT1",SSN,YEAR,OCC,VISN,STA),U,CODE)=$P($G(^TMP($J,"RPT1",SSN,YEAR,OCC,VISN,STA)),U,CODE)+HRSWRK
 . . . I PP>25&(YEAR="00")!(PP<25&(YEAR="01")) D
 . . . . ;
 . . . . ; Don't track approved leave or unscheduled regular for
 . . . . ; report # 2
 . . . . ;
 . . . . Q:HRSWRK<0!(CODE2'=3)
 . . . . S $P(^TMP($J,"RPT2",SSN,OCC,VISN,STA),U,CODE2)=$P($G(^TMP($J,"RPT2",SSN,OCC,VISN,STA)),U,CODE2)+HRSWRK
 . . . I 'COUNTED D
 . . . . S $P(^TMP($J,"RPT1",SSN,YEAR,OCC,VISN,STA),U,1)=$P($G(^TMP($J,"RPT1",SSN,YEAR,OCC,VISN,STA)),U,1)+1
 . . . . I PP>25&(YEAR="00")!(PP<25&(YEAR="01")) D
 . . . . . S $P(^TMP($J,"RPT2",SSN,OCC,VISN,STA),U,1)=$P($G(^TMP($J,"RPT2",SSN,OCC,VISN,STA)),U,1)+1
 . . . . S COUNTED=1
 K Y
 Q
 ;
