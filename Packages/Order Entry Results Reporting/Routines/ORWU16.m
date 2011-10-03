ORWU16 ; SLC/KCM - General Utilites for Windows Calls 16bit
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ;
USERINFO(Y) ; procedure
 ; return DUZ^NAME^SIGNAUTH^ISPROVIDER for the current user
 ; I DUZ=1085 S DUZ=1298           ; CHANGE ID **** DON'T EXPORT ****
 S Y=DUZ_U_$P(^VA(200,DUZ,0),U,1)
 S $P(Y,U,3)=$S($D(^XUSEC("ORES",DUZ)):3,$D(^XUSEC("ORELSE",DUZ)):2,$D(^XUSEC("OREMAS",DUZ)):1,1:0)
 S $P(Y,U,4)=$D(^XUSEC("PROVIDER",DUZ))#10
 Q
VALIDSIG(ESOK,X) ; procedure
 S X=$$DECRYP^XUSRB1(X),ESOK=0
 D HASH^XUSHSHP
 I X=$P($G(^VA(200,+DUZ,20)),U,4) S ESOK=1
 Q
HOSPLOC(Y,DIR,FROM) ; Return a bolus from the HOSPITAL LOCATION file
 ; .Return Array, Direction, Starting Text
 N I,IEN,CNT S CNT=44
 ;
 I DIR=0 D  ; Forward direction
 . F I=1:1:CNT S FROM=$O(^SC("B",FROM)) Q:FROM=""  D
 . . S IEN=$O(^SC("B",FROM,0))
 . . I $$ACTLOC(IEN) S Y(I)=IEN_"^"_FROM
 . I $G(Y(CNT))="" S Y(I)=""
 ;
 I DIR=1 D  ; Reverse direction
 . F I=1:1:CNT S FROM=$O(^SC("B",FROM),-1) Q:FROM=""  D
 . . S IEN=$O(^SC("B",FROM,0))
 . . I $$ACTLOC(IEN) S Y(I)=IEN_"^"_FROM
 Q
ACTLOC(LOC) ; Function
 ; Returns 1 (true) if active hospital location, otherwise 0 (false)
 N D0,X I +$G(^SC(LOC,"OOS")) Q 0                ; screen out OOS entry
 S D0=+$G(^SC(LOC,42)) I D0 D WIN^DGPMDDCF Q 'X  ; chk out of svc wards
 S X=$G(^SC(LOC,"I")) I +X=0 Q 1                 ; no inactivate date
 I DT>$P(X,U)&($P(X,U,2)=""!(DT<$P(X,U,2))) Q 0  ; chk reactivate date
 Q 1                                             ; must still be active
 ;
NEWPERS(Y,DIR,FROM,KEY) ; Return a bolus from the NEW PERSON file
 ; .Return Array, Direction, Starting Text
 N I,IEN,CNT S CNT=44,KEY=$G(KEY)
 ;
 I DIR=0 D  ; Forward direction
 . F I=1:1:CNT S FROM=$O(^VA(200,"B",FROM)) Q:FROM=""  D
 . . S IEN=$O(^VA(200,"B",FROM,0)) I $L(KEY),'$D(^XUSEC(KEY,IEN)) Q
 . . S Y(I)=IEN_"^"_FROM
 . I $G(Y(CNT))="" S Y(I)=""
 ;
 I DIR=1 D  ; Reverse direction
 . F I=1:1:CNT S FROM=$O(^VA(200,"B",FROM),-1) Q:FROM=""  D
 . . S IEN=$O(^VA(200,"B",FROM,0)) I $L(KEY),'$D(^XUSEC(KEY,IEN)) Q
 . . S Y(I)=IEN_"^"_FROM
 Q
DEVICE(Y) ; Return a list of devices
 S I=0,DEV=""
 F  S DEV=$O(^%ZIS(1,"B",DEV)) Q:DEV=""  S IEN=$O(^(DEV,0)) D
 . I $E($G(^%ZIS(2,+$G(^%ZIS(1,IEN,"SUBTYPE")),0)))'="P" Q
 . I $P($G(^%ZIS(1,IEN,0)),U,12)=2 Q
 . S I=I+1,Y(I)=IEN_";"_$P(^%ZIS(1,IEN,0),U)_U_DEV_U_$P($G(^(1)),U)_U_$P($G(^(90)),U)_U_$P(^(91),U)_U_$P(^(91),U,3)
 Q
VALDT(Y,X,%DT) ; Validate date/time entry
 S:'$D(%DT) %DT="TX" D ^%DT
 Q
 ;
URGENCY(Y) ; -- retrieve set values from dd for discharge summary urgency
 N ORDD,I,X
 D FIELD^DID(8925,.09,"","POINTER","ORDD")
 F I=1:1 S X=$P(ORDD("POINTER"),";",I) Q:X=""   S Y(I)=$TR(X,":","^")
 Q
 ;
