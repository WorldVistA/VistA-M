IBTPRPT ;EDE/YMG - VETERAN THIRD PARTY CHARGE REPORT; 06/02/2023
 ;;2.0;INTEGRATED BILLING;**767**;21-MAR-94;Build 10
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; entry point
 N FILTER,POP,ZTDESC,ZTRTN,ZTSAVE,ZTSK,%ZIS
 K ^TMP("IBTPRPT",$J)
 I '$$ASKFLTR(.FILTER) Q
 D PRTEXCEL^IBUCMM()    ; Excel display message
 ; ask for device
 K IOP,IO("Q")
 S %ZIS="MQ",%ZIS("B")="0;256;999999",POP=0 D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q  ; queued report
 .S ZTDESC="Veteran Third Party Charges Report",ZTRTN="COMPILE^IBTPRPT"
 .S ZTSAVE("FILTER(")=""
 .S ZTSAVE("ZTREQ")="@"
 .D ^%ZTLOAD,HOME^%ZIS
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! D PAUSE
 .Q
 D COMPILE
 Q
 ;
COMPILE ; compile report
 N ADX,AMNT,ARDATA,ARSTAT,BAL,BILLFR,BILLNO,BILLTO,BILLTYPE,CHTYPE,CLTRK,CNT,DFN,DIV,DIVN,DRG,EVTDT,FUND,IBDATA,IBIEN,IBRXIEN,IBSITE,IBSTAT,IBXDATA,IENS,PATNM
 N PDX,PMNT,PYRNM,RNB,RSC,RXDATA,RXDT,RXNAME,RXNUM,SDX,SPAUTH,SSN,Z
 S EVTDT=FILTER("SDT")-.001 F  S EVTDT=$O(^DGCR(399,"D",EVTDT)) Q:'EVTDT!(EVTDT>FILTER("EDT"))  D
 .S (CNT,IBIEN)=0 F  S IBIEN=$O(^DGCR(399,"D",EVTDT,IBIEN)) Q:'IBIEN  D
 ..S CNT=CNT+1 I '$D(ZTQUEUED),'(CNT#100) W "."
 ..S IBSITE=$$IBSITE()
 ..S DIV=$$DIV^IBJDF2(IBIEN)  ; ptr to file 40.8
 ..I 'FILTER("DIVS"),$G(FILTER("DIVS",DIV))="" Q  ; not selected division
 ..S DIVN=$S(DIV=0:"",1:$$GET1^DIQ(40.8,DIV,1))  ; division station #
 ..K IBDATA S IENS=IBIEN_"," D GETS^DIQ(399,IENS,".01;.02;.07;.11;.13;.27;135;151;152;201;215","IE","IBDATA")
 ..I IBDATA(399,IENS,.11,"I")="p" Q  ; exclude bills that patient is responsible for
 ..S BILLNO=IBDATA(399,IENS,.01,"I")
 ..S DFN=IBDATA(399,IENS,.02,"I")
 ..I FILTER("TYPE")="P",'FILTER("PAT"),$G(FILTER("PAT",DFN))="" Q  ; not selected patient
 ..I FILTER("TYPE")="Y",'FILTER("PYR"),$G(IBDATA(399,IENS,135,"I")),$G(FILTER("PYR",IBDATA(399,IENS,135,"I")))="" Q  ; not selected payer
 ..S PATNM=IBDATA(399,IENS,.02,"E")
 ..S PYRNM=IBDATA(399,IENS,135,"E")
 ..S BILLTYPE=IBDATA(399,IENS,.07,"E")
 ..S BILLFR=IBDATA(399,IENS,151,"I")
 ..S BILLTO=IBDATA(399,IENS,152,"I")
 ..S IBSTAT=IBDATA(399,IENS,.13,"E")
 ..I FILTER("TYPE")="P",'FILTER("CANC"),IBSTAT="CANCELLED" Q  ; skip cancelled bills
 ..S AMNT=+IBDATA(399,IENS,201,"I")
 ..S CHTYPE=IBDATA(399,IENS,.27,"I")
 ..S SPAUTH=$$SPAUTH(DFN,BILLFR)
 ..S SSN=$$LAST4SSN(DFN)
 ..K IBXDATA D F^IBCEF("N-DRG USED",,,IBIEN) S DRG=$G(IBXDATA)  ; DRG code
 ..S CLTRK=$O(^IBT(356,"E",IBIEN,""),-1)  ; file 356 ien
 ..S RNB=$$GET1^DIQ(356,CLTRK,.19)
 ..K ARDATA D GETS^DIQ(430,IENS,"8;71;203;255.1","IE","ARDATA")
 ..S ARSTAT=ARDATA(430,IENS,8,"E")
 ..I ARSTAT="BILL INCOMPLETE" Q  ; skip incomplete claims
 ..I FILTER("TYPE")="P",FILTER("PAID"),ARSTAT'="COLLECTED/CLOSED" Q  ; skip paid claims
 ..S BAL=ARDATA(430,IENS,71,"I")
 ..S FUND=ARDATA(430,IENS,203,"E")
 ..S RSC=ARDATA(430,IENS,255.1,"E")
 ..S PMNT=$$PAID^PRCAFN1(IBIEN)
 ..; diagnoses
 ..K IBXDATA D F^IBCEF("N-DIAGNOSES",,,IBIEN)
 ..S PDX=$E($P($$ICD9^IBACSV(+$G(IBXDATA(1))),U,3),1,20)  ; primary dx
 ..S SDX=$E($P($$ICD9^IBACSV(+$G(IBXDATA(2))),U,3),1,20)  ; secondary dx
 ..S ADX=""
 ..I '$$INPAT^IBCEF(IBIEN) D
 ...S Z=IBDATA(399,IENS,215,"I") I Z S ADX=$E($P($$ICD9^IBACSV(Z,$$BDATE^IBACSV(IBIEN)),U,3),1,20)  ; admitting dx
 ...; Rx
 ...S IBRXIEN=0 F  S IBRXIEN=$O(^IBA(362.4,"C",IBIEN,IBRXIEN)) Q:'IBRXIEN  D
 ....K RXDATA S IENS=IBRXIEN_"," D GETS^DIQ(362.4,IENS,".01;.03;.04","IE","RXDATA")
 ....S RXNUM=RXDATA(362.4,IENS,.01,"I")  ; Rx #
 ....S RXDT=RXDATA(362.4,IENS,.03,"I")  ; Rx date
 ....S RXNAME=RXDATA(362.4,IENS,.04,"E")  ; Rx name
 ....S ^TMP("IBTPRPT",$J,PATNM,EVTDT,BILLNO,"RX",IBRXIEN)=RXNUM_U_$E(RXNAME,1,20)_U_RXDT
 ....Q
 ...Q
 ..S Z=IBSITE_U_DIVN_U_SSN_U_PYRNM_U_PDX_U_ADX_U_SDX_U_DRG_U_BILLTYPE_U_BILLFR_U_BILLTO_U_ARSTAT_U_IBSTAT_U_RNB_U_AMNT_U_PMNT_U_BAL_U_FUND_U_RSC_U_CHTYPE_U_SPAUTH
 ..S ^TMP("IBTPRPT",$J,PATNM,EVTDT,BILLNO)=Z
 ..Q
 .Q
 D PRINT
 K ^TMP("IBTPRPT",$J)
 I '$D(ZTQUEUED) D ^%ZISC
 Q
 ;
PRINT ; print report
 N BILLNO,DATA,EVTDT,EXTDT,FLTRSTR,PATNM,Z,Z1
 U IO
 S EXTDT=$$FMTE^XLFDT(DT)
 W !,"Veteran Third Party Charges Report^",EXTDT
 S FLTRSTR=""
 I 'FILTER("DIVS") S FLTRSTR="Divisions"
 I FILTER("TYPE")="P",'FILTER("PAT") S FLTRSTR=FLTRSTR_$S(FLTRSTR'="":", Patients",1:"Patients")
 I FILTER("TYPE")="Y",'FILTER("PYR") S FLTRSTR=FLTRSTR_$S(FLTRSTR'="":", Payers",1:"Payers")
 I FLTRSTR="" S FLTRSTR="No filters"
 I FILTER("TYPE")="P" D
 .S FLTRSTR=FLTRSTR_"; Cancelled bills "_$S(FILTER("CANC"):"included",1:"excluded")
 .S:FILTER("PAID") FLTRSTR=FLTRSTR_"; Paid claims only"
 .Q
 W !,"Filtered By: ",FLTRSTR
 W !,"Site^Division^Patient Name^SSN(last 4)^Bill #^Payer^Prim DX^Admit DX^Sec DX^DRG code^Bill Type^Care From^Care To^Rx #^"
 W "Rx Fill Name^RX Fill Date^AR Claim Status^IB Claim Status^RNB^Claim Amount^Payment^Balance^Fund^RSC/Revenue Source^Claim Type^Sp. Auth."
 ;
 I '$D(^TMP("IBTPRPT",$J)) W !,"No records found." Q
 S PATNM="" F  S PATNM=$O(^TMP("IBTPRPT",$J,PATNM)) Q:PATNM=""  D
 .S EVTDT="" F  S EVTDT=$O(^TMP("IBTPRPT",$J,PATNM,EVTDT)) Q:EVTDT=""  D
 ..S BILLNO="" F  S BILLNO=$O(^TMP("IBTPRPT",$J,PATNM,EVTDT,BILLNO)) Q:BILLNO=""  D
 ...S DATA=^TMP("IBTPRPT",$J,PATNM,EVTDT,BILLNO)
 ...I $D(^TMP("IBTPRPT",$J,PATNM,EVTDT,BILLNO,"RX")) S Z="" F  S Z=$O(^TMP("IBTPRPT",$J,PATNM,EVTDT,BILLNO,"RX",Z)) Q:'Z  D
 ....W !,$P(DATA,U,1,2),U,PATNM,U,$S($P(DATA,U,3)>0:$P(DATA,U,3),1:"N/A"),U,BILLNO,U,$P(DATA,U,4),"^^^^",$P(DATA,U,8,9),U
 ....W $$FMTE^XLFDT($P(DATA,U,10),"2DZ"),U,$$FMTE^XLFDT($P(DATA,U,11),"2DZ"),U
 ....S Z1=^TMP("IBTPRPT",$J,PATNM,EVTDT,BILLNO,"RX",Z)
 ....W $P(Z1,U,1,2),U,$$FMTE^XLFDT($P(Z1,U,3),"2DZ"),U ; Rx data
 ....W $P(DATA,U,12,19),U
 ....S Z1=$P(DATA,U,20) W $S(Z1=1:"Prof",Z1=2:"Inst",1:""),U ; caim type
 ....S Z1=$P(DATA,U,21) W $S(Z1=1:"Y",1:"N") ; special authority
 ....Q
 ...I '$D(^TMP("IBTPRPT",$J,PATNM,EVTDT,BILLNO,"RX")) D
 ....W !,$P(DATA,U,1,2),U,PATNM,U,$S($P(DATA,U,3)>0:$P(DATA,U,3),1:"N/A"),U,BILLNO,U,$P(DATA,U,4,9),U
 ....W $$FMTE^XLFDT($P(DATA,U,10),"2DZ"),U,$$FMTE^XLFDT($P(DATA,U,11),"2DZ"),"^^^^"
 ....W $P(DATA,U,12,19),U
 ....S Z1=$P(DATA,U,20) W $S(Z1=1:"Prof",Z1=2:"Inst",1:""),U ; caim type
 ....S Z1=$P(DATA,U,21) W $S(Z1=1:"Y",1:"N") ; special authority
 ....Q
 ...Q
 ..Q
 .Q
 Q
 ;
