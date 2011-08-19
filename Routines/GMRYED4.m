GMRYED4 ;HIRMFO/YH - INTRAVENOUS INFUSION PROTOCOL ;10/16/96
 ;;4.0;Intake/Output;**6**;Apr 25, 1997
HANG ;DC CURRENT SOLUTION/ADD THE SAME SOLUTION - CONTINUED
 D DC^GMRYED6 Q:GMROUT!($G(GMRZ(1))="")  S GDCDT=$P(^GMR(126,DA(1),"IV",DA,0),"^",9),GMRVTYP=$P(^(0),"^",4)
 S GMRDEL="",GX=GDCDT I '$D(^GMR(126,DA(1),"IV",DA,"IN",0)) S GLABEL="",GHLOC=GMRHLOC D DC^GMRYUT0 G ADD
 I '$D(^GMR(126,DA(1),"IV",DA,"IN","C")) S GLABEL="",GHLOC=GMRHLOC D DC^GMRYUT0 G ADD
 S GDT=$O(^GMR(126,DA(1),"IV",DA,"IN","C",0)) I GDT'>0 S GLABEL="",GHLOC=GMRHLOC D DC^GMRYUT0 G ADD
 S GGDA=$O(^GMR(126,DA(1),"IV",DA,"IN","C",GDT,0)) I GGDA>0 W !,"Last reading for AMOUNT LEFT is "_$P(^GMR(126,DA(1),"IV",DA,"IN",GGDA,0),"^",2)_" mls"
 S GLABEL="",GHLOC=GMRHLOC
 I ($P(^GMR(126,DA(1),"IV",DA,"IN",GGDA,0),"^",2)>0) D
 .S GHLOC=GMRHLOC,GLABEL="" D DC^GMRYUT0 S GGDA=+$P(^GMR(126,DA(1),"IV",DA,"IN",0),"^",3)
 . ;; GMRY*4*6 - RJS  TEST FOR GMROUT
 .Q:GMROUT
 .D IVINTK^GMRYUT8 W !,"Total solution absorbed for this bottle: "_$S($P(^GMR(126,DA(1),"IV",DA,"IN",GGDA,0),"^",2)["*":"UNKNOWN",1:($P(GDATA,"^",5)-GTOTAL)_" mls"),!
ADD I GMROUT S $P(^GMR(126,DFN,"IV",DA(1),0),"^",9)="",$P(^(0),"^",10)="" W !,"DC canceled!!!",! Q
 D ^GMRYSTCA Q:GMROUT
 I GMRVTYP["L" S (GMRZ(2),GMRZ(3))="*"
 W !!,"Adding "_GMRZ_"  ("_GMRZ(1)_")  "_$S(+GMRZ(2)>0:GMRZ(2)_" mls ",1:""),! S:GMRZ(3)'>0 GMRZ(3)=""
RATE W !,"Infusion rate(ml/hr)"_$S(GMRZ(3)'="":" "_GMRZ(3)_" //",1:": ") S X="" R X:DTIME Q:'$T!(X["^")  I X'=""&(X'?1.3N) S X="" D HELP G RATE
 S:X="" X=GMRZ(3) S:X=""!(X=0) X="" I X'=""&((X<0)!(X>999)) D HELP G RATE
RATE1 W !,"New infusion rate is "_$S(X>0:X,1:"UNKNOWN") ;S %=1 D YN^DICN W:%=0 !!,"If the infusion rate is not correct then enter N(o).",! G:%=0 RATE1 Q:%<0  G:%'=1 RATE S GMRZ(3)=X
QUICK K DD S GSAVE=GMRVTYP,(X,GX)=GDCDT,DLAYGO=126.03,DA(1)=DFN,DIC="^GMR(126,"_DA(1)_",""IV"",",DIC(0)="ML" D WAIT^GMRYUT0 Q:GMROUT  D FILE^DICN L -^GMR(126,DFN) K DIC,DLAYGO,DD S DA=+Y,GMRVTYP=GSAVE Q:Y'>0
 S DIE="^GMR(126,"_DA(1)_",""IV"",",DR="2///^S X=GMRZ;3///^S X=GMRZ(1);4//^S X=GMRZ(2);11///^S X=GMRZ(3);6///^S X=""`""_DUZ;7///^S X=""`""_GMRHLOC;1///^S X=GSITE;17///^S X=GCATH(1)"
 D WAIT^GMRYUT0 I 'GMROUT D ^DIE L -^GMR(126,DFN)
 K DIE,DR Q
 ;
SELSITE ;SELECT IV SITE TO EDIT
 S GSITE="",GMRX=0 F  S GSITE=$O(^GMR(126,DFN,"IV","SITE",GSITE)) Q:GSITE=""  S GMRY=0,GDT=0 F  S GDT=$O(^GMR(126,DFN,"IV","SITE",GSITE,GDT)) Q:GDT'>0!(GMRY>0)  S GDA=$O(^(GDT,0)) D CHCKDC
 Q
SEL S GSITE="" I GN=0 S GMROUT=1 K GN,GMRDATA Q
 D SEL^GMRYUT13 Q
CHCKDC I $P(^GMR(126,DFN,"IV",GDA,0),"^",9)="" S GMRX=GMRX+1,GMRY=1,GMRX(GMRX)=GSITE_"^"_GDA Q
 Q
LISTQUES ;
 W !,"IV is defined as IV line/port/lock",! S GNN=0 F I=1:1 S X=$T(QUES+I) Q:X=""  S GMRW=$P(X,";;",2) W !,$P(GMRW,"^"),!,?5,$P(GMRW,"^",3)
 Q
HELP W !!,"Enter a number between 0 and 999 at which the infusion takes place",!,"0 means that the rate is UNKNOWN",! Q
LISTOP ;
 F I=1:1:9 S X=$T(QUES+I) Q:X=""  S GMRW=$P(X,";;",2),GNN($E(GMRW))=$E(GMRW,5,99),GNN=+GMRW W !,$P(GMRW,"^")
QUES ;
 ;;1.  Start IV^STARTIV^Start a new IV line or heparin/saline lock/port. 
 ;;2.  Solution: Replace/DC/Convert/Finish Solution^ADDSOL^DC current solution then replace a new solution to the selected IV line or convert the IV according to the user's choice.
 ;;3.  Replace Same Solution^HANG^Replace the same solution to a selected IV.
 ;;4.  DC IV/Lock/Port and Site^DCIV^Remove IV/lock/port from a selected IV site.
 ;;5.  Care/Maintenance/Flush^MAINTN^Check site condition, dressing change, tube change and flush.
 ;;6.  Add Additional Solution(s)^ADDONLY^Add additional solution(s) without discontinuing an existing one.
 ;;7.  Restart DC'd IV^RESTART^Restart an IV which was DC'd due to infiltration or other reasons.
 ;;8.  Adjust Infusion Rate^TITER^Adjust infusion rate for a selected IV.
 ;;9.  Flush^FLUSH^Flush all IV line(s) for a selected infusion site.
