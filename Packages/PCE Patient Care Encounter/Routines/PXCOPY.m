PXCOPY ;SLC/PKR - Copy various PCE files. ;05/21/2018
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 454
 ;================================
COPY(FILENUM,IEN) ;Copy an entry of ROOT into a new entry.
 N DA,DIK,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FDA,FIELDLEN,FILENAME
 N IENN,IENS,MSG,NAME,ORIGNAME,RESULT,ROOT,X,Y
 S ROOT=$$ROOT^DILFD(FILENUM)
 S FILENAME=$$GET1^DID(FILENUM,"","","NAME")
 S FILENAME=$$LOW^XLFSTR(FILENAME)
 S ORIGNAME=$$GET1^DIQ(FILENUM,IEN,.01)
 ;Get the new name.
 S FIELDLEN=$$GET1^DID(FILENUM,.01,"","FIELD LENGTH")
 S DIR(0)="F"_U_"3:"_FIELDLEN_U_"K:(X?.N)!'(X'?1P.E) X"
 S DIR("A")="Enter a Unique Name"
GETNAM D ^DIR
 I $D(DIRUT) Q
 S NAME=Y
 ;
 ;Make sure the new name is valid and unique.
 I '$$VNAME^PXINPTR(NAME) G GETNAM
 I $$FIND1^DIC(FILENUM,"","BXU",NAME) D  G GETNAM
 . W !,"There is already an entry with that name!"
 ;
 ;Set the starting place for additions and do the merge.
 D SETSTART(ROOT)
 S IENN=$$GETFOIEN(ROOT)
 S RESULT=$$MERGE(IENN,IEN,ROOT)
 I RESULT=0 W !,"Could not get a lock!" G GETNAM
 ;
 ;Change to the new name.
 S IENS=IENN_","
 S FDA(FILENUM,IENS,.01)=NAME
 K MSG
 D FILE^DIE("","FDA","MSG")
 ;Check to make sure the name was not a duplicate.
 I $G(MSG("DIERR",1))=740 D  G GETNAM
 . W !,NAME," is not a unique name!"
 ;Change the class to local and delete the sponsor.
 D SCAS(FILENUM,IENN,"L","")
 ;Initialize the change log.
 D INIEH(FILENUM,ROOT,IENN,IEN)
 ;
 ;Re-index the cross-references.
 S DIK=ROOT,DA=IENN
 D IX^DIK
 ;
 ;Tell the user what has happened and allow for editing of the new item.
 W !
 S DIR(0)="Y"
 S DIR("A")="Do you want to edit it now"
 S DIR("A",1)="The original "_FILENAME_" "_ORIGNAME_" has been copied into "_NAME_"."
 D ^DIR Q:$D(DIRUT)
 I Y D EDIT(FILENUM,IENN)
 Q
 ;
 ;================================
EDIT(FILENUM,IEN) ;Call the appropriate editor.
 ;The initial version only includes taxonomies.
 I FILENUM=9999999.09 D SMANEDIT^PXEDUSM(IEN,0)
 I FILENUM=9999999.15 D SMANEDIT^PXEXSM(IEN,0)
 I FILENUM=9999999.64 D SMANEDIT^PXHFSM(IEN,0)
 Q
 ;
 ;================================
GETFOIEN(ROOT) ;Return the first open IEN in ROOT. This should be called
 ;after a call to SETSTART.
 N ENTRY,NIEN,OIEN
 S ENTRY=ROOT_0_")"
 S OIEN=+$P(@ENTRY,U,3)
 S ENTRY=ROOT_OIEN_")"
 F  S NIEN=$O(@ENTRY) Q:+(NIEN-OIEN)>1  Q:+NIEN'>0  S OIEN=NIEN,ENTRY=ROOT_NIEN_")"
 Q OIEN+1
 ;
 ;================================
INIEH(FILENUM,ROOT,IENN,IEN) ;Initialize the change log after a copy.
 ;First delete any existing history entries.
 N ENTRY,IND,IENS,FDA,FDAIEN,MSG,SFN,TARGET,WP
 D FIELD^DID(FILENUM,"CHANGE LOG","","SPECIFIER","TARGET")
 S SFN=+$G(TARGET("SPECIFIER"))
 I SFN=0 Q
 S ENTRY=ROOT_IENN_",110)"
 S IND=0
 F  S IND=$O(@ENTRY@(IND)) Q:+IND=0  D
 . S IENS=IND_","_IENN_","
 . S FDA(SFN,IENS,.01)="@"
 I $D(FDA(SFN)) D FILE^DIE("K","FDA","MSG")
 I $D(MSG) D AWRITE^PXUTIL("MSG")
 ;Establish an initial entry in the change log.
 K FDA,MSG
 S IENS="+1,"_IENN_","
 S FDAIEN(IENN)=IENN
 S FDA(SFN,IENS,.01)=$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 S FDA(SFN,IENS,1)=$$GET1^DIQ(200,DUZ,.01)
 S FDA(SFN,IENS,2)="WP(1,1)"
 S WP(1,1,1)="Copied from "_$$GET1^DIQ(FILENUM,IEN,.01)
 D UPDATE^DIE("E","FDA","FDAIEN","MSG")
 I $D(MSG) D AWRITE^PXUTIL("MSG")
 Q
 ;
 ;================================
MERGE(IENN,IEN,ROOT) ;Use MERGE to copy ROOT(IEN into ROOT(IENN.
 N DEST,SOURCE
 S DEST=ROOT_IENN_")"
 ;Lock the file before merging.
 L +@DEST:DILOCKTM
 I '$T Q 0
 S SOURCE=ROOT_IEN_")"
 M @DEST=@SOURCE
 ;Unlock the file
 L -@DEST
 Q 1
 ;
 ;================================
SCAS(FILENUM,IEN,CLASS,SPONSOR) ;Set the class field to CLASS and the sponsor
 ;field to SPONSOR.
 N IENS,FDA,MSG
 S IENS=IEN_","
 S FDA(FILENUM,IENS,100)=CLASS
 S FDA(FILENUM,IENS,101)=SPONSOR
 D FILE^DIE("K","FDA","MSG")
 I $D(MSG) D AWRITE^PXUTIL("MSG")
 Q
 ;
 ;================================
SETSTART(ROOT) ;Set the starting value to add new entries. Start
 ;at the beginning so empty spaces are filled in.
 N CUR,ENTRY
 S ENTRY=ROOT_"0)"
 S $P(@ENTRY,U,3)=1
 Q
 ;
