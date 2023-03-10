RCHRFS1 ;SLC/SS - High Risk for Suicide Patients Report ; JAN 22,2021@14:32
 ;;4.5;Accounts Receivable;**379**;Mar 20, 1995;Build 16
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;External References  Type       ICR #
 ;-------------------  ---------- -----
 ; EN^DIQ1             Supported  10015
 ; ^DIR                Supported  10026
 ; RX^PSO52API         Supported  4820
 ; $$FMTE^XLFDT        Supported  10103
 ; $$RJ^XLFSTR         Supported  10104
 ; $$STRIP^XLFSTR      Supported  10104
 ;
 ;Access to files
 ;ICR#  TYPE          DESCRIPTION
 ;----- ----------    ---------------------------------------------------------------------------------------------------------------------------------------------
 ; 7218 Private       File (#350), access to fields (#.08),(#.09),(#.1),(#.12),(#.18),(#.19),(#.2),(#12),(#13),(#14)
 ; 4541 Private       File (#350), access to the "C" cross-reference and fields (#.01),(#.02),(#.03),(#.04),(#.05),(#.06),(#.07),(#.11),(#.14),(#.15),(#.16),(#.17)
 ;
 ;Global References    Supported by
 ;-----------------    --------------
 ; ^TMP($J             SACC 2.3.2.5.1
 ;
 ;
 ;Run the report:
 ; RCDFN - DFN of the patient
 ; FRMDTINT - from date
 ; TODTINT - to date
 ; IBSTAT - IB status : 
 ;   1-BILLED,
 ;   2- ON HOLD,
 ;   3- CANCELLED,
 ;   4- BILLED and ON HOLD, 
 ;   5- ALL
 ; IBSVCTYP - type of care
 ;   1 Medical Care
 ;   2 Outpatient Medication
 ;   3 Both (Medical Care and Outpatient Medication)
 ;
RUNRPT(RCDFN,FRMDTINT,TODTINT,IBSTAT,IBSVCTYP) ;Gather data for Report
 D GET350(RCDFN,FRMDTINT,TODTINT,IBSTAT,IBSVCTYP)
 I IBSTAT=5 D GET399^RCHRFS2(RCDFN,FRMDTINT,TODTINT,IBSVCTYP) ; Only pull file #399 data if user selected All as the desired IB Status
 Q
 ;
 ;
 ;Get data from #350
GET350(DFN,FRMDTINT,TODTINT,IBSTAT,IBSVCTYP) ; Collect data originating from the INTEGRATED BILLING ACTION file (#350)
 N IBIEN,IB0,STATLST,CNT,STATLST,LINE,RESULT,IBSTATNM,POP,SVCTYP,BILLNUM
 N DATEINFO,TRIGDT,SVCDT,XTEMP,DIC,DR,DA,DIQ,FBILLNUM,LCNT,LTRFLD,RC430IEN
 N TLTR,IBCANCLR,IBCANCLD,IBCANCLB,ARSTAT,ARAPPR,ARRSC,ARIEN,ARFLDS
 N RXADTNL,NORELDT,RXFILDT,RCHRFSST,STAT350,PTNINFO
 S (RXADTNL,NORELDT,RXFILDT)=""
 S (IBIEN,IBCANCLR,ICANCLD,IBCANCLB)="",CNT=0
 ; STATUS=1-BILLED,2- ON HOLD,3- CANCELLED,4- BILLED and ON HOLD, 5- ALL
 S STATLST=$S(IBSTAT=1:"/3/",IBSTAT=2:"/8/",IBSTAT=3:"/10/",IBSTAT=4:"/3/8/",1:"/3/8/10/")
 S PTNINFO=$$PATINFO^RCHRFSUT(DFN)
 I '$L(PTNINFO) Q  ;something wrong with the patient data
 K ^TMP($J,"RCHRFS",PTNINFO)
 F  S IBIEN=$O(^IB("C",DFN,IBIEN)) Q:IBIEN=""  D
 . K IBFLDS
 . S DIC=350,DR=".01:.07;.08;.09:.12;.14:.2;12:14",DA=IBIEN,DIQ="IBFLDS",DIQ(0)="IE" D EN^DIQ1
 . S STAT350="/"_IBFLDS(350,IBIEN,.05,"I")_"/"
 . S RXADTNL="" ;used only for RX copays in #350 to store additional information to get refill date and indicate whether we have the released date or not
 . S NORELDT=0 ;by default there IS the released date, if there is no released date then  =1
 . S RXFILDT=0 ;to store refill date
 . S DATEINFO=$$GETDTS
 . S RXADTNL=$P(DATEINFO,":",2) ;applies only to RX copays in #350 to store additional information to get refill dates and indicate whether we have the released date or not
 . S DATEINFO=$P(DATEINFO,":") ;the main data
 . I DATEINFO["#" D
 . . S RXDATE=IBFLDS(350,IBIEN,12,"I")
 . . S RXNUM=$E(IBFLDS(350,IBIEN,.08,"E"),1,12)
 . . S RXNAME=""
 . . S DATEINFO="RX/"_"350/"_RXDATE_"/"_RXDATE_"/"_RXNUM_"/"_$E(RXNAME,1,16)
 . S TRIGDT=$P(DATEINFO,"/",3) ;the date that used to compare against the date range and 
 . S SVCDT=$P(DATEINFO,"/",4) ; DOS
 . I DATEINFO["RX/350/" D
 . . S NORELDT=+RXADTNL ;if 1 then there is not release date, so don't display it
 . . S RXFILDT=$P(RXADTNL,U,2) ;fill/ refill date to display 
 . I TRIGDT'<FRMDTINT,TRIGDT'>TODTINT,(STATLST[STAT350) D
 . . ;Check Service Type
 . . S RESULT=IBFLDS(350,IBIEN,.04,"I"),SVCTYP=$P(RESULT,":",1)
 . . I IBSVCTYP=1,(SVCTYP=52!(IBFLDS(350,IBIEN,.03,"E")["RX")) Q  ;Only include Medical
 . . I IBSVCTYP=2,(SVCTYP'=52),(IBFLDS(350,IBIEN,.03,"E")'["RX") Q  ;Only include RX
 . . ;Get Cancellation information if it exists
 . . S IBCANCLR=IBFLDS(350,IBIEN,.1,"E")
 . . S IBCANCLD=IBFLDS(350,IBIEN,14,"I")
 . . S IBCANCLB=IBFLDS(350,IBIEN,13,"E")
 . . ;Get data & Set into scratch global ^TMP($J,"RCHRFS",PTNINFO,BILLNUM,DATE,CNT)=
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
 . . I $D(^TMP($J,"RCHRFS",PTNINFO,BILLNUM,SVCDT)) S CNT="" S CNT=$O(^TMP($J,"RCHRFS",PTNINFO,BILLNUM,SVCDT,CNT),-1)+1
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
 . . I SVCTYP=52 D
 . . . S XTEMP=XTEMP_U_U_$$STRIP^XLFSTR($$FMTE^XLFDT(SVCDT,"8D")," ") ;Pos 11 blank Pos 12 Release RX Date Col 7&8
 . . . S XTEMP=XTEMP_U_$P(DATEINFO,"/",5)_U_$P(DATEINFO,"/",6) ;Pos 13 RX Number, Pos 14 RX Name Col 9&10
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
 . . . K ARFLDS
 . . . S DIC=430,DR="61:63;68",DA=RC430IEN,DIQ="ARFLDS",DIQ(0)="I" D EN^DIQ1
 . . . S LCNT=0
 . . . F LTRFLD=61,62,63,68 D
 . . . . S LCNT=LCNT+1 S TLTR="LTR"_LCNT
 . . . . S @TLTR=ARFLDS(430,RC430IEN,LTRFLD,"I")
 . . . . I @TLTR'="" S XTEMP=XTEMP_U_$$STRIP^XLFSTR($$FMTE^XLFDT(@TLTR,"8D")," ") ; Pos 21-24 Letter 1-4
 . . . . I @TLTR="" S XTEMP=XTEMP_U_"NO DATE" ; Pos 21-24 Letter 1-4
 . . ;add HRfS information
 . . S RCHRFSST=$$HRFSDTS^RCHRFSUT(DFN,SVCDT)
 . . S $P(XTEMP,U,27)=$P(RCHRFSST,U,2) ;HRfS Activation Date 16
 . . S $P(XTEMP,U,28)=$P(RCHRFSST,U,3) ;HRfS Inactivation Date 18
 . . S $P(XTEMP,U,29)=$P(RCHRFSST,U,1) ;HRfS Active On DOS 11
 . . I SVCTYP=52 D
 . . . I NORELDT>0 S $P(XTEMP,U,12)=""
 . . . I RXFILDT>0 S $P(XTEMP,U,30)=RXFILDT
 . . S ^TMP($J,"RCHRFS",PTNINFO,BILLNUM,SVCDT,CNT)=XTEMP
 . . K XTEMP
 Q
 ;
 ;Loop through ^TMP to write report lines.
OUTPRPT ; Loop through ^TMP to write report lines.
 N LINE,BILLNUM,CNT,JUNK,PTNINFO
 S CNT=0,POP=0,LINE="",BILLNUM="",JUNK=0
 I '$D(^TMP($J,"RCHRFS")) S POP=1 W !,"NO DATA FOUND" Q
 S PTNINFO=""
 F  S PTNINFO=$O(^TMP($J,"RCHRFS",PTNINFO)) Q:PTNINFO=""!POP  D  Q:IBQUIT
 .F  S BILLNUM=$O(^TMP($J,"RCHRFS",PTNINFO,BILLNUM)) Q:BILLNUM=""!POP  D  Q:IBQUIT
 .. S SVCDT="" F  S SVCDT=$O(^TMP($J,"RCHRFS",PTNINFO,BILLNUM,SVCDT)) Q:SVCDT=""!POP  D  Q:IBQUIT
 ... S CNT="" F  S CNT=$O(^TMP($J,"RCHRFS",PTNINFO,BILLNUM,SVCDT,CNT)) Q:CNT=""  D  Q:IBQUIT
 .... I $Y>(IOSL-4) W ! D PAUSE(.IBQUIT) Q:IBQUIT  W @IOF D COLHEAD^RCHRFS
 .... S LINE=^TMP($J,"RCHRFS",PTNINFO,BILLNUM,SVCDT,CNT)
 .... I $P(LINE,U,9)=0 S $P(LINE,U,9)=""
 .... I '$P(LINE,U,4) D WRITEREC(PTNINFO,LINE)
 .... I $P(LINE,U,4)=$P(LINE,U,3),($P(LINE,U,3)'="") D WRITEREC(PTNINFO,LINE)
 K ^TMP($J,"RCHRFS")
 Q
 ;
 ;Write one line of the report
WRITEREC(PTNINFO,LINE) ; Write one line of report
 N PATNM,RCSSN
 S PATNM=$P(PTNINFO,U,1)
 S RCSSN=$P(PTNINFO,U,2)
 W !,$E(PATNM,1,26) ;Veteran Name, length: 26
 W ?26,U,RCSSN ;SSN 9
 W ?36,U,$P(LINE,U,27) ;HRfS Activation Date 16
 W ?53,U,$P(LINE,U,28) ;HRfS Inactivation Date 18
 W ?72,U,$P(LINE,U,29) ;HRfS Active On DOS 11
 W ?84,U,$P(LINE,U,9) ;Bill Number 11
 W ?96,U,$P(LINE,U,10) ;Category 26
 W ?123,U,$P(LINE,U,11) ;Medical DOS 11
 W ?135,U,$$STRIP^XLFSTR($$FMTE^XLFDT($P(LINE,U,30),"8D")," ") ;Rx Fill Date 12   
 W ?148,U,$P(LINE,U,12) ;Rx Release Date 15
 W ?164,U,$P(LINE,U,13) ;Rx Number 12
 W ?177,U,$E($P(LINE,U,14),1,16) ;Rx Name 16
 W ?194,U,$$RJ^XLFSTR($J($P(LINE,U,8),8,2),11) ;Charge Amount 11
 W ?206,U,$P(LINE,U,7) ;Unit 4
 W ?211,U,$P(LINE,U,6) ;IB STATUS 13
 W ?225,U,$P(LINE,U,15) ;AR STATUS 21
 Q
 ;
 ;Get dates for #350 entries
GETDTS() ; Get appropriate selection trigger dates by type of service
 ;Determine transaction type 52, RX Manual RX Out pat, inpatient, LTC inpatient, LTC Outpatient
 ;based on transaction type get date used for selection and determine if it falls within the 
 ;date range for the report.
 ; Return: Transaction type/File derived from/SELDT (Selection date)/DISPDT (display date).
 ; in the case of RX the following is appended to the return /RX #/Drug Name
 N IBTYPINT,IBTYPE,IBTYPE,IBBG,DATES,RESPONSE,SVCTYP,RXFLDS,RXRFILL,RXNUM,RXNAME,IBCAT,IBDTENT
 N RXDATE,RXIEN,RXNODE,IBDTFRM,RXFILDT,NORELDT
 S RESPONSE="",RXRFILL="",IBCAT="",IBDTFRM="",IBDTENT="",NORELDT=0
 ;RX via pharmacy system
 S IBCAT=IBFLDS(350,IBIEN,.03,"E")
 S IBTYPE=IBFLDS(350,IBIEN,.04,"E") S SVCTYP=+IBTYPE
 I SVCTYP=52 D  ;RX
 . ;get refill # if available and store it in RXRFILL
 . I $P(IBTYPE,";",2)'="" S RXRFILL=$P(IBTYPE,":",3)
 . K ^TMP($J,"RXRDT")
 . S RXIEN=+$P(IBTYPE,":",2)
 . S RXNODE="0,2"
 . I RXRFILL'="" S RXNODE="0,2,R^^"_RXRFILL
 . D RX^PSO52API(DFN,"RXRDT",RXIEN,,RXNODE,,)
 . I +$G(^TMP($J,"RXRDT",RXIEN,0))=-1 S RESPONSE="RX/"_"350#"_$P(^TMP($J,"RXRDT",RXIEN,0),U,2) Q
 . I RESPONSE'="" Q
 . I RXRFILL'="",$P(^TMP($J,"RXRDT",DFN,RXIEN,"RF",0),U,1)=-1 Q  ;No data for refill
 . ;get the release date if this is a refill (RXRFILL'="") 
 . I RXRFILL'="" S RXDATE=$P($G(^TMP($J,"RXRDT",DFN,RXIEN,"RF",RXRFILL,17)),U,1)
 . ;and if it is the original fill
 . E  S RXDATE=$P($G(^TMP($J,"RXRDT",DFN,RXIEN,31)),U,1)
 . ;get the fill date if this is a refill (RXRFILL'="") 
 . I RXRFILL'="" S RXFILDT=$P($G(^TMP($J,"RXRDT",DFN,RXIEN,"RF",RXRFILL,0.01)),U,1)
 . ;and if it is the original fill
 . E  S RXFILDT=+$P($G(^TMP($J,"RXRDT",DFN,RXIEN,22)),U,1)
 . ;
 . ;if no release date then use the refill date instead
 . I 'RXDATE,RXFILDT S RXDATE=RXFILDT,NORELDT=1 ;NORELDT=1 indicates that release date does not exist. Note: we set RXDATE=RXFILDT only for the inclusion logic, that compares release date with the selected date range
 . S RXDATE=RXDATE\1
 . S RXNUM=^TMP($J,"RXRDT",DFN,RXIEN,.01)
 . S RXNAME=$P(^TMP($J,"RXRDT",DFN,RXIEN,6),U,2)
 . S RESPONSE="RX/"_"350/"_RXDATE_"/"_RXDATE_"/"_RXNUM_"/"_$E(RXNAME,1,16)_":"_NORELDT_U_RXFILDT
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
 I IBCAT["INPT"!(IBCAT["ADMISSION") D
 . ;INP/350/(#.14) DATE BILLED FROM - used as trigger date to compare against the date range/(#.14) DATE BILLED FROM - used as DOS
 . S RESPONSE="INP/"_"350/"_IBFLDS(350,IBIEN,.14,"I")_"/"_IBFLDS(350,IBIEN,.14,"I")
 I RESPONSE'="" Q RESPONSE
 ;All Outpatient except for LTC
 S RESPONSE="OPT/350/"_IBFLDS(350,IBIEN,.14,"I")_"/"_IBFLDS(350,IBIEN,.14,"I")
 Q RESPONSE
 ;
PAUSE(IBQUIT) ;
 I $G(RCPAGE)>0,TRM K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 IBQUIT=1
 Q
 ;
CLEAN ; KILL ALL REMAINING VARIABLES BEFORE EXIT
 K ^TMP($J,"RXRDT")
 K RXFLDS,IBFLDS,TRIGDT,DPTDFN,IBRXFILL,IBRXNAM,IBRXNUM,ICANCLD,LTR1,LTR2,LTR3,LTR4,VADM
 K ARSTAT,ARAPPR,ARRSC
 Q
 ;
