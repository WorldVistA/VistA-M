RCVCR1 ;SLC/LLB/JC - First Party Veterans Charge Report ; SEP 9,2020@16:17
 ;;4.5;Accounts Receivable;**373,379**;Mar 20, 1995;Build 16
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;External References  Type       ICR #
 ;-------------------  ---------  -----
 ; HOME^%ZIS           Supported  10086
 ; ^DIC                Supported  10006
 ; ^DIQ                Supported  10004
 ; EN^DIQ1             Supported  10015
 ; ^DIR                Supported  10026
 ; RX^PSO52API         Supported  4820
 ; DEM^VADPT           Supported  10061
 ; $$FMTE^XLFDT        Supported  10103
 ; $$NOW^XLFDT         Supported  10103
 ; $$CJ^XLFSTR         Supported  10104
 ; $$STRIP^XLFSTR      Supported  10104
 ; EN^XUTMDEVQ         Supported  1519
 ;
 ;ICR#  TYPE          DESCRIPTION
 ;----- ----------    ---------------------
 ; 7218 Private       File (#350), access to fields (#.08),(#.09),(#.1),(#.12),(#.18),(#.19),(#.2),(#12),(#13),(#14)
 ; 4541 Private       File (#350), access to the "C" cross-reference and fields (#.01),(#.02),(#.03),(#.04),(#.05),(#.06),(#.07),(#.11),(#.14),(#.15),(#.16),(#.17)
 ;
START ;
 N DFN,VETNM,FRMDT,FRMDTINT,TODT,TODTINT,IBSVCTYP,IBSVCNM,IBQUIT,DGPAGE
 N IBSTAT,IBSTATNM,POP,%ZIS,X,ZTSAVE,Y,LETTER,STAT,SSN,DIRUT,IBRXNAM
 S (POP,DIRUT,IBQUIT,DGPAGE)=0
 D INIT
 I POP Q
 W !!,"The number of characters per row should be set to 256."
 W !,"Please use the following path to modify the display settings:"
 W !,"In Reflections. File >>> Settings >>> Terminal Configuration"
 W !," >>> Set Up Display Settings >>> Number of characters per row",!
 W !,"To capture as a spreadsheet format, at the DEVICE prompt, please accept the"
 W !,"default value of 0;256;99999. This should help avoid wrapping problems.",!
 W !,"For pagination, please use "";256;"" for the device value instead of the default.",!
 S %ZIS=""
 S %ZIS("B")="0;256;99999"
 S ZTSAVE("FRMDTINT")=""
 S ZTSAVE("LETTER")=""
 S X="FIRST PARTY VETERAN CHARGE REPORT"
 D EN^XUTMDEVQ("DISPHEAD^RCVCR1",X,.ZTSAVE,.%ZIS)
 D HOME^%ZIS
 D CLEAN
 Q
 ;
INIT ;
 ;
 W @IOF
 W !,"*** Print the First Party Veteran Charge Report ***",!
 W !,"This report captures detailed 1st party bill information for a specific "
 W !,"Veteran, within a user specified range of dates of service."
 W !,"This report output requires screen size of 256 characters wide.",!
 ; Get Veteran Name
 S DIC="^DPT(",DIC(0)="AQEZMV",DIC("A")="Enter Veteran Name: "
 D ^DIC
 K DIC
 I +Y<1 K DIC S POP=1 Q
 S DFN=$P(Y,U)
 S VETNM=$P(Y,U,2)
 D DEM^VADPT
 S SSN=$P(VADM(2),U,1)
 ;Get From date
 W !
 N DIR
 S DIR(0)="DO^:DT:EX"
 S DIR("A")="Enter From Date "
 D ^DIR
 I +Y<1 K DIR S POP=1 Q
 K DIR
 S FRMDT=X,FRMDTINT=Y
 ;Get To date
 S DIR(0)="DA^"_FRMDTINT_":"_DT_":EX"
 S Y=DT D D^DIQ S DIR("B")="TODAY"
 S DIR("A")="Enter To Date: "
 D ^DIR
 I +Y<1 K DIR S POP=1 Q
 K DIR
 S TODT=X,TODTINT=Y
 ; Get Service Type
 S DIR(0)="SO^1:Medical Care;2:Outpatient Medication;3:Both (Medical Care and Outpatient Medication)"
 S DIR("L",1)="Which type of copayment do you wish to see?"
 S DIR("L",2)="  1. Medical Care"
 S DIR("L",3)="  2. Outpatient Medication"
 S DIR("L")="  3. Both (Medical Care and Outpatient Medication)"
 S DIR("B")="3"
 S DIR("A")="Enter selection (1,2 or 3) "
 D ^DIR
 K DIR
 I +Y<1!(+Y>3) K DIR S POP=1 Q
 S IBSVCTYP=Y,IBSVCNM=Y(0)
 ; Get IB Status
 S DIR(0)="SO^1:Billed;2:On Hold;3:Cancelled;4:All (Billed, On Hold, Cancelled)"
 S DIR("L",1)="Which IB status for the selected copayment(s) do you wish to see?"
 S DIR("L",2)="  1. Billed"
 S DIR("L",3)="  2. On Hold"
 S DIR("L",4)="  3. Cancelled"
 S DIR("L")="  4. All (Billed, On Hold, Cancelled)"
 S DIR("B")="4"
 S DIR("A")="Enter Status selection (1,2,3 or 4) "
 D ^DIR
 K DIR
 I +Y<1!(+Y>4) K DIR S POP=1 Q
 S IBSTAT=Y,IBSTATNM=Y(0)
 ;Ask if Letters should print
 W !
 S DIR("A")="Enter Selection (1,2,or 3) "
 S DIR(0)="SO^1:Letter Dates;2:Total Payments Received on Bill Number;3:Neither"
 S DIR("L",1)="Do you want to see: "
 S DIR("L",2)="  1. Letter Dates"
 S DIR("L",3)="  2. Total Payments Received on Bill Number"
 S DIR("L")="  3. Neither"
 S DIR("B")="3"
 D ^DIR
 I $G(DIRUT) S POP=1 Q
 K DIR
 I +Y<1!(+Y>3) K DIR S POP=1 Q
 S LETTER=Y
 Q
 ;
DISPHEAD ; Write report header
 ;
 W @IOF
 W !,"First Party Veteran Charge Report",!
 W !,"Run date: ",$$FMTE^XLFDT($$NOW^XLFDT,"MP")
 W !,"Service Dates From ",$$FMTE^XLFDT(FRMDTINT,"5D")," To ",$$FMTE^XLFDT(TODTINT,"5D")
 W !,"Copayment Type Selected: ",IBSVCNM
 W !,"IB Status Selected: ",IBSTATNM
 N TRM S TRM=($E(IOST)="C")
 W !!
 D PRTCOLHD
 D RUNRPT
 D OUTPRPT
 Q:IBQUIT
 D ASKCONT(0)
 Q
 ;
ASKCONT(FLAG) ; display "press <Enter> to continue" prompt
 N Z
 W !!,$$CJ^XLFSTR("Press <Enter> to "_$S(FLAG=1:"continue.",1:"exit."),20)
 R !,Z:DTIME
 Q
 ;
PRTCOLHD ;
 ;
 N COL,CNT,CNAME,LENGTH,END,SCOL,LOC
 S END=255,SCOL=21,COL=0
 ;I $G(LETTER)="NO" S END=220,SCOL=17
 I $G(LETTER)'=1 S END=220,SCOL=17  ;JMC If Total Payment or Neither selected
 S DGPAGE=$G(DGPAGE)+1
 F CNT=1:1:SCOL D
 . S CNAME=$P($T(COLHD+CNT),U,2)
 . S LENGTH=$P($T(COLHD+CNT),U,4)
 . S LOC=COL+((LENGTH-$L(CNAME))\2)
 . I CNT>1 S LOC=LOC+1
 . W ?LOC,CNAME
 . S COL=COL+LENGTH
 . I CNT>1 S COL=COL+1
 . I CNT<SCOL W ?COL,"^"
 I $G(LETTER)=2 W ?223,"^Total Principal"
 W !
 S COL=0
 F CNT=1:1:SCOL D
 . S CNAME=$P($T(COLHD+CNT),U,3)
 . S LENGTH=$P($T(COLHD+CNT),U,4)
 . S LOC=COL+((LENGTH-$L(CNAME))\2)
 . I CNT>1 S LOC=LOC+1
 . S COL=COL+LENGTH
 . W ?LOC,CNAME
 . I CNT>1 S COL=COL+1
 . I CNT<SCOL W ?COL,"^"
 I $G(LETTER)=2 W ?223,"^Paid on Bill Number"
 Q
COLHD ; $T target. Format: Column #^1st row data^2nd row data^Field Width
 ;;1^^Veteran Name^26
 ;;2^^SSN^9
 ;;3^^Bill Number^11
 ;;4^^Category^26
 ;;5^Charge^Amount^8
 ;;6^Unit^Day^4
 ;;7^Medical^DOS^7
 ;;8^Release^RX DT^7
 ;;9^^RX Number^12
 ;;10^^RX Name^16
 ;;11^^IB Status^13
 ;;12^^AR Status^21
 ;;13^Cancel^Date^7
 ;;14^Cancellation^Reason^14
 ;;15^^Cancelled By^16
 ;;16^^APPR^6
 ;;17^^RSC^4
 ;;18^^Letter1^7
 ;;19^^Letter2^7
 ;;20^^Letter3^7
 ;;21^^Letter4^7
 Q
 ;
RUNRPT ;Gather data for Report
 D GET350
 I IBSTAT=4 D GET399^RCVCR2 ; Only pull file #399 data if user selected All as the desired IB Status
 Q
 ;
GET350 ; Collect data originating from the INTEGRATED BILLING ACTION file (#350)
 ;
 N IBIEN,IB0,STATLST,CNT,STATLST,LINE,RESULT,IBSTATNM,POP,SVCTYP,BILLNUM
 N DATEINFO,TRIGDT,SVCDT,XTEMP,DIC,DR,DA,DIQ,FBILLNUM,LCNT,LTRFLD,RC430IEN
 N TLTR,IBCANCLR,IBCANCLD,IBCANCLB,ARSTAT,ARAPPR,ARRSC,ARIEN,ARFLDS,RC430TPR
 S (IBIEN,IBCANCLR,ICANCLD,IBCANCLB)="",(CNT,RC430TPR)=0
 ; STATUS=BILLED,ON HOLD,CANCELLED, or ALL
 S STATLST=$S(IBSTAT=1:"/3/",IBSTAT=2:"/8/",IBSTAT=3:"/10/",1:"/3/8/10/")
 K ^TMP($J,"RCVCR")
 F  S IBIEN=$O(^IB("C",DFN,IBIEN)) Q:IBIEN=""  D
 . K IBFLDS
 . S DIC=350,DR=".01:.07;.08;.09:.12;.14:.2;12:14",DA=IBIEN,DIQ="IBFLDS",DIQ(0)="IE" D EN^DIQ1
 . S STAT="/"_IBFLDS(350,IBIEN,.05,"I")_"/"
 . S DATEINFO=$$GETDTS
 . I DATEINFO["#" D
 . . S RXDATE=IBFLDS(350,IBIEN,12,"I")
 . . S RXNUM=$E(IBFLDS(350,IBIEN,.08,"E"),1,12)
 . . S RXNAME=""
 . . S DATEINFO="RX/"_"350/"_RXDATE_"/"_RXDATE_"/"_RXNUM_"/"_$E(RXNAME,1,16)
 . S TRIGDT=$P(DATEINFO,"/",3)
 . S SVCDT=$P(DATEINFO,"/",4)
 . I TRIGDT'<FRMDTINT,TRIGDT'>TODTINT,(STATLST[STAT) D
 . . ;Check Service Type
 . . S RESULT=IBFLDS(350,IBIEN,.04,"I"),SVCTYP=$P(RESULT,":",1)
 . . I IBSVCTYP=1,(SVCTYP=52!(IBFLDS(350,IBIEN,.03,"E")["RX")) Q  ;Only include Medical
 . . I IBSVCTYP=2,(SVCTYP'=52),(IBFLDS(350,IBIEN,.03,"E")'["RX") Q  ;Only include RX
 . . ;Get Cancellation information if it exists
 . . S IBCANCLR=IBFLDS(350,IBIEN,.1,"E")
 . . S IBCANCLD=IBFLDS(350,IBIEN,14,"I")
 . . S IBCANCLB=IBFLDS(350,IBIEN,13,"E")
 . . ;Get data & Set into scratch global ^TMP($J,"RCVCR",BILLNUM,DATE,CNT)=
 . . ;FILE#^IBIEN^REF#^PARENT CHARGE^PARENT EVENT^STATUS^UNITS^TOTAL CHARG^AR BILL NUMBER^CATEGORY
 . . ;MEDICAL DOS^Release RX DT^RX #^RX Name^
 . . ;CNT is used to distinguish entries with the same Bill Number
 . . S (CNT,ARIEN)=0
 . . S FBILLNUM=IBFLDS(350,IBIEN,.11,"I") I FBILLNUM="" S BILLNUM=0
 . . I FBILLNUM["-" S BILLNUM=$P(FBILLNUM,"-",2)
 . . I BILLNUM'="" S ARIEN=$O(^PRCA(430,"D",BILLNUM,"")) ;Get IEN to 430 based on bill number
 . . S (ARSTAT,ARAPPR,ARRSC)=""
 . . I BILLNUM'="",$G(ARIEN)'=""  D
 . . . S DIC=430,DR="8;203;255.1",DA=ARIEN,DIQ="ARFLDS",DIQ(0)="IE" D EN^DIQ1
 . . . S ARSTAT=$G(ARFLDS(430,ARIEN,8,"E")) ; AR Status
 . . . S ARAPPR=$G(ARFLDS(430,ARIEN,203,"E")) ; APPR
 . . . I ARAPPR="" S ARAPPR="RVW"
 . . . S ARRSC=$G(ARFLDS(430,ARIEN,255.1,"I")) ; RSC
 . . . I ARRSC="" S ARRSC="RVW"
 . . S IBSTATNM=IBFLDS(350,IBIEN,.05,"E")
 . . I $D(^TMP($J,"RCVCR",BILLNUM,SVCDT)) S CNT="" S CNT=$O(^TMP($J,"RCVCR",BILLNUM,SVCDT,CNT),-1)+1
 . . S XTEMP=350_U_IBIEN_U_IBFLDS(350,IBIEN,.01,"E") ; Pos 1-3 FILE^IBIEN^IB Ref #
 . . S XTEMP=XTEMP_U_IBFLDS(350,IBIEN,.09,"E") ;Pos 4 Parent Charge 
 . . S XTEMP=XTEMP_U_IBFLDS(350,IBIEN,.16,"E") ;Pos 5 Parent Event
 . . S XTEMP=XTEMP_U_IBSTATNM_U_IBFLDS(350,IBIEN,.06,"E") ;Pos 6 IB STATUS Pos 7 Units Col 11&6
 . . S XTEMP=XTEMP_U_IBFLDS(350,IBIEN,.07,"E") ;Pos 8 Total Charge Col 5
 . . S XTEMP=XTEMP_U_$E(BILLNUM,1,21) ;Pos 9 AR Bill # Col 3
 . . S XTEMP=XTEMP_U_$E(IBFLDS(350,IBIEN,.03,"E"),1,26) ;Pos 10 Category Col 4
 . . I SVCTYP'=52 D
 . . . I IBFLDS(350,IBIEN,.03,"E")["RX" S XTEMP=XTEMP_U_U_$$STRIP^XLFSTR($$FMTE^XLFDT(SVCDT,"8D")," ")_U_U ;Pos 11 blank Pos 12 Release RX Date Col 7&8
 . . . I IBFLDS(350,IBIEN,.03,"E")'["RX" S XTEMP=XTEMP_U_$$STRIP^XLFSTR($$FMTE^XLFDT(SVCDT,"8D")," ")_U_U_U ;Pos 11  Medical DOS Pos 12-14 blank Col 7,8,9,10
 . . I SVCTYP=52 S XTEMP=XTEMP_U_U_$$STRIP^XLFSTR($$FMTE^XLFDT(SVCDT,"8D")," ") ;Pos 11 blank Pos 12 Release RX Date Col 7&8
 . . I SVCTYP=52 S XTEMP=XTEMP_U_$P(DATEINFO,"/",5)_U_$P(DATEINFO,"/",6) ;Pos 13 RX Number, Pos 14 RX Name Col 9&10
 . . S XTEMP=XTEMP_U_$E($G(ARSTAT),1,21) ;Pos 15 AR Status Col 12
 . . S XTEMP=XTEMP_U I $G(IBCANCLR)'="" S XTEMP=XTEMP_$$STRIP^XLFSTR($$FMTE^XLFDT($G(IBCANCLD),"8D")," ") ;Pos 16 Cancel Dt
 . . S XTEMP=XTEMP_U I $G(IBCANCLR)'="" S XTEMP=XTEMP_$E($G(IBCANCLR),1,14) ;Pos 17 Cancel Reason
 . . S XTEMP=XTEMP_U I $G(IBCANCLR)'="" S XTEMP=XTEMP_$E(IBCANCLB,1,16) ;Pos 18 Cancel By
 . . S XTEMP=XTEMP_U_$G(ARAPPR) ;Pos 19 APPR
 . . S XTEMP=XTEMP_U_$G(ARRSC) ;Pos 20 RSC
 . . ;Get Letter dates if they exist
 . . I FBILLNUM D
 . . . I '$D(^PRCA(430,"B",FBILLNUM)) Q
 . . . S RC430IEN=$O(^PRCA(430,"B",FBILLNUM,""))
 . . . I $G(LETTER)=1 D  ;JMC display letters if Letter Dates selected
 . . . . K ARFLDS
 . . . . S DIC=430,DR="61:63;68",DA=RC430IEN,DIQ="ARFLDS",DIQ(0)="I" D EN^DIQ1
 . . . . S LCNT=0
 . . . . F LTRFLD=61,62,63,68 D
 . . . . . S LCNT=LCNT+1 S TLTR="LTR"_LCNT
 . . . . . S @TLTR=ARFLDS(430,RC430IEN,LTRFLD,"I")
 . . . . . I @TLTR'="" S XTEMP=XTEMP_U_$$STRIP^XLFSTR($$FMTE^XLFDT(@TLTR,"8D")," ") ; Pos 21-24 Letter 1-4
 . . . . . I @TLTR="" S XTEMP=XTEMP_U_"NO DATE" ; Pos 21-24 Letter 1-4
 . . . I $G(LETTER)=2 D  ;user wants to display Total Payments Received on Bill Number
 . . . . S RC430TPR=+$P($G(^PRCA(430,RC430IEN,7)),"^",7)
 . . . . S XTEMP=XTEMP_U_RC430TPR
 . . S ^TMP($J,"RCVCR",BILLNUM,SVCDT,CNT)=XTEMP
 . . K XTEMP
 Q
 ;
OUTPRPT ; Loop through ^TMP to write report lines.
 N LINE,BILLNUM,CNT,JUNK,RCTPRARY
 S CNT=0,POP=0,LINE="",BILLNUM="",JUNK=0
 I '$D(^TMP($J,"RCVCR")) S POP=1 W !,"NO DATA FOUND" Q
 F  S BILLNUM=$O(^TMP($J,"RCVCR",BILLNUM)) Q:BILLNUM=""!POP  D  Q:IBQUIT
 . S SVCDT="" F  S SVCDT=$O(^TMP($J,"RCVCR",BILLNUM,SVCDT)) Q:SVCDT=""!POP  D  Q:IBQUIT
 . . S CNT="" F  S CNT=$O(^TMP($J,"RCVCR",BILLNUM,SVCDT,CNT)) Q:CNT=""  D  Q:IBQUIT
 . . . I $Y>(IOSL-4) W ! D PAUSE(.IBQUIT) Q:IBQUIT  W @IOF D PRTCOLHD
 . . . S LINE=^TMP($J,"RCVCR",BILLNUM,SVCDT,CNT)
 . . . I $P(LINE,U,9)=0 S $P(LINE,U,9)=""
 . . . I '$P(LINE,U,4) D WRITEREC(LINE)
 . . . I $P(LINE,U,4)=$P(LINE,U,3),($P(LINE,U,3)'="") D WRITEREC(LINE)
 K ^TMP($J,"RCVCR"),RCTPRARY
 Q
 ;
WRITEREC(LINE) ; Write one line of report
 ; display date as DDmmmYY $$STRIP^XLFSTR($$FMTE^XLFDT(3070308,"8D")," ")
 W !,$E(VETNM,1,26),?26,U,SSN,?36,U,$P(LINE,U,9),?48,U,$P(LINE,U,10),?75,U,$J($P(LINE,U,8),8,2)
 W ?84,U,$P(LINE,U,7),?89,U,$P(LINE,U,11),?97,U,$P(LINE,U,12),?105,U,$P(LINE,U,13),?118,U,$P(LINE,U,14)
 W ?135,U,$P(LINE,U,6),?149,U,$P(LINE,U,15),?171,U,$P(LINE,U,16),?179,U,$P(LINE,U,17),?194,U,$P(LINE,U,18)
 W ?211,U,$P(LINE,U,19),?218,U,$P(LINE,U,20)
 I $G(LETTER)=1 W ?223,U,$P(LINE,U,21),?231,U,$P(LINE,U,22),?239,U,$P(LINE,U,23),?247,U,$P(LINE,U,24)  ;JMC Only print if 1 selected
 I $G(LETTER)=2 D
 . W ?223,U
 . I $P(LINE,U,9)="" Q
 . I '$D(RCTPRARY($P(LINE,U,9))) W $J($P(LINE,U,21),11,2)  ;display the Total Principal Paid on Bill Number only once
 . S RCTPRARY($P(LINE,U,9))=""
 Q
 ;
GETDTS() ; Get appropriate selection trigger dates by type of service
 ;Determine transaction type 52, RX Manual RX Out pat, inpatient, LTC inpatient, LTC Outpatient
 ;based on transaction type get date used for selection and determine if it falls within the 
 ;date range for the report.
 ; Return: Transaction type/File derived from/SELDT (Selection date)/DISPDT (display date).
 ; in the case of RX the following is appended to the return /RX #/Drug Name
 N IBTYPINT,IBTYPE,IBTYPE,IBBG,DATES,RESPONSE,SVCTYP,RXFLDS,RXRFILL,RXNUM,RXNAME,IBCAT,IBDTENT
 N RXDATE,RXIEN,RXNODE,IBDTFRM,RXFILDT
 S RESPONSE="",RXRFILL="",IBCAT="",IBDTFRM="",IBDTENT=""
 ;RX via pharmacy system
 S IBCAT=IBFLDS(350,IBIEN,.03,"E")
 S IBTYPE=IBFLDS(350,IBIEN,.04,"E") S SVCTYP=+IBTYPE
 I SVCTYP=52 D  ;RX
 . I $P(IBTYPE,";",2)'="" S RXRFILL=$P(IBTYPE,":",3)
 . K ^TMP($J,"RXRDT")
 . S RXIEN=+$P(IBTYPE,":",2)
 . S RXNODE="0,2"
 . I RXRFILL'="" S RXNODE="0,2,R^^"_RXRFILL
 . D RX^PSO52API(DFN,"RXRDT",RXIEN,,RXNODE,,)
 . I +$G(^TMP($J,"RXRDT",RXIEN,0))=-1 S RESPONSE="RX/"_"350#"_$P(^TMP($J,"RXRDT",RXIEN,0),U,2) Q
 . I RESPONSE'="" Q
 . I RXRFILL'="",$P(^TMP($J,"RXRDT",DFN,RXIEN,"RF",0),U,1)=-1 Q  ;No data for refill
 . ;get the release date 
 . I RXRFILL'="" S RXDATE=$P($G(^TMP($J,"RXRDT",DFN,RXIEN,"RF",RXRFILL,17)),U,1)
 . E  S RXDATE=$P($G(^TMP($J,"RXRDT",DFN,RXIEN,31)),U,1)
 . ;get the fill date 
 . I RXRFILL'="" S RXFILDT=$P($G(^TMP($J,"RXRDT",DFN,RXIEN,"RF",RXRFILL,0.01)),U,1)
 . E  S RXFILDT=+$P($G(^TMP($J,"RXRDT",DFN,RXIEN,22)),U,1)
 . ;if no release date then use the refill date instead 
 . I 'RXDATE,RXFILDT S RXDATE=RXFILDT
 . S RXDATE=RXDATE\1
 . S RXNUM=^TMP($J,"RXRDT",DFN,RXIEN,.01)
 . S RXNAME=$P(^TMP($J,"RXRDT",DFN,RXIEN,6),U,2)
 . S RESPONSE="RX/"_"350/"_RXDATE_"/"_RXDATE_"/"_RXNUM_"/"_$E(RXNAME,1,16)
 I RESPONSE'="" Q RESPONSE
 ;Manually entered RX
 I SVCTYP=350 D
 . I IBCAT'["RX" Q  ; Medical Charge
 . S IBDTENT=IBFLDS(350,IBIEN,.15,"I")
 . I IBDTENT="" S IBDTENT=IBFLDS(350,IBIEN,12,"I")
 . S IBDTFRM=IBFLDS(350,IBIEN,.14,"I")
 . I IBDTFRM="" S IBDTFRM=IBDTENT
 . S RESPONSE="RXM/"_"350/"_IBDTENT_"/"_IBDTFRM
 I RESPONSE'="" Q RESPONSE
 ;Inpatient or LTC Inpatient
 ;INP/350/(#.14) DATE BILLED FROM - used as trigger date to compare against the date range/(#.14) DATE BILLED FROM - used as DOS
 I IBCAT["INPT"!(IBCAT["ADMISSION") D
 . ;S RESPONSE="INP/"_"350/"_IBFLDS(350,IBIEN,.15,"I")_"/"_IBFLDS(350,IBIEN,.14,"I")
 . S RESPONSE="INP/"_"350/"_IBFLDS(350,IBIEN,.14,"I")_"/"_IBFLDS(350,IBIEN,.14,"I")  ;jmc
 I RESPONSE'="" Q RESPONSE
 ;All Outpatient except for LTC
 S RESPONSE="OPT/350/"_IBFLDS(350,IBIEN,.14,"I")_"/"_IBFLDS(350,IBIEN,.14,"I")
 Q RESPONSE
 ;
PAUSE(IBQUIT) ;
 I $G(DGPAGE)>0,TRM K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 IBQUIT=1
 Q
CLEAN ; KILL ALL REMAINING VARIABLES BEFORE EXIT
 K ^TMP($J,"RXRDT")
 K RXFLDS,IBFLDS,TRIGDT,DPTDFN,IBRXFILL,IBRXNAM,IBRXNUM,ICANCLD,LTR1,LTR2,LTR3,LTR4,VADM
 K ARSTAT,ARAPPR,ARRSC
 Q
 ;
