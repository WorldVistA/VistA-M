PXRMDLL ;SLC/PJH - REMINDER DIALOG LOADER ;07/29/2010
 ;;2.0;CLINICAL REMINDERS;**10,6,12,17,18**;Feb 04, 2005;Build 152
 ;
OK(DIEN) ;Check if mental health test is for GUI
 I 'DIEN Q 0
 Q $$MH^PXRMDLG5(DIEN)
 ;
TXT ;Format text
 N NULL
 S TEXT=DTXT(SUB),NULL=0
 I ($E(TEXT)=" ")!(TEXT="") S NULL=1
 I LAST,'NULL S TEXT="<br>"_TEXT
 S TEXT=$$STRREP^PXRMUTIL(TEXT,"\\","<br>")
 S LAST=0 I NULL S TEXT="<br>"_TEXT,LAST=1
 Q
 ; 
EXP(TIEN,DITEM,DSUB) ;Expand taxonomy codes
 N ACNT,AHIS,ATYP,ARRAY,CODES,CNT,DPCE,DTAX
 ;Get taxonomy file details
 D TAX(TIEN,.ARRAY)
 ;
 ;Build dialog from the returned array
 ;
 ;Main Taxonomy prompt
 S DTXT=ARRAY
 S OCNT=OCNT+1
 S ORY(OCNT)=1_U_DITEM_U_DSUB_U_"S"_U_DEXC
 ;Default group indents and selection entry
 S $P(ORY(OCNT),U,16)=2,$P(ORY(OCNT),U,18)=2
 S OCNT=OCNT+1
 S ORY(OCNT)=2_U_DITEM_U_DSUB_U_DTXT
 ;
 ;Taxonomy CPT/POV resolution prompts
 S ACNT=""
 F  S ACNT=$O(ARRAY(ACNT)) Q:ACNT=""  D
 .;Prompt text
 .S DTXT=$P(ARRAY(ACNT),U),DPCE=$P(ARRAY(ACNT),U,4)
 .;Historical/Current flag
 .S AHIS=0 I $P(ARRAY(ACNT),U,3)=2 S AHIS=1
 .;CPT/POV
 .S ATYP="POV" I $P(ARRAY(ACNT),U,2)=81 S ATYP="CPT"
 .;Initial display
 .S DHIDE=0,DCHECK=0,DDIS=0
 .;Construct ien for this level
 .S DTAX=DSUB_"."_ACNT
 .S OCNT=OCNT+1
 .S ORY(OCNT)=1_U_DITEM_U_DTAX_U_"T"_U_DEXC_U_U_ATYP_U_AHIS
 .S OCNT=OCNT+1
 .S ORY(OCNT)=2_U_DITEM_U_DTAX_U_DTXT
 Q
 ;
