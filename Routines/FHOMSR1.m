FHOMSR1 ;Hines OIFO/RTK SPECIAL MEALS REQUEST MEAL  ;4/02/03  15:05
 ;;5.5;DIETETICS;**2,5,11**;Jan 28, 2005;Build 4
 ;
 S (FHORN,FHDIET)="",FHKEY=0,FHMSG1="S"
 D ^FHOMDPA I FHDFN="" Q
 I '$D(^FHPT(FHDFN,0)) W !!,"UNKNOWN SELECTION !" Q
 D SMSTAT^FHOMUTL I FHSTAT="P" D MSG1 Q
 I $D(^XUSEC("FHAUTH",DUZ)) S FHKEY=1
LOC ;Prompt for outpatient location
 W ! D OUTLOC^FHOMUTL I FHLOC="" D EXMSG^FHOMUTL Q
 W ! D RMBED^FHOMUTL
DIET ;Prompt for diet
 D DIETLST^FHOMUTL
 I FHDEF="" W !!,"NO DEFAULT OUTPATIENT DIET SET!!",! Q
 S FHDEF=$P($G(^FH(111,FHDEF,0)),U,1)
 K DIC S DIC="^FH(111,",DIC("A")="Select DIET NAME: ",DIC(0)="AEMQZ"
 S DIC("B")=FHDEF,DIC("S")="I $D(FHDIETS(+Y))" D ^DIC
 I $D(DUOUT) D EXMSG^FHOMUTL Q
 I Y=-1 D EXMSG^FHOMUTL Q
 S FHDIET=+Y
MEAL ;Prompt for meal
 K DIR,DIC S DIR("A")="Select Meal: "
 S DIR(0)="SAO^B:Breakfast;N:Noon;E:Evening"
 D ^DIR I $D(DIRUT) D EXMSG^FHOMUTL Q
 I Y'=-1 S FHMEAL=Y
 D CHECKRM I FHRMYES=1 D MSG2 Q
 W ! K DIR S DIR("A")="Is this correct?: ",DIR(0)="YA",DIR("B")="Y"
 D ^DIR
 S CONT=Y I CONT'=1 D EXMSG^FHOMUTL Q
 D NOW^%DTC S FHNOW=%,STDT=DT,FHLTFLG=0 D SMGM^FHOMRO2
 I SKIP=1 D EXMSG^FHOMUTL Q
 S FHQEL=1 I FHLTFLG=1 S FHSM=FHNOW,FHEL="L",FHQEL=0 D LATE I FHQEL=1 D EXMSG^FHOMUTL Q
 S FHSTAT=$S(FHKEY=1:"A",1:"P") D SETNODE,UPD100
 I FHQEL=0 D UPDE100
 D OKMSG^FHOMUTL
 I FHKEY=1 D PRINT
 I FHKEY=0 D ALERT
 D END Q
PRINT ;If user has key allow printing without sending alert to authorizor(s)
 W ! S DIR(0)="YA",DIR("B")="Y",DIR("A")="Print Voucher? " D ^DIR
 Q:$D(DIRUT)  S PRINT=Y I PRINT'=1 Q
 S FHCDT=FHDFN_"^"_FHNOW,FHREQPR=1 D DEV^FHOMSP1 K FHREQPR Q
ALERT ;Send alert to 15 Authorizors set up in file #119.9 (fields 9-13,40-49)
 K XQA,FHAU15 S FHAU15=$P($G(^FH(119.9,1,0)),U,7,11)_"^"_$P($G(^FH(119.9,1,1)),U,11,20)
 F A=1:1:15 S AB=$P(FHAU15,U,A) I AB'="" S XQA(AB)=""
 I '$D(XQA) D
 .W !!?5,"NOTICE: No 'Authorizing Person(s)' defined in site "
 .W !!?5,"parameter (#119.9) file -- NO ALERT SENT",!! Q
 D PATNAME^FHOMUTL
 S XQAMSG=$E(FHPTNM,1,9)_" ("_$E(FHPTNM,1,1)_$P(FHSSN,"-",3)_"): "
 S XQAMSG=XQAMSG_"Special Meal needs authorizing" D SETUP^XQALERT
 Q
SETNODE ;
 S AUDUZ=$S(FHSTAT="A":DUZ,1:""),AUFHNOW=$S(FHSTAT="A":FHNOW,1:"")
 S (FHSMID,Y)=FHNOW K DIC,DO S DA(1)=FHDFN,DIC="^FHPT("_DA(1)_",""SM"","
 S DIC(0)="L",DIC("P")=$P(^DD(115,17,0),U,2),X=+Y,DINUM=X
 D FILE^DICN I Y=-1 Q
 K DIE S DA(1)=FHDFN,DIE="^FHPT("_DA(1)_",""SM"","
 S DA=+Y,FHDA=DA
 S DR="1////^S X=FHSTAT;2////^S X=FHLOC;2.5////^S X=FHRMBD;3////^S X=FHDIET;3.5////^S X=FHMEAL;4////^S X=DUZ;5////^S X=AUDUZ;6////^S X=AUFHNOW;14////^S X=FHORN"
 D ^DIE
 I FHQEL=0 D ORDEL
 S FHZN=$G(^FHPT(FHDFN,"SM",FHDA,0))
 S FHACT="O",FHOPTY="S",FHOPDT=$P(FHNOW,".",1) D SETSM^FHOMRO2
 Q
