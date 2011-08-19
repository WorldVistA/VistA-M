TIUWRII1 ;SLC/AJB,AGP - War Related Illness and Injury Study Center ; 08/18/03
 ;;1.0;TEXT INTEGRATION UTILITIES;**159**;Jun 20, 1997
 ;
 Q
EN ;
 X ^%ZOSF("EON") W $G(IOCUON),@IOF
 N FDA,FDAIEN,MSG,POP,TIUABORT,TIUDA,TIUFPRIV,TIUPRNT
 S TIUFPRIV=1,TIUPRNT=0
 I '$$PATCH^XPDUTL("TIU*1.0*159")!($$CHKTITLE(8925.1,"WRIISC ASSESSMENT NOTE")=-1) F  D  Q:TIUPRNT>0!($D(DUOUT))
 . D GETCLASS
 . I +TIUPRNT<0 W !!,"Installation Error:  Invalid Selection.",!
 I +TIUPRNT<0 W !,"Enter EN^TIUWRII1 at the programmer prompt to re-build note title and objects.",! H 1 Q
 I $$CHKTITLE(8925.1,"WRIISC ASSESSMENT NOTE")>0,'$$PATCH^XPDUTL("TIU*1.0*159") W !!,"Installation Error:  WRIISC Assessment Note already exists.",! Q
 I $$CHKTITLE(8930,"CLINICAL COORDINATOR")<0 W !!,"Installation Error:  Class owner cannot be defined.",! Q
 D DELOBJS,MKOBJS I $G(TIUABORT)>0 D DELOBJS H 2 Q
 I '$$PATCH^XPDUTL("TIU*1.0*159")!($$CHKTITLE(8925.1,"WRIISC ASSESSMENT NOTE")=-1) D
 . S FDA(8925.1,"+1,",.01)="WRIISC ASSESSMENT NOTE"
 . S FDA(8925.1,"+1,",.03)="WRIISC ASSESSMENT NOTE"
 . S FDA(8925.1,"+1,",.04)="DOC"
 . S FDA(8925.1,"+1,",.06)=$$CHKTITLE(8930,"CLINICAL COORDINATOR")
 . S FDA(8925.1,"+1,",.07)=11
 . S FDA(8925.1,"+1,",3.02)=1
 . S FDA(8925.1,"+1,",99)=$H
 . D UPDATE^DIE("","FDA","FDAIEN","MSG")
 . I $D(MSG) D  D DELOBJS Q
 .. W !!,"The following error message was returned:",!!
 .. S MSG="" F  S MSG=$O(MSG("DIERR",1,"TEXT",MSG)) Q:MSG=""  W MSG("DIERR",1,"TEXT",MSG),!
 . W !!,"Creation of WRIISC ASSESSMENT NOTE title successful...",! H 1
 . S TIUDA=FDAIEN(1)
 . S FDA(8925.14,"+2,"_TIUPRNT_",",.01)=FDAIEN(1)
 . S FDA(8925.14,"+2,"_TIUPRNT_",",4)="WRIISC Assessment Note"
 . D UPDATE^DIE("","FDA","FDAIEN","MSG")
 . I $D(MSG) D  Q
 .. W !!,"The following error message was returned:",!!
 .. S MSG="" F  S MSG=$O(MSG("DIERR",1,"TEXT",MSG)) Q:MSG=""  W MSG("DIERR",1,"TEXT",MSG),!
 . W !,"Addition of "_$P(^TIU(8925.1,TIUPRNT,0),U)_" as parent successful...",! H 1
 W !,"Update finished."
 D
 .N DIR,X,Y
 .S DIR(0)="E"
 .W ! D ^DIR
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
 D ^DIC
 S TIUPRNT=+Y
 Q
GETLAB ;
 N DIC,X,Y
 S DIC("A")="Enter your site's local lab name for "_LABNAME_": "
 S DIC(0)="AEQ",DIC="^LAB(60,"
 W ! D ^DIC
 S LABIEN=+Y S:LABIEN>0 LABNAME=$P(Y,U,2)
 Q
