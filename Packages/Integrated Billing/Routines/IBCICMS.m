IBCICMS ;DSI/ESG - IBCI CLAIMSMANAGER STATUS REPORT ;2-APR-2001
 ;;2.0;INTEGRATED BILLING;**161**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 NEW STOP,IBCIRTN,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,POP,RPTSPECS
 ;
 S STOP=0
 S IBCIRTN="IBCICMS"
 W @IOF
 W !?10,"ClaimsManager Status Report",!
A10 D DATE I STOP G EXIT
A20 D DTRANGE I STOP G:$$STOP EXIT G A10
A30 D STATUS I STOP G:$$STOP EXIT G A20
A40 D TYPE I STOP G:$$STOP EXIT G A30
A50 D SELASN I STOP G:$$STOP EXIT G A40
A60 D ASSIGN I STOP G:$$STOP EXIT G A50
A70 D SORTBY I STOP G:$$STOP EXIT G A60
A75 D COMMENTS I STOP G:$$STOP EXIT G A70
A80 D DEVICE(IBCIRTN) I STOP G:$$STOP EXIT G:RPTSPECS("TYPE")="S" A40 G A75
 ;
EXIT ;
 QUIT                              ; quit from routine
 ;
COMPILE ; This entry point is called from EN^XUTMDEVQ in either
 ; direct mode or queued mode.
 NEW IBCISCNT
 D BUILD                           ; compile report
 I '$G(ZTSTOP) D EN^IBCICMSP       ; print report
 D ^%ZISC                          ; close the device
 KILL ^TMP($J,IBCIRTN)             ; kill scratch global
 I $D(ZTQUEUED) S ZTREQ="@"        ; purge the task record
COMPX ;
 QUIT                              ; quit from routine
 ;
 ;
STOP() ; See if the user wants to exit out of the whole option
 W !
 S DIR(0)="Y"
 S DIR("A")="Do you want to exit out of this option entirely"
 S DIR("B")="YES"
 S DIR("?",1)="  Enter YES to immediately exit out of this option."
 S DIR("?")="  Enter NO to return to the previous question."
 D ^DIR K DIR
 I $D(DIRUT) S (STOP,Y)=1 G STOPX
 I 'Y S STOP=0
STOPX ;
 Q Y
 ;
DATE ;
 W !
 S DIR(0)="SO^1:Event Date    (Date of Service);2:Entered Date  (Date of Entry into VistA)"
 S DIR("A")="Select Date Range by"
 S DIR("B")="Event Date"
 S DIR("?",1)="  Please enter the type of date on which you would like to report."
 S DIR("?",2)="  The Event Date is the date on which the services were performed."
 S DIR("?")="  The Entered Date is the date on which the bill was Entered into VistA."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G DATEX
 S RPTSPECS("DATYP")=Y
 S RPTSPECS("DATYP1")=$S(Y=1:"Event",1:"Entered")
DATEX ;
 Q
 ;
DTRANGE ;
 NEW X,Y,%DT
 W !
 S %DT="AEX"
 S %DT("A")="Enter the beginning "_RPTSPECS("DATYP1")_" Date: "
 S %DT(0)="-NOW"
 D ^%DT
 I Y=-1!$D(DTOUT) S STOP=1 G DTRNGX
 S RPTSPECS("BEGDATE")=Y
 W !
 S %DT="AEX"
 S %DT("A")="   Enter the ending "_RPTSPECS("DATYP1")_" Date: "
 S %DT(0)=RPTSPECS("BEGDATE")
 D ^%DT
 I Y=-1!$D(DTOUT) S STOP=1 G DTRNGX
 S RPTSPECS("ENDDATE")=Y
DTRNGX ;
 Q
 ;
 ;