MSG1 ;
 W !!,"This patient already has a pending Special Meal request for "
 S DTP=DT D DTP^FH W DTP," " Q
MSG2 ;
 W !!,"This patient already has a Recurring Meal ordered for "
 S DTP=DT D DTP^FH W DTP," "
 W $S(FHMEAL="B":"Breakfast",FHMEAL="N":"Noon",1:"Evening") Q
CHECKRM ; Check if the OP has an existing RM for this date/meal
 S FHRMYES=0
 F FHZ=0:0 S FHZ=$O(^FHPT(FHDFN,"OP","B",DT,FHZ)) Q:FHZ'>0!(FHZ>DT)  D
 .I $P($G(^FHPT(FHDFN,"OP",FHZ,0)),U,4)'=FHMEAL Q
 .I $P($G(^FHPT(FHDFN,"OP",FHZ,0)),U,15)="C" Q
 .S FHRMYES=1
 Q
END ;Kill local variables before exiting
 K A,AA,AB,BAG,CCC,CONT,DIC,DIR,ENDL,ENDT,FHDFN,FHDAYS,FHDEF
 K FHDIET,FHDIETS,FHSTAT,FHZ,STDT,STDTIM Q
 ;
LATE ;
 S FHCOMM=$P($G(^FH(119.6,FHLOC,0)),U,8),FHCOMM1=$G(^FH(119.73,FHCOMM,1))
 S FH1=$S(FHMEAL="B":1,FHMEAL="N":7,1:13) I FHEL="L" S FH1=FH1+3
TIME S FH3=FH1+2,FHCNT=0 F FHT=FH1:1:FH3 D
 .I $P(FHCOMM1,U,FHT)="" Q
 .S FHCNT=FHCNT+1,FHTM(FHCNT)=$P(FHCOMM1,U,FHT)
 W !,"Select Time: ( " F J=1:1:FHCNT W J,"=",FHTM(J)," "
 R ") ",FHS:DTIME I FHS=""!(FHS["^") S FHQEL=1 Q
 I (FHS'?1N)!(FHS<1)!(FHS>FHCNT) W !!,"Invalid time selection!" D TIME Q
 S FHTIME=FHTM(FHS),X=$E(FHNOW,1,7)_"@"_FHTIME,%DT="XT" D ^%DT S FHTRAY=Y
 D NOW^%DTC I FHTRAY<% W !!,"Cannot order for a time before now!" D TIME Q
 S FHBAG="N" I $P($G(^FH(119.73,FHCOMM,2)),U,10)="Y" D
 . K DIR S DIR(0)="SAO^Y:Yes;N:No",DIR("A")="Bagged Meal? ",DIR("B")="N"
 . D ^DIR I $D(DIRUT) S FHQEL=1 Q
 . S FHBAG=Y
 Q
ORDEL ;
 S DA=FHSM,DA(1)=FHDFN,DIE="^FHPT("_DA(1)_",""SM"","
 S DR="8////^S X=FHTIME;9////^S X=FHBAG;10////^S X=DUZ" D ^DIE
 Q
UPD100 ;Backdoor message to update file #100 with a new SM order
 Q:'$$PATCH^XPDUTL("OR*3.0*215")  ;must have CPRSv26 for O.M. backdoor
 Q:'DFN  K MSG D MSHOM^FHOMUTL  ;Sets MSG(1), MSG(2) & MSG(3) for OM
 S FILL="S;"_FHNOW
 S FHOMEAL=$S(FHMEAL="B":1,FHMEAL="N":3,FHMEAL="E":5,1:"")
 S FHDIETNM=$P($G(^FH(111,FHDIET,0)),U,1),FHODT=$$FMTHL7^XLFDT(FHNOW)
 S MSG(4)="ORC|SN||"_FILL_"^FH||||^^^"_FHODT_"^"_FHODT_"||||||||"_FHODT
 S MSG(5)="ODS|S|"_FHOMEAL_"|^^^"_FHDIET_"^"_FHDIETNM_"^99FHD|"
 D EVSEND^FHWOR
 Q
UPDE100 ;Backdoor message to update file #100 with a new SM Late Tray order
 Q:'$$PATCH^XPDUTL("OR*3.0*215")  ;must have CPRSv26 for O.M. backdoor
 Q:'DFN  K MSG D MSHOM^FHOMUTL  ;Sets MSG(1), MSG(2) & MSG(3) for OM
 S FILL="G;"_FHNOW,FHODT=$$FMTHL7^XLFDT(FHNOW)
 S FHTRAY=$$FMTHL7^XLFDT(FHTRAY)
 S FHOMELN=FHMEAL_"L"_FHS,FHOBAG="" I FHBAG="Y" S FHOBAG="bagged"
 S MSG(4)="ORC|SN||"_FILL_"^FH||||^^^"_FHTRAY_"^"_FHTRAY_"||||||||"_FHODT
 S MSG(5)="ODT|LATE|^^^"_FHOMELN_"^^99FHD|"_FHOBAG
 D EVSEND^FHWOR
 Q
