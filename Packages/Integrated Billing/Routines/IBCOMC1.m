IBCOMC1 ;ALB/CMS-IDENTIFY PT BY AGE WITH OR WITHOUT INSURANCE (CON'T);10-09-98
 ;;2.0;INTEGRATED BILLING;**103,183**;21-MAR-94
 Q
 ;
BEG ; Entry to run Identify Patients with/without Insurance Report
 ; Input variables must exist:
 ; IBAIB  - Required.    How to sort
 ;          1= Patient Name Range      2= Termianl Digit Range
 ; IBRF   - Required.  Name or Terminal Digit Range Start value
 ; IBRL   - Required.  Name or Terminal Digit Range Go to value
 ; IBAGEF - Optional.  Age start value or null
 ; IBAGEL - Optional.  Age end value or null
 ; IBBDT  - Required.  Last Treated Start Date
 ; IBEDT  - Required.  Last Treated End Date
 ;
 ; IBSIN  - Required.   Include Insurance Company search
 ;          1=Insurance Co. Range  2=Selected Ins. Co.  3=No Ins. Co.
 ;          If IBSIN=2 then the $O(IBSIN(1-6))=selected companies
 ; IBSINF - Optional.   Ins. Co. start Range or null
 ; IBSINL - Optional.   Ins. Co. end Range or null
 ;
 N DFN,IBC,IBC0,IBDLT,IBGP,IBI,IBINS,IBINSV,IBPAGE,IBQUIT
 N IBTMP,IBTD,IBX,IBXX,SDCNT,VA,VADM,VAERR,VAPA,X,Y
 K ^TMP("IBCOMC",$J) S IBPAGE=0,IBQUIT=0,IBINSV=""
 ;
 ;  Date Last Treated entered get DFN's
 D DLT
 ;
 S DFN=0 F  S DFN=$O(^TMP("IBCOMC",$J,"DLT",DFN)) Q:'DFN  D
 .;
 .K IBINS S (IBTD,IBINSV,IBINS)=""
 .;  I Terminal Digit out of range quit
 .I IBAIB=2 S IBTD=$$TERMDG^IBCONS2(DFN) I (+IBTD>IBRL)!(IBRF>+IBTD) Q
 .K VA,VADM,VAERR,VAPA
 .D DEM^VADPT,ADD^VADPT
 .;
 .;  I Pt. name out of range quit
 .S VADM(1)=$P($G(VADM(1)),U,1) I VADM(1)="" Q
 .I IBAIB=1,VADM(1)]IBRL Q
 .I IBAIB=1,IBRF]VADM(1) Q
 .;
 .;  I Age out of range quit
 .I IBAGEF I (+VADM(4)<IBAGEF)!(+VADM(4)>IBAGEL) Q
 .;
 .;  Check Insurance
 .S IBINSV=$G(^IBA(354,+DFN,60)) I IBSIN'=3,+IBINSV Q
 .I IBSIN=3,IBINSV D SET Q
 .;
 .D ALL^IBCNS1(DFN,"IBINS",3)
 .I IBSIN=3,$G(IBINS(0)) Q
 .I IBSIN=3,'$G(IBINS(0)) D SET Q
 .;
 .S IBX=0 F  S IBX=$O(IBINS(IBX)) Q:'IBX  D
 ..S IBC=IBINS(IBX,0)
 ..S IBC0=$G(^DIC(36,+IBC,0))
 ..I IBSIN=1,$P(IBC0,U,1)]IBSINF,IBSINL]$P(IBC0,U,1) D SET Q
 ..I IBSIN=2 F IBXX=1:1:6 I $G(IBSIN(IBXX)),+IBC=+IBSIN(IBXX) D SET
 .;
 I '$O(^TMP("IBCOMC",$J,0)) D HD^IBCOMC2 W !!,"** NO RECORDS FOUND **" G QUEQ
 D HD^IBCOMC2,WRT^IBCOMC2
 ;
