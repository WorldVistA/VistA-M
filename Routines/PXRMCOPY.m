PXRMCOPY ; SLC/PKR,PJH - Copy various reminder files. ;06/12/2009
 ;;2.0;CLINICAL REMINDERS;**6,12**;Feb 04, 2005;Build 73
 ;
 ;=====================================================
COPY(PROMPT,ROOT,WHAT) ;Copy an entry of ROOT into a new entry.
 N DIROUT,DTOUT,DUOUT
 F  D GETORGR Q:$D(DIROUT)  Q:$D(DTOUT)
 Q
 ;
 ;=====================================================
GETORGR ;Look-up logic to get and copy source entry to destination.
 N DA,DIE,DIC,DIK,DIR,DIRUT,FDA,FIELDLEN,FILE
 N IENN,IENO,IENS,MSG,NAME,ORGNAME,X,Y
 S DIC=ROOT,DIC(0)="AEMQ",DIC("A")=PROMPT
 W !
 D ^DIC
 I $D(DUOUT)!$D(DTOUT) S DIROUT="" Q
 S IENO=$P(Y,U,1)
 I IENO=-1 S DIROUT="" Q
 ;
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
 W !
 ;
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
 L +@DEST:10
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
