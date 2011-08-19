PXRMCLST ; SLC/PJH - List Reminder Categories ;03/09/2000
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;List all categories (for protocol PXRM SELECTION LIST)
 ;-------------------
ALL N BY,DC,DHD,DIC,FLDS,FR,L,LOGIC,NOW,TO,Y
 S Y=1
 D SET
 S DIC="^PXRMD(811.7,"
 S BY=".01"
 S FR=""
 S TO=""
 S DHD="W ?0 D HED^PXRMCLST"
 D DISP
 Q
 ;
 ;DISPLAY (Display from FLDS array)
 ;-------
DISP S L=0,FLDS="[PXRM REMINDER CATEGORIES]"
 D EN1^DIP
 Q
 ;
 ;Build list of sub-categories
 ;----------------------------
DSP N ARRAY,IC,SEQ,TAB,TXT
 ;
 ; D0=IEN OF PARENT D1=NODE NUMBER IN 10 OF CHILD 
 ;
 S IC=0 D GETLST(D0,D1,0)
 ;Display list of sub-categories
 S IC=0
 F  S IC=$O(ARRAY(IC)) Q:IC=""  D
 .S TAB=$P(ARRAY(IC),U),TXT=$P(ARRAY(IC),U,2)
 .W !,?TAB,TXT
 Q
 ;
 ;Get list of sub-categories
 ;--------------------------
GETLST(D0,D1,LEVEL) ;
 N CHILD,DATA,NAME,PXRMIEN,PXRMCAT,SEQ,SUB,TEMP
 ;Determine if this subcategory has children
 S DATA=$G(^PXRMD(811.7,D0,10,D1,0)) Q:DATA=""
 S PXRMCAT=$P(DATA,U) Q:PXRMCAT=""
 S NAME=$G(^PXRMD(811.7,PXRMCAT,0)) I NAME="" S NAME=PXRMCAT
 S IC=IC+1,ARRAY(IC)=LEVEL_U_"Sub-category: "_NAME
 ;Increment tab
 S LEVEL=LEVEL+5
 ;Don't allow > 4 levels
 I LEVEL>20 S IC=IC+1,ARRAY(IC)=LEVEL_U_"Further levels" Q
 ;
 ;Sort Reminders from this category into display sequence
 S SUB=0 K TEMP
 F  S SUB=$O(^PXRMD(811.7,PXRMCAT,2,SUB)) Q:SUB=""  D
 .S DATA=$G(^PXRMD(811.7,PXRMCAT,2,SUB,0)) Q:DATA=""
 .S PXRMIEN=$P(DATA,U) Q:PXRMIEN=""
 .S SEQ=$P(DATA,U,2)
 .S DATA=$G(^PXD(811.9,PXRMIEN,0)) Q:DATA=""
 .S NAME=$P(DATA,U) I NAME="" S NAME="Unknown"
 .S TEMP(SEQ)=NAME
 ;
 ;Re-save reminders in output array for display
 S SEQ=""
 F  S SEQ=$O(TEMP(SEQ)) Q:SEQ=""  D
 .S IC=IC+1
 .S ARRAY(IC)=LEVEL_U_"Sequence: "_$J(SEQ,2)_"  Reminder: "_TEMP(SEQ)
 ;
 ;Sort Sub-Categories for this category into display order
 S SUB=0 K TEMP
 F  S SUB=$O(^PXRMD(811.7,PXRMCAT,10,SUB)) Q:SUB=""  D
 .S DATA=$G(^PXRMD(811.7,PXRMCAT,10,SUB,0)) Q:DATA=""
 .S SEQ=$P(DATA,U,2),TEMP(SEQ)=SUB
 ;
 ;Process sub-sub categories in the same manner
 S SEQ=""
 F  S SEQ=$O(TEMP(SEQ)) Q:SEQ=""  D
 .S SUB=TEMP(SEQ)
 .D GETLST(PXRMCAT,SUB,LEVEL)
 Q
 ;
 ;Display Header (see DHD variable)
 ;--------------
HED N TEMP,TEXTLEN,TEXTHED,TEXTUND
 S TEXTHED="REMINDER CATEGORY LIST"
 S TEXTUND=$TR($J("",IOM)," ","-")
 S TEMP=NOW_"  Page "_DC
 S TEXTLEN=$L(TEMP)
 W TEXTHED
 W ?(IOM-TEXTLEN),TEMP
 W !,TEXTUND,!!
 Q
 ;
 ;Inquire/Print Option (for protocol PXRM GENERAL INQUIRE/PRINT)
 ;--------------------
