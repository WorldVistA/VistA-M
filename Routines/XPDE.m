XPDE ;SFISC/RSD - Package Edit ;06/24/2008
 ;;8.0;KERNEL;**2,15,21,44,51,68,131,182,201,229,302,399,507,539**;Jul 10, 1995;Build 11
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;these tags are called from options.
EDIT ;edit Build file package
 N DA,DIR,DDSFILE,DR,Y,Z
 Q:'$$DIC("AEMQLZ","",1)  S DA=+Y
 I $P(Y,U,3) D NEW(DA)
 S Z=$P(^XPD(9.6,DA,0),U,3)+1,DR="["_$P("XPD EDIT BUILD^XPD EDIT MP^XPD EDIT GP",U,Z)_"]",DDSFILE="^XPD(9.6,"
 D ^DDS Q:'$G(DA)
 ;if full DD, kill multiple for partial DD
 S Y=0 F  S Y=$O(^XPD(9.6,DA,4,Y)) Q:'Y  S Z=$G(^(Y,222)) D
 .K:$P(Z,U,3)="f" ^XPD(9.6,DA,4,Y,2),^XPD(9.6,DA,4,"APDD",Y)
 D QUIT(DA)
 Q
COPY ;copy a Build file package
 N DA,DIK,DIR,FR,FR0,TO,TO0,X,Y,Z W !
 Q:'$$DIC("QEAMZ","Copy FROM what Package: ")
 S FR=+Y,FR0=Y(0),Z="QEAMZL",Z("S")="I Y'="_FR
 I '$$DIC(.Z,"Copy TO what Package: ") D QUIT(FR) Q
 S TO=Y,TO0=Y(0)
 ;if this is not new, then it will be purged before copy.
 I '$P(TO,U,3) W !,$P(TO0,U)," package will be PURGED before the copy."
 W ! S DIR(0)="Y",DIR("A")="OK to continue",DIR("B")="YES" D ^DIR
 S DIK="^XPD(9.6,",DA=+TO
 I 'Y!$D(DIRUT) D  W ! Q
 .;they didn't want to continue, kill if it was a new package.
 .I $P(TO,U,3) D ^DIK W $P(TO0,U)," being deleted!"
 .;unlock both packages
 .D QUIT(FR),QUIT(TO)
 D WAIT^DICD
 ;if not new, kill old data
 K:'$P(TO,U,3) ^XPD(9.6,DA)
 M ^XPD(9.6,DA)=^XPD(9.6,FR) S $P(^(DA,0),U)=$P(TO0,U)
 D NEW(+TO)
 ;if new National Package name, then kill x-ref
 I $P(TO0,U,2)]"",$P(FR0,U,2)'=$P(TO0,U,2) K ^XPD(9.6,"C",$E($P(TO0,U,2),1,30),DA) S DIK(1)=1 D EN1^DIK
 D QUIT(FR),QUIT(TO)
 W "...Done.",!
 Q
