PXRMDLG3 ; SLC/PJH - Reminder Dialog Edit/Inquiry ;07/29/2004
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;
 ;Display national dialog
START N NLINE,NSEL
 S NLINE=0,NSEL=0
 ;
 ;Group header
 I $P($G(^PXRMD(801.41,PXRMDIEN,0)),U,4)="G" D
 .D DLINE(PXRMDIEN,"","")
 ;Other components
 D DETAIL(PXRMDIEN,"")
 ;Create headings
 D CHGCAP^VALM("HEADER1","Item  Seq.")
 D CHGCAP^VALM("HEADER2","Dialog Details/Findings")
 D CHGCAP^VALM("HEADER3","Type")
 S VALMCNT=NLINE
 S ^TMP("PXRMDLG",$J,"VALMCNT")=VALMCNT
EXIT Q
 ;
 ;Additional Findings
 ;-------------------
ADD(DIEN) ;
 N FIND,FSUB,FTYP,FNAME,FNUM
 S FSUB=0
 F  S FSUB=$O(^PXRMD(801.41,DIEN,3,FSUB)) Q:'FSUB  D
 .S FIND=$P($G(^PXRMD(801.41,DIEN,3,FSUB,0)),U) Q:FIND=""
 .S FNAME="" D FDESC(FIND) Q:FNAME=""
 .;Save additional finding name
 .S FOUND=1 D SAVE(2,FNAME,FTYP)
 Q
 ;
 ;Build listman global for all components
 ;---------------------------------------
DETAIL(PXRMDIEN,LEV) ;
 N DDATA,DDLG,DEND,DIEN,DNAM,DSEQ,DSTRT,IND,JND,DSUB
 S DSEQ=0
 ;
 ;Get each sequence number
 F  S DSEQ=$O(^PXRMD(801.41,PXRMDIEN,10,"B",DSEQ)) Q:'DSEQ  D
 .;Determine subscript
 .S DSUB=$O(^PXRMD(801.41,PXRMDIEN,10,"B",DSEQ,"")) Q:'DSUB
 .;Get ien of prompt/component
 .S DIEN=$P($G(^PXRMD(801.41,PXRMDIEN,10,DSUB,0)),U,2) Q:'DIEN
 .;Ignore prompts and forced values
 .I "PF"[$P($G(^PXRMD(801.41,DIEN,0)),U,4) Q
 .;Save line in workfile
 .D DLINE(DIEN,LEV,DSEQ)
 .;
 .;Process any sub-components
 .D DETAIL(DIEN,LEV_DSEQ_".")
 .;Extra line feed
 .I LEV="" D
 ..S NLINE=NLINE+1
 ..S ^TMP("PXRMDLG",$J,NLINE,0)=$J("",79)
 Q
 ;
 ;Save individual component details
 ;---------------------------------
DLINE(DIEN,LEV,DSEQ) ;
 ;Dialog name
 S DNAM=$P($G(^PXRMD(801.41,DIEN,0)),U) Q:DNAM=""
 ;Check if standard PXRM prompt
 I $$PXRM^PXRMEXID(DNAM) Q
 ;
 N DPTX,DTXT,DTYP,EXIST,ITEM,TEMP,SEP
 S ITEM=""
 S NSEL=NSEL+1,ITEM=NSEL
 S NLINE=NLINE+1,SEP=$E(LEV,$L(LEV))
 S TEMP=$J(ITEM,3)_$J("",4)_LEV_DSEQ
 ;Determine type
 S DTYP=$S($P($G(^PXRMD(801.41,DIEN,0)),U,4)="G":"group",1:"element")
 ;Dialog component display
 I $L(TEMP)<13 S TEMP=TEMP_$J("",12+$L(SEP)-$L(TEMP))_$E(DNAM,1,50)
 E  S TEMP=TEMP_" "_$E(DNAM,1,50)
 ;Add Type
 S ^TMP("PXRMDLG",$J,NLINE,0)=TEMP_$J("",70-$L(TEMP))_DTYP
 ;
 ;Set up selection index
 S ^TMP("PXRMDLG",$J,"IDX",NSEL,DIEN)=""
 ;
 ;Insert finding items
 I ("element;group"[DTYP) D
 .N DSUB,FDATA,FILENUM,FLIT,FLONG,FNAME,FOUND,FREP,FTAB,FTYP,TEMP
 .;Findings
 .S FNAME="",FOUND=0
 .D FDESC($P($G(^PXRMD(801.41,DIEN,1)),U,5))
 .I FNAME'="" S FOUND=1 D SAVE(1,FNAME,FTYP)
 .;Additional findings (see ADD^PXRMDLG2)
 .D ADD(DIEN)
 .;If no findings
 .I 'FOUND D
 ..S NLINE=NLINE+1
 ..S ^TMP("PXRMDLG",$J,NLINE,0)=$J("",12+$L(SEP))_"Finding: *NONE*"
 Q
 ;
 ;Finding description
 ;-------------------
FDESC(FIEN) ;
 N FGLOB,FITEM
 ;Determine finding type
 S FGLOB=$P(FIEN,";",2) Q:FGLOB=""
 S FITEM=$P(FIEN,";") Q:FITEM=""
 ;Diagnosis POV
 I FGLOB["ICD9" D  Q
 .S FTYP="DIAGNOSIS",FGLOB=U_FGLOB_FITEM_",0)"
 .S FNAME=$P($G(@FGLOB),U,3)
 I FGLOB["WV" D  Q
 .S FTYP="WH NOTIFICATION PURPOSE",FGLOB=U_FGLOB_FITEM_",0)"
 .S FNAME=$P($G(@FGLOB),U)
 ;Procedure CPT
 I FGLOB["ICPT" D  Q
 .S FTYP="PROCEDURE",FGLOB=U_FGLOB_FITEM_",0)"
 .S FNAME=$P($G(@FGLOB),U,2)
 ;Quick order
 I FGLOB["ORD(101.41" D  Q
 .S FTYP="QUICK ORDER",FGLOB=U_FGLOB_FITEM_",0)"
 .S FNAME=$P($G(@FGLOB),U,2)
 ;Short name for finding type
 S FTYP=$G(DEF1(FGLOB)) Q:FTYP=""
 ;Long name
 S FTYP=$G(DEF2(FTYP))
 S FGLOB=U_FGLOB_FITEM_",0)"
 S FNAME=$P($G(@FGLOB),U,1)
 I FNAME="" S FNAME=$P($G(@FGLOB),U)
 I FNAME]"" S FNAME=FNAME Q
 S FNAME=FITEM
 Q
 ;
 ;Save finding details
 ;--------------------
SAVE(DSUB,FNAME,FTYP) ;
 N TEMP
 I DSUB=1 S FLIT="Finding: "
 I DSUB>1 S FLIT="Add. Finding: "
 S FLONG=0
 I $L(FLIT_FNAME_" ("_FTYP_")")>60 S FLONG=1
 I 'FLONG S FNAME=FLIT_FNAME_" ("_FTYP_")"
 I FLONG S FNAME=FLIT_FNAME
 S TEMP=$J("",12+$L(SEP))_$E(FNAME,1,60)_$J("",60-$L(FNAME))
 S NLINE=NLINE+1
 S ^TMP("PXRMDLG",$J,NLINE,0)=TEMP
 I FLONG D
 .S NLINE=NLINE+1
 .S FTAB=$S(DSUB=1:21,1:26)
 .S ^TMP("PXRMDLG",$J,NLINE,0)=$J("",FTAB)_"("_FTYP_")"
 Q
