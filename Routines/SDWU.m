SDWU ; SLC/KCM - General Utilites for Windows Calls; 2/28/01
 ;;5.3;Scheduling;**262**;Aug 13, 1993
 ;
 Q
ACTLOC(LOC) ; Function: returns TRUE if active hospital location
 N D0,X I +$G(^SC(LOC,"OOS")) Q 0                ; screen out OOS entry
 S D0=+$G(^SC(LOC,42)) I D0 D WIN^DGPMDDCF Q 'X  ; chk out of svc wards
 S X=$G(^SC(LOC,"I")) I +X=0 Q 1                 ; no inactivate date
 I DT>$P(X,U)&($P(X,U,2)=""!(DT<$P(X,U,2))) Q 0  ; chk reactivate date
 Q 1                                             ; must still be active
 ;
CLINLOC(Y,FROM,DIR) ; Return a set of clinics from HOSPITAL LOCATION
 ; .Y=returned list, FROM=text to $O from, DIR=$O direction,
 N I,IEN,CNT S I=0,CNT=44
 F  Q:I'<CNT  S FROM=$O(^SC("B",FROM),DIR) Q:FROM=""  D
 . S IEN="" F  S IEN=$O(^SC("B",FROM,IEN),DIR) Q:'IEN  D
 . . I ($P($G(^SC(IEN,0)),U,3)'="C")!('$$ACTLOC(IEN)) Q
 . . S I=I+1,Y(I)=IEN_"^"_FROM
 Q
INPLOC(Y,FROM,DIR) ;Return a set of wards from HOSPITAL LOCATION
 ; .Y=returned list, FROM=text to $O from, DIR=$O direction,
 N I,IEN,CNT S I=0,CNT=44
 F  Q:I'<CNT  S FROM=$O(^SC("B",FROM),DIR) Q:FROM=""  D
 . S IEN="" F  S IEN=$O(^SC("B",FROM,IEN),DIR) Q:'IEN  D
 . . I ($P($G(^SC(IEN,0)),U,3)'="W")!('$$ACTLOC(IEN)) Q
 . . S I=I+1,Y(I)=IEN_"^"_FROM
 Q
HOSPLOC(Y,FROM,DIR) ; Return a set of locations from HOSPITAL LOCATION
 ; .Y=returned list, FROM=text to $O from, DIR=$O direction,
 N I,IEN,CNT S I=0,CNT=44
 F  Q:I'<CNT  S FROM=$O(^SC("B",FROM),DIR) Q:FROM=""  D
 . S IEN="" F  S IEN=$O(^SC("B",FROM,IEN),DIR) Q:'IEN  D
 . . I '$$ACTLOC(IEN) Q
 . . S I=I+1,Y(I)=IEN_"^"_FROM
 Q
  
