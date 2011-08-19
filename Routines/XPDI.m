XPDI ;SFISC/RSD - Install Process ;9/16/02  13:29
 ;;8.0;KERNEL;**10,21,39,41,44,58,68,108,145,184,229**;Jul 10, 1995
EN ;install
 N DIR,DIRUT,POP,XPD,XPDA,XPDD,XPDIJ,XPDDIQ,XPDIT,XPDIABT,XPDNM,XPDNOQUE,XPDPKG,XPDREQAB,XPDST,XPDSET,XPDSET1,XPDT,XPDQUIT,XPDQUES,Y,ZTSK,%
 S %="I '$P(^(0),U,9),$D(^XPD(9.7,""ASP"",Y,1,Y)),$D(^XTMP(""XPDI"",Y))",XPDST=$$LOOK^XPDI1(%)
 Q:'XPDST!$D(XPDQUIT)
 S XPDIT=0,(XPDSET,XPDSET1)=$P(^XPD(9.7,XPDST,0),U) K ^TMP($J)
 ;Check each part of XPDT array
 F  S XPDIT=$O(XPDT(XPDIT)) Q:'XPDIT  D  Q:'$D(XPDT)!$D(XPDQUIT)
 .S XPDA=+XPDT(XPDIT),XPDNM=$P(XPDT(XPDIT),U,2),XPDPKG=+$P($G(^XPD(9.7,+XPDT(XPDIT),0)),U,2),%=$P(^(0),U,5)
 .W !,"Checking Install for Package ",XPDNM
 .;check that Install file was created correctly
 .I '$D(^XPD(9.7,XPDA,"INI"))!'$D(^("INIT")) W !,"**INSTALL FILE IS CORRUPTED**",!,*7 S XPDQUIT=1 Q
 .;run enviroment check routine
 .;XPDREQAB req. build missing, =2 global killed
 .I $$ENV^XPDIL1(1) S:$G(XPDREQAB)=2 XPDQUIT=1 Q
 .;save variables that are setup in environ. chck. routine
 .I $D(XPDNOQUE)!$D(XPDDIQ) D
 ..S:$D(XPDNOQUE) ^XTMP("XPDI",XPDA,"ENVVAR","XPDNOQUE")=XPDNOQUE
 ..I $D(XPDDIQ) M ^XTMP("XPDI",XPDA,"ENVVAR","XPDDIQ")=XPDDIQ
 .D QUES^XPDI1(XPDA) Q:'$D(XPDT(+XPDIT))!$D(XPDQUIT)
 .;XPDIJ=XPDA if XPDIJ routine is part of Build
 .S:$D(^XTMP("XPDI",XPDA,"RTN","XPDIJ")) XPDIJ=XPDA
 .D XQSET^XPDI1(XPDA)
 ;NONE = no Build to install
 G NONE:'$O(XPDT(""))!$D(XPDQUIT)!($G(XPDREQAB))
 ;check that we have all Builds to install
 S XPDA=XPDST,XPDNM=XPDSET,Y=0
 F  S Y=$O(^XPD(9.7,"ASP",XPDA,Y)) Q:'Y  S %=+$O(^(Y,0)) I '$D(XPDT("DA",%)) G NONE
 W !
 ;See if a Master Build
 S %=$O(^XTMP("XPDI",XPDA,"BLD",0)),%=$P(^(%,0),U,3) S:%=1 XPDT("MASTER")=XPDA
 ;Inhibit Logon Question
 D DIR^XPDIQ("XPI") I $D(DIRUT) D ABRTALL(2) Q
 ;disable options question
 D DIR^XPDIQ("XPZ") I $D(DIRUT) D ABRTALL(2) Q
 ;XPDSET=set name,(also build name), of options that will be disabled
 ;XPDSET1=setname or null if they don't want to disable
 D  I XPDSET1="^" D ABRTALL(2) Q
 .;if they say no, set XPDET1=""
 .S:'$G(XPDQUES("XPZ1")) XPDSET1="",Y=0
 .S ^XTMP("XQOO",XPDSET,0)=XPDSET_" is being installed by KIDS^"_DT_U_DUZ
 .I XPDSET1]"" D  Q:XPDSET1="^"!(XPDSET1="")
 ..;merge the options/protocols that were put in ^TMP($J,"XQOO",build name)
 ..M ^XTMP("XQOO",XPDSET)=^TMP($J,"XQOO",XPDSET)
 ..D INIT^XQOO(.XPDSET1) Q:"^"[XPDSET1
 ..N DIR S DIR(0)="N^0:60:0",DIR("B")=0
 ..S DIR("A")="Delay Install (Minutes)",DIR("?")="Enter the number of minutes to delay the installing of Routines after the Disable of Options"
 ..W ! D ^DIR I $D(DIRUT) S XPDSET1="^"
 .;Y is set in the call to DIR in previous .DO
 .;save setname into first Build and the Delay in minutes, Y
 .K XPD S XPD(9.7,XPDST_",",7)=(XPDSET1]"")_XPDSET,XPD(9.7,XPDST_",",8)=Y
 .D FILE^DIE("","XPD")
 ;check if they want to update other CPUs
 I $G(XPDQUES("XPZ2")) D  I $D(DIRUT) D ABRTALL(2) Q
 .N DA,DIE,DIR,DR,I,XPD,X,Y,Z
 .;if they haven't already added Volume Sets, populate the mulitple
 .I '$O(^XPD(9.7,XPDA,"VOL",0)) D  I $D(XPD) D UPDATE^DIE("","XPD")
 ..X ^%ZOSF("UCI") S Y=$P(Y,",",2),(I,Z)=0
 ..F  S I=$O(^%ZIS(14.5,I)) Q:'I  S X=$G(^(I,0)) S:$P(X,U)]""&$P(X,U,11)&($P(X,U)'=Y) Z=Z+1,XPD(9.703,"+"_Z_","_XPDA_",",.01)=$P(X,U)
 .W !!,"I will Update the following VOLUME SETS:",!
 .S I=0 F  S I=$O(^XPD(9.7,XPDA,"VOL",I)) Q:'I  W ?3,$P(^(I,0),U),!
 .W ! S DIR(0)="Y",DIR("A")="Want to edit this list",DIR("B")="NO"
 .D ^DIR Q:$D(DIRUT)  D:Y
 ..S DA=XPDA,DIE="^XPD(9.7,",DR=30,DR(2,9.703)=".01"
 ..D ^DIE
 .I '$O(^XPD(9.7,XPDA,"VOL",0)) W !!,"No VOLUME SETS selected!!" Q
 .Q:$$TM^%ZTLOAD  ;quit if Taskman is running
 .W !!,"TASKMAN is not running. If you install now, you must run the routine XPDCPU",!,"in the production UCI for each of the VOLUME SETS you have listed once"
 .W !,"the installation starts!!",!,"If you Queue the install, the VOLUME SETS will be updated automatically.",*7,*7,!!
