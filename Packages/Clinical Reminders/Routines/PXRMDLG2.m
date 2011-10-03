PXRMDLG2 ; SLC/PJH - Reminder Dialog Edit/Inquiry ;06/02/2009
 ;;2.0;CLINICAL REMINDERS;**12**;Feb 04, 2005;Build 73
 ;
 ;Find description for dialog type
LIT(INP) ;
 Q:INP="G" "Dialog group: "
 Q:INP="F" "Forced value: "
 Q:INP="P" "Prompt: "
 Q:INP="E" "Dialog element: "
 Q "???"
 ;
 ;Additional Findings
ADD(DIEN) ;
 N FIND,FSUB,FTYP,FNAME,FNUM
 S FSUB=0
 F  S FSUB=$O(^PXRMD(801.41,DIEN,3,FSUB)) Q:'FSUB  D
 .S FIND=$P($G(^PXRMD(801.41,DIEN,3,FSUB,0)),U) Q:FIND=""
 .S FNAME="" D DESC(FIND) Q:FNAME=""
 .S FNAME="Additional Finding: "_FNAME
 .;Save additional finding name
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMDLG",$J,VALMCNT,0)=$J("",15)_FNAME
 Q
 ;Finding description
DESC(FIEN) ;
 ;Determine finding type
 S FGLOB=$P(FIEN,";",2) Q:FGLOB=""
 S FITEM=$P(FIEN,";") Q:FITEM=""
 ;Diagnosis POV
 I FGLOB["ICD9" D  Q
 .S FTYP="DIAGNOSIS",FGLOB=U_FGLOB_FITEM_",0)"
 .S FNAME=$P($G(@FGLOB),U,3)_" ["_FITEM_"]"
 ;Procedure CPT
 I FGLOB["ICPT" D  Q
 .S FTYP="PROCEDURE",FGLOB=U_FGLOB_FITEM_",0)"
 .S FNAME=$P($G(@FGLOB),U,2)_" ["_FITEM_"]"
 ;Quick order
 I FGLOB["ORD(101.41" D  Q
 .S FTYP="QUICK ORDER",FGLOB=U_FGLOB_FITEM_",0)"
 .S FNAME=$P($G(@FGLOB),U,2)_" ["_FITEM_"]"
 ;Short name for finding type
 S FTYP=$G(DEF1(FGLOB)) Q:FTYP=""
 S FNUM=" ["_FTYP_"("_FITEM_")]"
 ;Long name
 S FTYP=$G(DEF2(FTYP))
 S FGLOB=U_FGLOB_FITEM_",0)"
 S FNAME=$P($G(@FGLOB),U,1)
 I FNAME="" S FNAME=$P($G(@FGLOB),U)
 I FNAME]"" S FNAME=FNAME_FNUM Q
 S FNAME=FITEM
 Q
 ;
 ;Dialog Details (DD)
DETAIL(PIEN) ;
 ;Get prompt data
 N DATA
 S DATA=$G(^PXRMD(801.41,PIEN,0))
 ;Extract name, type and disabled
 S PNAME=$P(DATA,U),PDIS=$P(DATA,U,3),PTYP=$P(DATA,U,4),PTYP=$$LIT(PTYP)
 ;Result (if any)
 S RESULT=$P(DATA,U,15)
 I RESULT S RESNM=$P($G(^PXRMD(801.41,RESULT,0)),U)
 ;Get Resolution/Finding details
 S DATA=$G(^PXRMD(801.41,PIEN,1)),RIEN=$P(DATA,U,3),FIEN=$P(DATA,U,5)
 ;Resolution status name (assume this is a set)
 S RNAME="???"
 I RIEN S RNAME=$P($G(^PXRMD(801.9,RIEN,0)),U) S:RNAME="" RNAME="???"
 ;Set Default display values
 S FNAME="???",FTYP="???",ONAME="???"
 ;For quick orders get the orderable item
 I RNAME="ORDERED" D
 .S FTYP="QUICK ORDER",FNAME="*QUICK ORDER MISSING*"
 .S OIEN=$P($G(^PXRMD(801.41,PIEN,1)),U,7) Q:'OIEN
 .S FGLOB="^ORD(101.43,"_OIEN_",0)"
 .S ONAME=$P($G(@FGLOB),U)_" ["_OIEN_"]"
 ;Description of finding
 D DESC(FIEN)
 ;
 S RNAME="Resolution: "_RNAME
 S FTYP="Finding type: "_FTYP
 S FNAME="Finding item: "_FNAME
 S VALMCNT=VALMCNT+1
 S PTXT=$J(SEQ,3)_$J("",12)_PTYP_PNAME
 S ^TMP("PXRMDLG",$J,VALMCNT,0)=PTXT_$J("",72-$L(PTXT))_$S(+PDIS>0:" (Disabled)",1:"")
 S ^TMP("PXRMDLG",$J,"IDX",SEQ,PIEN)=""
 ;Save resolution
 I ('DGRP),(FTYP'["TAXONOMY"),(FTYP'["MENTAL HEALTH") D
 .I RNAME'["???" D
 ..S VALMCNT=VALMCNT+1
 ..S ^TMP("PXRMDLG",$J,VALMCNT,0)=$J("",15)_RNAME
 .I FTYP["QUICK ORDER" D
 ..S VALMCNT=VALMCNT+1
 ..S ^TMP("PXRMDLG",$J,VALMCNT,0)=$J("",15)_"Orderable item: "_ONAME
 I ('DGRP) D
 .;Save finding type
 .I FTYP'["???" D
 ..S VALMCNT=VALMCNT+1
 ..S ^TMP("PXRMDLG",$J,VALMCNT,0)=$J("",15)_FTYP
 ;Save finding name
 I ('DGRP),(FNAME'["???") D
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMDLG",$J,VALMCNT,0)=$J("",15)_FNAME
 ;Additional Findings
 I (FTYP'["TAXONOMY"),(FTYP'["MENTAL HEALTH") D ADD(PIEN)
 ;Result group/element (mental health)
 I RESULT D
 .;Save result details
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMDLG",$J,VALMCNT,0)=$J("",15)_"Result name: "_RESNM
 ;Get additional prompts/dialog group elements
 D PROMPT^PXRMDLG1(PIEN,20,DHED,DGRP)
 Q
 ;
 ;Group findings and prompts
GROUP(PIEN) ;
 ;Get prompt data
 S DATA=$G(^PXRMD(801.41,PIEN,0))
 ;Extract name, type and disabled
 S PNAME=$P(DATA,U),PDIS=$P(DATA,U,3),PTYP=$P(DATA,U,4),PTYP=$$LIT(PTYP)
 ;Result (if any)
 S RESULT=$P(DATA,U,15)
 I RESULT S RESNM=$P($G(^PXRMD(801.41,RESULT,0)),U)
 ;Get Resolution/Finding details
 S DATA=$G(^PXRMD(801.41,PIEN,1)),RIEN=$P(DATA,U,3),FIEN=$P(DATA,U,5)
 ;Resolution status name (assume this is a set)
 S RNAME="???"
 I RIEN S RNAME=$P($G(^PXRMD(801.9,RIEN,0)),U) S:RNAME="" RNAME="???"
 ;Set Default display values
 S FNAME="???",FTYP="???",ONAME="???"
 ;For quick orders get the orderable item
 I RNAME="ORDERED" D
 .S FTYP="QUICK ORDER",FNAME="*QUICK ORDER MISSING*"
 .S OIEN=$P($G(^PXRMD(801.41,PIEN,1)),U,7) Q:'OIEN
 .S FGLOB="^ORD(101.43,"_OIEN_",0)"
 .S ONAME=$P($G(@FGLOB),U)_" ["_OIEN_"]"
 ;Description of finding
 D DESC(FIEN)
 ;
 S RNAME="Resolution: "_RNAME
 S FTYP="Finding type: "_FTYP
 S FNAME="Finding item: "_FNAME
 ;Save resolution
 I (FTYP'["TAXONOMY"),(FTYP'["MENTAL HEALTH") D
 .I RNAME'["???" D
 ..S VALMCNT=VALMCNT+1
 ..S ^TMP("PXRMDLG",$J,VALMCNT,0)=$J("",15)_RNAME
 .I FTYP["QUICK ORDER" D
 ..S VALMCNT=VALMCNT+1
 ..S ^TMP("PXRMDLG",$J,VALMCNT,0)=$J("",15)_"Orderable item: "_ONAME
 ;Save finding type
 I FTYP'["???" D
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMDLG",$J,VALMCNT,0)=$J("",15)_FTYP
 ;Save finding name
 I (FNAME'["???") D
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMDLG",$J,VALMCNT,0)=$J("",15)_FNAME
 ;Additional Findings
 I (FTYP'["TAXONOMY"),(FTYP'["MENTAL HEALTH") D ADD(PIEN)
 ;Get additional prompts/dialog group elements
 D PROMPT^PXRMDLG1(PIEN,20,"Additional prompts: ",0)
 ;Final line feed
 S VALMCNT=VALMCNT+1
 S ^TMP("PXRMDLG",$J,VALMCNT,0)=$J("",79)
 Q
