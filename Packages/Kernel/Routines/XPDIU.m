XPDIU ;SFISC/RSD - UNload/Convert/Rollup Distribution Global ;08/14/2008
 ;;8.0;KERNEL;**15,41,44,51,58,101,108,506**;Jul 10, 1995;Build 11
 ;Per VHA Directive 2004-038, this routine should not be modified.
EN1 ;unload
 N %,DA,DIK,DIR,DIRUT,X,XPD,XPDST,XPDT,XPDQ,XPDQUIT,Y
 ;remove dangling transport globals
 S DA=0 F  S DA=$O(^XTMP("XPDI",DA)) Q:'DA  I '$D(^XPD(9.7,DA)) K ^XTMP("XPDI",DA)
 ;must be the starting package and still exist in the transport global
 S (DA,XPDST)=$$LOOK^XPDI1("I $D(^XPD(9.7,""ASP"",Y,1,Y)),$D(^XTMP(""XPDI"",Y))") Q:'DA
 S XPDQ=^XPD(9.7,DA,0),DIR(0)="Y",DIR("A")="Want to continue with the Unload of this Distribution",DIR("B")="NO"
 ;check if install has status of start
 I $P(XPDQ,U,9)=2 W !!,"***WARNING***  Install ",$P(XPDQ,U)," has already started!",!,"   Unloading this install might leave your system in an unstable state!!",!!
 S DIR("?")="YES will delete the Transport Global and the entry in the Install file for these Packages."
 I $P(XPDQ,U,9)=1,$P(XPDQ,U,6) W !,"This Distribution is Queued for Install with task number ",$P(XPDQ,U,6),!,"Don't forget to delete Taskman Task.",!
 W ! D ^DIR I 'Y!$D(DIRUT) D QUIT^XPDI1(XPDST) Q
 S XPD=0,DIK="^XPD(9.7,"
 ;need to kill the XTMP("XPDI") and the entry in the install file
 F  S XPD=$O(XPDT(XPD)) Q:'XPD  S DA=+XPDT(XPD) D ^DIK K ^XTMP("XPDI",DA)
 ;check if Out-Of-Order setname is defined, kill it
 I $D(^XTMP("XQOO",$P(XPDQ,U))) K ^($P(XPDQ,U))
 D QUIT^XPDI1(XPDST)
 Q
EN2 ;convert
 N %,DA,DIK,DIR,DIRUT,X,XPD,XPDBLD,XPDI,XPDNM,XPDPKG,XPDPMT,XPDST,XPDT,XPDQUIT,Y
 S XPDI=$$LOOK^XPDI1("I '$P(^(0),U,9),$D(^XPD(9.7,""ASP"",Y,1,Y))") Q:'XPDI
 K XPDT("DA"),XPDT("NM")
 ;make sure transport globals exist
 S XPDT=0 F  S XPDT=$O(XPDT(XPDT)) Q:'XPDT  D
 .S Y=+XPDT(XPDT) Q:$D(^XTMP("XPDI",Y))
 .W !,$P(XPDT(XPDT),U,2),"   ** Transport Global doesn't exist **",$C(7)
 .K XPDT(XPDT) S XPDQUIT=1
 I $D(XPDT)'>9!$D(XPDQUIT) D QUIT^XPDI1(XPDI) Q
 S DIR(0)="Y",DIR("A")="Want to make the Transport Globals Permanent",DIR("B")="NO"
 S DIR("?",1)="YES will leave the Transport Global so you can transport this TG in multiple Distributions."
 S DIR("?")="NO will remove the Transport Global after you transport this TG in the next Distribution."
 D ^DIR I $D(DIRUT) D QUIT^XPDI1(XPDI) Q
 S XPDPMT=Y,DIR("A")="Want to continue with the Conversion of the Package(s)",DIR("B")="NO"
 S DIR("?",1)="YES will convert the Packages to globals that can be transported.",DIR("?")="An entry will be added to the Build file and the entry in the Install file will be deleted."
 D ^DIR I 'Y!$D(DIRUT) Q
 S XPDT=0,DIK="^XPD(9.7,"
 F  S XPDT=$O(XPDT(XPDT)) Q:'XPDT  D  Q:$D(XPDQUIT)
 .;kill Install file entry
 .S XPDA=+XPDT(XPDT),XPDNM=$P(XPDT(XPDT),U,2),XPDBLD=$O(^XTMP("XPDI",XPDA,"BLD",0)),XPDPKG=+$O(^XTMP("XPDI",XPDA,"PKG",0))
 .;resolve the Package file link
 .D:XPDPKG
 ..N DIC,X,Y
 ..S DIC="^DIC(9.4,",DIC(0)="X",X=$P(^XTMP("XPDI",XPDA,"PKG",XPDPKG,0),U)
 ..D ^DIC I Y<0 S XPDPKG=0 Q
 ..S XPDPKG=+Y
 ..Q
 .S DA=$$BLD^XPDIP(XPDBLD) D:DA
 ..K ^XTMP("XPDT",DA)
 ..;check that component files exists
 ..S Y=$O(^XTMP("XPDI",XPDA,"BLD",0)),X=0 I Y F  S X=+$O(^XTMP("XPDI",XPDA,"BLD",Y,"KRN",X)) Q:'X  D
 ...;if file doesn't exist, kill it and 'B' x-ref
 ...I '$D(^DIC(X,0)) K ^XTMP("XPDI",XPDA,"BLD",Y,"KRN",X),^("B",X)
 ...Q
 ..S ^XTMP("XPDT",DA)=XPDPMT M ^XTMP("XPDT",DA)=^XTMP("XPDI",XPDA)
 ..Q
 .I 'DA W !,XPDNM,"   ** Couldn't add to Build file **" S XPDQUIT=1 Q
 .;kill Install file entry
 .S DA=XPDA D ^DIK
 .K ^XTMP("XPDI",XPDA)
 ;set expiration date to 1 year if global should be permanent, else 30
 S ^XTMP("XPDT",0)=$$FMADD^XLFDT(DT,$S(XPDPMT:365,1:30))_U_DT
 D QUIT^XPDI1(XPDI)
 W !,"  ** DONE **",!
 Q
