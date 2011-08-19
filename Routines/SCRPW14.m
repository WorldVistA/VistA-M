SCRPW14 ;RENO/KEITH - Encounter Activity Report ;06/10/99
 ;;5.3;Scheduling;**139,144,180**;AUG 13, 1993
 ;06/10/99 ACS Added cpt modifiers to the report
 ;
 N DIC,DIR,DTOUT,DUOUT,X,Y,SD,ZTSAVE,%DT,SDDIV,SDI
 D TITL^SCRPW50("Encounter Activity Report") G:'$$DIVA^SCRPW17(.SDDIV) EXIT
 D SUBT^SCRPW50("*** Date Range Selection ***")
FDT W ! S %DT="AEPX",%DT("A")="Beginning date: ",%DT(0)="-TODAY" D ^%DT G:X=U!$D(DTOUT)!(X="") EXIT
 G:Y<1 FDT S SD("BDT")=Y X ^DD("DD") S SD("PBDT")=Y W !
LDT S %DT("A")="Ending date: " D ^%DT G:X=U!$D(DTOUT)!(X="") EXIT
 I Y<SD("BDT") W !!,$C(7),"Ending date must be after beginning date!",! G LDT
 G:Y<1 LDT S SD("EDT")=Y X ^DD("DD") S SD("PEDT")=Y,SD("EDT")=SD("EDT")_".999999"
CATE D SUBT^SCRPW50("*** Report Category Selection ***")
 W ! S DIR(0)="S^C:CLINIC;P:PROVIDER;S:STOP CODE",DIR("A")="Select category for report output" D ^DIR G:$D(DTOUT)!$D(DUOUT) EXIT S SD("CAT")=Y D STAT G:'$D(SD("STAT")) EXIT
 D SUBT^SCRPW50("*** Report Format Selection ***")
 W ! S DIR(0)="S^D:DETAILED;S:SUMMARY",DIR("A")="Select report format",DIR("B")="SUMMARY" D ^DIR G:$D(DTOUT)!$D(DUOUT) EXIT S SD("FMT")=Y
 I SD("FMT")="S" W ! S DIR(0)="S^A:ALPHABETIC;E:ENCOUNTER TOTALS;V:VISIT TOTALS;U:UNIQUE TOTALS",DIR("A")="Select report order",DIR("B")="ALPHABETIC" D ^DIR G:$D(DTOUT)!$D(DUOUT) EXIT S SD("ORD")=Y G QUE
 S SD("ORD")="A" D LIST(SD("CAT")) G:'$D(SD("LIST")) EXIT
QUE D SUBT^SCRPW50("*** Selected Report Parameters ***")
 W !!,"You have selected the following report parameters:",! D PVIEW^SCRPW15(0)
 W ! K DIR S DIR(0)="Y",DIR("A")="OK",DIR("B")="YES" D ^DIR G:$D(DTOUT)!$D(DUOUT) EXIT G:'Y EXIT
 F SDI="SDDIV","SDDIV(","SD(","SDL(" S ZTSAVE(SDI)=""
 W ! D EN^XUTMDEVQ("RPT^SCRPW14","OPT. ACTIVITY REPORT",.ZTSAVE)
 ;
EXIT D END^SCRPW50 Q
 ;
STAT ;Prompt for encounter statuses to include
 D SUBT^SCRPW50("*** Encounter Status Selection ***")
 K SD("STAT") W !!,"Choose as many of the following statuses",!,"as you wish to include in the report:",!
 W !?10,"CHECKED IN",!?10,"CHECKED OUT",!?10,"NO ACTION TAKEN",!?10,"INPATIENT APPOINTMENT",!?10,"NON-COUNT",!?10,"ACTION REQUIRED",! N DIC,I S DIC="^SD(409.63,",DIC(0)="AEMQ",DIC("B")="CHECKED OUT"
 S DIC("S")="I Y<4!(Y=8!(Y=12!(Y=14)))",DIC("A")="Select encounter status: " F I=1:1 D ^DIC Q:$D(DTOUT)!$D(DUOUT)  S:Y>0 SD("STAT",$P(Y,U))="" K DIC("B") Q:X=""&(I>1)
 Q
 ;
