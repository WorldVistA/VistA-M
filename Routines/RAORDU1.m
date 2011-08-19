RAORDU1 ;HISC/CAH - AISC/SAW-Utility for Rad/NM Orders Module ;05/15/09  12:56
 ;;5.0;Radiology/Nuclear Medicine;**10,41,75,99**;Mar 16, 1998;Build 5
 ;P#99 - changed Pregnant title to Pregnant at time of order entry.
CP ;Create protocols for Rad/Nuc Med in OE/RR Protocol file (#100)
 ;based upon entries in the Rad/Nuc Med Common Procedure file (#71.3)
 ;
 I $$ORVR^RAORDU()>2.5 W !!,"In order to use this option, your site must be running version 2.5 of the",!,"Order Entry/Results Reporting package." G Q
 ;
 ;Check/set package and default protocol values
 S ORPKG=$O(^DIC(9.4,"C","RA",0)) I 'ORPKG W !,$C(7),"There is no entry for the Radiology/Nuclear Medicine package in your Package",!,"file (#9.4), unable to proceed.  Contact your site manager." G Q
 S ORDEF=$O(^ORD(101,"B","RA OERR DEFAULT PROTOCOL",0)) I 'ORDEF W !,$C(7),"You do not have a default Radiology/Nuclear Medicine protocol in your",!,"Protocol file (#101), unable to continue.  Contact your site manager." G Q
 S (I,RACNT,RAF1,X)=0 K ^TMP($J,"RAEX") W !!?10,"Create an OE/RR Protocol from a Radiology/Nuclear Medicine",!?10,"Common Procedure",!
 F  S I=$O(^RAMIS(71.3,I)) Q:I'>0  I $D(^(I,0)) S Y=I_"^"_^(0) I $P(Y,"^",6)']"",$D(^RAMIS(71,+$P(Y,"^",2),0)) S RACNT=RACNT+1,^TMP($J,"RAEX",RACNT)=Y W !,RACNT,?6,$P(^RAMIS(71,+$P(Y,"^",2),0),"^") D:'(RACNT#15) ASK^RAUTL4 Q:X="^"!(X>0)
 G Q:X="^" I 'RACNT W !,$C(7),"The Common Procedures file does not have any entries from which to choose." G Q
 I RACNT=1 S RADUP(1)="" W !!,"There is only one Common Procedure to choose from." S DIR(0)="YA",DIR("A")="Okay to continue? " D ^DIR G Q:Y'=1,CP1
 I X'>0,RACNT#15 D ASK^RAUTL4 G Q:'$D(RADUP)
CP1 S RAI=0 F  S RAI=$O(RADUP(RAI)) Q:RAI'>0  S Y=^TMP($J,"RAEX",RAI),DA=+Y,Y=$P(Y,"^",2,99) W !!,"Processing the ",$P(^RAMIS(71,+Y,0),"^")," procedure.",! D CP2
Q K %1,D,D0,DA,DIC,DIE,DIR,DR,I,J,K,ORDEF,OREA,ORFL,ORPKG,ORTXT,RACNT,RADUP,RAERR,RAF1,RAI,RAILOC,RAPAR,RASEL,X,Y,Z,^TMP($J,"RAEX")
 K DI,DIG,DIH,DIU,DIV,DQ
 Q
CP2 S RAERR=0 S RAILOC=$P(Y,"^",8) I 'RAILOC S RAILOC=$O(^RA(79.1,0)) I RAILOC,$O(^(RAILOC)) K RAILOC W !,$C(7),"You must enter an 'Imaging Location' before this procedure can be processed",!,"as an orderable item in OE/RR." S RAERR=1
 S ORTXT=$P(Y,"^",13) I ORTXT']"" W !,$C(7),"You must enter a 'Name of Ordeable Item' before this procedure can be processed",!,"as an orderable item in OE/RR." S RAERR=1
 I RAERR K RAILOC,ORTXT Q
 S ORFL=+Y_";RAMIS(71,",OREA="S RADR1=1,RAPRI="_+Y_",RAILOC="_RAILOC_$S($P(Y,"^",11):",RARU="_$P(Y,"^",11),1:"")
 S Z="^^^^^RACAT^RAREQDT^^RAMT^RAIP" F X=6,9,10 S OREA=OREA_$S($P(Y,"^",X)]"":","_$P(Z,"^",X)_"="_""""_$P(Y,"^",X)_"""",1:"")
 I $O(^RAMIS(71.3,DA,"M",0)) S K=0 F J=1:1 S K=$O(^RAMIS(71.3,DA,"M",K)) Q:K'>0  S X=$G(^(K,0)) I $D(^RAMIS(71.2,+X,0)) S X=$P(^(0),"^") I X]"" S OREA=OREA_",RAMOD("_J_")="_""""_X_""""
 S OREA=OREA_" D ^RAORR"
 I $G(^DIC(9.4,ORPKG,0))]"" N RA1 S RA1=$P(^(0),"^",2)_+ORFL_" "_ORTXT S:$O(^ORD(101,"B",RA1,0)) ORDA=$O(^(0)) ; define ORDA if filelink record exists in file #101
 ;D EN3^ORUPREF2 W:$D(Y) !,*7,"Unable to create an orderable item in OE/RR."
 Q  ;dead code OE 2.5 from CP down to here
 ;
