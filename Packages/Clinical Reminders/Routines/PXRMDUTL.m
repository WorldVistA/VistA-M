PXRMDUTL ; SLC/AGP - DIALOG UTILITIES. ;04/10/2013
 ;;2.0;CLINICAL REMINDERS;**24,26,53**;Feb 04, 2005;Build 225
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
 N CNT,IEN,REPIEN,TYPE
 S CNT=0 F  S CNT=$O(^PXRMD(801.41,DIEN,10,CNT)) Q:CNT'>0  D
 .S IEN=$P($G(^PXRMD(801.41,DIEN,10,CNT,0)),U,2) Q:IEN'>0
 .S REPIEN=$P($G(^PXRMD(801.41,IEN,49)),U,3)
 .I REPIEN>0 D DITEMAR(REPIEN,.ARRAY,.DARRAY,.DCNT)
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
 S DIE="^PXRMXD(801.41,"
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
 N AFIEN,AFIND,DIEN,FIND,NODE,OI,TYPE,X
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
 N ARRAY,IEN
 D DITEMAR(DIEN,.ARRAY)
 S IEN=0 F  S IEN=$O(ARRAY(IEN)) Q:IEN'>0  D
 .D DMAKENAT(IEN)
 D DMAKENAT(DIEN)
 Q
 ;
