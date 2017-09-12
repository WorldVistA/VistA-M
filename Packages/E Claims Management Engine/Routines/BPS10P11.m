BPS10P11 ;ALB/DMB - Post-install for BPS*1.0*11 ;04/08/2011
 ;;1.0;E CLAIMS MGMT ENGINE;**11**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Reference to FILESEC^DDMOD supported by IA 2916
 ;
 Q
 ;
POST ; Entry Point for post-install
 D BMES^XPDUTL("  Starting post-install of BPS*1*11")
 ;
 ; Update BPS NCPDP REJECT CODES dictionary with CHAMPVA DRUG NON BILLABLE, 569, 597
 D BPS93
 ; Update the GET CODE for BPS NCPCP FIELD DEFS
 D FLDDEFS
 ; Remove 401 from the Transaction multiple of BPS Claims
 D CLAIM
 ; Update PATIENT RELATIONSHIP CODE in BPS INSURER DATA records
 D PRC
 ; Update the compiled menu protocol BPS PRTCL USRSCR HIDDEN ACTIONS
 D MENU
 ; Change order of DUR codes in BPS REQUESTS file
 D BPSREQ
 ; Update BPS NCPDP FIELD CODES FILE (#9002313.94)
 D FLDCODE
 ; Update file security for the BPS NCPDP FIELD CODES (9002313.94) file
 D DDSCRTY
 ;
 D BMES^XPDUTL("  Finished post-install of BPS*1*11")
 Q
 ;
BPS93 ;
 N X,Y,BPSFIEN,DIC
 D BMES^XPDUTL("   Updating BPS NCPDP REJECT CODES")
 D
 . I $D(^BPSF(9002313.93,"B","eC")) D  Q
 .. D MES^XPDUTL("    - eC already exists in the BPS NCPDP REJECT CODES dictionary.")
 . S DIC=9002313.93,X="eC",DIC(0)="",DIC("DR")=".02///CHAMPVA-DRUG NON BILLABLE"
 . D FILE^DICN
 . S X="    - eC:CHAMPVA-DRUG NON BILLABLE was "_$S(Y=-1:"*NOT* ",1:"")_"added to BPS NCPDP REJECT CODES."
 . D MES^XPDUTL(X)
 D
 . I $D(^BPSF(9002313.93,"B",569)) D  Q
 .. D MES^XPDUTL("    - 569 already exists in the BPS NCPDP REJECT CODES dictionary.")
 . S DIC=9002313.93,X=569,DIC(0)="",DIC("DR")=".02///Provide Beneficiary with CMS Notice of Appeal Rights"
 . D FILE^DICN
 . S X="    - 569:Provide Beneficiary with CMS Notice of Appeal Rights was "_$S(Y=-1:"*NOT* ",1:"")_"added to BPS NCPDP REJECT CODES."
 . D MES^XPDUTL(X)
 D
 . I $D(^BPSF(9002313.93,"B",597))  D  Q
 .. D MES^XPDUTL("    - 597 already exists in the BPS NCPDP REJECT CODES dictionary.")
 . S DIC=9002313.93,X=597,DIC(0)="",DIC("DR")=".02///LTC Dispensing type does not support the packaging type"
 . D FILE^DICN
 . S X="    - 597:LTC Dispensing type does not support the packaging type was "_$S(Y=-1:"*NOT* ",1:"")_"added to BPS NCPDP REJECT CODES."
 . D MES^XPDUTL(X)
 D MES^XPDUTL("    - Done with updating BPS NCPDP REJECT CODES")
 Q
 ;
FLDDEFS ;
 N TEXT,BPX,CNT,OK,FIELD,IEN,GETCODE,SETCODE,MC,ERRMSG,FKI,FKV,D0FRMTCD,FRMTCD,PREIEN,FLAGS
 D BMES^XPDUTL("   Updating BPS NCPDP FIELD DEFS")
 S (CNT,PREIEN)=0
 F BPX=1:1 S TEXT=$P($T(FIELDS+BPX),";;",2,99) Q:TEXT=""  D
 . S FIELD=$P(TEXT,";",1)   ; ncpdp field#
 . S IEN=+$O(^BPSF(9002313.91,"B",FIELD,0))   ; ien to file# 9002313.91
 . I IEN=0 D MES^XPDUTL("    - Error: can't find entry for the NCPDP field # "_FIELD_" in the file") Q
 . ;
 . D MES^XPDUTL("    - Updating data for the NCPDP field# "_FIELD_"...")
 . S OK=0
 . ;
 . S GETCODE=$P(TEXT,";",2)
 . I GETCODE]"" D
 .. K MC,ERRMSG S MC(1,0)=GETCODE
 .. D WP^DIE(9002313.91,IEN_",",10,"","MC","ERRMSG")
 .. I $D(ERRMSG) D  Q
 ... D MES^XPDUTL("    - FileMan reported a problem with the GET CODE for field# "_FIELD)
 ... S (FKI,FKV)="ERRMSG"
 ... F  S FKI=$Q(@FKI) Q:FKI'[FKV  D MES^XPDUTL("    - "_FKI_" = "_$G(@FKI))
 ... D MES^XPDUTL("   ")
 ... Q
 . S OK=OK+1
 . ;
 . S SETCODE=$P(TEXT,";",3)    ; SET code
 . I SETCODE]"" D
 .. K MC,ERRMSG S MC(1,0)=SETCODE
 .. D WP^DIE(9002313.91,IEN_",",30,"","MC","ERRMSG")
 .. I $D(ERRMSG) D  Q
 ... D MES^XPDUTL("    - FileMan reported a problem with the SET CODE for field# "_FIELD)
 ... S (FKI,FKV)="ERRMSG"
 ... F  S FKI=$Q(@FKI) Q:FKI'[FKV  D MES^XPDUTL("   - "_FKI_" = "_$G(@FKI))
 ... D MES^XPDUTL("  ")
 ... Q
 . S OK=OK+1
 . ;
 . S D0FRMTCD=$P(TEXT,";",4)    ; D0 FORMAT code
 . I D0FRMTCD]"" D
 .. K MC,ERRMSG
 .. S MC(1,0)=D0FRMTCD
 .. S FLAGS="" I IEN=PREIEN S FLAGS="A"
 .. D WP^DIE(9002313.91,IEN_",",20,FLAGS,"MC","ERRMSG")
 .. I $D(ERRMSG) D  Q
 ... D MES^XPDUTL("    - FileMan reported a problem with the D0 FORMAT CODE for field# "_FIELD)
 ... S (FKI,FKV)="ERRMSG"
 ... F  S FKI=$Q(@FKI) Q:FKI'[FKV  D MES^XPDUTL("   - "_FKI_" = "_$G(@FKI))
 ... D MES^XPDUTL("  ")
 ... Q
 . S OK=OK+1
 . ;
 . S FRMTCD=$P(TEXT,";",5)    ; FORMAT code
 . I FRMTCD]"" D
 .. K MC,ERRMSG
 .. S MC(1,0)=FRMTCD
 .. D WP^DIE(9002313.91,IEN_",",40,"","MC","ERRMSG")
 .. I $D(ERRMSG) D  Q
 ... D MES^XPDUTL("    - FileMan reported a problem with the FORMAT CODE for field# "_FIELD)
 ... S (FKI,FKV)="ERRMSG"
 ... F  S FKI=$Q(@FKI) Q:FKI'[FKV  D MES^XPDUTL("   - "_FKI_" = "_$G(@FKI))
 ... D MES^XPDUTL("  ")
 ... Q
 . S OK=OK+1
 . ;
 . I OK=4 S:'(PREIEN=IEN) CNT=CNT+1
 . S PREIEN=IEN
 D MES^XPDUTL("    - Update to BPS NCPDP FIELD DEFS is complete. "_CNT_" records updated.")
 Q
 ;
