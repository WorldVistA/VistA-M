DGUTL3 ;ALB/MTC,CKN - ELIGIBILITY UTILITIES ; 10/4/05 12:22pm
 ;;5.3;Registration;**114,506,653**;Aug 13, 1993;Build 2
 ;
 Q
ELIG(DFN,SOURCE,DEFAULT) ;-- This function will prompt for the eligibility for a patient. If
 ;   only one eligibility then it will be returned without prompting.
 ;
 ;   INPUT:  DFN - Patient
 ;           SOURCE - (1:PTF,2:ADMISSION,3:TRANSFER)
 ;           DEFALUT - IEN from file 8.1
 ;  OUTPUT:  IEN of file 8^Name
 ;
 ;
 N RESULT,VAEL,ALLEL,EMP,X,DGDEF,Y
 ;
 ;-- get eligility codes
 D GETEL(DFN)
 S DGDEF=$P($G(^DIC(8,+$G(DEFAULT),0)),U)
 I DGDEF'="" S DGDEF=DEFAULT_U_DGDEF
 ;
 S RESULT="",EMP=$P(VAEL(1),U,2),ALLEL=U_EMP
 I '$D(VAEL) G ELIGQ
 I $D(VAEL(1))=1 S RESULT=VAEL(1) G ELIGQ
 ;-- if no default set default to primary eligibility
 I DGDEF="" S DGDEF=VAEL(1)
 ;
DISP ;-- display choices
 W !,"THIS PATIENT HAS OTHER ENTITLED ELIGIBILITIES:"
 W !?5,$P(VAEL(1),U,2)
 S X="" F  S X=$O(VAEL(1,X)) Q:X'>0  D
 . W !?5,$P(VAEL(1,X),U,2)
 . S ALLEL=ALLEL_U_$P(VAEL(1,X),U,2)
 ;
 ;-- prompt for eligibility codes
 ;
1 W !,"ENTER THE ELIGIBILITY FOR THIS "_$S(SOURCE=1:"MOVEMENT",SOURCE=2:"ADMISSION",SOURCE=3:"TRANSFER",1:"PATIENT")_": "_$P(DGDEF,U,2)_"// "
 R X:DTIME
 ;-- if timeout
 G ELIGQ:'$T
 ;-- if ^
 G ELIGQ:X[U
 ;-- if default (primary) quit
 I X="" S RESULT=DGDEF G ELIGQ
 ;-- find eligibility
 S X=$$UPPER^VALM1(X)
 G DISP:X["?",1:ALLEL'[(U_X)
 ;
 S EMP=X_$P($P(ALLEL,U_X,2),U) W $P($P(ALLEL,U_X,2),U)
 I $P(VAEL(1),U,2)=EMP S RESULT=VAEL(1) G ELIGQ
 S X="" F  S X=$O(VAEL(1,X)) Q:X'>0  D
 . I $P(VAEL(1,X),U,2)=EMP S RESULT=X_U_EMP
 ;
ELIGQ ;
 K VAEL
 Q +RESULT
 ;
GETEL(DFN) ;-- This function will get the eligibilities for the patient
 ;  specified by DFN and return all the active eligibilities in the
 ;  ARRAY specified.
 ;
 ;  INPUT:  DFN - Patient
 ;
 D ELIG^VADPT
 Q
 ;
GETDEL(DFN,START,END) ;-- This function will scan the Eligibility Date
 ; Sensitive file #8.3 for all active eligibilities for a date range.
 ;
 N DGI,DGJ,DGK
 ;
 S DGI=0 F  S DGI=$O(^VAEL(8.3,"AE",DFN,DGI)) Q:DGI=""  D
 . S DGJ=$O(^VAEL(8.3,"AE",DFN,DGI,0)),DGK=^(DGJ)
 . I $P(DGK,U,2) S VAEL(1)=DGI_U_$P($G(^DIC(8,DGI,0)),U)
 . I '$P(DGK,U,2) S VAEL(1,DGI)=DGI_U_$P($G(^DIC(8,DGI,0)),U)
 Q
 ;
ASKPR(DFN) ;-- This function will ask the user for the primary eligibility.
 ;
 N RESULT,VAEL,ALLEL,EMP,X,DGDEF,Y
 ;
 ;-- get eligility codes
 S DEFAULT=$O(^VAEL(8.3,"AP",DFN,0))
 S DGDEF=$P($G(^DIC(8,+$G(DEFAULT),0)),U)
 I DGDEF'="" S DGDEF=DEFAULT_U_DGDEF
 ;
 S RESULT=""
 ;
TRY W !,"PRIMARY ELIGIBILITY CODE: "_$P(DGDEF,U,2)_"// "
 R X:DTIME
 ;-- if timeout
 G PRIMQ:'$T
 ;-- if ^
 G PRIMQ:X[U
 ;-- find eligibility
 S X=$$UPPER^VALM1(X)
 ;
PRIMQ ;
 K VAEL
 Q +RESULT
 ;
BADADR(DFN) ;does this patient have a bad address?
 ;
 Q:'$G(DFN) ""
 Q $P($G(^DPT(DFN,.11)),"^",16)
 ;
DELBAI(DFN) ;delete bad address indicator
 N FDA,IENS
 Q:'$G(DFN)
 S IENS=DFN_",",FDA(2,IENS,.121)="@"
 D FILE^DIE("E","FDA")
 Q
GETSHAD(DFN) ;Get current value of Proj 112/SHAD from Patient file.
 ;   Input:  DFN - Patient ien
 ;  Output: Valid values - 1 (Yes), 0 (No), or null
 ;                    -1 - error
 Q:$G(DFN)="" -1 ;Quit with error if missing input parameter
 Q $P($G(^DPT(DFN,.321)),"^",15)
