XQ ; SEA/MJM - Menu driver (Part 1) ;Dec 13, 2018@10:05
 ;;8.0;KERNEL;**9,46,94,103,157,570,593,614,OSE/SMH**;Jul 10, 1995;Build 11
 ; Original Routine authored by US Department of Veteans Affairs and in Public Domain
 ; OSE/SMH changes to support VistA Intenationalization
 ; OSE/SMH modificiations (c) Sam Habiel 2018
 ; Look for OSE/SMH for specific modifications
 ; Licensed under Apache 2.0
 D LOGRSRC^%ZOSV("$XQ MENU DRIVER$",0,1)
 D INIT^XQ12 Q:'$D(XQY)
 I $D(XQUR),$E(XQUR,1,2)="^^" S XQRB=1,XQJS=4
 I '$D(XQJS),$D(XQUR),XQUR'="",XQUR'["[" S:XQUR'[U XQUR=U_XQUR K ^VA(200,DUZ,202.1) S XQJS=0 D ^XQTOC
 I $D(XQUR),XQUR["[" K ^VA(200,DUZ,202.1) S XQJS=3,^XUTL("XQ",$J,"T")=1
 I $D(^VA(200,DUZ,202.1)),$L($P(^(202.1),U)) S XQJS=1 S %=+^(202.1) S XQUR=$G(^DIC(19,%,"U")) I XQUR]"" D ^XQTOC
M I '$D(XQVOL) S XQVOL=$G(^XUTL("XQ",$J,"XQVOL")) I '$L(XQVOL) D GETENV^%ZOSV S XQVOL=$P(Y,U,2)
 I $G(^%ZIS(14.5,"LOGON",XQVOL)) S XQNOLOG="" G H^XUS
 S:$S('$D(XQY0):1,'$L(XQY0):1,1:0) XQY0=^DIC(19,XQY,0) S XQT=$P(XQY0,U,4) G:XQT="" M3 K:'$D(XQJS) XQUR K X,XQNOGO,XQR,XQUIT,XQUEFLG ;,XQSV
 I $D(XQAUDIT),XQAUDIT D LOGOPT^XQ12
 I $G(XQY)>0 D CHKQUE^XQ92 I XQUEFLG S XQNOGO=""
 ;
 ;Execute the Entry Action and look for XQUIT
 D:'$D(XQM3)&("LOQX"'[XQT) LO K XQM3 I $D(XQUIT) D
 .S XQUIT=0
 .D ^XQUIT
 .Q
 ;
 G:$D(XQUR) ASK1 ;Jump start or continue
 I '$D(XQUIT),XQT'="A",$P(XQY0,U,17),$D(^DIC(19,XQY,26)),$L(^(26)) X ^(26)
 D:$D(XQXFLG)[0 ABT^XQ12
 D:$P(XQY0,U)]"" LOGRSRC^%ZOSV($P(XQY0,U),0,1)
 I XQT'="M" W:'^XUTL("XQ",$J,"T") !,$P(XQY0,U,2) W:$D(DUZ("SAV")) !,"Not when testing another's menus." S %=^XUTL("XQ",$J,"T"),^("T")=%+1,^(%+1)=XQY_XQPSM_U_XQY0 G M3:XQT'?1U!$D(DUZ("SAV"))
 I XQT'="M" D:'$D(XQXFLG) ABT^XQ12 D:+XQXFLG ABLOG^XQ12 K %,X,XQTT G @(XQT_"^XQ1")
M1 ;
 D LOGRSRC^%ZOSV("$XQ MENU DRIVER$",0,1)
 Q:XQY<1!'$D(^XUTL("XQ",$J,"T"))  D:'$D(XQXFLG) ABT^XQ12
 ; OSE/SMH - L10N BEGIN CHANGES - NEXT TWO LINES OLD LINES - LINES DON'T TRANSLATE BY JUST CONCATENATION - ORDER IS WRONG
 ;D:'$D(XQABOLD)&(+XQXFLG) ABLOG^XQ12 K XQABOLD W ! S XQUR=0,XQTT=^XUTL("XQ",$J,"T"),XQDIC=XQY S XQAA="Select "_$S($D(DUZ("SAV")):$P(DUZ("SAV"),U,3)_"'s ",1:"")_$P(XQY0,U,2)
 ;S XQAA=XQAA_$G(DUZ("TEST"))_" Option: " S:$D(XQMM("B")) XQAA=XQAA_XQMM("B")_"//"
 D:'$D(XQABOLD)&(+XQXFLG) ABLOG^XQ12 K XQABOLD W ! S XQUR=0,XQTT=^XUTL("XQ",$J,"T"),XQDIC=XQY
 I $D(DUZ("SAV")) D  ; OSE/SMH - DIALOG: |1| Select |2|'s |3| Option"
 . N XQDLG
 . S XQDLG(1)=$G(DUZ("TEST"))
 . S XQDLG(2)=$P(DUZ("SAV"),U,3)
 . S XQDLG(3)=$P(XQY0,U,2)
 . S XQAA=$$EZBLD^DIALOG(19001,.XQDLG)
 E  D  ; OSE/SMH - DIALOG: |1| Select |2| Option"
 . N XQDLG
 . S XQDLG(1)=$G(DUZ("TEST"))
 . S XQDLG(2)=$P(XQY0,U,2)
 . S XQAA=$$EZBLD^DIALOG(19002,.XQDLG)
 S XQAA=$$TRIM^XLFSTR(XQAA,"L")_" "
 S:$D(XQMM("B")) XQAA=XQAA_XQMM("B")_"//"
 ; /OSE/SMH - L10N END CHANGES
 S:$S('XQTT:1,1:+$P(^XUTL("XQ",$J,XQTT),U,1)'=XQY) ^("T")=XQTT+1,^(XQTT+1)=XQY_XQPSM_U_XQY0 I $D(DUZ("AUTO")),DUZ("AUTO"),'$D(XQMM("J")),'$D(XQMM("N")) G EN^XQ2
 K:'$D(XQMM("J")) XQMM("N")
M2 ;
 I '$D(XQMMF),$D(XQMM("J")) G ^XQ74
 Q:$D(XQALEXIT)&'$D(XQALMENU)  K XQMMF I $D(XQMM("A")) S XQAA=XQMM("A") K XQMM("A") I $D(XQMM("B")),$L(XQMM("B")) S XQAA=XQAA_XQMM("B")_"//"
 D DISPLAY^XQALERT,CHK^XM
 S:'$D(DTIME) DTIME=60
 ;
ASK ;Get user's response in XQUR
 W !,XQAA R XQUR:DTIME I '$T Q:$D(XQALEXIT)  W $C(7),"  Timed out...." G CON^XQTOC
 I $D(XQALEXIT),XQUR=""!(XQUR["^") Q
 ;
ASK1 D SETSV ;Set XQSV to remember where we started from (XQY^XQDIC^XQY0)
 K XQUIT
 I XQUR="*",$D(DUZ("SAV")) G TESTN^XUS91
 I $D(XQJS),XQJS,XQJS'>2 D SET^XQTOC G JUMP^XQ72 ;Continue, 3=[LOGIN
 I XQUR["[" G:'$D(DUZ("SAV")) ^XQT W !,"Not when testing another's menus!" S %=^XUTL("XQ",$J,"T")+1,^("T")=%,^(%)=XQY_XQPSM_U_XQY0 G M3
 I XQUR="" S:$D(XQMM("B")) XQUR=XQMM("B") K XQMM("B") G:$L(XQUR) D S XQABOLD=1 G M3:^XUTL("XQ",$J,"T")>1,XPRMP^XQ12
 I XQUR=U G M3
 I $E(XQUR)=$C(34),$L(XQUR)>1 S XQUR=$P(XQUR,$C(34),2) D P^XQ75 G:XQY'>0 NOFIND K XQAA S XQY=+XQY,XQCH=XQUR G JUMP^XQ72
D I XQUR["^^" G:XQUR="^^" R^XQ73 S XQRB=1 S XQUR=$P(XQUR,U,2,99)
 ;"^^" is GO HOME, return to the Primary Menu, "^^x" is a rubber band
 I XQUR[U S XQUR=$P(XQUR,U,2) G:'$L(XQUR) NOFIND D S^XQ75 G D:'XQY,NOFIND:XQY<0 K XQAA S XQY=+XQY,XQCH=XQUR G:$D(XQRB) ^XQ73 G JUMP^XQ72
D0 G:XQUR'?1"?"1AN.ANP D1 D OPT^XQHLP G ASK
D1 G EN^XQ2:XQUR?."?"!(XQUR'?.ANP) D DIC^XQ71 G:'XQY D S:XQY>0 XQPSM=$S(XQPSM=("U"_DUZ):XQPSM_",P"_XQDIC,XQPSM[",":XQPSM,XQDIC>0:XQPSM,1:"P"_XQDIC)
 I XQY=-1,$O(^VA(200,DUZ,203,0))>0 S XQDIC="U"_DUZ D DIC^XQ71 G:'XQY D S:XQY>0 XQPSM="U"_DUZ_",P"_XQY
M0 I XQY=-1 S XQDIC=$O(^DIC(19,"B","XUCOMMAND",0)) S:XQDIC="" XQDIC=-1 D DIC^XQ71 G:'XQY D S:XQY>0 XQPSM="PXU" I XQY=-1 G M3:XQUR="HALT",NOFIND
 G:XQY=-2 NOFIND K XQAA S XQY=+XQY,XQCH=XQUR G M
 ;
NOFIND ;Could not find the option requested, go back and try again
 W:XQY=-1 "  ??" S %=^XUTL("XQ",$J,^XUTL("XQ",$J,"T")),XQY0=$P(%,U,2,999),XQY=+$P(%,U,1) K XQJS,XQR G M1
 ;
M3 I $P(XQY0,U,15),$D(^DIC(19,+XQY,15)),$L(^(15)) X ^(15) ;W "  ==> XQ+47"
 S %=^XUTL("XQ",$J,"T")-1,^("T")=% G H^XUS:(%'>0) S %=^XUTL("XQ",$J,%),XQY0=$P(%,U,2,999),XQPSM=$P(%,U,1),XQY=+XQPSM,XQPSM=$P(XQPSM,XQY,2,99),XQM3="" I +XQY<0 D RBX^XQ73
 G M
 ;
LO I $P(XQY0,U,4)'="A",$P(XQY0,U,14),$D(^DIC(19,+XQY,20)),$L(^(20)) X ^(20) ;W " ==> LO^XQ"
 Q
 ;
SETSV ;Record where we are now for posterity in XQSV
 ; ZEXCEPT: XQSV,XQY  - global variables recording current VistA menu
 N %
 S %=^XUTL("XQ",$J,^XUTL("XQ",$J,"T"))
 S XQSV=""
 S $P(XQSV,U)=+%
 S $P(XQSV,U,2)=$S($P(%,U)["PXU":$O(^DIC(19,"B","XUCOMMAND",0)),1:$P($P(%,U),"P",2)) I $P(XQSV,U,2)="" S $P(XQSV,U,2)=XQY
 S $P(XQSV,U,3)=$P(%,U,2,99)
 Q
 ;
PRIO ;This subroutine is no longer used.  Kernel no longer resets priority.
 ;S Y=10 X:$D(^%ZOSF("PRIINQ")) ^("PRIINQ") S ^XUTL("XQ",$J,"P")=Y,X=$P(XQY0,U,8) X ^%ZOSF("PRIORITY")
 Q