BUILD ;build package from a namespace
 N DIR,DIRUT,XPDA,XPDI,XPDF,XPDN,XPDX,XPDXL,X,X1,Y,Y1 W !
 Q:'$$DIC("QEAML")
 S XPDA=+Y W !
 I $P(^XPD(9.6,XPDA,0),U,3) W !,"The Build Type must be SINGLE PACKAGE!!",! Q
 ;if not a new package
 I '$P(Y,U,3) D  I $D(DIRUT) D QUIT(XPDA) Q
 .S DIR(0)="Y",DIR("A")="Package already exists, Want to PURGE the existing data",DIR("B")="NO",DIR("?")="YES will delete all the KERNEL FILE information for this package in the BUILD file."
 .D ^DIR K DIR Q:'Y
 .S Y=0 F  S Y=$O(^XPD(9.6,XPDA,"KRN",Y)) Q:'Y  K ^(Y,"NM")
 E  D NEW(XPDA)
 ;XPDN(0=excluded names or 1=include names, namespace)=""
 W ! S DIR(0)="FO^1:15^K:X'?.1""-""1U.15UNP X",DIR("A")="Namespace",DIR("?")="Enter 1 to 15 characters, preceed with ""-"" to exclude namespace"
 F  D ^DIR Q:$D(DIRUT)  S X=$E(Y,$L(Y))="*",%=$E(Y)="-",XPDN('%,$E(Y,%+1,$L(Y)-X))=""
 I '$D(XPDN)!$D(DTOUT)!$D(DUOUT) D QUIT(XPDA) Q
 W !!,"NAMESPACE  INCLUDE",?35,"EXCLUDE",!,?11,"-------",?35,"-------"
 S (X,Y)="",(X1,Y1)=1
 F  D  W !?11,X,?35,Y Q:'X1&'Y1
 .S:X1 X=$O(XPDN(1,X)),X1=X]"" S:Y1 Y=$O(XPDN(0,Y)),Y1=Y]""
 S DIR(0)="Y",DIR("A")="OK to continue",DIR("B")="YES" D ^DIR
 I 'Y!$D(DIRUT) D QUIT(XPDA) Q
 D WAIT^DICD S XPDX="",XPDI("IEN")=0
 F  S XPDX=$O(XPDN(1,XPDX)),XPDXL=$L(XPDX),XPDF=0 Q:XPDX=""  D
 .F  S XPDF=$O(^XPD(9.6,XPDA,"KRN",XPDF)) Q:'XPDF  D
 ..N XPD,XPDIC,XPDJ,XPCNT W "."
 ..;XPDIC is used in $$SCR1^XPDET
 ..S XPDIC="^XPD(9.6,"_XPDA_",""KRN"","_XPDF_",""NM"",",XPCNT=0
 ..D LIST^DIC(XPDF,"","","","*",.XPDI,XPDX,"","I $E(^(0),1,XPDXL)=XPDX,$$SCR1^XPDET(Y)")
 ..F XPDJ=1:1 S X=$G(^TMP("DILIST",$J,1,XPDJ)) Q:X=""  D
 ...S:XPDF<.404 %=^TMP("DILIST",$J,2,XPDJ)_",",X=$$TX^XPDET(X,$$GET1^DIQ(XPDF,%,$$TF^XPDET(XPDF),"I"))
 ...S Y="+"_XPDJ_","_XPDF_","_XPDA_",",XPD(9.68,Y,.01)=X,XPD(9.68,Y,.03)=0
 ...;Keep XPD from getting too big.
 ...S XPCNT=XPCNT+1 I XPCNT>100 D UPDATE^DIE("","XPD") S XPCNT=0 K XPD
 ..Q:'$D(XPD)  D UPDATE^DIE("","XPD")
 D QUIT(XPDA)
 W "...Done.",!
 Q
VER ;verify a Build file package
 N XPDA,Y
 Q:'$$DIC("AEMQZ")  S XPDA=+Y
 D EN^XPDV
 Q
