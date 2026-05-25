ORY535R ;ISL/TDP - Restore-install for patch OR*3*535 ;Sep 12, 2024@13:35:57
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**535**;Dec 17, 1997;Build 20
 ;
CLRINDX ;Delete the "B" index of file 100.04
 N DIK
 D BMES^XPDUTL("Clearing 'B' indexes for file 100.04")
 S DIK="^ORD(100.04,",DIK(1)=".01"
 D ENALL2^DIK
 D MES^XPDUTL("   Completed!")
 Q
 ;
RSTR ; Initiate restore processes
 D ACTIV("METFORMIN EGFR - LAB RESULTS",1,0)
 D ACTIV("GLUCOPHAGE - LAB RESULTS",0,0)
 D RENAME("^OCXS(860.3,","METFORMIN ORDER","GLUCOPHAGE ORDER")
 D RECOMPILE
 D RMVLCL
 D RMVB
 D CLRINDX
 D REINDEX
 ;D RMVPARAM ;Unable to remove entries as the parameter is removed before this routine is run.
 Q
 ;
ACTIV(ORCHKRL,ORACTIV,PST) ; Inactivate Order Check Rule
 ; ORCHKRL = Name of Order Check Rule in file 860.2
 ; ORACTIV = Status of Order Check Rule. 0 = Active, 1 = Inactive, No value defaults to Active
 ; PST = Indicates METFORMIN EGFR - LAB RESULTS from Post-init code (1 = yes, 0 = no)
 N ORACT,ORACT1,ORCHKRLIEN
 Q:$G(ORCHKRL)=""
 S ORACTIV=+$G(ORACTIV) D
 . I ORACTIV=1 S ORACT="Inactivating ",ORACT1="inactivated."
 . E  S ORACT="Activating ",ORACT1="activated."
 S ORCHKRLIEN=$O(^OCXS(860.2,"B",ORCHKRL,0))
 I 'ORCHKRLIEN D  Q
 . I PST Q  ;METFORMIN EGFR - LAB RESULTS won't exist yet on initial install
 . D BMES^XPDUTL("   "_ORCHKRL_" does not exist in the ORDER CHECK")
 . D MES^XPDUTL("      RULE (#860.2) file.")
 . Q
 I +$G(^OCXS(860.2,ORCHKRLIEN,"INACT"))=ORACTIV D  Q
 . D BMES^XPDUTL("   "_ORCHKRL_" is already "_ORACT1_" ABORTING action!")
 . Q
 D BMES^XPDUTL(ORACT_ORCHKRL_" in the ORDER CHECK")
 D MES^XPDUTL("   RULE (#860.2) file.")
 S ^OCXS(860.2,ORCHKRLIEN,"INACT")=ORACTIV
 D BMES^XPDUTL("   "_ORCHKRL_" has been "_ORACT1)
 Q
 ;
RENAME(FILE,OROLD,ORNEW) ; Rename file entry
 N CNT,DA,DIC,DIE,DO,DR,FILENM,TEXT,X,Y
 Q:$G(FILE)=""
 Q:$G(OROLD)=""
 Q:$G(ORNEW)=""
 S (DIC,DIE)=FILE
 S DIC(0)="X"
 S X=OROLD
 D ^DIC Q:Y<1
 S DA=+Y
 I 'DA Q
 S DIE="^OCXS(860.3,",DR=".01///"_ORNEW
 D ^DIE
 S FILENM=FILE
 S DO=""
 D DO^DIC1
 I DO(2)'=-1 D
 . S FILENM=$P(DO,U,1)_" (#"_$P(DO,U,2)_")"
 S CNT=1
 S TEXT(CNT)="Renamed "_FILENM_" file entry "_OROLD_" to "_ORNEW_"."
 I $L(TEXT(CNT))>66 D
 . N DONE
 . S DONE=0
 . S X=$L(TEXT(CNT))
 . F Y=66:-1:1 D  Q:DONE
 .. I $E(TEXT(CNT),Y)'=" " Q
 .. S TEXT(CNT+1)=$E(TEXT(CNT),Y+1,X)
 .. S TEXT(CNT)=$E(TEXT(CNT),1,Y)
 .. S CNT=CNT+1
 .. I $L(TEXT(CNT))<66 S DONE=1
 S CNT=1
 D BMES^XPDUTL($G(TEXT(CNT)))
 F  S CNT=$O(TEXT(CNT)) Q:+CNT=0  D MES^XPDUTL("     "_$G(TEXT(CNT)))
 Q
