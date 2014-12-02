PXRMEXLB ;SLC/PJH - Reminder Dialog Exchange. ;06/27/2013
 ;;2.0;CLINICAL REMINDERS;**6,12,26**;Feb 04, 2005;Build 404
 ;
 ;=====================================================================
 ;Build the DLOC array.
BDLOC(IEN,IND120) ;
 N DDATA,DNAME,JND
 S JND=0
 F  S JND=$O(^PXD(811.8,IEN,120,IND120,1,JND)) Q:JND=""  D
 .S DDATA=$G(^PXD(811.8,IEN,120,IND120,1,JND,0)) Q:DDATA=""
 .S DNAME=$P(DDATA,U,1)
 .;Save start and end in 100 node and 120 node IND and JND.
 .S ^TMP("PXRMEXTMP",$J,"DLOC",DNAME)=$P(DDATA,U,2,3)_U_IND120_U_JND
 Q
 ;
 ;Build list of dialog components
 ;-------------------------------
DBUILD(IEN,IND120,JND120) ;
 N CNT,DARRAY,DATA,DDATA,DDLG,DEND,DIALNAM,DLOC,DMAP,DNAME,DNODE,DSEQ
 N DSTRT,DSUB,FDATA,FILE,FILENAM,FILENUM,FNAME,IND,INDICES,JND,LINE
 N REPARR,REPCNT,RESGRP,TEMPRESL,VERSN
 K ^TMP("PXRMEXTMP",$J,"DMAP")
 S LINE=^PXD(811.8,IEN,100,3,0)
 S VERSN=$$GETTAGV^PXRMEXU3(LINE,"<PACKAGE_VERSION>")
 S DDATA=$G(^PXD(811.8,IEN,120,IND120,1,JND120,0)) Q:DDATA=""
 S ^TMP("PXRMEXTMP",$J,"PXRMDNAME")=$P(DDATA,U,1)
 S DIALNAM=$P(DDATA,U,1)
 S DSUB=$P(DDATA,U,2)+2
 I $P($G(^PXD(811.8,IEN,100,DSUB,0)),";",3)["100~NATIONAL" S ^TMP("PXRMEXTMP",$J,"PXRMDNAT")=""
 I '$D(^TMP("PXRMEXTMP",$J,"DLOC")) D BDLOC(IEN,IND120)
 S (JND,REPCNT)=0
 ;Scan the dialog components in 120 and save the name and type.
 F  S JND=$O(^PXD(811.8,IEN,120,IND120,1,JND)) Q:JND'>0!(JND>JND120)  D
 .S DDATA=$G(^PXD(811.8,IEN,120,IND120,1,JND,0)) Q:DDATA=""
 .S (DDLG,DNAME)=$P(DDATA,U,1)
 .S DSTRT=$P(DDATA,U,2),DEND=$P(DDATA,U,3),DSUB=DSTRT+2
 .;Extract dialog type and text and findings from exchange file
 .D DPARSE(IND120,JND,DNAME,DSTRT,DEND,.RESGRP,.TEMPRSEL)
 .;Scan dialog components in 120 and save dialog links
 .F  S DSUB=$O(^PXD(811.8,IEN,100,DSUB)) Q:DSUB>DEND  D
 ..S LINE=$G(^PXD(811.8,IEN,100,DSUB,0))
 .. S INDICES=$P(LINE,"~",1)
 .. S DATA=$P(LINE,"~",2)
 .. S FILE=$P(INDICES,";",1)
 .. S FIELD=$P(INDICES,";",3)
 .. I (FILE'=801.412)&(FILE'=801.41121)&(FIELD'=118) Q
 ..;Handle dialogs with replacement dialogs
 ..I FIELD=118 D
 ...S DNAME=DATA Q:DNAME=""
 ...S DLOC=^TMP("PXRMEXTMP",$J,"DLOC",DNAME)
 ...S REPCNT=REPCNT+1 D
 ....I +$P(VERSN,"P",2)>11 S ^TMP("PXRMEXTMP",$J,"DREPL",DIALNAM,REPCNT,DDLG)=DNAME_U_DLOC
 ....I +$P(VERSN,"P",2)<12 S REPARR(REPCNT,DDLG)=DNAME_U_DLOC
 ..I FIELD'=.01 Q
 ..S DSEQ=DATA Q:DSEQ=""
 ..I FILE="801.41121" D  Q
 ...S DNAME=DATA Q:DNAME=""
 ...;Quit if DLOC for the item is not defined. This should fix a problem
 ...;pre-patch 12 entries not containing national prompts.
 ...I +$P(VERSN,"P",2)<12,'$D(^TMP("PXRMEXTMP",$J,"DLOC",DNAME)) Q
 ...S DLOC=^TMP("PXRMEXTMP",$J,"DLOC",DNAME)
 ...S CNT=0
 ...I $D(^TMP("PXRMEXTMP",$J,"DMAP",DDLG))>0 S CNT=$O(^TMP("PXRMEXTMP",$J,"DMAP",DDLG,""),-1)
 ...S ^TMP("PXRMEXTMP",$J,"DMAP",DDLG,CNT+1)=DNAME
 ..S LINE=$G(^PXD(811.8,IEN,100,DSUB+1,0))
 ..I ($P(LINE,";")'="801.412") Q
 .. S INDICES=$P(LINE,"~",1)
 .. I $P(INDICES,";",3)'=2 Q
 .. S DATA=$P(LINE,"~",2)
 .. S DNAME=DATA Q:DNAME=""
 ..;Quit if DLOC for the item is not defined. This should fix a problem
 ..;pre-patch 12 entries not containing national prompts.
 ..I +$P(VERSN,"P",2)<12,'$D(^TMP("PXRMEXTMP",$J,"DLOC",DNAME)) Q
 ..S DLOC=^TMP("PXRMEXTMP",$J,"DLOC",DNAME)
 ..S ^TMP("PXRMEXTMP",$J,"DMAP",DDLG,DSEQ)=DNAME
 ;
 I $D(REPARR)>0 D
 .N CNT,DLG,REPCNT
 .S CNT="",REPCNT=0
 .F  S CNT=$O(REPARR(CNT)) Q:CNT=""  D
 ..S REPCNT=REPCNT+1,DLG=$O(REPARR(CNT,""))
 ..S ^TMP("PXRMEXTMP",$J,"DREPL",DIALNAM,REPCNT,DLG)=REPARR(CNT,DLG)
 ;
 ;Build index of dialog findings by name
 S IND=0
 F  S IND=$O(^PXD(811.8,IEN,120,IND)) Q:'IND  D
 .S FDATA=$G(^PXD(811.8,IEN,120,IND,0)) Q:FDATA=""
 .S FILENAM=$P(FDATA,U),FILENUM=$P(FDATA,U,2) Q:FILENAM=""  Q:'FILENUM
 .;Ignore reminder dialogs
 .I FILENAM="REMINDER DIALOG" Q
 .;Ignore reminder terms
 .I FILENAM="REMINDER TERM" Q
 .;Strip off trailing S in finding file name
 .I $E(FILENAM,$L(FILENAM))="S" S $E(FILENAM,$L(FILENAM))=""
 .S JND=0
 .F  S JND=$O(^PXD(811.8,IEN,120,IND,1,JND)) Q:'JND  D
 ..S FNAME=$P($G(^PXD(811.8,IEN,120,IND,1,JND,0)),U) Q:FNAME=""
 ..;Save entry
 ..S ^TMP("PXRMEXFND",$J,FNAME)=FILENUM_U_FILENAM_U_IND
 I $D(TEMPRESL)>0 D
 .S DDLG="" F  S DDLG=$O(TEMPRESL(DDLG)) Q:DDLG=""  D
 ..S DSEQ=$O(^TMP("PXRMEXTMP",$J,"DMAP",DDLG,""),-1)
 ..S ^TMP("PXRMEXTMP",$J,"DMAP",DDLG,DSEQ+1)=TEMPRESL(DDLG)_U_RESGRP(TEMPRESL(DDLG))
 Q
 ;
 ;---------------------------------------
 ;Scan exchange file to get dialog fields
 ;---------------------------------------
DPARSE(IND120,JND120,DNAME,DSTRT,DEND,RESGRP,TEMPRESL) ;
 N DARRAY,DCNT,DDATA,DFIND,DFIAD,DFNAM,DFNUM,DFQUIT,DLCT,DLINES
 N DSTRING,DSUB,DTEXT,DTXT,DTYP,RESNAME
 ;
 ;Find where all the field numbers are kept
 S DSUB=DSTRT-1,DSTRING=";.01;4;5;15;24;25;55;"
 F  S DSUB=$O(^PXD(811.8,IEN,100,DSUB)) Q:'DSUB  D  Q:DSUB>DEND
 .S DDATA=$G(^PXD(811.8,IEN,100,DSUB,0)) Q:DDATA=""
 .I $P(DDATA,";")'=801.41 Q
 .S DFNUM=$P(DDATA,";",3),DFNUM=$P(DFNUM,"~") Q:DFNUM=""
 .I DSTRING[(";"_DFNUM_";") S DARRAY(DFNUM)=DSUB
 .I $P(DDATA,";")="801.41121" S DARRAY(55)=DSUB
 ;
 ;Determine dialog component type
 S DSUB=DARRAY(4) Q:'DSUB
 S DTYP=$P($G(^PXD(811.8,IEN,100,DSUB,0)),"~",2)
 I DTYP'["result" S:DTYP[" " DTYP=$P(DTYP," ",2) S:DTYP="value" DTYP="forced"
 ;
 ;Initialise text and finding fields
 S DTXT="*NONE*",DFIND=""
 ;Get text appropriate for the type of component
 I ((DTYP="element")!(DTYP="group"))&(DTYP'["result") D
 .;Search for WP text
 .S DSUB=$G(DARRAY(25)) D:DSUB
 ..S DTEXT=$P($G(^PXD(811.8,IEN,100,DSUB,0)),";",3) Q:DTEXT=""
 ..;Get the line count
 ..S DLINES=$P(DTEXT,"~",3),DCNT=0
 ..;Get the wp text lines
 ..F DLCT=DSUB+1:1:DSUB+DLINES D
 ...S DTEXT=$G(^PXD(811.8,IEN,100,DLCT,0))
 ...S DCNT=DCNT+1,DTXT(DCNT)=DTEXT
 ...;Check for embedded TIU templates
 ...D DTIU(DNAME,DTEXT)
 ..;Reformat text to 50 characters
 ..D DWP(1,50,DCNT,.DTXT)
 ..;Search for Result Group/Element
 ..S DSUB=$G(DARRAY(55)) I DSUB>0 D
 ...S RESNAME=$P($P($G(^PXD(811.8,IEN,100,DSUB,0)),";",3),"~",2)
 ...S TEMPRESL(DNAME)=RESNAME
 .;Search for finding item
 .S DSUB=$G(DARRAY(15)) D:DSUB
 ..S DFIND=$P($G(^PXD(811.8,IEN,100,DSUB,0)),";",3) Q:DFIND=""
 ..;Finding name
 ..S DFIND=$P(DFIND,"~",2) Q:DFIND=""
 ..I $P(DFIND,".")="ICD9" S DFIND=$P(DFIND," ")
 .;
 .;Search for additional finding - start after WP text
 .S DSUB=+$G(DARRAY(25)) D:DSUB
 ..S DCNT=0,DFQUIT=0
 ..F DLCT=DSUB+1+DLINES:1 D  Q:DFQUIT  Q:DLCT>DEND
 ...S DTEXT=$G(^PXD(811.8,IEN,100,DLCT,0))
 ...;Ignore line if this is not an additional finding
 ...I $P(DTEXT,";")'=801.4118 S:$P(DTEXT,";")>801.4118 DFQUIT=1 Q
 ...S DFNAM=$P(DTEXT,"~",2) Q:DFNAM=""
 ...I $P(DFNAM,".")="ICD9" S DFNAM=$P(DFNAM," ")
 ...S DCNT=DCNT+1,DFIAD(DCNT)=DFNAM
 ;
 I DTYP["result" D
 .S DSUB=$G(DARRAY(.01)) Q:'DSUB
 .S DDATA=^PXD(811.8,IEN,100,DSUB,0) Q:DDATA=""
 .S DTXT=$P(DDATA,"~",2)
 .S RESGRP(DNAME)=DSTRT_U_DEND_U_IND120_U_JND120
 ;
 I DTYP="prompt" D
 .;search for prompt caption
 .S DSUB=$G(DARRAY(24)) Q:'DSUB
 .S DDATA=^PXD(811.8,IEN,100,DSUB,0) Q:DDATA=""
 .S DTXT="Prompt caption: "_$P(DDATA,"~",2)
 ;
 I DTYP="group" D
 .;search for group caption
 .S DSUB=$G(DARRAY(5)) Q:'DSUB
 .S DDATA=^PXD(811.8,IEN,100,DSUB,0) Q:DDATA=""
 .S DTXT="Group caption: "_$P(DDATA,"~",2)
 ;
 ;Save dialog type
 I DTYP["result" S DTYP=$$STRREP^PXRMUTIL(DTYP,"result ","rs.")
 S ^TMP("PXRMEXTMP",$J,"DTYP",DNAME)=DTYP
 ;Save dialog component text (first line only)
 I ($G(DTXT)'=""),(DTXT'=DNAME) S ^TMP("PXRMEXTMP",$J,"DTXT",DNAME)=DTXT
 ;
 ;Save main finding
 I DFIND]"" S ^TMP("PXRMEXTMP",$J,"DFND",DNAME,1)=$P(DFIND,".",2,99)
 ;Save additional findings
 S DSUB=0
 F   S DSUB=$O(DFIAD(DSUB)) Q:'DSUB  S ^TMP("PXRMEXTMP",$J,"DFND",DNAME,DSUB+1)=$P(DFIAD(DSUB),".",2,99)
 ;
 ;Save additional WP text lines
 S DSUB=0
 F   S DSUB=$O(DTXT(DSUB)) Q:'DSUB  S ^TMP("PXRMEXTMP",$J,"DTXT",DNAME,DSUB)=DTXT(DSUB)
 Q
 ;
 ;Extract any TIU templates
 ;-------------------------
DTIU(DNAME,TEXT) ;
 N IC,TCNT,TLIST,TNAM
 ;Templates are in format {FLD:fldname}
 S TCNT=0 D TIUXTR^PXRMEXU1("{FLD:","}",TEXT,.TLIST,.TCNT) Q:'TCNT
 ;
 F IC=1:1:TCNT D
 .S TNAM=$G(TLIST(TCNT)) Q:TNAM=""
 .S ^TMP("PXRMEXTMP",$J,"DTIU",DNAME,TNAM)=""
 Q
 ;
 ;Process WP fields
 ;-----------------
DWP(LM,RM,NIN,TEXT) ;
 N NOUT,TEXTOUT
 D FORMAT^PXRMTEXT(LM,RM,NIN,.TEXT,.NOUT,.TEXTOUT)
 K TEXT
 M TEXT=TEXTOUT
 Q
 ;
 ;-----------------
FINDSTRT(IEN,IND120,END) ;
 I END=1 Q 0
 N START,TEMP,ISSEL
 S START=0,TEMP=0
 F  S END=$O(^PXD(811.8,IEN,120,IND120,END),-1) Q:END'>0!(START>0)  D
 .S ISSEL=$P(^PXD(811.8,IEN,120,IND120,END,0),U,7)
 .I ISSEL=0 S TEMP=END Q
 .S START=TEMP
 Q START
 ;
