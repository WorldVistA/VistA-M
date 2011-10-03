WVBRNOT2 ;HCIOFO/FT,JR IHS/ANMC/MWR - BROWSE NOTIFICATIONS;
 ;;1.0;WOMEN'S HEALTH;;Sep 30, 1998
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  PROMPTS FOR SELECTION CRITERIA WHEN BROWSING NOTIFICATIONS.
 ;;  CALLED BY WVBRNOT.
 ;
 D SETVARS^WVUTL5
 D TITLE^WVUTL5("BROWSE NOTIFICATIONS")
 D ONEALL Q:WVPOP
 D DATES  Q:WVPOP
 D STATUS Q:WVPOP
 D CMGR   Q:WVPOP
 D ORDER  Q:WVPOP
 D DEVICE Q:WVPOP
 Q
 ;
ONEALL ;EP
 ;---> SELECT ONE PATIENT OR ALL PATIENTS.
 K DIR
 W !!?3,"Browse Notifications for ONE individual patient,"
 W !?3,"or browse Notifications for ALL patients?"
 S DIR("A")="   Select ONE or ALL: ",DIR("B")="ALL"
 S DIR(0)="SAM^o:ONE;a:ALL" D HELP2
 D ^DIR K DIR
 I Y=-1!($D(DIRUT)) S WVPOP=1 Q
 ;---> IF ALL PATIENTS, S WVA=1 AND QUIT.
 I Y="a" S WVA=1 Q
 ;
 W !!,"   Select the patient whose Notifications you wish to browse."
 D PATLKUP^WVUTL8(.Y)
 I Y<0 S WVPOP=1 Q
 ;---> FOR ONE PATIENT, SET WVA=0 AND WVDFN=PATIENT DFN, QUIT.
 S WVDFN=+Y,WVA=0,WVCMGR=$P(^WV(790,WVDFN,0),U,10)
 Q
 ;
DATES ;EP
 ;---> ASK DATE RANGE.  RETURN DATES IN WVBEGDT AND WVENDDT.
 ;---> IF LOOKING AT ONLY ONE PATIENT, SET DEFAULT BEGIN DATE=T-365.
 S WVBEGDF=$S(WVA:"T-30",1:"T-365")
 D ASKDATES^WVUTL3(.WVBEGDT,.WVENDDT,.WVPOP,WVBEGDF,"T")
 Q
 ;
STATUS ;EP
 ;---> GET XREF: OPEN OR ALL
 W !!?3,"Do you wish to browse DELINQUENT, OPEN, QUEUED, "
 W "or ALL Notifications?"
 S DIR("A")="   Select DELINQUENT, OPEN, QUEUED or ALL: "
 S DIR("B")="OPEN"
 S DIR(0)="SAM^d:DELINQUENT;o:OPEN;q:QUEUED;a:ALL" D HELP4
 D ^DIR K DIR
 I Y=-1!($D(DIRUT)) S WVPOP=1 Q
 S WVB=Y
 Q
 ;
