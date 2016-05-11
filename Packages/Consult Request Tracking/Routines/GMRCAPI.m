GMRCAPI ;SLC/MKB,ASMR/BL -- Consult APIs ; 10/16/15 1:36pm
 ;;3.0;CONSULT/REQUEST TRACKING;**80**;DEC 27, 1997;Build 42
 ;Per VA directive #6402, this routine should not be modified.
 ;Use of this routine is controlled by IA #6082
 ;
GET(GMRCAR,GMRCDA,GMRCMED)  ;return basic data & list of linked results
 ; Input:
 ;  GMRCAR - array to return list, passed by reference
 ;  GMRCDA - ien from file 123
 ;  GMRCMED- 1 = include Medicine pkg results; 0 = only TIU docs
 ;
 ; Output:
 ;  GMRCAR - array in format:
 ;       GMRCAR(0)    = zero node of record
 ;       GMRCAR(1)    = CP procedure name
 ;       GMRCAR(20)   = Reason for Request (wp)
 ;       GMRCAR(30)   = Prov Dx
 ;       GMRCAR(30.1) = Prov Dx codes
 ;       GMRCAR(50,n) = "ien;global ref," e.g. 5;TIU(8925, or 3;MCAR(691,
 ;
 I '$D(^GMR(123,GMRCDA,0)) Q
 N X,P,RES,CNT
 S GMRCAR(0)=^GMR(123,GMRCDA,0)
 S $P(GMRCAR(0),U,20)="" ;return TIU note in 50 list
 ; resolve GMRC file pointers to external format
 S X=$P(GMRCAR(0),U,5) S:X $P(GMRCAR(0),U,5)=$P($G(^GMR(123.5,X,0)),U)
 S X=$P(GMRCAR(0),U,8) I X,X["123.3" S $P(GMRCAR(0),U,8)=$P($G(^GMR(123.3,+X,0)),U)
 F P=9,10 S X=$P(GMRCAR(0),U,P) I X S $P(GMRCAR(0),U,P)=$$GET1^DIQ(101,X_",",1)
 S X=$P(GMRCAR(0),U,12) S:X $P(GMRCAR(0),U,12)=$P($G(^ORD(100.01,X,0)),U)
 S X=$P(GMRCAR(0),U,13) S:X $P(GMRCAR(0),U,13)=$P($G(^GMR(123.1,X,0)),U)
 ;
 S X=$G(^GMR(123,GMRCDA,1)) I X S GMRCAR(1)=$$EXTERNAL^DILFD(123,1.01,,X)
 I $D(^GMR(123,GMRCDA,20)) M GMRCAR(20)=^(20)
 F X=30,30.1 I $L($G(^GMR(123,GMRCDA,X))) S GMRCAR(X)=^(X) ;Prov Dx
 S RES="",CNT=1 F  S RES=$O(^GMR(123,GMRCDA,50,"B",RES)) Q:RES=""  D
 . I '$G(GMRCMED) Q:RES'["TIU(8925"
 . S GMRCAR(50,CNT)=RES
 . I RES["MCAR" D
 .. N ARR,STR
 .. D MEDLKUP^MCARUTL3(.ARR,+$P(RES,"MCAR(",2),+RES)
 .. I '+ARR K GMRCAR(50,CNT) Q
 .. S STR=$P(ARR,U,9)_U_$P(ARR,U,6)_$S($P(ARR,U,10):"^^^^^^^^1",1:"")
 .. ;  procedure name ^ date.time ^^^^^^^^ 1=has image(s)
 .. S GMRCAR(50,CNT)=GMRCAR(50,CNT)_U_STR
 . S CNT=CNT+1
 Q
 ;
IFC(GMRCDA) ;return IFC information
 ; Input:
 ;  GMRCDA - ien from file 123
 ;
 ; Output:
 ;  IFC fields as a string with these pieces:
 ;  1 - IFC REMOTE SERVICE NAME (#.131)
 ;  2 - REMOTE REQUESTOR PHONE (#.132)
 ;  3 - REMOTE REQUESTOR DIG PAGER (#.133)
 ;  5 - IFC ROLE (#.125)
 ;  6 - REMOTE ORDERING PROVIDER (#.126)
 ;  7 - REMOTE CONSULT FILE ENTRY (#.06)
 ;  8 - ROUTING FACILITY (#.07)
 ;
 I '$D(^GMR(123,GMRCDA,0)) Q ""
 N X0,X12,Y
 S X0=$G(^GMR(123,GMRCDA,0)),X12=$G(^(12)),Y=$G(^(13))
 S $P(Y,U,5,6)=$P(X12,U,5,6)
 S $P(Y,U,7,8)=$P(X0,U,22,23)
 Q Y
 ;
ACT(GMRCAR,GMRCDA) ;return Activity data
 ; Input:
 ;  GMRCAR - array to return list, passed by reference
 ;  GMRCDA - ien from file 123
 ;
 ; Output:
 ;  GMRCAR - array in format:
 ;       GMRCAR(n,0) = zero node of record
 ;       GMRCAR(n,1) = comment (wp)
 ;       GMRCAR(n,2) = two node of record
 ;       GMRCAR(n,3) = three node of record
 ;
 I '$D(^GMR(123,GMRCDA,0)) Q
 N I,X0,X
 S I=0 F  S I=$O(^GMR(123,GMRCDA,40,I)) Q:I<1  S X0=$G(^(I,0)) D
 . ; resolve GMRC file pointers to external format
 . S X=$P(X0,U,2) S:X $P(X0,U,2)=$P($G(^GMR(123.1,X,0)),U)
 . S X=$P(X0,U,6) S:X $P(X0,U,6)=$P($G(^GMR(123.5,X,0)),U)
 . S GMRCAR(I,0)=X0
 . I $D(^GMR(123,GMRCDA,40,I,1)) M GMRCAR(I,1)=^(1)
 . I $D(^GMR(123,GMRCDA,40,I,2)) S GMRCAR(I,2)=^(2)
 . I $D(^GMR(123,GMRCDA,40,I,3)) S GMRCAR(I,3)=^(3)
 Q
