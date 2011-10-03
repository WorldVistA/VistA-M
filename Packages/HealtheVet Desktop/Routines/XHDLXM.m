XHDLXM ; SLC/JER - XML Library calls for CM ; 25 Jul 2003  9:42 AM
 ;;1.0;HEALTHEVET DESKTOP;;Jul 15, 2003
XMLHDR(XHDY,ROOTEL,XHDI) ; Create XML Header for Mresult pass root element
 ; as ROOTEL
 S XHDI=+$G(XHDI)+1
 S @XHDY@(XHDI)="<?xml version=""1.0"" encoding=""UTF-8"" ?>"
 S XHDI=XHDI+1
 S @XHDY@(XHDI)="<"_ROOTEL_">"
 Q
 ;
XMLFOOT(XHDY,ROOTEL,XHDI) ; Appends XML closing tags
 S XHDI=+$G(XHDI)+1,@XHDY@(XHDI)="</"_ROOTEL_">"
 Q
 ;
ESCAPE(DATA) ; Escapes XML special characters in data
 N SPEC
 S SPEC("<")="&lt;",SPEC(">")="&gt;",SPEC("""")="&quot;"
 S SPEC("'")="&apos;",SPEC("&")="&amp;"
 Q $$REPLACE^XLFSTR(DATA,.SPEC)
 ;
FILENTRY(XHDY,FILE,IENS,FLDS,INCID,XHDI)        ; Produce XML representation of entry
 N XHDF,XHDKI,PCATAG S XHDF=0,XHDI=+$G(XHDI)
 I +$G(INCID) D
 . S XHDI=XHDI+1,@XHDY@("XMLDOC",XHDI)="<id>"_+IENS_"</id>"
 D GETS^DIQ(FILE,IENS,$$FLDS(.FLDS),"IE",XHDY)
 F  S XHDF=$O(@XHDY@(FILE,IENS,XHDF)) Q:XHDF'>0  D
 . N TAG,VAL
 . S TAG=$TR($$FLDNAME(XHDF,FILE)," /","")
 . S VAL=$G(@XHDY@(FILE,IENS,XHDF,$S($L(FLDS(XHDF),U)=2:$P(FLDS(XHDF),U,2),1:"E")))
 . S XHDI=XHDI+1,@XHDY@("XMLDOC",XHDI)="<"_TAG_">"_VAL_"</"_TAG_">"
 K @XHDY@(FILE)
 Q
FLDS(FLDS)      ; Iterate through field list, build DR-string
 N XHDI,XHDY S XHDI=0,XHDY=""
 F  S XHDI=$O(FLDS(XHDI)) Q:+XHDI'>0  D
 . S XHDY=XHDY_$S(XHDY="":"",1:";")_XHDI
 Q XHDY
FLDNAME(XHDFN,FILENUM)  ; Resolve field names
 Q $$MIXED($P($G(^DD(FILENUM,XHDFN,0)),U))
MIXED(X) ; Return Mixed Case X
 N XHDI,WORD,TMP
 S TMP="" F XHDI=1:1:$L(X," ") S WORD=$$LOW^XLFSTR($P(X," ",XHDI)),$E(WORD)=$S(XHDI=1:$E(WORD),1:$$UP^XLFSTR($E(WORD))),TMP=$S(TMP="":WORD,1:TMP_WORD)
 Q TMP