FIELDS ; NCPDP field;GET code;SET code;D0 FORMAT code;FORMAT code
 ;;325;;;S BPS("X")=$TR($G(BPS("X")),"-/._","");
 ;;325;;;S BPS("X")=$$ANFF^BPSECFM(BPS("X"),15)
 ;;401;S BPS("X")=$G(BPS("NCPDP","DOS"));S $P(^BPSC(BPS(9002313.02),401),U,1)=BPS("X")
 ;;402;;;I $L($G(BPS("X")))>12 S BPS("X")=$E(BPS("X"),$L(BPS("X"))-11,$L(BPS("X")));
 ;;402;;;S BPS("X")=$$NFF^BPSECFM($G(BPS("X")),12)
 ;;409;S BPS("X")=$G(BPS("RX",BPS(9002313.0201),"Ingredient Cost"))
 ;;412;S BPS("X")=$G(BPS("RX",BPS(9002313.0201),"Dispensing Fee"))
 ;;436;S BPS("X")=$G(BPS("RX",BPS(9002313.0201),"Product ID Qualifier"))
 ;;483;;;S BPS("X")=$$DFF^BPSECFM($G(BPS("X")),7,4);S BPS("X")=$$DFF^BPSECFM($G(BPS("X")),7,4)
 ;;996;;S $P(^BPSC(BPS(9002313.02),400,BPS(9002313.0201),990),U,6)=""
 ;
