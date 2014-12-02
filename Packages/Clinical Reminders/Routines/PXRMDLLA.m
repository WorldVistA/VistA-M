PXRMDLLA ;SLC/PJH - REMINDER DIALOG LOADER ;08/01/2013
 ;;2.0;CLINICAL REMINDERS;**6,12,18,26**;Feb 04, 2005;Build 404
 ;
FREC(DFIEN,DFTYP) ;Build type 3 record
 N CSARRAY,CSCNT
 ;Dialog type/text and resolution  
 S DNAM=$$NAME(DFIEN,DFTYP)
 ;Translate vitals ien to PCE code - This will need a DBIA
 S DCOD=""
 I DPCE="VIT" D
 .S DFIEN=$$GET1^DIQ(120.51,DFIEN,7,"E")
 .;Vitals Caption
 .S DVIT=$P($G(^PXRMD(801.41,DITEM,2)),U,4)
 I DFTYP]"" D
 .S OCNT=OCNT+1
 .S ORY(OCNT)=3_U_DITEM_U_U_DPCE_U_DEXC_U_DFIEN_U_$G(DCOD)_U_DNAM_U_U_DVIT
 .;Get order type for orderable items
 .;DBIA #3110
 .S:DPCE="Q" $P(ORY(OCNT),U,11)=$P($G(^ORD(101.41,DFIEN,0)),U,4)
 .;If mental health check if a GAF score and if MH test is required
 .I DPCE="MH",DFIEN D
 ..;DBIA #5044
 ..I $P($G(^YTT(601.71,DFIEN,0)),U)="GAF" S $P(ORY(OCNT),U,12)=1
 ..;Check to see if the MH test is required
 ..S $P(ORY(OCNT),U,13)=+$P($G(^PXRMD(801.41,DITEM,0)),U,18)
 ..I $P(ORY(OCNT),U,13)=2,$$PATCH^XPDUTL("OR*3.0*243")=0 S $P(ORY(OCNT),U,13)=1
 Q
 ;
GUI(IEN) ;Work out prompt type for PCE
 Q:IEN="" ""
 N SUB S SUB=$P($G(^PXRMD(801.41,IEN,46)),U)
 Q:'SUB ""
 Q $P($G(^PXRMD(801.42,SUB,0)),U)
 ;
