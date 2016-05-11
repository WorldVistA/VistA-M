HMPXGSD ; ASMR/hrubovcak - Scheduling data retrieval ;Nov 20, 2015 01:49:50
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ; DE2818, code below adapted from CLINLOC^ORWU
CLINLOC(RSLT,FROM,DIR) ; return list of clinics from HOSPITAL LOCATION file (#44)
 ; all 3 arguments required
 ; RSLT=returned list (passed by reference), FROM=text to $ORDER from, DIR=$ORDER direction
 ; RSLT(counter) = IEN^location name
 N I,IEN,LOCNM  ; counter, internal entry number, location name
 S I=0,LOCNM=$G(FROM)
 F  S LOCNM=$O(^SC("B",LOCNM),DIR) Q:LOCNM=""  D  ; ICR 10040
 . S IEN="" F  S IEN=$O(^SC("B",LOCNM,IEN),DIR) Q:'IEN  D
 ..  Q:'($P($G(^SC(IEN,0)),U,3)="C")  ; check (#2) TYPE [3S], must be clinic
 ..  Q:'$$ACTLOC(IEN)  ; must be active
 ..  S I=I+1,RSLT(I)=IEN_"^"_LOCNM
 ;
 Q
 ;
 ; DE2818, code below adapted from ACTLOC^ORWU
ACTLOC(LOC) ; Boolean function, TRUE if active hospital location
 ; LOC - IEN in HOSPITAL LOCATION file, ICR 10040
 ; IND - the "I" node, ^SC(D0,I) = (#2505) INACTIVATE DATE [1D] ^ (#2506) REACTIVATE DATE [2D] ^
 ; D0, X - used by WIN^DGPMDDCF
 N D0,IND,X
 Q:+$G(^SC(LOC,"OOS")) 0  ; (#50.01) OCCASION OF SERVICE CLINIC?, screen entry
 S D0=+$G(^SC(LOC,42)) I D0 D WIN^DGPMDDCF Q 'X  ; check out-of-service wards, ICR 1246
 S IND=$G(^SC(LOC,"I")) Q:'IND 1  ; INACTIVATE DATE not found
 I DT>$P(IND,U)&($P(IND,U,2)=""!(DT<$P(IND,U,2))) Q 0  ; check REACTIVATE DATE
 Q 1  ; active
 ;