CLAIM ;
 ; Delete the 401 and 420 data from BPS Claims and then remove the fields.
 D BMES^XPDUTL("   Updating BPS CLAIMS")
 ;
 ; Check if the fields have already been removed
 ; IA 2205
 I '$$VFIELD^DILFD(9002313.0201,401),'$$VFIELD^DILFD(9002313.0201,420) D MES^XPDUTL("    - Data and Fields already removed.  No further action.") Q
 ; 
 ; Delete the data first
 N IEN,IEN2,CNT,DIK,DA
 S IEN=0,CNT=0
 F  S IEN=$O(^BPSC(IEN)) Q:'IEN  D
 . S IEN2=0
 . F  S IEN2=$O(^BPSC(IEN,400,IEN2)) Q:'IEN2  D
 .. S $P(^BPSC(IEN,400,IEN2,400),U,1)="",$P(^BPSC(IEN,400,IEN2,400),U,20)=""
 .. S CNT=CNT+1
 ;
 ; Delete the fields from the data defintion
 ; IA 10013
 S DIK="^DD(9002313.0201,",DA(1)=9002313.0201,DA=401
 D ^DIK
 S DIK="^DD(9002313.0201,",DA(1)=9002313.0201,DA=420
 D ^DIK
 ;
 D MES^XPDUTL("    - Done with BPS CLAIMS. "_CNT_" rows updated.")
 Q
 ;
PRC ;Update PATIENT RELATIONSHIP CODE in BPS INSURER DATA records
 N CNT,DA,DIE,DR,DTOUT,IEN
 D BMES^XPDUTL("   Updating PATIENT RELATIONSHIP CODE")
 S CNT=0
 S IEN=0 F  S IEN=$O(^BPS(9002313.78,IEN)) Q:'IEN  D
 . I $P($G(^BPS(9002313.78,IEN,1)),"^",5)="" Q  ;Do not want to inadvertently change null value
 . I +$P($G(^BPS(9002313.78,IEN,1)),"^",5)'>4 Q  ;Valid value, do not change
 . S CNT=CNT+1,DIE="^BPS(9002313.78,",DA=IEN,DR=1.05_"////"_4
 . D ^DIE
 . K DA,DR,DIE
 D MES^XPDUTL("    - "_CNT_" entries updated")
 D MES^XPDUTL("    - Done with updating PATIENT RELATIONSHIP CODE")
 Q
 ;
