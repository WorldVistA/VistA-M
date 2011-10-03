ABSVE4 ;VAMC ALTOONA/CTB/CLH - MULTIPLE DAYS ENTRY ;4/13/00  3:17 PM
V ;;4.0;VOLUNTARY TIMEKEEPING;**10,18**;JULY 6, 1994
 ;ENTER DATA INTO TIME FILE
 N %,%DT,%T,%W,%Y,C,COMB,DATE,DAY,DIC,DI,DIR,D0,DQ,DR,DUOUT,DIE,DATE,ORG,DA,SER,VOL,I,N,X,Y,POP,MONTH,DONE,OUT,DDH
 D ^ABSVSITE G OUT^ABSVE3:'%
 S (DONE,OUT)=0
 F  D  Q:DONE  I 'DONE!(OUT) G OUT^ABSVE3
  . S %DT="AEP",%DT("A")="Select Posting MONTH and YEAR: " D ^%DT K %DT
  . I Y>0 S DONE=1 QUIT
  . I X["^" S OUT=1 QUIT
  . S %DT="EX",X="??" W "       Month and Year are REQUIRED.  Use '^' to Quit",*7,!! D ^%DT S %DT="AEX"
  . QUIT
 I OUT K OUT D OUT^ABSVE3 QUIT
 K DONE
 S MONTH=$E(Y,1,5)_"00"
 S DIC("A")="Select Volunteer: "
TIME S DIC("S")="I $D(^ABS(503330,+Y,4,ABSV(""INST""),0))",DIC=503330,DIC(0)="AEMZQ"
 D MDIV^ABSVSITE,^DIC K DIC
 G OUT^ABSVE3:Y<0
 G TIME:'$$ACTIVE^ABSVU2(+Y,ABSV("INST"))
 S ABSVX("VOLDA")=+Y,ABSVX("NAME")=$P(Y,"^",2)
T1 S DA=ABSVX("VOLDA") D PC1^ABSVE2,SEL1^ABSVE2 G OUT^ABSVE3:Y=""
 S X=^ABS(503330,DA,1,$P(Y,"^",2),0)
 S COMB=$P(X,"^",5),ORG=$P(X,"^",2),SER=$P(X,"^",4)
 F  D  Q:DONE!(OUT)
  . W !! S %DT="E",DONE=0,OUT=0 F  D  Q:DONE
  . . NEW NEW
  . . W !,"For "_ABSVX("NAME")_" and Combination "_COMB
  . . R !,"Select DAY NUMBER: ",X:DTIME S %T=$T
  . . I X=""!(X["^") S DONE=1 S:X["^"!('%T) OUT=1 QUIT
  . . I X>31!(X<1) D ERROR QUIT
  . . S X="0"_X,X=$E(MONTH,1,5)_$E(X,$L(X)-1,$L(X))
  . . D ^%DT I Y'>0 D ERROR  QUIT
  . . S DATE=Y
  . . S Y=0 F  S Y=$O(^ABS(503331,"B",ABSVX("VOLDA"),Y)) Q:Y=""  S X=$G(^ABS(503331,Y,0)) I $P(X,"^",3)=DATE,$P(X,"^",6)=COMB Q
  . . I Y'>0 S X=ABSVX("VOLDA") S DIC="^ABS(503331,",DIC(0)="ML" D FILE^DICN,XREF S NEW=1
  . . S DA=+Y,DR=4,DIE="503331" D ^DIE
  . . I '$D(Y) S X="<Daily Record Completed.>*" D MSG^ABSVQ QUIT
  . . I $D(NEW) K NEW S X="This entry is incomplete and is being deleted.*" D MSG^ABSVQ S DIK=DIE D ^DIK K DIK QUIT
  . . S ABSVXA="ARE YOU SURE YOU WANT TO DELETE THIS ENTRY",ABSVXB="",%=1 D ^ABSVYN
  . . I %'=1 S X="  <No action taken>*" D MSG^ABSVQ QUIT
  . . S DIK=DIE D ^DIK K DIK S X="  <Record Deleted>*" D MSG^ABSVQ
  . . QUIT
  . QUIT:OUT
 K OUT,DONE W !!!,"For ",$$FULLDAT^ABSVU2(MONTH),":" S DIC("A")="Select Next Volunteer: " G TIME
XREF S XX=$E(DATE,1,5)_"00^"_DATE_"^"_+ORG_"^^"_COMB_"^"_ABSV("SITE")_"^"_+SER,$P(^ABS(503331,+Y,0),"^",2,8)=XX K XX
 S ^ABS(503331,"AD",DATE,+Y)="",^ABS(503331,"AC",+ORG,+Y)="",^ABS(503331,"AE",+SER,+Y)="",^ABS(503331,"AF",$E(DATE,1,5)_"00",+Y)=""
 Q
ERROR ;
 W *7,! S X="Enter the day NUMBER of the month selected.  E.g. for March 25, 1993 enter 25, or '^' when finished.*"
 D MSG^ABSVQ W !
 QUIT
