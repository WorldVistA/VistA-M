XPDT ;SFISC/RSD - Transport a package ;02/12/2009
 ;;8.0;KERNEL;**2,10,28,41,44,51,58,66,68,85,100,108,393,511,539,547,672,713**;Jul 10, 1995;Build 15
 ;Per VHA Directive 2004-038, this routine should not be modified.
EN ;build XTMP("XPDT",ien, XPDA=ien,XPDNM=name
 ;XPDT(seq #)=ien^name^1=use current transport global^required in multi-package^don't send PAH^Version#
 ;XPDT("DA",ien)=seq #^build type
 ;XPDVER=version number^package name
 ;XPDGP=flag;global^flag;global^...  flag=1 replace global at site
 N DIR,DIRUT,I,POP,XPD,XPDA,XPDA0,XPDERR,XPDGP,XPDGREF,XPDH,XPDH1,XPDHD,XPDI,XPDNM,XPDSEQ,XPDSIZ,XPDSIZA,XPDT,XPDTP,XPDVER
 N DUOUT,DTOUT,XPDFMSG,X,Y,Z,Z1
 K ^TMP($J,"XPD")
 S XPD="First Package Name: ",DIR(0)="Y",DIR("A")="   Use this Transport Global",DIR("?")="Yes, will use the current Transport Global on your system. No, will create a new one.",XPDT=0
 W !!,"Enter the Package Names to be transported. The order in which",!,"they are entered will be the order in which they are installed.",!!
 F  S XPDA=$$DIC^XPDE("AEMQZ",XPD) Q:'XPDA  D  Q:$D(DIRUT)!$D(XPDERR)
 .S XPDA0=Y(0)
 .S:'XPDT XPD="Another Package Name: "
 .;XPDI=name^1=use current transport global
 .S XPDI=$P(XPDA0,U)_"^"
 .I $D(XPDT("DA",XPDA)) W "   ",$P(XPDI,U)," already listed",! Q
 .;if type is Global Package, set DIRUT if there is other packages
 .I $P(XPDA0,U,3)=2 W "   GLOBAL PACKAGE" D  Q
 ..;if there is already a package in distribution, abort
 ..I XPDT S DIRUT=1 W !,"A GLOBAL PACKAGE cannot be sent with any other packages" Q
 ..I $D(^XTMP("XPDT",XPDA)) W "  **Cannot have a pre-existing Transport Global**" S DIRUT=1 Q
 ..W !?10,"will transport the following globals:",! S X=0,XPDGP=""
 ..F  S X=$O(^XPD(9.6,XPDA,"GLO",X)) Q:'X  S Z=$G(^(X,0)) I $P(Z,U)]"" S XPDGP=XPDGP_($P(Z,U,2)="y")_";"_$P(Z,U)_"^" W ?12,$P(Z,U),!
 ..;XPDERR is set to quit loop, so no other packages can be added
 ..S XPDERR=1,XPDT=XPDT+1,XPDT(XPDT)=XPDA_U_XPDI,XPDT("DA",XPDA)=XPDT_U_2
 .Q:$D(XPDERR)
 .D PCK(XPDA,XPDI,,XPDA0)
 .;multi-package
 .Q:$P(XPDA0,U,3)'=1
 .W "   (Multi-Package)" S X=0
 .I XPDT>1 S DIRUT=1 W !,"A Master Build must be the first/only package in a transport" Q
 .F  S X=$O(^XPD(9.6,XPDA,10,X)) Q:'X  S Z=$P($G(^(X,0)),U),Z1=$P($G(^(0)),U,2) D:Z]""
 ..N XPDA,XPDA0,X
 ..W !?3,Z S XPDA=$O(^XPD(9.6,"B",Z,0)),XPDA0=$G(^XPD(9.6,XPDA,0))
 ..I 'XPDA!(XPDA0="") W "  **Can't find definition in Build file**" Q
 ..I $D(XPDT("DA",XPDA)) W "  already listed" Q
 ..D PCK(XPDA,Z,Z1,XPDA0)
 .S XPDERR=1 ;XPDERR is set to quit loop, so no other packages can be added
 .Q
 G:'XPDT!$D(DUOUT) QUIT K XPDERR
 ;XPDH=Header comment, XPDTP=transport method: 1=PM, 0=HF
 S (XPDH,XPDTP)=""
 ;XPDH=header comment, will be return from DISP ;p713
 F  D DISP Q:$D(DIRUT)
 G:$D(DUOUT) QUIT
 ;XPDT>1 (more than one package) or $P(XPDA0,U,3) multi-package) can only use HF 
 I XPDT=1,'$P(XPDA0,U,3) D  G:$D(DTOUT)!$D(DUOUT) QUIT
 .S DIR(0)="SAO^HF:Host File;PM:PackMan",DIR("A")="Transport through (HF)Host File or (PM)PackMan: "
 .S DIR("?")="Enter the method of transport for the package(s)."
 .D ^DIR S:Y="PM" XPDTP=1 S:Y="" XPDH=""
 .K DIR
 .Q
 ;single package, no transport method, no header comment
 I XPDT=1,'XPDTP,XPDH="" W !,"No Transport Method selected, will only write Transport Global to ^XTMP."
 ;XPDTP = 1-transports using Packman, can't be GP or multiple builds
 I 'XPDTP,XPDH]"" D DEV G:POP QUIT
 W !!
 F XPDT=1:1:XPDT S XPDA=XPDT(XPDT),XPDNM=$P(XPDA,U,2) D  G:$D(XPDERR) ABORT
 .W !?5,XPDNM,"..." S XPDGREF="^XTMP(""XPDT"","_+XPDA_",""TEMP"")"
 .;if using current transport global, run pre-transp routine and quit
 .I $P(XPDA,U,3) S XPDA=+XPDA D PRET Q
 .;if package file link then set XPDVER=version number^package name
 .S XPDA=+XPDA,XPDVER=$S($P(^XPD(9.6,XPDA,0),U,2):$$VER^XPDUTL(XPDNM)_U_$$PKG^XPDUTL(XPDNM),1:"")
 .;Increment and set the Build number and set Build version #
 .S $P(^XPD(9.6,XPDA,6.3),U)=$G(^XPD(9.6,XPDA,6.3))+1,$P(^XPD(9.6,XPDA,6),U)=$P(XPDT(XPDT),U,6)
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
 S DIR(0)="F^3:200",DIR("A")="Header Comment",DIR("?")="Enter a comment between 3 and 200 characters.",DIR("B")=XPDH
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
 I $G(^XMB("NETNAME"))["DOMAIN.EXT" S XMY("S.A1AE HFS CHKSUM SVR@DOMAIN.EXT")=""
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
PCK(XPDA,XPDNM,XPDREQ,XPDA0) ;XPDA=Build ien, XPDNM=Build name, XPDREQ=Required, XPDA0=Y(0) ^XPD(9.6,XPDA,0)
 N Y,Z
 S XPDT=XPDT+1,XPDT(XPDT)=XPDA_U_XPDNM,XPDT("DA",XPDA)=XPDT_"^"_$P(XPDA0,U,3)
 ;get TEST# and increment ;p713
 S Z=+$G(^XPD(9.6,XPDA,6)),Z=Z+1,$P(XPDT(XPDT),U,6)=Z
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
 D @Y
 Q
 ;
DISP ;display packages, RETURN: DIRUT  ;p713
 N DIR,X,Y
 W !!,"ORDER    PACKAGE",?25,"VERSION #",!
 F XPDT=1:1:XPDT W ?2,XPDT,?9,$P(XPDT(XPDT),U,2),?28,$P(XPDT(XPDT),U,6) D  W !
 .W:$P(XPDT(XPDT),U,3) ?25,"       **will use current Transport Global**"
 .;check if New and single package, has Package File Link, Package App. History
 .I $P(XPDT(XPDT),U,2)["*"!'$$PAH(+XPDT(XPDT))!($P(XPDT(XPDT),U,5)) Q
 .S DIR(0)="Y",DIR("A")="Send the PATCH APPLICATION HISTORY from the PACKAGE file",DIR("B")="YES"
 .W !! D ^DIR I 'Y S $P(XPDT(XPDT),U,5)=1
 .Q
 S DIR(0)="SA^C:Continue;E:Edit Version #;Q:Quit",DIR("A")="Do you want to (C)ontinue, (E)dit Version #, (Q)uit: ",DIR("B")="C"
 W ! D ^DIR
 I Y="C" D  S DIRUT=1 Q
 .N DIC,I,J,Y
 .S I=XPDT,J=""
 .F I=1:1:XPDT S J=J_$P(XPDT(I),U,2)_" v"_$P(XPDT(I),U,6)_$S(I<XPDT:", ",1:"")
 .S XPDH=J
 .Q
 I $D(DIRUT)!(Y="Q") S DIRUT=1,DUOUT=1 Q
 ;edit of Version # ;p713
 F  D  I $D(DIRUT) K DIRUT Q
 .K DIR
 .S DIR(0)="NOA^1:"_XPDT,DIR("A")="Enter the ORDER number or <CR> when done: "
 .W ! D ^DIR I $D(DIRUT)!(Y="") Q
 .S Z=Y,DIR("B")=$P(XPDT(Z),U,6),DIR(0)="NA^1:9999",DIR("A")="Version #: "
 .D ^DIR I Y S $P(XPDT(Z),U,6)=Y
 .Q
 Q
 ;
