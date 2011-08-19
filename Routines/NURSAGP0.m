NURSAGP0 ;HIRMFO/MD,RM-GENERIC PROMPTS FOR ADMIN/EDUCATION REPORTS ;10/05/95
 ;;4.0;NURSING SERVICE;**13**;Apr 25, 1997
EN1 ;GENERIC PROMPTS FOR GENDER REPORTS
 S NSP=0 W !!,"Select GENDER (Press return for both male and female): " R X:DTIME
 I '$T!(X="^") S NUROUT=1 Q
 I X="" S NSP=1 Q
 S X=$$UP^XLFSTR(X)
 I X="M"!(X="F") S NSPC=X Q
 W !,?5," Enter One Of The Following : ",!?10," M for Male ",!?10," F for  Female " G EN1
EN2 ;GENERIC PROMPTS FOR ACADEMIC DEGREE REPORTS
 W ! S NSP=0,DIC("A")="Select ACADEMIC DEGREE (Press return for all degrees): "
 S DIC="^NURSF(212.1,",DIC(0)="AEMZQ",DIC("W")="W ?45,$P(^(0),U,3)" D ^DIC W ! I '$D(DTOUT),X="" S NSP=1 Q
 I $D(DTOUT)!(X="^")!(+Y'>0) S NUROUT=1 Q
 S NSPC=$P(Y(0),"^",3)
 Q
EN3 ;GENERIC PROMPTS FOR AGE REPORTS
 W ! S X="^",NSP=0,%DT("A")="Start with DATE OF BIRTH (Press return for all dates of birth): ",%DT="AEQ" D ^%DT K %DT I X="" S NSP=1 Q
 I X="^"!(+Y'>0) S NUROUT=1 Q
 S NSPC=Y
 W ! S X="^",NSPC(1)=0,%DT("A")="Go To DATE OF BIRTH (Press return for all dates until the present date): ",%DT="AEQ",X="^" D ^%DT K %DT
 I X="" S X="T" D ^%DT S NSPC(1)=Y Q
 I Y'>0!(X="^") S NUROUT=1 Q
 S NSPC(1)=Y
 Q
EN4 ;GENERIC PROMPTS FOR CERTIFICATION REPORTS
 W ! S NSP=0 S DIC("A")="Select CERTIFICATION NAME (Press return for all certification names): ",DIC(0)="ZAEMQ",DIC="^NURSF(212.2," D ^DIC I '$D(DTOUT),X="" S NSP=1 G NXCK
 I +Y'>0!$D(DTOUT) S NUROUT=1 Q
 S NSPC=$P(Y(0),"^",2)
NXCK W ! S X="^",NSP(1)=0,%DT("A")="Start With DATE CERTIFICATION EXPIRES (Press return for all dates): ",%DT="AEQ",X="^" D ^%DT K %DT
 I '$D(DTOUT),X="" S NSP(1)=1 Q
 I Y'>0!(X="^") S NUROUT=1 Q
 S NSPC(1)=Y
 W ! S X="^",NSPC(2)=0,%DT("A")="Go To DATE CERTIFICATION EXPIRES (Press return for all dates until present date): ",%DT="AE",X="^" D ^%DT K %DT
 I X="" S X="T" D ^%DT S NSPC(2)=Y Q
 I Y'>0!(X="^") S NUROUT=1 Q
 S NSPC(2)=Y
 Q
EN5 ;GENERIC PROMPTS FOR FTEE PROFILE REPORTS
 S NSP=0 W !!,"Select FTEE (Press return for all FTEE): " R X:DTIME
 I X="^"!'$T S NUROUT=1 Q
 I X="" S NSP=1 Q
 I X["?" G HELP
 I X=+X,X'>1,X'<0,X'?.E1"."4N.N S NSPC=X Q
HELP W !,?5," Type a number between 0 And 1 (e.g. 0,.200,.005,1) " G EN5
EN6 ;GENERIC PROMPTS FOR GRADE PROFILE REPORTS 
 W ! S NSP=0,DIC("A")="Select GRADE/STEP CODE (Press return for all grade/step codes): "
 S DIC="^NURSF(211.1,",DIC(0)="AEMQ" D ^DIC I '$D(DTOUT),X="" S NSP=1 Q
 I $D(DTOUT)!(+Y'>0) S NUROUT=1 Q
 S NSPC=$P(Y,"^",2)
 Q
EN7 ;GENERIC PROMPTS FOR LICENSE PROFILE REPORTS
 W ! S X="",NSP=0,%DT("A")="Start With DATE LICENSE EXPIRES (Press return for all dates): ",%DT="AE",X="^" D ^%DT K %DT
 I X="" S NSP=1 Q
 I Y'>0!(X="^") S NUROUT=1 Q
 S NSPC=Y D:+Y D^DIQ S %DT("B")=Y
ENDT W ! S X="",NSPC(2)=0,%DT("A")="Go To DATE LICENSE EXPIRES: ",%DT="AE",X="^" D ^%DT K %DT
 I X="" W !!,"PLEASE ENTER A DATE OR '^' TO EXIT" G ENDT
 I Y'>0!(X="^") S NUROUT=1 Q
 S NSPC(2)=Y
 Q
EN8 ;GENERIC PROMPTS FOR MILITARY REPORTS
 S NSP=0 W !!,"Select MILITARY STATUS (Press return for retired and active reservists): " R X:DTIME
 I '$T!(X="^") S NUROUT=1 Q
 I X="" S NSP=1 G NXCK1
 S X=$$UP^XLFSTR(X)
 I X="A"!(X="R") S NSPC=X G NXCK1
 W !,?5," Type A for Active Reservists and Type R for Retired or Discharged) : " G EN8
NXCK1 W ! S NSP(1)=0,DIC("A")="Select MILITARY SERVICE BRANCH (Press return for all service branches) : ",DIC(0)="AEMQ",DIC="^DIC(23," D ^DIC I '$D(DTOUT),X="" S NSP(1)=1 Q
 I $D(DTOUT)!(+Y'>0) S NUROUT=1 Q
 S NSPC(1)=$P(Y,"^",2)
 Q
