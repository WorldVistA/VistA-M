MCPOS0C ;HIRMFO/RMP,DAD-ASTM file update ;7/24/96  08:39
 ;;2.3;Medicine;;09/13/1996
 ;
 D STUFF("MCPMVA",690.2)
 Q
 ;
START(FILE) ;DESIGNED TO CREATE MCPMVA - Medicine View ASTM subfile
 ;Medicine View file entry - template name
 ;Subfile entires for Field Number
 ;SubSubfile entry for ASTM value
 N COUNT,TEMP,REC,PROC,CODE
 S COUNT=0,TEMP=""
 F  S TEMP=$O(^MCAR(FILE,"B",TEMP)) Q:TEMP=""  D
 . S REC=$O(^MCAR(FILE,"B",TEMP,""))
 . S TMP=$S($D(^MCAR(FILE,REC,1)):$$TMP(FILE,REC),1:"")
 . Q:TMP=""
 . W !,";;",$P(^MCAR(FILE,REC,0),U)_"^"_TMP
 . Q
 Q
TMP(FILE,REC) ;FOR EVERY Template with ASTM pointers in the SUB OR
 ; SUBSUBfile structure GET ASTM ID's
 N CNT,ARRAY,TMP,SUBENTRY
 S CNT=0,(ARRAY)=""
 F  S CNT=$O(^MCAR(FILE,REC,1,CNT)) Q:CNT'?1N.N  D
 . S TMP=^MCAR(FILE,REC,1,CNT,0)
 . Q:$P(TMP,U,3)=""  S SUBENTRY=$P(TMP,U),TMP=$P(TMP,U,3)
 . S TMP=$P(^MCAR(690.5,TMP,0),U,1,2),TMP=$TR(TMP,U,"~")
 . S TMP=SUBENTRY_"~"_TMP
 . S:$L(ARRAY)>0 ARRAY=ARRAY_","
 . S ARRAY=ARRAY_TMP
 . Q
 Q ARRAY
 ;
STUFF(ROUTINE,TFILE) ;ROUTINE is set to "MCPMVA"
 ;FILE is set to 690.2
 N TEMP,COUNT,HOLD,VALUE,LOOP
 S MCDATA(1)=""
 S MCDATA(2)="Update the pointers from the Medicine View file (#690.2)"
 S MCDATA(3)="to the ASTM file (#690.5)."
 D MES^XPDUTL(.MCDATA)
 ;
 F LOOP=1:1 S HOLD=$P($T(DATA+LOOP^@(ROUTINE)),";;",2) Q:HOLD=""  D
 . S (DLAYGO,DIC)=TFILE,DIC(0)="L"
 . S (VALUE,X)=$P(HOLD,U)
 . D ^DIC I Y=-1 K DIC,DA Q
 . S DA=+Y
 . D SCODE($P(HOLD,U,2),DA,TFILE)
 . Q
 Q
 ;
SCODE(STEMP,SDA,FILE) ;
 N ENTRY,CODE,TYPE,DATE,LOOP
 F LOOP=1:1 S ENTRY=$P(STEMP,",",LOOP) Q:ENTRY=""  D
 . S ASTM=$$ASTM(ENTRY)
 . S DA(1)=SDA,DIC="^MCAR("_FILE_","_DA(1)_",1,",DIC(0)="L"
 . S DIC("P")=$$GET1^DID(FILE,2,"","SPECIFIER"),DLAYGO=FILE
 . S (X,CODE)=$P(ENTRY,"~"),CODE2=$P(ENTRY,"~",2)
 . D ^DIC
 . I Y=-1 K DIC,DA Q
 . S DIE=DIC,DA=+Y K DIC
 . S DR="2////^S X=ASTM"
 . D ^DIE
 . K DIE,DR,DA,Y
 . Q
 Q
ASTM(ENTRY) ;
 N TMP,ASTM S (ASTM,TMP)=""
 S (X,CODE)=$P(ENTRY,"~",2),CODE2=$P(ENTRY,"~",3)
 F  Q:ASTM'=""  S TMP=$O(^MCAR(690.5,"B",CODE,TMP)) Q:TMP=""  D
 . S:$D(^MCAR(690.5,"C",CODE2,TMP)) ASTM=TMP
 . Q
 Q ASTM
