TIUTPBN ; SLC/AJB - Trans Pharm Care Note ; July 29, 2003 [3/16/04 1:37pm]
 ;;1.0;TEXT INTEGRATION UTILITIES;**170,183,202**;Jun 20, 1997
 ;
 Q
EN ;
 X ^%ZOSF("EON") W IOCUON,@IOF
 N FDA,FDAIEN,MSG,POP,TIUDA,TIUFPRIV,TIUIEN,TIUPRNT,TIUTMP
 D PRE
 I $$CHKTITLE(142.5,"TIU TPBN FUTURE APPTS")<0 D  G EXIT
 . W !!,"The Health Summary Object did not install correctly."
 . W !,"Installation cannot continue."
 S TIUFPRIV=1
 S TIUIEN=$$CHKTITLE(8925.1,"TRANSITIONAL PHARMACY BENEFIT NOTE")
 S TIUIEN=$S(TIUIEN>0:TIUIEN,1:"+1")
 I $$CHKTITLE(8930,"CLINICAL COORDINATOR")<0 W !!,"Installation Error:  Class owner cannot be defined.",! G EXIT
 I TIUIEN="+1" F  D  Q:TIUPRNT>0!($D(DUOUT))
 . D GETCLASS
 . I $D(DUOUT) W !!,"Installation Aborted by User." S XPDABORT=1 Q
 . I +TIUPRNT<0 W !!,"Installation Error:  Invalid Selection.",!
 . I  W !,"A DOCUMENT CLASS must be entered or '^' to abort."
 I +$G(TIUPRNT)<0 G EXIT
 I $$MKOBJS<0 Q
 S FDA(8925.1,TIUIEN_",",.01)="TRANSITIONAL PHARMACY BENEFIT NOTE"
 S FDA(8925.1,TIUIEN_",",.02)=""
 S FDA(8925.1,TIUIEN_",",.03)="TRANSITIONAL PHARMACY BENEFIT NOTE"
 S FDA(8925.1,TIUIEN_",",.04)="DOC"
 S FDA(8925.1,TIUIEN_",",.05)=""
 S FDA(8925.1,TIUIEN_",",.06)=$$CHKTITLE(8930,"CLINICAL COORDINATOR")
 S FDA(8925.1,TIUIEN_",",.07)=13
 S FDA(8925.1,TIUIEN_",",3.02)=1
 S FDA(8925.1,TIUIEN_",",99)=$H
 D UPDATE^DIE("","FDA","FDAIEN","MSG")
 I $D(MSG) D  Q
 . W !!,"The following error message was returned:",!!
 . S MSG="" F  S MSG=$O(MSG("DIERR",1,"TEXT",MSG)) Q:MSG=""  W MSG("DIERR",1,"TEXT",MSG),!
 W !!,"Creation of TRANSITIONAL PHARMACY BENEFIT NOTE title successful...",! H 1
 I TIUIEN="+1" D
 . S TIUDA=FDAIEN(1)
 . S FDA(8925.14,"+2,"_TIUPRNT_",",.01)=FDAIEN(1)
 . S FDA(8925.14,"+2,"_TIUPRNT_",",4)="Transitional Pharmacy Benefit Note"
 . D UPDATE^DIE("","FDA","FDAIEN","MSG")
 . I $D(MSG) D  S XPDABORT=1 Q
 .. W !!,"The following error message was returned:",!!
 .. S MSG="" F  S MSG=$O(MSG("DIERR",1,"TEXT",MSG)) Q:MSG=""  W MSG("DIERR",1,"TEXT",MSG),!
 . W !,"Addition of "_$P(^TIU(8925.1,TIUPRNT,0),U)_" as parent successful...",! H 1
 I $G(TIUDA)="" S TIUDA=TIUIEN
 D GETBOIL
 K FDAIEN
 S FDAIEN(TIUDA)=TIUDA
 S FDA(8925.1,TIUDA_",",3)="TIUTMP"
 D UPDATE^DIE("","FDA","FDAIEN","MSG")
 I $D(MSG) D  Q
 . W !!,"The following error message was returned:",!!
 . S MSG="" F  S MSG=$O(MSG("DIERR",1,"TEXT",MSG)) Q:MSG=""  W MSG("DIERR",1,"TEXT",MSG),!
 W !,"Boilerplate text and objects added successfully.",!
 W !,"Update finished.",!
 W !,"*** The TRANSITIONAL PHARMACY BENEFIT NOTE title must be"
 W !,"*** activated before use.",!
EXIT D
 .N DIR,X,Y
 .S DIR(0)="E"
 .W ! D ^DIR
 Q
