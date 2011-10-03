PXRMOUTD ; SLC/PKR - Reminder output driver. ;10/20/2009
 ;;2.0;CLINICAL REMINDERS;**4,17**;Feb 04, 2005;Build 102
 ;
 ;===================================================
DUE(PXRMITEM,DUE,DUEDATE,RESDATE,FREQ,FIEVAL) ;Create the due information.
 N LDATE,LDATEF,TEMP,TXT
 ;
 I RESDATE["E" S LDATEF=+RESDATE_U_"E"
 I RESDATE["X" D
 . S LDATEF=+RESDATE_U_"X"
 . S LDATE=0
 E  S LDATE=+RESDATE
 I (+RESDATE)'>0 S LDATEF="unknown"
 I '$D(LDATEF) S LDATEF=LDATE
 ;
 ;Immunizations may be marked as contraindicated. If that is the case
 ;they are never due.
 I $G(FIEVAL("CONTRAINDICATED"))=1 D  Q
 . S ^TMP("PXRHM",$J,PXRMITEM,PXRMRNAM)="NEVER"_U_DUEDATE_U_LDATEF
 ;
 ;A reminder frequency of 0Y is a special case that means never show as
 ;applicable.
 I (FREQ="0Y") D  Q
 . S ^TMP("PXRHM",$J,PXRMITEM,PXRMRNAM)="N/A"_U_U_LDATEF
 ;
 ;A reminder frequency of 99Y means do once in a lifetime. In this
 ;case display null for the due date.
 I (LDATE>0)&(FREQ="99Y") D  Q
 . S ^TMP("PXRHM",$J,PXRMITEM,PXRMRNAM)="DONE"_U_""_U_LDATEF
 ;
 S ^TMP("PXRHM",$J,PXRMITEM,PXRMRNAM)=DUE_U_DUEDATE_U_LDATEF
 Q
 ;
 ;===================================================
IGNNA(PXRMITEM,NOOUTPUT) ;The reminder is N/A, determine if there is
 ;no Clinical Maintenance output.
 S NOOUTPUT=1
 ;Get the IGNORE ON N/A information.
 N IGNORE
 S IGNORE=$P(DEFARR(0),U,8)
 ;
 ;If the reminder is N/A and the ignore wildcard is set we are done.
 I ($D(^TMP(PXRMPID,$J,PXRMITEM,"N/A")))&(IGNORE["*") Q
 ;
 ;Look for specific ignore codes.
 I ($D(^TMP(PXRMPID,$J,PXRMITEM,"N/A","AGE")))&(IGNORE["A") Q
 I ($D(^TMP(PXRMPID,$J,PXRMITEM,"N/A","INACTIVE")))&(IGNORE["I") Q
 I $D(^TMP(PXRMPID,$J,PXRMITEM,"N/A","INACTIVE")) D  Q
 . S ^TMP("PXRHM",$J,PXRMITEM,PXRMRNAM)=""
 . S ^TMP("PXRHM",$J,PXRMITEM,PXRMRNAM,"TXT",1)=^TMP(PXRMPID,$J,PXRMITEM,"N/A","INACTIVE")
 I ($D(^TMP(PXRMPID,$J,PXRMITEM,"N/A","RACE")))&(IGNORE["R") Q
 I ($D(^TMP(PXRMPID,$J,PXRMITEM,"N/A","SEX")))&(IGNORE["S") Q
 ;If we got to here there are no ignore codes so return the N/A
 ;information and turn the output on.
 S NOOUTPUT=0
 Q
 ;
 ;===================================================
OUTPUT(OUTTYPE,DEFARR,PXRMPDEM,PCLOGIC,RESLOGIC,DUE,DUEDATE,RESDATE,FREQ,FIEVAL) ;
 ;Produce the final output.
 N NTXT S NTXT=0
 ;Check for a fatal error.
 I $$FERROR^PXRMOUTU(.NTXT) S ^TMP("PXRHM",$J,PXRMITEM,PXRMRNAM)="ERROR" Q
 ;See if any warnings need to be issued.
 D WARN^PXRMOUTU(PXRMITEM,.PXRMPDEM)
 ;
 ;Temporarily set CMB=CM
 I OUTTYPE=4 S OUTTYPE=5
 ;
 ;If the component is CR (Reminders Due) and the reminder is not due
 ;we are done.
 I (OUTTYPE=0)&(DUE'["DUE") Q
 ;
 ;If the reminder is N/A do the N/A part for the summary and maintenance
 ;components.
 N NOOUTPUT
 S NOOUTPUT=0
 I 'PCLOGIC D
 .;IGNORE ON N/A applies only to the Clinical Maintenance component.
 . I OUTTYPE=5 D IGNNA(PXRMITEM,.NOOUTPUT)
 . I 'NOOUTPUT D NAOUTPUT(PXRMITEM,RESDATE)
 I NOOUTPUT Q
 ;
 ;If the reminder is applicable produce the due information.
 I PCLOGIC D DUE(PXRMITEM,DUE,DUEDATE,RESDATE,FREQ,.FIEVAL)
 ;
 ;Proudce the various output types
 ;Clinical maintenance output.
 I OUTTYPE=5 D CM^PXRMOUTC(.DEFARR,.PXRMPDEM,PCLOGIC,RESLOGIC,RESDATE,.FIEVAL,OUTTYPE)
 ;Order check output.
 I OUTTYPE=55 D CM^PXRMOUTC(.DEFARR,.PXRMPDEM,PCLOGIC,RESLOGIC,RESDATE,.FIEVAL,OUTTYPE)
 ;MyHealtheVet summary.
 I OUTTYPE=10 D MHVS^PXRMOUTM(.DEFARR,.PXRMPDEM,PCLOGIC,RESLOGIC,RESDATE,.FIEVAL,1)
 ;MyHealtheVet detailed.
 I OUTTYPE=11 D MHVD^PXRMOUTM(.DEFARR,.PXRMPDEM,PCLOGIC,RESLOGIC,RESDATE,.FIEVAL,1)
 ;MyHealtheVet detailed.
 I OUTTYPE=12 D MHVC^PXRMOUTM(.DEFARR,.PXRMPDEM,PCLOGIC,RESLOGIC,RESDATE,.FIEVAL)
 ;
 ;If there is any information stored in ^TMP("PXRHM") Health Summary
 ;will not display it unless ^TMP("PXRHM",$J,PXRMITEM,PXRMRNAM) has
 ;data in it.
 I '$D(PXRMITEM)!'$D(PXRMRNAM) Q
 I $D(^TMP("PXRHM",$J,PXRMITEM,PXRMRNAM))=10 S ^TMP("PXRHM",$J,PXRMITEM,PXRMRNAM)=" "
 Q
 ;
 ;===================================================
NAOUTPUT(PXRMITEM,RESDATE) ;Prepare the N/A output.
 N DDATE
 I RESDATE["E" S DDATE=+RESDATE_U_"E"
 I RESDATE["X" S DDATE=+RESDATE_U_"X"
 I '$D(DDATE) S DDATE=+RESDATE
 I DDATE=0 S DDATE=""
 S ^TMP("PXRHM",$J,PXRMITEM,PXRMRNAM)="N/A"_U_U_DDATE
 Q
 ;
