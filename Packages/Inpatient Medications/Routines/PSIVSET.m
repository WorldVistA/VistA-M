PSIVSET ;BIR/PR-IV PACKAGE ENTRY POINT ;12 DEC 97 / 9:18 AM 
 ;;5.0;INPATIENT MEDICATIONS;**35,81,91,407**;16 DEC 1997;Build 26
 ;
 ; Reference to ^PS(59.7 is supported by DBIA# 2181.
 ; 
 ; PSJ*407 - Liberty ITS/RJH - 08/22 - Significant modifications to prevent 
 ;           users from being allowed to update the IV Room file (#59.5)
 ;           without the PSJI MGR security key
 ;
 D NOW^%DTC S Y=%
 ;W !!,"INPATIENT MEDICATIONS (IV) (Version: ",$P($P($T(PSIVSET+1),";;",2)," ",1,2),")",!
ENOR ;
 S (PSIVCT,PSIVSN)=0 D NOW^%DTC F X=0:0 S X=$O(^PS(59.5,X)) Q:'X  D
 .I $S(+'$G(^PS(59.5,X,"I")):1,+$G(^PS(59.5,X,"I"))>%:1,1:0) S PSIVCT=PSIVCT+1 S PSIVSN=X
 I PSIVCT=1 D ENCHK I $D(%) S:%=-1!(%=2) XQUIT="" G:%=2!(%=-1) Q1
 ;I PSIVCT=1 S PSIVSN=$O(^PS(59.5,0)) D ENCHK I $D(%) S:%=-1!(%=2) XQUIT="" G:%=2!(%=-1) Q1
MULT ;
 ; PSJ*407/RJH - Begin changes
 ; I PSIVCT>1 K DIC S DIC="^PS(59.5,",DIC(0)="QEAM",DIC("S")="I $S($P($G(^(""I"")),U)="""":1,1:$P(^(""I""),U)>DT)" D ^DIC K DIC S:Y<0 XQUIT="" Q:Y<0  S PSIVSN=+Y D ENCHK I $D(%) G:%=2 MULT S:%=-1 XQUIT="" G:%=-1 Q1
 I PSIVCT>1 D
 . I '$D(^TMP("PSJUSER",$J,"FLAG")) D  Q
 .. K DIC S DIC="^PS(59.5,",DIC(0)="QEAM",DIC("S")="I $S($P($G(^(""I"")),U)="""":1,1:$P(^(""I""),U)>DT)" D ^DIC K DIC
 .. S:Y<0 XQUIT="" Q:Y<0
 .. S PSIVSN=+Y D ENCHK I $D(%) G:%=2 MULT S:%=-1 XQUIT="" G:%=-1 Q1
 .. Q
 . S PSIVSN=$G(^TMP("PSJUSER",$J,"FLAG")) D ENCHK I $D(%) G:%=2 MULT S:%=-1 XQUIT="" G:%=-1 Q1
 . Q
 ;
 Q:+$G(DONE)=1   ;P407
 ; PSJ*407/RJH - End changes
 I 'PSIVCT W !!,"Whoops ... You don't have an IV ROOM defined ... ",!,"You MUST define at least one IV ROOM before you can continue.",! S DIC="^PS(59.5,",DIC(0)="QEAML",DLAYGO=59.5,DIC("A")="Select IV ROOM: " D ^DIC I Y'>0 S XQUIT="" G Q1
 I 'PSIVCT S DIE=DIC,(DA,PSIVSN)=+Y,DR="[PSJI SITE PARAMETERS]" K DIC D ^DIE,ENCHK
Q ;
 I PSIVSN<1 W !!,"You have not selected a valid IV ROOM" S %=1 D YN^DICN I %=0 G Q
 I PSIVSN<1 G:%=1 PSIVSET S XQUIT="" G Q1
 S IOP=$P(^PS(59.5,PSIVSN,0),U,2) I IOP]"" S %ZIS="QN" D ^%ZIS I ION]"" W !!,"Current IV LABEL device is: ",ION S PSIVPL=ION
 E  D ENLD
 S IOP=$P(^PS(59.5,PSIVSN,0),U,3) I IOP]"" S %ZIS="QN" D ^%ZIS I ION]"" W !!,"Current IV REPORT device is: ",ION S PSIVPR=ION
 E  D ENPD
 ;D ^%ZISC  - check if %ZISC created mismatch in PSIVPL/PSIVPR = ION; don't que later
 D ^%ZISC S:PSIVPL="HOME" PSIVPL=ION S:PSIVPR="HOME" PSIVPR=ION