ADD(TXT) ;
 S NEXTLINE=NEXTLINE+1
 S @TARGET@(NEXTLINE,0)=TXT
 Q
ADDSTR(STR1,STR2,MAX) ;
 N CNT,DONE,TMP
 S CNT=0,(DONE,TMP)=""
 I '$D(STR2) D ADD(STR1) Q
 I $L(STR1)<MAX S $P(TMP," ",MAX-$L(STR1))=" ",STR1=STR1_TMP D ADD(STR1_STR2) Q
 E  F  D  Q:DONE=1
 .N TMPSTR S TMPSTR=""
 .I $L(STR1)=MAX,$E(STR1,MAX)=" " S DONE=1 D ADD(STR1_STR2) Q
 .F  D  Q:DONE=1
 ..S CNT=CNT+1
 ..I $L(TMPSTR_$P(STR1," ",CNT)_" ")<60 S TMPSTR=TMPSTR_$P(STR1," ",CNT)_" "
 ..E  S DONE=1,TMP="",$P(TMP," ",MAX-$L(TMPSTR))=" ",TMPSTR=TMPSTR_TMP D ADD(TMPSTR_STR2),ADD($P(STR1," ",CNT,999))
 Q
AOPMEDS(DFN,TARGET) ;
 N DRUG,EMPTY,INDEX,NEXTLINE,NODE,TIUSTAT,TIUSTATS,TMP,NVAMED,NVASTR
 S EMPTY=1,NEXTLINE=0
 D OCL^PSOORRL(DFN,"","")
 S TIUSTATS="^ACTIVE^REFILL^HOLD^PROVIDER HOLD^ON CALL^ACTIVE (S)^NON-VERIFIED^DRUG INTERACTIONS^INCOMPLETE^PENDING^"
 S INDEX=0
 F  S INDEX=$O(^TMP("PS",$J,INDEX))  Q:INDEX'>0  D
 .S NODE=$G(^TMP("PS",$J,INDEX,0))
 .I '($L($P(NODE,U,2))>0) Q
 .I $P(NODE,U)'["O" Q
 .S TIUSTAT=$P(NODE,U,9) I TIUSTAT="ACTIVE/SUSP" S TIUSTAT="ACTIVE (S)",$P(NODE,U,9)=TIUSTAT
 .I $F(TIUSTATS,"^"_TIUSTAT_"^")=0 Q
 .S EMPTY=0
 .S TMP($P(NODE,U,2),INDEX)=NODE
 .S TMP($P(NODE,U,2),INDEX,"P")=$P($G(^TMP("PS",$J,INDEX,"P",0)),U,2)
 .I ^TMP("PS",$J,INDEX,"SIG",0)>0 D
 ..N TIUSIG S TIUSIG=0
 ..F  S TIUSIG=$O(^TMP("PS",$J,INDEX,"SIG",TIUSIG)) Q:TIUSIG=""  S TMP($P(NODE,U,2),INDEX,"SIG",TIUSIG)=^TMP("PS",$J,INDEX,"SIG",TIUSIG,0)
 ;
 S (DRUG,INDEX)=0
 F  S DRUG=$O(TMP(DRUG)) Q:DRUG=""  F  S INDEX=$O(TMP(DRUG,INDEX)) Q:INDEX=""  D
 . S NODE=TMP(DRUG,INDEX)
 . D ADDSTR("")
 . N SIG S SIG=0
 . S NVASTR=""
 . S NVAMED=$P($P(NODE,U),";")
 . S NVAMED=$E(NVAMED,$L(NVAMED))
 . I NVAMED="N" S NVASTR="Non-VA "
 . F  S SIG=$O(TMP(DRUG,INDEX,"SIG",SIG)) Q:SIG=""  D
 ..I SIG=1 D ADDSTR(NVASTR_DRUG_" "_TMP(DRUG,INDEX,"SIG",SIG),$P(NODE,U,9),60)
 ..I SIG'=1 D ADDSTR(TMP(DRUG,INDEX,"SIG",SIG))
 . D ADDSTR(" # Refills: "_$P(NODE,U,5)," Quantity: "_$P(NODE,U,12),30)
 . D ADDSTR("Issue Date: "_$$FMTE^XLFDT($P(NODE,U,15))," Provider: "_TMP(DRUG,INDEX,"P"),30)
 ;
 I EMPTY D
 .D ADDSTR(""),ADDSTR("No Medications Found"),ADDSTR("")
 K ^TMP("PS",$J)
 Q "~@"_$NA(@TARGET)
