IBOSCDC1 ;ALB/BNT - SERVICE CONNECTED DETERMINATION CHANGE REPORT UTILITIES;10/04/07
 ;;2.0;INTEGRATED BILLING;**384**;21-MAR-94;Build 74
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Patient info for header
 ;Input:
 ;IBDFN = Patient DFN
 ;IBLEN = Length of overall characters for output
 ;Returns:
 ;Left Justified patient name with Last 4 SSN
PATINF(IBDFN,IBLEN) ;
 N X
 S X=$$PATNAME(IBDFN,IBLEN-7)_" "_$$SSN4^IBNCPRR1(IBDFN)
 Q $$LJ(X,IBLEN) ;name
 ;
 ;Get patient's name
 ;Input:
 ;IBDFN = Patient DFN
 ;IBLEN = Length of characters to return
 ;Returns:
 ;patient's name
PATNAME(IBDFN,IBLEN) ;
 Q $E($P($G(^DPT(IBDFN,0)),U),1,IBLEN)
 ;
 ;left justified, blank padded
 ;adds spaces on right or truncates to make return string IBLEN characters long
 ;IBST- original string
 ;IBLEN - desired length
LJ(IBST,IBLEN) ;
 N IBL
 S IBL=IBLEN-$L(IBST)
 Q $E(IBST_$J("",$S(IBL<0:0,1:IBL)),1,IBLEN)
 ;
 ;Get Third Party bill from file 362.4, if one exists
 ;IBRXN = RX number
 ;IBDT = RX Fill Date
 ;Returns the Bill Number
BILL(IBRXN,IBDT) ;Bill IEN (if any) or null
 N RES,X,IBZ
 S IBDT=$P(IBDT,".")
 S RES=""
 S X="" F  S X=$O(^IBA(362.4,"B",IBRXN,X),-1) Q:X=""  D:X  Q:RES
 . S IBZ=$G(^IBA(362.4,X,0))
 . I $P($P(IBZ,U,3),".")=IBDT,$P(IBZ,U,2) S RES=+$P(IBZ,U,2)
 Q RES
 ;
 ;Check if the status on the first party bill in 350 is CANCELLED?
 ;IBILL = IEN from file 350
 ;Returns 1=yes, 0=no