IBSITE() ; return site from IB site parameters
 N IBFAC,IBSITE,Y  ; all 3 are used in SITE^IBAUTL
 D SITE^IBAUTL
 Q IBSITE
 ;
SPAUTH(DFN,EVTDT) ; get special authority
 ;
 ; DFN - patient's DFN
 ; EVTDT - event date (bill from date)
 ;
 ; returns 1 if patient has special authority eligibility, 0 otherwise
 ;
 N RES,TMP,Z
 S RES=0
 D CL^IBACV(DFN,EVTDT,"",.TMP)
 F Z=1:1:8 I $D(TMP(Z)) D  Q:RES
 .I Z=7 S:+$$CVEDT^IBACV(DFN,EVTDT) RES=1 Q
 .S RES=1
 .Q
 Q RES
 ;
LAST4SSN(DFN) ; return lst 4 digits of patient's SSN
 ;
 ; DFN - patient's DFN
 ;
 ; returns last 4 digits of patient's SSN, or 0 if SSN couldn't be found
 ;
 N VADM,Z
 D DEM^VADPT
 S Z=+$G(VADM(2))
 Q $E(Z,$L(Z)-3,$L(Z))
 ;
ASKFLTR(FILTER) ; filter prompts
 ;
 ; FILTER - array of filters, passed by reference
 ;
 ; returns 1 on success, 0 for user exit / timeout
 ;
 ; sets FILTER("DIVS") = 1 for all divisions, 0 for selected divsions
 ;      FILTER("DIVS",file 40.8 ien) = division name (only for selected divisions)
 ;      FILTER("SDT") and FILTER("EDT") to start date and end date respectively
 ;      FILTER("TYPE") = "P" for report by patient, "Y" for report by payer
 ;  report by patient only:
 ;      FILTER("PAT") = 1 for all patients, 0 for selected patients
 ;      FILTER("PAT",DFN) = patient name (only for selected patients)
 ;      FILTER("CANC") = 1 for printing cancelled bills, 0 for not printing them
 ;      FILTER("PAID") = 1 for printing just paid claims, 0 for printing all claims
 ;  report by payer only:
 ;      FILTER("PYR") = 1 for all payers, 0 for selected payers
 ;      FILTER("PYR",file 36 ien) = payer name (only for selected payers)
 ;
 N RES,Z
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 N VAUTD,VAUTN,VAUTNI
 D DIVISION^VAUTOMA I 'VAUTD,$O(VAUTD(""))="" Q 0  ; filter by division
 M FILTER("DIVS")=VAUTD
 I '$$ASKDT(.FILTER) Q 0  ; filter by date of service
 S DIR(0)="SA^P:Patient;Y:Payer",DIR("B")="P"
 S DIR("A")="Run Report by (P)atient or Pa(Y)er? (P/Y): "
 D ^DIR I $D(DIRUT)!$D(DIROUT) Q 0
 S FILTER("TYPE")=Y,RES=1
 I FILTER("TYPE")="P" D  ; by patient
 .S VAUTNI=2 D PATIENT^VAUTOMA I 'VAUTN,$O(VAUTN(""))="" S RES=0 Q
 .M FILTER("PAT")=VAUTN
 .S Z=$$ASKPAID() I Z=-1 S RES=0 Q
 .S FILTER("PAID")=Z
 .I FILTER("PAID")=1 S FILTER("CANC")=1 Q
 .S Z=$$ASKCANC() I Z=-1 S RES=0 Q
 .S FILTER("CANC")=Z
 .Q
 I FILTER("TYPE")="Y" D  ; by payer
 .I '$$ASKPYR(.FILTER) S RES=0
 .Q
 Q RES
 ;
