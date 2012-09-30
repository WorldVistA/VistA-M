PXRMSMAN ;SLC/PKR - Utilities for working with ScreenMan ;12/16/2011
 ;;2.0;CLINICAL REMINDERS;**22**;Feb 04, 2005;Build 160
 ;=============================================
FSOC(FILENUM,FIELD) ;Format a set of codes for display in ScreenMan.
 N CODES,MSG,LEN,NL,TEXTOUT
 S CODES=$$GET1^DID(FILENUM,FIELD,"","POINTER","MSG")
 S CODES=$TR(CODES,":","=")
 S CODES=$$STRREP^PXRMUTIL(CODES,";",", ")
 D FORMATS^PXRMTEXT(1,IOM,CODES,.NL,.TEXTOUT)
 S LEN=$L(TEXTOUT(NL))
 S:$E(TEXTOUT(NL),LEN)="," TEXTOUT(NL)=$E(TEXTOUT(NL),1,(LEN-1))
 D HLP^DDSUTL(.TEXTOUT)
 Q
 ;
 ;=============================================
WPECAP(FNUM,DA,FIELD,MAXLEN) ;Executable caption for word-processing fields.
 ;FNUM is the file number and FIELD is the field name. MAXLEN is
 ;74-$L(FIELD). Pass it as parameter so it does not need to be
 ;constantly recomputed.
 N L1,TEXT,WPTEXT
 S WPTEXT=$$GET^DDSVAL(FNUM,.DA,FIELD)
 S TEXT=FIELD_": "
 I $$WPNCHAR^PXRMSMAN(WPTEXT)=0 Q TEXT
 S L1=@WPTEXT@(1,0)
 S LEN=$L(L1)
 Q TEXT_$S(LEN>MAXLEN:$E(L1,1,MAXLEN)_" ...",1:L1)
 ;
 ;=============================================
WPNCHAR(WP) ;Return 0 if a word-processing field does not contain any text.
 I '$D(@WP@(0)) Q 0
 N LN,NC
 S NC=0
 F LN=1:1:$P(@WP@(0),U,4) Q:NC>0  S NC=NC+$L(@WP@(LN,0))
 Q NC
 ;
 ;=============================================
VSPON(FILENUM,DA,SPONIEN,DDSERROR) ;Make sure the Class of the Sponsor matches
 ;the Class of the entry.
 N CLASS,SCLASS
 S CLASS=$$GET^DDSVAL(FILENUM,DA,100,,"E")
 S SCLASS=$$GET1^DIQ(811.6,SPONIEN,100)
 I CLASS=SCLASS Q
 N TEXT
 S TEXT(1)="The entry's class is "_CLASS_"."
 S TEXT(2)="The selected sponsor's class is "_SCLASS_"."
 S TEXT(3)="They must match."
 D HLP^DDSUTL(.TEXT)
 S DDSERROR=1
 Q
 ;
