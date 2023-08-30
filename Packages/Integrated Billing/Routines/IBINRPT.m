IBINRPT ;YMG/EDE -  Indian Attestation (MEGABUS Act) Copay Exemption Report ;NOV 23 2021
 ;;2.0;INTEGRATED BILLING;**716**;21-MAR-94;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to FILE #2 in ICR #7300
 ;
 Q
 ;
EN ; entry point
 N EXCEL,IBEND,IBSTART,QUIT
 N POP,ZTDESC,ZTRTN,ZTSAVE,ZTSK,%ZIS
 K ^TMP("IBINRPT",$J)
 W !!,"Indian Attestation Copay Exemption Report",!
 ; ask for dates
 S QUIT=0 D ASKDT I QUIT Q
 ; export to Excel?
 S EXCEL=$$GETEXCEL^IBUCMM() I EXCEL<0 Q
 I EXCEL D PRTEXCEL^IBUCMM()
 I 'EXCEL W !!,"This report requires 132 column display.",!
 ; ask for device
 K IOP,IO("Q")
 S %ZIS="MQ",%ZIS("B")="",POP=0 D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q  ; queued report
 .S ZTDESC="Indian Attestation Copay Exemption Report",ZTRTN="COMPILE^IBINRPT"
 .S ZTSAVE("EXCEL")="",ZTSAVE("IBEND")="",ZTSAVE("IBSTART")="",ZTSAVE("ZTREQ")="@"
 .D ^%ZTLOAD,HOME^%ZIS
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! D PAUSE
 .Q
 D COMPILE
 Q
 ;
COMPILE ; compile report
 N IBBLNO,IBCHRG,IBCHTYPE,IBDATA,IBDFN,IBFR,IBGRP,IBIEN,IBINDTM,IBINFLG,IBINSTDT,IBNM,IBPID,IBSTATNM,IBTO,Z
 S IBINDTM=IBSTART-.001 F  S IBINDTM=$O(^DPT("AINC",IBINDTM)) Q:'IBINDTM!($P(IBINDTM,".")>IBEND)  D
 .S IBDFN=0 F  S IBDFN=$O(^DPT("AINC",IBINDTM,IBDFN)) Q:'IBDFN  D
 ..S Z=$$INDGET^IBINUT1(IBDFN)
 ..S IBINFLG=$P(Z,U)  ; indian self-identification flag (Y/N)
 ..S IBINSTDT=$P(Z,U,2)  ; indian self-identification start date
 ..S IBIEN=0 F  S IBIEN=$O(^IB("C",IBDFN,IBIEN)) Q:'IBIEN  D
 ...S IBDATA=^IB(IBIEN,0)  ; file 350 node 0
 ...S IBTO=+$P(IBDATA,U,15)  ; "Bill To" date
 ...I '$$INDCHKDT^IBINUT1(IBTO,IBINSTDT) Q  ; bill timeframe is not covered by exemption
 ...S IBSTATNM=$$GET1^DIQ(350,IBIEN_",",.05,"E")  ; bill status (350/.05) - external
 ...; check bill status
 ...I IBINFLG="Y","^BILLED^HOLD - RATE^HOLD - REVIEW^ON HOLD^"'[(U_IBSTATNM_U) Q
 ...I IBINFLG'="Y",IBSTATNM'="CANCELLED" Q
 ...S IBCHTYPE=$P(IBDATA,U,3) Q:IBCHTYPE=""  ; charge type (350/.03)
 ...S IBGRP=$P(^IBE(350.1,IBCHTYPE,0),U,11) I IBGRP=7!(IBGRP=9) Q  ; quit if LTC or Tricare charge
 ...Q:$$GET1^DIQ(350.1,IBCHTYPE,.05,"E")'="NEW"
 ...S IBBLNO=$P(IBDATA,U,11)  ; bill #
 ...S Z=$$PATID(IBDFN),IBPID=$P(Z,U),IBNM=$P(Z,U,2)  ; patient id and name
 ...S IBCHRG=$P(IBDATA,U,7)  ; bill amount (350/.07)
 ...S IBFR=$P(IBDATA,U,14)  ; "Bill From" date
 ...S ^TMP("IBINRPT",$J,IBDFN,IBIEN)=IBNM_U_IBPID_U_IBINDTM_U_IBINFLG_U_IBBLNO_U_IBCHTYPE_U_IBSTATNM_U_IBFR_U_IBTO_U_IBCHRG
 ...S ^TMP("IBINRPT",$J,"IDX",IBNM,IBDFN)=""
 ...Q
 ..Q
 .Q
 D PRINT
 K ^TMP("IBINRPT",$J)
 Q
 ;
