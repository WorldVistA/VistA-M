PXRMTAXD ; SLC/PKR - Routines used by taxonomy data dictionary. ;05/05/2014
 ;;2.0;CLINICAL REMINDERS;**26**;Feb 04, 2005;Build 404
 ;
 ;===================================
CDINPTR(CODE) ;Input transform for code field of Use in Dialogs Code multiple.
 N CODESYS,CODESYSL,DATA,RESULT,TEXT,VALID
 S VALID=$$VCODE^PXRMLEX(CODE)
 I 'VALID D
 . S TEXT(1)="Only valid codes from a supported coding system can be entered here."
 . S TEXT(2)=CODE_" is not a valid code."
 . D EN^DDIOL(.TEXT)
 Q VALID
 ;
 ;========================================
CHGUID(IEN,CODESYS,CODE,UID) ;For a coding system code pair in the 20
 ;node change the value of UID.
 N FDA,IENS,IND,JND,KND,MSG,NCHG,NUID,TERM
 S NCHG=0,TERM=""
 F  S TERM=$O(^PXD(811.2,IEN,20,"ATCC",TERM)) Q:TERM=""  D
 . I '$D(^PXD(811.2,IEN,20,"ATCC",TERM,CODESYS,CODE)) Q
 . S IND=$P(^PXD(811.2,IEN,20,"ATC",TERM,CODESYS),U,1)
 . S JND=$P(^PXD(811.2,IEN,20,"ATC",TERM,CODESYS),U,2)
 . S NUID=$P(^PXD(811.2,IEN,20,IND,1,JND,0),U,3)
 . S KND=0
 . F  S KND=+$O(^PXD(811.2,IEN,20,IND,1,JND,1,KND)) Q:KND=0  D
 .. I $P(^PXD(811.2,IEN,20,IND,1,JND,1,KND,0),U,1)=CODE D
 ... S NCHG=NCHG+1
 ... S IENS=KND_","_JND_","_IND_","_IEN_","
 ... S FDA(811.2312,IENS,1)=UID
 ... I UID=0 S NUID=NUID-1
 ... I UID=1 S NUID=NUID+1
 .. S IENS=JND_","_IND_","_IEN_","
 .. S FDA(811.231,IENS,3)=NUID
 I NCHG>0 D FILE^DIE("","FDA","MSG")
 Q NCHG
 ;
 ;===================================
CSYSOPTR(CODESYS) ;Output transform for Coding System field of Use in Dialogs
 ;Codes multiple.
 ;DBIA #5679
 Q $S($D(DDS):$P($$CSYS^LEXU(CODESYS),U,4),1:CODESYS)
 ;
 ;====================================
INUSE(TIEN,CHKTYP) ;Check to see if a taxonomy is in use. Used for the "DEL"
 ;node: ^DD(811.2,.01,"DEL",1,0) and inactivation check in
 ;POSTACT^PXRMTXSM.
 N FNUM,IEN,NAME,NL,TEXT,TYPE
 K ^TMP($J,"TDATA"),^TMP($J,"DLG FIND")
 D BLDLIST^PXRMFRPT(811.2,"PXD(811.2,",TIEN,"TDATA")
 I '$D(^TMP($J,"TDATA")) K ^TMP($J,"DLG FIND") Q 0
 I CHKTYP="DEL" S TEXT(1)="This taxonomy cannot be deleted, it is used by the following:"
 I CHKTYP="INACT" S TEXT(1)="Warning - this taxonomy has been inactivated but, it is used by the following:"
 S NL=1,TYPE=""
 F  S TYPE=$O(^TMP($J,"TDATA",811.2,TIEN,TYPE)) Q:TYPE=""  D
 . S FNUM=$S(TYPE="DEF":811.9,TYPE="TERM":811.5,TYPE="DIALOG":801.41,TYPE="ROC":801,TYPE="OCRULE":801.1)
 . S NL=NL+1,TEXT(NL)=" "_$S(TYPE="DEF":"Definitions:",TYPE="TERM":"Terms:",TYPE="DIALOG":"Dialogs:",TYPE="ROC":"Orderable Item Groups:",TYPE="OCRULE":"Order Check Rules:",1:"")
 . S IEN=""
 . F  S IEN=$O(^TMP($J,"TDATA",811.2,TIEN,TYPE,IEN)) Q:IEN=""  D
 .. S NL=NL+1,TEXT(NL)="  "_$$GET1^DIQ(FNUM,IEN,.01)
 . S NL=NL+1,TEXT(NL)=" "
 D EN^DDIOL(.TEXT)
 K ^TMP($J,"TDATA"),^TMP($J,"DLG FIND")
 Q 1
 ;
 ;========================================