LIST(X) ;Get list for detail
 ;Output: SD("LIST",ifn)=name
 W ! N DIC S DIC=$S(X="C":"^SC(",X="P":"^VA(200,",1:"^DIC(40.7,"),DIC(0)="AEMQ" S:X="S" DIC("S")="I $L($P(^(0),U,2))=3"
 F  D ^DIC Q:$D(DTOUT)!$D(DUOUT)!(X="")  S:Y>0 SD("LIST",$P(Y,U))=$P(Y,U,2)
 W ! Q
 ;
RPT ;Print report
 N %,X,Y,SDQ,SDTIT,SDI,DFN,SDIVN,SDMD,SDOUT,SDSTOP,SDX
 N SDCH,SDCH0,SDCL,SDCOL,SDD,SDD0,SDDET,SDDT,SDFFS,SDLINE,SDN,SDOE,SDOE0,SDOED,SDOED0,SDP,SDPI,SDP0,SDPAGE,SDPG,SDPNOW,SDPR,SDPT,SDR,SDS,SDSC,SDSV,SDT,SDT1,SDT2,SDTOT,SDTOT1,SDTOT2,SDUN,SDVP,SDVP0,SDVS,SDLIST,SDRPVS,SDRPUN,SDRPEN
 K ^TMP("SCRPW",$J) S (SDOUT,SDSTOP)=0,SDMD=$O(SDDIV("")),SDMD=$O(SDDIV(SDMD)) S:$P(SDDIV,U,2)="ALL DIVISIONS" SDMD=1
 S SDDT=SD("BDT") F  S SDDT=$O(^SCE("B",SDDT)) Q:'SDDT!(SDDT>SD("EDT"))!SDOUT  S SDOE=0 F  S SDOE=$O(^SCE("B",SDDT,SDOE)) Q:'SDOE!SDOUT  S SDOE0=$$GETOE^SDOE(SDOE) I $L(SDOE0) S SDIV=$P(SDOE0,U,11) D:SDIV EVAL
 G:SDOUT EXIT G ^SCRPW15
 ;