LOAD(DITEM,DCUR,DTTYP) ;Load dialog questions into array
 N DARRAY,DCOD,DEXC,DFIND,DFIEN,DFTYP,DNAM,DPCE,DRES,DSEQ,DSUB,DTYP,OCNT
 N DVIT,NODE,CNT,IDENT,TAXBUILT,TAXNODE,TDX,TPR,TSEL
 I +$G(DITEM)'>0 Q
 ;DBIA #3110    OR(101.41
 ;
 ;Build list of PCE codes
 S DARRAY("AUTTEDT(")="PED"
 S DARRAY("AUTTEXAM(")="XAM"
 S DARRAY("AUTTHF(")="HF"
 S DARRAY("AUTTIMM(")="IMM"
 S DARRAY("AUTTSK(")="SK"
 ;
 S DARRAY("GMRD(120.51,")="VIT"
 S DARRAY("ORD(101.41,")="Q"
 S DARRAY("YTT(601.71,")="MH"
 ;
 S DARRAY("ICD9(")="POV"
 S DARRAY("ICPT(")="CPT"
 S DARRAY("WV(790.404,")="WH"
 S DARRAY("WV(790.1,")="WHR"
 ;
 S DARRAY("PXD(811.2,")="T"
 ;
 ;Get the dialog element
 S OCNT=0
 N TERMNODE,TERMSTAT,TERMOUT
 S DTYP=$P($G(^PXRMD(801.41,DITEM,0)),U,4)
 ;Finding detail
 S DRES=$P($G(^PXRMD(801.41,DITEM,1)),U,3)
 S DFIND=$P($G(^PXRMD(801.41,DITEM,1)),U,5)
 ;check for WH finding
 I $P($G(^PXRMD(801.41,DITEM,0)),U,16)["WHR" S DFIND=$G(WHFIND)
 ;
 S DFIEN=$P(DFIND,";"),DFTYP=$P(DFIND,";",2)
 S DPCE="",DVIT="" I DFTYP'="" S DPCE=$G(DARRAY(DFTYP))
 ;Exclude from P/N
 S DEXC=$P($G(^PXRMD(801.41,DITEM,2)),U,3)
 ;
 ;Non taxonomy codes (3 - finding record)
 I DPCE'="T" D FREC(DFIEN,DFTYP)
 ;
 ;Taxonomy codes need expanding (3 - finding record)
 I DPCE="T" D
 .S TAXBUILT=0
 .I $G(DTTYP)="" D
 ..S TAXNODE=$G(^PXRMD(801.41,DITEM,"TAX"))
 ..S TSEL=$P(TAXNODE,U) I TSEL="N" Q
 ..S TDX=$$TOK^PXRMDTAX(DFIEN,"POV")
 ..S TPR=$$TOK^PXRMDTAX(DFIEN,"CPT")
 ..I TSEL="D" S DTTYP="POV",TAXBUILT=1 Q
 ..I TSEL="P" S DTTYP="CPT",TAXBUILT=1 Q
 ..I TDX,TPR Q
 ..I TDX S DTTYP="POV",TAXBUILT=1 Q
 ..I TPR S DTTYP="CPT",TAXBUILT=1
 .I $G(DTTYP)'="" D EXP^PXRMDLLB(DITEM,DFIEN,DCUR,DTTYP,5) I TAXBUILT=0 Q
 .D EXPTAX^PXRMDLLB(DITEM,DFIEN,DCUR)
 ;
 ;Prompt details (4 - prompt records)
 N ARRAY,DTITLE,DREQ,DSEQ,DSSEQ,DSUB,DTYP
 ;If not a taxonomy get prompts from dialog file
 I DPCE'="T" D PROTH(DITEM,"","")
 ;Check for MST findings
 I (DPCE'="T"),(DFTYP]"") D MST^PXRMDLLB(DFTYP,DFIEN)
 ;If taxonomy use finding parameters (CPT/POV)
 I DPCE="T" D
 .I $G(DTTYP)="",$G(^PXRMD(801.41,DITEM,"TAX"))'="N" Q
 .;
 .I $D(^PXRMD(801.41,DITEM,10,"B"))>0 D  Q
 ..I $G(DTTYP)'="",$G(DCUR)'="" D PROTH(DITEM,DTTYP,DCUR) Q
 ..D PROTH(DITEM,"","")
 ;Return array of type 4 records
 S DSEQ=""
 F  S DSEQ=$O(ARRAY(DSEQ)) Q:'DSEQ  D
 .S OCNT=OCNT+1
 .S ORY(OCNT)=4_U_DITEM_U_DSEQ_U_ARRAY(DSEQ)
 .S DSSEQ=""
 .F  S DSSEQ=$O(ARRAY(DSEQ,DSSEQ)) Q:'DSSEQ  D
 ..S OCNT=OCNT+1
 ..S ORY(OCNT)=4_U_DITEM_U_DSEQ_"."_DSSEQ_U_ARRAY(DSEQ,DSSEQ)
 ;
 ;Get progress note text if defined
 ;I DPCE'="T" D:'DEXC PTXT(DITEM)
 ;Build Alternate progress note text for taxonomies with more then one pick list.
 I DTTYP="" D:'DEXC PTXT(DITEM)
 ;Build Alternate progress note text for taxonomies with one pick list.
 I DPCE="T",DTTYP'="" D:'DEXC PTXT(DITEM)
 ;Additional findings
 N FASUB
 S FASUB=0
 F  S FASUB=$O(^PXRMD(801.41,DITEM,3,FASUB)) Q:'FASUB  D
 .S DFIND=$P($G(^PXRMD(801.41,DITEM,3,FASUB,0)),U)
 .S DFIEN=$P(DFIND,";"),DFTYP=$P(DFIND,";",2) Q:DFTYP=""  Q:DFIEN=""
 .S DVIT="",DPCE=$G(DARRAY(DFTYP))
 .I DPCE'="",DPCE'="T" D FREC(DFIEN,DFTYP)
 .I DPCE'="",DPCE="T" D
 ..D EXP^PXRMDLLB(DITEM,DFIEN,DCUR,"CPT",3)
 ..D EXP^PXRMDLLB(DITEM,DFIEN,DCUR,"POV",3)
 ;D EXPTAX^PXRMDLLB(DITEM,DFIEN,DCUR)
 Q
 ;
 ;
 ;Returns item name
NAME(DFIEN,DFTYP) ;
 Q:DFTYP="" ""
 Q:DFIEN="" ""
 N NAME,FGLOB,POSN
 ;DBIA #4108
 I DFTYP="WV(790.404," S NAME=$P($G(^WV(790.404,DFIEN,0)),U) Q:NAME]"" NAME
 I DFTYP="WV(790.1," S NAME=$G(WHNAME) K WHNAME Q:NAME]"" NAME
 S POSN=2
 S:DFTYP["AUTT" POSN=1 S:DFTYP["AUTTEDT" POSN=4 S:DFTYP["ICD" POSN=3
 S FGLOB=U_DFTYP_DFIEN_",0)",NAME=$P($G(@FGLOB),U,POSN)
 I (POSN>1),NAME="" S NAME=$P($G(@FGLOB),U)
 I NAME="" S NAME=DFIEN
 Q NAME
 ;
PROTH(IEN,DTTYP,DCUR) ; Additional prompts defined in 801.41
 N DDATA,DDEF,DIEN,DEXC,DGUI,DNAME,DOVR,DREQ,DSEQ,DSNL,DSUB,DFTEXT
 N DTXT,DTYP,NODE,PRINT,TAX
 S DSEQ=0
 F  S DSEQ=$O(^PXRMD(801.41,IEN,10,"B",DSEQ)) Q:'DSEQ  D
 .;Get prompts in sequence
 .S DSUB=$O(^PXRMD(801.41,IEN,10,"B",DSEQ,"")) Q:'DSUB
 .S NODE=$G(^PXRMD(801.41,IEN,10,DSUB,0))
 .;Prompt ien
 .S DIEN=$P($G(^PXRMD(801.41,IEN,10,DSUB,0)),U,2) Q:'DIEN
 .;Ignore disabled components, and those that are not prompts
 .I $$ISDISAB^PXRMDLL(DIEN)=1 Q
 .Q:"PF"'[$P($G(^PXRMD(801.41,DIEN,0)),U,4)
 .;check to make sure prompt is apporiate for the taxonomy encounter type
 .I $G(DTTYP)'="",$G(DCUR)'="",$$TAXPRMPT(DIEN,DTTYP,DCUR)=0 Q
 .;Set defaults to null
 .S DDEF="",DEXC="",DREQ="",DSNL=""
 .;Prompt name and GUI process (quit if null)
 .S DNAME=$P($G(^PXRMD(801.41,DIEN,0)),U),DGUI=$$GUI(DIEN)
 .I $G(DGUI)="WH_NOT_PURP" D
 ..S PRINT=$$GET^XPAR($G(DUZ)_";VA(200,^SRV.`"_+$G(SRV)_"^DIV^SYS","PXRM WH PRINT NOW",1,"I")
 .;Type Prompt or Forced
 .S DTYP=$P($G(^PXRMD(801.41,DIEN,0)),U,4)
 .I "PF"[DTYP D
 ..;Required/Prompt caption
 ..S DDATA=$G(^PXRMD(801.41,DIEN,2)),DTXT=$P(DDATA,U,4)
 ..;Default value or forced value
 ..S:DTYP="P" DDEF=$P(DDATA,U) S:DTYP="F" DDEF=$P(DDATA,U,2)
 ..;Override caption/start new line/exclude PN from dialog file
 ..S DDATA=$G(^PXRMD(801.41,IEN,10,DSUB,0)),DREQ=$P(DDATA,U,9)
 ..S DOVR=$P(DDATA,U,6),DSNL=$P(DDATA,U,7),DEXC=$P(DDATA,U,8)
 ..S DNAME=DTXT I DOVR]"" S DNAME=DOVR
 ..;Convert date to fileman format
 ..I DGUI="VST_DATE",DDEF["T" S DDEF=$$DT^XLFDT()
 .S ARRAY(DSEQ)=DGUI_U_DEXC_U_DDEF_U_DTYP_U_DNAME_U_DSNL_U_DREQ_U_$G(DFTEXT)_U_$G(PRINT)
 .;the following section add a comment prompt to the WH review of result
 .;section of the reminder dialog
 .I DGUI="WH_PAP_RESULT",DFTYP="WV(790.1,",DTYP="P" D
 ..N WHCNT,WHFLAG,WHNUM,WHLOOP
 ..S WHNUM=DSEQ+1,WHLOOP=0
 ..F WHLOOP=0 D
 ...S (WHCNT,WHFLAG)=0
 ...F  S WHCNT=$O(^PXRMD(801.41,IEN,10,"B",WHCNT)) Q:'WHCNT!(WHFLAG=1)  D
 ....I WHCNT=WHNUM S WHFLAG=1,WHNUM=WHNUM+1
 ...I WHFLAG=0 S WHLOOP=1
 ..S ARRAY(WHNUM)="COM"_U_U_U_"P"_U_"Comment:"_U_U_U
 .;Additional checkboxes
 .I DGUI="COM",DIEN>1 D
 ..N DSSEQ,DSUB,DTEXT
 ..S DSSEQ=0
 ..F  S DSSEQ=$O(^PXRMD(801.41,DIEN,45,"B",DSSEQ)) Q:'DSSEQ  D
 ...S DSUB=$O(^PXRMD(801.41,DIEN,45,"B",DSSEQ,"")) Q:'DSUB
 ...S DTEXT=$P($G(^PXRMD(801.41,DIEN,45,DSUB,0)),U,2) Q:DTEXT=""
 ...S ARRAY(DSEQ,DSSEQ)=U_DEXC_U_DDEF_U_DTYP_U_DTEXT_U_DSNL_U_DREQ
 Q
 ;
PRTAX(FNODE,RSUB) ;Get all additional fields for this resolution type
 N ACNT,ASUB
 N DDATA,DDEF,DEXC,DGUI,DNAME,DREQ,DSEQ,DSUB,DTYP,PRINT
 S ASUB=0,DSEQ=0
 F  S ASUB=$O(^PXRMD(801.45,FNODE,1,RSUB,5,ASUB)) Q:'ASUB  D
 .S DDATA=$G(^PXRMD(801.45,FNODE,1,RSUB,5,ASUB,0)) Q:DDATA=""
 .;Ignore if disabled
 .I $P(DDATA,U,3)=1 Q
 .S DSUB=$P(DDATA,U) Q:DDATA=""
 .S DSEQ=DSEQ+1
 .;Set defaults to null
 .S DDEF="",DEXC="",DREQ="",DSNL=""
 .;Prompt name and GUI process (quit if null)
 .S DNAME=$P($G(^PXRMD(801.41,DSUB,0)),U),DGUI=$$GUI(DSUB)
 .I $G(DGUI)="WH_NOT_PURP" D
 ..S PRINT=$$GET^XPAR($G(DUZ)_";VA(200,^SRV.`"_+$G(SRV)_"^DIV^SYS","PXRM WH PRINT NOW",1,"I")
 .;Type Prompt or Forced
 .S DTYP=$P($G(^PXRMD(801.41,DSUB,0)),U,4)
 .I DTYP="P" D
 ..S DREQ=$P(DDATA,U,2),DTXT=$P($G(^PXRMD(801.41,DSUB,2)),U,4)
 ..;Override caption/start new line/exclude from PN from finding type 
 ..S DOVR=$P(DDATA,U,5),DSNL=$P(DDATA,U,6),DEXC=$P(DDATA,U,7)
 ..S DNAME=DTXT I DOVR]"" S DNAME=DOVR
 ..;Required/Prompt caption
 ..S DDATA=$G(^PXRMD(801.41,DSUB,2))
 .S ARRAY(DSEQ)=DGUI_U_DEXC_U_DDEF_U_DTYP_U_DNAME_U_DSNL_U_DREQ_U_U_$G(PRINT)
 Q
 ;
PTXT(ITEM) ;Get progress note (WP) text for type 6 records
 N ARRAY,LAST,NULL,SUB,TEXT,TXTCNT
 S SUB=0
 F  S SUB=$O(^PXRMD(801.41,ITEM,35,SUB)) Q:'SUB  D
 .S ARRAY(SUB)=$G(^PXRMD(801.41,ITEM,35,SUB,0))
 S SUB=0,LAST=0 F  S SUB=$O(ARRAY(SUB)) Q:'SUB  D
 .S TEXT=$G(ARRAY(SUB))
 .S NULL=0 I (TEXT="")!($E(TEXT)=" ") S NULL=1
 .I LAST,'NULL S TEXT="<br>"_TEXT
 .S TEXT=$$STRREP^PXRMUTIL(TEXT,"\\","<br>")
 .S LAST=0 I NULL S TEXT="<br>"_TEXT,LAST=1
 .S OCNT=OCNT+1,ORY(OCNT)=6_U_ITEM_U_U_TEXT
 Q
 ;
 ;function to determine if the prompt is valid for the taxonomy encounter type.
TAXPRMPT(DIEN,DTTYP,DCUR) ;
 N FIND,IEN
 S IEN=$P($G(^PXRMD(801.41,DIEN,1)),U,4) I +IEN=0 Q 1
 S FIND=$P($G(^PXRMD(801.45,IEN,0)),U) I FIND="" Q 1
 I FIND=DTTYP Q 1
 Q 0
 ;
