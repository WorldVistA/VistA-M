IBFBWL6 ;ALB/PAW-IB NVC Precert Worklist IV and RUR  ;30-SEP-2015
 ;;2.0;INTEGRATED BILLING;**554**;21-MAR-94;Build 81
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; -- main entry point for IB NVC PRECERT WORKLIST IV and RUR
 ; add code to do filters here
 ;
 I IBGRP=1 D EN^VALM("IB NVC PRECERT WORKLIST IV")
 I IBGRP=2 D EN^VALM("IB NVC PRECERT WORKLIST RUR")
 Q
 ;
HDR ; -- header code
 ;
 N IBSS,IBSSX,IBSSLE,IBSSLS
 S VALM("TITLE")=" Worklist Actions"
 S IBSSX=$$GET1^DIQ(2,DFN_",",.09,"I"),IBSSLE=$L(IBSSX),IBSSLS=6 I $E(IBSSX,IBSSLE)="P" S IBSSLS=5
 S IBSS=$E(IBNAME,1)_$E(IBSSX,IBSSLS,IBSSLE)
 S VALMHDR(2)=" PATIENT: "_IBNAME_" (ID: "_IBSS_")"
 Q
 ;
INIT ; -- init variables and list array
 ; input - ^TMP("IBFBWA",$J)=DFN^IBNAME^IBAUTH
 ; output - none
 N DFN,ECNT,IBAUTH,IBNAME,IBFIRST
 I '$D(^TMP("IBFBWA",$J)) Q
 S ECNT=$G(^TMP("IBFBWA",$J))
 S DFN=$P(ECNT,U,1),IBNAME=$P(ECNT,U,2),IBAUTH=$P(ECNT,U,3)
 D BLD
 Q
 ;
BLD ; Build data to display
 N IBGRPX,VALMY
 I $G(IBFIRST)'="" S IBFIRST="" Q
 D FULL^VALM1
 S IBGRPX=$S(IBGRP=1:"Insurance Verification",1:"RUR Pre-certification")
 I IBGRP=1 D
 . D SET^VALM10(1,"","")
 . D SET^VALM10(2," Available Actions:","")
 . D SET^VALM10(3,"","")
 . D SET^VALM10(4,"   Enter 1 if Pre-cert is required.","")
 . D SET^VALM10(5,"   Enter 2 if Pre-cert is NOT required.","")
 I IBGRP=2 D
 . D SET^VALM10(1,"Available Actions:","")
 . D SET^VALM10(2,"","")
 . D SET^VALM10(3,"   Enter 1 to remove auth from worklist.","")
 . D SET^VALM10(4,"   Enter 2 to complete certification.","")
 . D SET^VALM10(5,"   Enter 3 to set a next review date.","")
 . D RURRC
 S VALMBCK="R"
 Q
 ; 
IVDONE ; IV is complete
 N IBEVENT,IBIEN,IENROOT
 I $G(IBFIRST)'="" S IBFIRST="" Q
 S IENROOT=""
 D FIND
 S FDA(360,IBIEN_",",2.01)="XX"
 D UPDATE^DIE("","FDA","IENROOT")
 S FDA(360,IBIEN_",",2.02)="UR"
 D UPDATE^DIE("","FDA","IENROOT")
 D RESET
 D NOW^%DTC
 S IBEVENT="IV-Req Precert"
 D LOGUPD
 W !," Pre-cert for "_IBNAME_" is required.  Moved to RUR worklist."
 S IBFIRST=1
 D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
IVREM ; IV Remove Auth from Worklist
 N IBEVENT,IBIEN,IENROOT
 I $G(IBFIRST)'="" S IBFIRST="" Q
 D FIND
 S FDA(360,IBIEN_",",2.01)="XX"
 D UPDATE^DIE("","FDA","IENROOT")
 D RESET
 D NOW^%DTC
 S IBEVENT="IV-Precert not req"
 D LOGUPD
 W !," Pre-cert for "_IBNAME_" not required.  Removed from worklist."
 S IBFIRST=1
 D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
RUDONE ; RUR Pre-certification is complete
 N IBEVENT,IBIEN,IBRC,IENROOT
 I $G(IBFIRST)'="" S IBFIRST="" Q
 D FIND
 S FDA(360,IBIEN_",",2.02)="XX"
 D UPDATE^DIE("","FDA","IENROOT")
 D RESET
 D RURRCPR
 D NOW^%DTC
 S IBEVENT="RUR-Precert complete|"_$G(IBRC)
 D LOGUPD
 W !," Authorization for "_IBNAME_" has completed RUR Pre-certification."
 S IBFIRST=1
 D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
RUREM ; RUR Remove Auth from Worklist
 N IBEVENT,IBIEN,IBRC
 I $G(IBFIRST)'="" S IBFIRST="" Q
 D FIND
 S FDA(360,IBIEN_",",2.02)="XX"
 D UPDATE^DIE("","FDA","IENROOT")
 D RESET
 D RURRCPR
 D NOW^%DTC
 S IBEVENT="RUR-Precert removed|"_$G(IBRC)
 D LOGUPD
 W !," Authorization for "_IBNAME_" has been removed from the worklist."
 ; W !," Please update Claims Tracking with Non-billable Reason, if needed."
 S IBFIRST=1
 D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