Q1 K IOP,PSIVCT,%ZIS,% Q
 ;
ENCHK ;
 ; PSJ*407/RJH - Begin changes
 N OPT1,OPTS              ; PSJ*407
 D SETUP                  ; PSJ*407
 S DONE=0                 ; PSJ*407
 S OPT1=$P($G(XQY0),U,1)  ; PSJ*407 - This should be the calling menu option
 ;
 S PSIV=1 S:'$D(^PS(59.5,PSIVSN,5)) $P(^(5),U)="" I '$D(^PS(59.5,PSIVSN,1)) S PSIV=0 W !!,$C(7),"This IV room is missing parameters."
 E  S PSIVSITE=^PS(59.5,PSIVSN,1),$P(PSIVSITE,U,20,21)=$G(^PS(59.5,PSIVSN,5)) D
 .; F TYP="A","P","H","S","C" I '$D(^PS(59.5,PSIVSN,2,"AC",TYP)) W !!,$C(7),"Manufacturing Time(s) missing for " S X=$$CODES^PSIVUTL(TYP,59.51,.02) W X S PSIV=0 ; PSJ*407
 . F TYP="A","P","H","S","C" I '$D(^PS(59.5,PSIVSN,2,"AC",TYP)),'$D(^TMP("PSJUSER",$J,"DSPFLAG")) S PSIV=0 S ^TMP("PSJUSER",$J,"FLAG")=PSIVSN D  ; PSJ*407
 . Q                      ; PSJ*407
AGA ;
 ; I 'PSIV R !!,"Would you like to edit this IV room" S %=1 D YN^DICN Q:%=2!(%=-1)  W:'% !,"Answer Yes or No.",! G:'% AGA S DIE="^PS(59.5,",DR="[PSJI SITE PARAMETERS]",DA=PSIVSN D ^DIE G ENCHK ; PSJ*407
 ; I PSIVSN W !!,"You are signed on under the ",$P(^PS(59.5,PSIVSN,0),"^")," IV ROOM" K %  ; PSJ*407
 I PSIVSN,PSIV D  Q  ; The IV Room is defined and set up properly
 . W !!,"You are signed on under the ",$P(^PS(59.5,PSIVSN,0),"^")," IV ROOM" K %
 . K PSIV,TYP,%X,%Y,C,D,D0,D1,DA,DIC,DIE,DR,X,Y,Z
 . Q
 ;
 ; If we're here, then the IV Room is missing Coverages
 I OPT1="PSJI SITE PARAMETERS" D SITEMSG Q
 ; I '$D(^TMP("PSJUSER",$J,"DSPFLAG")),(OPT1="PSJI MGR"),($G(XQY0)'["PSJI SUPERVISOR") D MSG1(1) Q
 I '$D(^TMP("PSJUSER",$J,"SUPFLAG")),(OPT1="PSJI MGR")!(OPT1="PSJI SUPERVISOR") D MSG1(1) Q
 I $D(OPTS(OPT1)) D MSG1(0) Q
 ; K PSIV,TYP,%X,%Y,C,D,D0,D1,DA,DIC,DIE,DR,X,Y,Z Q    ; PSJ*407 
 Q
 ; PSJ*407/RJH - End changes
 ;
ENLD ;Get label device.
 W ! K IOP S %ZIS="NQ",%ZIS("B")=$S($P(^PS(59.5,PSIVSN,0),U,2)]"":$P(^(0),U,2),1:"HOME"),%ZIS("A")="Enter IV LABEL device: " D ^%ZIS S:POP ION="HOME"
 S PSIVPL=ION K IOP,%ZIS Q
