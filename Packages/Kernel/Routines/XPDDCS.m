XPDDCS ;SFISC/RSD - Display Checksum for a package ;05/05/2008
 ;;8.0;KERNEL;**2,44,108,202,393,511,547**;Jul 10, 1995;Build 15
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
EN1 ;Verify checksums in Transport Global
 N D0,DIC,X,XPD,XPDS,XPDSHW,XPDST,XPDT,Y,Z
 ;S DIC="^XPD(9.7,",DIC(0)="AEQMZ",DIC("S")="I $D(^XTMP(""XPDI"",Y))"
 ;D ^DIC Q:Y<0
 S XPDS="I $D(^XTMP(""XPDI"",Y))"
 S XPDST=$$LOOK^XPDI1(XPDS) Q:XPDST'>0
 S XPDSHW=$$ASK Q:$D(DIRUT)
 S XPD("XPDT(")="",XPD("XPDST")="",XPD("XPDSHW")="",X="XUTMDEVQ"
 ;during Virgin install, XUTMDEVQ might not exists
 X ^%ZOSF("TEST") E  D  Q
 .S IOSL=99999,IOM=80,IOF="#",IOST="",$Y=0 D LST1(9.7)
 S Y="LST1^XPDDCS(9.7)",Z="Checksum Print"
 ;p345-rename AND* to XPD* - Patch was Cancelled keep code for future.
 I '$G(XPDAUTO) D EN^XUTMDEVQ(Y,Z,.XPD)
 I $G(XPDAUTO) S IO=XPDDEV U XPDDEV D LST1^XPDDCS(9.7)
 Q
 ;
ASK() ;Ask if want each routine listed
 N DIR
 I $D(XPDAUTO) Q 1
 S DIR(0)="YAO",DIR("A")="Want each Routine Listed with Checksums: ",DIR("A",1)="",DIR("B")="Yes"
 D ^DIR
 Q Y
 ;
EN2 ;print from build (system)
 N D0,DIC,XPD,XPDT,XPDST,Y,Z
 ;S DIC="^XPD(9.6,",DIC(0)="AEQMZ"
 ;D ^DIC Q:Y<0
 S XPDST=$$LOOK^XPDB1() Q:XPDST'>0
 S XPDSHW=$$ASK Q:$D(DIRUT)
 S XPD("XPDT(")="",XPD("XPDSHW")="",Y="LST1^XPDDCS(9.6)",Z="Checksum Print"
 ;p345-rename AND* to XPD*- Patch was Cancelled keep code for future.
 I '$G(XPDAUTO) D EN^XUTMDEVQ(Y,Z,.XPD)
 I $G(XPDAUTO) S:'$D(XPDDEV) XPDDEV=0 U XPDDEV D LST1^XPDDCS(9.6)
 Q
 ;
LST1(FILE) ;Print group
 N XPDI S XPDI=0
 F  S XPDI=$O(XPDT(XPDI)) Q:XPDI'>0  S D0=+XPDT(XPDI) D PNT(FILE)
 Q
 ;
