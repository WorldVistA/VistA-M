PXRMOUTU ;SLC/PKR - Utilites for preparing output. ;07/29/2010
 ;;2.0;CLINICAL REMINDERS;**17,18**;Feb 04, 2005;Build 152
 ;
 ;==================================================
ADDTXT(LM,RM,NTXT,TXT) ;
 N IND,NOUT,TEXTOUT
 D FORMATS^PXRMTEXT(LM,RM,.TXT,.NOUT,.TEXTOUT)
 F IND=1:1:NOUT S NTXT=NTXT+1,^TMP("PXRHM",$J,PXRMITEM,PXRMRNAM,"TXT",NTXT)=TEXTOUT(IND)
 Q
 ;
 ;==================================================
ADDTXTA(LM,RM,NTXT,NLINES,TXTA) ;Add an array of text.
 I NLINES=0 Q
 N IND,NOUT,TEXTOUT
 D FORMAT^PXRMTEXT(LM,RM,NLINES,.TXTA,.NOUT,.TEXTOUT)
 F IND=1:1:NOUT S NTXT=NTXT+1,^TMP("PXRHM",$J,PXRMITEM,PXRMRNAM,"TXT",NTXT)=TEXTOUT(IND)
 Q
 ;
 ;==================================================
COPYTXT(NTXT,NLINES,TEXT) ;Copy NLINES of TEXT into ^TMP output.
 N IND
 F IND=1:1:NLINES S NTXT=NTXT+1,^TMP("PXRHM",$J,PXRMITEM,PXRMRNAM,"TXT",NTXT)=TEXT(IND)
 Q
 ;
 ;==================================================
FERROR(NTXT) ; Check for a fatal error and output a message.
 I '$D(^TMP(PXRMPID,$J,PXRMITEM,"FERROR")) Q 0
 N ERROR,TEXT
 ;Error trap
 I $D(^TMP(PXRMPID,$J,PXRMITEM,"FERROR","ERROR TRAP")) D
 . S TEXT="There was an error processing this reminder. It could not be properly evaluated; please notify your Clinical Reminder coordinator."
 . D ADDTXT(1,PXRMRM,.NTXT,TEXT)
 ;
 ;Reminder errors
 I $D(^TMP(PXRMPID,$J,PXRMITEM,"FERROR","NO REMINDER")) D
 . S TEXT=^TMP(PXRMPID,$J,PXRMITEM,"FERROR","NO REMINDER")
 . D ADDTXT(1,PXRMRM,.NTXT,TEXT)
 ;
 ;Expanded taxonomy errors
 I $D(^TMP(PXRMPID,$J,PXRMITEM,"FERROR","EXPANDED TAXONOMY")) D
 . S ERROR=$O(^TMP(PXRMPID,$J,PXRMITEM,"FERROR","EXPANDED TAXONOMY",""))
 . I ERROR="NO LOCK" S TEXT="Could not get a lock for expanded taxonomy "_+PXRMXTLK_", try again!"
 . D ADDTXT(1,PXRMRM,.NTXT,TEXT)
 ;
 ;Patient errors
 I $D(^TMP(PXRMPID,$J,PXRMITEM,"FERROR","PATIENT")) D
 . S ERROR=$O(^TMP(PXRMPID,$J,PXRMITEM,"FERROR","PATIENT",""))
 . I ERROR="NOPAT" S TEXT=^TMP(PXRMPID,$J,PXRMITEM,"FERROR","PATIENT","NOPAT")
 . I ERROR="NO LOCK" S TEXT="Could not get a lock for patient "_PXRMPDEM("DFN")_", try again!"
 . D ADDTXT(1,PXRMRM,.NTXT,TEXT)
 Q 1
 ;
 ;==================================================
INFO(PXRMITEM,NTXT) ;Output INFO text. An INFO node has the structure:
 ;(PXRMPID,$J,PXRMITEM,"INFO",DESCRIPTION)=TEXT
 I '$D(^TMP(PXRMPID,$J,PXRMITEM,"INFO")) Q
 N DES,TEXT
 S TEXT="Information about the reminder evaluation:"
 D ADDTXT(1,PXRMRM,.NTXT,TEXT)
 S DES=""
 F  S DES=$O(^TMP(PXRMPID,$J,PXRMITEM,"INFO",DES)) Q:DES=""  D
 . S TEXT=^TMP(PXRMPID,$J,PXRMITEM,"INFO",DES)
 . D ADDTXT(2,PXRMRM,.NTXT,TEXT)
 Q
 ;
 ;==================================================
WARN(PXRMITEM,PXRMPDEM) ;Output WARNING text. An WARN node has the structure:
 ;(PXRMPID,$J,PXRMITEM,"WARN",DESCRIPTION)=TEXT
 I '$D(^TMP(PXRMPID,$J,PXRMITEM,"WARN")) Q
 N DES,NL,REMINDER,SUB
 K ^TMP("PXRMXMZ",$J)
 S SUB="Reminder evaluation warnings"
 S REMINDER=$S($G(PXRMITEM)>0:$P(^PXD(811.9,PXRMITEM,0),U,1),1:"?")
 S ^TMP("PXRMXMZ",$J,1,0)="The following warnings were encountered:",NL=1
 S DES=""
 F  S DES=$O(^TMP(PXRMPID,$J,PXRMITEM,"WARN",DES)) Q:DES=""  D
 . S TEXT=^TMP(PXRMPID,$J,PXRMITEM,"WARN",DES)
 . S NL=NL+1 S ^TMP("PXRMXMZ",$J,NL,0)=" "_^TMP(PXRMPID,$J,PXRMITEM,"WARN",DES)
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="While evaluating reminder "_REMINDER
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="For patient DFN="_PXRMPDEM("DFN")
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="The time of the evaluation was "_$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 D SEND^PXRMMSG("PXRMXMZ",SUB,"",DUZ)
 K ^TMP("PXRMXMZ",$J)
 Q
 ;