STATUS ;
 NEW CH,IEN,TXT
 W !
 S CH="1:All ClaimsManager Statuses;"
 S CH=CH_"2:One Specific ClaimsManager Status;"
 S CH=CH_"3:Any ClaimsManager Status (Bill is still Editable)"
 S DIR(0)="SO^"_CH
 S DIR("A")="Select the ClaimsManager Status Option"
 S DIR("B")=3
 S DIR("?",1)="  Option 1 - All ClaimsManager Statuses - indicates that all bills"
 S DIR("?",2)="    will be included on the report regardless of ClaimsManager"
 S DIR("?",3)="    status."
 S DIR("?",4)="  "
 S DIR("?",5)="  Option 2 - One Specific ClaimsManager Status - will allow you to"
 S DIR("?",6)="    choose a ClaimsManager status and only bills with this specific"
 S DIR("?",7)="    status will be included on the report."
 S DIR("?",8)="  "
 S DIR("?",9)="  Option 3 - Any ClaimsManager Status (Bill is still Editable) -"
 S DIR("?",10)="    will only select those bills that are still open for editing in"
 S DIR("?")="    the IB Enter/Edit Billing Information option."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G STATX
 S RPTSPECS("STATYP")=Y,RPTSPECS("IBCISTAT")=""
 I RPTSPECS("STATYP")'=2 G STATX
 ;
 ; Ask the user which status they want to report on
 W !
 S IEN=0,CH=""
 F  S IEN=$O(^IBA(351.91,IEN)) Q:'IEN  D
 . S TXT=$P($G(^IBA(351.91,IEN,0)),U,2)
 . I CH="" S CH=IEN_":"_TXT
 . E  S CH=CH_";"_IEN_":"_TXT
 . Q
 S DIR(0)="SO^"_CH
 S DIR("A")="Please choose a ClaimsManager Status"
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G STATX
 S RPTSPECS("IBCISTAT")=Y
STATX ;
 Q
 ;
 ;
COMMENTS ;
 S RPTSPECS("IBCICOMM")=1           ; default
 I RPTSPECS("TYPE")="S" G COMMX     ; don't ask if summary
 W !
 S DIR(0)="Y"
 S DIR("A")="Do you want to see ClaimsManager comments associated with these bills"
 S DIR("B")="YES"
 S DIR("?",1)="  Enter YES if you would like to see the comments which are stored in the"
 S DIR("?",2)="    ClaimsManager file (#351.9) for each bill on this report."
 S DIR("?",3)=""
 S DIR("?")="  Enter NO if you do not want to see these comments."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G COMMX
 S RPTSPECS("IBCICOMM")=+Y
COMMX ;
 Q
 ;
 ;
SELASN ;
 W !
 S DIR(0)="F^1:1"
 S DIR("A",1)="Do you want to include one specific Assigned to person or All?"
 S DIR("A")="Please enter 1 or A"
 S DIR("B")="A"
 S DIR("?",1)="  Enter '1' to indicate that you only want to include one specific"
 S DIR("?",2)="    Assigned to person on this report.  You will then be asked"
 S DIR("?",3)="    to select this person."
 S DIR("?",4)=""
 S DIR("?",5)="  Enter 'A' to indicate that you want to include all Assigned to"
 S DIR("?",6)="    people on this report.  You will then be asked if you want"
 S DIR("?")="    to sort by the Assigned to person."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G SELASNX
 I '$F(".1.A.","."_Y_".") W *7,"  Invalid response ... Please enter '1' or 'A'" G SELASN
 S RPTSPECS("SELASN")=Y
SELASNX ;
 Q
 ;
 ;
ASSIGN ;
 NEW DIC,X,Y
 W !
 S RPTSPECS("ASNSORT")=0
 S RPTSPECS("ASNDUZ")=0
 I RPTSPECS("SELASN")="A" D  G ASSIGNX
 . I RPTSPECS("TYPE")="S" Q     ; don't ask this if summary
 . S DIR(0)="Y"
 . S DIR("A")="Do you want the primary sort by the Assigned To person"
 . S DIR("B")="YES"
 . S DIR("?",1)="  Enter YES if you would like the bills on this report primarily"
 . S DIR("?",2)="    sorted by the Assigned To person.  If a bill is not assigned"
 . S DIR("?",3)="    to anyone, then the word ""UNASSIGNED"" will be used."
 . S DIR("?",4)=""
 . S DIR("?")="  Enter NO if you would like to choose a different primary sort."
 . D ^DIR K DIR
 . I $D(DIRUT) S STOP=1 Q
 . S RPTSPECS("ASNSORT")=+Y
 . Q
 ;
 ; At this point, we know that the user wants to include only one
 ; assigned to person.  We need to select this person here.
 ;
 S DIC="^VA(200,"
 S DIC(0)="AEMQO"
 S DIC("A")="Enter the Assigned to person to include: "
 S DIC("S")="I $D(^IBA(351.9,""ASN"",+Y))"
 I $D(^IBA(351.9,"ASN",DUZ)) S DIC("B")=DUZ
 D ^DIC
 I Y<0 S STOP=1 G ASSIGNX
 S RPTSPECS("ASNDUZ")=+Y
ASSIGNX ;
 Q
 ;
 ;
