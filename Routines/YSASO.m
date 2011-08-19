YSASO ;692/DCL-ASI OUTPUT LOOKUP;MAY 03, 1996@11:45 ;10/2/96  15:34
 ;;5.01;MENTAL HEALTH;**24**;Dec 30, 1994
 Q
DICI(YSAS) ;Look-up of patient and ASI intake, PASS YSAS BY REFERENCE
 N DIC,YSASPIEN
 S YSAS=0
 S DIC="^DPT(",DIC(0)="AEMQ"
 S DIC("W")="W $$PID^YSASLIB(Y)"
 D ^DIC
 Q:Y'>0
 S YSASPIEN=+Y
 I '$D(^YSTX(604,"C",YSASPIEN)) D  Q
 .W $C(7),!,"No ASI Record In Database"
 .W !,"Use Intake Option To Add ASI Record",!
 .Q
 S DIC="^YSTX(604,",DIC(0)="AEQ"  ;,DIC("S")="I $P(^(0),U,2)=YSASPIEN"
 S DIC("S")="I $P(^(0),U,2)=YSASPIEN,$P(^(0),U,4)=1"
 S DIC("A")="SELECT ASI ID NUMBER: "
 S D="A02."_+YSASPIEN
 D IX^DIC
 Q:Y'>0
 S YSAS=+Y
 Q
 ;
DICF(YSAS) ;Lookup Patient and Follow-up PASS YSAS BY REFERENCE
 N DIC,YSASPIEN
 S YSAS=0
 S DIC="^DPT(",DIC(0)="AEMQZ"
 S DIC("W")="W $$PID^YSASLIB(Y)"
 D ^DIC
 Q:Y'>0
 ;patient file ien
 S YSASPIEN=+Y
 I $$NOASI(YSASPIEN) D  Q
 .W $C(7),!,"Patient has no ASI Follow-up on file",!
 .Q
 S DIC="^YSTX(604,",DIC(0)="AEQ"
 S DIC("S")="I $P(^(0),U,2)=YSASPIEN,$P(^(0),U,4)=2"
 S DIC("A")="SELECT ASI FOLLOW-UP: "
 S DIC("W")="W $$FUID^YSASLIB(Y)"
 S D="A02."_+YSASPIEN
 D IX^DIC
 Q:Y'>0
 S YSAS=+Y
 Q
 ;
 ;
NOASI(IEN) ;
 ;Check if Patient has NO ASI FOLLOW-UP on file return 0 if one if found and 1 if none is found
 Q:$G(IEN)'>0
 N ASI,FLG
 S ASI=0,FLG=1
 F  S ASI=$O(^YSTX(604,"C",IEN,ASI)) Q:ASI'>0  I $D(^YSTX(604,"D",2,ASI)) S FLG=0 Q
 Q FLG
 ;
