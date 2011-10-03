IBCNRFM1 ;DAOU/DMK - Perform FileMan API Calls ;05-NOV-2003
 ;;2.0;INTEGRATED BILLING;**251**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Description
 ;
 ; Perform FileMan Add, Delete, File, and Lookup API calls
 ;
 Q
 ;
ADD1(FILENO,X) ; Add file entry via FILE^DICN
 ;   FILENO = file #
 ;        X = file .01 field internal value
 ;
 K DO
 N DA,DIC,DIE,DINUM,DLAYGO,DTOUT,DUOUT,Y
 S DIC=$$ROOT^DILFD(FILENO),DIC(0)="L"
 S DLAYGO=FILENO
 D FILE^DICN
 Q +Y
 ;
ADD2(FILENO,IEN1,FIELDNO,X) ; Add subfile entry via FILE^DICN
 ;   FILENO = file #
 ;     IEN1 = file level internal entry number
 ;  FIELDNO = subfile field #
 ;        X = subfile .01 field internal value
 ;
 ; FILENO_FIELDNO must = subfile #
 ; ","_IEN1_"," = IENS = internal entry number string
 ;
 K DO
 N DA,DIC,DIE,DINUM,DLAYGO,DTOUT,DUOUT,Y
 S DA(1)=IEN1
 S DIC=$$ROOT^DILFD(FILENO_FIELDNO,","_IEN1_",")
 S DIC(0)="L",DIC("P")=$P(^DD(FILENO,FIELDNO,0),"^",2)
 S DLAYGO=FILENO
 D FILE^DICN
 Q +Y
 ;
DELETE1(FILENO,IEN) ; Delete file entry via DIK
 ;   FILENO = file #
 ;      IEN = file level internal entry number
 ;
 N %,DA,DIC,DIK,X,Y
 S DA=IEN
 S DIK=$$ROOT^DILFD(FILENO)
 D ^DIK
 Q
 ;
DELETE2(FILENO,IEN1,FIELDNO,IEN) ; Delete subfile entry via DIK
 ;   FILENO = file #
 ;     IEN1 = file level internal entry number
 ;  FIELDNO = subfile field #
 ;      IEN = subfile level internal entry number
 ;
 ; FILENO_FIELDNO must = subfile #
 ; ","_IEN_"," = IENS = internal entry number string
 ;
 N %,DA,DIC,DIK,X,Y
 S DA(1)=IEN1,DA=IEN
 S DIK=$$ROOT^DILFD(FILENO_FIELDNO,","_IEN1_",")
 D ^DIK
 Q
 ;
FILE1(FILENO,IEN,DATA) ; File data via DIE
 ;   FILENO = file #
 ;      IEN = file level internal entry number
 ;     DATA = array reflecting field numbers and values
 ;            (DATA(FIELDNO)=VALUE)
 ;
 N DA,DIC,DIDEL,DIE,DLAYGO,DR,DTOUT,X,Y
 N FIELDNO,I
 S DA=IEN
 S DIE=$$ROOT^DILFD(FILENO)
 S FIELDNO=$O(DATA(""))
 S DR=FIELDNO_"////^S X=DATA("_FIELDNO_")"
 F I=1:1 S FIELDNO=$O(DATA(FIELDNO)) Q:FIELDNO=""  D
 . S DR(1,FILENO,I)=FIELDNO_"////^S X=DATA("_FIELDNO_")"
 D ^DIE
 Q
 ;
FILE2(FILENO,IEN1,FIELDNO1,IEN,DATA) ; File subfile data via DIE
 ;   FILENO = file #
 ;     IEN1 = file level internal entry number
 ; FIELDNO1 = file field #
 ;      IEN = subfile level internal entry number
 ;     DATA = array reflecting subfile field numbers and
 ;            values (DATA(FIELDNO)=VALUE)
 ;
 ; FILENO_FIELDNO must = subfile #
 ; ","_IEN_"," = IENS = internal entry number string
 ;
 N DA,DIDEL,DIC,DIE,DLAYGO,DR,DTOUT,X,Y
 N FIELDNO,I
 S DA=IEN,DA(1)=IEN1
 ;S DIE=$$ROOT^DILFD(FILENO)_IEN1_","_FIELDNO1_","
 S DIE=$$ROOT^DILFD(FILENO_FIELDNO1,","_IEN1_",")
 S FIELDNO=$O(DATA(""))
 S DR=FIELDNO_"////^S X=DATA("_FIELDNO_")"
 F I=1:1 S FIELDNO=$O(DATA(FIELDNO)) Q:FIELDNO=""  D
 . S DR(1,FILENO_FIELDNO1,I)=FIELDNO_"////^S X=DATA("_FIELDNO_")"
 D ^DIE
 Q
 ;
LOOKUP1(FILENO,X) ; Lookup file entry via DIC
 ;   FILENO = file #
 ;        X = lookup value
 ;
 N DA,DIC,DIE,DINUM,DLAYGO,DTOUT,DUOUT,Y
 S DIC=$$ROOT^DILFD(FILENO),DIC(0)="X"
 D ^DIC
 Q +Y
 ;
LOOKUP2(FILENO,IEN1,FIELDNO,X) ; Lookup subfile entry via DIC
 ;   FILENO = file #
 ;     IEN1 = file level internal entry number
 ;  FIELDNO = subfile field #
 ;        X = lookup value
 ;
 ; FILENO_FIELDNO must = subfile #
 ; ","_IEN1_"," = IENS = internal entry number string
 ;
 N DA,DIC,DIE,DINUM,DLAYGO,DTOUT,DUOUT,Y
 I IEN1'=-1 D
 . S DIC=$$ROOT^DILFD(FILENO_FIELDNO,","_IEN1_","),DIC(0)="X"
 . D ^DIC
 I IEN1=-1 S Y=-1
 Q +Y
 ;
LOOKUP3(FILENO,D,X) ; Lookup file entry via IX^DIC
 ;   FILENO = file #
 ;        D = cross-reference to use
 ;        X = lookup value
 ;
 N DA,DIC,DIE,DINUM,DLAYGO,DTOUT,DUOUT,Y
 S DIC=$$ROOT^DILFD(FILENO),DIC(0)="X"
 D IX^DIC
 Q +Y
 ;
SELECT1(FILENO,PROMPT) ; Select file entry via DIC
 ;   FILENO = file #
 ;   PROMPT = prompt (optional)
 ;
 N DIC,DTOUT,DUOUT,X,Y
 S DIC=$$ROOT^DILFD(FILENO)
 S DIC(0)="ABEMQ"
 I $G(PROMPT)]"" S DIC("A")=PROMPT
 D ^DIC
 I $D(DTOUT)!$D(DUOUT) S Y=-1
 Q +Y