GROUP(DIEN,DSUB) ;Dialog group
 N DATA,DBOX,DCAP,DCHK,DENTRY,DEXC,DGIEN,DGRP,DGSEQ,DGSUB,DHIDE,DIND
 N DINDPN,DMHEX,DRESL,DSHARE,SUB,DCOUNT
 ;Group caption text
 S DATA=$G(^PXRMD(801.41,DIEN,0))
 S DCAP=$P(DATA,U,5),DBOX=$P(DATA,U,6),DIND=$P(DATA,U,7)
 S DSHARE=$P(DATA,U,8),DENTRY=$P(DATA,U,9),DHIDE=$P(DATA,U,10)
 S DINDPN=$P(DATA,U,12) S:DINDPN="" DINDPN=0
 S DBOX=$S(DBOX="Y":1,1:"")
 ;group header is display only if SUPPRESS CHECKBOX
 S DCHK="S" I ('DHIDE)&(DSUPP) S DCHK="D",DHIDE=0
 ;Default group setting to hide
 I DHIDE="" S DHIDE=1
 ;
 S DEXC=$P($G(^PXRMD(801.41,DIEN,2)),U,3)
 ;
 S OCNT=OCNT+1,ORY(OCNT)=1_U_DIEN_U_DSUB_U_DCHK_U_DEXC
 S $P(ORY(OCNT),U,8)=$$AHIS(DIEN)
 S $P(ORY(OCNT),U,15)=DHIDE,$P(ORY(OCNT),U,16)=DIND
 S $P(ORY(OCNT),U,17)=DSHARE,$P(ORY(OCNT),U,18)=DENTRY
 S $P(ORY(OCNT),U,19)=DBOX,$P(ORY(OCNT),U,20)=DCAP
 S $P(ORY(OCNT),U,21)=DINDPN
 ;Create type 2 records if if here is additional group text
 N LAST,TEXT
 S SUB=0,LAST=0 F  S SUB=$O(DTXT(SUB)) Q:'SUB  D
 .D TXT
 .S OCNT=OCNT+1,ORY(OCNT)=2_U_DIEN_U_DSUB_U_TEXT
 ;Get dialog group sub-elements
 N DTYP,DSUPP,DDIS,IDENT S DGSEQ=0
 F  S DGSEQ=$O(^PXRMD(801.41,DIEN,10,"B",DGSEQ)) Q:'DGSEQ  D
 .S DGSUB=$O(^PXRMD(801.41,DIEN,10,"B",DGSEQ,"")) Q:'DGSUB
 .S DATA=$G(^PXRMD(801.41,DIEN,10,DGSUB,0))
 .S DGIEN=$P(DATA,U,2) Q:'DGIEN
 .;Check if element is disabled/invalid
 .I $$ISDISAB(DGIEN)=1 Q
 .;Branching logic call to determine if element should be suppress,
 .;replace or left as is
 .N TERMNODE,TERMSTAT
 .S TERMNODE=$G(^PXRMD(801.41,DGIEN,49))
 .I $G(TERMNODE)'="" D  Q:TERMSTAT=0
 ..S TERMSTAT=1
 ..D REPLACE^PXRMDLLB(DFN,TERMNODE,.DGIEN,.DATA,.TERMSTAT)
 .;Exclude from P/N
 .S DEXC=$P(DATA,U,8)
 .I $P($G(^PXRMD(801.41,DGIEN,0)),U,16)'["WHR" D
 ..K DTXT S SUB=0 F  S SUB=$O(^PXRMD(801.41,DGIEN,25,SUB)) Q:'SUB  D
 ...S DTXT(SUB)=$G(^PXRMD(801.41,DGIEN,25,SUB,0))
 .S DATA=$G(^PXRMD(801.41,DGIEN,0))
 .;If the actual element is exclude from P/N override
 .I $P($G(^PXRMD(801.41,DGIEN,2)),U,3) S DEXC=1
 .S DTYP=$P(DATA,U,4),DSUPP=$P(DATA,U,11) Q:"EG"'[DTYP
 .S DMHEX=$P(DATA,U,14)
 .S DRESL=$$RESGROUP^PXRMDLLB(DGIEN)
 .;S DRESL=$P(DATA,U,15)
 .S DRES=$P($G(^PXRMD(801.41,DGIEN,1)),U,3)
 .;Done Elsewhere (historical)
 .S DHIS=$$AHIS(DGIEN)
 .S DFIND=$P($G(^PXRMD(801.41,DGIEN,1)),U,5)
 .S DFIEN=$P(DFIND,";"),DFTYP=$P(DFIND,";",2)
 .S DPCE="" I DFTYP'="" S DPCE=$G(DARRAY(DFTYP))
 .;If mental Health ignore if not GUI
 .I DPCE="MH" Q:'$$OK(DFIEN)
 .S DGRP=DSUB_"."_DGSUB
 .;Taxonomy codes need expanding
 .I DPCE="T" D EXP(DFIEN,DGIEN,DGRP) Q
 .;Translate vitals ien to PCE code - This will need a DBIA
 .I DPCE="VIT" S DFIEN=$$GET1^DIQ(120.51,DFIEN,7,"E")
 .;Embedded Dialog Group
 .I DTYP="G" D GROUP(DGIEN,DGRP) Q
 .S DDIS="S" I DSUPP=1 S DDIS="D"
 .S DGRP=DSUB_"."_DGSUB,OCNT=OCNT+1
 .S ORY(OCNT)=1_U_DGIEN_U_DGRP_U_DDIS_U_DEXC_U_U_U_DHIS_U_DMHEX_U_DRESL_U_$G(DCOUNT)
 .;
 .N LAST,TEXT
 .S SUB=0,LAST=0 F  S SUB=$O(DTXT(SUB)) Q:'SUB  D
 ..D TXT
 ..S OCNT=OCNT+1,ORY(OCNT)=2_U_DGIEN_U_DGRP_U_TEXT
 Q
 ;
ISDISAB(PXRMIEN) ;
 N PXRMDATA
 S PXRMDATA=$G(^PXRMD(801.41,PXRMIEN,0))
 I +$P(PXRMDATA,U,3)=0 Q 0
 I +$P(PXRMDATA,U,3)=2 Q 1
 N ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTIO
 S ZTDESC="Reminder Dialog disable check"
 S ZTRTN="ISQDISB^PXRMDLL"
 S ZTSAVE("PXRMDATA")=""
 S ZTSAVE("PXRMIEN")=""
 S ZTIO=""
 S ZTDTH=$$NOW^XLFDT
 D ^%ZTLOAD
 Q 1
ISQDISB ;
 N CNT,MSG,MSGCNT,RESULT,STDFILES,STR,TYPE
 S TYPE=$P(PXRMDATA,U,4)
 S CNT=1
 S TYPE=$S(TYPE="E":"Element",TYPE="G":"Group",TYPE="R":"Result Group",1:"Item")
 S STR="Disabled Dialog Item is being used in CPRS."
 S ^TMP("PXRMXMZ",$J,CNT,0)="Reminder Dialog "_TYPE_" "_$P(PXRMDATA,U)_" is inactive."
 D DIALDSAR^PXRMFRPT(.STDFILES) I '$D(STDFILES) G ISQDISBX
 S RESULT=$$DISABCHK^PXRMDLG6(PXRMIEN,.STDFILES,.MSG)
 I '$D(MSG) G ISQDISBX
 S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)="",CNT=CNT+1
 S MSGCNT=0
 F  S MSGCNT=$O(MSG(MSGCNT)) Q:MSGCNT'>0  D
 .S CNT=CNT+1
 .S ^TMP("PXRMXMZ",$J,CNT,0)="    "_$G(MSG(MSGCNT))
 ;
