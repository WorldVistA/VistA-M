FSCUEDS ;SLC/STAFF-NOIS Utilities Edit Schedules ;7/12/95  14:36
 ;;1.1;NOIS;;Sep 06, 1998
 ;
FILES ; from FSCOPT
 N DIR,FILE,X,Y K DIR
 S DIR(0)="SAMO^SCHEDULES:SCHEDULES;EVENTS:EVENTS;RECURRING EVENTS:RECURRING EVENTS"
 S DIR("?",1)="Enter the file you wish to review."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 W !,"These are files you can review.",!
 S DIR("A",1)="          Schedule"
 S DIR("A",2)="          Events"
 S DIR("A",3)="          Recurring Events"
 S DIR("A",4)=""
 S DIR("A")="Select file: "
 D ^DIR K DIR
 I $D(DIRUT) Q
 I '$L(Y) Q
 S FILE=Y
 N DIR,TRAN,X,Y K DIR
 S TRAN=0 I FILE["EVENT",$$ACCESS^FSCU(DUZ,"SUPER") S TRAN=1
 S DIR(0)="SAMO^PRINT:PRINT;SEARCH:SEARCH;INQUIRE:INQUIRE"_$S(TRAN:";TRANSFER:TRANSFER;DELETE:DELETE",1:"")
 S DIR("A")="Select (P)rint, (S)earch, (I)nquire/Edit"_$S(TRAN:", (T)ransfer, (D)elete",1:"")_": "
 S DIR("?",1)="Enter PRINT to print the file."
 S DIR("?",2)="Enter SEARCH the file."
 S DIR("?",3)="Enter INQUIRE to inquire on the file."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 I '$L(Y) Q
 I Y="PRINT" D PRINT(FILE) Q
 I Y="SEARCH" D SEARCH(FILE) Q
 I Y="INQUIRE" D  Q
 .I '$$ACCESS^FSCU(DUZ,"SUPER") D
 ..N DIR,X,Y K DIR
 ..S DIR(0)="SAMO^INQUIRE:INQUIRE;NEW:NEW"
 ..S DIR("A")="Select (I)nquire/Edit or (N)ew: "
 ..S DIR("B")="INQUIRE"
 ..S DIR("?",1)="Enter INQUIRE to inquire on the file."
 ..S DIR("?",2)="Enter NEW to make a new entry."
 ..S DIR("?")="^D HELP^FSCU(.DIR)"
 ..S DIR("??")="FSC U1 NOIS"
 ..D ^DIR K DIR
 ..I $D(DIRUT) Q
 ..I '$L(Y) Q
 ..I Y="INQUIRE" D INQUIRE(FILE) Q
 ..I Y="NEW" D NEW Q
 .E  D INQUIRE(FILE) Q
 I Y="TRANSFER" D ADD^FSCEVENT Q
 I Y="DELETE" D DEL^FSCEVENT Q
 Q
 ;
NEW ;
 N DIR,END,START,X,Y K DIR
 S START=$E(DT,1,3)-1_"0101",END=$E(DT,1,3)+1_"1201"
 S DIR(0)="DAO^"_START_":"_END_":EX"
 S DIR("?",1)="Enter the schedule date."
 S DIR("?")="^D HELP^%DTC,HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 S DIR("A")="Select Date: "
 D ^DIR K DIR
 I $D(DIRUT) Q
 I '$L(Y) Q
 S X=Y
 N DIC,DO,Y K DIC,DO,Y
 S DIC="^FSCD(""SCHEDULE"",",DIC(0)="AEMQL",DIC("DR")="1///^S X=DUZ;2:999"
 D FILE^DICN K DIC,Y
 Q
 ;
PRINT(FILE) ;
 N DIC,L
 I FILE="SCHEDULES" S DIC="^FSCD(""SCHEDULE"","
 I FILE="EVENTS" S DIC="^FSCD(""EVENTS"","
 I FILE="RECURRING EVENTS" S DIC="^FSC(""REVENT"","
 S L="LIST "_$P(@(DIC_"0)"),U)
 D EN1^DIP
 Q
 ;
SEARCH(FILE) ;
 N DIC
 I FILE="SCHEDULES" S DIC="^FSCD(""SCHEDULE"","
 I FILE="EVENTS" S DIC="^FSCD(""EVENTS"","
 I FILE="RECURRING EVENTS" S DIC="^FSC(""REVENT"","
 D EN^DIS
 Q
 ;
INQUIRE(FILE) ;
 N CONTINUE,DIC K DIC S CONTINUE=1
 I FILE="SCHEDULES" S DIC="^FSCD(""SCHEDULE"",",DIC(0)="AEMQ",DIC("S")="I $P(^(0),U,2)=DUZ!$$ACCESS^FSCU(DUZ,""SUPER"")"
 I FILE="EVENTS" S DIC="^FSCD(""EVENTS"",",DIC(0)="AEMQ"
 I FILE="RECURRING EVENTS" S DIC="^FSC(""REVENT"",",DIC(0)="AEMQ"
 I DIC(0)'["L",$$ACCESS^FSCU(DUZ,"SUPER") S DIC(0)=DIC(0)_"L"
 N ZERODIC S ZERODIC=DIC(0)
 F  D  I 'CONTINUE Q
 .N ENTRY,EDIT,DR,OK
 .S DIC(0)=ZERODIC
 .S OK=1 W ! D ^DIC I Y<1 S OK=0
 .I 'OK S CONTINUE=0 Q
 .S ENTRY=Y,EDIT=DIC
 .D SHOW(EDIT,+ENTRY,.OK)
 .I '$$ACCESS^FSCU(DUZ,"SUPER"),DIC["EVENT" D PAUSE^FSCU(.OK) Q
 .S DR=".01:999"
 .I DIC["SCHEDULE",'$$ACCESS^FSCU(DUZ,"SUPER") S DR=".01;2:999"
 .D EDIT(EDIT,+ENTRY,DR,.OK)
 Q
EDIT(EDIT,DA,DR,OK) ;
 N DIE,GBL S OK=1
 D FILE(EDIT,DA,.DIE,.GBL,.OK)
 I 'OK Q
 L +@GBL:30 I '$T W !,"Unable to edit." Q
 D ^DIE
 L -@GBL
 Q
 ;
FILE(DIC,ENTRY,DIE,GBL,OK) ;
 S OK=0
 I '$D(@(DIC_"0)")) Q
 S DIE=DIC,GBL=DIE_ENTRY_")",OK=1
 Q
 ;
SHOW(DIC,DA,OK) ;
 S OK=0
 I '$D(@(DIC_"0)")) Q
 D EN^DIQ S OK=1
 Q
