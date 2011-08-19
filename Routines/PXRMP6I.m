PXRMP6I ; SLC/PKR - Inits for PXRM*2.0*6 ;11/25/2007
 ;;2.0;CLINICAL REMINDERS;**6**;Feb 04, 2005;Build 123
 Q
 ;====================================================
DELDD ;Delete the old data dictionaries.
 N DIU,TEXT
 D EN^DDIOL("Removing old data dictionaries.")
 S DIU(0)=""
 F DIU=800,801.41,810.1,810.2,810.4,810.5,810.8,811.5,811.8,811.9 D
 . S TEXT=" Deleting data dictionary for file # "_DIU
 . D EN^DDIOL(TEXT)
 . D EN^DIU2
 Q
 ;
 ;====================================================
LISTRULE(IEN) ;List of list rules to include in the build.
 N NAME,OK
 S OK=0
 S NAME=$P(^PXRM(810.4,IEN,0),U,1)
 I NAME="VA-*IHD QUERI 412 DIAGNOSIS" S OK=1
 I NAME="VA-*IHD QUERI ANCHOR VISIT" S OK=1
 I NAME="VA-*IHD QUERI LIPID LOWERING MEDS" S OK=1
 I NAME="VA-*IHD QUERI PTS WITH QUALIFY VISIT" S OK=1
 I NAME="VA-*MH QUERI QUALIFY MH VISIT" S OK=1
 I NAME="VA-*MH QUERI QUALIFY PC VISIT" S OK=1
 I OK D RMEHIST^PXRMUTIL(810.4,IEN)
 Q OK
 ;
 ;====================================================
OPTION(ACTION) ;Disable/enable options.
 N ACT,IND,OPT,LIST,RESULT
 S ACT=$S(ACTION=2:"DISABLE",ACTION=1:"ENABLE",1:"?")
 D BMES^XPDUTL(ACT_" options.")
 ;
 D FIND^DIC(19,"","@;.01","","GMTS","*","B","","","LIST")
 F IND=1:1:+LIST("DILIST",0) D
 . S OPT=LIST("DILIST","ID",IND,.01)
  S RESULT=$$OPTDE^XPDUTL(OPT,ACTION)
  I RESULT=0 D MES^XPDUTL("Could not "_ACT_" option "_OPT)
 ;
 K LIST
 D FIND^DIC(19,"","@;.01","","IBDF PRINT","*","B","","","LIST")
 F IND=1:1:+LIST("DILIST",0) D
 . S OPT=LIST("DILIST","ID",IND,.01)
 . S RESULT=$$OPTDE^XPDUTL(OPT,ACTION)
 . I RESULT=0 D MES^XPDUTL("Could not "_ACT_" option "_OPT)
 ;
 S OPT="OR CPRS GUI CHART"
 S RESULT=$$OPTDE^XPDUTL(OPT,ACTION)
 I RESULT=0 D MES^XPDUTL("Could not "_ACT_" option "_OPT)
 ;
 S OPT="ORS HEALTH SUMMARY"
 S RESULT=$$OPTDE^XPDUTL(OPT,ACTION)
 I RESULT=0 D MES^XPDUTL("Could not "_ACT_" option "_OPT)
 ;
 K LIST
 D FIND^DIC(19,"","@;.01","","PXRM","*","B","","","LIST")
 F IND=1:1:+LIST("DILIST",0) D
 . S OPT=LIST("DILIST","ID",IND,.01)
 . S RESULT=$$OPTDE^XPDUTL(OPT,ACTION)
 . I RESULT=0 W !,"Could not ",ACTION," option ",OPT
 Q
 ;
 ;====================================================
PRE ;These are the pre-installation actions
 D ENVCHK^PXRMP6IM I $G(XPDABORT)=1 Q
 ;Disable options and protocols
 D OPTION(2)
 D PROTOCOL(2)
 ;Delete existing exchange file entries.
 D DELEXI^PXRMP6IE
 ;Rename entries that need it.
 D RENAME
 ;Initialize list template.
 D INILT^PXRMP6IL
 ;Delete the old DDs.
 D DELDD
 ;Repoint dialog with BDI as a finding item to BDI2
 D BDICONV^PXRMP6ID
 D CHECKRG^PXRMP6ID
 D STORERG^PXRMP6ID
 Q
 ;
 ;====================================================
