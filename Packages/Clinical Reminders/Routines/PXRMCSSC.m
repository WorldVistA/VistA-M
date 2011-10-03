PXRMCSSC ; SLC/PKR - Routines for taxonomy code set update. ;04/10/2003
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;============================================================
SELCODE(FILENUM,TAXIEN,LC,TAXMSG) ;Create the message for selectable
 ;codes. Check for codes that are currently inactive or will be
 ;inactive within the next 180 days.
 N CODE,CPTCLST,CPTFLST,DT6M,ICD9CLST,ICD9FLST,IEN,ILC,MSGARR,NODE,STATUS
 ;Go through the selectable codes making an ordered list.
 I FILENUM'=80,FILENUM'=81 Q
 S DT6M=$$DT6M^PXRMCSU(DT)
 S ILC=0
 I FILENUM=80 D
 . S IEN=0
 . F  S IEN=$O(^PXD(811.2,TAXIEN,"SDX","B",IEN)) Q:IEN=""  D
 .. S CODE=$$CODEC^ICDCODE(IEN)
 .. S STATUS=+$$STATCHK^ICDAPIU(CODE,DT)
 .. I 'STATUS S ICD9CLST(CODE_" ")=CODE
 .. I STATUS D
 ... S STATUS=+$$STATCHK^ICDAPIU(CODE,DT6M)
 ... I 'STATUS S ICD9FLST(CODE_" ")=CODE
 I FILENUM=81 D
 . S IEN=0
 . F  S IEN=$O(^PXD(811.2,TAXIEN,"SPR","B",IEN)) Q:IEN=""  D
 .. S CODE=$$CODEC^ICPTCOD(IEN)
 .. S STATUS=+$$STATCHK^ICPTAPIU(CODE,DT)
 .. I 'STATUS S CPTCLST(CODE_" ")=CODE
 I $D(ICD9CLST) D
 . S IEN=""
 . F  S IEN=$O(ICD9CLST(IEN)) Q:IEN=""  D
 .. S CODE=ICD9CLST(IEN),ILC=ILC+1
 .. S MSGARR(ILC)="Selectable ICD9 code "_CODE_" is inactive."
 I $D(ICD9FLST) D
 . S IEN=""
 . F  S IEN=$O(ICD9FLST(IEN)) Q:IEN=""  D
 .. S CODE=ICD9FLST(IEN),ILC=ILC+1
 .. S MSGARR(ILC)="Selectable ICD9 code "_CODE_" will be inactive within 180 days."
 I $D(CPTCLST) D
 . S IEN=""
 . F  S IEN=$O(CPTCLST(IEN)) Q:IEN=""  D
 .. S CODE=CPTCLST(IEN),ILC=ILC+1
 .. S MSGARR(ILC)="Selectable CPT code "_CODE_" is inactive."
 I $D(CPTFLST) D
 . S IEN=""
 . F  S IEN=$O(CPTFLST(IEN)) Q:IEN=""  D
 .. S CODE=CPTFLST(IEN),ILC=ILC+1
 .. S MSGARR(ILC)="Selectable CPT code "_CODE_" will be inactive with 180 days."
 I ILC>0 D
 . S ILC=ILC+1,MSGARR(ILC)=" ",TAXMSG=1
 . D ADDTMSG^PXRMCSTX(.LC,.MSGARR)
 Q
 ;
