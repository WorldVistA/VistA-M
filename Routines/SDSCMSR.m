SDSCMSR ;ALB/JAM/RBS - ASCD Managers Summary Data Report ; 3/5/07 11:44am
 ;;5.3;Scheduling;**495**;Aug 13, 1993;Build 50
 ;;MODIFIED FOR NATIONAL RELEASE from a Class III software product
 ;;known as Service Connected Automated Monitoring (SCAM).
 ;
 ;**Program Description**
 ;  This report is to be used by managers only
 Q
EN ;  Entry Point
 N ZTQUEUED,POP,ZTRTN,ZTDTH,ZTDESC,ZTSAVE,SDSCDVSL,SDSCDVLN,WHO,DIR,X,Y
 N SDSCBDT
 K ^TMP("SDSCMGR",$J)
 ; Get Divisions
 D DIV^SDSCUTL
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) G EXIT
 S SDSCDVSL=Y,SDSCDVLN=SCLN
 ;  Get start and end date for report
 S (SDSCBDT,SDSCEDT)=""
 S SDSCBDT=$O(^SCE("B",""))\1,SDSCEDT=DT
 D GETDATE1^SDSCOMP I SDSCTDT="" G EXIT
 K DIR,X,Y
 S DIR(0)="S^A:All Encounters;C:Compiled ASCD Encounters Only"
 S DIR("A")="Select to check ",DIR("B")="Compiled ASCD Encounters Only"
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) G EXIT
 S WHO=Y
 K %ZIS,IOP,IOC,ZTIO S %ZIS="MQ" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="BEG^SDSCMSR",ZTDTH=$H,ZTDESC="ASCD Manager Summary Report"
 . S ZTSAVE("WHO")="",ZTSAVE("SDSCBDT")="",ZTSAVE("SDSCEDT")="",ZTSAVE("SDSCDVSL")=""
 . S ZTSAVE("SDSCDVLN")="",ZTSAVE("SDEDT")="",ZTSAVE("SDSCTDT")=""
 . K IO("Q") D ^%ZTLOAD W !,"REQUEST QUEUED"
 ;