ASKDT(FILTER) ; prompt for start and end dates
 ;
 ; FILTER - array of filters, passed by reference
 ;
 ; returns 1 on success, 0 on user exit / timeout
 ;
 ; sets FILTER("SDT") and FILTER("EDT") to start date and end date respectively
 ;
 N RES
 N DIR,DUOUT,DTOUT,DIRUT,X,Y
 S RES=0
 S DIR(0)="D^::EX"
 S DIR("A")="Start with Date of Service"
 S DIR("?")="   Please enter a valid starting date of service."
 D ^DIR I $D(DIRUT)!$D(DIROUT) G ASKDTX
 S FILTER("SDT")=Y
 ; End date
ASKDT1 ;
 S DIR("A")="  End with Date of Service"
 S DIR("?",1)="   Please enter a valid ending date of service."
 S DIR("?")="   This date must not precede the starting date entered above."
 D ^DIR I $D(DIRUT)!$D(DIROUT) G ASKDTX
 I Y<FILTER("SDT") W !,"     End Date must not precede the Start Date." G ASKDT1
 S FILTER("EDT")=Y,RES=1
 ;
ASKDTX ; dates prompt exit point
 Q RES
 ;
ASKCANC() ; "display cancelled bills?" prompt
 ;
 ; returns 1 for Yes, 0 for No, -1 for user exit / timeout
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="Y"
 S DIR("A")="Display cancelled bills (Y/N)"
 D ^DIR I $D(DIRUT)!$D(DIROUT) Q -1
 Q $S(Y>0:1,1:0)
 ;
