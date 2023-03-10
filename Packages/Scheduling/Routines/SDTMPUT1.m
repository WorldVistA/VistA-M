SDTMPUT1 ;MS/SJA - VISTA-TELEHEALTH UPDATE UTILITY ;Dec 17, 2020
 ;;5.3;Scheduling;**773**;Aug 13, 1993;Build 9
 ;
 ;
 N ACT,ALL,CLN,DIV,III,SDALL,SDASH,SDEF,SDOUT,SDLT,SDV1,STIEN,XX,SEL,TOT,VAUTD
EN ;
 S $P(SDASH,"=",80)="",(SEL,ACT,DIV)="",(ALL,SDOUT)=0
 W @IOF W !,?22,"VistA Real-Time Clinic Updates",!
 D ASK Q:SDOUT
 S:$G(VAUTD)=1 DIV="ALL"
 W ! D @SEL
 G EN
 ;
C ; clinic
 K ^TMP($J)
 K DIC,DTOUT,DUOUT S DIC="^SC(",DIC(0)="AEQM",DIC("A")="Select Clinic: "
1 D ^DIC I Y>0 S ^TMP($J,+Y)="",DIC("A")="Another one:" G 1
 I $D(DTOUT)!($D(DUOUT))!('$O(^TMP($J,0))) Q
 W !!,SDASH,!
 F III=0:0 S III=$O(^TMP($J,III)) Q:'III  W !,"Clinic: ",III,?15,$$GET1^DIQ(44,III,.01)
 W !,SDASH,!
 F III=0:0 S III=$O(^TMP($J,III)) Q:'III  D
 . D EN^SDTMPHLB(III) W !,"Sending HL7 message for Clinic: ",$$GET1^DIQ(44,III,.01)
 W !! S DIR(0)="EA",DIR("A")="Press <Enter> to continue" D ^DIR K DIR
 Q
 ;
S ; stop codes
 K ^TMP($J),^TMP($J,"CLN") S (TOT,TOT(0),TOT(1))=0
 K DIC,DTOUT,DUOUT S DIC="^SD(40.6,",DIC(0)="AEMQ",DIC("A")="Select Telehealth Stop Code: "
2 D ^DIC I Y>0 S ^TMP($J,+Y)="",DIC("A")="Select another Telehealth Stop Code: " G 2
 I $D(DTOUT)!($D(DUOUT))!('$O(^TMP($J,0))) Q
 W !!,SDASH,!
 F STIEN=0:0 S STIEN=$O(^TMP($J,STIEN)) Q:'STIEN  S CLN=$$ST(STIEN,DIV)
 F III=0:0 S III=$O(^TMP($J,"CLN",III)) Q:'III  D
 . W:TOT=0 !,SDASH,!
 . D EN^SDTMPHLB(III) W !,"Sending HL7 message for Clinic: ",III,"-",$$GET1^DIQ(44,III,.01) S TOT=TOT+1
 W !!
 I ACT="B" D
 . W !,"Total number of Active clinics updated: ",TOT(1)
 . W !,"Total number of Inactive clinics updated: ",TOT(0)
 W !,"Total number of clinics updated: ",TOT
 W !! S DIR(0)="EA",DIR("A")="Press <Enter> to continue" D ^DIR K DIR
 Q
ST(STIEN,DIV) ;
 N FLG1,FLG2,CODE,STP1,STP2,F407,S407,II,NODE0,STOP1,STOP2,XX
 S (F407,S407,STP1,STP2)=0
 S CODE=$G(^SD(40.6,STIEN,0)),STP1=$E(CODE,1,3),STP2=$E(CODE,4,6)
 S F407=$O(^DIC(40.7,"C",STP1,0)) S:STP2 S407=$O(^DIC(40.7,"C",STP2,0))
 S II=0
 F  S II=$O(^SC(II)) Q:'II  S (FLG1,FLG2)=0 D
 . S NODE0=$G(^SC(II,0)) I DIV'="ALL" Q:'$$DIVCHK($P(NODE0,U,15))
 . S STOP1=$P(NODE0,"^",7),STOP2=$P(NODE0,"^",18)
 . Q:($G(STOP1)="")&(($G(STOP2))="")
 . I $G(F407)!$G(S407) D
 . . I (F407=STOP1)!(S407=STOP1) S FLG1=1
 . . I (F407=STOP2)!(S407=STOP2) S FLG2=1
 . I 'FLG1,'FLG2 Q
 . S XX=$$ACTIVE(II) I ACT="B" S TOT(XX)=TOT(XX)+1
 . I (XX&(ACT="I"))!('XX&(ACT="A")) Q
 . W !,"Clinic: ",II W:ACT="B" ?15,$S(XX:"'A'",'XX:"'I'",1:"") W ?20,"(",$S(STOP1:$$GET1^DIQ(40.7,STOP1,1),1:"   "),"/",$S(STOP2:$$GET1^DIQ(40.7,STOP2,1),1:"   "),") ",$P(NODE0,U) D
 . . S ^TMP($J,"CLN",II)=""
 Q 1
 ;
EXIT ;
 K DTOUT,DUOUT,DTOT
 K ^TMP($J)
 Q
 ;
ASK W ! K DIR,Y S DIR(0)="SA^C:Clinic;S:Stop Code;Q:Quit"
 S DIR("A")="Select (C)linic, (S)top Code or (Q)uit: "
 S DIR("B")="C"
 D ^DIR K DIR I Y="Q"!$D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 S SEL=Y W ! I SEL="C" Q
 ;
 S DIR(0)="SA^A:Active;I:Inactive;B:Both"
 S DIR("A")="(A)ctive Clinics, (I)nactive Clinics, (B)oth: "
 S DIR("?",1)="Enter an 'A' for Active Clinics, 'I' for Inactive Clinics,"
 S DIR("?")="'B' for Both Active and Inactive Clinics"
 S DIR("B")="A"
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 S ACT=Y W !
 ;
DIV ; ask for division
 D ASK2^SDDIV S:Y<0 SDOUT=1
 Q
 ;
DIVCHK(CLNDIV) ; check clinic division
 N FLG,FF
 S FLG=0
 I $G(VAUTD)=0 S FF=0 F  S FF=$O(VAUTD(FF)) Q:'FF  I CLNDIV=FF S FLG=1 Q
 Q FLG
 ;
ACTIVE(LOC) ;determine if clinic is active
 ; Output X:1=ACTIVE, 
 ;        X:0=INACTIVE
 N NODE,I1,I2,X
 S X=0
 S NODE=$G(^SC(LOC,"I")) Q:NODE="" 1
 S I1=$P(NODE,U,1)   ;inactive date/time
 S I2=$P(NODE,U,2)   ;reactive date/time
 I (I1="") S X=1 Q X
 I ((I1'="")&(I1>DT))!((I2'="")&(I2'>DT)) S X=1 Q X
 Q X
 ;
