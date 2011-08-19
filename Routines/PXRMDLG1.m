PXRMDLG1 ; SLC/PJH - Reminder Dialog Edit/Inquiry (overflow) ;03/17/2009
 ;;2.0;CLINICAL REMINDERS;**12**;Feb 04, 2005;Build 73
 ;
 ;Get selectable codes for a taxonomy
 ;-----------------------------------
CODES(FILE,TIEN,NLINE,HIST) ;
 N BDATE,CODES,CODE,DATES,DESC,DTEXT,EDATE,STR,SUB,TAB,TEXT
 ;Display text
 D CODES^PXRMDLLB(FILE,TIEN,.CODES)
 I '$D(CODES) Q
 S TEXT=$J("",15)_"Selectable codes:",TAB=18
 S STR=$$LJ^XLFSTR($G(TEXT),60)
 S STR=STR_"Activation Periods"
 S NLINE=NLINE+1
 S ^TMP(NODE,$J,NLINE,0)=STR
 S SUB=""
 F  S SUB=$O(CODES(SUB)) Q:SUB=""  D
 .S CODE=$P(CODES(SUB),U,2),DESC=$P(CODES(SUB),U,3)
 .S BDATE=$$FMTE^XLFDT($P($G(CODE),":",2))
 .I $P($G(CODE),":",3)'="" S EDATE=$$FMTE^XLFDT($P($G(CODE),":",3))
 .S DATE=BDATE I $G(EDATE)'="" S DATE=DATE_"-"_EDATE
 .S STR=$$LJ^XLFSTR($P($G(CODE),":"),8)
 .S STR=STR_$$LJ^XLFSTR(DESC,31)
 .S DTEXT=STR_DATE
 .S NLINE=NLINE+1
 .S ^TMP(NODE,$J,NLINE,0)=$J("",15)_DTEXT
 Q
 ;Either dialog text or P/N text
 ;------------------------------
TSUB(IEN,VIEW) ;
 ;Dialog View uses Dialog text
 I VIEW=1 Q 25
 I VIEW=2,$D(^PXRMD(801.41,IEN,25)) Q 25
 ;P/N View uses P/N TEXT if defined
 I $D(^PXRMD(801.41,IEN,35)) Q 35
 ;Otherwise Dialog Text
 Q 25
 ;
 ;additional prompts in the dialog file
 ;-------------------------------------
PROMPT(IEN,TAB,TEXT,DGRP) ;
 N DATA,DDIS,DGSEQ,DSUB,DTITLE,DTXT,DTYP,SEQ,SUB
 S SEQ=0
 F  S SEQ=$O(^PXRMD(801.41,IEN,10,"B",SEQ)) Q:'SEQ  D
 .S SUB=$O(^PXRMD(801.41,IEN,10,"B",SEQ,"")) Q:'SUB
 .S DSUB=$P($G(^PXRMD(801.41,IEN,10,SUB,0)),U,2) Q:'DSUB 
 .S DATA=$G(^PXRMD(801.41,DSUB,0)) Q:DATA=""
 .S DNAME=$P(DATA,U),DDIS=$P(DATA,U,3),DTYP=$P(DATA,U,4)
 .I VIEW,('DGRP),(DTYP'="P") Q
 .I ('VIEW),('DGRP),("FP"'[DTYP) Q
 .S:VIEW DDIS=""
 .I DTYP="F" S DNAME=DNAME_" (forced value)"
 .I DGRP D
 ..S DGSEQ=$P($G(^PXRMD(801.41,IEN,10,SUB,0)),U)
 ..S DNAME=DGSEQ_$J("",3-$L(DGSEQ))_DNAME
 .I TAB=0,DTYP="P" D
 ..;Override prompt caption
 ..S DTITLE=$P($G(^PXRMD(801.41,IEN,10,SUB,0)),U,6)
 ..I DTITLE="" S DTITLE=$P($G(^PXRMD(801.41,DSUB,2)),U,4)
 ..S DNAME=$J("",3)_DTITLE
 .I TAB=0,DTYP="F" S DNAME=$J("",3)_DNAME
 .S DNAME=$J("",15)_$G(TEXT)_DNAME
 .;S:DDIS]"" DNAME=DNAME_$J("",72-$L(DNAME))_DDIS
 .S:+DDIS>0 DNAME=DNAME_$J("",72-$L(DNAME))_" (Disabled)"
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMDLG",$J,VALMCNT,0)=DNAME
 .S TEXT=$J("",TAB)
 Q
 ;