GETBOIL ;
 N LINE,LINETXT
 F LINE=1:1 S LINETXT=$P($T(BOILTXT+LINE),";;",2) Q:LINETXT="EOM"  S TIUTMP(LINE)=LINETXT
 Q
BOILTXT ;
 ;;This patient has been identified as a new patient waiting for care from
 ;;the VA and is eligible for the transitional pharmacy program.
 ;;
 ;;Patient Name:  |PATIENT NAME|
 ;;SSN:           |PATIENT SSN|
 ;;Age:           |PATIENT AGE|
 ;;
 ;;Primary Care Provider:  |TIU TPBN PCP|
 ;;
 ;;Allergies/Adverse Reactions:
 ;;|ALLERGIES/ADR|
 ;;
 ;;Rx(s):
 ;;|TIU TPBN ACT OUT MEDS|
 ;;
 ;;Over-the-counter drugs or drugs not issued by VA but currently taking 
 ;;(Please List):
 ;;
 ;;
 ;;
 ;;Non-formulary Rx requested, not filled:
 ;;
 ;;
 ;;
 ;;Formulary Alternatives Recommended:
 ;;
 ;;
 ;;
 ;;Next appointment(s):
 ;;|TIU TPBN FUTURE APPTS|
 ;;
 ;;
 ;;Counseling:
 ;;
 ;;The patient and/or the patient's caregiver was offered counseling on
 ;;drug, dosage, schedule, route of administration, storage, potential 
 ;;side effects, significant drug interactions, and the procedure for 
 ;;obtaining refill prescriptions.
 ;;
 ;;Counseling was [] Provided     [] Refused
 ;;EOM
 Q
CHKTITLE(FILE,NAME) ;
 N DIC,X,Y
 S DIC=FILE,DIC(0)="X"
 S X=NAME
 D ^DIC
 Q +Y
GETCLASS ;
 N DIC,X,Y
 S DIC("A")="Select the DOCUMENT CLASS where the new title will be installed:  "
 S DIC(0)="AEQ",DIC="^TIU(8925.1,",DIC("S")="I $P(^(0),U,4)=""DC"""
 W ! D ^DIC
 S TIUPRNT=+Y
 Q
MKOBJS() ;
 N TIUHSO
 S TIUHSO=$$CHKTITLE(142.5,"TIU TPBN FUTURE APPTS")
 I $$MKOBJ("TIU TPBN ACT OUT MEDS","S X=$$AOPMEDS^TIUTPBN(DFN,""^TMP(""""TIUMED"""",$J)"")")<0 D  Q -1
 . W !!,"Installation Error:  TIU Object creation failed.",!
 I $$MKOBJ("TIU TPBN FUTURE APPTS","S X=$$TIU^GMTSOBJ(DFN,"_TIUHSO_")")<0 D  Q -1
 . W !!,"Installation Error:  TIU Object creation failed.",!
 I $$MKOBJ("TIU TPBN PCP","S X=$P($$OUTPTPR^SDUTL3(DFN,DT),U,2)")<0 D  Q -1
 . W !!,"Installation Error:  TIU Object creation failed.",!
 Q 1
MKOBJ(NAME,METHOD) ;
 N FDA,FDAIEN,MSG
 S FDA(8925.1,"+1,",.01)=NAME
 S FDA(8925.1,"+1,",.03)=NAME
 S FDA(8925.1,"+1,",.04)="O"
 S FDA(8925.1,"+1,",.06)=$$CHKTITLE(8930,"CLINICAL COORDINATOR")
 S FDA(8925.1,"+1,",.07)=11
 S FDA(8925.1,"+1,",9)=METHOD
 S FDA(8925.1,"+1,",99)=$H
 D UPDATE^DIE("","FDA","FDAIEN","MSG")
 I $D(MSG) D  Q -1
 . W !!,"TIU Object "_NAME_" creation failed.  The following error message was returned:",!!
 . S MSG="" F  S MSG=$O(MSG("DIERR",1,"TEXT",MSG)) Q:MSG=""  W MSG("DIERR",1,"TEXT",MSG),!
 W !!,"Creation of TIU Object "_NAME_" successful..." H 1
 Q 1
PRE ;
 N DA,DIK,NAME,X,Y
 F NAME="TIU TPBN ACT OUT MEDS","TIU TPBN FUTURE APPTS","TIU TPBN PCP" D
 .S DA=0,DA=$O(^TIU(8925.1,"B",NAME,DA))
 .S DIK="^TIU(8925.1,"
 .I DA>0 D ^DIK
 S NAME="INS^GMTSOBJ"
 D @NAME
 Q