DISP ;Display request with defaults
 S:'$D(RAMOD)#2 RAMOD=""
 S J="",$P(J,"-",80)="" W !!,J
 I $D(RAMOD)>9 S RAMOD="" F I=1:1 Q:'$D(RAMOD(I))  S RAMOD=RAMOD_$S(I'=1:", ",1:"")_RAMOD(I) S RAI=0 S RAI=+$O(^RAMIS(71.2,"B",RAMOD(I),RAI)) I $P($G(^RAMIS(71.2,RAI,0)),U,2)="p" S RAACI="p"
 W !?10,"Patient: ",RANME I RASEX'="M" S:'$D(RAPREG) RAPREG="" W "   Pregnant at time of order entry: ",$S(RAPREG="y":"YES",RAPREG="u":"UNKNOWN",RAPREG="n":"NO",1:"")
 W !?8,"Procedure: ",$S($D(^RAMIS(71,RAPRI,0)):$P(^(0),"^"),1:"UNKNOWN"),!?2,"Proc. Modifiers: ",RAMOD
 S:'$D(RAMT) RAMT=$S($G(RAACI)="p":"p",$E(RACAT)="I":"w",1:"a") S RAMT=RAMT_"^"_$P($P(^DD(75.1,19,0),RAMT_":",2),";") W !?9,"Category: ",RACAT,?49,"Mode of Transport: ",$P(RAMT,"^",2)
 S:'$D(RAIP) RAIP="n" W !,"     Desired Date: ",RAWHEN,?46,"Isolation Procedures: ",$S(RAIP="y":"YES",1:"NO")
 S:'$D(RARU) RARU=9 W !,"  Request Urgency: ",$S($D(RARU):$P($P(^DD(75.1,6,0),RARU_":",2),";"),1:"ROUTINE"),?46,"Scheduled for Pre-op: ",$S($D(RAPREOP1):"YES",1:"NO")
 I $D(RAILOC) W !,"Submit Request To: ",$S($D(^RA(79.1,+RAILOC,0)):$S($D(^SC(+$P(^(0),"^"),0)):$P(^(0),"^"),1:"Unknown"),1:"Unknown")
 W !," Request Location: ",$S($P($G(^SC(+RALIFN,0)),U)]"":$E($P($G(^SC(+RALIFN,0)),U),1,26),1:"Unkown") I $$ORVR^RAORDU()'<3 W ?46,"Nature of order:  SVC CORRECTION"
 D DISREA(RAREAST) ;display the reason for study
 ;*Billing Aware Project:
 ;   Display New ICD-9 Dx and their related SC/EI/MST/HNC responses.
 ;
BADISP D:$P($G(RABWDX(1)),U,1)>0 BADISP^RABWORD1(.RABWDX)
 ;*
 K ^UTILITY($J,"W"),^(1) S DIWF="WN",DIWL=1,DIWR=79,I=0 W !!,"Clinical History:",! F  S I=$O(^TMP($J,"RAWP",I)) Q:I'>0  S X=^(I,0) D ^DIWP
 D ^DIWW W !,J
 S DIR(0)="Y",DIR("A")="Do you want to change any of the above",DIR("B")="NO" D ^DIR K DIR S:$D(DUOUT)!($D(DTOUT)) RAOUT=1 Q:$D(RAOUT)  S:Y=0 RADR1=1 S:Y'=0 RADR2=1,RASTOP=0
 ; RASTOP is used to track whether the procedure messages have printed.
 ; If you answer 'yes' to "Do you want to edit this request", you
 ; will see the procedure messages again (if they exist and if you
 ; viewed them before.  Value altered in ADDORD+1^RAORD1 & EN2+1^RAPRI)
 Q
 ;
DISREA(X) ;this function formats and displays the reason for study for this
 ;order.
 ;input: X - the reason for study (a string between three & sixty four
 ;characters in length)
 N %,DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,I,LINES,Z
 ;accumulate & format data; column width of sixty (DIWF's C60) characters
 S DIWF="C60",DIWL=1 D ^DIWP
 W !," Reason for Study: " S I=0,LINES=^UTILITY($J,"W",DIWL)
 ;LINES: # of formatted lines in ^UTILITY
 F  S I=$O(^UTILITY($J,"W",DIWL,I)) Q:'I  W ?19,$G(^(I,0)) W:I'=LINES !
 K ^UTILITY($J,"W",DIWL)
 Q
 ;