FIND(FIEN,SEQ,DIEN,NLINE,NODE) ;
 N FNUM,TIEN,HIST,SUB,CODE,CODES,BDATE,EDATE,DATE,DESC,DTEXT
 S HIST=0
 S TIEN=$P(FIEN,";")
 I FIEN["ICPT" S FNUM=81
 I FIEN["ICD9" S FNUM=80
 I FNUM=80 S CODE=$P($G(^ICD9(TIEN,0)),U) D PERIOD^ICDAPIU(CODE,.CODES)
 I FNUM=81 S CODE=$P($$CPT^ICPTCOD(TIEN),U,2) D PERIOD^ICPTAPIU(CODE,.CODES)
 S TEXT=$J("",15)_"Selectable codes:",TAB=18
 S STR=$$LJ^XLFSTR($G(TEXT),60)
 S STR=STR_"Activation Periods"
 S NLINE=NLINE+1
 S ^TMP(NODE,$J,NLINE,0)=STR
 S BDATE=""
 F  S BDATE=$O(CODES(BDATE)) Q:BDATE=""  D
 .I $G(BDATE)=0 Q
 .S EDATE=$P(CODES(BDATE),U),DESC=$P(CODES(BDATE),U,2)
 .S BDATE=$$FMTE^XLFDT(BDATE)
 .I $G(EDATE)'="" S EDATE=$$FMTE^XLFDT(EDATE)
 .S DATE=BDATE I $G(EDATE)'="" S DATE=DATE_"-"_EDATE
 .S STR=$$LJ^XLFSTR($G(CODE),8)
 .S STR=STR_$$LJ^XLFSTR(DESC,31)
 .S DTEXT=STR_DATE
 .S NLINE=NLINE+1
 .S ^TMP(NODE,$J,NLINE,0)=$J("",15)_DTEXT
 S NLINE=NLINE+1
 S ^TMP(NODE,$J,NLINE,0)=$J("",79)
 Q
 ;
TAX(FIEN,SEQ,DIEN,NLINE,NODE) ;
 N ARRAY,CNT,FILE,HIST,TIEN,TSEQ
 N CNT,DTXT,FNODE,RSUB,TDX,TNAME,TPAR,TPR,TYP
 N TCUR,TDTXT,TDHTXT,THIS,TPTXT,TPHTXT
 S TIEN=$P(FIEN,";") Q:TIEN=""
 S HIST=0,FILE=""
 ;Get associated codes
 ;
 ;Get taxonomy name
 S TNAME=$P($G(^PXD(811.2,TIEN,0)),U,1)
 ;
 ;Check what type of taxonomy codes exist
 S TDX=$$TOK^PXRMDLLA(TIEN,"SDX")
 S TPR=$$TOK^PXRMDLLA(TIEN,"SPR")
 ;
 ;Diagnoses
 I TDX D
 .;Diagnosis texts
 .S TPAR=$G(^PXD(811.2,TIEN,"SDZ"))
 .;Get parameter file node for this finding type
 .S FNODE=$O(^PXRMD(801.45,"B","POV","")) Q:FNODE=""
 .;check if finding parameters are disabled
 .S TCUR=$P($G(^PXRMD(801.45,FNODE,1,1,0)),U,2)
 .S THIS=$P($G(^PXRMD(801.45,FNODE,1,2,0)),U,2)
 .;get category text (diagnoses)
 .S FILE=80
 ;Procedures
 I TPR D
 .;Procedure texts
 .S TPAR=$G(^PXD(811.2,TIEN,"SPZ"))
 .;Get parameter file node for this finding type
 .S FNODE=$O(^PXRMD(801.45,"B","CPT","")) Q:FNODE=""
 .;check if finding parameters are disabled
 .S TCUR=$P($G(^PXRMD(801.45,FNODE,1,1,0)),U,2)
 .S THIS=$P($G(^PXRMD(801.45,FNODE,1,2,0)),U,2)
 .;get category text (procedures)
 .S FILE=81
 I FILE]"" D CODES(FILE,TIEN,.NLINE,HIST)
 S NLINE=NLINE+1
 S ^TMP(NODE,$J,NLINE,0)=$J("",79)
 Q
 ;
