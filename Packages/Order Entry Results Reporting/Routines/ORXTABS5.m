ORXTABS5 ;SLC/PKS - Edit calls, tab parameters preferences. [11/22/00 11:16am]
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
 ;   Some tags in this routine are functions or calls used by 
 ;      other tags herein.
 ;
 Q
 ;
TYPE ; Type, for labs.
 ;
 ; Assign DIR variables:
 S DIR("T")=120 ; Two minute maximum timeout for response.
 S DIR("A")="   Enter "_ORXPDIS_":  "
 S DIR("A",1)="      L     List Format"
 S DIR("A",2)="      C     Cumulative Format"
 S DIR(0)="SAO^L:List Format;C:Cumulative Format" ; Optional, Set of Codes.
 ;
 ; Translate one value to match past practice:
 I ORXNOW="R" S ORXNOW="L"
 ;
 ; Call tag to get/assign input:
 D INPUT^ORXTABS2
 ;
 ; Re-translate one value to match past practice:
 I ORXNOW="L" S ORXNOW="R"
 ;
 ; Present applicability message to user: 
 W !!,"(NOTE: This setting applies only to the LM version of CPRS.)",!
 ;
 Q
 ;
DISPGRP ; Display Group (service/section), for orders.
 ;
 ; Internal variables used:
 ;
 ;    DIC,X,Y,DTOUT,DUOUT = Variables for FM calls.
 ;    ORXDONE             = Flag for loop exit.
 ;    ORXTMP              = Temporary variable for value holding.
 ;
 N DIR,X,Y,DTOUT,DUOUT,ORXDONE,ORXTMP
 ;
 ; Set/translate current setting into a display value:
 I (('$D(ORXNOW))!(ORXNOW="")) S ORXNOW="ALL"
 S ORXTMP=0
 I ORXNOW'="" D
 .S ORXTMP=$O(^ORD(100.98,"B",ORXNOW,ORXTMP))
 .I ORXTMP>0 S ORXTMP=$P(^ORD(100.98,ORXTMP,0),U)
 ;
 ; Establish loop for input control:
 S ORXDONE=0
 F  D  Q:ORXDONE
 .W !!,"   Enter "_ORXPDIS_" for display of orders."
 .W !!,"   Select Service/Section: "_ORXTMP_"//"
 .R X:DTIME S:'$T X="^" I X["^" S ORXDONE=1 Q
 .I X="" S ORXDONE=1 Q                       ; No change.
 .I X="@" S ORXDONE=1 Q                      ; Results in default.
 .I X["?" W !!,"   Choose from:",! D DG^ORCHANG1(1,"DISP") Q
 .S DIC=100.98,DIC(0)="NEQZ"
 .D ^DIC
 .S:Y>0 ORXNOW=$P(Y(0),U,3),ORXDONE=1
 I X="@" S ORXNOW=X
 I (ORXNOW="@") S ORXNOW="ALL"               ; Bottom line default.
 ;
 Q
 ;
OUTPT ; Outpatient (0) or Inpatient (1) meds display.
 ;
 ; Assign DIR variables:
 S DIR("T")=120 ; Two minute maximum timeout for response.
 S DIR("A")="   Enter "_ORXPDIS_":  "
 S DIR("A",1)="      0     Outpatient"
 S DIR("A",2)="      1     Inpatient"
 S DIR(0)="SAO^0:Outpatient;1:Inpatient"     ; Optional, Set of Codes.
 ;
 ; Call tag to get/assign input:
 D INPUT^ORXTABS2
 ;
 Q
 ;
SUBJECT ; Subject, for notes.
 ;
 ; Assign DIR variables:
 S DIR("T")=120 ; Two minute maximum timeout for response.
 S DIR("A")="   Enter "_ORXPDIS_" setting:  "
 S DIR("A",1)="      0     Off/Hide Subjects"
 S DIR("A",2)="      1     On/Show Subjects"
 S DIR(0)="SAO^0:Off/Hide Subjects;1:On/Show Subjects"
 ;
 ; Call tag to get/assign input:
 D INPUT^ORXTABS2
 ;
 Q
 ;
FORMAT ; Format, for orders.
 ;
 ; Assign DIR variables:
 S DIR("T")=120 ; Two minute maximum timeout for response.
 S DIR("A")="   Enter "_ORXPDIS_" setting for Orders:  "
 S DIR("A",1)="      L     Long"
 S DIR("A",2)="      S     Short"
 S DIR(0)="SAO^L:Long;S:Short"
 ;
 ; Call tag to get/assign input:
 D INPUT^ORXTABS2
 ;
 Q
 ;
COMMENTS ; Comments, for problems.
 ;
 ; Assign DIR variables:
 S DIR("T")=120 ; Two minute maximum timeout for response.
 S DIR("A")="   Enter "_ORXPDIS_" setting for Problems:  "
 S DIR("A",1)="      0     Off/Hide Comments"
 S DIR("A",2)="      1     On/Show Comments"
 S DIR(0)="SAO^0:Off/Hide Comments;1:On/Show Comments"
 ;
 ; Call tag to get/assign input:
 D INPUT^ORXTABS2
 ;
 Q
 ;
SERVICE ; Service, for consults.
 ;
 ; Internal variables used:
 ;
 ;    DIC,X,Y,DTOUT,DUOUT = Variables for call to DIC.
 ;
 N DIC,X,Y,DTOUT,DUOUT
 ;
 ; Assign DIC variables and call DIC:
 S DIC=123.5
 S DIC(0)="AEFMQ"
 S DIC("A")="   Select service for Consults:  "
 S DIC("B")="ALL"
 S:$L($G(ORXNOW)) DIC("B")=ORXNOW
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
 K DIC,X,Y,DTOUT,DUOUT                       ; Clean up before exit.
 ;
 Q
 ;
OCCLIM ; Occurrence Limit, for notes.
 ;
 ; Assign DIR variables:
 S DIR("T")=120 ; Two minute maximum timeout for response.
 S DIR("A")="   Enter "_ORXPDIS_" setting for Notes:  "
 S DIR("?")="   Entry must be between 1 and 9,999,999"
 S DIR(0)="NA^1:9999999"                     ; Numerical, required.
 ;
 ; Call tag to get/assign input:
 D INPUT^ORXTABS2
 ;
 I ORXNOW'="^" D
 .W !!,"(NOTE: Setting may be overridden by your TIU Personal Preferences.)",!
 .H 2
 ;
 Q
 ;
