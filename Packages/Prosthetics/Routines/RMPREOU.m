RMPREOU ;HINES/HNC -Suspense Processing Utility  ;2-2-2000
 ;;3.0;PROSTHETICS;**45,55,59,135,83**;Feb 09, 1996;Build 20
 ; Add new function for working days M-F.
 ;
 ;HNC - #83, add free text ordering provider to tag WHO 3/11/05
 ;
 Q
 ;
ITEM(DA,RL) ;psas hcpcs space item name
 ;parm 1=ien 660
 ;parm 2=string length
 N DIC,DIQ,DR,ITEM
 S DIC=660,DIQ="RE",DR="4:4.5",DIQ(0)="EN" D EN^DIQ1
 S ITEM=$G(RE(660,DA,4.5,"E"))_" "_$G(RE(660,DA,4,"E"))
 I $G(RL) S ITEM=$E(ITEM,0,RL)
 K RE Q ITEM
 ;
 Q
PWRKDAY(DA)     ;working days between init action and current dateM-F.
 ;holidays are counted as working days
 ;parm 1=ien 668, DA
 ;
 N RMTO,RB,RE
 S RB=$P($G(^RMPR(668,DA,0)),U,9)
 Q:RB="" 0
 S RE=DT
 Q:RE="" 0
 D WDAY
 Q RMTO
 Q
 ;
TYPE(DA,RL) ;type of consult, suspense
 ;parm 1=ien 668
 ;parm 2=string length optional
 N DIC,DIQ,DR,TYPE
 S DIC=668,DIQ="RE",DR=9,DIQ(0)="EN" D EN^DIQ1
 S TYPE=$G(RE(668,DA,9,"E"))
 I $G(RL) S TYPE=$E(TYPE,0,RL)
 K RE Q TYPE
 ;
 ;
 Q
PDAY(DA) ;days between create and init action
 ;parm 1=ien 668
 N PDAY,X1,X2
 S PDAY=""
 S X2=$P($G(^RMPR(668,DA,0)),U,1)
 Q:X2="" PDAY
 S X1=$P($G(^RMPR(668,DA,0)),U,9)
 I X1="" S:$D(RMPRCD) X1=RMPRCD
 ;Q:X1="" PDAY
 D ^%DTC
 Q X
 ;
 Q
DES(DA,RL) ;description for manual
 ;parm 1=ien 668
 ;parm 2=string length optional
 N DES
 S DES=$G(^RMPR(668,DA,2,1,0))
 I DES="" Q DES
 I $G(RL) S DES=$E(DES,0,RL)
 Q DES
 ;
STATUS(DA,RL) ;status of suspense, open, pending, closed
 N DIC,DIQ,DR,STATUS
 S DIC=668,DIQ="RE",DR=14,DIQ(0)="EN" D EN^DIQ1
 S STATUS=$G(RE(668,DA,14,"E"))
 I STATUS="" S STATUS="UNKNOWN"
 I $G(RL) S STATUS=$E(STATUS,0,RL)
 K RE Q STATUS
 ;
WHO(DA,RL,RMPRA) ;requestor or provider
 ;DA ien to file 200
 ;RL length of return string
 ;RMPRA ien to file 668
 N DIC,DIQ,DR,WHO
 S WHO=""
 I DA="" S WHO=$P($G(^RMPR(668,RMPRA,"IFC1")),U,3)
 I (WHO'="")&($G(RL)'="") S WHO=$E(WHO,0,RL)
 I WHO'="" Q WHO
 S DIC=200,DIQ="RE",DR=.01,DIQ(0)="EN" D EN^DIQ1
 S WHO=$G(RE(200,DA,.01,"E"))
 I $G(RL) S WHO=$E(WHO,0,RL)
 K RE Q WHO
 ;
 Q
NUM ;pick number from list
 K DIR S DIR(0)="LO^"_VALMBG_":"_VALMLST D ^DIR
 Q
 ;
NUM2 ;pick a single number from a list
 K DIR S DIR(0)="N^"_VALMBG_":"_VALMLST D ^DIR
 Q
 ;
