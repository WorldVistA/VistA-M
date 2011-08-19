IBCROE ;OAK/ELZ - CHARGE MASTER TO EXCEL OUTPUT ;28-NOV-2005
 ;;2.0;INTEGRATED BILLING;**308**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine will produce output from Charge Master for the local site in a format that can be imported
 ; into excel.
 ; 
 ; load an Inpatient and a Non-Provider based site for same zip code first
 ; 
 ;
EN ; main option entry point
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,IBRCVER,IBZIP,POP,%ZIS,IBVERS,ZTRTN,ZTDESC,ZTSAVE,ZTSK
 ;
 ;find zip code for extraction
 S DIR(0)="F^3:3^K:X'?3N X",DIR("A")="Enter a 3 digit zip identifier"
 S DIR("?")="Enter the first 3 digits of a zip code for which you want to extract data." D ^DIR Q:$D(DIRUT)
 S IBZIP=Y
 ;
 S IBVERS=$$SELVERS Q:'IBVERS
 ;
 ; find out where to write output
 W !!,"Select where you would like the output.  This will be very large and you",!,"should select either a Host File Server (HFS) printer or Current Terminal",!,"(screen capture) to save the output to a file."
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN="DQ^IBCROE",ZTDESC="IB Reasonable Charges Extract"
 . S (ZTSAVE("IBZIP"),ZTSAVE("IBVERS"))=""
 . D ^%ZTLOAD D HOME^%ZIS K IO("Q") W !,"QUEUED TASK #",ZTSK
 ;
 ;
DQ ; tasked entry point
 U IO D EXCEL(IBZIP,IBVERS)
 ;
 ;
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 I '$D(ZTQUEUED) D HOME^%ZIS W !,"Done!"
 ;
 ;
 Q
 ;