BEG ; Begin report
 N DTOTAL,DATOTAL,CT,P,L,SDABRT,AJ,DTOT,SDSCDIV,SDSCDNM,THDR,AI
 S (DTOTAL,DATOTAL,CT)=0
 S (P,L,SDABRT)=0
 F AJ="VBA","NO CHANGE","SCNSC","NSCSC","REV","NOT","NPROC" S DTOT(AJ)=0
 S SDSCDIV=$S(SDSCDVSL'[SDSCDVLN:SDSCDVSL,1:"")
 I SDSCDIV="" S SDSCDNM="ALL" D BLD G EXT
 I SDSCDIV'="" D
 . S THDR=""
 . F AI=1:1:$L(SDSCDVSL,",") S SDSCDIV=$P(SDSCDVSL,",",AI) Q:SDSCDIV=""  D  Q:$G(SDABRT)=1
 .. S SDSCDNM=$P(^DG(40.8,SDSCDIV,0),"^",1),THDR=THDR_SDSCDNM_",",CT=CT+1 D BLD
 G EXT
 ;
BLD ;
 N SDOEDT,ATOTAL,ENC,SDOE0,TOTAL,EDIV,SDEFLG,SI,SUBTOT,SDNWPV,DIV
 N SBTOT,SDOE,SDSCDATA,SCVAL
 I WHO="A" S SDOEDT=SDSCTDT,ATOTAL=0 D
 . I '$D(ZTQUEUED) D EN^DDIOL("Please wait while I count encounters")
 . F  S SDOEDT=$O(^SCE("B",SDOEDT)) Q:SDOEDT\1>SDEDT!(SDOEDT="")  D
 .. S ENC="" F  S ENC=$O(^SCE("B",SDOEDT,ENC)) Q:ENC=""  D
 ... S SDOE0=$$GETOE^SDOE(ENC,0)
 ... I SDSCDIV'="" Q:$P(SDOE0,U,11)'=SDSCDIV
 ... I $P(SDOE0,U,12)=2 S ATOTAL=ATOTAL+1 I '$D(ZTQUEUED) W:ATOTAL#100=0 "."
 ;
FND ;
 S SDOEDT=SDSCTDT,TOTAL=0
 F  S SDOEDT=$O(^SDSC(409.48,"AE",SDOEDT)) Q:SDOEDT\1>SDEDT!(SDOEDT="")  D
 . S SDOE=""
 . F  S SDOE=$O(^SDSC(409.48,"AE",SDOEDT,SDOE)) Q:SDOE=""  D
 .. I SDSCDIV'="" Q:$P(^SDSC(409.48,SDOE,0),U,12)'=SDSCDIV
 .. S EDIV=$P(^SDSC(409.48,SDOE,0),U,12),TOTAL=TOTAL+1
 .. ; if division is null, check for value
 .. I EDIV="" D
 ... S EDIV=$P($G(^SCE(SDOE,0)),U,11)
 ... I EDIV="" S EDIV="~" Q
 ... D UPD(SDOE,.12,EDIV,"I")
 .. ;  Check for not editable
 .. S SDEFLG=0 D CHECK^SDSCEDT
 .. I 'SDEFLG D STORE("NOT") W "!X" Q
 .. S SDSCDATA=$G(^SDSC(409.48,SDOE,0)) I SDSCDATA="" Q
 .. I +$P(SDSCDATA,U,9),+$P(SDSCDATA,U,6) D STORE("VBA") Q
 .. I $P(SDSCDATA,U,5)="R" D STORE("REV") Q
 .. I $P(SDSCDATA,U,5)="C" S SCVAL=$$SCHNG^SDSCUTL(SDOE) D:SCVAL'=""
 ...I '+SCVAL D STORE("NO CHANGE") Q
 ...I $P(SCVAL,"^",2) D STORE("SCNSC") Q
 ...D STORE("NSCSC")
 ;
PRT ;  Print report
 S SUBTOT=0
 S SDHDR="Managers Summary Data Report"
 U IO D STDHDR^SDSCRPT2 Q:$G(SDABRT)=1
 S SDNWPV=1
 W SDHDR,?67,"PAGE: ",P
 W !,?5,"For Encounters Dated ",$$FMTE^XLFDT(SDSCTDT,2)," THRU ",$$FMTE^XLFDT(SDEDT,2)," For Division: ",SDSCDNM,!!
 W ! F I=1:1:79 W "-"
 ;
 I WHO="A" W !,"All Checked Out Encounters: ",?52,$J(ATOTAL,10) S DATOTAL=DATOTAL+ATOTAL
 W !,"ASCD Encounters that are potentially billable:  ",?55,$J(TOTAL,7) S DTOTAL=DTOTAL+TOTAL
 W !,?55,$J("-------",7)
 S SBTOT=0,DIV="" F  S DIV=$O(^TMP("SDSCMGR",$J,"VBA",DIV)) Q:DIV=""  D
 . S SBTOT=SBTOT+^TMP("SDSCMGR",$J,"VBA",DIV)
 W !,"Encounters verified with Rated Disability Codes: ",?55,$J(SBTOT,7) S SUBTOT=SUBTOT+SBTOT,DTOT("VBA")=DTOT("VBA")+SBTOT
 S SBTOT=0,DIV="" F  S DIV=$O(^TMP("SDSCMGR",$J,"NO CHANGE",DIV)) Q:DIV=""  D
 . S SBTOT=SBTOT+^TMP("SDSCMGR",$J,"NO CHANGE",DIV)
 W !,"Encounters where SC NOT changed:  ",?55,$J(SBTOT,7) S SUBTOT=SUBTOT+SBTOT,DTOT("NO CHANGE")=DTOT("NO CHANGE")+SBTOT
 S SBTOT=0,DIV="" F  S DIV=$O(^TMP("SDSCMGR",$J,"SCNSC",DIV)) Q:DIV=""  D
 . S SBTOT=SBTOT+^TMP("SDSCMGR",$J,"SCNSC",DIV)
 W !,"Encounters where SC was changed to NSC:  ",?55,$J(SBTOT,7) S SUBTOT=SUBTOT+SBTOT,DTOT("SCNSC")=DTOT("SCNSC")+SBTOT
 S SBTOT=0,DIV="" F  S DIV=$O(^TMP("SDSCMGR",$J,"NSCSC",DIV)) Q:DIV=""  D
 . S SBTOT=SBTOT+^TMP("SDSCMGR",$J,"NSCSC",DIV)
 W !,"Encounters where NSC was changed to SC:  ",?55,$J(SBTOT,7) S SUBTOT=SUBTOT+SBTOT,DTOT("NSCSC")=DTOT("NSCSC")+SBTOT
 S SBTOT=0,DIV="" F  S DIV=$O(^TMP("SDSCMGR",$J,"REV",DIV)) Q:DIV=""  D
 . S SBTOT=SBTOT+^TMP("SDSCMGR",$J,"REV",DIV)
 W !,"Encounters sent to Clinical Review:  ",?55,$J(SBTOT,7) S SUBTOT=SUBTOT+SBTOT,DTOT("REV")=DTOT("REV")+SBTOT
 S SBTOT=0,DIV="" F  S DIV=$O(^TMP("SDSCMGR",$J,"NOT",DIV)) Q:DIV=""  D
 . S SBTOT=SBTOT+^TMP("SDSCMGR",$J,"NOT",DIV)
 W !,"Encounters not editable:  ",?55,$J(SBTOT,7) S SUBTOT=SUBTOT+SBTOT,DTOT("NOT")=DTOT("NOT")+SBTOT
 W !,"Encounters not yet processed:  ",?55,$J(TOTAL-SUBTOT,7) S DTOT("NPROC")=DTOT("NPROC")+(TOTAL-SUBTOT)
 W !!!
 K ^TMP("SDSCMGR",$J)
 Q
 ;
UPD(SDENC,SDFLD,SDVAL,SDFLG) ; Update record
 N SDPD
 S SDPD(409.48,SDENC_",",SDFLD)=SDVAL
 D FILE^DIE(SDFLG,"SDPD","ERROR")
 Q
EXT ;
 I CT>1,$G(SDABRT)'=1 D PRTT
 D RPTEND^SDSCRPT1
 ;
EXIT ;
 K SDTYPE,SDSCTDT,SDEDT,SDSCEDT,SCLN,DIRUT,DTOUT,DUOUT,SDHDR
 K SDSCMSG,SDFLG,SDOEDAT,SDOSC,SDPAT,SDSCPKG,SDSCSRC,SDV0
 Q
STORE(VAL) ; Total up and Store
 S ^TMP("SDSCMGR",$J,VAL,EDIV)=$G(^TMP("SDSCMGR",$J,VAL,EDIV))+1
 S ^TMP("SDSCMGR",$J,VAL,EDIV,SDOE)=""
 K VAL
 Q
 ;
PRTT ; Print total page
 N HHDR,HHDR1,HHDR2,HHDR3,HHDR4,I
 U IO D STDHDR^SDSCRPT2 Q:$G(SDABRT)=1
 I $E(THDR,$L(THDR))="," S THDR=$E(THDR,1,$L(THDR)-1)
 W SDHDR,?67,"PAGE: ",P
 S HHDR1="For Encounters Dated "_$$FMTE^XLFDT(SDSCTDT,2)_" THRU "_$$FMTE^XLFDT(SDEDT,2)_" TOTAL for "
 S HHDR2=THDR
 I $L(HHDR1)+$L(HHDR2)>IOM D
 . S HHDR3=$P(HHDR2,",",1),HHDR4=$P(HHDR2,",",2,99)
 . S HHDR=HHDR1_HHDR3
 . I HHDR4'="" S HHDR=HHDR_","
 I $L(HHDR1)+$L(HHDR2)'>IOM D
 . S HHDR=HHDR1_HHDR2
 W !,HHDR
 I $G(HHDR4)'="" W !,?5,HHDR4
 W ! F I=1:1:79 W "-"
 ;
 I WHO="A" W !,"All Checked Out Encounters: ",?52,$J(DATOTAL,10)
 W !,"ASCD Encounters w/ SC='Yes' & potentially billable:  ",?55,$J(DTOTAL,7)
 W !,?55,$J("-------",7)
 W !,"Encounters verified with Rated Disability Codes: ",?55,$J(DTOT("VBA"),7)
 W !,"Encounters where SC NOT changed:  ",?55,$J(DTOT("NO CHANGE"),7)
 W !,"Encounters where SC was changed to NSC:  ",?55,$J(DTOT("SCNSC"),7)
 W !,"Encounters where NSC was changed to SC:  ",?55,$J(DTOT("NSCSC"),7)
 W !,"Encounters sent to Clinical Review:  ",?55,$J(DTOT("REV"),7)
 W !,"Encounters not editable:  ",?55,$J(DTOT("NOT"),7)
 W !,"Encounters not yet processed:  ",?55,$J(DTOT("NPROC"),7)
 W !!!
 Q