KENODE(DA,X) ;Kill the "AE" (coding system, code) index.
 ;X(1) is the code.
 N CODESYS
 S CODESYS=$P(^PXD(811.2,DA(3),20,DA(2),1,DA(1),0),U,1)
 K ^PXD(811.2,DA(3),20,"AE",CODESYS,X(1))
 Q
 ;
 ;========================================
KILLUIDC(IEN,CODE,CODESYS) ;Remove codes from the Use In Dialogs Codes multiple
 ;when Use In Dialog is false.
 I '$D(^PXD(811.2,IEN,30,"ACC",CODE,CODESYS)) Q
 N IENS,KFDA,MSG
 S IENS=^PXD(811.2,IEN,30,"ACC",CODE,CODESYS)_","_IEN_","
 S KFDA(811.24,IENS,.01)="@"
 D FILE^DIE("","KFDA","MSG")
 Q
 ;
 ;========================================
KTC(DA,X) ;Kill the "ATC" (term, coding system) index.
 ;X(1) is the coding system.
 N TERM
 S TERM=^PXD(811.2,DA(2),20,DA(1),0)
 K ^PXD(811.2,DA(2),20,"ATC",TERM,X(1))
 Q
 ;
 ;========================================
KTCC(DA,X) ;KILL the "ATCC" (term, coding system, code) index.
 ;X(1) is the code, X(2) is Use in Dialog.
 N CODESYS,TERM
 S TERM=^PXD(811.2,DA(3),20,DA(2),0)
 S CODESYS=$P(^PXD(811.2,DA(3),20,DA(2),1,DA(1),0),U,1)
 K ^PXD(811.2,DA(3),20,"ATCC",TERM,CODESYS,X(1))
 Q
 ;
 ;========================================
KUID(DA,X) ;Kill the "AUID" Use in Dialog index and remove the code
 ;from the Use In Dialogs Codes multiple.
 ;X(1) is the code, X(2) is Use in Dialog.
 N CODESYS
 S CODESYS=$P(^PXD(811.2,DA(3),20,DA(2),1,DA(1),0),U,1)
 I '$D(^PXD(811.2,DA(3),20,"AUID",CODESYS,X(1))) Q
 K ^PXD(811.2,DA(3),20,"AUID",CODESYS,X(1))
 D KILLUIDC(DA(3),X(1),CODESYS)
 Q
 ;
 ;========================================
KUIDC(DA,X) ;When a code is deleted from the Use In Dialog Codes multiple
 ;check to see if a special entry was made for this code in the
 ;Selected Codes Multiple, if one is found delete it. If one is not
 ;found then find the code in the Selected Codes Multiple and change
 ;UID to 0.
 ;X(1) is the code, X(2) is the coding system.
 I '$D(^PXD(811.2,DA(1),30,"ACC",X1(1),X1(2))) Q
 K ^PXD(811.2,DA(1),30,"ACC",X1(1),X1(2))
 N IENS,KFDA,MSG,NCHG,TERM,TERMIND
 I $D(^PXD(811.2,DA(1),20,"ATC",X1(1),X1(2))) D
 . S TERMIND=$P(^PXD(811.2,DA(1),20,"ATC",X1(1),X1(2)),U,1)
 . S IENS=TERMIND_","_DA(1)_","
 . S KFDA(811.23,IENS,.01)="@"
 . D FILE^DIE("","KFDA","MSG")
 ;Search for the code in the Selected Codes Multiple and set UID=0.
 S NCHG=$$CHGUID^PXRMTAXD(DA(1),X1(2),X1(1),0)
 Q
 ;
 ;========================================
