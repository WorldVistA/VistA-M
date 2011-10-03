ABSVTED3 ;VAMC ALTOONA/CTB - RESET AND BACKDATE TIME CARDS ;2/10/99  11:59 AM
V ;;4.0;VOLUNTARY TIMEKEEPING;**7,13**;JULY 6, 1994
 ;MARK TIME CARD FOR RETRANSMISSION
 N %,%W,%Y,%Y1,ABSVX,C,CHECK,DDH,DIR,ABSVXX,I,N,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 D ^ABSVSITE Q:'%
 W ! S X="This option will allow you to mark as READY TO TRANSMIT a single time card or all cards for a single month.  If a single month is selected, you will be allowed to have each card backdated.*" D MSG^ABSVQ
 S DIR(0)="S^S:Single Card;A:All Cards for One Month",DIR("A")="Select Marking Option"
 D ^DIR Q:$$DIR^ABSVU2
 D @Y
 Q
 ;
S N DIC,Y,X,DA,NAME,%DT,MONTH
S1 S DIC=503330,DIC(0)="AEMZQ",DIC("S")="I $D(^ABS(503330,+Y,4,ABSV(""INST""),0))"
 S:'$D(DIC("A")) DIC("A")="Select VOLUNTEER: "
 F  D MDIV^ABSVSITE,^DIC Q:+Y<0  Q:$$ACTIVE^ABSVU2(+Y,ABSV("INST"))
 K DIC Q:+Y<0
 S DA=+Y,NAME=$P(Y(0),"^")
 S %DT="AEP",%DT("A")="Select MONTH/YEAR: " D ^%DT Q:+Y<0
 S MONTH=$E(Y,1,5)_"00"
 S DIC="^ABS(503335,",X=NAME,DIC(0)="EMNZQ",DIC("S")="S ZX=^(0) I $P(ZX,U)=DA,$P(ZX,U,5)=MONTH,$P(ZX,U,12)=ABSV(""SITE"")"
 D ^DIC K ZX
 I $D(DUOUT) K DUOUT Q
 I +Y<0 S X="No Timecard on file for "_NAME_", for "_$$FULLDAT^ABSVU2(MONTH)_".*" D MSG^ABSVQ W !! G S1
 S DA=+Y K DIC
 I $P(^ABS(503335,DA,0),"^",6)=1 S X=" -- Time Card HAS NOT been transmitted.  No Further Action Required --*" D MSG^ABSVQ,RS1 G S1
 S ABSVXA="Do you want to edit or backdate the time card at this time",ABSVXB="",%=1 D ^ABSVYN Q:%<1
 I %=1 S ABSVX("MRT")="" D TC1^ABSVTED K ABSVX("MRT")
 S ABSVXA="Are you sure you want to mark this time card for retransmission",ABSVXB="",%=2 D ^ABSVYN
 I %'=1 W !,"** NO ACTION TAKEN **"
 QUIT:%<0
 I %=2 D RS1 G S1
 S X=1 D STATUS^ABSVTED
 D RS1 G S1
 ;
RS1 K DIC,Y,X,DA,NAME,%DT,MONTH S DIC("A")="Select Next Volunteer: " Q
A N %DT,CODE,COUNT,DA,BACKDATE,IDATE,OK,TC,X,X1,XDATE,Y
 ;INTRO
SE W ! S X="This option will allow you to reset the transmission status of all time cards for the specified month to 'Ready for Transmission' and 'Backdate' the card.*" D MSG^ABSVQ
 W !!
 ;SELECT MONTH
 D NOW^ABSVQ
 S %DT="AE",%DT("A")="Select MONTH/YEAR to Mark and Backdate: " D ^%DT
 Q:Y<0
 S IDATE=Y,XDATE=$$FULLDAT^ABSVU2(IDATE)
 I '$D(^ABS(503335,"AK",IDATE)) S X="No Time Cards are on file for that month.   <No Action Taken>*" D MSG^ABSVQ QUIT
 ;'OK'
 S ABSVXA="Do you also want to backdate the cards",ABSVXB="",%=3 D ^ABSVYN
 I %<0 S MSG="  <Option Terminated - No Further Action Taken.*" D MSG^ABSVQ QUIT
 S BACKDATE=$S(%=1:1,1:0)
 S ABSVXA="I will now loop through ALL time cards for "_XDATE_" and Station "_ABSV("SITE")_","
 S ABSVXA(1)="then mark each card for tranmission"_$S(BACKDATE:" and backdate.",1:"."),ABSVXA(2)="ARE YOU READY",ABSVXB="" D ^ABSVYN
 I %'=1 S X="  <No Action Taken>*" D MSG^ABSVQ Q
 ;LOOP THROUGH
 I BACKDATE D  Q:'OK
 . S OK=1
 . S DIC=503337,DIC(0)="M",X="BACKDATE" D ^DIC K DIC
 . I Y<0 D
 . . S Y=$O(^ABS(503337,"C","BD",0))
 . . I Y<0 S OK=1 QUIT
 . . S X="  Error in file 503337, contact your IRM staff."
 . . D MSG^ABSVQ
 . . S OK=0
 . . QUIT
 . S BACKDATE=+Y,CODE=$P(^ABS(503337,BACKDATE,0),"^",2)
 . QUIT
 W !!
 S X="I am now beginning the process.  Please DO NOT attempt to stop this job.*" D MSG^ABSVQ
 S DA=0,COUNT=0
 F  S DA=$O(^ABS(503335,"AK",IDATE,DA)) Q:'DA  I $D(^ABS(503335,DA,0)) DO
  . S TC=^ABS(503335,DA,0)
  . QUIT:'$D(^ABS(503330,$P(TC,"^",1),0))!($P(TC,"^",12)'=ABSV("SITE"))  W !,$P(^(0),"^",1),"  "
  . S X1=$P(TC,"^",6) K:X1]"" ^ABS(503335,"AF",X1,DA)
  . S $P(^ABS(503335,DA,0),"^",6)=1,^ABS(503335,"AF",1,DA)=""
  . S:BACKDATE $P(^ABS(503335,DA,1),"^",33,34)=BACKDATE_"^"_CODE
  . W "  <Done>"
  . S COUNT=COUNT+1
  . QUIT
 W !!,COUNT," Time Cards for "_XDATE_" have been marked for retransmission "_$S(BACKDATE:"and backdated.",1:".")
 QUIT
