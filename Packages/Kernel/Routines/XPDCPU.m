XPDCPU ;SFISC/RWF,RSD - Code that update each cpu ;09/09/96  08:01
 ;;8.0;KERNEL;**41,44**;Jul 03, 1995
 N DIC,X,XPDA
 S DIC("S")="I $P(^(0),U,9)=2,$D(^XPD(9.7,""ASP"",Y,1,Y)),$D(^XTMP(""XPDI"",Y))"
 D EN1 Q:'XPDA
 S X=$O(^XPD(9.7,XPDA,"VOL","B",^%ZOSF("VOL"),0)) Q:'X
 D EN(XPDA,X)
 Q
 ;
MOVE ;move routines to other CPU
 N DIC,DIR,DIRUT,X,XPDA,XPDJ,Y
 S DIC("S")="I $P(^(0),U,9)=3"
 D EN1 Q:'XPDA
 S DIR(0)="Y",DIR("A")="Want to move the Routine for this Package to another CPU",DIR("B")="YES",DIR("?")="YES means you want to update the routines on another CPU"
 D ^DIR Q:'Y!$D(DIRUT)
 K ^XTMP("XPDR",XPDA)
 S ^XTMP("XPDR",0)=DT_U_DT,XPDJ=""
 F  S XPDJ=$O(^XPD(9.7,XPDA,"RTN","B",XPDJ)) Q:XPDJ=""  D
 .Q:XPDJ="XPDCPU"
 .N DIF,XCNP,%N
 .S DIF="^XTMP(""XPDR"",XPDA,""RTN"",XPDJ,",XCNP=0,X=XPDJ
 .X ^%ZOSF("LOAD")
 I $D(^XTMP("XPDR",XPDA)) W !!,"Run INSTALL^XPDCPU on the other CPU to install the Routines.",!
 Q
INSTALL ;install routines
 N DIC,DIR,DIRUT,X,XPDA,XPDJ,Y
 S DIC("S")="I $P(^(0),U,9)=3,$D(^XTMP(""XPDR"",Y))"
 D EN1 Q:'XPDA
 S DIR(0)="Y",DIR("A")="Want to install the Routine for this Package",DIR("B")="YES",DIR("?")="YES means you want to install the routines on this CPU"
 D ^DIR Q:'Y!$D(DIRUT)
 S XPDJ=""
 F  S XPDJ=$O(^XTMP("XPDR",XPDA,"RTN",XPDJ)) Q:XPDJ=""  D
 .N %,DIE,XCM,XCN,XCS
 .S DIE="^XTMP(""XPDR"",XPDA,""RTN"",XPDJ,",XCN=0,X=XPDJ
 .X ^%ZOSF("SAVE")
 W !!,"Done",!!
 Q
 ;
EN(XPDA,XPDVDA) ;XPDA=ien of INSTALL file, XPDVDA=VOLUME SET ien
 L +^XPD(9.7,XPDA,"VOL",XPDVDA):2 E  W:IO]"" !,"Can't Lock global, another XPDCPU must be running",! Q
 N Y,%,XPDNM
 S Y=0,ZTREQ="@"
 F  S Y=$O(^XPD(9.7,"ASP",XPDA,Y)) Q:'Y  S %=$O(^(Y,0)) D:%  Q:$D(XPDABORT)
 .N XPDA,Y
 .S XPDA=%,XPDNM=$P($G(^XPD(9.7,XPDA,0)),U) D EN2
 Q
EN1 ;ask for Install
 N Y S XPDA=0
 I $D(DUZ)_$D(DUZ(0))_$D(U)[0 D DT^DICRW
 S DIC(0)="QEAMZ",DIC="^XPD(9.7,"
 D ^DIC K DIC Q:Y'>0
 S XPDA=+Y
 Q
EN2 N X,XPD,XPDBLD,XPDI,ZTUCI,ZTCPU,ZTRTN,ZTDTH,ZTIO,ZTDESC
 ;must have XTMP & entry in file 9.7
 Q:'$D(^XTMP("XPDI",XPDA))!'$D(^XPD(9.7,XPDA,0))
 ;hang 1 hr or until VOLUME multiple is set, XPDIJ sets VOL multiple
 F X=0:1:60 Q:$D(^XPD(9.7,XPDA,"VOL",+$G(XPDVDA),0))  H 60 W:IO]"" "."
 I X=60 W:IO]"" !!,"Package ",$P(^XPD(9.7,XPDA,0),U)," never installed",! Q
 S XPDBLD=$O(^XTMP("XPDI",XPDA,"BLD",0))
 D FILE(2),UPDT
 W:IO]"" !,"Loading Routines"
 I $D(^XTMP("XPDI",XPDA,"RTN","XPDCPU")) S X=$$RTNUP^XPDUTL("XPDCPU",2)
 ;make sure routines have been loaded
 F X=0:1:240 Q:$P($G(^XPD(9.7,XPDA,1)),U,2)  H 15 W:IO]"" "." D UPDT
 D UPDT,RTN^XPDIJ(XPDA),UPDT
 W:IO]"" !!,"Recompiling Template routines"
 F XPD="DIKZ","DIEZ","DIPZ" D
 .S XPDI="" Q:'$$CHCK
 .F  S XPDI=$O(^XTMP("XPDI",XPDA,XPD,XPDI)) Q:'XPDI  S X=^(XPDI) D:X]"" @("EN2^"_XPD_"("""_XPDI_""","""","""_X_""")"),UPDT
 D UPDT,FILE(1)
 Q
CHCK() ;check if the component is installed, return 1 if installed, 0 to abort
 N XPDC,Y
 I XPD="DIKZ" S XPDC="S Y=$G(^(+$O(^XPD(9.7,XPDA,4,""A""),-1),0))"
 E  S Y=$S(XPD="DIPZ":.4,1:.402),XPDC="S Y=$G(^XPD(9.7,XPDA,""KRN"","_Y_",0))"
 F  X XPDC Q:'Y!$P(Y,U,2)  H 60 D UPDT W:IO]"" "." I $D(ZTMQUE),$$STOP^%ZTLOAD S Y=0 Q
 Q ''Y
FILE(XPDF) ;set NOW into the VOLUME SET multiple, XPDF=field number
 N XPD
 S XPD(9.703,XPDVDA_","_XPDA_",",XPDF)=$$NOW^XLFDT
 D FILE^DIE("","XPD")
 Q
UPDT ;update $H into VOLUME SET multiple, field 4
 S ^XPD(9.7,XPDA,"VOL",XPDVDA,1)=$H
 Q