RBLD20I ;Rebuild all the indexes on the 20 node.
 N CODESYS,D0,D1,D2,D3,DA,NAME,TCCDA,TCCX,TEMP,UID,X
 ;X(1) is the code and X(2) is UID.
 D BMES^XPDUTL("Building Selected Codes multiple indexes.")
 S NAME=""
 F  S NAME=$O(^PXD(811.2,"B",NAME)) Q:NAME=""  D
 . S D0=$O(^PXD(811.2,"B",NAME,""))
 . D MES^XPDUTL(" Taxonomy: "_NAME_"; IEN="_D0)
 . K ^PXD(811.2,D0,20,"AE")
 . K ^PXD(811.2,D0,20,"ATC")
 . K ^PXD(811.2,D0,20,"ATCC")
 . K ^PXD(811.2,D0,20,"AUID")
 . S DA(3)=D0,D1=0,TCCDA(2)=D0
 . F  S D1=+$O(^PXD(811.2,D0,20,D1)) Q:D1=0  D
 .. S DA(2)=D1,D2=0,TCCDA(1)=D1
 .. F  S D2=+$O(^PXD(811.2,D0,20,D1,1,D2)) Q:D2=0  D
 ... S CODESYS=$P(^PXD(811.2,D0,20,D1,1,D2,0),U,1)
 ... I $L(CODESYS)>3 D
 .... S CODESYS=$E(CODESYS,1,3)
 .... S $P(^PXD(811.2,D0,20,D1,1,D2,0),U,1)=CODESYS
 ... S TCCX(1)=CODESYS
 ... S DA(1)=D2,D3=0,TCCDA=D2
 ... D STC^PXRMTAXD(.TCCDA,.TCCX)
 ... F  S D3=+$O(^PXD(811.2,D0,20,D1,1,D2,1,D3)) Q:D3=0  D
 .... S DA=D3
 .... S TEMP=^PXD(811.2,D0,20,D1,1,D2,1,D3,0)
 .... S X(1)=$P(TEMP,U,1)
 .... D SENODE^PXRMTAXD(.DA,.X)
 .... S X(2)=$P(TEMP,U,2)
 .... D STCC^PXRMTAXD(.DA,.X)
 .... I +X(2)=0 Q
 .... D SUID^PXRMTAXD(.DA,.X)
 Q
 ;
 ;========================================
RBLDUID ;Rebuild the "AUID" index for all entries.
 N D0,D1,D2,D3,DA,TEMP,UID,X
 ;X(1) is the code and X(2) is UID.
 S D0=0
 F  S D0=+$O(^PXD(811.2,D0)) Q:D0=0  D
 . K ^PXD(811.2,D0,20,"AUID")
 . S DA(3)=D0,D1=0
 . F  S D1=+$O(^PXD(811.2,D0,20,D1)) Q:D1=0  D
 .. S DA(2)=D1,D2=0
 .. F  S D2=+$O(^PXD(811.2,D0,20,D1,1,D2)) Q:D2=0  D
 ... S DA(1)=D2,D3=0
 ... F  S D3=+$O(^PXD(811.2,D0,20,D1,1,D2,1,D3)) Q:D3=0  D
 .... S DA=D3
 .... S TEMP=^PXD(811.2,D0,20,D1,1,D2,1,D3,0)
 .... S X(1)=$P(TEMP,U,1)
 .... S X(2)=$P(TEMP,U,2)
 .... I +X(2)=0 Q
 .... D SUID^PXRMTAXD(.DA,.X)
 Q
 ;
 ;========================================
SAVEUIDC(IEN,CODESYS,CODE) ;Save codes marked as Use In Dialog in the 
 ;Use In Dialogs Codes Multiple.
 ;If the coding system code pair already exists quit.
 I $D(^PXD(811.2,IEN,30,"ACC",CODE,CODESYS)) Q
 N IENS,FDA,MSG
 S IENS="+1,"_IEN_","
 S FDA(811.24,IENS,.01)=CODE
 S FDA(811.24,IENS,1)=CODESYS
 D UPDATE^DIE("","FDA","","MSG")
 Q
 ;
 ;========================================
SENODE(DA,X) ;Set the "AE" (coding system, code) index.
 ;X(1) is the code.
 N CODEP,CODESYS
 S CODESYS=$P(^PXD(811.2,DA(3),20,DA(2),1,DA(1),0),U,1)
 ;The ICD and CPT coding systems are "grandfathered" to
 ;use the pointer in the Clinical Reminders Index for V CPT
 ;and V POV so save the code pointer.
 S CODEP=X(1)
 ;DBIA #5747
 I CODESYS="ICD" S CODEP=$P($$CODEN^ICDEX(X(1),80),"~",1)
 I CODESYS="ICP" S CODEP=$P($$CODEN^ICDEX(X(1),80.1),"~",1)
 I CODESYS="CPC" S CODEP=$P($$STATCHK^ICPTAPIU(X(1)),U,2)
 I CODESYS="CPT" S CODEP=$P($$STATCHK^ICPTAPIU(X(1)),U,2)
 S ^PXD(811.2,DA(3),20,"AE",CODESYS,X(1))=CODEP
 Q
 ;
 ;========================================
STC(DA,X) ;Set the "ATC" (term, coding system) index.
 ;X(1) is the coding system.
 N TERM
 S TERM=^PXD(811.2,DA(2),20,DA(1),0)
 S ^PXD(811.2,DA(2),20,"ATC",TERM,X(1))=DA(1)_U_DA
 Q
 ;
 ;========================================