ISQDISBX ;
 D SEND^PXRMMSG("PXRMXMZ",STR,"",DUZ)
 Q
 ;
LOAD(DIEN,DFN) ;Load dialog questions into array
 N DARRAY,DATA,DITEM,DFIND,DFIEN,DFTYP,DPCE,DRES,DSEQ,DSUB,DTXT,DTYP,OCNT
 N DDIS,DEXC,DHIDE,DCHECK,DDIS,DHIS,DMHEX,DRESL,DSUPP,SUB,IDENT,TXTCNT
 ;Check Status of dialog
 S DATA=$G(^PXRMD(801.41,DIEN,0)) Q:DATA=""
 ;If disabled ignore
 I $$ISDISAB(DIEN)=1 Q
 ;Ignore if not a reminder dialog
 I $P(DATA,U,4)'="R" Q
 ;
 ;List of PCE codes
 S DARRAY("AUTTEDT(")="PED"
 S DARRAY("AUTTEXAM(")="XAM"
 S DARRAY("AUTTHF(")="HF"
 S DARRAY("AUTTIMM(")="IMM"
 S DARRAY("AUTTSK(")="SK"
 S DARRAY("GMRD(120.51,")="VIT"
 S DARRAY("ORD(101.41,")="Q"
 S DARRAY("YTT(601.71,")="MH"
 S DARRAY("ICD9(")="POV"
 S DARRAY("ICPT(")="CPT"
 S DARRAY("PXD(811.2,")="T"
 S DARRAY("WV(790.1,")="WHR"
 ;
 ;Get elements for the dialog
 S DSEQ=0,OCNT=0
 F  S DSEQ=$O(^PXRMD(801.41,DIEN,10,"B",DSEQ)) Q:'DSEQ  D
 .S DSUB=$O(^PXRMD(801.41,DIEN,10,"B",DSEQ,"")) Q:'DSUB
 .S DATA=$G(^PXRMD(801.41,DIEN,10,DSUB,0))
 .S DITEM=$P(DATA,U,2) Q:DITEM=""
 .;Ignore disabled elements
 .S DATA=$G(^PXRMD(801.41,DITEM,0)) Q:DATA=""  Q:$$ISDISAB(DITEM)=1
 .;Branching logic call to determine if element should be suppress,
 .;replace or left as is
 .S TERMNODE=$G(^PXRMD(801.41,DITEM,49))
 .N TERMSTAT
 .I $G(TERMNODE)'="" D  Q:TERMSTAT=0
 ..S TERMSTAT=1
 ..D REPLACE^PXRMDLLB(DFN,TERMNODE,.DITEM,.DATA,.TERMSTAT)
 .S DTYP=$P(DATA,U,4),DSUPP=$P(DATA,U,11)
 .S DMHEX=$P(DATA,U,14)
 .S DRESL=$$RESGROUP^PXRMDLLB(DITEM)
 .;S DRESL=$P(DATA,U,15)
 .K DTXT S SUB=0
 .F  S SUB=$O(^PXRMD(801.41,DITEM,25,SUB)) Q:'SUB  D
 ..S DTXT(SUB)=$G(^PXRMD(801.41,DITEM,25,SUB,0))
 .S DRES=$P($G(^PXRMD(801.41,DITEM,1)),U,3)
 .S DFIND=$P($G(^PXRMD(801.41,DITEM,1)),U,5)
 .S DFIEN=$P(DFIND,";"),DFTYP=$P(DFIND,";",2)
 .S DPCE="" I DFTYP'="" S DPCE=$G(DARRAY(DFTYP))
 .;If mental Health ignore if not GUI
 .I DPCE="MH" Q:'$$OK(DFIEN)
 .;Exclude from PN
 .S DEXC=$P($G(^PXRMD(801.41,DITEM,2)),U,3)
 .;Taxonomy codes need expanding
 .I DPCE="T" D EXP(DFIEN,DITEM,DSUB) Q
 .;Translate vitals ien to PCE code - This will need a DBIA
 .I DPCE="VIT" S DFIEN=$P($G(^GMRD(120.51,DFIEN,0)),U,7)
 .;Done Elsewhere (historical)
 .S DHIS=$$AHIS(DITEM)
 .;Dialog Group
 .I DTYP="G" D GROUP(DITEM,DSUB) Q
 .;Dialog type/text and resolution 
 .S OCNT=OCNT+1,DDIS="S"
 .I DSUPP=1 S DDIS="D"
 .S ORY(OCNT)=1_U_DITEM_U_DSUB_U_DDIS_U_DEXC_U_U_U_DHIS_U_DMHEX_U_DRESL
 .N LAST,TEXT
 .S SUB=0,LAST=0 F  S SUB=$O(DTXT(SUB)) Q:'SUB  D
 ..D TXT
 ..S OCNT=OCNT+1,ORY(OCNT)=2_U_DITEM_U_DSUB_U_TEXT
 Q
 ;
