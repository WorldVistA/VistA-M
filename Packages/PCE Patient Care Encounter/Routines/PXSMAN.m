PXSMAN ;SLC/PKR - Utilities for working with ScreenMan ;10/24/2016
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 244
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
 I $$WPNCHAR^PXSMAN(WPTEXT)=0 Q TEXT
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
VUPAGE(FILENUM,UPAGE,DA,DDSERROR) ;Make sure the Upper Age is not less than
 ;the Lower Age.
 N LWRAGE
 S LWRAGE=$$GET^DDSVAL(FILENUM,.DA,"LOWER AGE")
 I UPAGE'<LWRAGE Q
 D HLP^DDSUTL("The Upper Age cannot be less than the Lower Age.")
 S DDSERROR=1
 Q
 ;