SELVERS() ; get version to extract from user
 N DIR,DIRUT,DTOUT,DUOUT,X,Y,IB,IBV,IBVP,IBX,IBVL
 ; use primary site to list and remove prior to version 2.0 as choices
 S IBVL=$$VERSITE^IBCRHBRV($P($$SITE^VASITE,"^",3)),IBV=""
 F X=1:1 Q:'$P(IBVL,",",X)  S:$P(IBVL,",",X)>1.9 IBV=IBV_$S($L($P(IBVL,",",X))>2:$P(IBVL,",",X),1:$P(IBVL,",",X)_".0")_"^"
 S IBV=$E(IBV,1,$L(IBV)-1)
 S IBX=0
 W !!,"Select the version of Reasonable Charges to extract.",!
 S DIR("?")="Enter a code from the list corresponding to the version of Reasonable Charges to upload.  Must be version 2.0 or greater.  There was no version 2.2 of Reasonable Charges."
 S DIR(0)="SO^"
 F IB=1:1:$L(IBV,U) S IBVP=$P(IBV,U,IB),DIR(0)=DIR(0)_+IBVP_":RC version "_IBVP_" eff "_$$FMTE^XLFDT($$VERSDT^IBCRHBRV(+IBVP),"2Z")_" inact "_$$FMTE^XLFDT($$VERSEDT^IBCRHBRV(+IBVP),"2Z")_";"
 D ^DIR K DIR S:$L(Y)=1 Y=Y_".0" S IBX=+$S(IBV[Y:Y,1:0)
 Q IBX
 ;
 ;
 ; call at EXEL with zip and version, will print to host file the calculated charges by type
EXCEL(ZIP,VERS) ;
 N IB2,IB3,IBZ,COL,IBBI,IBBR,IBBR0,IBCHG,IBCI,IBCI0,IBCM,IBCNT,IBCPT,IBCS,IBCS0,IBCSNM,IBCT,IBDV,IBLNZ,IBMOD,IBMODI,IBNAME,IBPB,IBRG,IBRG0,Z
 K ^TMP("IBCROE",$J)
 S IBCNT=0
 ;
 S IBCS=0 F  S IBCS=$O(^IBE(363.1,IBCS)) Q:'IBCS  D
 . S IBCS0=$G(^IBE(363.1,IBCS,0))
 . ;
 . S IBCSNM=$P(IBCS0,U,1) Q:$E(IBCSNM,1,3)'="RC-"
 . S IBBR=+$P(IBCS0,U,2),IBBR0=$G(^IBE(363.3,IBBR,0))
 . S IBRG=+$P(IBCS0,U,7),IBRG0=$G(^IBE(363.31,IBRG,0)),IBDV=$P(IBRG0," ",2)
 . ;
 . I $P(IBRG0,U,2)'=ZIP Q
 . ;
 . S IBBI=$$EXPAND^IBCRU1(363.3,.04,$P(IBBR0,U,4))
 . S IBCT=$S(IBBR0["FACILITY":"FACILITY",IBBR0["PHYSICIAN":"PHYSICIAN",1:$P(IBBR0,U,1))
 . ;
 . I IBBI["MISC",IBCSNM'["SNF" S COL=2,IBNAME="Partial Hospitalization"
 . I IBBI["MISC",IBCSNM["SKILLED" S COL=1,IBNAME="Skilled Nursing"
 . I IBBI="DRG",IBCSNM["ANC" S COL=1,IBNAME="Inpatient Anc" I IBCSNM["ICU" S COL=COL+1,IBNAME=IBNAME_" ICU"
 . I IBBI="DRG",IBCSNM["R&B" S COL=3,IBNAME="Inpatient R&B" I IBCSNM["ICU" S COL=COL+1,IBNAME=IBNAME_" ICU"
 . ;
 . I IBBI="CPT",IBCSNM["INPT" S COL=1,IBNAME="Inpatient Facility" I IBCT="PHYSICIAN" S COL=COL+1,IBNAME="Inpatient Physician"
 . I IBBI="CPT",IBCSNM["SNF" S COL=3,IBNAME="SNF Facility" I IBCT="PHYSICIAN" S COL=COL+1,IBNAME="SNF Physician"
 . I IBBI="CPT",IBCSNM["OPT" S COL=5,IBNAME="Outpatient Facility" I IBCT="PHYSICIAN" S COL=COL+1,IBNAME="Outpatient Physician"
 . I IBBI="CPT",IBCSNM["FS" S COL=7,IBNAME="Freestanding Physician"
 . ;
 . S IBPB=$P(IBRG0,U,3),IBPB=$S(IBPB=1:"VAMC Provider Based",IBPB=2:"Opt Provider Based",IBPB=3:"Non-Provider Based",1:"Provider Based Unknown")
 . ;
 . S IBCM=$P(IBBR0,U,5),IBCM=$S(IBCM=4:"ml",IBCM=5:"mn+",IBCM=6:"hr+",1:"")
 . ;
 . S IB2(IBCS)=IBBI_U_COL_U_IBNAME_U_IBDV_U_IBPB_U_IBCM
 . S $P(IB3(IBBI),U,COL)=IBNAME_" "_IBDV_" "_IBPB
 . ;
 . S IBCNT=IBCNT+1 I IBCNT#1000=0,'$D(ZTQUEUED) U IO(0) W "." U IO
 ;
ITEMS ;
 S IBBI="" F  S IBBI=$O(IB3(IBBI)) Q:IBBI=""  S ^TMP("IBCROE",$J,IBBI)="Item^Modifier^"_IB3(IBBI)
 ;
 S IBCI=0 F  S IBCI=$O(^IBA(363.2,IBCI)) Q:'IBCI  D
 . S IBCI0=^IBA(363.2,IBCI,0),IBCSNM=$P($G(^IBE(363.1,+$P(IBCI0,U,2),0)),U,1) Q:IBCSNM=""
 . S IBLNZ=$G(IB2($P(IBCI0,U,2))) I IBLNZ="" S IBZ("NOT DONE ",IBCSNM)="" Q
 . S IBZ("DONE",IBCSNM)=""
 . ;
 . Q:$P(IBCI0,U,3)'=$$VERSDT^IBCRHBRV(VERS)
 . ;
 . S IBCHG=$P(IBCI0,U,5)_$P(IBLNZ,U,6)_$P(IBCI0,U,8)
 . S IBMOD=$P(IBCI0,U,7) I IBMOD'="" S IBMOD=$P($$MOD^ICPTMOD(IBMOD,"I"),U,2)
 . I IBMOD="" S IBMOD=0
 . S IBCPT=$$EXPAND^IBCRU1(363.2,.01,$P(IBCI0,U,1))
 . ;
 . S IBBI=$P(IBLNZ,U,1)
 . S COL=$P(IBLNZ,U,2)
 . I $P($G(^TMP("IBCROE",$J,IBBI,IBCPT,IBMOD)),U,COL)'="" Q  ;DUP
 . S $P(^TMP("IBCROE",$J,IBBI,IBCPT,IBMOD),U,COL)=IBCHG
 . ;
 . S IBCNT=IBCNT+1 I IBCNT#1000=0,'$D(ZTQUEUED) U IO(0) W "." U IO
 ;
 ;
 D WRT
 K ^TMP("IBCROE",$J)
 Q
WRT ;
 S IBBI="" F  S IBBI=$O(^TMP("IBCROE",$J,IBBI)) Q:IBBI=""  D
 . W !,^TMP("IBCROE",$J,IBBI)
 . S IBCPT="" F  S IBCPT=$O(^TMP("IBCROE",$J,IBBI,IBCPT)) Q:IBCPT=""  D
 .. S IBMOD="" F  S IBMOD=$O(^TMP("IBCROE",$J,IBBI,IBCPT,IBMOD)) Q:IBMOD=""  D
 ... S IBMODI=IBMOD I IBMOD=0 S IBMODI=""
 ... W !,IBCPT,U,IBMODI,U,^TMP("IBCROE",$J,IBBI,IBCPT,IBMOD)
 ... S IBCNT=IBCNT+1 I IBCNT#1000=0,'$D(ZTQUEUED),$E(IOST,1,2)'="C-" U IO(0) W "." U IO
 Q
