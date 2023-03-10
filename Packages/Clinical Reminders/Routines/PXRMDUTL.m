PXRMDUTL ;SLC/AGP - DIALOG UTILITIES. ;07/22/2020
 ;;2.0;CLINICAL REMINDERS;**24,26,53,45,71**;Feb 04, 2005;Build 43
 Q
 ;
 ;==========================================
ALLOWDEL(IEN) ; check to see if the item can be deleted
 N CLASS,TYPE
 S TYPE=$P($G(^PXRMD(801.41,IEN,0)),U,4)
 S CLASS=$P($G(^PXRMD(801.41,IEN,100)),U)
 I (CLASS="N")&((TYPE="P")!(TYPE="F")) Q 0
 Q 1
 ;
DELD(DIEN) ; delete the dialog item
 N ARRAY,CNT,DARRAY,DA,DIK,PXRMINST
 S CNT=0
 D DITEMAR(DIEN,.ARRAY,.DARRAY,.CNT)
 S PXRMINST=1
 S DIK="^PXRMD(801.41,"
 S CNT="" F  S CNT=$O(ARRAY(CNT),-1) Q:CNT=""  D
 .S DA=$O(ARRAY(CNT,"")) Q:DA'>0
 .I $$ALLOWDEL(DA)=0 Q
 .D ^DIK
 Q
 ;
 ; builds an array of items beneath the dialog item, lowest item first.
DITEMAR(DIEN,ARRAY,DARRAY,DCNT) ;
 ;  DIEN is the IEN of the dialog top level
 ;  Array contains the dialog elements and groups within the dialog.
 N CNT,IDX,IEN,REPIEN,SEQ,TYPE,X0
 S CNT=0 F  S CNT=$O(^PXRMD(801.41,DIEN,10,CNT)) Q:CNT'>0  D
 .S IEN=$P($G(^PXRMD(801.41,DIEN,10,CNT,0)),U,2) Q:IEN'>0
 .I $D(^PXRMD(801.41,IEN,"BL")) D
 ..S SEQ=0 F  S SEQ=$O(^PXRMD(801.41,IEN,"BL","B",SEQ)) Q:SEQ'>0  D
 ...S IDX=$O(^PXRMD(801.41,IEN,"BL","B",SEQ,"")) Q:IDX'>0
 ...S REPIEN=$P($G(^PXRMD(801.41,IEN,"BL",IDX,0)),U,5)
 ...I REPIEN>0 D DITEMAR(REPIEN,.ARRAY,.DARRAY,.DCNT)
 .S TYPE=$P($G(^PXRMD(801.41,IEN,0)),U,4)
 .I TYPE="G"!(TYPE="E") D DITEMAR(IEN,.ARRAY,.DARRAY,.DCNT)
 .I '$D(DARRAY(IEN)) S DARRAY(IEN)="",DCNT=DCNT+1,ARRAY(DCNT,IEN)=""
 I '$D(DARRAY(DIEN)) S DARRAY(DIEN)="",DCNT=DCNT+1,ARRAY(DCNT,DIEN)=""
 Q
 ;
DMAKENAT(DA) ; sets the class field and renamed to the correct national format
 N CLASS,DIE,DR,IEN,NAME,NEWNAME,PREFIX,TYPE
 S NAME=$P($G(^PXRMD(801.41,DA,0)),U)
 I $E(NAME,1,3)="VA-"!($E(NAME,1,4)="PXRM") Q
 S CLASS="N"
 S DIE="^PXRMD(801.41,"
 S DR="100////^S X=CLASS"
 D ^DIE
 S TYPE=$P($G(^PXRMD(801.41,DA,0)),U,4)
 S PREFIX=$S(TYPE="R":"VA-",TYPE="G":"VA-",TYPE="E":"VA-",1:"PXRM ")
 S NEWNAME=PREFIX_NAME
 D RENAME^PXRMUTIL(801.41,NAME,NEWNAME)
 Q
 ;
 ;=============================================================
 ; Build a TEMP global of findings for dialog types
 ; Input a string of characters for the dialog type field.
 ;    example "EGS" = search element, groups, result groups
 ; Output an array by finding types, Finding IEN, Dialog IEN, "F" or "A"
 ;    example OUT("AUTTHF(",608,631,"F")=""