MENU ; remove the cached hidden menu protocol for the ECME user screen
 N BPSORD,XQORM
 D BMES^XPDUTL("   Removing cached hidden menu for BPS PRTCL USRSCR HIDDEN ACTIONS")
 S BPSORD=$O(^ORD(101,"B","BPS PRTCL USRSCR HIDDEN ACTIONS",0))
 S XQORM=BPSORD_";ORD(101,"
 I $D(^XUTL("XQORM",XQORM)) K ^XUTL("XQORM",XQORM)
 D MES^XPDUTL("    - Done with removing cached hidden menu for BPS PRTCL USRSCR HIDDEN ACTIONS")
 Q
 ;
BPSREQ ;Update DUR records in BPS REQUESTS - switch first two DUR fields
 N CNT,DA,DIE,DR,DTOUT,IEN,NUM,PSC,RFS,X
 D BMES^XPDUTL("   Updating BPS REQUESTS file")
 S CNT=0
 S IEN=0 F  S IEN=$O(^BPS(9002313.77,IEN)) Q:'IEN  D
 . S NUM=0 F  S NUM=$O(^BPS(9002313.77,IEN,3,NUM)) Q:'NUM  D
 .. S X=$G(^BPS(9002313.77,IEN,3,NUM,0)),PSC=$P(X,"^",2),RFS=$P(X,"^",1)
 .. I $D(^BPS(9002313.21,"B",RFS)),$D(^BPS(9002313.23,"B",PSC)) D  ;Pieces are in wrong order
 ... S CNT=CNT+1
 ... S DIE="^BPS(9002313.77,"_IEN_",3,"
 ... S DA(1)=IEN,DA=NUM,DR=".01///"_PSC_";.02///"_RFS
 ... D ^DIE
 ... K DA,DR,DIE
 D MES^XPDUTL("    - "_CNT_" entries updated")
 D MES^XPDUTL("    - Done with updating BPS REQUESTS file")
 Q
 ;
FLDCODE ;Update CODE multiple, DESCRIPTION field (#1) for "09" code
 ;
 N DIE,DA,DR,KEYVAL,IEN91,IEN94,IEN1,EFLG,DTOUT
 D BMES^XPDUTL("   Updating BPS NCPDP FIELD CODES")
 S KEYVAL=342,IEN91="",EFLG=0
 S IEN91=$O(^BPSF(9002313.91,"B",KEYVAL,IEN91))
 I +IEN91,$D(^BPS(9002313.94,"B",IEN91)) D
 . S IEN94="",IEN94=$O(^BPS(9002313.94,"B",IEN91,IEN94))
 . I +IEN94 D  Q
 . . S IEN1="",IEN1=$O(^BPS(9002313.94,1,IEN94,"B","09",IEN1))
 . . I +IEN1 D  Q
 . . . S DIE="^BPS(9002313.94,"_IEN94_",1,",DA=IEN1,DA(1)=IEN94,DR="1////COMPOUND PREPARATION COST"
 . . . D ^DIE
 . . D MES^XPDUTL("    - '09' not found in NCPDP FIELD CODES, CODE multiple")
 . . S EFLG=1
 . D MES^XPDUTL("    - No record found in NCPDP FIELD CODES")
 . S EFLG=1
 D:'EFLG MES^XPDUTL("    - Done with updating BPS NCPDP FIELD CODES")
 Q
 ;
DDSCRTY ; update the Data Dictionary Security
 ;
 D BMES^XPDUTL("   Updating file security for the BPS NCPDP FIELD CODES file")
 N BPSCRTY,BPSERR,BPSFILE,V
 S BPSFILE=9002313.94
 S BPSCRTY("RD")="Pp"
 D FILESEC^DDMOD(BPSFILE,.BPSCRTY,"BPSERR") ;IA 2916
 I $D(BPSERR) D
 .D MES^XPDUTL("    - error returned while updating File Security, file #"_BPSFILE)
 .S V="BPSERR" F  S V=$Q(@V) Q:V=""  D MES^XPDUTL(" - error message: "_@V)
 ;
 D MES^XPDUTL("    - Done with updating file security")
 Q