RMVB ;Remove the bad "B" new-style field index in the NAME (#.01) field
 ; of the ORDER CHECK OVERRIDE REASONS (#100.04) file
 N MSG,OUTPUT
 D BMES^XPDUTL("Deleting New-Style ""B"" index from the Data Dictionary for the")
 D MES^XPDUTL("NAME (#.01) field in the ORDER CHECK OVERRIDE REASONS (#100.04) file ...")
 D MES^XPDUTL("")
 D DELIXN^DDMOD(100.04,"B","KW","OUTPUT","MSG")
 I $D(MSG("DIERR")) D  Q
 . N ERRCODE,ERRTXT,X,Y
 . D MES^XPDUTL("   An error occurred while deleting the New-Style ""B"" field index!!!")
 . S X=0
 . F  S X=$O(MSG("DIERR",X)) Q:+X=0  D
 .. S ERRCODE=+$G(MSG("DIERR",X))
 .. I ERRCODE>0 D MES^XPDUTL("   ERROR CODE: "_ERRCODE)
 .. S Y=0
 .. F  S Y=$O(MSG("DIERR",X,"TEXT",Y)) Q:+Y=0  D
 ... D MES^XPDUTL("   "_$G(MSG("DIERR",X,"TEXT",1)))
 D BMES^XPDUTL("   Completed!")
 Q
 ;
REINDEX ;Reindex "B" cross reference in file 100.04
 N DIK
 D BMES^XPDUTL("Reindexing the 'B' cross reference for file 100.04")
 S DIK="^ORD(100.04,",DIK(1)=".01"
 D ENALL^DIK
 D MES^XPDUTL("   Completed!")
 Q
 ;
RECOMPILE ;Recompile the Order Check System
 N OCXOETIM
 D BMES^XPDUTL("---Recompiling Order Check Routines-----------------------------------")
 D AUTO^OCXOCMP
 D BMES^XPDUTL("   ---Recompiling Complete---")
 Q
 ;
RMVLCL ;Remove Local entries from the ORDER CHECK OVERRIDE REASONS (#100.04) file
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,CNT,DA,DIK
 ;S MSG(1)="   Patch OR*3*535 created an option to add local Order Check Override"
 ;S MSG(2)="   Reasons in file 100.04. Now that patch OR*3*535 is being backed out,"
 ;S MSG(3)="   you have the option to keep the locally created Order Check Override"
 ;S MSG(4)="   Reasons and by default the new NATIONAL (#.05) field. Answer YES to"
 ;S MSG(5)="   remove the local entries. Default response is NO."
 ;RMV1 ;S %=2,%Y=""
 ;D BMES^XPDUTL("Do you want to delete locally created Order Check Override Reasons in file 100.04")
 ;D YN^DICN
 ;D MES^XPDUTL(%Y)
RMV1 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 D MES^XPDUTL("")
 I DTIME>30 S DIR("T")=30
 S DIR("?",1)="   Patch OR*3*535 created an option to add local Order Check Override"
 S DIR("?",2)="   Reasons in file 100.04. Now that patch OR*3*535 is being backed out,"
 S DIR("?",3)="   you have the option to keep the locally created Order Check Override"
 S DIR("?",4)="   Reasons and by default the new NATIONAL (#.05) field. Answer YES to"
 S DIR("?")="   remove the local entries. Default response is NO."
 S DIR(0)="Y"
 S MSG(1)="Delete locally created Order Check Override Reasons in file 100.04."
 S MSG(2)="Answering YES results in the NATIONAL (#.05) field in the ORDER CHECK"
 S MSG(3)="OVERRIDE REASONS (#100.04) file to be removed as well. Proceed?"
 S DIR("B")="NO"
 D MES^XPDUTL(.MSG)
 D ^DIR
 D MES^XPDUTL($S(Y=1:"YES",Y=0:"NO",Y="":"NO",1:Y))
 I Y["^" D BMES^XPDUTL("   Exiting is not allowed!!"),MES^XPDUTL("") G RMV1
 I +Y=0 D  Q
 . D BMES^XPDUTL("   Skipping deletion of the locally created Order Check Override")
 . D MES^XPDUTL("   Reasons and leaving the new NATIONAL (#.05) field installed.")
 ;I %<1 D
 ;. I %=0,%Y["?" D MES^XPDUTL(""),MES^XPDUTL(.MSG)
 ;. I %=-1 D BMES^XPDUTL("   Exiting is not allowed!!!")
 ;. G RMV1
 ;I %=2 D BMES^XPDUTL("  Skipping ...") Q
 D BMES^XPDUTL("Removing local Order Check Override Reasons...")
 S DIK="^ORD(100.04,"
 S (CNT,DA)=0
 F  S DA=$O(^ORD(100.04,DA)) Q:+DA=0  D
 . I +$P($G(^ORD(100.04,DA,0)),U,5)=1 Q
 . D MES^XPDUTL("   Deleting '"_$P($G(^ORD(100.04,DA,0)),U,1)_"'")
 . D ^DIK
 . S CNT=CNT+1
 D BMES^XPDUTL("   --- "_CNT_" local Order Check Override Reasons removed!")
RMVNTL ;Remove National (#.05) field from the ORDER CHECK OVERRIDE REASONS (#100.04) file and any related data from file entries
 N OVRD,VAL4,VAL5
 D BMES^XPDUTL("Removing NATIONAL (#.05) field from the ORDER CHECK OVERRIDE")
 D MES^XPDUTL("REASONS (#100.04) file ...")
 S DIK="^DD(100.04,"
 S DA=.05
 S DA(1)=100.04
 D ^DIK
 S OVRD=0
 F  S OVRD=$O(^ORD(100.04,OVRD)) Q:+OVRD=0  D
 . S VAL5=$G(^ORD(100.04,OVRD,0))
 . S VAL4=$P(VAL5,U,1,4)
 . I VAL4=VAL5 Q
 . S ^ORD(100.04,OVRD,0)=VAL4
 D BMES^XPDUTL("   ... COMPLETED!")
 Q
 ;
RMVPARAM ;Remove entries made related to the ORK METFORMIN EGFR parameter.
 N DA,DIK,ORENTITY,ORINSTANCE,ORPARAM
 S ORPARAM=$O(^XTV(8989.51,"B","ORK METFORMIN EGFR",""))
 I ORPARAM<1 Q
 D BMES^XPDUTL("Removing ORK METFORMIN EGFR parameter entries for all entities...")
 S DIK="^XTV(8989.5,"
 S ORENTITY=""
 F  S ORENTITY=$O(^XTV(8989.5,"AC",ORPARAM,ORENTITY)) Q:ORENTITY=""  D
 . S ORINSTANCE=0
 . F  S ORINSTANCE=$O(^XTV(8989.5,"AC",ORPARAM,ORENTITY,ORINSTANCE)) Q:+ORINSTANCE=0  D
 . . S DA=0
 . . F  S DA=$O(^XTV(8989.5,"AC",ORPARAM,ORENTITY,ORINSTANCE,DA)) Q:+DA=0  D
 . . . D ^DIK
 D BMES^XPDUTL("   ... Complete!")
 Q