FARRAY(SUB,TYPES) ;
 N AFIEN,AFIND,DIEN,FIND,IDX,NODE,OI,TYPE,X
 K ^TMP($J,SUB)
 F X=1:1:$L(TYPES)  S TYPE=$E(TYPES,X) D
 .S DIEN=""
 .F  S DIEN=$O(^PXRMD(801.41,"TYPE",TYPE,DIEN)) Q:DIEN'>0  D
 ..I TYPE="S" D  Q
 ...S FIND=$P($G(^PXRMD(801.41,DIEN,50)),U)
 ...I FIND'="" D SETGBL(SUB,DIEN,FIND_";YTT(601.71,","RG",0)
 ..S NODE=$G(^PXRMD(801.41,DIEN,1))
 ..S FIND=$P(NODE,U,5),OI=$P(NODE,U,7)
 ..I FIND'="" D SETGBL(SUB,DIEN,FIND,"F",0)
 ..I OI'="" D SETGBL(SUB,DIEN,OI_";ORD(101.43,","O",0)
 ..S AFIND=""
 ..F  S AFIND=$O(^PXRMD(801.41,DIEN,3,"B",AFIND)) Q:AFIND=""  D
 ...S AFIEN=$O(^PXRMD(801.41,DIEN,3,"B",AFIND,""))
 ...D SETGBL(SUB,DIEN,AFIND,"A",AFIEN)
 ..S IDX=0 F  S IDX=$O(^PXRMD(801.41,DIEN,"BL",IDX)) Q:IDX'>0  D
 ...S NODE=$G(^PXRMD(801.41,DIEN,"BL",IDX,0))
 ...S FIND=$P(NODE,U,2),SEQ=$P(NODE,U)
 ...D SETGBL(SUB,DIEN,FIND,"B",SEQ)
 Q
 ;
RTAXNAME(NAME) ;
 I '$D(^PXD(811.2,"B",NAME)) Q NAME
 N CNT,FOUND,RESULT,TEMP
 S TEMP=NAME,CNT=0
 I $L(NAME)>64 S TEMP=$E(NAME,1,60)
 S TEMP=TEMP_"*"
 I '$D(^PXD(811.2,"B",TEMP)) Q TEMP
 S FOUND=0
 F  D  Q:FOUND=1
 .S CNT=CNT+1
 .I '$D(^PXD(811.2,"B",TEMP_CNT)) S RESULT=TEMP_CNT,FOUND=1
 Q RESULT
 ;
SETGBL(SUB,DIEN,VARP,LOC,IEN) ;
 N FIEN,GBL
 S GBL=$P(VARP,";",2),FIEN=$P(VARP,";")
 I LOC="A" S ^TMP($J,SUB,GBL,FIEN,DIEN,LOC,IEN)="" Q
 S ^TMP($J,SUB,GBL,FIEN,DIEN,LOC)=""
 Q
 ;
NATCONV(DIEN) ; entry point to convert a local dialog to a national dialog
 N ARRAY,IEN,DARRAY,DCNT
 S DCNT=0
 D DITEMAR(DIEN,.ARRAY,.DARRAY,.DCNT)
 S IEN=0 F  S IEN=$O(DARRAY(IEN)) Q:IEN'>0  D
 .D DMAKENAT(IEN)
 D DMAKENAT(DIEN)
 Q
 ;
