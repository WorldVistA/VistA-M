SPNFEDT2 ;HISC/DAD-FIM EDIT UTILITIES ;8/28/96  12:44
 ;;2.0;Spinal Cord Dysfunction;**12,19**;01/02/1997
 ;
SCORE(SPNFD0) ; *** Display FIM scores
 ; SPNFD0 = IEN in the Outcomes file (#154.1)
 N SPNFTEXT,SPNFTYPE,SPNFUNDL,X
 S SPNFTYPE=$P($G(^SPNL(154.1,SPNFD0,0)),U,2)
 S SPNFTEXT(1)="(Computed from incomplete data)"
 S SPNFTEXT(2)="(No data or invalid data found)"
 S SPNFUNDL=$TR($J("",79)," ","=")
 W !!,SPNFUNDL
 I SPNFTYPE=2 D
 . W !?3,"Motor FIM Score:" S X=$$EN1^SPNFUTL0(SPNFD0)
 . W ?38,$S(X:$J(+X,6,1),1:$J(X,6))
 . W:X["*" "*",?48,SPNFTEXT(1) W:X["ERROR" ?48,SPNFTEXT(2)
 . W !?3,"Cognitive FIM Score:" S X=$$EN2^SPNFUTL0(SPNFD0)
 . W ?38,$S(X:$J(+X,6,1),1:$J(X,6))
 . W:X["*" "*",?48,SPNFTEXT(1) W:X["ERROR" ?48,SPNFTEXT(2)
 . W !?3,"Total FIM Score:" S X=$$EN3^SPNFUTL0(SPNFD0)
 . W ?38,$S(X:$J(+X,6,1),1:$J(X,6))
 . W:X["*" "*",?48,SPNFTEXT(1) W:X["ERROR" ?48,SPNFTEXT(2)
 . Q
 I SPNFTYPE=1 D
 . S X=$$EN3^SPNFUTL0(SPNFD0)
 . W !,"Self Report of Function total score: ",X
 . W:X["*" " ",SPNFTEXT(1) W:X["ERROR" " ",SPNFTEXT(2)
 . Q
 I "^1^2^"'[(U_SPNFTYPE_U) D
 . W !?3,"ERROR, unknown record type: '",SPNFTYPE,"'"
 . Q
 W !,SPNFUNDL,!
 H 2
 Q
 ;
FIND(SPNFTYPE,SPNFDFN) ; *** Find patient record
 ;  SPNFTYPE = FIM type
 ;  SPNFDFN  = Patient file (#2) IEN
 ;
 ; Returns:  IEN ^ Flag  ( 0^-1  or  IEN^0  or  0^1 )
 ;  IEN  = If the patient SPNFDFN has only one record of FIM type
 ;         SPNFTYPE then return the IEN of that record SPNFD0.
 ;         Else if the patient has no records, or multiple records
 ;         return IEN = 0
 ;  Flag = -1 No records for this patient
 ;          0 One record for this patient
 ;         +1 Number of records for this patient
 ;
 N SPNFD0,SPNFDATE,SPNFNUMB
 S (SPNFD0(0),SPNFDATE,SPNFNUMB)=0
 F  S SPNFDATE=$O(^SPNL(154.1,"AA",SPNFTYPE,SPNFDFN,SPNFDATE)) Q:SPNFDATE'>0  D
 . S SPNFD0=0
 . F  S SPNFD0=$O(^SPNL(154.1,"AA",SPNFTYPE,SPNFDFN,SPNFDATE,SPNFD0)) Q:SPNFD0'>0  D
 .. S SPNFNUMB=SPNFNUMB+1 I SPNFD0(0)'>0 S SPNFD0(0)=SPNFD0
 .. Q
 . Q
 S SPNFNUMB=$S(SPNFNUMB=0:-1,SPNFNUMB=1:0,1:SPNFNUMB)
 I SPNFNUMB S SPNFD0(0)=0
 Q SPNFD0(0)_U_SPNFNUMB