STOP ;Check for stop task request
 S:$G(ZTQUEUED) (SDOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
 ;
EVAL ;Evaluate encounter
 S SDSTOP=SDSTOP+1 I SDSTOP#3000=0 D STOP Q:SDOUT
 I '$P(SDOE0,U,6),$$DIV(SDIV),$D(SD("STAT",+$P(SDOE0,U,12))) K SDS I $$CAT(.SDS) D SRT(SDIV) D:SDMD SRT(0) S SDS=0 F  S SDS=$O(SDS(SDS)) Q:'SDS  D SET
 Q
 ;
DIV(SDIV) ;Evaluate division
 Q:'SDDIV 1  Q $D(SDDIV(SDIV))
 ;
SRT(SDIV) ;Set report total for summary format
 Q:SD("FMT")="D"  S SDRPEN(SDIV)=$G(SDRPEN(SDIV))+1,^TMP("SCRPW",$J,SDIV,"RPT","PT",+$P(SDOE0,U,2),+$P(SDDT,"."))="" Q
 ;
SET ;Set global for a division
 D SET1(SDIV) D:SDMD SET1(0) Q:SD("FMT")="S"
 K SDLIST D GETDX^SDOE(SDOE,"SDLIST")
 S SDOED=0 F  S SDOED=$O(SDLIST(SDOED)) Q:'SDOED  S SDOED0=SDLIST(SDOED) D:$L(SDOED0) DSET(SDIV) D:SDMD DSET(0)
 K SDLIST D GETCPT^SDOE(SDOE,"SDLIST")
 S SDVP=0 F  S SDVP=$O(SDLIST(SDVP)) Q:'SDVP  S SDVP0=SDLIST(SDVP) I $L(SDVP0) D PSET(SDIV) D:SDMD PSET(0)
 Q
 ;
SET1(SDIV) S ^TMP("SCRPW",$J,SDIV,1,SDS,"ENC")=$G(^TMP("SCRPW",$J,SDIV,1,SDS,"ENC"))+1,^TMP("SCRPW",$J,SDIV,1,SDS,"PT",+$P(SDOE0,U,2),+$P(SDDT,"."))=""
 Q
 ;
DSET(SDIV) S SDD=+$P(SDOED0,U),SDR=$S($P(SDOED0,U,12)="P":"PRI",1:"SEC"),^TMP("SCRPW",$J,SDIV,1,SDS,"DX",SDD,SDR)=$G(^TMP("SCRPW",$J,SDIV,1,SDS,"DX",SDD,SDR))+1 Q
 ;
PSET(SDIV) ;
 I SD("CAT")="P",'$$OLD^SDOEUT(SDOE) S SDPR=$P($G(^AUPNVCPT(SDVP,12)),U,4) Q:'$D(SD("LIST",+SDPR))
 ;S SDP=+$P(SDVP0,U),SDQ=$P(SDVP0,U,16) S:'SDQ SDQ=1 S ^TMP("SCRPW",$J,SDIV,1,SDS,"PROC",SDP)=$G(^TMP("SCRPW",$J,SDIV,1,SDS,"PROC",SDP))+SDQ Q
 ;SDP=procedure pointer, SDQ=procedure quantity
 S SDP=+$P(SDVP0,U)
 S SDQ=$P(SDVP0,U,16)
 S:'SDQ SDQ=1
 ; add quantity to total quantity for current procedure
 S ^TMP("SCRPW",$J,SDIV,1,SDS,"PROC",SDP)=$G(^TMP("SCRPW",$J,SDIV,1,SDS,"PROC",SDP))+SDQ
 ;
 ;Loop through modifiers and add to ^TMP array
 N SDMODN,SDMOD
 S SDMODN=0
 F  S SDMODN=+$O(SDLIST(SDVP,1,SDMODN)) Q:'SDMODN  D
 .S SDMOD=$P(SDLIST(SDVP,1,SDMODN,0),"^")
 .;add modifier quantity to array
 .S:SDMOD ^TMP("SCRPW",$J,SDIV,1,SDS,"PROC",SDP,SDMOD)=$G(^TMP("SCRPW",$J,SDIV,1,SDS,"PROC",SDP,SDMOD))+SDQ
 Q
 ;
CAT(SDS) ;Determine if encounter fits category
 ;Required input: SDS array to return list
 ;Output: SDS(ifn) array=list of category ifns to tally
 I SD("CAT")="C" S SDCL=$P(SDOE0,U,4) Q:SDCL<1 0  S:SD("FMT")="S"!$D(SD("LIST",+SDCL)) SDS(SDCL)="" Q $D(SDS)
 I SD("CAT")="P" D CATP Q $D(SDS)
 I SD("CAT")="S" D CATS Q $D(SDS)
 Q 0
 ;
CATP ;Get providers
 K SDLIST D GETPRV^SDOE(SDOE,"SDLIST")
 S SDPI=0 F  S SDPI=$O(SDLIST(SDPI))  Q:'SDPI  S SDP=$P(SDLIST(SDPI),U) S:SD("FMT")="S"!$D(SD("LIST",SDP)) SDS(SDP)=""
 Q
 ;
CATS ;Get stop codes
 S SDSC=+$P(SDOE0,U,3) S:SD("FMT")="S"!$D(SD("LIST",SDSC)) SDS(SDSC)=""
 S SDCH=0 F  S SDCH=$O(^SCE("APAR",SDOE,SDCH)) Q:'SDCH  S SDCH0=$$GETOE^SDOE(SDCH) I $P(SDCH0,U,8)=4 S SDSC=+$P(SDCH0,U,3) S:SD("FMT")="S"!$D(SD("LIST",SDSC)) SDS(SDSC)=""
 Q