ENPD ;Get printer device.
 W ! K IOP S %ZIS("B")=$S($P(^PS(59.5,PSIVSN,0),U,3)]"":$P(^(0),U,3),1:"HOME"),%ZIS="NQ",%ZIS("A")="Enter IV REPORT device: " D ^%ZIS S:POP ION="HOME"
 S PSIVPR=ION K IOP,%ZIS Q
DEVX W !!,$C(7),"You must select a device."
 Q
SITEPARM ; Edit IV Site Parameters.
 D ^PSIVXU Q:$D(XQUIT)
 N CHK,DIC,DIE,DA,DR,DLAYGO,DIOV,DTOUT,PSGDT,Z
 S DIC=59.7,DIC(0)="AEMQ" D ^DIC Q:Y<0
 S DIE=DIC,DA=+Y,DR=32 D ^DIE
 D ^PSIVXU Q:$D(XQUIT)  S (DIC,DLAYGO)=59.5,DIC(0)="AEQMLZ" D ^DIC S:Y>0 DIE=DIC,DA=+Y,DR="[PSJI SITE PARAMETERS]" D:Y>0 ^DIE,ENCHK^PSIVSET,SET^PSIVXU D ENIVKV^PSGSETU
 ; ----------------------------------------------------------------------------
 ; PSJ*407/RJH - Begin changes
 ; Added Quit to SITEPARM tag and new tags below
 Q
SITEMSG ;
 D MISSING
 W !,!,"Please select "_$P(^PS(59.5,PSIVSN,0),U,1)_" IV ROOM to update the Parameters."
 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR,DTOUT,DUOUT,DIRUT
 S ^TMP("PSJUSER",$J,"DSPFLAG")=1
 K PSIV,TYP,%X,%Y,C,D,D0,D1,DA,DIC,DIE,DR,X,Y,Z
 Q
 ;
MSG1(FLG) ;
 D MISSING
 W !,!,"The "_$P(^PS(59.5,PSIVSN,0),U,1)_" IV ROOM can be updated using option 'Site Parameters (IV)'"
 W !,"by a holder of the PSJI MGR VistA Security Key. Contact the"
 W !,"Pharmacy Informaticist to update the IV Room parameters."
 I 'FLG W !!,"You are being returned to the Option Menu." S DONE=1
 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR,DTOUT,DUOUT,DIRUT
 I FLG S ^TMP("PSJUSER",$J,"SUPFLAG")=1
 K PSIV,TYP,%X,%Y,C,D,D0,D1,DA,DIC,DIE,DR,X,Y,Z
 Q
 ;
MISSING ; Show the missing coverage time(s)
 F TYP="A","P","H","S","C" I '$D(^PS(59.5,PSIVSN,2,"AC",TYP)) D
 . W !!,$C(7),"Coverage Time(s) missing for " S X=$$CODES^PSIVUTL(TYP,59.51,.02) W X
 . Q
 Q
 ;
SETUP ; Menu options to check to display missing coverage warnings to the user
 ; S OPTS(Menu option from #19)="". Menu option is piece one of XQY0
 S OPTS("PSJI RETURN BY BARCODE ID")=""
 S OPTS("PSJI LBLMENU")=""
 S OPTS("PSJI LBLI")=""
 S OPTS("PSJI MAN")=""
 S OPTS("PSJI ORDER")=""
 S OPTS("PSJI RETURNS")=""
 S OPTS("PSJI SUSMENU")=""
 S OPTS("PSJI SUSLBDEL")=""
 S OPTS("PSJI INDIVIDUAL SUSPENSE")=""
 S OPTS("PSJI SUSLBLS")=""
 S OPTS("PSJI SUSMAN")=""
 S OPTS("PSJI SUSREP")=""
 S OPTS("PSJI SUSLIST")=""
 S OPTS("PSJU VBW")=""
 S OPTS("PSJ ECO")=""
 S OPTS("PSJ OE")=""
 Q
 ; PSJ*407/RJH - End changes