DIC(DIC,A,XPDL) ;DIC lookup to Build file, 9.6
 N DLAYGO
 S DIC(0)=$G(DIC),DIC="^XPD(9.6," S:$G(A)]"" DIC("A")=A
 S:DIC(0)["L" DLAYGO=9.6,DIC("DR")="1;2//SINGLE PACKAGE;5//YES"
 D ^DIC Q:Y<0 0
 I '$G(XPDL) L +^XPD(9.6,+Y):0 E  W !,"Being accessed by another user" Q 0
 Q +Y
 ;
NEW(DA) ;create Kernel Files multiple for package DA
 N I,J,X,XPDNEWF,XPD,XPDI
 S:'$D(^XPD(9.6,DA,"KRN",0)) ^XPD(9.6,DA,"KRN",0)=U_$P(^DD(9.6,7,0),U,2)
 S I=0
 F J=1:1 S X=+$P($T(FILES+J),";;",2) Q:'X  S:$D(^DD(X))&'$D(^XPD(9.6,DA,"KRN",X)) I=I+1,(XPDI(I),XPD(9.67,"+"_I_","_DA_",",.01))=X
 Q:'$D(XPD)
 ;XPDNEWF is a flag in INPUT transform of BUILD COMPONENT multiple
 S XPDNEWF=1
 D UPDATE^DIE("","XPD","XPDI")
 Q
QUIT(Y) ;unlock Y
 L -^XPD(9.6,Y)
 Q
 ;
 ;;file;install order;x-ref;file build;entry build;file pre;entry pre;file post;entry post;delete
 ;You must put in code to delete anything
FILES ;kernel files for field 7 in file 9.6
 ;;9.8;;1;RTNF^XPDTA;RTNE^XPDTA
 ;;9.2;1;;;HELP^XPDTA1;HLPF1^XPDIA1;HLPE1^XPDIA1;HLPF2^XPDIA1;;HLPDEL^XPDIA1
 ;;3.6;2;1;;BUL^XPDTA1;;BULE1^XPDIA1;;;BULDEL^XPDIA1
 ;;19.1;3;;;KEY^XPDTA1;KEYF1^XPDIA1;KEYE1^XPDIA1;KEYF2^XPDIA1;;KEYDEL^XPDIA1
 ;;.5;4;;;EDEOUT^DIFROMSO(.5,DA,"",XPDA);FPRE^DIFROMSI(.5,"",XPDA);EPRE^DIFROMSI(.5,DA,"",XPDA,"",OLDA);;EPOST^DIFROMSI(.5,DA,"",XPDA)
 ;;.4;5;;;EDEOUT^DIFROMSO(.4,DA,"",XPDA);FPRE^DIFROMSI(.4,"",XPDA);EPRE^DIFROMSI(.4,DA,$E("N",$G(XPDNEW)),XPDA,"",OLDA);;EPOST^DIFROMSI(.4,DA,"",XPDA);DEL^DIFROMSK(.4,"",%)
 ;;.401;6;;;EDEOUT^DIFROMSO(.401,DA,"",XPDA);FPRE^DIFROMSI(.401,"",XPDA);EPRE^DIFROMSI(.401,DA,$E("N",$G(XPDNEW)),XPDA,"",OLDA);;EPOST^DIFROMSI(.401,DA,"",XPDA);DEL^DIFROMSK(.401,"",%)
 ;;.402;7;;;EDEOUT^DIFROMSO(.402,DA,"",XPDA);FPRE^DIFROMSI(.402,"",XPDA);EPRE^DIFROMSI(.402,DA,$E("N",$G(XPDNEW)),XPDA,"",OLDA);;EPOST^DIFROMSI(.402,DA,"",XPDA);DEL^DIFROMSK(.402,"",%)
 ;;.403;8;;;EDEOUT^DIFROMSO(.403,DA,"",XPDA);FPRE^DIFROMSI(.403,"",XPDA);EPRE^DIFROMSI(.403,DA,$E("N",$G(XPDNEW)),XPDA,"",OLDA);;EPOST^DIFROMSI(.403,DA,"",XPDA);DEL^DIFROMSK(.403,"",%)
 ;;.84;9;;;EDEOUT^DIFROMSO(.84,DA,"",XPDA);FPRE^DIFROMSI(.84,"",XPDA);EPRE^DIFROMSI(.84,DA,"",XPDA,"",OLDA);;EPOST^DIFROMSI(.84,DA,"",XPDA);DEL^DIFROMSK(.84,"",%)
 ;;3.8;11;;;MAILG^XPDTA1;MAILGF1^XPDIA1;MAILGE1^XPDIA1;MAILGF2^XPDIA1;;MAILGDEL^XPDIA1(%)
 ;;870;13;1;;HLLL^XPDTA1;;HLLLE^XPDIA1;;;HLLLDEL^XPDIA1(%)
 ;;771;14;;;HLAP^XPDTA1;HLAPF1^XPDIA1;HLAPE1^XPDIA1;HLAPF2^XPDIA1;;HLAPDEL^XPDIA1(%)
 ;;101;15;;;PRO^XPDTA;PROF1^XPDIA;PROE1^XPDIA;PROF2^XPDIA;;PRODEL^XPDIA
 ;;8994;16;1;;;;;;;RPCDEL^XPDIA1
 ;;409.61;17;1;;;;LME1^XPDIA1;;;LMDEL^XPDIA1
 ;;19;18;;;OPT^XPDTA;OPTF1^XPDIA;OPTE1^XPDIA;OPTF2^XPDIA;;OPTDEL^XPDIA
 ;;8994.2;19;1;;;;CRC32PE^XPDIA1;;;CRC32DEL^XPDIA1
 ;;8989.51;20;;;PAR1E1^XPDTA2;PAR1F1^XPDIA3;PAR1E1^XPDIA3;PAR1F2^XPDIA3;;PAR1DEL^XPDIA3(%)
 ;;8989.52;21;1;;PAR2E1^XPDTA2;PAR2F1^XPDIA3;PAR2E1^XPDIA3;PAR2F2^XPDIA3;;PAR2DEL^XPDIA3(%)
 ;;779.2;22;1;;HLOAP^XPDTA1;;HLOE^XPDIA1;;;
 ;;9002226;23;1;;BLD^XPDIHS;BLD1^XPDIHS;BLD^XPDIHS;BLD1^XPDIHS;;BLD^XPDIHS
