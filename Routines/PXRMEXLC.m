PXRMEXLC ; SLC/PKR/PJH - Routines to display repository entry components. ;06/10/2009
 ;;2.0;CLINICAL REMINDERS;**4,6,12**;Feb 04, 2005;Build 73
 ;======================================================
BLDLIST(FORCE) ;Build a list of all repository entries.
 ;If FORCE is true then force rebuilding of the list.
 I FORCE K ^TMP("PXRMEXLR",$J)
 I $D(^TMP("PXRMEXLR",$J,"VALMCNT")) S VALMCNT=^TMP("PXRMEXLR",$J,"VALMCNT")
 E  D
 . D REXL^PXRMLIST("PXRMEXLR")
 . S VALMCNT=^TMP("PXRMEXLR",$J,"VALMCNT")
 Q
 ;
 ;======================================================
CDISP(IEN) ;Format component list for display.
 N CAT,CLOK,CMPNT,END,EXISTS,FILENUM,FMTSTR,FOKTT,IOKTI,IND,INDEX
 N JND,JNDS,KND,MSG,NCMPNT,NDLINE,NITEMS,NLINE,NSEL,PT01
 N START,TEMP,TEMP0,TYPE
 K ^TMP("PXRMEXLC",$J),^TMP("PXRMEXLD",$J)
 S CLOK=1
 I ('$D(^PXD(811.8,IEN,119)))!('$D(^PXD(811.8,IEN,120))) D CLIST^PXRMEXCO(IEN,.CLOK)
 I 'CLOK Q
 ;If this is being called by the Silent Installer VALMDDF will not
 ;exist.
 S FMTSTR=$S('$D(VALMDDF):"4R2^50L4^8C5^6C",1:$$LMFMTSTR^PXRMTEXT(.VALMDDF,"RLCC"))
 S (NDLINE,NLINE,NSEL)=0
 ;Load the description.
 F IND=1:1:$P(^PXD(811.8,IEN,110,0),U,4) D
 . S NLINE=NLINE+1
 . S ^TMP("PXRMEXLC",$J,NLINE,0)=^PXD(811.8,IEN,110,IND,0)
 S NLINE=NLINE+1
 S ^TMP("PXRMEXLC",$J,NLINE,0)=" "
 S NCMPNT=^PXD(811.8,IEN,119)
 ;Load the text for display.
 ;Build and load the item selection list for display.
 F IND=1:1:NCMPNT D
 . S NLINE=NLINE+1
 . S TEMP=^PXD(811.8,IEN,120,IND,0)
 . S ^TMP("PXRMEXLC",$J,NLINE,0)=$P(TEMP,U,1)
 . S FILENUM=$P(TEMP,U,2)
 . S NITEMS=$P(TEMP,U,3)
 .;See if items in this file are ok to transport.
 . S FOKTT=$$FOKTT^PXRMEXFI(FILENUM)
 . F JND=1:1:NITEMS D
 .. S TEMP=^PXD(811.8,IEN,120,IND,1,JND,0)
 ..;If items from this file can be installed make sure the individual
 ..;item is installable.
 .. S IOKTI=$S('FOKTT:0,1:$$IOKTI^PXRMEXFI(FILENUM,TEMP))
 .. S PT01=$P(TEMP,U,1)
 .. S EXISTS=$S(FILENUM=0:$$EXISTS^PXRMEXCF(PT01),1:$$EXISTS^PXRMEXIU(FILENUM,PT01,"W"))
 ..;If this is a health factor see if it is a category.
 .. S CAT=""
 .. I (FILENUM=9999999.64) D
 ... S TYPE=""
 ... S START=$P(TEMP,U,2)
 ... S END=$P(TEMP,U,3)
 ... F KND=START:1:END D
 .... S TEMP0=$P(^PXD(811.8,IEN,100,KND,0),";",3)
 .... I $P(TEMP0,"~",1)=.1 S TYPE=$P(TEMP0,"~",2)
 ... I TYPE="CATEGORY" S CAT="X"
 ..;If entries in this file are ok to install add them to the
 ..;selectable list. For dialog items only display those that are
 ..;selectable.
 .. I FILENUM=801.41,'IOKTI Q
 .. I IOKTI D
 ... S NSEL=NSEL+1,INDEX=NSEL
 ... S ^TMP("PXRMEXLC",$J,"SEL",NSEL)=FILENUM_U_IND_U_JND_U_EXISTS
 ... S ^TMP("PXRMEXLC",$J,"IDX",NSEL,NSEL)=""
 .. E  S INDEX=""
 .. D FMTDATA(FMTSTR,INDEX,PT01,CAT,EXISTS,.NLINE)
 . S NLINE=NLINE+1
 . S ^TMP("PXRMEXLC",$J,NLINE,0)=""
 Q
 ;
 ;======================================================
FMTDATA(FMTSTR,NSEL,PT01,CAT,EXISTS,NLINE) ;Format items for display.
 N IND,NL,NSTI,OUTPUT,TEMP
 S TEMP=NSEL_U_PT01_U_CAT_U_$S(EXISTS:"X",1:"")
 D COLFMT^PXRMTEXT(FMTSTR,TEMP," ",.NL,.OUTPUT)
 F IND=1:1:NL S NLINE=NLINE+1,^TMP("PXRMEXLC",$J,NLINE,0)=OUTPUT(IND)
 Q
 ;
 ;======================================================
INSCHR(NUM,CHR) ;Return a string of NUM characters (CHR).
 N IND,TEMP
 S TEMP=""
 I NUM<1 Q TEMP
 F IND=1:1:NUM S TEMP=TEMP_CHR
 Q TEMP
 ;
 ;======================================================
ORDER(STRING,ORDER) ;Rebuild string in ascending or descending order.
 N ARRAY,ITEM,CNT
 F CNT=1:1 S ITEM=$P(STRING,",",CNT) Q:'ITEM  S ARRAY(ITEM)=""
 K STRING
 F CNT=1:1 S ITEM=$O(ARRAY(ITEM),ORDER) Q:'ITEM  S $P(STRING,",",CNT)=ITEM
 Q
 ;