SORTBY ;
 S RPTSPECS("SORTBY")=3               ; default
 I RPTSPECS("TYPE")="S" G SORTBYX     ; don't ask if summary
 NEW CH,PS
 W !
 S CH="1:Terminal Digit;"
 S CH=CH_"2:Insurance Company Name;"
 S CH=CH_"3:Patient Last Name;"
 S CH=CH_"4:Total Charges;"
 S CH=CH_"5:Bill Number"
 S DIR(0)="SO^"_CH
 S PS=$S(RPTSPECS("ASNSORT"):"secondary",1:"primary")
 S DIR("A")="Please enter the "_PS_" sort criteria"
 S DIR("B")="Patient Last Name"
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G SORTBYX
 S RPTSPECS("SORTBY")=Y
SORTBYX ;
 Q
 ;
TYPE ;
 W !
 S DIR(0)="S^D:Detailed;S:Summary"
 S DIR("A")="Please enter the report type"
 S DIR("B")="Detailed"
 S DIR("?",1)="  The Detailed report will show the breakout of bills &"
 S DIR("?",2)="  a summary based on the criteria that you selected."
 S DIR("?",3)=""
 S DIR("?",4)="  The Summary report will show the total amount of bills"
 S DIR("?")="  based on the criteria that you selected."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G TYPEX
 S RPTSPECS("TYPE")=Y
TYPEX ;
 Q
 ;
DEVICE(IBCIRTN) ; Device Handler and possible TaskManager calls
 NEW ZTRTN,ZTDESC,ZTSAVE,POP
 W !!!,"*** This report is 132 characters wide ***",!
 S ZTRTN="COMPILE^"_IBCIRTN
 S ZTDESC="IBCI ClaimsManager Status Report"
 I IBCIRTN="IBCICME" S ZTDESC="IBCI ClaimsManager Error Report"
 S ZTSAVE("RPTSPECS(")=""
 S ZTSAVE("IBCIRTN")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE)
 I POP S STOP=1
DEVICEX ;
 Q
 ;
 ;
BUILD ; Build the scratch global based on the selection and sort criteria
 ;
 NEW SUBSCRPT,RDT,IBIFN,CMDATA,IBDATA,CMSTATUS,BILLID,PATDATA
 NEW NAME,SSN,BILLER,CODER,OIFLG,ASSIGNED,CHARGES,ERR,ERRCODES
 NEW SORT1,SORT2,SORT3,SORT4,SORT5,RPTDATA,COUNT,ASNSUB,NAMESUB
 NEW INSNAME
 ;
 KILL ^TMP($J,IBCIRTN)
 ;
 S SUBSCRPT="D"                           ; for event date looping
 I RPTSPECS("DATYP")=2 S SUBSCRPT="APD"   ; for entry date looping
 ;
 ; Get the starting date for looping purposes
 S RDT=$O(^DGCR(399,SUBSCRPT,RPTSPECS("BEGDATE")),-1)
 ;
 S COUNT=0
 ; Main loop....stop when we get to a date after the report end date
 F  S RDT=$O(^DGCR(399,SUBSCRPT,RDT)) Q:'RDT!($P(RDT,".",1)>RPTSPECS("ENDDATE"))!$G(ZTSTOP)  D
 . S IBIFN=0
 . F  S IBIFN=$O(^DGCR(399,SUBSCRPT,RDT,IBIFN)) Q:'IBIFN!$G(ZTSTOP)  D
 .. S COUNT=COUNT+1
 .. I $D(ZTQUEUED),COUNT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 .. S CMDATA=$G(^IBA(351.9,IBIFN,0))
 .. I CMDATA="" Q
 .. S IBDATA=$G(^DGCR(399,IBIFN,0))
 .. I IBDATA="" Q
 .. ;
 .. ; If the user chose a specific ClaimsManager status to report
 .. ; on, then make sure this bill has the status they want.
 .. S CMSTATUS=$P(CMDATA,U,2)
 .. I RPTSPECS("STATYP")=2,CMSTATUS'=RPTSPECS("IBCISTAT") Q
 .. ;
 .. ; If the user wants to see bills that are still open for editing
 .. I RPTSPECS("STATYP")=3,'$F(".1.","."_$P(IBDATA,U,13)_".") Q  ;DSI/DJW 3/21/02
 .. ;
 .. ; If the user wants to include a specific assigned to person,
 .. ; then make sure the assigned to person is the one they want.
 .. I RPTSPECS("ASNDUZ"),RPTSPECS("ASNDUZ")'=$P(CMDATA,U,12) Q
 .. ;
 .. ; At this point, we know we want to include this bill.
 .. D GETDATA^IBCICME1
 .. S ^TMP($J,IBCIRTN,SORT1,SORT2,SORT3,SORT4,SORT5,NAME,IBIFN)=RPTDATA
 .. Q
 . Q
 ;
BUILDX ;
 Q
 ;
 ;
