XPDT ;SFISC/RSD - Transport a package ;02/12/2009
 ;;8.0;KERNEL;**2,10,28,41,44,51,58,66,68,85,100,108,393,511,539,547**;Jul 10, 1995;Build 15
 ;Per VHA Directive 2004-038, this routine should not be modified.
EN ;build XTMP("XPDT",ien, XPDA=ien,XPDNM=name
 ;XPDT(seq #)=ien^name^1=use current transport global on system
 ;XPDT("DA",ien)=seq #
 ;XPDVER=version number^package name
 ;XPDGP=flag;global^flag;global^...  flag=1 replace global at site
 N DIR,DIRUT,I,POP,XPD,XPDA,XPDERR,XPDGP,XPDGREF,XPDH,XPDH1,XPDHD,XPDI,XPDNM,XPDSEQ,XPDSIZ,XPDSIZA,XPDT,XPDTP,XPDVER
 N DUOUT,DTOUT,XPDFMSG,X,Y,Z,Z1
 K ^TMP($J,"XPD")
 S XPD="First Package Name: ",DIR(0)="Y",DIR("A")="   Use this Transport Global",DIR("?")="Yes, will use the current Transport Global on your system. No, will create a new one.",XPDT=0
 W !!,"Enter the Package Names to be transported. The order in which",!,"they are entered will be the order in which they are installed.",!!
 F  S XPDA=$$DIC^XPDE("AEMQZ",XPD) Q:'XPDA  D  Q:$D(DIRUT)!$D(XPDERR)
 .S:'XPDT XPD="Another Package Name: "
 .;XPDI=name^1=use current transport global
 .S XPDI=$P(Y(0),U)_"^"
 .I $D(XPDT("DA",XPDA)) W "   ",$P(Y(0),U)," already listed",! Q
 .;if type is Global Package, set DIRUT if there is other packages
 .I $P(Y(0),U,3)=2 W "   GLOBAL PACKAGE" D  Q
 ..;if there is already a package in distribution, abort
 ..I XPDT S DIRUT=1 W !,"A GLOBAL PACKAGE cannot be sent with any other packages" Q
 ..I $D(^XTMP("XPDT",XPDA)) W "  **Cannot have a pre-existing Transport Global**" S DIRUT=1 Q
 ..W !?10,"will transport the following globals:",! S X=0,XPDGP=""
 ..F  S X=$O(^XPD(9.6,XPDA,"GLO",X)) Q:'X  S Z=$G(^(X,0)) I $P(Z,U)]"" S XPDGP=XPDGP_($P(Z,U,2)="y")_";"_$P(Z,U)_"^" W ?12,$P(Z,U),!
 ..;XPDERR is set to quit loop, so no other packages can be added
 ..S XPDERR=1,XPDT=XPDT+1,XPDT(XPDT)=XPDA_U_XPDI,XPDT("DA",XPDA)=XPDT
 .Q:$D(XPDERR)
 .D PCK(XPDA,XPDI)
 .;multi-package
 .Q:$P(Y(0),U,3)'=1
 .W "   (Multi-Package)" S X=0
 .I XPDT>1 S DIRUT=1 W !,"A Master Build must be the first/only package in a transport" Q
 .F  S X=$O(^XPD(9.6,XPDA,10,X)) Q:'X  S Z=$P($G(^(X,0)),U),Z1=$P($G(^(0)),U,2) D:Z]""
 ..N XPDA,X
 ..W !?3,Z S XPDA=$O(^XPD(9.6,"B",Z,0))
 ..I 'XPDA W "  **Can't find definition in Build file**" Q
 ..I $D(XPDT("DA",XPDA)) W "  already listed" Q
 ..D PCK(XPDA,Z,Z1)
 .S XPDERR=1 ;XPDERR is set to quit loop, so no other packages can be added
 .Q
 G:'XPDT!$D(DIRUT) QUIT K XPDERR
 W !!,"ORDER   PACKAGE",!
 F XPDT=1:1:XPDT S Y=$P(XPDT(XPDT),U,2) W ?2,XPDT,?7,Y D  W !
 .W:$P(XPDT(XPDT),U,3) "     **will use current Transport Global**"
 .;check if New Version and single package, has Package File Link, Package App. History
 .Q:Y["*"!'$$PAH(+XPDT(XPDT))
 .S DIR(0)="Y",DIR("A")="Send the PATCH APPLICATION HISTORY from the PACKAGE file",DIR("B")="YES"
 .W !! D ^DIR I 'Y S $P(XPDT(XPDT),U,5)=1
 S DIR(0)="Y",DIR("A")="OK to continue",DIR("B")="YES",XPDH=""
 W !! D ^DIR G:$D(DIRUT)!'Y QUIT K DIR
 I $G(XPDTP),XPDT>1 W !!,"You cannot send multiple Builds through PackMan."
 S DIR(0)="SAO^HF:Host File"_$S(XPDT=1:";PM:PackMan",1:"")
 S DIR("A")="Transport through (HF)Host File"_$S(XPDT=1:" or (PM)PackMan: ",1:": ")
 S DIR("?")="Enter the method of transport for the package(s)."
 D ^DIR G:$D(DTOUT)!$D(DUOUT) QUIT K DIR
 I Y="" W !,"No Transport Method selected, will only write Transport Global to ^XTMP." S XPDH=""
 ;XPDTP = transports using Packman
 S:Y="PM" XPDTP=1
 I $D(XPDGP),Y'="HF" W !,"**Global Package can only be sent with a Host File, Transport ABORTED**" Q
 I Y="HF" D DEV G:POP QUIT
 W !!
 F XPDT=1:1:XPDT S XPDA=XPDT(XPDT),XPDNM=$P(XPDA,U,2) D  G:$D(XPDERR) ABORT
 .W !?5,XPDNM,"..." S XPDGREF="^XTMP(""XPDT"","_+XPDA_",""TEMP"")"
 .;if using current transport global, run pre-transp routine and quit
 .I $P(XPDA,U,3) S XPDA=+XPDA D PRET Q
 .;if package file link then set XPDVER=version number^package name
 .S XPDA=+XPDA,XPDVER=$S($P(^XPD(9.6,XPDA,0),U,2):$$VER^XPDUTL(XPDNM)_U_$$PKG^XPDUTL(XPDNM),1:"")
 .;Inc the Build number
 .S $P(^XPD(9.6,XPDA,6.3),U)=$G(^XPD(9.6,XPDA,6.3))+1
 .K ^XTMP("XPDT",XPDA)
 .;GLOBAL PACKAGE
 .I $D(XPDGP) D  S XPDT=1 Q
 ..;can't send global package in packman message
 ..I $G(XPDTP) S XPDERR=1 Q
 ..;verify global package
 ..I '$$GLOPKG^XPDV(XPDA) S XPDERR=1 Q
 ..;get Environment check and Post Install routines
 ..F Y="PRE","INIT" I $G(^XPD(9.6,XPDA,Y))]"" S X=^(Y) D
 ...S ^XTMP("XPDT",XPDA,Y)=X,X=$P(X,U,$L(X,U)),%=$$LOAD^XPDTA(X,"0^")
 ..D BLD^XPDTC,PRET
 .F X="DD^XPDTC","KRN^XPDTC","QUES^XPDTC","INT^XPDTC","BLD^XPDTC" D @X Q:$D(XPDERR)
 .D:'$D(XPDERR) PRET
 ;XPDTP - call ^XPDTP to build Packman message
 I $G(XPDTP) S XPDA=+XPDT(XPDT) D ^XPDTP G QUIT
 I $L(XPDH) D GO G QUIT
 ;if no device then just create transport global
 W !! F XPDT=1:1:XPDT W "Transport Global ^XTMP(""XPDT"","_+XPDT(XPDT)_") created for ",$P(XPDT(XPDT),U,2),!
 Q
DEV N FIL,DIR,IOP,X,Y,%ZIS W !
 D HOME^%ZIS
 S DIR(0)="F^3:245",DIR("A")="Enter a Host File",DIR("?")="Enter a filename and/or path to output package(s).",POP=0
 D ^DIR I $D(DTOUT)!$D(DUOUT) S POP=1 Q
 ;if no file, then quit
 Q:Y=""  S FIL=Y
 S DIR(0)="F^3:80",DIR("A")="Header Comment",DIR("?")="Enter a comment between 3 and 80 characters."
 D ^DIR I $D(DIRUT) S POP=1 Q
 S XPDH=Y,%ZIS="",%ZIS("HFSNAME")=FIL,%ZIS("HFSMODE")="W",IOP="HFS",(XPDSIZ,XPDSIZA)=0,XPDSEQ=1
 D ^%ZIS I POP W !!,"**Incorrect Host File name**",!,$C(7) Q
 ;write date and comment header
 S XPDHD="KIDS Distribution saved on "_$$HTE^XLFDT($H)
 U IO W $$SUM(XPDHD),!,$$SUM(XPDH),!
 S XPDFMSG=1 ;Send mail to forum of routines in HFS.
 ;U IO(0) is to insure I am writing to the terminal
 U IO(0) Q
 ;
GO S I=1,Y="",XPDH1="**KIDS**:" U IO
 ;Global Package, header is different and there is only 1 package
 I $D(XPDGP) W $$SUM("**KIDS**GLOBALS:"_$P(XPDT(1),U,2)_U_XPDGP),! G GO1
 ;write header that maintains package list, keep less than 255 char
 F  D  W $$SUM(XPDH1_Y),! Q:I=XPDT  S Y="",I=I+1,XPDH1="**KIDS**"
 .F I=I:1 S Y=Y_$P(XPDT(I),U,2)_"^" Q:$L(Y)>200!(I=XPDT)
 ;after the package list write an extra line feed
GO1 W ! S XPDSIZA=XPDSIZA+2
 N XMSUB,XMY,XMTEXT
 ;loop thru & write global, don't kill if set to permanent, set in XPDIU
 F XPDT=1:1:XPDT S XPDA=+XPDT(XPDT),XPDNM=$P(XPDT(XPDT),U,2) D GW,XM K:'$G(^XTMP("XPDT",XPDA)) ^(XPDA)
 W "**END**",!
 ;GLOBAL PACKAGE there could only be one package, write globals
 I $D(XPDGP) D GPW W "**END**",!
 ;we're done with device, close it
 W "**END**",! D ^%ZISC
 W !!,"Package Transported Successfully",!
 Q
GW ;global write
 N GR,GCK,GL
 S GCK="^XTMP(""XPDT"","_XPDA,GR=GCK_")",GCK=GCK_",",GL=$L(GCK)
 ;INSTALL NAME line will mark the beginning of global for all lines until
 ;the next INSTALL NAME
 W $$SUM("**INSTALL NAME**",1),!,$$SUM(XPDNM),!
 F  Q:$D(DIRUT)  S GR=$Q(@GR) Q:GR=""!($E(GR,1,GL)'=GCK)  W $$SUM($P(GR,GCK,2),1),!,$$SUM(@GR),!
 Q
XM ;Send HFS checksum message
 Q:'$G(XPDFMSG)
 N XMTEXT,C,RN,RN2,X,X2
 K ^TMP($J)
 S XMSUB="**KIDS** Checksum for "_XPDNM,XMTEXT="^TMP($J)"
 I $G(^XMB("NETNAME"))["domain.ext" S XMY("S.A1AE HFS CHKSUM SVR@FORUM.domain.ext")=""
 E  S X=$$GET^XPAR("PKG","XPD PATCH HFS SERVER",1,"Q") S:$L(X) XMY(X)=""
 I '$D(XMY) Q  ;No one to send it to.
 S C=1,@XMTEXT@(1,0)="~~1:"_XPDNM
 I XPDT=1,$O(XPDT(1)) D
 . S RN=1 F  S RN=$O(XPDT(RN)) Q:'RN  S C=C+1,@XMTEXT@(C,0)="~~2:"_$P(XPDT(RN),"^",2)
 S (RN,RN2)="" ;Send full RTN node
 F  S RN=$O(^XTMP("XPDT",XPDA,"RTN",RN)) Q:'$L(RN)  S X=^(RN),X2=$G(^(RN,2,0)) D
 . S C=C+1,@XMTEXT@(C,0)="~~3:"_RN_"^"_X_"^"_$P(X2,";",5)
 . I RN2="",$E(X2,1,3)=" ;;" S RN2=$P(X2,"**",1)_"**[Patch List]**"_$P(X2,"**",3)
 S C=C+1,@XMTEXT@(C,0)="~~4:"_RN2
 S C=C+1,@XMTEXT@(C,0)="~~8:"_$G(^XMB("NETNAME"))
 S C=C+1,@XMTEXT@(C,0)="~~9:Save"
 S XMTEXT="^TMP($J,"
 D ^XMD
 Q
GPW ;global package write
 N I,G,GR,GCK,GL
 W !
 F I=1:1 S G=$P(XPDGP,U,I) Q:G=""  D
 .S GR="^"_$P(G,";",2),GCK=$S(GR[")":$E(GR,1,$L(GR)-1)_",",1:GR_"("),GL=$L(GCK)
 .;GLOBAL line will mark the beginning of global for all lines until
 .;the next GLOBAL
 .W $$SUM("**GLOBAL**",1),!,$$SUM(GR),!
 .F  Q:$D(DIRUT)  S GR=$Q(@GR) Q:GR=""!($E(GR,1,GL)'=GCK)  W $$SUM($P(GR,GCK,2),1),!,$$SUM(@GR),!
 Q
QUIT F XPDT=1:1:XPDT L -^XPD(9.6,+XPDT(XPDT))
 Q
ABORT W !!,"**TRANSPORT ABORTED**",*7
 D QUIT
 F XPDT=1:1:XPDT K ^XTMP("XPDT",+XPDT(XPDT))
 ;if HF, save file name IO into XPDH
 S:$L(XPDH) XPDH=IO
 D ^%ZISC
 ;if HF, then delete file
 I $L(XPDH),$$DEL1^%ZISH(XPDH) W !,"File:  ",XPDH,"  (Deleted)"
 Q
 ;
PCK(XPDA,XPDNM,XPDREQ) ;XPDA=Build ien, XPDNM=Build name, XPDREQ=Required
 N Y
 S XPDT=XPDT+1,XPDT(XPDT)=XPDA_U_XPDNM,XPDT("DA",XPDA)=XPDT
 S:'$G(XPDREQ) XPDREQ=0
 S $P(XPDT(XPDT),U,4)=XPDREQ
 Q:'$D(^XTMP("XPDT",XPDA))  S Y=$G(^(XPDA))
 W "     **Transport Global exists**"
 ;Y=1 if TG is permanent
 I Y S $P(XPDT(XPDT),U,3)=1 Q
 ;ask if they want to use TG
 D ^DIR S $P(XPDT(XPDT),U,3)=Y
 Q
 ;
SUM(X,Z) ;X=string to write, Z 0=don't check size
 S XPDSIZA=XPDSIZA+$L(X)+2
 Q X
 ;
PAH(XPDA) ;check for PATCH APPLICATION HISTORY in Package file
 N Y,Z
 S Y=^XPD(9.6,XPDA,0),Z=$$VER^XPDUTL($P(Y,U))
 ;Single Package, Version multiple, PAH multiple
 I $P(Y,U,3)=0,$D(^DIC(9.4,+$P(Y,U,2),22)),Z S Z=$O(^(22,"B",Z,0)) I Z,$O(^DIC(9.4,+$P(Y,U,2),22,Z,"PAH",0)) Q 1
 Q 0
 ;
PRET ;Pre-Transport Routine
 N Y,Z
 S Y=$G(^XPD(9.6,XPDA,"PRET")) Q:Y=""
 I '$$RTN^XPDV(Y,.Z) W !!,"Pre-Transportation Routine ",Y,Z,*7 Q
 S Y=$S(Y["^":Y,1:"^"_Y) W !,"Running Pre-Transportation Routine ",Y
 D @Y Q
 ;
 ;
 ;FROM DEV
 ;if MSM and HFS file is on device A or B, then get size for floppy disk
 ;XPDSIZ=disk size, XPDSIZA=accummulated size,XPDSEQ=disk sequence number
 I ^%ZOSF("OS")["MSM",FIL?1(1"A",1"B")1":"1.E D  Q:POP
 .S DIR(0)="N^0:5000",DIR("A")="Size of Diskette (1K blocks)",DIR("B")=1400,DIR("?")="Enter the number of 1K blocks which each diskette will hold, 0 means unlimited space"
 .D ^DIR I $D(DIRUT) S POP=1 Q
 .S XPDSIZ=$S(Y:Y*1024,1:0)
 ;FROM SUM
 ;ask for next disk
 ;this code is for MSM system only
 I $G(Z),XPDSIZ,XPDSIZ-XPDSIZA<1024 D
 .;write continue flag at end of this file
 .W "**CONTINUE**",!,"**END**",!
 .;should call %ZIS HFS utilities to close and open file
 .X "C IO" U IO(0)
 .N DIR,G,GR,GCK,GL,I,X,Y
 .W !!,"Diskette #",XPDSEQ," is full."
 .S DIR(0)="E",DIR("A")="Insert the next diskette and Press the return key",DIR("?")="The current diskette is full, insert a new diskette to continue."
 .;$D(DIRUT)=the user aborted the distribution
 .D ^DIR I $D(DIRUT) D ABORT Q
 .W ! S XPDSEQ=XPDSEQ+1,XPDSIZA=0
 .;MSM specific code to open HFS
 .X "O IO:IOPAR" U IO
 .W $$SUM("Continuation #"_XPDSEQ_" of "_XPDHD),!,$$SUM(XPDH),!,$$SUM("**SEQ**:"_XPDSEQ),!!
 .S XPDSIZA=XPDSIZA+2
