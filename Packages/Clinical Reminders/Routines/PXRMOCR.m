PXRMOCR ;SLC/PKR - Routines for editing order check rules ;05/30/2012
 ;;2.0;CLINICAL REMINDERS;**22**;Feb 04, 2005;Build 160
 ;Also contains routines used by the DD for file #801.1.
 ;=============================================
CHECK(IEN,DDSBR,DDSERROR) ;Check a rule for errors, called by DATA 
 ;VALIDATION on form.
 N DEF,OCTEXT,TERM,TEXT
 ;Either a term or definition must be defined.
 S TERM=$$GET^DDSVAL(801.1,IEN,20)
 S DEF=$$GET^DDSVAL(801.1,IEN,30)
 I TERM="",DEF="" D  Q
 . S TEXT="Either a term or defintion must be defined."
 . S DDSERROR=1
 . S DDSBR="TERM^PXRM OCR MAIN BLOCK^1"
 . I $D(DDS) D HLP^DDSUTL(TEXT)
 . E  D EN^DDIOL(TEXT)
 I (TERM'=""),($$GET^DDSVAL(801.1,IEN,21)="") D  Q
 . S TEXT="The TERM EVALUATION STATUS is missing."
 . S DDSERROR=1
 . S DDSBR="TERM EVALUATION STATUS^PXRM OCR TERM^20"
 . I $D(DDS) D MSG^DDSUTL(TEXT)
 . E  D EN^DDIOL(TEXT)
 I (DEF'=""),($$GET^DDSVAL(801.1,IEN,31)="") D  Q
 . S TEXT="The DEFINITION EVALUATION STATUS is missing."
 . S DDSERROR=1
 . S DDSBR="DEFINITION EVALUATION STATUS^PXRM OCR DEFINITION^30"
 . I $D(DDS) D MSG^DDSUTL(TEXT)
 . E  D EN^DDIOL(TEXT)
 I (DEF'=""),($$GET^DDSVAL(801.1,IEN,32)="") D  Q
 . S TEXT="The OUTPUT TEXT is missing."
 . S DDSERROR=1
 . S DDSBR="OUTPUT TEXT^PXRM OCR DEFINITION^30"
 . I $D(DDS) D MSG^DDSUTL(TEXT)
 . E  D EN^DDIOL(TEXT)
 S OCTEXT=$$GET^DDSVAL(801.1,IEN,"ORDER CHECK TEXT")
 I $$WPNCHAR^PXRMSMAN(OCTEXT)=0 D  Q
 . S TEXT="There is no ORDER CHECK TEXT."
 . S DDSERROR=1
 . S DDSBR="ORDER CHECK TEXT^PXRM OCR MAIN BLOCK^1"
 . I $D(DDS) D MSG^DDSUTL(TEXT)
 . E  D EN^DDIOL(TEXT)
 D FOCTXT(IEN,OCTEXT,.DDSBR,.DDSERROR)
 Q
 ;
 ;=============================================
DCAP(IEN) ;This is the executable caption for the definition.
 I '$$DEDOK(IEN) Q ""
 N DIEN
 S DIEN=$$GET^DDSVAL(801.1,IEN,"REMINDER DEFINITION")
 I DIEN="" Q "DEFINITION: "
 Q "DEFINITION: "_$P(^PXD(811.9,DIEN,0),U,1)
 ;
 ;=============================================
DDEL(IEN,OLD,NEW) ;Kill logic for AD cross-reference.
 I $G(NEW)>0 Q
 D DELFIELD(IEN,31)
 D DELFIELD(IEN,32)
 Q
 ;
 ;=============================================
DEDOK(IEN) ;The definition in a rule can be edited as long as a term has
 ;not been defined.
 I $$GET^DDSVAL(801.1,IEN,"REMINDER TERM")="" Q 1
 Q 0
 ;
 ;===================================
DELFIELD(IEN,FIELD) ;Delete a field.
 N FDA,IENS,MSG
 S IENS=IEN_","
 S FDA(801.1,IENS,FIELD)="@"
 D FILE^DIE("","FDA","MSG")
 Q
 ;
 ;=============================================
DPOST(IEN) ;Definition post-action.
 ;If the definition is defined do not allow navigation to the term.
 N VALUE
 S VALUE=$S($$TEDOK(IEN):0,1:1)
 D UNED^DDSUTL("TERM","PXRM OCR MAIN BLOCK",1,VALUE)
 Q
 ;
 ;=============================================
FOCTXT(IEN,OCTEXT,DDSBR,DDSERROR) ;Format and store the order check text as
 ;long as it does not contain a TIU object.
 N FDA,IENS,IND,MSG,NIN,NOUT,NPIPE,TEXTIN,TEXTOUT
 S NIN=$P(@OCTEXT@(0),U,4)
 S NPIPE=0
 F IND=1:1:NIN D
 . S TEXTIN(IND)=@OCTEXT@(IND,0)
 . S NPIPE=NPIPE+$L(TEXTIN(IND),"|")-1
 S $P(^PXD(801.1,IEN,5),U,1)=NIN
 ;Remove existing formatted text.
 K ^PXD(801.1,IEN,6) S $P(^PXD(801.1,IEN,5),U,2)=0
 I NPIPE=0 D  Q
 .;No TIU Objects, format and save the text.
 . D FORMAT^PXRMTEXT(1,80,NIN,.TEXTIN,.NOUT,.TEXTOUT)
 . S $P(^PXD(801.1,IEN,5),U,2)=NOUT
 . S IENS=IEN_","
 . S FDA(801.1,IENS,47)="TEXTOUT"
 . D UPDATE^DIE("","FDA","","MSG")
 I (NPIPE#2)=1 D
 .;There is an odd number of pipes.
 . S TEXTOUT(1)="Warning, the Order Check Text has "_NPIPE_" '|' characters."
 . S TEXTOUT(2)="Because this is an odd number, TIU Object expansion will not work."
 . S DDSERROR=1
 . S DDSBR="ORDER CHECK TEXT^PXRM OCR MAIN BLOCK^1"
 . I $D(DDS) D MSG^DDSUTL(.TEXTOUT)
 . E  D EN^DDIOL(.TEXTOUT)
 Q
 ;
 ;=============================================
FORMPRE(IEN) ;Form pre-action.
 ;If the term is defined, do not allow navigation to the definition.
 N VALUE
 S VALUE=$S($$DEDOK(IEN):0,1:1)
 D UNED^DDSUTL("DEFINITION","PXRM OCR MAIN BLOCK",1,VALUE)
 ;If the definition is defined do not allow navigation to the term.
 S VALUE=$S($$TEDOK(IEN):0,1:1)
 D UNED^DDSUTL("TERM","PXRM OCR MAIN BLOCK",1,VALUE)
 Q
 ;
 ;=============================================
SMANEDIT(IEN,NEW) ;Invoke the ScreeMan editor for entry IEN.
 N DA,DR,DDSCHANG,DDSFILE,DDSPARM,DDSSAVE,RESTRICT,RULCLASS
 S DDSFILE=801.1,DDSPARM="CS"
 S RULCLASS=$P($G(^PXD(801.1,IEN,100)),U,1)
 S RESTRICT=$S($G(PXRMINST):0,RULCLASS="N":1,1:0)
 S DR=$S(RESTRICT:"[PXRM OCR EDIT RESTRICTED]",1:"[PXRM OCR EDIT]")
 S DA=IEN
 D ^DDS
 ;If the entry is new and the user did not save, delete it.
 I $G(NEW),$G(DDSSAVE)'=1 D DELETE^PXRMEXFI(801.1,IEN) Q
 ;If changes were made update the edit history.
 I $G(DDSCHANG)'=1 Q
 ;Make sure the change was not a deletion.
 I '$D(^PXD(801.1,IEN)) Q
 ;Update the edit history.
 N IENS,FDA,FDAIEN,MSG
 S IENS="+1,"_IEN_","
 S FDA(801.13,IENS,.01)=$$NOW^XLFDT
 S FDA(801.13,IENS,1)=DUZ
 D UPDATE^DIE("S","FDA","FDAIEN","MSG")
 K DA,DDSFILE
 S DA=FDAIEN(1),DA(1)=IEN
 S DDSFILE=801.1,DDSFILE(1)=801.13
 S DR="[PXRM OCR EDIT HISTORY]"
 D ^DDS
 Q
 ;
 ;=============================================
TCAP(IEN) ;This is the executable caption for the term.
 ;I '$$TEDOK(IEN) Q ""
 I '$$TEDOK(IEN) Q " "
 N TIEN
 S TIEN=$$GET^DDSVAL(801.1,IEN,"REMINDER TERM")
 I TIEN="" Q "TERM: "
 Q "TERM: "_$P(^PXRMD(811.5,TIEN,0),U,1)
 ;
 ;=============================================
TEDOK(IEN) ;The term in a rule can be edited as long as a definition has
 ;not been defined.
 I $$GET^DDSVAL(801.1,IEN,"REMINDER DEFINITION")="" Q 1
 Q 0
 ;
 ;=============================================
TDEL(IEN,OLD,NEW) ;Kill logic for AT cross-reference.
 I $G(NEW)>0 Q
 D DELFIELD(IEN,21)
 Q
 ;
 ;=============================================
TPOST(IEN) ;Term post-action.
 ;If the term is defined, do not allow navigation to the definition.
 N VALUE
 S VALUE=$S($$DEDOK(IEN):0,1:1)
 D UNED^DDSUTL("DEFINITION","PXRM OCR MAIN BLOCK",1,VALUE)
 Q
 ;
