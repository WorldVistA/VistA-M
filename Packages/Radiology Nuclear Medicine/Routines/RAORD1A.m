RAORD1A ;HISC/FPT-Request an Exam ;05/05/09  07:45
 ;;5.0;Radiology/Nuclear Medicine;**1,86,99**;Mar 16, 1998;Build 5
 ;
 ;Call to WIN^DGPMDDCF (Supported IA #1246) from the SCREENW function
 ;Supported IA #10039 reference to ^DIC(42
 ;Supported IA #10040 reference to ^SC
 ;Supported IA #10061 reference to ^VADPT
 ;Supported IA #10103 reference to ^XLFDT
 ;Supported IA #2056 reference to ^DIQ
 ;
SCREEN(RAINPAT,RACPRS27) ; screen for active clinics/wards
 ; This code is also called from RAORD1 (screen for the Patient Location
 ; prompt which is a pointer to the HOSPITAL LOCATION (#44) file.)
 ; We want to EXCLUDE from our selection the following types of
 ; hospital locations:
 ;
 ;  1) Occasion of Service (OOS) locations (fld: 50.01) 'OOS' node
 ;  2) File Area ("F") or Imaging ("I") locations (fld: 2)
 ;  3) Inactivate Date (fld: 2505) 'I' node
 ;
 ; input: RAINPAT=1 if the patient is an inpatient located on a ward, else 0.
 ;        RACPRS27=1 if the environment is running CPRS GUI v27, else 0.
 ;
 Q:$D(^SC(+Y,"OOS"))#2 0 ; #1
 N RA44 S RA44=$G(^SC(+Y,0)),RA44(42)=$P($G(^SC(+Y,42)),U)
 Q:"^F^I^"[(U_$P(RA44,U,3)_U) 0 ; #2
 ;
 ; if the hospital location is defined as a ward set RAWARD to 1, else 0
 N RAWARD S RAWARD=0
 ;check the pointer to the WARD LOCATION file.
 I RA44(42)>0 D  Q:RAWARD=-1 0
 .;Error; the HOSPITAL LOCATION cannot be of TYPE 'Clinic' & point to a ward
 .I $P(RA44,U,3)="C" S RAWARD=-1 Q
 .;Error; bad pointers between files 42 & 44
 .I $P($G(^DIC(42,RA44(42),44)),U)'=+Y S RAWARD=-1 Q
 .;ok, set ward flag...
 .S RAWARD=1
 .Q
 ;
 ; 1) if the hospital location is a ward check if we should screen by ward
 ; 2) the hosp location=ward, facility is running v26, and we have an
 ;    outpatient quit zero (default of the $S)
 I RAWARD  Q $S(RACPRS27!RAINPAT:$$SCREENW(+Y),1:0)
 ;
 ; if the hospital location is a clinic, we have an inpatient, and the
 ; facility is not running CPRS v27 return 0
 I 'RACPRS27,(RAINPAT) Q 0
 ;
 ; Check INACTIVATE DATE against REACTIVATE DATE
 ; inactivate date = reactivate date (allow)
 ; inactivate date > reactivate date (disallow)
 ; inactivate date < reactivate date (allow)
 ;
 N RASCA,RASCI,RASCINDE S RASCINDE=$G(^SC(+Y,"I"))
 S RASCI=+$P(RASCINDE,U),RASCA=+$P(RASCINDE,U,2)
 ;
 Q $S(RASCI'>0:1,RASCI>DT:1,1:RASCI'>RASCA)
 ;
SCREENW(Y) ; check the out-of-service field of the WARD LOCATION (#42) record.
 ;input Y: ien of the HOSPITAL LOCATION record
 ; RAWHEN: DATE DESIRED (Not guaranteed) (file: 75.1, fld: 21) optional
 ;output : '0' if not valid, else '1' if valid 
 N D0,DGPMOS,X
 S D0=+$G(^SC(Y,42))
 Q:'D0 0
 Q:'($D(^DIC(42,D0,0))#2) 0
 ;
 ;WIN^DGPMDDCF (Supported IA #1246) Is the ward active?
 ; Input
 ;  D0 "Dee zero" (req): IEN of WARD LOCATION file.  
 ;  DGPMOS (opt): defaults to DT. Is the ward in service on this date?  
 ; Output
 ;  X: 1 if out of service, 0 if in service, or -1 if input variables
 ;     not defined properly. Be careful; note the difference in their
 ;     boolean definition ('0'=success) and ours ('0'=failure)
 ;
 S:$D(RAWHEN)#2 DGPMOS=$P(RAWHEN,".",1)
 D WIN^DGPMDDCF
 Q 'X  ;alter 'X' (the WIN^DGPMDDCF output value) to meet our ($$SCREENW) output definition
 ;
PREG(RADFN,RADT) ; Subroutine will display the pregnancy prompt to the
 ; user if the patient is between the ages of 12 - 55 inclusive.
 ; Called from CREATE1^RAORD1.
 ; Input : RADFN - Patient, RADT - Today's date
 ; Output: Patient Pregnant? (yes, no, unknown or no default)
 ;   Note: (may set RAOUT if the user times out or '^' out)
 Q:RASEX'="F" "" ; not a female
 S:RADT="" RADT=$$DT^XLFDT()
 N RADAYS,VADM D DEM^VADPT ; $P(VADM(3),"^") DOB of patient, internal
 S RADAYS=$$FMDIFF^XLFDT(RADT,$P(VADM(3),"^"),3)   ;P#99 correct/replace variable RAWHEN to RADT
 Q:((RADAYS\365.25)<12) "" ; too young
 Q:((RADAYS\365.25)>55) "" ; too old
 ;if RA ADDEXAM option, display and copy pregnany status from previous active order
 I $D(RAOPT("ADDEXAM")) W !,"PREGNANT AT TIME OF ORDER ENTRY: ",$$GET1^DIQ(75.1,$$PRACTO^RAUTL8(RADFN),13) Q $$GET1^DIQ(75.1,$$PRACTO^RAUTL8(RADFN),13,"I")
 N DIR,DIROUT,DIRUT,DUOUT,DTOUT S DIR(0)="75.1,13",DIR("A")="PREGNANT AT TIME OF ORDER ENTRY" D ^DIR
 S:$D(DIRUT) RAOUT="^" Q:$D(RAOUT) ""
 Q $P(Y,"^")
 ;
INIMOD(Y) ; check if the user has selected the same
 ; modifier more than once when the order is requested.
 ; The 'Request an Exam' option.  Called from MODS^RAORD1
 ; Input: 'Y' the name of the procedure modifier
 ; Output: 'X' if the user has not entered this modifier in
 ;             the past return one (1).  Else return zero (0).
 Q:'$D(RAMOD) 1 ; must allow the selection of the first modifier
 ; after this, it is assumed that the RAMOD array is defined.
 N RACNT,X S X=1,RACNT=99999
 F  S RACNT=$O(RAMOD(RACNT),-1) Q:RACNT=""!(X=0)  S:RAMOD(RACNT)=Y X=0
 Q X
 ;