RUNRD ; RUR Set Next Review Date
 N DIRUT,IBNRD,IBIEN,IENROOT,X,Y,IBEVENT,IBRC
 I $G(IBFIRST)'="" S IBFIRST="" Q
 S (IBNRD,IENROOT)=""
 D FIND
 S DIR(0)="DA^"_DT_"::EX",DIR("A")="Next Review Date: "
 ; default to date is last day of current month
 S X=$E($$SCH^XLFDT("1M(L@1A)",DT)\1,6,7)
 S DIR("B")=$$FMTE^XLFDT($E(DT,1,5)_X)
 D ^DIR K DIR Q:$D(DIRUT)
 S IBNRD=Y
 S FDA(360,IBIEN_",",3.01)=IBNRD
 D UPDATE^DIE("","FDA","IENROOT")
 D RESET
 D RURRCPR
 D NOW^%DTC
 S IBEVENT="RUR-NextRevDt "_$$FDATE^VALM1(IBNRD)_"|"_$G(IBRC)
 D LOGUPD
 W !," Next review date for "_IBNAME_" has been set to "_$$FDATE^VALM1(IBNRD)_"."
 S IBFIRST=1
 D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
FIND ; Find Auth Match
 N IBX
 S IBX="" F  S IBX=$O(^IBFB(360,"C",DFN,IBX)) Q:IBX=""  D
 . I $P(^IBFB(360,IBX,0),U,3)=IBAUTH S IBIEN=IBX
 Q
 ;
LOGUPD ; Update Log
 N FDA,IBDT,IBLOG
 S IBDT=$$NOW^XLFDT()
 S FDA(360.04,"+1,"_IBIEN_",",.01)=IBDT,FDA(360.04,"+1,"_IBIEN_",",.03)=DUZ
 S IBLOG=$P($G(^IBFB(360,IBIEN,4,0)),U,3)
 S IBLOG=IBLOG+1
 S FDA(360.04,"+1,"_IBIEN_",",.02)=IBEVENT
 D UPDATE^DIE("","FDA")
 S ^IBFB(360,"DFN",DFN,DT,IBIEN,IBLOG)=""
 S ^IBFB(360,"DT",DT,DFN,IBIEN,IBLOG)=""
 Q
 ;
RESET ; Reset ^TMP global
 N IBDOS,IBINS
 I IBGRP=1 D
 . S IBINS=""
 . F  S IBINS=$O(^TMP("IBFBWL",$J,IBINS)) Q:IBINS=""  D
 .. I $D(^TMP("IBFBWL",$J,IBINS,IBNAME,DFN,IBAUTH)) D
 ... K ^TMP("IBFBWL",$J,IBINS,IBNAME,DFN,IBAUTH)
 I IBGRP=2 D
 . S IBDOS=""
 . F  S IBDOS=$O(^TMP("IBFBWL",$J,IBDOS)) Q:IBDOS=""  D
 .. S IBINS=""  F  S IBINS=$O(^TMP("IBFBWL",$J,IBDOS,IBINS)) Q:IBINS=""  D
 ... I $D(^TMP("IBFBWL",$J,IBDOS,IBINS,IBNAME,DFN,IBAUTH)) D
 .... K ^TMP("IBFBWL",$J,IBDOS,IBINS,IBNAME,DFN,IBAUTH)
 Q
 ;
RURRC ; Reason Codes
 ; Option 2 (internal comment 2) was removed - Addl Info Req - Refer to FR - and renumbered
 D SET^VALM10(6,"","")
 D SET^VALM10(7," At the second prompt, you may enter one of the following:","")
 D SET^VALM10(8,"","")
 D SET^VALM10(9," 1. Pending Payer Action             6. Continued Stay Review","")
 D SET^VALM10(10," 2. Auth Not Reqd - SC/SA            7. Discharge Review Required","")
 D SET^VALM10(11," 3. Auth Not Reqd - Payer Contacted  8. Partial SC Stay - Auth Worked","")
 D SET^VALM10(12," 4. Auth Not Required                9. Partial Stay/Visit Approved","")
 D SET^VALM10(13," 5. Auth Obtained                   10. Auth Denied","")
 D SET^VALM10(14,"                                    11. Auth Not Obtained/No ROI/Sent to FR","")
 Q
 ;
RURRCPR ; RUR Reason Code Prompt
 N X,Y
 S IBRC=""
 K DIR S DIR(0)="NO^1:11"
 S DIR("A")="Enter REASON CODE (1-11) or return: "
 S DIR("?",1)="Enter a Reason Code between 1 and 11 or Enter if no code."
 D ^DIR K DIR
 S IBRC=$G(Y)
 I IBRC="^" W !,"This response must be a number." G RURRCPR
 S IBRC=$S(IBRC=1:1,IBRC=2:3,IBRC=3:4,IBRC=4:5,IBRC=5:6,IBRC=6:7,IBRC=7:8,IBRC=8:9,IBRC=9:10,IBRC=10:11,IBRC=11:12,1:"")
 Q
 ;        
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D ^%ZISC
 S VALMBCK="R"
 Q
