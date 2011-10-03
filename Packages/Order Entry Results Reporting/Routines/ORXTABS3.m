ORXTABS3 ; SLC/PKS - Edit calls, tab parameters preferences. [10/17/00 2:39pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9,47,84**;Dec 17, 1997
 ;
 ; NOTES: The routines herein are called by those of the same tag 
 ;        name in ORXTABS2.  Most variables are NEW'd and assigned 
 ;        by one or more routines in the preceding call chains. 
 ;        Refer to comments and notes there for additional infor-
 ;        mation.  
 ;
 ;   Each tag in this routine must return one of the following:
 ;
 ;      1 - A new value entered or selected by the user,
 ;      2 - A null string,
 ;      3 - The string "*Invalid*" - to repeat due to invalid entry,
 ;      4 - The "^" character, indicating user's cancel action.
 ;
 Q
 ;
BEG ; Beginning date.
 ;
 ; Internal variables used:
 ;
 ;    ORXBDAT = Current "BEG" date entry.
 ;    ORXDATE = ORXNOW passed variable converted to external format.
 ;    ORXEDAT = Matching "END" date data.
 ;    ORXREQ  = Flag for required or optional date entry.
 ;    X       = Passed variable used in date format conversion.
 ;    Y       = Passed variable used in date format conversion.
 ;    %DT     = Passed variable in date conversion.
 ;
 N ORXBDAT,ORXDATE,ORXEDAT,ORXREQ,X,Y,%DT
 K ORXDATE
 S ORXREQ="O"
 ;
 ; Assign DIR variables and call DIR:
 S DIR("T")=120 ; Two minute maximum timeout for response.
 S DIR("A")="   Enter "_ORXPDIS_" value:  "
 S DIR("?")="   Enter beginning date; an empty response means an unrestricted beginning date range"
 I ORXPDIR="IMAGING"!(ORXPDIR="REPORTS") D   ; Required in some cases.
 .S ORXREQ=""
 .S DIR("A")="   Enter "_ORXPDIS_" value (required):  "
 .S DIR("?")="   Enter beginning date (required)"
 ;
 ; Assign DIR default, if any:
 I $L($G(ORXNOW)) S DIR("B")=$S(ORXNOW?7N.1".".6N:$$FMTE^XLFDT(ORXNOW),1:ORXNOW)
 S DIR(0)="DA"_ORXREQ_"^::ETX"               ; DIR input restrictions.
 W !!                                        ; For screen display.
 D ^DIR                                      ; FM user input call.
 S:$D(DTOUT) Y="^"                           ; Handle time-outs.
 S (ORXNOW,ORXBDAT)=Y                        ; ORXBDAT for comparison.
 S:X="@" ORXNOW="",ORXBDAT=""                ; User wants null entry.
 S:(X'="@")&(X'="^") ORXNOW=X                ; Or use X value.
 K DIR,X,Y                                   ; Clean up each time.
 ;
 ; Use ORXEDAT twice to Check for valid date entry:
 I ORXBDAT'="" D
 .I ORXNOW="^" Q
 .I (ORXCNT+1)>ORXNUM W !!,"ERROR: Improper TABS entry." S ORXNOW="^" Q
 .S ORXEDAT=$P($G(ORXSETS),";",ORXCNT+1)
 .I ORXEDAT'="END" W !!,"ERROR: Improper TABS entry." S ORXNOW="^" Q
 .S ORXEDAT=$P($G(ORXCUR),";",$P($G(ORXPCS),";",ORXCNT+1))
 .I ('$D(ORXEDAT)!(ORXEDAT="")) Q            ; Null END = accept.
 .S %DT="",X=ORXEDAT D ^%DT S ORXEDAT=Y      ; Convert all dates.
 .I ORXEDAT<ORXBDAT W !!,"ERROR: Beginning date cannot be later than ending date." S ORXNOW="*Invalid*"
 ;
 Q
 ;
END ; Ending date.
 ;
 ; Internal variables used:
 ;
 ;    ORXBDAT = Matching "BEG" date data.
 ;    ORXEDAT = Current "END" date entry.
 ;    ORXDATE = ORXNOW passed variable converted to external format.
 ;    ORXREQ  = Flag for required or optional date entry.
 ;    X       = Passed variable used in date format conversion.
 ;    Y       = Passed variable used in date format conversion.
 ;    %DT     = Passed variable in date conversion.
 ;
 N ORXBDAT,ORXEDAT,ORXDATE,ORXREQ,X,Y,%DT
 K ORXDATE
 S ORXREQ="O"
 ;
 ; Assign DIR variables and call DIR:
 S DIR("T")=120 ; Two minute maximum timeout for response.
 S DIR("A")="   Enter "_ORXPDIS_" value:  "
 S DIR("?")="   Enter ending date; a null response means an unlimited ending date range"
 I ORXPDIR="IMAGING"!(ORXPDIR="REPORTS") D   ; Required in some cases.
 .S ORXREQ=""
 .S DIR("A")="   Enter "_ORXPDIS_" value (required):  "
 .S DIR("?")="   Enter ending date (required)"
 ;
 ; Assign DIR default, if any:
 I $L($G(ORXNOW)) S DIR("B")=$S(ORXNOW?7N.1".".6N:$$FMTE^XLFDT(ORXNOW),1:ORXNOW)
 S DIR(0)="DA"_ORXREQ_"^::ETX"               ; DIR input restrictions.
 W !!                                        ; For screen display.
 D ^DIR                                      ; FM user input call.
 S:$D(DTOUT) Y="^"                           ; Handle time-outs.
 S (ORXNOW,ORXEDAT)=Y                        ; ORXEDAT for comparison.
 S:X="@" ORXNOW="",ORXEDAT=""                ; User wants null entry.
 S:(X'="@")&(X'="^") ORXNOW=X                ; Or use X value.
 K DIR,X,Y                                   ; Clean up each time.
 ;
 ; Use ORXBDAT twice to Check for valid date entry:
 I ORXEDAT'="" D
 .I ORXNOW="^" Q
 .I (ORXCNT-1)<1 W !!,"ERROR: Improper TABS entry." S ORXNOW="^" Q
 .S ORXBDAT=$P($G(ORXSETS),";",ORXCNT-1)
 .I ORXBDAT'="BEG" W !!,"ERROR: Improper TABS entry." S ORXNOW="^" Q
 .S ORXBDAT=$P($G(ORXCUR),";",$P($G(ORXPCS),";",ORXCNT-1))
 .I ('$D(ORXBDAT)!(ORXBDAT="")) Q            ; Null BEG = accept.
 .S %DT="",X=ORXBDAT D ^%DT S ORXBDAT=Y      ; Convert all dates.
 .I ORXBDAT>ORXEDAT W !!,"ERROR: Ending date cannot be earlier than beginning date." S ORXNOW="*Invalid*"
 ;
 Q
 ;
MAX ; Maximum.
 ;
 ; Assign DIR variables:
 S DIR("T")=120 ; Two minute maximum timeout for response.
 S DIR("A")="   Enter "_ORXPDIS_" # of items to display:  "
 S DIR("?")="   Entry must be between 1 and 999"
 S DIR(0)="NA^1:999"                         ; Numerical, required.
 I ORXPDIR="IMAGING" S DIR(0)="NAO^1:999"    ; Imaging not required.
 ;
 ; Call tag to get/assign input:
 D INPUT^ORXTABS2
 ;
 Q
 ;
AUTHOR ; Author, for D/C Summaries or Notes.
 ;
 ; Internal variables used:
 ;
 ;    DIC,X,Y,DTOUT,DUOUT = Variables for call to DIC.
 ;    ORXSTAT = Used to hold current value of related STATUS value.
 ;
 N DIC,X,Y,DTOUT,DUOUT,ORXSTAT
 ;
 ; Assign DIC variables and call DIC:
 S DIC=200
 S DIC(0)="AEFMQ"
 S DIC("A")="   Select author:  "
 S DIC("B")=$P($G(^VA(200,DUZ,0)),U)
 S DTIME=120
 W !!                                        ; Screen formatting.
 D ^DIC
 ;
 I $D(DUOUT) S ORXNOW="^"
 I $D(DTOUT) S ORXNOW="^"
 ;
 ; Examine user entry, treat if needed, and assign it for return:
 I ORXNOW'="^" S:+Y'>0 Y=""
 I ORXNOW'="^" S ORXNOW=+Y
 ;
 ; Use ORXSTAT twice to Check for valid entry:
 I ORXNOW'="" D
 .I (ORXCNT-1)<1 W !!,"ERROR: Improper TABS entry." S ORXNOW="^" Q
 .S ORXSTAT=$P($G(ORXSETS),";",ORXCNT-1)
 .I ORXSTAT'="STATUS" W !!,"ERROR: Improper TABS entry." S ORXNOW="^" Q
 .S ORXSTAT=$P($G(ORXCUR),";",$P($G(ORXPCS),";",ORXCNT-1))
 .I '$D(ORXSTAT) Q                           ; Null STATUS = accept.
 .I ((ORXSTAT=5)!(ORXNOW<4)) S ORXNOW=""     ; If STATUS'=4, set null.
 ;
 K DIC,X,Y,DTOUT,DUOUT
 ;
 Q
 ;