DEV S POP=0 S:'$D(^DD(3.5,0)) POP=1
 ;check if home device is defined
 I 'POP S IOP="",%ZIS=0 D ^%ZIS
 ;Kernel Virgin Install
 I POP S XPDA=XPDST D:$G(XPDIJ) XPDIJ^XPDI1 G EN^XPDIJ
 ;set XPDA=starting Build, ask for device for messages
 ;XPDNOQUE is defined means don't let them queue output
 W !!,"Enter the Device you want to print the Install messages."
 W:'$D(XPDNOQUE) !,"You can queue the install by enter a 'Q' at the device prompt."
 W !,"Enter a '^' to abort the install.",!
 S XPDA=XPDST,%ZIS=$P("Q",U,'$D(XPDNOQUE))
 D ^%ZIS G:POP ASKABRT
 ;reset expiration date to T+7 on transport global
 S XPDD=$$FMADD^XLFDT(DT,7),^XTMP("XPDI",0)=XPDD_U_DT
 I $D(IO("Q")) D  G ASKABRT:$D(ZTSK)[0 D XPDIJ^XPDI1:$G(XPDIJ),QUIT^XPDI1(XPDST) Q
 . N DIR,NOW S NOW=$$HTFM^XLFDT($$HADD^XLFDT($H,,,2)) ;Must be in future
 . S DIR(0)="DA^"_NOW_":"_XPDD_":AEFRSX"
 . S DIR("A")="Request Start Time: "
 . S DIR("B")=$$FMTE^XLFDT(NOW)
 . S DIR("?",1)="Enter a Date including Time"
 . S DIR("?",2)="The time must be in the future and not to exceed 7 days in the future."
 . S DIR("?")="Current date/time: "_DIR("B")
 . D ^DIR
 .Q:$D(DIRUT)
 .S ZTDTH=Y,ZTRTN="EN^XPDIJ",ZTDESC=XPDNM_" KIDS install",ZTSAVE("XPDA")=""
 .D ^%ZTLOAD,HOME^%ZIS K IO("Q")
 .Q:$D(ZTSK)[0
 .W !,"Install Queued!",!!
 .;save task into first Build
 .K XPD S XPD(9.7,XPDST_",",5)=ZTSK,XPDIT=0
 .F  S XPDIT=$O(XPDT(XPDIT)) Q:'XPDIT  S XPD(9.7,+XPDT(XPDIT)_",",.02)=1 D FILE^DIE("","XPD") K XPD
 ;run install
 U IO D XPDIJ^XPDI1:$G(XPDIJ),QUIT^XPDI1(XPDST) G EN^XPDIJ
 Q
 ;
 ;XPDA=ien to del, XPDK=1 kill global, XPDALL=1 deleting all
 ;XPDST=starting package.
ABORT(XPDA,XPDK,XPDALL) ;abort install of Build XPDA
 N %,DA,DIK,XPDJ,XPDNM,Y
 Q:'$D(^XPD(9.7,XPDA,0))  S XPDNM=$P(^(0),U)
 D BMES^XPDUTL(XPDNM_" Build will not be installed"_$S(XPDK=1:", Transport Global deleted!",1:"")),MES^XPDUTL("               "_$$HTE^XLFDT($H))
 S DIK="^XPD(9.7,",XPDJ=XPDT("NM",XPDNM),DA=XPDA
 ;kill XPDT array, but don't kill global if XPDK=2
 K XPDT("NM",XPDNM),XPDT("DA",XPDA),XPDT(XPDJ),XPDT("GP") Q:XPDK=2
 K ^XTMP("XPDI",XPDA)
 ;if we are not deleting all packages and we are deleting the starting package
 ;set the next package to the starting package. It must always be 1.
 I '$G(XPDALL),XPDA=XPDST S Y=$O(XPDT(0)) D:Y
 .;unlock starting install
 .L -^XPD(9.7,XPDST)
 .S XPDST=+XPDT(Y),XPDT(1)=XPDT(Y),XPDT("DA",XPDST)=1,XPDT("NM",$P(XPDT(Y),U,2))=1,XPDIT=0
 .K XPDT(Y) N XPD
 .S %="XPD(9.7,"""_XPDST_","")",@%@(3)=XPDST,@%@(4)=1
 .;loop thru the rest of the packages and reset the starting package field
 .F  S Y=$O(XPDT(Y)) Q:'Y  D
 ..S XPD(9.7,+XPDT(Y)_",",3)=XPDST
 .D FILE^DIE("","XPD")
 D ^DIK
 Q
ASKABRT ;ask if want to unload distribution
 N DIR,DIRUT,X,Y
 S XPDQUIT=1,DIR(0)="Y",DIR("A")="Install ABORTED, Want to remove the Transport Globals",DIR("B")="YES"
 W ! D ^DIR I Y D ABRTALL(1) Q
 L -^XPD(9.7,XPDST)
 Q
ABRTALL(XPDK) ;abort all Builds
 N XPDA
 S XPDT=0
 F  S XPDT=$O(XPDT(XPDT)) Q:'XPDT  S XPDA=+XPDT(XPDT) D ABORT(XPDA,XPDK,1)
 ;unlock starting install
 L -^XPD(9.7,XPDST)
 Q
NONE W !!,"**NOTHING INSTALLED**",!
 Q
