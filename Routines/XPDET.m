XPDET ;SFISC/RSD - Input tranforms & help for file 9.6 & 9.7 ;10/19/2002
 ;;8.0;KERNEL;**15,39,41,44,51,58,66,137,229,393,539**;Jul 10, 1995;Build 11
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
INPUTB(X) ;input tranfrom for NAME in BUILD file
 ;X=user input
 ;name must be unique
 I $L(X)>50!($L(X)<3)!$D(^XPD(9.6,"B",X)) K X Q
 I X["*" K:$P(X,"*",2,3)'?1.2N1"."1.2N.1(1"V",1"T").2N1"*"1.6N X Q
 S %=$L(X," ") I %<2 K X Q
 S %=$P(X," ",%) K:%'?1.2N1"."1.2N.1(1"V",1"T",1"B").2N X
 Q
INPUTE(X) ;input transform for ENTRIES in KERNEL FILES multiple
 ;X=user input
 N D,DD,DIC,DICR,DIX,DIY,DS,DO,XPDLK,Y
 S XPDLK=$$GR(D1)
 I XPDLK=""!X["*" K X Q
 S DIC(0)="QEMZ",DIC=XPDLK
 S:D1=9.8 DIC("S")="I $T(^@$P(^(0),U))]"""""
 D ^DIC K:Y<0 X Q:'$D(X)
 S X=Y(0,0)
 ;check that this doesn't exist already
 I $D(^XPD(9.6,D0,"KRN",D1,"NM","B",X)) K X Q
 ;if fm file, change X to contain file # of template
 I D1<.404 S X=$$TX(X,$P(Y(0),U,$S(D1=.403:8,1:4)))
 Q
GLOBALE(X) ;input transform for GLOBAL multiple .01 field in file 9.6
 I $L(X)>30!($L(X)<2) K X Q
 I X["(",X'[")" K X Q
 ;change ' back to " for subscripts, they were changed in the Pre-Lookup node of the DD, 7.5. This was done to trick FM, which doesn't allow " in .01 fields
 S X=$TR(X,"'","""")
 I '$D(@("^"_X)) K X
 Q
INPUTMB(X) ;input transform for field 10 and 11 in file 9.6
 ;X=user input
 N D,DD,DIC,DICR,DIX,DIY,DS,DO,Y
 ;can't select a global or multi package or itself (D0)
 S DIC(0)="QEMZ",DIC="^XPD(9.6,",DIC("S")="I '$P(^(0),U,3),Y'="_D0
 D ^DIC K:Y<0 X Q:'$D(X)
 S X=Y(0,0)
 Q
LOOKE(X) ;special lookup for ENTRIES in KERNEL FILES multiple
 Q:X'?1.E1"*"
 N %,XPD,XPDI,XPDIC,XPDF,XPDLK,XPDX,Y
 S XPDLK=$$GR(D1),XPDIC=DIC,XPDF=D1
 I XPDLK="" K X Q
 G:$E(X)="-" DEL
 S XPDX=$P(X,"*"),XPDI("IEN")=0
 D LIST^DIC(D1,"","","","*",.XPDI,XPDX,"","I $$SCR^XPDET(Y)")
 I '$G(^TMP("DILIST",$J,0)) K X Q
 K ^TMP("XPDX",$J)
 ;loop thru list from lister and file using UPDATE^DIE
 F XPDI=1:1 S X=$G(^TMP("DILIST",$J,1,XPDI)) Q:X=""  D
 .S:D1<.404 %=^TMP("DILIST",$J,2,XPDI)_",",X=$$TX(X,$$GET1^DIQ(D1,%,$$TF(D1),"I"))
 .S Y="+"_XPDI_","_D1_","_D0_",",^TMP("XPDX",$J,9.68,Y,.01)=X,^(.03)=0
 I $D(^TMP("XPDX",$J)) D UPDATE^DIE("","^TMP(""XPDX"",$J)","^TMP(""XPD"",$J)")
 ;if in Screenman then call MLOAD to update screen
 I $D(DDS),$D(^TMP("XPD",$J)) D MLOAD^DDSUTL("^TMP(""XPD"",$J)")
 S X=""
 K ^TMP("XPDX",$J),^TMP("XPD",$J)
 Q
DEL ;delete using wild card
 I X'?1"-"1.E1"*" K X Q
 S X=$E(X,2,$L(X)-1),XPDX=X S:$L(X) XPDI("IEN")=0
 D LIST^DIC(9.68,","_D1_","_D0_",","","","*",.XPDI,XPDX)
 I '$G(^TMP("DILIST",$J,0)) K X Q
 N DIK,DA,D2
 S DIK=XPDIC,DA(1)=D1,DA(2)=D0
 F XPDI=1:1 S (DA,D2)=$G(^TMP("DILIST",$J,2,XPDI)) Q:'DA  D
 .D ^DIK
 I $D(DDS) D MDEL^DDSUTL("^TMP(""DILIST"",$J,2)")
 S X=""
 K ^TMP("DILIST",$J)
 Q
HELP ;executable help of ENTRIES in KERNEL FILE multiple
 N D,DIC,DIE,DIX,DIY,DO,DZ,DS,X,Y
 ;file 9.8 is routine file, check that routine exists
 S DIC=$$GR(D1),DIC(0)="M",X="??" Q:DIC=""  S:D1=9.8 DIC("S")="I $T(^@$P(^(0),U))]"""""
 D ^DIC Q
 ;
HELPO ;executable help of INSTALL ORDER in KERNEL FILES multiple
 N Y
 W !,"Numbers in use:  ORDER     FILE#" S Y=0
 F  S Y=$O(^XPD(9.6,D0,"KRN","AC",Y)) Q:'Y  W !,?18,$J(Y,2),?28,$O(^(Y,0))
 W ! Q
 ;
HELPMB ;executable help of fields 10 & 11 in file 9.6
 N D,DIC,DIE,DIX,DIY,DO,DZ,DS,X,Y
 S DIC="^XPD(9.6,",DIC(0)="M",X="??",DIC("S")="I '$P(^(0),U,3),Y'="_D0
 D ^DIC Q
 ;
SCRA(Y) ;screen of ACTION field in ENTRIES multiple in KERNEL FILES multiple, Y=action
 ;Y=0 - send, 1 - delete, 2 - link, 3 - merge, 4 - attach, 5 - disable
 ;all entries can send to site
 Q:'Y 1
 ;.5=function file, can't delete, all others can
 I Y=1 Q (D1'=.5)
 ;then rest of code check if it is a Option or Protocal and can have MENU ITEMS
 Q:D1'=19&(D1'=101) 0
 ;only Options and Protocol can disable
 Q:Y=5 1
 N FGR,X,XPDF,XPDT,XPDY,XPDZ
 ;get X=name, FGR=global reference, XPDF=file #
 S XPDY=Y,XPDF=D1,X=$P(^XPD(9.6,D0,"KRN",D1,"NM",D2,0),U),FGR=$$FILE^XPDV(D1)
 Q:X="" 0
 ;X=ien of protocol or option
 S X=+$O(@FGR@("B",X,0)) Q:'X 0
 ;get type
 S XPDT=$P($G(@FGR@(X,0)),U,4)
 ;all Options and Protocols, except Event Drivers, can be attached
 I XPDY=4 Q '(XPDF=101&(XPDT="E"))
 ;Protocol and Type is Subscriber can't do anything else
 I XPDF=101,XPDT="S" Q 0
 ;if it has SUBSCRIBERS, node 775 then ok
 I $O(@FGR@(X,775,0)) Q 1
 ;if type is menu,potocol,protocol menu,limited,extended,window suite
 I "MOQLXZ"[$P($G(@FGR@(X,0)),U,4) Q 1
 ;if it has ITEMs, node 10 then ok
 I $O(@FGR@(X,10,0)) Q 1
 Q 0
 ;
 ;only Fileman templates need to know what file they are associated with.
 ;this value is also triggered to field .02 in the DD.
TX(X,Y) ;X=template name, Y=file #
 Q X_"    FILE #"_Y
 ;
TF(F) ;F=file, return field of file# for templates
 Q $S(F>.403:"",F<.403:4,1:7)
 ;
GR(X) Q $G(^DIC(X,0,"GL"))
 ;
 ;screens checks that X is not already in the ENTRIES multiple
SCR(Y) ;screen logic for ENTRIES multiple in file 9.6
 N %,X,Z
 S Z=^(0),X=$P(Z,U)
 ;FM files are less than .44
 I XPDF<.44 D  Q:X="" 0
 .S %=$S(XPDF=.403:$P(Z,U,8),1:$P(Z,U,4)),X=X_"    FILE #"_%
 .S:XPDF'=.403&($P(Z,U,8)>2) %=0 S:'% X=""
 ;routine must exist and must be type 'R'
 I XPDF=9.8 Q:$T(^@X)=""!($P(Z,U,2)'="R") 0
 Q '$D(@(XPDIC_"""B"",X)"))
 ;
 ;screen checks that X is not in the exclude list, XPDN(0)
SCR1(Y) ;screen logic for exclude list
 N %,X
 ;if name X is in the exclude list, XPDN(0,X), then fail
 S Y(0)=^(0),X=$P(Y(0),U) Q:$D(XPDN(0,X)) 0
 ;check if X is refered in the namespace by check the subscript
 ;before X, if sub exist and $P(X,sub)="" then it is part of the
 ;namespace, fail and return 0
 S %=$O(XPDN(0,X),-1) I $L(%) Q:$P(X,%)="" 0
 Q $$SCR(.Y)
 ;
 ;screen on PACKAGE LINK field in file 9.6,
PCK(Y) ;check Package File name, Y=ien in package file
 N %,Y,Z
 S Z=^(0)
 ;DA is undef when you are adding a new Build without a version number
 Q:'$D(^XPD(9.6,+$G(DA),0)) 1
 S Y=$L($P(Z,U)),%=$P(^XPD(9.6,DA,0),U),%=$$PKG^XPDUTL(%)
 Q $P(Z,U)=$E(%,1,Y)!($P(Z,U,2)=%)
VOLE(X) ;input transform for VOLUME SET multiple in INSTALL file
 ;X=user input
 N D,DD,DIC,DICR,DIX,DIY,DO,DS,XPD,Y,%
 ;(0;11)=SIGNON/PRODUCTION
 S DIC(0)="QEMZ",DIC="^%ZIS(14.5,",DIC("S")="I $P(^(0),U,11)"
 D ^DIC K:Y<0 X Q:'$D(X)
 S X=Y(0,0)
 Q
VOLH ;executable help for VOLUME SET multiple in INSTALL file
 N D,DD,DIC,DIE,DIX,DIY,DO,DS,DZ,X,Y,%
 S X="??",DIC(0)="QEMZ",DIC="^%ZIS(14.5,",DIC("S")="I $P(^(0),U,11)"
 D ^DIC
 Q
ID97 ;identifier for Install file
 N XPDET,XPD,XPD0,XPD1,XPD2,XPD9
 S XPD0=$G(^(0)),XPD1=$G(^(1)),XPD2=$G(^(2)),XPD9=$P(XPD0,U,9),XPD="" Q:XPD9=""
 D
 .;Loaded, get DATE LOADED
 .I 'XPD9 S XPD=$$FMTE^XLFDT($P(XPD0,U,3),2) Q
 .Q:XPD9>4
 .;Started, get INSTALL START TIME
 .I XPD9=2 S XPD=$$FMTE^XLFDT($P(XPD1,U),2) Q
 .;Completed or De-Installed, get INSTALL COMPLETE TIME
 .I XPD9>2 S XPD=$$FMTE^XLFDT($P(XPD1,U,3),2) Q
 .;Queued, get QUEUED TASK NUMBER
 .I XPD9=1 S XPD="#"_$P(XPD0,U,6) Q
 ;S XPDET(1)="   "_$$EXTERNAL^DILFD(9.7,.02,"",XPD9)_"  "_XPD,XPDET(1,"F")="?0"
 S XPDET(1)="  "_XPD,XPDET(1,"F")="?0"
 S:XPD2]"" XPDET(2)="=> "_$E(XPD2,1,70),XPDET(2,"F")="!?5"
 D EN^DDIOL(.XPDET)
 Q
 ;not being used right now,
DEL97(Y) ;delete access to file 9.7, 0-can't delete, 1-can
 N %
 S %=$P(^XPD(9.7,Y,0),U,9)
 Q $S(%=3:1,%=2:0,$D(^XPD(9.7,"ASP",Y,1,Y)):1,1:0)
 ;
PAR964 ;Clear other fields if file is partial.  Called from within form
 D PUT^DDSVAL(DIE,.DA,222.7,"n","","I") ;Send data NO
 D PUT^DDSVAL(DIE,.DA,222.5,"","","I") ;Resolve pointer
 D PUT^DDSVAL(DIE,.DA,222.8,"","","I") ;Sites Data
 D PUT^DDSVAL(DIE,.DA,222.9,"n","","I") ;User Override
 D PUT^DDSVAL(DIE,.DA,224,"","","I") ;Data Screen
 Q
 ;