QUEQ ; Exit clean-UP
 W ! D ^%ZISC K IBTMP,IBAIB,IBRF,IBRL,IBSIN,IBAGEF,IBAGEL,IBBDT,IBEDT,IBSINF,IBSINL,VA,VAERR,VADM,VAPA,^TMP("IBCOMC",$J)
 Q
 ;
SET ;   set data line for global
 ;S IBTMP(1)=PT NAME^SSN^AGE^DOB^CAT^DATE LAST VISIT
 ;S IBTMP(2)=INSURANCE NAME^REIMBURSE?^GROUP NAME
 ;           or Date Verified No Insurance on File and Patient Home Phone
 ;
 N IBTD,IBCAT
 S IBTD(+$G(^TMP("IBCOMC",$J,"DLT",DFN,"INP")))="Inp "
 S IBTD(+$G(^TMP("IBCOMC",$J,"DLT",DFN,"OUT")))="Out "
 S IBTD=$O(IBTD(""),-1) S IBTD=IBTD_U_IBTD(IBTD)
 S IBCAT=$P($$LST^DGMTU(DFN),U,4) S IBCAT=$S(IBCAT="C":"Yes",IBCAT="G":"GMT",1:"No")
 S IBTMP(1)=$S(+VADM(6):"*",1:"")_VADM(1)_U_"("_$E(VADM(1),1,1)_$P($P(VADM(2),U,2),"-",3)_")"_U_+VADM(4)_U_$P(VADM(3),U,2)_U_IBCAT_U_$P(IBTD,U,2)_$$FMTE^XLFDT(+IBTD,"5ZD")
 I IBSIN=3 S IBTMP(2)=$S(+IBINSV:"No Coverage Verified: "_$$FMTE^XLFDT(+IBINSV,"5ZD"),1:"No Insurance on File.")_"  Patient's Home Phone: "_$P(VAPA(8),U,1)
 I IBSIN'=3 S IBTMP(2)=$P(IBC0,U,1)_U_$P(IBC0,U,2)_U_$S($P($G(IBINS(IBX,355.3)),U,3)]"":$P(IBINS(IBX,355.3),U,3),1:"(No Plan Name)")
 ;
 ;   Set Global array
 S ^TMP("IBCOMC",$J,1,$S(IBAIB=2:IBTD,1:VADM(1)),DFN)=IBTMP(1)
 I IBSIN=3 S IBC=999999999
 S ^TMP("IBCOMC",$J,1,$S(IBAIB=2:IBTD,1:VADM(1)),DFN,+IBC)=IBTMP(2)
SETQ Q
 ;
DLT ;  Get DFN's for Date Last Treated Range
 N IBCBK,IBDA,IBFIL,IBQUERY,IBVAL,IBX,X,Y K ^TMP("IBCOMC",$J,"DLT")
 I (IBBDT="")!(IBEDT="") G DLTQ
 S IBFIL="",IBCBK="I '$P(Y0,U,6),$P(Y0,U,12)=2,$P(Y0,U,7) S ^TMP(""IBCOMC"",$J,""DLT"",Y,""INP"")=+Y0"
 S IBVAL("BDT")=IBBDT,IBVAL("EDT")=IBEDT
 ;
 ;   get DFNs for date last seen outpatient
 D SCAN^IBSDU("DATE/TIME",.IBVAL,IBFIL,IBCBK,1,0,"BACKWARD")
 ;
 ;   get DFNs for date last seen discharge date
 S IBX=IBBDT F  S IBX=$O(^DGPM("ATT3",IBX)) Q:('IBX)!(IBX>IBEDT)  D
 .S IBDA=0 F  S IBDA=$O(^DGPM("ATT3",IBX,IBDA)) Q:'IBDA  D
 ..S ^TMP("IBCOMC",$J,"DLT",+$P($G(^DGPM(IBDA,0)),U,3),"OUT")=IBX
DLTQ Q
 ;IBCOMC1