INQ(Y) N BY,DC,DHD,DIC,FLDS,FR,L,LOGIC,NOW,TO
 S DIC="^PXRMD(811.7,"
 S DIC(0)="AEMQ"
 D SET
 D DISP
 Q
 ;
 ;Input Transforms for edit option PXRM REMINDER CATEGORY EDIT #811.7
 ;-------------------------------------------------------------------
BADITEM(X,DA1) ;Subcategory
 I X=DA1 Q 1
 Q '$$PARENTOK(DA1,X)
 ;
KILLAC ;This only applies if deleting a sub-category
 I '$D(^PXRMD(811.7,DA)) Q
 ;
 N SUB,MAS
 S MAS=""
 ;Get the parent categories for this sub sub-category, quit if none
 F  S MAS=$O(^PXRMD(811.7,"AC",DA,MAS)) Q:MAS=""  D
 .;Get sub category position in the parent, quit if none
 .S SUB=$O(^PXRMD(811.7,"AC",DA,MAS,"")) Q:SUB=""
 .;
 .;Kill the sub category on the parent category
 .N DIC,DIK,DA S DIK="^PXRMD(811.7,MAS,10,",DA(1)=MAS,DA=SUB D ^DIK
 .;Cross reference on SUBCATEGORY field kills the AC index entry
 Q
 ;
PARENTOK(PARENT,ITEM) ;Returns true if category is already in tree
 N IDX,OK
 S IDX=0,OK=1
 F  S IDX=$O(^PXRMD(811.7,"AC",PARENT,IDX)) Q:'IDX  D  Q:'OK
 .I IDX=ITEM S OK=0 Q
 .S OK=$$PARENTOK(IDX,ITEM)
 Q OK
 ;
 ;Reminders for this category
 ;---------------------------
REM N ARRAY,DATA,IC,NAME,PXRMIEN,SEQ,TEMP
 ;
 ; D0=IEN OF CATEGORY 
 ;
 S SUB=0
 ;Sort Reminders from this category into display sequence
 F  S SUB=$O(^PXRMD(811.7,D0,2,SUB)) Q:SUB=""  D
 .S DATA=$G(^PXRMD(811.7,D0,2,SUB,0)) Q:DATA=""
 .S PXRMIEN=$P(DATA,U) Q:PXRMIEN=""
 .S SEQ=$P(DATA,U,2)
 .S DATA=$G(^PXD(811.9,PXRMIEN,0)) Q:DATA=""
 .S NAME=$P(DATA,U) I NAME="" S NAME="Unknown"
 .S TEMP(SEQ_0)=NAME
 ;
 I $O(TEMP(""))="" W ! Q
 ;
 ;Re-save reminders in output array for display
 S SEQ="",IC=0
 F  S SEQ=$O(TEMP(SEQ)) Q:SEQ=""  D
 .S IC=IC+1
 .S ARRAY(IC)="Sequence: "_$J(SEQ/10,2)_"   Reminder: "_TEMP(SEQ)
 ;
 S IC=0
 F  S IC=$O(ARRAY(IC)) Q:IC=""  D
 .W !,ARRAY(IC)
 Q
 ;
SETAC Q
 ;
 ;Verify Reminder/Category display order is unique
 ;RECORD 2=Reminder 10=Sub-category
UNIQUE(X,DA1,DA,RECORD) ;
 N SUB,DATA,SEQ,TEMP
 S SUB=0
 F  S SUB=$O(^PXRMD(811.7,DA1,RECORD,SUB)) Q:'SUB  D
 .Q:SUB=DA
 .S SEQ=$P($G(^PXRMD(811.7,DA1,RECORD,SUB,0)),U,2)
 .I SEQ'="" S TEMP(SEQ)=""
 I $D(TEMP(X)) W "  Sequence number already used " Q 0
 Q 1
 ;
SET ;Setup all the variables
 ; Set Date for Header
 S NOW=$$NOW^XLFDT
 S NOW=$$FMTE^XLFDT(NOW,"1P")
 ;
 ;These variables need to be setup every time because DIP kills them.
 S BY="NUMBER"
 S (FR,TO)=+$P(Y,U,1)
 S DHD="W ?0 D HED^PXRMCLST"
 ;
 Q