CMGR ;EP
 ;---> SELECT CASES FOR ONE CASE MANAGER OR ALL.
 ;---> DO NOT PROMPT FOR CASE MANAGER IF SITE PARAMETERS SAY NOT TO,
 ;---> OR IF LOOKING AT PROCEDURES FOR ONLY ONE PATIENT.
 I '$D(^WV(790.02,DUZ(2),0)) S WVE=1 Q
 I '$P(^WV(790.02,DUZ(2),0),U,5)!('WVA) S WVE=1 Q
 W !!?3,"Browse Notifications for ONE particular Case Manager,"
 W !?3,"or browse Notifications for ALL Case Managers?"
 S DIR("A")="   Select ONE or ALL: ",DIR("B")="ALL"
 S DIR(0)="SAM^o:ONE;a:ALL" D HELP5
 D ^DIR K DIR
 I Y=-1!($D(DIRUT)) S WVPOP=1 Q
 ;---> IF ALL CASE MANAGERS, S WVE=1 AND QUIT.
 I Y="a" S WVE=1 Q
 ;
 W !!,"   Select the Case Manager whose patients you wish to browse."
 ;
 D DIC^WVFMAN(790.01,"QEMA",.Y,"   Select CASE MANAGER: ")
 I Y<0 S WVPOP=1 Q
 ;---> FOR ONE CASE MANAGER, SET WVE=0 AND WVCMGR=^VA(200 DFN, QUIT.
 S WVCMGR=+Y,WVE=0
 Q
 ;
 ;
ORDER ;EP
 ;---> ASK ORDER BY DATE OR BY PATIENT OR BY PRIORITY.
 ;---> IF LOOKING AT ONLY ONE PATIENT, ORDER BY DATE AND QUIT.
 I 'WVA S WVC=1 Q
 ;
 ;---> SORT SEQUENCE IN WVC:  1=DATE, PATIENT, PRIORITY
 ;--->                        2=PATIENT, DATE, PRIORITY
 ;--->                        3=PRIORITY, DATE, PATIENT
 ;
 W !!?3,"Display Notifications in order of:"
 W ?39,"1) DATE OF NOTIFICATION (earliest first)"
 W !?39,"2) NAME OF PATIENT (alphabetically)"
 W !?39,"3) PRIORITY (beginning with URGENT)"
 S DIR("A")="   Select 1, 2, or 3: ",DIR("B")=1
 S DIR(0)="SAM^1:DATE;2:NAME;3:PRIORITY" D HELP3
 D ^DIR K DIR
 I Y=-1!($D(DIRUT)) S WVPOP=1 Q
 S WVC=Y
 Q
 ;
DEVICE ;EP
 ;---> GET DEVICE AND POSSIBLY QUEUE TO TASKMAN.
 S ZTRTN="DEQUEUE^WVBRNOT"
 F WVSV="A","B","C","D","E","CMGR","DFN","BEGDT","ENDDT" D
 .I $D(@("WV"_WVSV)) S ZTSAVE("WV"_WVSV)=""
 D ZIS^WVUTL2(.WVPOP,1,"HOME")
 Q
 ;
HELP2 ;EP
 ;;Answer "ONE" to browse Notifications for ONE particular patient.
 ;;Answer "ALL" to browse Notifications for ALL patients.
 S WVTAB=5,WVLINL="HELP2" D HELPTX
 Q
 ;
HELP3 ;EP
 ;;Enter "DATE" to list Notifications in chronological order beginning
 ;;   with the oldest first.
 ;;Enter "NAME" to list Notifications by Patient Name in alphabetical
 ;;   order.
 ;;Enter "PRIORITY" to list Notifications by degree of urgency,
 ;;   beginning with the most urgent first.
 S WVTAB=5,WVLINL="HELP3" D HELPTX
 Q
 ;
HELP4 ;EP
 ;;"OPEN Notifications" are ones that have not yet been closed,
 ;;     in other words, the patient has not yet been reached or has not
 ;;     yet responded.
 ;;
 ;;"DELINQUENT Notifications" are OPEN Notifications that have remained
 ;;     open past the date they were due to be closed (as determined by
 ;;     the "DATE DELINQUENT BY" field in the Edit Notification screen).
 ;;
 ;;"QUEUED Notifications" are only LETTERS waiting to be printed.
 ;;     They do not include letters that have already been printed.
 ;;
 ;;"ALL Notifications" includes DELINQUENT, OPEN and CLOSED.
 ;;     CLOSED notifications are ones that have been brought to closure,
 ;;     in other words, either the patient has been contacted or the
 ;;     case is no longer active.
 S WVTAB=5,WVLINL="HELP4" D HELPTX
 Q
 ;
HELP5 ;EP
 ;;Answer "ONE" to browse Notifications for ONE particular Case Manager.
 ;;Answer "ALL" to browse Notifications for ALL Case Managers.
 S WVTAB=5,WVLINL="HELP5" D HELPTX
 Q
 ;
HELPTX ;EP
 ;---> CREATES DIR ARRAY FOR DIR.  REQUIRED VARIABLES: WVTAB,WVLINL.
 N I,T,X S T=$$REPEAT^XLFSTR(" ",WVTAB)
 F I=1:1 S X=$T(@WVLINL+I) Q:X'[";;"  S DIR("?",I)=T_$P(X,";;",2)
 S DIR("?")=DIR("?",I-1) K DIR("?",I-1)
 Q
