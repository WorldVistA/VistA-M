DGENCLEA ;ALB/JLS - Camp Lejeune Eligibility API - Retrieve Eligibility ;11/28/14 4:25pm
 ;;5.3;Registration;**909**;Aug 13,1993;Build 32
 ;
 ; Business Rules to determine Camp Lejeune Eligibility:
 ;. Person is a Veteran AND
 ;  . Either ("Rule 1") 
 ;    . Has one Military Service Episode (DGMSE) between, and inclusive of, Aug 1, 1953 and Dec 31, 1987 and 
 ;    . The identified DGMSE has a character of discharge other than
 ;      . Dishonorable
 ;      . Other Than Honorable
 ;      . Undesirable
 ;      . Bad Conduct
 ;      . Dishonorable-VA
 ;AND
 ;    . The identified DGMSE is at least 30 days in duration
 ;  . OR ("Rule 2"; perform this check only if "Rule 1" was not met)
 ;    . Has more than one Military Service Episodes (DGMSEs) between, and inclusive of, Aug 1, 1953 and Dec 31, 1987 AND 
 ;    . All of the identified DGMSEs have a character of discharge other than 
 ;      . Dishonorable
 ;      . Other Than Honorable 
 ;      . Undesirable
 ;      . Bad Conduct
 ;      . Dishonorable-VA
 ;AND
 ;    . The sum of two or more of the identified DGMSEs add up to at least 30 days in duration (meaning that it does not have to be consecutive days)
 ;
 ;  Inputs: DFN
 ; Outputs: CLE returns 1 if patient is camp lejeune eligible, returns 0 if not camp lejeune eligible
 ;  0 - CLE "Not Eligible"
 ;  1 - CLE "Eligible"
 ;
CLE(DFN) ;
 K DGMSE
 ; Is patient a veteran VET1 Is the patient an eligible veteran VET
 I '$$VET^DGENPTA(DFN) Q 0
 ; If primary eligibility code exists it must be a Veteran Type Eligibility Code from File 8 
 N DGPRIEL
 S DGPRIEL=$P($G(^DPT(DFN,.36)),U,1)
 I DGPRIEL]"",$P($G(^DIC(8,DGPRIEL,0)),U,5)="N" Q 0
 ; Get DGMSE data from DGMSE sub-file #2.3216 first, if that does not exist get DGMSE data from .32 node
 N DGMSE
 I $D(^DPT(DFN,.3216)) D GETMSE^DGMSEUTL(DFN,.DGMSE)
 I $G(DGMSE)="" S DGMSE=$G(^DPT(DFN,.32))
 I '$D(DGMSE) Q 0
 ; Loop through DGMSE to find at least 1 qualifying DGMSE  (CLE=1)
 N DGENTDT,DGEXITDT,DGTYPE,DGLOOP,DGCLE,DGCLSRDT,X1,X2
 S (DGCLE,DGCLSRDT)=0
 S DGLOOP="" F  S DGLOOP=$O(DGMSE(DGLOOP)) Q:(DGLOOP="")!(DGCLE=1)  D
 . S (DGENTDT,DGEXITDT,DGTYPE,X1,X2)=""
 . S DGENTDT=$$FMTH^XLFDT($P(DGMSE(DGLOOP),"^",1),1),DGEXITDT=$$FMTH^XLFDT($P(DGMSE(DGLOOP),"^",2),1),DGTYPE=$P(DGMSE(DGLOOP),"^",6)
 . ;automatically quit out of this DGMSE if Discharge is 2,4,5,6,8 or null
 . ;File #25 (Dishonorable,Other Than Dishonorable,Undesirable,Bad Conduct,Dishonorable-VA
 . Q:(DGTYPE=2)!(DGTYPE=4)!(DGTYPE=5)!(DGTYPE=6)!(DGTYPE=8)!(DGTYPE="")
 . ;automatically quit out if DGMSE is NOT within date range
 . ;08011953 and 12311987
 . ;$H 41120(subtracted +1 to be 'inclusive') and 53690(added +1 to be 'inclusive')
 . ;FM 2530801 and 2871231
 . Q:(DGENTDT>53690)!(DGEXITDT<41120)   ;if either date is out of CLE date range do not continue (ineligible)
 . I DGENTDT<41120 S DGENTDT=41120  ;only include Entry Dates starting from CLE date range
 . I DGEXITDT>53690 S DGEXITDT=53690    ;only include Exit Dates ending at CLE date range
 . S X1=$$HTFM^XLFDT($G(DGEXITDT)),X2=$$HTFM^XLFDT($G(DGENTDT)) D ^%DTC S DGCLSRDT=DGCLSRDT+(X+1)
 . ;automatically quit out if DGMSE is NOT greater than 30 days
 . Q:DGCLSRDT<30
 . S DGCLE=1
 Q DGCLE
 ;
