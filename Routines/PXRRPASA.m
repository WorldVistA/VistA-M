PXRRPASA ;ISL/PKR - Build and sort a list of appointments. ; 6/27/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**18**;Aug 12, 1996
 ;
SORT ;
 N BD,BUSY,CLINIEN,DFN,DONE,ED
 N IC,JC,FAC,FACILITY,FACNAM
 N HLOCIEN,POV,STATUS
 N TEMP
 ;
 ;Allow the task to be cleaned up upon successful completion.
 S ZTREQ="@"
 ;
 I '(PXRRQUE!$D(IO("S"))) D INIT^PXRRBUSY(.BUSY)
 ;
 ;Build a list of hospital locations to be included in the report.
 S TEMP=$P($G(PXRRLCSC),U,1)
 ;
 ;Check for selected hospital locations.
 I TEMP="HS" D
 . F IC=1:1:NHL D
 .. S HLOCIEN=$P(PXRRLCHL(IC),U,2)
 .. S FACILITY=$P(^SC(HLOCIEN,0),U,4)
 .. I $$FACCHECK(FACILITY) D
 ... S ^TMP(PXRRXTMP,$J,"HLOC",FACILITY,HLOCIEN)=""
 ;
 ;Check for selected clinics.
 I TEMP="CS" D
 . S IC=0
 . F  S IC=$O(^SC(IC)) Q:+IC=0  D
 .. S DONE=0
 .. S CLINIEN=$P(^SC(IC,0),U,7)
 .. I +CLINIEN>0 D
 ... F JC=1:1:NCS Q:DONE  D
 .... I CLINIEN=$P(PXRRCS(JC),U,2) D
 ..... S FACILITY=$P(^SC(IC,0),U,4)
 ..... I $$FACCHECK(FACILITY) S ^TMP(PXRRXTMP,$J,"HLOC",FACILITY,IC)=""
 ..... S DONE=1
 ;
 ;For all hospital locations or clinic stops we have to have
 ;all the locations in the file.
 I (TEMP="HA")!(TEMP="CA") D
 . S IC=0
 . F  S IC=$O(^SC(IC)) Q:+IC=0  D
 .. S FACILITY=$P(^SC(IC,0),U,4)
 .. I $$FACCHECK(FACILITY) D
 ... S ^TMP(PXRRXTMP,$J,"HLOC",FACILITY,IC)=""
 ;
 ;Build a list of appointments for each location.
 S FAC=""
NFAC S FAC=$O(^TMP(PXRRXTMP,$J,"HLOC",FAC))
 I FAC="" G APPDONE
 ;
 S HLOCIEN=""
NHLOC S HLOCIEN=$O(^TMP(PXRRXTMP,$J,"HLOC",FAC,HLOCIEN))
 I HLOCIEN="" G NFAC
 ;
 ;If this is an interactive session let the user know that something
 ;is happening.
 ;I '(PXRRQUE!$D(IO("S"))) D SPIN^PXRRBUSY("Sorting appointments",.BUSY)
 ;
 ;Check for a user request to stop the task.
 I $$S^%ZTLOAD S ZTSTOP=1 D EXIT^PXRRGUT
 ;
 S BD=PXRRBADT-.0001
 S ED=PXRREADT+.2359
NDATE S BD=$O(^SC(HLOCIEN,"S",BD))
 ;If we have passed the ending date we are done.
 I (BD>ED)!(BD="") G NHLOC
 ;
 ;If this is an interactive session let the user know that something
 ;is happening.
 I '(PXRRQUE!$D(IO("S"))) D SPIN^PXRRBUSY("Sorting appointments",.BUSY)
 ;
 ;At this point we have an appointment that can be added to the list.
 S IC=0
 F  S IC=$O(^SC(HLOCIEN,"S",BD,1,IC)) Q:+IC=0  D
 . S DFN=$P(^SC(HLOCIEN,"S",BD,1,IC,0),U,1)
 . S POV=$P(^DPT(DFN,"S",BD,0),U,7)
 . S STATUS=$P(^DPT(DFN,"S",BD,0),U,2)
 . S ^XTMP(PXRRXTMP,"APPT",FAC,HLOCIEN,DFN,BD)=STATUS_U_POV
 ;
 ;Get the next appointment.
 G NDATE
 ;
APPDONE ;
 I '(PXRRQUE!$D(IO("S"))) D DONE^PXRRBUSY("done")
EXIT ;
 K ^TMP(PXRRXTMP)
 ;
 ;Build the list of patient activities.
 I PXRRQUE D 
 .;Start the report that was queued but not scheduled.
 . N DESC,ROUTINE,TASK
 . S DESC="Patient Activity Report - patient activities"
 . S ROUTINE="PAT^PXRRPAPI"
 . S ZTDTH=$$NOW^XLFDT
 . S TASK=^XTMP(PXRRXTMP,"PATZTSK")
 . D REQUE^PXRRQUE(DESC,ROUTINE,TASK)
 E  D PAT^PXRRPAPI
 Q
 ;
 ;=======================================================================
FACCHECK(FAC,FACILITY) ;If FAC is on the list of facilities return true.
 N IC,FOUND
 S FOUND=0
 F IC=1:1:NFAC Q:FOUND  D
 . I $P(PXRRFAC(IC),U,1)=FAC D
 .. S FOUND=1
 Q FOUND
 ;