ASKPAID() ; "display paid claims?" prompt
 ;
 ; returns 1 for Yes, 0 for No, -1 for user exit / timeout
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="Y"
 S DIR("A")="Display paid claims only(Y/N)"
 D ^DIR I $D(DIRUT)!$D(DIROUT) Q -1
 Q $S(Y>0:1,1:0)
 ;
ASKPYR(FILTER) ; prompt for payer(s)
 ;
 ; FILTER - array of filters, passed by reference
 ;
 ; returns 1 on success, 0 on user exit / timeout
 ;
 ; sets FILTER("PYR") = 1 for all payers, 0 for selected payers
 ;      FILTER("PYR",file 36 ien) = payer name (only for selected payers)
 ;
 N DIC,VAUTNI,VAUTP,VAUTSTR,VAUTVB
 S DIC=36,VAUTNI=0,VAUTSTR="payer",VAUTVB="VAUTP" D FIRST^VAUTOMA
 I 'VAUTP,$O(VAUTP(""))="" Q 0
 M FILTER("PYR")=VAUTP
 Q 1
 ;
PAUSE ; "Press Return to Continue" prompt
 N DIR,DUOUT,DTOUT,DIROUT,DIRUT,X,Y
 W !
 S DIR(0)="E" D ^DIR
 W !
 Q