STCC(DA,X) ;Set the "ATCC" (term, coding system, code) index.
 ;X(1) is the code, X(2) is Use in Dialog.
 N CODESYS,TERM
 S TERM=^PXD(811.2,DA(3),20,DA(2),0)
 S CODESYS=$P(^PXD(811.2,DA(3),20,DA(2),1,DA(1),0),U,1)
 S ^PXD(811.2,DA(3),20,"ATCC",TERM,CODESYS,X(1))=X(2)
 Q
 ;
 ;========================================
SUID(DA,X) ;Set the "AUID" Use in Dialog index.
 ;X(1) is the code, X(2) is Use in Dialog.
 N ACTDT,BDESC,CODESYS,DATA,INACTDT,LDESC,RESULT,TEMP,VP
 I +X(2)=0 Q
 S CODESYS=$P(^PXD(811.2,DA(3),20,DA(2),1,DA(1),0),U,1)
 I $D(^PXD(811.2,DA(3),20,"AUID",CODESYS,X(1))) Q
 ;DBIA #5679
 S RESULT=$$PERIOD^LEXU(X(1),CODESYS,.DATA)
 I +RESULT=-1 Q
 S ACTDT=0
 F  S ACTDT=$O(DATA(ACTDT)) Q:ACTDT=""  D
 . S TEMP=DATA(ACTDT)
 . S INACTDT=$P(TEMP,U,1)
 . I INACTDT="" S INACTDT="DT"
 . S VP=$P(TEMP,U,3)
 . S LDESC=DATA(ACTDT,0)
 . S BDESC=$P(TEMP,U,4)
 . I BDESC="" S BDESC=LDESC
 . S ^PXD(811.2,DA(3),20,"AUID",CODESYS,X(1),ACTDT,INACTDT)=$P(VP,";",1)_U_LDESC
 ;If UID=1 add the code to the Use In Dialog Codes Multiple.
 ;This cannot be done if the entry is being installed by Reminder
 ;Exchange because it causes an UPDATE^DIE call to make another
 ;UPDATE^DIE call. The Use In Dialog Codes Multiple is built after
 ;the entry is installed by a call to TAX30^PXRMEXUO.
 I $G(PXRMEXCH)=1 Q
 I X(2)=1 D SAVEUIDC(DA(3),CODESYS,X(1))
 Q
 ;
 ;========================================
SUIDC(DA,X) ;Copy codes from the Use in Dialog Codes multiple to the Selected
 ;Codes structure.
 ;X(1) is the code, X(2) is the coding system.
 ;Check if this coding system code pair already exists.
 I $D(^PXD(811.2,DA(1),30,"ACC",X(1),X(2))) Q
 S ^PXD(811.2,DA(1),30,"ACC",X(1),X(2))=DA
 I $D(^PXD(811.2,DA(1),20,"AUID",X(2),X(1))) Q
 N NCHG
 S NCHG=$$CHGUID^PXRMTAXD(DA(1),X(2),X(1),1)
 I NCHG>0 Q
 ;No instances of this code were found in the 20 node so create one.
 K ^TMP("PXRMCODES",$J)
 S ^TMP("PXRMCODES",$J,X(1),X(2),X(1))=1
 D SAVETC^PXRMTXIM(DA(1))
 D POSTSAVE^PXRMTXSM(DA(1))
 Q
 ;
 ;========================================
TAXCOUNT(TAXIEN) ;Count the expanded taxonomy entries and set the 0 node.
 ;This code is obsolete and will be removed in the taxonomy cleanup
 ;patch that follows PXRM*2*26.
 Q
 N IEN,NUM
 S (IEN,NUM)=0
 F  S IEN=+$O(^PXD(811.3,IEN)) Q:IEN=0  S NUM=NUM+1
 S $P(^PXD(811.3,0),U,3,4)=TAXIEN_U_NUM
 Q
 ;
 ;========================================
TAXEDIT(TAXIEN,KI) ;Whenever a taxonony item is edited rebuild the expanded
 ;taxonomy. Called from new-style cross-reference on 811.2.
 ;This code is obsolete and will be removed in the taxonomy cleanup
 ;patch that follows PXRM*2*26.
 Q
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q
 D DELEXTL^PXRMBXTL(TAXIEN)
 D EXPAND^PXRMBXTL(TAXIEN,KI)
 D TAXCOUNT(TAXIEN)
 Q
 ;
 ;========================================
TAXKILL(TAXIEN) ;Called whenever a taxonony item is killed. Called from new-
 ;style cross-reference on 811.2.
 ;This code is obsolete and will be removed in the taxonomy cleanup
 ;patch that follows PXRM*2*26.
 Q
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q
 D DELEXTL^PXRMBXTL(TAXIEN)
 D TAXCOUNT(TAXIEN)
 Q
 ;