BILLCNCL(IBILL) ;
 N IBBILSTS
 Q:(IBILL="")!(IBILL=0) 1
 Q $S($$BILLSTS(IBILL)["CANCEL":1,1:0)
 ;
 ;Returns the PRINT NAME of the STATUS associated with a bill
 ;IBILL = IEN from file 350
 ;Returns the PRINT NAME field from file 350.21
BILLSTS(IBILL) ;
 N IBBILSTS
 Q:(IBILL="")!(IBILL=0) ""
 S IBBILSTS=$P(^IB(IBILL,0),U,5)
 Q $P(^IBE(350.21,IBBILSTS,0),U,2)
 ;
 ;Get the TOTAL CHARGE for the bill
 ;IBILL = IEN from file 350
 ;Returns the TOTAL CHARGE 
BILLAMNT(IBILL) ;
 N X,X2,X3
 Q:(IBILL="")!(IBILL=0) ""
 S X=$P(^IB(IBILL,0),U,7),X2="2$",X3=0 D COMMA^%DTC
 Q X
 ;
 ;Collect the RX related data using Pharmacy API for the report and store in ^TMP($J,"IBRXARR"
 ;DFN = Patient IEN
 ;IBBDT = Beginning search date, used to determine if Rx was filled within this date
COLLECT(DFN,IBBDT) ; Collect data for patient
 N LIST,IBRX,IBFIL,CNT
 S LIST="IBRXARR",(IBRX,CNT,IBFIL)=0
 K ^TMP($J,LIST)
 D RX^PSO52API(DFN,LIST,,,"2,I,R",,)
 F  S IBRX=$O(^TMP($J,LIST,DFN,IBRX)) Q:'IBRX  D
 . Q:'+$P(^TMP($J,LIST,DFN,IBRX,31),U)
 . D GETDATA(0,IBRX,DFN,LIST)
 . I ^TMP($J,LIST,DFN,IBRX,"RF",0)<0 Q
 . F  S IBFIL=$O(^TMP($J,LIST,DFN,IBRX,"RF",IBFIL)) Q:IBFIL=""  D 
 . . Q:IBFIL=0
 . . D GETDATA(IBFIL,IBRX,DFN,LIST)
 . Q
 Q
 ;
 ;Gets specific data for first and third party bills and store in TMP file
 ;IBFIL = RX Fill #
 ;IBRX = IEN to Prescription file - RX ID Placeholder in the TMP file
 ;DFN = Patient IEN
 ;LIST = placeholder for data in ^TMP file
GETDATA(IBFIL,IBRX,DFN,LIST) ;
 N IBBA,IBBILL,IBRXN,IBFILDT,IBRXINS,IBBILLN,IBECN
 I IBFIL=0 D
 . S IBFILDT=+$P(^TMP($J,LIST,DFN,IBRX,22),U)
 . S IBBA=+$P($G(^TMP($J,LIST,DFN,IBRX,106)),U)
 E  S IBFILDT=+$P(^TMP($J,LIST,DFN,IBRX,"RF",IBFIL,.01),U) D
 . S IBBA=+$P($G(^TMP($J,LIST,DFN,IBRX,"IB",IBFIL,9)),U)
 Q:IBFILDT<IBBDT
 S IBRXN=^TMP($J,LIST,DFN,IBRX,.01)
 ; First party copay
 I $$BILLCNCL(IBBA) Q
 S IBBILL=$P($P(^IB(IBBA,0),U,11),"-",2)
 I IBBILL="" S IBBILL=$$BILLSTS(IBBA)
 S CNT=CNT+1 D SETREF(CNT,IBRXN,IBFIL,IBFILDT,IBBILL,"Copay","",$$BILLAMNT(IBBA))
 ; Third party bills
 S IBBILL=$$BILL(IBRXN,IBFILDT) Q:IBBILL']""
 S IBBILLN=$$GETBILLN(IBBILL)
 S IBRXINS=$$GETINS(IBBILL)
 S IBECN=$$ECMENO^IBNCPRR1(IBRX)
 S CNT=CNT+1 D SETREF(CNT,IBRXN,IBFIL,IBFILDT,IBBILLN,IBRXINS,IBECN,"")
 Q
 ;
 ;SETREF sets the reference global with report data
 ;INPUT: DATA = Counter^RxIEN^Rx#^Fill#^FillDate^BillNumber^BillInsurance^ECME#^TotalCharge
SETREF(CNT,IBRXN,IBFIL,IBDT,IBBILLN,IBRXINS,IBECN,IBCHRG) ;
 S @REF@(DFN,CNT)=IBRXN_U_IBFIL_U_IBDT_U_IBBILLN_U_IBECN_U_IBRXINS_U_IBCHRG
 Q
 ;
 ;Get the Bill Number from file 399
 ;Input:
 ;IEN of file 399
 ;Returns:
 ;BILL NUMBER field
GETBILLN(IBBIL) ;
 Q $P($G(^DGCR(399,IBBIL,0)),U)_$$ECME^IBTRE(IBBIL,"")
 ;
 ;Get the ECME Number from file 399
 ;Input:
 ;IEN of file 399
 ;Returns:
 ;ECME NUMBER field
GETECME(IBBIL) ;
 Q $P($P($G(^DGCR(399,IBBIL,"M1")),U,8),";")
 ;
 ;Get Insurance payer
 ;Input:
 ;IEN of file 399
 ;Returns:
 ;Insurance company name prefixed with p-, s-, or t-.
GETINS(IBBIL) ;
 N IBINS,IBSEQ,IBM
 Q:'$D(^DGCR(399,IBBIL,0)) ""
 S IBSEQ=$P(^DGCR(399,IBBIL,0),U,21)
 ;Don't include Patient in CURRENT BILL PAYER SEQUENCE.
 Q:IBSEQ["A" ""
 S IBM=$G(^DGCR(399,IBBIL,"M"))
 Q:'IBM "UNKNOWN"
 S IBINS=$S(IBSEQ="P":$P(IBM,U),IBSEQ="S":$P(IBM,U,2),IBSEQ="T":$P(IBM,U,3))
 I IBINS']"" Q "UNKNOWN"
 Q $$LOW^XLFSTR(IBSEQ)_"-"_$P(^DIC(36,IBINS,0),U)
 ;