PRINT ; print report
 N EXTDT,IBCHRG,IBCHTYPE,IBDATA,IBDFN,IBNM,LN,PAGE,QUIT
 U IO
 S (PAGE,QUIT)=0
 S EXTDT=$$FMTE^XLFDT(DT)
 I EXCEL D
 .W !,"Indian Attestation Copay Exemption Report",U,EXTDT,U,$$FMTE^XLFDT(IBSTART),"-",$$FMTE^XLFDT(IBEND)
 .W !,"Name^ID^Indian change date/time^Indian status^Bill #^Charge type^Bill status^Bill From date^Bill To Date^Bill amount"
 .Q
 I 'EXCEL D
 .I $E(IOST,1,2)["C-",'$D(ZTQUEUED) W @IOF
 .D HDR
 .Q
 I '$D(^TMP("IBINRPT",$J)) D  Q
 .I EXCEL W !!,"No records found." Q
 .W !!,$$CJ^XLFSTR("No records found.",132)
 .I PAGE>0,'$D(ZTQUEUED) W ! D PAUSE W @IOF
 .Q
 S IBNM="" F  S IBNM=$O(^TMP("IBINRPT",$J,"IDX",IBNM)) Q:IBNM=""!QUIT  D
 .S IBDFN="" F  S IBDFN=$O(^TMP("IBINRPT",$J,"IDX",IBNM,IBDFN)) Q:IBDFN=""!QUIT  D
 ..S IBIEN="" F  S IBIEN=$O(^TMP("IBINRPT",$J,IBDFN,IBIEN)) Q:IBIEN=""!QUIT  D
 ...S IBDATA=^TMP("IBINRPT",$J,IBDFN,IBIEN)
 ...S IBCHTYPE=$$GET1^DIQ(350.1,$P(IBDATA,U,6),.01,"E")
 ...S IBCHRG=$FN($P(IBDATA,U,10),"",2)
 ...I EXCEL D  Q
 ....W !,$P(IBDATA,U),U,$P(IBDATA,U,2),U,$$FMTE^XLFDT($P(IBDATA,U,3),"2Z"),U,$P(IBDATA,U,4),U,$P(IBDATA,U,5),U,IBCHTYPE,U,$P(IBDATA,U,7),U
 ....W $$FMTE^XLFDT($P(IBDATA,U,8),"2DZ"),U,$$FMTE^XLFDT($P(IBDATA,U,9),"2DZ"),U,IBCHRG
 ....Q
 ...S LN=LN+1
 ...W !,$E($P(IBDATA,U),1,25),?27,$P(IBDATA,U,2),?34,$$FMTE^XLFDT($P(IBDATA,U,3),"2Z"),?54,$P(IBDATA,U,4),?59,$$CJ^XLFSTR($P(IBDATA,U,5),12),?72
 ...W $E(IBCHTYPE,1,12),?86,$$CJ^XLFSTR($P(IBDATA,U,7),13),?101,$$FMTE^XLFDT($P(IBDATA,U,8),"2DZ"),?112,$$FMTE^XLFDT($P(IBDATA,U,9),"2DZ"),?121,$$CJ^XLFSTR("$"_IBCHRG,11)
 ...I LN>(IOSL-3) D HDR I QUIT Q
 ...Q
 ..Q
 .Q
 I PAGE>0,'$D(ZTQUEUED),'QUIT W ! D PAUSE W @IOF
 Q
 ;
HDR ; print header
 I PAGE>0,'$D(ZTQUEUED) D PAUSE W @IOF I $G(QUIT) Q
 S PAGE=PAGE+1,LN=8
 W !,"Indian Attestation Copay Exemption Report",?66,EXTDT,?120,"Page: ",PAGE
 W !,"Indian Attestation Change dates: ",$$FMTE^XLFDT(IBSTART)," - ",$$FMTE^XLFDT(IBEND)
 W !!,"Bills with Indian Attestation Status = Y : Eligible for possible cancellation."
 W !,"Bills with Indian Attestation Status = N : Eligible for possible re-billing."
 W !
 W !,"                                    Indian Change   Indian                                           Bill From  Bill To     Bill"
 W !,"Name                        ID        Date/Time     Status    Bill #    Charge Type    Bill Status      Date      Date     Amount"
 W ! D DASH(132)
 Q
 ;
DASH(LEN) ; print line of dashes
 N DASH
 S $P(DASH,"-",LEN+1)="" W DASH
 Q
 ;
PATID(DFN) ; returns Id for a given patient
 ;
 ; DFN - patient's DFN
 ;
 ; returns [first letter of the last name]_[last 4 digits of the SSN for a given patient] ^ patient name, or "" if unable to get the Id
 ;
 N IBNM,VADM
 I +$G(DFN)'>0 Q ""
 D DEM^VADPT
 S IBNM=VADM(1)
 Q $E(IBNM,1)_$P($P(VADM(2),U,2),"-",3)_U_IBNM
 ;
ASKDT ; prompt for start and end dates
 ;
 ; sets IBSTART and IBEND vars to start date and end date respectively, sets QUIT=1 on user exit
 ;
 N DIR,DUOUT,DTOUT,DIRUT,X,Y
 S DIR(0)="D^::EX"
 S DIR("A")="Start with Indian Attestation Change date"
 S DIR("B")=$$FMTE^XLFDT($$FMADD^XLFDT(DT,-7),"1D")
 S DIR("?")="   Please enter a valid start date."
 D ^DIR
 I $D(DIRUT) S QUIT=1 G ASKDTX
 S IBSTART=Y
 ; End date
ASKDT1 ;
 S DIR("A")="  End with Indian Attestation Change date"
 S DIR("B")=$$FMTE^XLFDT($$FMADD^XLFDT(DT),"1D")
 S DIR("?",1)="   Please enter a valid end date."
 S DIR("?")="   This date must not precede the start date entered above."
 D ^DIR
 I $D(DIRUT) S QUIT=1 G ASKDTX
 I Y<IBSTART W !,"     End Date must not precede the Start Date." G ASKDT1
 S IBEND=Y
 ;
ASKDTX ; dates prompt exit point
 Q
 ;
PAUSE    ; "Type <Enter> to continue" prompt
 N DIR,DUOUT,DTOUT,DIRUT,X,Y
 S DIR(0)="E" D ^DIR
 I $D(DIRUT) S QUIT=1
 W !
 Q
