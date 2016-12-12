ORDEA01 ;ISP/RFR - DEA TOOLS;10/15/2014  08:09
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**218,374,350**;Dec 17, 1997;Build 77
 Q
SITE ;Edit the site-level parameter
 N DA,SITE
 S DA=$O(^ORD(100.7,0))
 I +$G(DA)=0 D
 .N FDA,ERROR,IEN
 .S SITE=$P($$SITE^VASITE(),U,2)
 .S FDA(100.7,"+1,",.01)=SITE,FDA(100.7,"+1,",.02)="YES"
 .D UPDATE^DIE("E","FDA","IEN","ERROR")
 .I $D(ERROR) D  Q
 ..N IDX
 ..S IDX=0 F  S IDX=$O(ERROR("DIERR",IDX)) Q:'IDX  D
 ...W "FILEMAN ERROR #"_ERROR("DIERR",IDX)_":",!
 ...W ERROR("DIERR",IDX,"TEXT",1)
 .S DA=IEN(1)
 I +$G(DA)>0,($G(SITE)="") S SITE=$$GET1^DIQ(100.7,DA_",",.01)
 Q:+$G(DA)=0
 W !!,"This option is used to enable or disable electronic prescribing of outpatient",!
 W "controlled substances for your entire site. Yes enables it and No disables it.",!
 W !,"CONFIGURING SITE "_SITE,!
 N DIE,DR
 S DIE="^ORD(100.7,",DR=.02
 D ^DIE
 Q
