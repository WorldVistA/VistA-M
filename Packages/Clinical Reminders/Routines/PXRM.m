PXRM ;SLC/PKR - Clinical Reminders entry points. ;04/01/2022
 ;;2.0;CLINICAL REMINDERS;**4,11,12,16,18,24,26,47,42,65**;Feb 04, 2005;Build 438
 ;Entry points in this routine are listed in DBIA #2182.
 ;==========================================================
MAIN(DFN,PXRMITEM,OUTTYPE,DISC) ;Main driver for clinical reminders.
 ;INPUT  DFN - Pointer to Patient File (#2)
 ;       PXRMITEM - IEN of reminder to evaluate.
 ;       OUTTYPE - Flag to indicate type of output information.
 ;         0 - Reminders DUE NOW only (CLINICAL REMINDERS DUE
 ;             HS component)
 ;         1 - All Reminders with Next and Last Information
 ;             (CLINICAL REMINDERS SUMMARY HS component)
 ;         5 - Health Maintenance (CLINICAL REMINDERS MAINTENANCE
 ;              HS component)
 ;        10 - MyHealtheVet summary
 ;        11 - MyHealtheVet detailed
 ;        12 - MyHealtheVet combined
 ;        55 - Order check
 ;        DISC - (optional) if this is true then the disclaimer will
 ;             be loaded in ^TMP("PXRM",$J,"DISC").
 ;
 ;OUTPUT  ^TMP("PXRHM",$J,PXRMITEM,PXRMRNAM)=
 ;              STATUS_U_DUE DATE_U_LAST DONE
 ;        where PXRMRNAM is the PRINT NAME or if it is undefined then
 ;        it is the NAME (.01).
 ;        For the Clinical Maintenance component, OUTTYPE=5, there is 
 ;        subsequent output of the form
 ;        ^TMP("PXRHM",$J,PXRMITEM,PXRMRNAM,"TXT",N)=TEXT
 ;        where N is a number and TEXT is a text string.
 ;
 ;        If DISC is true then the disclaimer will be loaded into
 ;        ^TMP("PXRM",$J,"DISC"). The calling application should
 ;        delete this when it is done.
 ;
 ;        The calling application can display the contents of these
 ;        two ^TMP arrays as it chooses. The caller should also make
 ;        sure the ^TMP globals are killed before it exits.
 ;
 N DEFARR,EVALDT,FIEVAL
 ;Load the definition into DEFARR.
 D DEF^PXRMLDR(PXRMITEM,.DEFARR)
 ;
 I $G(NODISC)="" S NODISC=1
 S EVALDT=$$NOW^XLFDT
 D EVAL(DFN,.DEFARR,OUTTYPE,NODISC,.FIEVAL,EVALDT)
 Q
 ;
 ;==========================================================
MAINDF(DFN,PXRMITEM,OUTTYPE,EVALDT) ;Alternate entry point that allows
 ;evaluation date/time as input parameter and saves FIEVAL in
 ;^TMP("PXRHM,$J,PXRMITEM,"FIEVAL").
 N DEFARR,FIEVAL
 D DEF^PXRMLDR(PXRMITEM,.DEFARR)
 D EVAL(DFN,.DEFARR,OUTTYPE,0,.FIEVAL,EVALDT)
 M ^TMP("PXRHM",$J,PXRMITEM,"FIEVAL")=FIEVAL
 Q
 ;
 ;==========================================================
DISABLE(PXRMITEM,RNAME) ;
 N MNAME,NTXT,RDATA,REASON,TEXT
 S ^TMP("PXRHM",$J,PXRMITEM,RNAME)="CNBD^DISABLED^DISABLED"
 S ^TMP("PXRHM",$J,PXRMITEM,RNAME,"TXT",1)="Reminder evaluation is temporarily disabled."
 S NTXT=1,REASON=""
 F  S REASON=$O(^XTMP("PXRM_DISEV","REASON",REASON)) Q:REASON=""  D
 . S NTXT=NTXT+1
 . S ^TMP("PXRHM",$J,PXRMITEM,RNAME,"TXT",NTXT)="Reason: "_REASON_"."
 . S RDATA=""
 . F  S RDATA=$O(^XTMP("PXRM_DISEV","REASON",REASON,RDATA)) Q:RDATA=""  D
 .. S NTXT=NTXT+1
 .. I REASON["index" D
 ... S TEXT="Of file #"_RDATA
 ...;Check if the index has been rebuilt.
 ... D INDXCHK^PXRMDIEV(REASON,RDATA)
 .. I REASON["manager" D
 ... S MNAME=$P(^VA(200,RDATA,0),U,1)
 ... S TEXT="The reminder manager is - "_MNAME
 .. S ^TMP("PXRHM",$J,PXRMITEM,RNAME,"TXT",NTXT)=TEXT_"."
 Q
 ;
 ;==========================================================
EVAL(DFN,DEFARR,OUTTYPE,NODISC,FIEVAL,DATE) ;Reminder evaluation entry
 ;point. This entry point uses the local array DEFARR for the reminder
 ;definition and returns the Finding Evaluation Array, FIEVAL.
 ;PXRM name spaced variables are the reminder evaluation "global"
 ;variables. If date is specified then the reminder will be evaluated
 ;as if the current date is DATE.
 N LAST,PXRMAGE,PXRMDATE,PXRMDOB,PXRMDOD,PXRMLAD,PXRMPDEM,PXRMPID
 N PXRMITEM,PXRMRM,PXRMRNAM,PXRMSEX,PXRMSIG
 ;Make sure the reminder exists.
 I $D(DEFARR("DNE")) D NODEF^PXRMERRH(DEFARR("IEN")) Q
 ;PXRMRM is the right margin for output.
 S PXRMRM=80
 S PXRMDATE=+$G(DATE)
 S PXRMITEM=DEFARR("IEN")
 S PXRMPID="PXRM"_PXRMITEM_$H
 N D00
 S D00=DEFARR(0)
 S PXRMRNAM=$P(D00,U,3)
 ;If the print name is null use the .01.
 I PXRMRNAM="" S PXRMRNAM=$P(D00,U,1)
 ;
 I $D(^XTMP("PXRM_DISEV",0)) D DISABLE(PXRMITEM,PXRMRNAM) G EXIT
 ;
 ;Set the error handler to the PXRMERRH routine. Use the new style of
 ;error trapping.
 N $ES,$ET
 S $ET="D ERRHDLR^PXRMERRH"
 ;
 ;Make sure the "E" node exists
 I $D(DEFARR(20))&'$D(DEFARR("E")) D  G EXIT
 . S ^TMP("PXRHM",$J,PXRMITEM,PXRMRNAM)="ERROR"_U_"E NODE MISSING"
 . S ^TMP(PXRMPID,$J,PXRMITEM,"FERROR","NO ENODE")=""
 ;
 ;Check for recursion.
 N RECUR
 S RECUR=$$RECCHK^PXRMRCUR(PXRMITEM)
 I RECUR D  G EXIT
 . N ERROR,NTXT
 . S ^TMP(PXRMPID,$J,PXRMITEM,"FERROR","RECURSION")=RECUR
 . S ^TMP("PXRHM",$J,PXRMITEM,PXRMRNAM)="ERROR"
 . S NTXT=1
 . S ERROR=$$FERROR^PXRMOUTU(.NTXT)
 ;
 ;Establish the main findings evaluation variables.
 N CRSTATUS,DUE,DUEDATE,FREQ,PCLOGIC,RESDATE,RESLOGIC
 S (DUE,DUEDATE,FREQ,RESDATE)=0
 S (CRSTATUS,PCLOGIC,RESLOGIC)=""
 ;
 ;Establish the patient demographic information.
 N TODAY
 S TODAY=$G(DATE,DT)
 D DEM^PXRMPINF(DFN,TODAY,.PXRMPDEM)
 I PXRMPDEM("PATIENT")="" D  G EXIT
 . S ^TMP(PXRMPID,$J,PXRMITEM,"FERROR","PATIENT","NO PAT")="DFN "_DFN_" IS NOT A VALID PATIENT"
 . S PCLOGIC=0
 ;
 ;Load the local demographic variables for use in condition.
 S PXRMAGE=PXRMPDEM("AGE"),PXRMDOB=PXRMPDEM("DOB"),PXRMDOD=PXRMPDEM("DOD")
 S PXRMLAD=PXRMPDEM("LAD"),PXRMSEX=PXRMPDEM("SEX"),PXRMSIG=PXRMPDEM("SIG")
 ;
 ;Check for a date of death.
 I PXRMPDEM("DOD")'="" D
 . S ^TMP(PXRMPID,$J,PXRMITEM,"N/A","DEAD")=""
 . S ^TMP(PXRMPID,$J,PXRMITEM,"DEAD")="Patient is deceased."
 ;
 ;If the component is CR and the patient is deceased we are done.
 I OUTTYPE=0,PXRMPDEM("DOD")'="",'$G(PXRMIDOD) G OUTPUT
 ;
 ;Check for a sex specific reminder.
 N SEXOK
 S SEXOK=$$SEX^PXRMLOG(.DEFARR,PXRMPDEM("SEX"))
 S FIEVAL("SEX")=SEXOK
 ;If the patient is the wrong sex then don't do anything else.
 I 'SEXOK D  G OUTPUT
 . S PCLOGIC=0
 . S ^TMP(PXRMPID,$J,PXRMITEM,"N/A","SEX")=""
 . S ^TMP(PXRMPID,$J,PXRMITEM,"INFO","SEX")="Patient is the wrong sex!"
 ;
 ;Evaluate the findings.
 D EVAL^PXRMEVFI(DFN,.DEFARR,.FIEVAL)
 ;
 ;Check for missing index.
 I $D(^TMP(PXRMPID,$J,PXRMITEM,"WARNING","MISSING INDEX")) D  G OUTPUT
 . S (DUE,DUEDATE)="CNBD",PCLOGIC=1
 ;
 ;Evaluate the Patient Cohort Logic.
 D EVALPCL^PXRMLOG(.DEFARR,.PXRMPDEM,.FREQ,.PCLOGIC,.FIEVAL)
 ;
 ;Evaluate the resolution logic and get the last resolution date.
 D EVALRESL^PXRMLOG(.DEFARR,.RESDATE,.RESLOGIC,.FIEVAL)
 ;
 ;If there is CONTRAINDICATED LOGIC or RESOLUTION LOGIC, determine CRSTATUS.
 I (DEFARR(80)'="")!(DEFARR(90)'="") S CRSTATUS=$$CRSTATUS^PXRMLOG(.DEFARR,.FIEVAL)
 ;
 ;If the reminder is applicable calculate the due date.
 I PCLOGIC D DUE^PXRMDATE(.DEFARR,RESDATE,FREQ,.DUE,.DUEDATE,.FIEVAL)
 ;
OUTPUT ;Prepare the final output.
 D OUTPUT^PXRMOUTD(OUTTYPE,.DEFARR,.PXRMPDEM,PCLOGIC,RESLOGIC,DUE,DUEDATE,RESDATE,FREQ,CRSTATUS,.FIEVAL)
 ;
EXIT ;Kill the working arrays unless this was a test run.
 K ^TMP($J,"SVC",DFN)
 I $G(PXRMDEBG) D
 . S PXRMID=PXRMPID
 . S FIEVAL("PATIENT AGE")=$G(PXRMPDEM("AGE"))
 . S FIEVAL("DFN")=DFN
 . S FIEVAL("EVAL DATE/TIME")=$$NOW^PXRMDATE
 . S ^TMP(PXRMPID,$J,PXRMITEM,"REMINDER NAME")=$G(PXRMRNAM)
 E  K ^TMP(PXRMPID,$J)
 ;
 ;I DISC is true load the disclaimer.
 I $G(DISC) D LOAD^PXRMDISC
 Q
 ;
 ;==========================================================
FIDATA(DFN,PXRMITEM,FINDINGS) ;Return the finding evaluation array to the
 ;caller in the array FINDINGS. The caller should use the form
 ;D FIDATA^PXRM(DFN,PXRMITEM,.FINDINGS)
 ;The elements of the FINDINGS array will correspond to the
 ;findings in the reminder definition. For finding N FINDINGS(N)
 ;will be 0 if the finding is false and 1 if it is true. For
 ;true findings there will be additional elements. The exact set
 ;of additional elements will depend of the type of finding.
 ;Some typical examples are:
 ;FINDINGS(N)=1
 ;FINDINGS(N,"DATE")=FileMan date
 ;FINDINGS(N,"FINDING")=variable pointer to the finding
 ;FINDINGS(N,"FILE NUMBER")=file number of data source
 ;FINDINGS(N,"VALUE")=value of the finding, for example the
 ;                    value of a lab test
 ;
 N DEFARR,FI,FIEVAL
 ;Load the definition into DEFARR.
 D DEF^PXRMLDR(PXRMITEM,.DEFARR)
 D EVAL(DFN,.DEFARR,0,1,.FIEVAL)
 K ^TMP("PXRM",$J),^TMP("PXRHM",$J)
 ;Load the FINDINGS array.
 S FI=0
 F  S FI=+$O(FIEVAL(FI)) Q:FI=0  D
 . S FINDINGS(FI)=FIEVAL(FI)
 . I 'FIEVAL(FI) Q
 . S FINDINGS(FI,"DATE")=FIEVAL(FI,"DATE")
 . I FIEVAL(FI,"FINDING")["PSDRUG" S FINDINGS(FI,"DRUG")=1
 . S FINDINGS(FI,"FILE NUMBER")=FIEVAL(FI,"FILE NUMBER")
 . S FINDINGS(FI,"FINDING")=FIEVAL(FI,"FINDING")
 . I $D(FIEVAL(FI,"TERM")) S FINDINGS(FI,"TERM")=FIEVAL(FI,"TERM")
 . I $D(FIEVAL(FI,"VALUE")) S (FINDINGS(FI,"RESULT"),FINDINGS(FI,"VALUE"))=FIEVAL(FI,"VALUE")
 . I $D(FIEVAL(FI,"VISIT")) S FINDINGS(FI,"VIEN")=FIEVAL(FI,"VISIT")
 Q
 ;
 ;==========================================================
INACTIVE(PXRMITEM) ;Return the INACTIVE FLAG, which has a value of 1
 ;if the reminder is inactive.
 I '$D(^PXD(811.9,PXRMITEM)) Q 1
 Q $P(^PXD(811.9,PXRMITEM,0),U,6)
 ;
