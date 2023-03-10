PXRMOUTU ;SLC/PKR - Utilities for preparing output. ;02/14/2022
 ;;2.0;CLINICAL REMINDERS;**17,18,26,47,42,65**;Feb 04, 2005;Build 438
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
 . S TEXT(1)="There was an error processing this reminder, it could not be properly evaluated."
 . S TEXT(2)="There may be additional information in the error trap."
 . D ADDTXTA(2,PXRMRM,.NTXT,2,.TEXT)
 ;
 ;Frequency errors
 I $D(^TMP(PXRMPID,$J,PXRMITEM,"FERROR","NOFREQ")) D
 . S TEXT=^TMP(PXRMPID,$J,PXRMITEM,"FERROR","NOFREQ")
 . D ADDTXT(1,PXRMRM,.NTXT,TEXT)
 ;
 ;Patient errors
 I $D(^TMP(PXRMPID,$J,PXRMITEM,"FERROR","PATIENT")) D
 . S ERROR=$O(^TMP(PXRMPID,$J,PXRMITEM,"FERROR","PATIENT",""))
 . I ERROR="NO PAT" S TEXT=^TMP(PXRMPID,$J,PXRMITEM,"FERROR","PATIENT","NO PAT")
 . D ADDTXT(1,PXRMRM,.NTXT,TEXT)
 ;
 ;Problems with CF.VA-REMINDER DEFINITION
 ;No reminder definition
 I $D(^TMP(PXRMPID,$J,PXRMITEM,"FERROR","CF.VA-REMINDER DEFINITION")) D
 . K TEXT
 . S TEXT(1)=""
 . S TEXT(2)="The computed finding parameter for CF.VA-REMINDER DEFINITION is missing, invalid, or inactive."
 . D ADDTXTA(1,PXRMRM,.NTXT,2,.TEXT)
 ;
 ;Recursion
 I $D(^TMP(PXRMPID,$J,PXRMITEM,"FERROR","RECURSION")) D
 . K TEXT
 . S TEXT(1)=""
 . S TEXT(2)="This reminder definition is being called recursively, check CF.VA-REMINDER DEFINITION."
 . D ADDTXTA(2,PXRMRM,.NTXT,2,.TEXT)
 ;
 ;Reminder errors
 I $D(^TMP(PXRMPID,$J,PXRMITEM,"FERROR","NO REMINDER")) D
 . S TEXT=^TMP(PXRMPID,$J,PXRMITEM,"FERROR","NO REMINDER")
 . D ADDTXT(1,PXRMRM,.NTXT,TEXT)
 ;
 ;General text
 K TEXT
 S TEXT(1)=""
 S TEXT(2)="Please notify your Clinical Reminder Manager about this error."
 D ADDTXTA(1,PXRMRM,.NTXT,2,.TEXT)
 ;
 Q 1
 ;
 ;==================================================
INFO(PXRMITEM,NTXT) ;Output INFO text. An INFO node has the structure:
 ;(PXRMPID,$J,PXRMITEM,"INFO",DESCRIPTION)=TEXT
 I '$D(^TMP(PXRMPID,$J,PXRMITEM,"INFO")) Q
 N DES,TEXT
 S TEXT(1)=""
 S TEXT(2)="Information about the reminder evaluation:"
 D ADDTXTA(1,PXRMRM,.NTXT,2,.TEXT)
 S DES=""
 F  S DES=$O(^TMP(PXRMPID,$J,PXRMITEM,"INFO",DES)) Q:DES=""  D
 . S TEXT=^TMP(PXRMPID,$J,PXRMITEM,"INFO",DES)
 . D ADDTXT(2,PXRMRM,.NTXT,TEXT)
 Q
 ;
 ;==================================================
WARN(PXRMITEM,PXRMPDEM) ;Output WARNING text. An WARN node has the structure:
 ;(PXRMPID,$J,PXRMITEM,"WARNING",DESCRIPTION)=TEXT
 I '$D(^TMP(PXRMPID,$J,PXRMITEM,"WARNING")) Q
 N DES,NL,REMINDER,SUB
 K ^TMP("PXRMXMZ",$J)
 S SUB="Reminder evaluation warnings"
 S REMINDER=$S($G(PXRMITEM)>0:$P(^PXD(811.9,PXRMITEM,0),U,1),1:"?")
 S ^TMP("PXRMXMZ",$J,1,0)="The following warnings were encountered:",NL=1
 S DES=""
 F  S DES=$O(^TMP(PXRMPID,$J,PXRMITEM,"WARNING",DES)) Q:DES=""  D
 . S TEXT=^TMP(PXRMPID,$J,PXRMITEM,"WARNING",DES)
 . S NL=NL+1 S ^TMP("PXRMXMZ",$J,NL,0)=" "_^TMP(PXRMPID,$J,PXRMITEM,"WARNING",DES)
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="While evaluating reminder "_REMINDER
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="For patient DFN="_PXRMPDEM("DFN")
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="The time of the evaluation was "_$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 D SEND^PXRMMSG("PXRMXMZ",SUB,"",DUZ)
 K ^TMP("PXRMXMZ",$J)
 Q
 ;
