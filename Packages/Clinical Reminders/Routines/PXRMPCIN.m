PXRMPCIN ; SLC/PKR - Computed findings for primary care info. ;06/09/2006
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ;
 ;=======================================================
PROVIDER(DFN,TEST,DATE,VALUE,TEXT) ;Computed finding for a patient's
 ;primary care provider. Value is the name which is the .01 node
 ;of file #200 the NEW PERSON file.
 N PP
 S DATE=$$NOW^PXRMDATE
 ;DBIA #1252
 S PP=$P($$OUTPTPR^SDUTL3(DFN,DATE),U,2)
 I PP="" S TEST=0 Q
 S TEST=1,VALUE=PP
 Q
 ;
 ;=======================================================
TEAM(DFN,TEST,DATE,VALUE,TEXT) ;Computed finding for a patient's primary
 ;care team. Value is the name which is the .01 node
 ;of file 404.51 the TEAM file.
 N PT
 S DATE=$$NOW^PXRMDATE
 ;DBIA #1252
 S PT=$P($$OUTPTTM^SDUTL3(DFN,DATE),U,2)
 I PT="" S TEST=0 Q
 S TEST=1,VALUE=PT
 Q
 ;
