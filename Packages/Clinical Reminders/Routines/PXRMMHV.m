PXRMMHV ; SLC/PKR - Clinical Reminders entry points. ; 10/19/2005
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ;Supports DBIA #4811.
 ;==========================================================
MHVC(DFN) ;Return the MHV combined output for all the active patient
 ;reminders.
 N RIEN
 K ^TMP("PXRMMHVC",$J)
 S RIEN=0
 F  S RIEN=$O(^PXD(811.9,"P",RIEN)) Q:+RIEN'>0  D
 . I $P(^PXD(811.9,RIEN,0),U,6)=1 Q
 . D MAIN^PXRM(DFN,RIEN,12,0)
 Q
 ;
 ;==========================================================
PREMLIST ;Return a list of the active patient reminders.
 N NAME,RIEN,TEMP
 K ^TMP("PXRMMHVL",$J)
 S RIEN=0
 F  S RIEN=$O(^PXD(811.9,"P",RIEN)) Q:+RIEN'>0  D
 . S TEMP=^PXD(811.9,RIEN,0)
 . I $P(TEMP,U,6)=1 Q
 . S ^TMP("PXRMMHVL",$J,RIEN)=$P(TEMP,U,1)_U_$P(TEMP,U,3)_U_$P(^PXD(811.9,RIEN,100),U,1)
 Q
 ;
 ;==========================================================
WEBALL ;Return the web site information for all the active patient reminders.
 N NAME,RIEN,TEMP
 K ^TMP("PXRMMHVW",$J)
 S RIEN=0
 F  S RIEN=$O(^PXD(811.9,"P",RIEN)) Q:+RIEN'>0  D
 . S TEMP=^PXD(811.9,RIEN,0)
 . I $P(TEMP,U,6)=1 Q
 . D WEBI(RIEN,"PXRMMHVW")
 Q
 ;
 ;==========================================================
WEBI(RIEN,NODE) ;Return the web site information for an individual reminder.
 N IEN,IND,NL,TEMP,URL
 I '$D(^PXD(811.9,RIEN,50)) Q
 S IEN=0
 F  S IEN=+$O(^PXD(811.9,RIEN,50,IEN)) Q:IEN=0  D
 . S TEMP=$G(^PXD(811.9,RIEN,50,IEN,0))
 . S URL=$P(TEMP,U,1)
 . I URL="" Q
 . S ^TMP(NODE,$J,RIEN,"WEB",IEN,"URL")=URL
 . S ^TMP(NODE,$J,RIEN,"WEB",IEN,"TITLE")=$P(TEMP,U,2)
 .;If there is a description output it.
 . I '$D(^PXD(811.9,RIEN,50,IEN,1)) Q
 . S (IND,NL)=0
 . F  S IND=+$O(^PXD(811.9,RIEN,50,IEN,1,IND)) Q:IND=0  D
 .. S NL=NL+1
 .. S ^TMP(NODE,$J,RIEN,"WEB",IEN,"DESCRIPTION",NL)=^PXD(811.9,RIEN,50,IEN,1,IND,0)
 Q
 ;
