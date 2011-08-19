FSCUEDIT ;SLC/STAFF-NOIS Utilities Edit ;1/17/98  17:13
 ;;1.1;NOIS;;Sep 06, 1998
 ;
FILES ; from FSCOPT
 N DIR,FILE,X,Y K DIR
 S DIR(0)="SAMO^CALL:CALL;FORMAT:FORMAT;FUNC:FUNC;OFFICE:OFFICE;LIST:LIST;MOD:MOD;PACK:PACK;PARAM:PARAM;RPT:RPT;SITE:SITE;SPEC:SPEC;STATUS:STATUS;SUB:SUB;TASK:TASK;WORK:WORK"
 S DIR("?",1)="Enter the file you wish to review."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 W !,"These are files you can review (editing only by supervisors).",!
 S DIR("A",1)="          Call"
 S DIR("A",2)="          Format"
 S DIR("A",3)="          Functional Area"
 S DIR("A",4)="          List"
 S DIR("A",5)="          Module"
 S DIR("A",6)="          Office"
 S DIR("A",7)="          Package"
 S DIR("A",8)="          Parameter"
 S DIR("A",9)="          Reports"
 S DIR("A",10)="          Site"
 S DIR("A",11)="          Specialist"
 S DIR("A",12)="          Status History"
 S DIR("A",13)="          Subcomponent"
 S DIR("A",14)="          Task"
 S DIR("A",15)="          Workload"
 S DIR("A",16)=""
 S DIR("A")="Select file: "
 D ^DIR K DIR
 I $D(DIRUT) Q
 I '$L(Y) Q
 S FILE=Y
 N DIR,X,Y K DIR
 S DIR(0)="SAMO^PRINT:PRINT;SEARCH:SEARCH;INQUIRE:INQUIRE"
 S DIR("A")="Select (P)rint, (S)earch, (I)nquire"_$S($$ACCESS^FSCU(DUZ,"SUPER"):"/Edit",1:"")_": "
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
 I Y="INQUIRE" D INQUIRE(FILE) Q
 Q
 ;
PRINT(FILE) ;
 N DIC,L
 S DIC=$S(FILE="CALL":"^FSCD(""CALL"",",FILE="WORK":"^FSCD(""WKLD"",",FILE="STATUS":"^FSCD(""STATUS HIST"",",FILE="OFFICE":"^FSC(""ISC"",",1:"^FSC("""_FILE_""","),L="LIST "_$P(@(DIC_"0)"),U)
 D EN1^DIP
 Q
 ;
SEARCH(FILE) ;
 N DIC
 S DIC=$S(FILE="CALL":"^FSCD(""CALL"",",FILE="WORK":"^FSCD(""WKLD"",",FILE="STATUS":"^FSCD(""STATUS HIST"",",FILE="OFFICE":"^FSC(""ISC"",",1:"^FSC("""_FILE_""",")
 D EN^DIS
 Q
 ;
INQUIRE(FILE) ;
 N CONTINUE S CONTINUE=1
 I FILE="OFFICE" S FILE="ISC"
 F  D  I 'CONTINUE Q
 .N ENTRY,DR,OK
 .W ! D LOOKUP^FSCULOOK(FILE,.ENTRY,$S($$ACCESS^FSCU(DUZ,"SUPER"):"AELMOQ",1:"AEMOQ"),.OK)
 .I 'OK S CONTINUE=0 Q
 .D SHOW(FILE,+ENTRY,.OK)
 .I FILE="SITE",DUZ=$P(^FSC("SITE",+ENTRY,0),U,6) D EDIT(FILE,+ENTRY,"3:5.4",.OK) Q
 .I '$$ACCESS^FSCU(DUZ,"SUPER") D PAUSE^FSCU(.OK) Q
 .I FILE="CALL" W !!,"NOIS calls should be edited using other options." H 2 Q
 .I FILE="WORK" W !!,"NOIS workload should be edited using other options." H 2 Q
 .I FILE="STATUS" W !!,"NOIS Status History should be edited using other options." H 2 Q
 .S DR=".01R;.02:999"
 .I FILE="PARAM" S DR="100:101;8"
 .D EDIT(FILE,+ENTRY,DR,.OK)
 Q
 ;
EDIT(FILE,DA,DR,OK) ;
 N DIE,GBL S OK=1
 D FILE(FILE,DA,.DIE,.GBL,.OK)
 I 'OK Q
 L +@GBL:30 I '$T W !,"Unable to edit." Q
 D ^DIE
 L -@GBL
 Q
 ;
FILE(FILE,ENTRY,DIE,GBL,OK) ;
 S OK=0
 I '$D(^FSC(FILE,0)) Q
 S DIE="^FSC("""_FILE_""",",GBL=DIE_ENTRY_")",OK=1
 Q
 ;
SHOW(FILE,DA,OK) ;
 N DIC
 S OK=0
 S DIC=$S(FILE="CALL":"^FSCD(""CALL"",",FILE="WORK":"^FSCD(""WKLD"",",FILE="STATUS":"^FSCD(""STATUS HIST"",",FILE="OFFICE":"^FSC(""ISC"",",1:"^FSC("""_FILE_""",")
 I '$D(@(DIC_"0)")) Q
 D EN^DIQ S OK=1
 Q