ADDEDTCL(DFN) ; DG*5.3*909 Enter/Edit Camp Lejeune Indicator
 ;
AECL2 N DGCLIND,DGCLOLD,DGSITE,X,Y
 K DIR S DIR(0)="YO"
 S DIR("A")="CAMP LEJEUNE WATER CONTAMINANT EXPOSURE INDICATED"
 S DGCLOLD=$P($G(^DPT(DFN,.3217)),U,1)
 S DIR("B")=$S(DGCLOLD="Y":"YES",DGCLOLD="N":"NO",1:"")
 K:DIR("B")="" DIR("B")
 S DIR("?",1)="Enter "_$C(34)_"Y"_$C(34)_" if veteran claims need "
 S DIR("?",1)=DIR("?",1)_"for care of conditions related to exposure of"
 S DIR("?",2)=$C(34)_"Water Contamination at Camp Lejeune"_$C(34)
 S DIR("?",2)=DIR("?",2)_". Enter "_$C(34)_"N"_$C(34)_" if veteran "
 S DIR("?",2)=DIR("?",2)_"was not assigned to"
 S DIR("?",3)="Camp Lejeune between August 1, 1953 and December 31, "
 S DIR("?",3)=DIR("?",3)_"1987 or does not claim need"
 S DIR("?",4)="for care of conditions related to exposure of "_$C(34)
 S DIR("?",4)=DIR("?",4)_"Water Contamination at Camp"
 S DIR("?",5)="Lejeune"_$C(34)_"."
 S DIR("?",6)="Choose from:",DIR("?",7)="Y YES",DIR("?",8)="N NO"
 S DIR("?")="Null "_$C(34)_"Blank"_$C(34)
 D ^DIR K DIR
 I X="@" D  G AECL2
 . W !!,"Camp Lejeune indicator cannot be deleted if already "
 . W "indicated.",!,"Enter '^' to exit.",!
 S DGCLIND=$S(Y=1:"Y",Y=0:"N",1:Y)
 Q:DGCLIND="^"  Q:"^Y^N^"'[(U_DGCLIND_U) 
 S DGSITE=$P($$SITE^VASITE,U,3)
 D SAVECL(DFN,DGCLIND,$P($$NOW^XLFDT,".",1),DGSITE,"VAMC")
 Q
 ;
SAVECL(DFN,DGCLIND,DGCLDAT,DGSITE,DGSOURCE) ; DG*5.3*909 Save CL-V info
 ; Check if CL-V Indicator already No or Yes, then use old date.
 N DGCLVREC S DGCLVREC=$G(^DPT(DFN,.3217))
 I "^Y^N^"[(U_$P(DGCLVREC,U)_U),$P(DGCLVREC,U,2)]"" D
 . S DGCLDAT=$P(DGCLVREC,U,2)
 S ^DPT(DFN,.3217)=DGCLIND_U_DGCLDAT_U_DGSITE_U_DGSOURCE
 Q
 ;
SETCLNO ; DG*5.3*909 Set Camp Lejeune to No when no longer CL Eligible
 Q:$P($G(^DPT(DFN,.3217)),U,1)'="Y"
 Q:$G(^DPT(DFN,.32171))=1    ; if Locked then don't chg YES to NO
 N DGCLE S DGCLE=$$CLE(DFN) Q:DGCLE
 D SAVECL(DFN,"N",$P($$NOW^XLFDT,".",1),$P($$SITE^VASITE,U,3),"VAMC")
 D AUTOUPD^DGENA2(DFN)
 Q
 ;