USER ;Edit user-level parameter
 N DA
 S DA=$O(^ORD(100.7,0))
 I +$G(DA)=0 D  Q
 .W !!,"NO SITE CONFIGURED.",!!
 .W "You must first run the ePCS Site Enable/Disable [OR EPCS SITE PARAMETER] option",!
 .W "before running this option.",!
 .H 4
 W !!,"This option is used to enable or disable electronic prescribing of outpatient",!
 W "controlled substances for individual users.",!
 W !,"CONFIGURING SITE "_$$GET1^DIQ(100.7,DA_",",.01),!
 N EXIT
 F  D  Q:+$G(EXIT)
 .N DIC,X,Y,DTOUT,DUOUT,IEN,ACTION,DIR,DIRUT,DIROUT
 .S DIC="^VA(200,",DIC(0)="AEQ",DIC("A")="Select the USER NAME: "
 .D ^DIC
 .S:+Y<1 EXIT=1
 .Q:+Y<1
 .S IEN=Y,ACTION=$S($D(^ORD(100.7,"C",+IEN)):"enabled^disable",1:"disabled^enable")
 .W !!,$P(IEN,U,2)_" is currently "_$P(ACTION,U,1)_"."
 .K X,Y
 .S DIR(0)="Y^A",DIR("A")="Do you want to "_$P(ACTION,U,2)_" "_$P(IEN,U,2)
 .S DIR("B")="NO"
 .D ^DIR
 .Q:$D(DIRUT)
 .I Y=1 D
 ..N FDA,ERROR,SCHEDULES,SEX
 ..I $P(ACTION,U,1)="disabled" D
 ...N RETURN,PROBLEM,OUTPUT,TEXT,DELIMIT,COUNT
 ...S RETURN=$$VDEA^XUSER(.RETURN,+IEN),SEX=$$GET1^DIQ(200,+IEN_",",4),SEX=$S(SEX="MALE":"he",SEX="FEMALE":"she",1:"it")
 ... I 'RETURN D
 .... S PROBLEM="" F  S PROBLEM=$O(RETURN(PROBLEM)) Q:PROBLEM=""  D
 ..... I PROBLEM["DEA number with no expiration date" K RETURN(PROBLEM)
 ..... I PROBLEM["expired DEA number" K RETURN(PROBLEM)
 .... S PROBLEM=$O(RETURN("")) I PROBLEM["permitted to prescribe all schedules",$O(RETURN(PROBLEM))="" S RETURN=1
 ...I RETURN D
 ....S FDA(100.71,"+1,"_DA_",",.01)=+IEN
 ....D UPDATE^DIE("S","FDA",,"ERROR")
 ...S PROBLEM="" F  S PROBLEM=$O(RETURN(PROBLEM)) Q:$G(PROBLEM)=""  D
 ....I PROBLEM'["Is permitted to prescribe" D
 .....S COUNT=+$G(COUNT)+1,PROBLEM(COUNT)=$$LOW^XLFSTR($E(PROBLEM,1))_$P($E(PROBLEM,2,*),".",1)
 .....S:PROBLEM(COUNT)["user account status:" PROBLEM(COUNT)=$P(PROBLEM(COUNT),":",1)_" is"_$P(PROBLEM(COUNT),":",2)
 ....S:PROBLEM["Is permitted to prescribe" SCHEDULES=$$LOW^XLFSTR($E(PROBLEM,1))_$E(PROBLEM,2,*)
 ...S PROBLEM=+$G(COUNT)
 ...I 'RETURN D
 ....W !!
 ....S DELIMIT=", "
 ....F COUNT=1:1:PROBLEM  D
 .....S:COUNT=PROBLEM DELIMIT=" and "
 .....S TEXT=$S($G(TEXT)'="":TEXT_DELIMIT,1:"")_PROBLEM(COUNT)
 ....S TEXT="Cannot enable "_$P(IEN,U,2)_" to sign controlled substance orders because "_$S($E(TEXT,1,4)'="user":SEX_" ",1:"")_TEXT_"."
 ....D WRAP^ORUTL(TEXT,"OUTPUT")
 ....F COUNT=1:1:OUTPUT W OUTPUT(COUNT),!
 ..I $P(ACTION,U,1)="enabled" D
 ...S FDA(100.71,$O(^ORD(100.7,"C",+IEN,DA,0))_","_DA_",",.01)="@"
 ...D FILE^DIE("S","FDA","ERROR")
 ..I $D(ERROR) D
 ...N IDX
 ...S IDX=0 F  S IDX=$O(ERROR("DIERR",IDX)) Q:'IDX  D
 ....W !!,"FILEMAN ERROR #"_ERROR("DIERR",IDX)_":",!
 ....W ERROR("DIERR",IDX,"TEXT",1),!
 ..I '$D(ERROR),($D(FDA)) D
 ...N OUTPUT,COUNT,TEXT
 ...S TEXT="Successfully "_$P(ACTION,U,2)_"d "_$P(IEN,U,2)
 ...S TEXT=TEXT_$S($G(SCHEDULES)'="":" and "_SEX_" "_SCHEDULES,1:".")
 ...D WRAP^ORUTL(TEXT,"OUTPUT")
 ...W !!
 ...F COUNT=1:1:OUTPUT W OUTPUT(COUNT),!
 Q
PRVCHK ;CHECK SINGLE PROVIDER IS PROPERLY SETUP
 N DIC,Y,X,DTOUT,DUOUT
 S DIC="^VA(200,",DIC(0)="AEOQ"
 S DIC("A")="Select the provider: "
 D ^DIC
 Q:+Y<1
 W !!
 N STATUS,RETURN,TEXT,OUTPUT,LINE,LAST
 S STATUS=$$VDEA^XUSER(.RETURN,+Y)
 S STATUS=$$CHKSWIT(.RETURN,+Y,STATUS)
 S TEXT="This provider is"_$S(STATUS=0:" not",1:"")_" able to write controlled substance orders"
 I STATUS=0 S OUTPUT=2,OUTPUT(1)=TEXT_" for the",OUTPUT(2)="following reasons:"
 I STATUS=1 S TEXT=TEXT_" and "
 S RETURN="" F  S RETURN=$O(RETURN(RETURN)) Q:$G(RETURN)=""  D
 .I STATUS=1 D
 ..I RETURN["Is permitted to prescribe" D
 ...D WRAP^ORUTL(TEXT_"is"_$P(RETURN,"Is",2),"OUTPUT")
 ...S TEXT=""
 ..I RETURN'["Is permitted to prescribe" D WRAP^ORUTL(RETURN,"LAST")
 .I STATUS=0 D
 ..I RETURN["Is permitted to prescribe" D WRAP^ORUTL("Once all of the issues above are resolved, the provider is"_$P(RETURN,"Is",2),"LAST")
 ..I RETURN'["Is permitted to prescribe" S OUTPUT=OUTPUT+1,OUTPUT(OUTPUT)=RETURN
 I '$D(OUTPUT) D WRAP^ORUTL(TEXT_"is permitted to prescribe any schedule.","OUTPUT")
 F LINE=1:1:OUTPUT W OUTPUT(LINE),!
 I $D(LAST)>9 D
 .I STATUS=1 W !,"However, the following item"_$S(LAST=1:" was",1:"s were")_" noted:",!
 .F LINE=1:1:+$G(LAST) W LAST(LINE),!
 G PRVCHK
 Q
CHKSWIT(RETURN,IEN,RETVAL) ;CHECK THE LITTLE SWITCH
 I '$D(^ORD(100.7,"C",IEN)) D
 .S RETURN("Is not an ENABLED USER in the OE/RR EPCS PARAMETERS file.")="",RETVAL=0
 Q RETVAL
REPORTS ;PROMPT THE USER FOR THE REPORT TO RUN
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,REP
 S REP("CFG")="Provider Incomplete Configuration;INCOMPL^ORDEA01A;INCOMPLQ^ORDEA01A"
 S REP("DUP")="Duplicate VA Numbers;DUPVA^ORDEA01A;DUPVAQ^ORDEA01A"
 S REP("DET")="DETOX/MAINTENANCE ID List;DETOX^ORDEA01A;DETOXQ^ORDEA01A"
 S REP("LAS")="Provider Last Names Containing Punctuation;LAST^ORDEA01B;LASTQ^ORDEA01B"
 S REP("FEE")="Fee Basis/C & A Providers Without a DEA Number;FEEDEA^ORDEA01B;FEEDEAQ^ORDEA01B"
 S REP("AUD")="Logical Access Control Audit;AUDIT^ORDEA01B;AUDITQ^ORDEA01B"
 S DIR(0)="SO"
 S REP="" F  S REP=$O(REP(REP)) Q:$G(REP)=""  S $P(DIR(0),U,2)=$P(DIR(0),U,2)_REP_":"_$P(REP(REP),";")_";"
 S DIR("A")="Select the data validation report to run"
 D ^DIR
 Q:$D(DIRUT)
 Q:'$D(REP(Y))
 S REP=Y
 D @$P(REP(Y),";",2)
 Q
DISPRMPT() ;PROMPT THE USER TO INCLUDE DISUSERED AND TERMINATED USERS
 ;RETURNS: ^ IF USER QUIT OR TIMED OUT
 ;         OTHERWISE, THE VALUE OF VARIABLE Y
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="Y"_U,DIR("A",1)="Do you want to include DISUSERed and TERMINATED users"
 S DIR("A")="in the output",DIR("B")="NO"
 D ^DIR
 Q:$D(DIRUT) U
 Q Y
