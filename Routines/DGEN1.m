DGEN1 ;ALB/RMO - Patient Enrollment Protocols;16 JUN 1997 01:30 pm
 ;;5.3;Registration;**121,147,624**;08/13/93
 ;
EP ;Entry point for DGEN ENROLL PATIENT protocol 
 ; Input  -- DFN      Patient IEN
 ; Output -- VALMBCK  R   =Refresh screen
 ;
 ;send an enrollment/eligibility query
 I $$SEND^DGENQRY1(DFN) W !!,"Enrollment/Eligibility Query sent...",!!
 ;
 N DGENOUT
 S VALMBCK=""
 D FULL^VALM1
 ;
 ;Enroll patient
 I '$$ENRPAT^DGEN(DFN,.DGENOUT) D
 . I '$G(DGENOUT) D
 . . W !!,">>> Patient enrollment record was not created."
 . . D PAUSE^VALM1
 ELSE  D
 . ;Re-build enrollment screen
 . D BLD^DGENL
 D MESSAGE^DGENL(DFN)
 S VALMBCK="R"
 Q
 ;
CE ;Entry point for DGEN CEASE ENROLLMENT protocol 
 ; Input  -- DFN      Patient IEN
 ; Output -- VALMBCK  R   =Refresh screen
 N DGENOUT,DGENR,DGENRIEN
 S VALMBCK=""
 D FULL^VALM1
 ;
 ;Ask patient if s/he would like to cease enrollment
 I $$ASK^DGEN("cease enrollment",.DGENOUT) D
 . ;If 'Yes' cancel current enrollment
 . ;Find current enrollment
 . S DGENRIEN=$$FINDCUR^DGENA(DFN) Q:'DGENRIEN
 . ;Get current enrollment array
 . I $$GET^DGENA(DGENRIEN,.DGENR) D
 . . ;Cancel current enrollment
 . . I '$$CANCEL^DGEN(DFN,.DGENR) D
 . . . W !!,">>> Patient's enrollment was not ceased."
 . . . D PAUSE^VALM1
 . . ELSE  D
 . . . ;Re-build enrollment screen
 . . . D BLD^DGENL
 D MESSAGE^DGENL(DFN)
 S VALMBCK="R"
 Q
 ;
EH ;Entry point for DGEN EXPAND HISTORY protocol
 ; Input  -- DFN      Patient IEN
 ; Output -- VALMBCK  R   =Refresh screen
 N DGI,DGSELY
 S VALMBCK=""
 ;
 ;Select entries to expand
 D EN^DGENLR(XQORNOD(0),"EH",.DGSELY)
 I $D(DGSELY("^"))!($D(DGSELY("ERR"))) G EHQ
 D FULL^VALM1
 ;
 ;Expand history for selected entries
 S DGI=0
 ;Loop through selection
 F  S DGI=$O(DGSELY(DGI)) Q:'DGI  D
 . N DGLINE,DGENRIEN
 . S DGLINE=+$O(^TMP("DGENIDX",$J,"EH",DGI,0)),DGENRIEN=+$G(^(DGLINE))
 . W !!,^TMP("DGEN",$J,DGLINE,0)
 . ;Load patient enrollment history screen
 . D EN^DGENLEH(DFN,DGENRIEN)
 D MESSAGE^DGENL(DFN)
 S VALMBCK="R"
EHQ Q
 ;
SP ;Entry point for DGEN SELECT PATIENT protocol
 ; Input  -- None
 ; Output -- DFN      Patient IEN
 ;           VALMBCK  R   =Refresh screen
 N DGDFN
 S VALMBCK=""
 D FULL^VALM1
 ;
 ;Get Patient File (#2) IEN
 D GETPAT^DGRPTU(,,.DGDFN,)
 ;
 ;If a patient is selected
 I DGDFN>0 D
 . ;Reset DFN to selected patient
 . S DFN=DGDFN
 . ;Re-build enrollment screen for selected patient
 . D BLD^DGENL
 D MESSAGE^DGENL(DFN)
 S VALMBCK="R"
SPQ Q
 ;
QUERY ;entry point for DGEN SEND ENROLLMENT QUERY protocol
 I '$$ON^DGENQRY W "sending of enrollment queries turned off" Q
 N NOTIFY,DIR,ERROR
 S DIR("A")="Do you want to be notified when the reply is received"
 S DIR("B")="YES"
 S DIR(0)="Y"
 S DIR("?")="If YES, you will be mailed notification when the reply is received."
 D ^DIR
 I '$D(DIRUT) D
 .K DIR
 .I Y=1 S NOTIFY=$G(DUZ)
 .I $$SEND^DGENQRY1(DFN,$G(NOTIFY),,.ERROR) D
 ..W !!,"Enrollment/Eligibility query sent ..."
 .E  D
 ..W !!,"Failure to send Query: ",ERROR
 .D PAUSE^VALM1
 D MESSAGE^DGENL(DFN)
 S VALMBCK="R"
 Q
 ;
CHECK ;Entry point for the DGEN CHECK QUERY STATUS protocol
 I $$PENDING^DGENQRY(DFN) D
 .W !!,"Query still pending ..."
 .D PAUSE^VALM1
 .D MESSAGE^DGENL(DFN)
 E  D
 .W !!,"Query is not pending ..."
 .D PAUSE^VALM1
 .D BLD^DGENL
 S VALMBCK="R"
 Q
 ;
PEZ ;Entry point for DGENUP PRINT 1010EZ-EZR protocol (DG*5.3*624)
 N RPTSEL,DGTASK,MTIEN
 D FULL^VALM1
 S (RPTSEL,DGTASK,MTIEN)=""
 S RPTSEL=$$SEL1010^DG1010P("") ;*Select 1010EZ/R form to print
 D:RPTSEL'="-1"
 .S MTIEN=$$MTPRMPT^DG1010P(DFN,"") ;select mt to print 
 .S DGTASK=$$PRT1010^DG1010P(RPTSEL,DFN,MTIEN) ;*Print 1010EZ/R
 S VALMBCK="R"
 Q
