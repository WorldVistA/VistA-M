PXRMCOPY ;SLC/PKR,PJH - Copy various reminder files. ;12/09/2019
 ;;2.0;CLINICAL REMINDERS;**6,12,26,45**;Feb 04, 2005;Build 566
 ;
 ;=====================================================
COPY(PROMPT,ROOT,WHAT) ;Copy an entry of ROOT into a new entry.
 N DIROUT,DTOUT,DUOUT
 F  D GETORGR Q:$D(DIROUT)  Q:$D(DTOUT)
 Q
 ;
 ;=====================================================
GETORGR ;Look-up logic to get and copy source entry to destination.
 N DIC,IENN,IENO,Y
 S DIC=ROOT,DIC(0)="AEMQ",DIC("A")=PROMPT
 W !
 D ^DIC
 I $D(DUOUT)!$D(DTOUT) S DIROUT="" Q
 S IENO=$P(Y,U,1)
 I IENO=-1 S DIROUT="" Q
 D GETORGRC(IENO,.IENN,ROOT,WHAT,0)
 Q
 ;
GETORGRC(IENO,IENN,ROOT,WHAT,SKIP) ;
 N DA,DIC,DIE,DIK,DIR,DIRUT,FAIL,FDA,FIELDLEN,FILE
 N HASGF,IENS,MSG,NAME,ORGNAME,X,Y
 ; reminder dialog checks
 S DIC=ROOT,FAIL=0
 N DTYP,LFIND,LOCK
 I ROOT="^PXRMD(801.41," D
 .;Check for Uneditable flag
 .S LOCK=$P($G(^PXRMD(801.41,IENO,100)),U,4)
 .S LFIND=$P($G(^PXRMD(801.41,IENO,1)),U,5)
 .S DTYP=$P($G(^PXRMD(801.41,IENO,0)),U,4)
 .S HASGF=$$HASGF(IENO)
 .I HASGF D
 ..I $P($G(^PXRMD(801.41,IENO,0)),U)="VA-TICKLER ELEMENT" Q
 ..W !,"This item cannot be copied." S FAIL=1 H 2 Q
 .I LOCK=1,'$G(PXRMINST),DTYP="G" D  Q
 ..W !,"This item cannot be copied." S FAIL=1 H 2
 .I LOCK=1,$G(LFIND)'="",$G(LFIND)'["ORD",'$G(PXRMINST),DTYP'="G" D  Q
 ..W !,"This item cannot be copied." S FAIL=1 H 2
 ;
 I FAIL=1 Q
 ;Set the starting place for additions.
 D SETSTART^PXRMCOPY(DIC)
 S IENN=$$GETFOIEN(ROOT)
 D MERGE(IENN,IENO,ROOT)
 ;
 ;Get the new name.
 S ORGNAME=$P(@(ROOT_IENO_",0)"),U,1)
 S FILE=$$FNFR^PXRMUTIL(ROOT)
 S FIELDLEN=$$GET1^DID(FILE,.01,"","FIELD LENGTH")
 S DIR(0)="F"_U_"3:"_FIELDLEN_U_"K:(X?.N)!'(X'?1P.E) X"
 S DIR("A")="PLEASE ENTER A UNIQUE NAME"
GETNAM D ^DIR
 I $D(DIRUT) D DELETE(ROOT,IENN) Q
 S NAME=Y
 ;
 ;Make sure the new name is valid.
 I '$$VNAME^PXRMINTR(NAME) G GETNAM
 ;
 ;Change to the new name.
 S IENS=IENN_","
 S FDA(FILE,IENS,.01)=NAME
 K MSG
 D FILE^DIE("","FDA","MSG")
 ;Check to make sure the name was not a duplicate.
 I $G(MSG("DIERR",1))=740 D  G GETNAM
 . W !,NAME," is not a unique name!"
 ;Change the class to local and delete the sponsor.
 D SCAS(FILE,IENN,"L","")
 ;Initialize the edit history.
 D INIEH(FILE,ROOT,IENN,IENO)
 ;
 ;Reindex the cross-references.
 S DIK=ROOT,DA=IENN
 D IX^DIK
 I $G(PXRMDANY)=1 D  Q
 .W !!,"Completed copy of '"_ORGNAME_"'"
 .W !,"into '"_NAME_"'",! H 2
 .I $P(@(ROOT_IENN_",0)"),U,4)="P" D
 ..;Allow PXRM prompts to be changed into forced values
 ..N ANS,TEXT
 ..S TEXT="Change the new prompt into a forced value :"
 ..D ASK^PXRMDCPY(.ANS,TEXT,4,"N") Q:$D(DUOUT)!$D(DTOUT)  Q:ANS'="Y"
 ..;Store the dialog type
 ..S DR="4///F",DIE=ROOT,DA=IENN
 ..D ^DIE
 .S DTOUT=1,PXRMDANY=0
 W !
 ;
 I SKIP=1 W !,"The original "_WHAT_" "_ORGNAME_" has been copied into "_NAME_"." H 1 Q
 ;Tell the user what has happened and allow for editing of the new item.
 S DIR(0)="Y"
 S DIR("A")="Do you want to edit it now"
 S DIR("A",1)="The original "_WHAT_" "_ORGNAME_" has been copied into "_NAME_"."
 D ^DIR Q:$D(DIRUT)
 I Y D EDIT^PXRMEDIT(ROOT,IENN)
 Q
 ;
 ;=====================================================
COPYLL ;Copy a location list.
 N PROMPT,ROOT,WHAT
 S WHAT="location list"
 S ROOT="^PXRMD(810.9,"
 S PROMPT="Select the reminder location list to copy: "
 D COPY(PROMPT,ROOT,WHAT)
 Q
 ;
 ;=====================================================
COPYREM ;Copy a reminder definition.
 N PROMPT,ROOT,WHAT
 S WHAT="reminder"
 S ROOT="^PXD(811.9,"
 S PROMPT="Select the reminder definition to copy: "
 D COPY(PROMPT,ROOT,WHAT)
 Q
 ;
 ;=====================================================
COPYTAX ;Copy a taxonomy.
 N PROMPT,ROOT,WHAT
 S WHAT="taxonomy"
 S ROOT="^PXD(811.2,"
 S PROMPT="Select the reminder taxonomy to copy: "
 D COPY(PROMPT,ROOT,WHAT)
 Q
 ;
 ;=====================================================
COPYTERM ;Copy a reminder term.
 N PROMPT,ROOT,WHAT
 S WHAT="reminder term"
 S ROOT="^PXRMD(811.5,"
 S PROMPT="Select the reminder term to copy: "
 D COPY(PROMPT,ROOT,WHAT)
 Q
 ;
 ;=====================================================
DELETE(DIK,DA) ;Delete the entry just added. 
 D ^DIK
 W !!,"New entry not created due to invalid name!",!
 Q
 ;
 ;=====================================================
GETFOIEN(ROOT) ;Return the first open IEN in ROOT. This should be called
 ;after a call to SETSTART.
 N ENTRY,NIEN,OIEN
 S ENTRY=ROOT_0_")"
 S OIEN=+$P(@ENTRY,U,3)
 S ENTRY=ROOT_OIEN_")"
 F  S NIEN=$O(@ENTRY) Q:+(NIEN-OIEN)>1  Q:+NIEN'>0  S OIEN=NIEN,ENTRY=ROOT_NIEN_")"
 Q OIEN+1
 ;
 ;
HASGF(IEN) ;
 N ARRAY,CNT,DIEN,DARRAY,RESULT
 S CNT=0,RESULT=0
 I $G(PXRMINST)=1 Q RESULT
 S RESULT=$$ITEMHSGF(IEN) I RESULT=1 Q RESULT
 I '$D(^PXRMD(801.41,IEN,10)) Q RESULT
 D DITEMAR^PXRMDUTL(IEN,.ARRAY,.DARRAY,.CNT)
 S DIEN=0 F  S DIEN=$O(DARRAY(DIEN)) Q:DIEN'>0!(RESULT=1)  D
 .S RESULT=$$ITEMHSGF(DIEN)
 Q RESULT
 ;
ITEMHSGF(IEN) ;
 N FIND,FOUND
 I $G(PXRMINST)=1 Q 0
 I $P($G(^PXRMD(801.41,IEN,1)),U,5)[801.46 Q 1
 S FOUND=0,FIND="" F  S FIND=$O(^PXRMD(801.41,IEN,3,"B",FIND)) Q:FIND=""!(FOUND=1)  D
 .I FIND[801.46 S FOUND=1
 Q 0
 ;
 ;=====================================================
INIEH(FILENUM,ROOT,IENN,IENO) ;Initialize the edit history after a copy.
 ;First delete any existing history entries.
 N ENTRY,IND,IENS,FDA,FDAIEN,MSG,SFN,TARGET,WP
 D FIELD^DID(FILENUM,"EDIT HISTORY","","SPECIFIER","TARGET")
 S SFN=+$G(TARGET("SPECIFIER"))
 I SFN=0 Q
 S ENTRY=ROOT_IENN_",110)"
 S IND=0
 F  S IND=$O(@ENTRY@(IND)) Q:+IND=0  D
 . S IENS=IND_","_IENN_","
 . S FDA(SFN,IENS,.01)="@"
 I $D(FDA(SFN)) D FILE^DIE("K","FDA","MSG")
 I $D(MSG) D AWRITE^PXRMUTIL("MSG")
 ;Establish an initial entry in the edit history.
 K FDA,MSG
 S IENS="+1,"_IENN_","
 S FDAIEN(IENN)=IENN
 S FDA(SFN,IENS,.01)=$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 S FDA(SFN,IENS,1)=$$GET1^DIQ(200,DUZ,.01)
 S FDA(SFN,IENS,2)="WP(1,1)"
 S WP(1,1,1)="Copied from "_$$GET1^DIQ(FILENUM,IENO,.01)
 D UPDATE^DIE("E","FDA","FDAIEN","MSG")
 I $D(MSG) D AWRITE^PXRMUTIL("MSG")
 Q
 ;
 ;=====================================================
MERGE(IENN,IENO,ROOT) ;Use MERGE to copy ROOT(IENO into ROOT(IENN.
 N DEST,SOURCE
 S DEST=ROOT_IENN_")"
 ;Lock the file before merging.
 L +@DEST:DILOCKTM
 S SOURCE=ROOT_IENO_")"
 M @DEST=@SOURCE
 ;Unlock the file
 L -@DEST
 Q
 ;
 ;=====================================================
SCAS(FILENUM,IEN,CLASS,SPONSOR) ;Set the class field to CLASS and the sponsor
 ;field to SPONSOR.
 N IENS,FDA,MSG
 S IENS=IEN_","
 S FDA(FILENUM,IENS,100)=CLASS
 S FDA(FILENUM,IENS,101)=SPONSOR
 D FILE^DIE("K","FDA","MSG")
 I $D(MSG) D AWRITE^PXRMUTIL("MSG")
 Q
 ;
 ;=====================================================
SETSTART(ROOT) ;Set the starting value to add new entries. Start
 ;at the begining so empty spaces are filled in.
 N CUR,ENTRY
 S ENTRY=ROOT_"0)"
 S $P(@ENTRY,U,3)=1
 Q
 ;