TAX(TXIEN,ARRAY) ;Return list of resolutions/codes for taxonomy
 N CNT,DTXT,FNODE,RSUB,TDX,TNAME,TPAR,TPR,TYP
 N TCUR,TDTXT,TDHTXT,THIS,TPTXT,TPHTXT
 ;
 ;Get taxonomy name
 S TNAME=$P($G(^PXD(811.2,TXIEN,0)),U,1)
 ;
 ;Check what type of taxonomy codes exist
 S TDX=$$TOK^PXRMDLLA(TXIEN,"SDX")
 S TPR=$$TOK^PXRMDLLA(TXIEN,"SPR")
 ;
 ;Taxonomy dialog text
 S DTXT=$P($G(^PXD(811.2,TXIEN,0)),U,3)
 ;default to taxonomy description if null
 I DTXT="" S DTXT=$P($G(^PXD(811.2,TXIEN,0)),U,2)
 ;default to taxonomy name if null
 I DTXT="" S DTXT=$P($G(^PXD(811.2,TXIEN,0)),U,1)
 ;
 S CNT=0,ARRAY=DTXT
 ;
 ;Diagnoses
 I TDX D
 .;Diagnosis texts
 .S TPAR=$G(^PXD(811.2,TXIEN,"SDZ"))
 .;Get parameter file node for this finding type
 .S FNODE=$O(^PXRMD(801.45,"B","POV","")) Q:FNODE=""
 .;check if finding parameters are disabled
 .S TCUR=$P($G(^PXRMD(801.45,FNODE,1,1,0)),U,2)
 .S THIS=$P($G(^PXRMD(801.45,FNODE,1,2,0)),U,2)
 .;get category text (diagnoses)
 .I 'TCUR D  ; Current
 ..S TDTXT=$P(TPAR,U,2) S:TDTXT="" TDTXT=TNAME
 ..S CNT=CNT+1,ARRAY(CNT)=TDTXT_U_80_U_1_U_"POV"
 .I 'THIS D  ; Historical
 ..S TDHTXT=$P(TPAR,U,3) S:TDHTXT="" TDHTXT=TNAME_" (HISTORICAL)"
 ..S CNT=CNT+1,ARRAY(CNT)=TDHTXT_U_80_U_2_U_"POV"
 ;Procedures
 I TPR D
 .;Procedure texts
 .S TPAR=$G(^PXD(811.2,TXIEN,"SPZ"))
 .;Get parameter file node for this finding type
 .S FNODE=$O(^PXRMD(801.45,"B","CPT","")) Q:FNODE=""
 .;check if finding parameters are disabled
 .S TCUR=$P($G(^PXRMD(801.45,FNODE,1,1,0)),U,2)
 .S THIS=$P($G(^PXRMD(801.45,FNODE,1,2,0)),U,2)
 .;get category text (procedures)
 .I 'TCUR D  ; Current
 ..S TPTXT=$P(TPAR,U,2) S:TPTXT="" TPTXT=TNAME
 ..S CNT=CNT+1,ARRAY(CNT)=TPTXT_U_81_U_1_U_"CPT"
 .I 'THIS D  ; Historical
 ..S TPHTXT=$P(TPAR,U,3) S:TPHTXT="" TPHTXT=TNAME_" (HISTORICAL)"
 ..S CNT=CNT+1,ARRAY(CNT)=TPHTXT_U_81_U_2_U_"CPT"
 ;
 Q
 ;
AHIS(DITEM) ;
 N RSIEN,RSNAM
 S RSIEN=$P($G(^PXRMD(801.41,DITEM,1)),U,3)
 I RSIEN="" Q 0
 S RSNAM=$P($G(^PXRMD(801.9,RSIEN,0)),U)
 I RSNAM["DONE ELSEWHERE" Q 1
 N GUI,PIEN,PFOUND
 S PIEN=0,PFOUND=0
 F  S PIEN=$O(^PXRMD(801.41,DITEM,10,"D",PIEN)) Q:'PIEN  D  Q:PFOUND
 .;Ignore elements and groups
 .I "EG"[$P($G(^PXRMD(801.41,PIEN,0)),U,4) Q
 .;GUI Process
 .S GUI=$P($G(^PXRMD(801.41,PIEN,46)),U) Q:'GUI
 .;Check if this is PXRM VISIT DATE (or a copy of it)
 .I $P($G(^PXRMD(801.42,GUI,0)),U)="VST_DATE" S PFOUND=1
 Q PFOUND
