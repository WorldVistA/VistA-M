PSOLSET ;BHAM ISC/SAB - site parameter set up ;12/03/92
VERS ;;7.0;OUTPATIENT PHARMACY;**10,22,32,40,120,247**;DEC 1997;Build 18
 ;Reference to ^PS(59.7 supported by DBIA 694
 ;Reference to ^PSX(550 supported by DBIA 2230
 ;Reference to ^%ZIS(2 supported by DBIA 3435
 ;
 I '$D(DUZ) W !,$C(7),"DUZ Number must be defined !!",! G LEAVE
 W !,"Outpatient Pharmacy software - Version "_$P($T(VERS),";",3)
 I $D(^XTMP("PSO_V7 INSTALL",0)) W !!,"Outpatient Pharmacy software is being installed.  PLEASE TRY LATER!",! G LEAVE
 S PSOBAR1="",PSOBARS=0 ;make sure we have one
 S PSOCNT=0 F I=0:0 S I=$O(^PS(59,I)) Q:'I  S PSOCNT=PSOCNT+1,Y=I
 G DIV1:PSOCNT W !,$C(7) S DIR("A",1)="Site parameters must be specified for at least one site."
 S DIR("A",2)="This is usually done by the package Co-ordinator.",DIR("A")="Do you want to continue:  ",DIR("B")="YES",DIR(0)="SA^Y:YES;N:NO",DIR("?")="Enter Y to edit site parameters or N to exit." D ^DIR
 G LEAVE:"Y"'[$E(X)
 W ! D ^PSOSITED G PSOLSET
DIV1 G:PSOCNT=1 DIV3 S DIR(0)="Y",DIR("?")="Enter 'Y' to select Division or 'N' to EXIT"
DIV2 I PSOCNT>1 W ! S DIC("A")="Division: ",DIC=59,DIC(0)="AEMQ"
 S:$G(PSOVEX)'=1 DIC("S")="I $S('$D(^PS(59,+Y,""I"")):1,'^(""I""):1,DT'>^(""I""):1,1:0)"
 D ^DIC K DIC G:$D(DUOUT)!($D(DTOUT)) LEAVE
 I +Y<0 W $C(7),! S DIR("A",1)="A 'DIVISION' must be selected!",DIR("A")="Do you want to try again",DIR("B")="YES" D ^DIR G:'Y LEAVE G DIV2
DIV3 K DIR S PSOSITE=+Y W:PSOCNT>1 !!?10,"You are logged on under the ",$P(^PS(59,PSOSITE,0),"^")," division.",! S PSOPAR=$G(^PS(59,PSOSITE,1)),PSOPAR7=$G(^PS(59,PSOSITE,"IB")),PSOSYS=$G(^PS(59.7,1,40.1)) D CUTDATE^PSOFUNC
 S PSOPINST=$P($G(^PS(59,PSOSITE,"INI")),"^")
 S (SITE,DA)=$P(^XMB(1,1,"XUS"),"^",17),DIC="4",DIQ(0)="IE",DR=".01;99",DIQ="PSXUTIL" D EN^DIQ1 S S3=$G(PSXUTIL(4,SITE,99,"I")),S2=$G(PSXUTIL(4,SITE,.01,"E")) K DA,DIC,DIQ(0),DR
 S PSXSYS=+$O(^PSX(550,"C",""))_"^"_$G(S3)_"^"_$G(S2),PSOINST=S3
 K S3,S2,S1,PSXUTIL
 I $G(PSXSYS) D
 .K:($P($G(^PSX(550,+PSXSYS,0)),"^",2)'="A") PSXSYS
 .S Y=$$VERSION^XPDUTL("PSO") I Y>6.0 S PSXVER=1
 E  K PSXSYS
 S PSODIV=$S(($P(PSOSYS,"^",2))&('$P(PSOSYS,"^",3)):0,1:1)
 I $D(DUZ),$D(^VA(200,+DUZ,0)) S PSOCLC=DUZ
PLBL I $P(PSOPAR,"^",8) D
 .S %ZIS="MNQ",%ZIS("A")="Select PROFILE PRINTER: " S:$G(PSOCLBL)&($D(PSOPROP)) %ZIS("B")=PSOPROP
 .D ^%ZIS K %ZIS,IO("Q"),IOP Q:POP  S PSOPROP=ION D ^%ZISC
LBL S %ZIS="MNQ",%ZIS("A")="Select LABEL PRINTER: " S:$G(PSOCLBL)&($D(PSOLAP))!($G(SUSPT)) %ZIS("B")=$S($G(SUSPT):PSLION,1:PSOLAP)
 D ^%ZIS K %ZIS,IO("Q"),IOP S:POP PSOQUIT=1 G:POP EXIT S @$S($G(SUSPT):"PSLION",1:"PSOLAP")=ION,PSOPIOST=$G(IOST(0))
 N PSOIOS S PSOIOS=IOS D DEVBAR^PSOBMST
 S PSOBARS=PSOBAR1]""&(PSOBAR0]"")&$P(PSOPAR,"^",19),PSOIOS=IOS D ^%ZISC
LASK I $G(PSOPIOST),$D(^%ZIS(2,PSOPIOST,55,"B","LL")) G EXIT
 K DIR S DIR("A")="OK to assume label alignment is correct",DIR("B")="YES",DIR(0)="Y",DIR("?")="Enter Y if labels are aligned, N if they need to be aligned." D ^DIR S:$D(DIRUT) PSOQUIT=1 G:Y!($D(DIRUT)) EXIT
P2 S IOP=$G(PSOLAP) D ^%ZIS K IOP I POP W $C(7),!?5,"Printer is busy.",! G LASK
 U IO(0) W !,"Align labels so that a perforation is at the top of the",!,"print head and the left side is at column zero."
 W ! K DIR,DIRUT,DUOUT,DTOUT S DIR(0)="E" D ^DIR K DIR,DTOUT,DUOUT Q:$D(DIRUT)  D ^PSOLBLT D ^%ZISC
 K DIRUT,DIR S DIR("A")="Is this correct",DIR("B")="YES",DIR(0)="Y",DIR("?")="Enter Y if labels are aligned correctly, N if they need to be aligned." D ^DIR S:$D(DIRUT) PSOQUIT=1 G:Y!($D(DIRUT)) EXIT
 G P2
LEAVE S XQUIT="" G FINAL
Q W !?10,$C(7),"Default printer for labels must be entered." G LBL
 ;
EXIT D ^%ZISC Q:$G(PSOCLBL)
 D:'$G(PSOBFLAG) GROUP K I,IOP,X,Y,%ZIS,DIC,J,DIR,X,Y,DTOUT,DIROUT,DIRUT,DUOUT Q
 ;
FINAL ;exit action from main menu - kill and quit
 K SITE,PSOCP,PSNP,PSL,PRCA,PSLION,PSOPINST
 K GROUPCNT,DISGROUP,PSOCAP,PSOINST,PSOION,PSONULBL,PSOSITE7,PFIO,PSOIOS,X,Y,PSOSYS,PSODIV,PSOPAR,PSOPAR7,PSOLAP,PSOPROP,PSOCLC,PSOCNT
 K PSODTCUT,PSOSITE,PSOPRPAS,PSOBAR1,PSOBAR0,PSOBARS,SIG,DIR,DIRUT,DTOUT,DIROUT,DUOUT,I,%ZIS,DIC,J,PSOREL
 Q
GROUP ;display group
 S GROUPCNT=0,AGROUP="" I $D(^PS(59.3,0)) F  S AGROUP=$O(^PS(59.3,"B",AGROUP)) Q:AGROUP=""  D
 .S GROUPCNT=GROUPCNT+1 I GROUPCNT=1 S AGROUP1=AGROUP
 S:GROUPCNT=1 GRPNME=AGROUP1,II="" G:GROUPCNT>1 GROUP1
 Q:'$D(GRPNME)  F  S II=$O(^PS(59.3,"B",GRPNME,II)) Q:II=""  S DISGROUP=II
 K AGROUP,AGROUP1,GRPNME,II
 Q
GROUP1 W ! S DIC("A")="Bingo Board Display: ",DIC=59.3,DIC(0)="AEMQZ",DIR(0)="Y",DIR("?")="Enter 'Y' to select Bingo Board Display or 'N' to EXIT"
 S:$P($G(^PS(59,PSOSITE,1)),"^",20) DIC("B")=$P($G(^PS(59,PSOSITE,1)),"^",20)
 D ^DIC K DIC Q:$D(DTOUT)!($D(DUOUT))
 I +Y<0 W $C(7) S DIR("A",1)="A 'BINGO BOARD DISPLAY' should be selected!",DIR("A")="Do you want to try again",DIR("B")="YES",DIR("?")="A display group must be defined in order to run Bingo Board." D ^DIR Q:"Y"'[$E(X)  G GROUP
 S DISGROUP=+Y
 K DIR,DIC,AGROUP,AGROUP1,GRPNME,II
 Q