MKOBJS ;
 N LABIEN,LABNAME,LINE,LINETXT,METHOD,NAME
 F LINE=1:1 S LINETXT=$P($T(DATA+LINE),";;",2) Q:LINETXT="EOM"!$G(TIUABORT)>0  D
 .S NAME=$P(LINETXT,";"),METHOD=$P(LINETXT,";",2)
 .S:METHOD["@" METHOD=$TR(METHOD,"@",";")
 .I $$CHKTITLE(8925.1,NAME)>0 W !!,"Installation Error:  TIU Object "_NAME_" already exists." H 1 Q
 .I METHOD="ASK USER" D
 ..N DUOUT,FLAG S FLAG=0
 ..S LABNAME=$P(LINETXT,";",3)
 ..I LABNAME="HEPATITIS C ANTIBODY" S FLAG=1
 ..S LABIEN=0
 ..F  Q:LABIEN>0!($D(DUOUT))  D GETLAB
 ..S:LABIEN>0 METHOD=$S(FLAG=1:"S X=$$LAB2^TIUWRIIS(DFN,"""_LABNAME_""",5,,1410102,$$NOW^XLFDT)",1:"S X=$$LAB2^TIUWRIIS(DFN,"""_LABNAME_""",5,""T-365"")")
 .I METHOD="ASK USER" D  S TIUABORT=1 Q
 ..W !!,"Installation Error:  TIU Object "_NAME_" creation aborted by user."
 ..W !,"Enter EN^TIUWRII1 at the programmer prompt to re-build note title and objects.",!
 ..W !,"See the patch description for more details."
 .I $$MKOBJ(NAME,METHOD)<0 D
 ..W !!,"Installation Error:  Creation of TIU Object "_NAME_" failed.",!
 Q
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
 . W !!,"TIU Object creation failed.  The following error message was returned:",!!
 . S MSG="" F  S MSG=$O(MSG("DIERR",1,"TEXT",MSG)) Q:MSG=""  W MSG("DIERR",1,"TEXT",MSG),!
 W !!,"Creation of TIU Object "_NAME_" successful..." H 1
 Q 1
DELOBJS ;
 N DA,DIK,LINE,LINETXT,NAME,X,Y
 F LINE=1:1 S LINETXT=$P($T(DATA+LINE),";;",2) Q:LINETXT="EOM"  D
 .S NAME=$P(LINETXT,";")
 .S DA=0,DA=$O(^TIU(8925.1,"B",NAME,DA))
 .S DIK="^TIU(8925.1,"
 .I DA>0 D ^DIK
 Q
DATA ;
 ;;VA-WRIISC ADDRESS;S X=$$ADDRESS^TIUWRIIS(DFN)
 ;;VA-WRIISC ACTIVE PROBLEMS;S X=$$PROB^TIUWRIIS(DFN)
 ;;VA-WRIISC NEXT OF KIN;S X=$$PNOK^TIUWRIIS(DFN)
 ;;VA-WRIISC VITALS;S X=$$VITALS^TIUWRIIS(DFN,"T@BP@P@R",1,"T-90")
 ;;VA-WRIISC CBC;ASK USER;CBC
 ;;VA-WRIISC GLUCOSE;ASK USER;GLUCOSE
 ;;VA-WRIISC HEMATOCRIT;ASK USER;HEMATOCRIT
 ;;VA-WRIISC HEMOGLOBIN;ASK USER;HEMOGLOBIN
 ;;VA-WRIISC HEPATITIS C ANTIBODY;ASK USER;HEPATITIS C ANTIBODY
 ;;VA-WRIISC POTASSIUM;ASK USER;POTASSIUM
 ;;VA-WRIISC SODIUM;ASK USER;SODIUM
 ;;VA-WRIISC URINALYSIS;ASK USER;URINALYSIS
 ;;EOM
 Q