PNT(XPDFIL) ;print
 N XPD0,XPDC,XPDDT,XPDE,XPDI,XPDJ,XPDPG,XPDQ,XPDUL,XPDBCS,X
 Q:'$D(^XPD(XPDFIL,D0,0))  S XPD0=^(0),XPDPG=1,$P(XPDUL,"-",IOM)="",XPDDT=$$HTE^XLFDT($H,"1PM")
 W:$E(IOST,1,2)="C-" @IOF D HDR
 W !
 S XPDI="",(XPDQ,XPDE)=0
 ;XPDFIL=9.7  use transport global exists
 I XPDFIL=9.7 D
 .I '$D(^XTMP("XPDI",D0)) W !!," ** Transport Global doesn't exist **" S XPDQ=1 Q
 .;check for missing nodes in transport global
 .I '$D(^XTMP("XPDI",D0,"BLD"))="" W !!," **Transport Global corrupted, please reload **" S XPDQ=1 Q
 .F XPDC=0:1 S XPDI=$O(^XTMP("XPDI",D0,"RTN",XPDI)) Q:XPDI=""  S XPDJ=$G(^(XPDI)) D  Q:XPDQ
 ..I XPDJ="" W !," **Transport Global corrupted, please reload **" S XPDQ=1 Q
 ..;if deleting at site, there is no checksum
 ..I +XPDJ=1 S XPDC=XPDC-1 Q
 ..;if no before checksum, get from FORUM, XPDBCS(routine)=checksum, doesn't work no web service on Forum
 ..;I $P(XPDJ,U,4)="" D:'$D(XPDBCS) CHKS^XPDIST($P(XPD0,U),.XPDBCS) S $P(XPDJ,U,4)=$G(XPDBCS(XPDI))
 ..D SUM(XPDI,$NA(^XTMP("XPDI",D0,"RTN",XPDI)),$P(XPDJ,U,3),$P(XPDJ,U,4))
 ..S XPDQ=$$CHK(4)
 ;check build file
 E  D
 .F XPDC=0:1 S XPDI=$O(^XPD(9.6,D0,"KRN",9.8,"NM","B",XPDI)) Q:XPDI=""  S XPDJ=$O(^(XPDI,0)) D  Q:XPDQ
 ..Q:'$D(^XPD(9.6,D0,"KRN",9.8,"NM",+XPDJ,0))  S XPDJ=$P(^(0),U,4)
 ..;quit if no checksum, routine wasn't loaded
 ..I XPDJ="" S XPDC=XPDC-1 Q
 ..N DIF,XCNP,%N
 ..S X=XPDI,DIF="^TMP($J,""RTN"",XPDI,",XCNP=0
 ..X ^%ZOSF("TEST") E  W !,XPDI,?10,"Doesn't Exist" Q
 ..X ^%ZOSF("LOAD")
 ..D SUM(XPDI,$NA(^TMP($J,"RTN",XPDI)),XPDJ,"")
 ..S XPDQ=$$CHK(4)
 Q:XPDQ
 W !!?3,XPDC," Routine"_$S(XPDC>1:"s",1:"")_" checked, ",XPDE," failed.",!
 ;p345-rename AND* to XPD*-Patch was Cancelled keep code for future.
 I $G(XPDAUTO) S XPDCHKSM=XPDE
 Q
 ;
 ;XPDR=routine name, Z=global root, XPD=check sum, XPDBS=before Checksum from FORUM
SUM(XPDR,Z,XPD,XPDBS) ;check checksum
 N Y
 ;See if we have a before checksum and compare.
 I $L(XPDBS) D BEFORE(XPDR,XPDBS)
 ;first char. is the sum tag used in XPDRSUM
 I XPD'?1U1.N W !,XPDR,?10,"ERROR in Checksum" S XPDE=XPDE+1 Q
 S @("Y=$$SUM"_$E(XPD)_"^XPDRSUM(Z)"),XPD=$E(XPD,2,255)
 I Y=XPD,XPDSHW W !,XPDR,?10,"Calculated "_$J(XPD,10)
 I Y'=XPD W !,XPDR,?10,"Calculated "_$C(7)_$J(Y,10)_", expected value "_XPD S XPDE=XPDE+1
 Q
 ;
BEFORE(RN,SUM) ;Check a before Checksum
 N DIF,XCNP,%N,X
 I SUM'?1U1.N Q
 K ^TMP($J,"XPDDCS",RN) ;patch 511
 S X=RN,DIF="^TMP($J,""XPDDCS"",RN,",XCNP=0
 X ^%ZOSF("TEST") E  W !,RN,?10,"Not on current system." Q
 X ^%ZOSF("LOAD")
 S DIF=$NA(^TMP($J,"XPDDCS",RN))
 S @("Y=$$SUM"_$E(SUM)_"^XPDRSUM(DIF)"),SUM=$E(SUM,2,255)
 I Y'=SUM W !,RN,?10,"Before Checksum Calculated "_Y_" expected value "_SUM
 Q
 ;
CHK(Y) ;Y=excess lines, return 1 to exit
 Q:$Y<(IOSL-Y) 0
 I $E(IOST,1,2)="C-" D  Q:'Y 1
 .N DIR,I,J,K,X
 .S DIR(0)="E" D ^DIR
 S XPDPG=XPDPG+1
 W @IOF D HDR
 Q 0
 ;
HDR W !,"PACKAGE: ",$P(XPD0,U),"     ",XPDDT,?70,"PAGE ",XPDPG,!,XPDUL,!
 Q
