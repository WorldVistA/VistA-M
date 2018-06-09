PXDATE ;SLC PKR Routines for dealing with dates. ;01/09/2018
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 244
 ;;
 ;================================
EVENTDT(HELP) ;Edit Event Date and Time.
 N EVENTDT,DIRUT,PROMPT
 S PROMPT="Event Date and Time"
 S EVENTDT=$$GETDT^PXDATE(-1,-1,-1,"NOW",PROMPT,HELP)
 I $D(DIRUT),(EVENTDT'="@") S PXCEEND=1 Q ""
 Q EVENTDT
 ;
 ;================================
FUTURE(DATE) ;Return 1 if DATE is in the future.
 I DATE>$$NOW^XLFDT Q 1
 Q 0
 ;
 ;================================
GETDT(REQTIME,BEFORE,AFTER,DEFAULT,PROMPT,HELP) ;General date/time entry
 ;REQTIME is 1 if time is required,
 ;           0 if time is optional
 ;          -1 if the date can be imprecise
 ;BEFORE  is the maximum number of days before the visit that the date
 ;        can be or -1 for no limit.
 ;AFTER   is the maximum number of days after the visit that the date
 ;        can be or -1 for no limit, except it cannot be in the future.
 ;DEFAULT is the default date/time if there is not one in the file.
 ;        The possible values are NOW or TODAY.
 N AFTERDT,BEFOREDT,DIR,VISITDT,X,Y
 S VISITDT=$P(^TMP("PXK",$J,"VST",1,0,"BEFORE"),U,1)
 S AFTERDT=$S(AFTER=-1:"NOW",1:$$FMADD^XLFDT(VISITDT,-AFTER,0,0,0))
 S BEFOREDT=$S(BEFORE=-1:"",1:$$FMADD^XLFDT(VISITDT,BEFORE,0,0,0))
 ;Setup the DIR call.
 S DIR(0)="DO^"_BEFOREDT_":"_AFTERDT_":ESP"
 S REQTIME=$G(REQTIME)
 S DIR(0)=DIR(0)_$S(REQTIME=1:"RX",REQTIME=-1:"T",REQTIME=0:"TX",1:"")
 S DIR("A")=PROMPT
 S DIR("B")=$$FMTE^XLFDT(DEFAULT,"5Z")
 I $G(HELP)'="" S DIR("??")="^"_HELP
 D ^DIR
 I X="@" S Y="@"
 Q Y
 ;
 ;================================
VFMDATE(DATE,%DT) ;Is DATE a valid FileMan date?
 N TIME,X,Y
 S X=DATE
 D ^%DT
 I Y=-1 Q Y
 S TIME=$P(DATE,".",2)
 I +$E(TIME,1,2)>24 Q -1
 I +$E(TIME,3,4)>59 Q -1
 I +$E(TIME,5,6)>59 Q -1
 Q Y
 ;
