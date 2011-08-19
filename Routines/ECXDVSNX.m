ECXDVSNX ;ALB/JAP - Division Identifier for DSS ;July 16, 1998
 ;;3.0;DSS EXTRACTS;**8,24,33**;Dec 22, 1997
 ;
EN ;entry point from menu option
 ;user adds any division to file #727.3
 N D,L,X,Y,YR,MON,FY,OUT,%,DIR,DIRUT,DTOUT,DUOUT,DIC,DIE,DR
 D NOW^%DTC S ECX=$$FMTE^XLFDT(%,"5D"),YR=+$P(ECX,"/",3),MON=+$P(ECX,"/",1),FY=$S(MON<10:YR,1:YR+1)
 S ECXFY=FY-1700,ECFYB=ECXFY-1_"1000",ECFYE=ECXFY_"1001"
 ;get all divisions active during this fiscal year
 D ALL^ECXDVSN2(.ECXDIV,1,ECFYB,ECFYE,.ECXERR)
 D SELECT
 G EXIT
 Q
 ;
SELECT ;select division
 S DIR(0)="PAO^40.8",DIR("A")="Select Medical Center Division: " K X,Y
 S DIR("S")="I $D(ECXDIV(+Y))" K X,Y D ^DIR K DIR Q:$D(DIRUT)
 S ECXDIV=+Y
 W !!,"Division:",?20,$P(ECXDIV(ECXDIV),U,2)
 I $P(ECXDIV(ECXDIV),U,5)=0 W "   **Inactive**"
 W !,"Station number:",?20,$P(ECXDIV(ECXDIV),U,3)
 W !,"Primary division?:",?20,$S(+$P(ECXDIV(ECXDIV),U,4):"Yes",1:"No")
 S DR="1;",DIQ(0)="E",DIQ="ECX",DA=ECXDIV,DIC="^ECX(727.3," K ECX D EN^DIQ1
 ;if division already has a dss identifier, then display it
 I $G(ECX(727.3,ECXDIV,1,"E"))]"" D  Q:$D(DTOUT)  G:Y=0 SELECT
 .W !,"DSS Identifier:",?20,ECX(727.3,ECXDIV,1,"E"),!
 .S DIR(0)="YA",DIR("A")="Do you want to change this identifier? ",DIR("B")="NO"
 .K X,Y D ^DIR K DIR
 ;allow user to enter/edit dss division identifier
 S OUT=0
 F  D  Q:$D(DIRUT)!(OUT=1)
 .W !
 .S DIR(0)="FA^1:1",DIR("A")="Enter the DSS Division Identifier: "
 .K X,Y D ^DIR K DIR Q:$D(DIRUT)
 .I X?.P!(X?.L)!($L(X)>1)!(X="0") W !,"Invalid ...try again.",! Q
 .I '$$CHKCODE(X,ECXDIV) W !,"Already used for another division ...try again.",! Q
 .S ECXID=X,OUT=1
 G:$D(DUOUT) SELECT
 Q:$D(DTOUT)
 ;if selected division isn't in file #727.3, then add it
 I '$D(ECX(727.3,ECXDIV)) D
 .S (X,DINUM)=ECXDIV,DIC(0)="L",DLAYGO=727.3,DIC="^ECX(727.3,"
 .K DD,DO D FILE^DICN K DINUM,DLAYGO,X,Y
 ;update with new identifier
 S DIE="^ECX(727.3,",DA=ECXDIV,DR="1////^S X=ECXID;" D ^DIE
 W !!
 G SELECT
 ;
EXIT ;common exit point
 K ECX,ECXDIV,ECXERR,ECXFY,ECFYB,ECFYE
 Q
 ;
CHKCODE(X,ECXDIV) ;make sure dss identifier is unique
 I '$D(^ECX(727.3,"C",X)) Q 1
 S XX=$O(^ECX(727.3,"C",X,0))
 I XX'=ECXDIV Q 0
 Q 1