WRKDAY(DA)        ;working days between create and init action M-F.
 ;holidays are counted as working days
 ;parm 1=ien 668, DA
 ;
 N RMTO,RB,RE
 S RB=$P($G(^RMPR(668,DA,0)),U,1)
 Q:RB="" 0
 S RE=$P($G(^RMPR(668,DA,0)),U,9)
 Q:RE="" 0
 D WDAY
 Q RMTO
CWRKDAY(DA) ;working days based on today for open records.
 ;holidays are counted as working days
 ;parm 1=ien 668, DA
 N RMTO,RB,RE
 S RB=$P($G(^RMPR(668,DA,0)),U,1)
 Q:RB="" 0
 S RE=DT
 D WDAY
 Q RMTO
CANWKDY(DA) ;*135 working days between create and cancel date for cancel w/o initial action records.
 ;holidays are counted as working days
 ;parm 1=ien 668, DA
 N RMTO,RB,RE
 S RB=$P($G(^RMPR(668,DA,0)),U)
 Q:RB="" 0
 S RE=$P(^RMPR(668,DA,5),U)
 Q:RE="" 0
 D WDAY
 Q RMTO
WDAY ;       RB - begining date
 ;       RE - ending date
 ;Return variable:
 ;       RMTO - working days
 ;Changed 03/26/03 to make a call to XUWORKDY to not count Holidays
 ;In order to not couont Holidays the site must keep the Holiday file 
 ;current.
 S RMTO=$$EN^XUWORKDY(RB,RE)
 Q
 ;Set days as Monday the FIRST day and so on:
 ;       Monday    = 1
 ;       Sunday    = 7
 ;If invalid dates, return ZERO.
 N X,Y,RMB,RME,RMTOT,RDSDAY,RDEDAY,RBCA,RNOB,RMNOD,RECA,RNO
1 S X1=RE,X2=RB D ^%DTC S RMNOD=X
 S (RMTO,RMTOT,RECA)=0
 S X=RB D DW^%DTC S RMB=X
 S X=RE D DW^%DTC S RME=X
 I (RB=RE)!(RB>RE)!(RMNOD'>0) Q
 ;Get the FIRST set of Monday to Sunday days.
 S RDSDAY=$S(RMB["MON":1,RMB["TUE":2,RMB["WED":3,RMB["THU":4,RMB["FRI":5,RMB["SAT":6,RMB["SUN":7,1:0)
 S RNOB=$S(RDSDAY=1:4,RDSDAY=2:3,RDSDAY=3:2,RDSDAY=4:1,1:0)
 I RNOB=4,RMNOD<7 S RNOB=$S(RMNOD=1:1,RMNOD=2:2,RMNOD=3:3,1:4)
 I RNOB=3,RMNOD<6 S RNOB=$S(RMNOD=1:1,RMNOD=2:2,1:3)
 I RNOB=2,RMNOD<5 S RNOB=$S(RMNOD=1:1,1:2)
 S RBCA=7-RDSDAY
 S RMNOD=RMNOD-RBCA
 ;Get the SECOND set of Monday to Sunday days.
 S RDEDAY=$S(RME["MON":1,RME["TUE":2,RME["WED":3,RME["THU":4,RME["FRI":5,RME["SAT":6,RME["SUN":7,1:0)
 I RMNOD>0 D
 .S RECA=$S(RDEDAY=7:5,RDEDAY=6:5,1:RDEDAY)
 .S RMNOD=RMNOD-RDEDAY
 ;
 ;calculate totals
 S RMTOT=RMTOT+RNOB+RECA
 I RMNOD>0,RMNOD<6 S RMTOT=RMTOT+RMNOD
 I RMNOD=6 S RMTOT=RMTOT+RMNOD-1
 I RMNOD=7 S RMTOT=RMTOT+RMNOD-2
 ;if the FIRST and SECOND set of Monday to Sunday total is
 ;still greater than 7 days, exclude Saturday and Sunday - don't count.
 I RMNOD>7 S RMTOT=RMTOT+(RMNOD-((RMNOD/7)*2))
 S RMTO=$J(RMTOT,0,0)
END ;