POST ;These are the post-installation actions
 N NLINES
 D SETMAXMH
 ;Convert the mental health pointers.
 D HMHPTRS^PXRMP6IM(.NLINES,1)
 ;Convert Conditions for mental health findings.
 D MHCOND^PXRMP6IC
 I '$D(^PXRMINDX(601.84,"DATE BUILT")) S ^PXRMINDX(601.84,"DATE BUILT")=$$NOW^XLFDT
 ;Convert the rule set sequences to numbers.
 D SEQCONV^PXRMP6IS
 ;Enable options and protocols
 D OPTION(1)
 D PROTOCOL(1)
 D SMEXINS^PXRMP6IE
 D RTAXEXP
 D WRITERG^PXRMP6ID
 D DCLEAN^PXRMP6ID
 D REINDEX^PXRMP6ID
 D RESCIND
 Q
 ;
 ;====================================================
PROTOCOL(ACTION) ;Disable/enable protocols.
 N ACT,PROT,RESULT
 S ACT=$S(ACTION=2:"DISABLE",ACTION=1:"ENABLE",1:"?")
 D BMES^XPDUTL(ACT_" protocols.")
 ;
 S PROT="ORS HEALTH SUMMARY"
 S RESULT=$$PRODE^XPDUTL(PROT,ACTION)
 I RESULT=0 D MES^XPDUTL("Could not "_ACT_" protocol "_PROT)
 ;
 S PROT="ORS AD HOC HEALTH SUMMARY"
 S RESULT=$$PRODE^XPDUTL(PROT,ACTION)
 I RESULT=0 D MES^XPDUTL("Could not "_ACT_" protocol "_PROT)
 ;
 S PROT="PXRM PATIENT DATA CHANGE"
 S RESULT=$$PRODE^XPDUTL(PROT,ACTION)
 I RESULT=0 D MES^XPDUTL("Could not "_ACT_" protocol "_PROT)
 Q
 ;
 ;====================================================
RESCIND ;
 N ARY,NAME,IEN,TEXT
 S TEXT(1)="Rescinding outdated National Reminder and disabling outdated"
 S TEXT(2)="National Reminder Dialog"
 S TEXT(3)=""
 D BMES^XPDUTL(.TEXT)
 S NAME="VA-POS DEPRESSION SCREEN FOLLOWUP"
 S IEN=$O(^PXD(811.9,"B",NAME,"")) Q:IEN'>0
 K ARY
 ;S ARY(1,811.9,IEN_",",1.6)=1
 S ARY(1,811.9,IEN_",",69)=3071101
 D FILE^DIE("","ARY(1)")
 S TEXT(1)="Rescinding reminder: "_NAME
 S TEXT(2)=""
 D BMES^XPDUTL(.TEXT)
 S DIEN=$G(^PXD(811.9,IEN,51)) Q:DIEN'>0
 S NAME=$P($G(^PXRMD(801.41,DIEN,0)),U)
 K ARY
 S ARY(1,801.41,DIEN_",",3)="Disable with PXRM*2.0*6 on Nov 1, 2007"
 D FILE^DIE("","ARY(1)")
 S TEXT(1)="Disabling Dialog: "_NAME
 D BMES^XPDUTL(.TEXT)
 Q
 ;====================================================
RENAME ;Rename entries
 N DA,DIE
 S DA=+$O(^PXRM(810.4,"B","VA-*MH QUERY QUALIFYING MH VISIT",""))
 I DA=0 Q
 S DIE=810.4,DR=".01///VA-*MH QUERI QUALIFYING MH VISIT"
 D ^DIE
 Q
 ;
 ;====================================================
RTAXEXP ;Rebuild taxonomy expansions.
 N IEN,IND,TEXT,TNAME
 S TNAME(1)="VA-TETANUS DIPHTHERIA"
 S TNAME(2)="VA-WH HYSTERECTOMY W/CERVIX REMOVED"
 D BMES^XPDUTL("Rebuilding taxonomy expansions.")
 F IND=1:1:2 D
 . S IEN=$O(^PXD(811.2,"B",TNAME(IND),""))
 . I IEN="" Q
 . S TEXT=" Working on taxonomy "_IEN
 . D BMES^XPDUTL(TEXT)
 . D DELEXTL^PXRMBXTL(IEN)
 . D EXPAND^PXRMBXTL(IEN,"")
 Q
 ;
 ;====================================================
SETMAXMH ;Set the maximum number of mental health questions that can be 
 ;administered through a reminder dialog.
 N DA,DIE,DR
 I +$P($G(^PXRM(800,1,"MH")),U)>0 Q
 S DA=1,DR="17////35",DIE="^PXRM(800," D ^DIE
 Q
 ;