LINK2TIU(DNAME,TNAME,TEMPNAME,TEMPONLY,GBL) ;
 ;;  DNAME=DIALOG NAME
 ;;  TNAME=TIU TITLE NAME
 ;;  TEMPNAME=FILE 8927 ENTRY NAME. If not defined the name is set to DNAME
 ;;  TEMPONLY=1 PLACE ITEM UNDER SHARED TEMPLATES ROOT, 0=PLACE ITEM UNDER DOCUMENT TITLES ROOT
 ;;  GBL=GLOBAL FOR LINK FIELD IN FILE 8927
 N DA,DIE,DIEN,DR,FDA,IENS,LASTVAL,LINK,LVL,NAME,PAR,PXRMERR,PXRMPAR,SIEN
 N TEMPIEN,TEXT,TIU,TYPE,DONE,TIEN,MSG,INST,OK,PREIEN,SINDEX,FLAG
 ; find dialog
 S TEXT(1)="Template not created"
 S NAME=$S($G(TEMPNAME)'="":TEMPNAME,1:DNAME)
 S DIEN=$O(^PXRMD(801.41,"B",DNAME,""))
 I DIEN'>0 S TEXT(2)="  Could not find dialog: "_DNAME D MES^XPDUTL(.TEXT) Q
 I $P($G(^PXRMD(801.41,DIEN,0)),U,4)'="R" S TEXT(2)="  "_DNAME_"type is not a dialog" D MES^XPDUTL(.TEXT) Q
 ;find note title IEN
 I +TEMPONLY=0 D
 .S TIEN=0,DONE=0 F  S TIEN=$O(^TIU(8925.1,"B",TNAME,"")) Q:TIEN'>0!(DONE=1)  D
 ..S TYPE=$P($G(^TIU(8925.1,TIEN,0)),U,4) I TYPE="DOC" S DONE=1
 .I TIEN'>0 S TEXT(2)="  Could not find note title: "_TNAME D MES^XPDUTL(.TEXT) Q
 ;
 ;set parameter value to true OK=0 means entity/value pair already exists.
 S PAR="TIU TEMPLATE REMINDER DIALOGS",LVL="SYS",OK=1
 D GETLST^XPAR(.PXRMPAR,LVL,PAR,"I",.PXRMERR)
 S LASTVAL=$O(PXRMPAR(""),-1)
 ;F INST=1:1:LASTVAL D  Q:INST>LASTVAL!(OK=0)
 ;. Q:'$D(PXRMPAR(INST))
 S INST=0 F  S INST=$O(PXRMPAR(INST)) Q:INST'>0!(OK=0)  D
 . I PXRMPAR(INST)=DIEN S OK=0
 I OK=1 D
 . S LASTVAL=LASTVAL+1
 . D EN^XPAR(LVL,PAR,LASTVAL,"`"_DIEN,.PXRMERR)
 ;
 ;find template root IEN
 I +$G(TEMPONLY)=1 S SIEN=$O(^TIU(8927,"AROOT","ROOT",""))
 E  S SIEN=$O(^TIU(8927,"AROOT","TITLES",""))
 I SIEN'>0 S TEXT(2)="  Could not find "_$S(+$G(TEMPONLY)=1:"Shared Templates",1:"Document Titles")_" folder" D MES^XPDUTL(.TEXT) Q
 ;check for pre-existing template?
 S PREIEN=$O(^TIU(8927,"B",$S($G(TEMPNAME)'="":TEMPNAME,1:DNAME)_" TEMPLATE","")),FLAG=1
 I +$G(PREIEN)>0 D
 . S SINDEX=0
 . F  S SINDEX=$O(^TIU(8927,SIEN,10,SINDEX)) Q:+$G(SINDEX)'>0!(FLAG=0)  D
 . . I $P(^TIU(8927,SIEN,10,SINDEX,0),U)=SINDEX&($P(^TIU(8927,SIEN,10,SINDEX,0),U,2)=PREIEN) S FLAG=0 D
 . . . ;K MSG
 . . . S TEXT(2)="  "_NAME_" template already exists under ",TEXT(3)="    "_$S(+$G(TEMPONLY)=1:"Shared Templates",1:"Document Titles")_" folder"
 . . . D MES^XPDUTL(.TEXT)
 . . . ;K MSG
 Q:FLAG=0
 ;create linking template to dialog
 S IENS="?+1,"
 S FDA(8927,IENS,.01)=NAME
 S FDA(8927,IENS,.03)="TEMPLATE"
 S FDA(8927,IENS,.04)="ACTIVE"
 S FDA(8927,IENS,.05)="NO"
 S FDA(8927,IENS,.08)="NO"
 S FDA(8927,IENS,.09)="NO"
 S FDA(8927,IENS,.1)="NO"
 S FDA(8927,IENS,.11)="NO"
 S FDA(8927,IENS,.12)="NO"
 S FDA(8927,IENS,.13)="NO"
 S FDA(8927,IENS,.14)="NO"
 S FDA(8927,IENS,.15)=DNAME
 D UPDATE^DIE("E","FDA","IENS","MSG")
 I $D(MSG)>0 S TEXT(2)="  Could not find "_DNAME_" template IEN" D MES^XPDUTL(.TEXT) D AWRITE^PXRMUTIL("MSG") Q
 S TEMPIEN=IENS(1) I TEMPIEN'>0 S TEXT(2)="  Could not find "_DNAME_" template IEN" D MES^XPDUTL(.TEXT) Q
 D MES^XPDUTL("Template "_NAME_" created")
 ;
 ;assign link template to Shared Template
 K IENS,FDA
 S LASTVAL=$O(^TIU(8927,SIEN,10,"B",""),-1)
 S LASTVAL=LASTVAL+1
 S FDA(8927.03,"+2,"_SIEN_",",.01)=LASTVAL
 S FDA(8927.03,"+2,"_SIEN_",",.02)=TEMPIEN
 D UPDATE^DIE("","FDA","","MSG")
 I $D(MSG)>0 D
 .S TEXT(2)="  Error adding "_DNAME_" Template to the "_$S(+$G(TEMPONLY)=1:"Shared Templates",1:"Document Titles")_" folder"
 .D MES^XPDUTL(.TEXT) D AWRITE^PXRMUTIL("MSG") Q
 I +$G(TEMPONLY)=1 D MES^XPDUTL("Template "_NAME_" added to Shared Folder.") Q
 ;
 ;assign note title to template
 S DA=TEMPIEN,DIE="^TIU(8927,"
 S LINK=TIEN_";"_GBL
 S DR=".19////^S X=LINK"
 D ^DIE
 D MES^XPDUTL("Template "_NAME_" link to note title "_TNAME)
 K FDA,IENS
 S IENS=TEMPIEN_","
 S FDA(8927,IENS,.01)=TNAME
 D UPDATE^DIE("E","FDA","IENS","MSG")
 I $D(MSG)>0 D
 .S TEXT(1)="Could not rename template"
 .D MES^XPDUTL(.TEXT) D AWRITE^PXRMUTIL("MSG")
 Q
 ;
