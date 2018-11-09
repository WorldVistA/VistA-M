IBCEF12 ;EDE/JWS - OUTPUT FORMATTER SPECIFIC DENTAL FUNCTIONS ;30-JAN-96
 ;;2.0;INTEGRATED BILLING;**592**;21-MAR-94;Build 58
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;JWS;IB*2.0*592;US131
TNUM(IBIFN) ; Extract code for 364.5 field 383 N-TOOTH NUMBER
 N IB,IB1
 K ^TMP("IBXSAVE",$J,"TO")
 ;IA# 3820
 S IB=0 F  S IB=$O(^DGCR(399,IBIFN,"DEN1",IB)) Q:'IB  S IB1=^(IB,0),^TMP("IBXSAVE",$J,"TO",IBIFN,IB)=IB1_U_"JP"
 Q
 ;
DEN ; Output formatter Format Code for file DEN, field 2
 ;JWS;IB*2.0*592;US131
 N A,Z,Q,IBZ K IBXSAVE("OUTPT")
 D SET1^IBCEF1(IBXIEN,.A,.IBZ,.IBXDATA,.IBXNOREQ)
 S (Q,Z)=0  ;,Q=$G(@A)
 F  S Z=$O(IBZ(Z)) S:'Z @A=Q Q:'Z  M IBXSAVE("OUTPT",Z)=IBZ(Z) S Q=Q+1,IBXDATA(Z)=Q D:Z>1 ID^IBCEF2(Z,"DEN ") D SVITM^IBCEF2(.IBXSAVE,Z)
 Q
 ;
DEN1 ; Output formatter Format Code for file DEN1, field 2
 ;JWS;IB*2.0*592;US131
 N A,Z,Q,IBZ K IBXSAVE("OUTPT")
 D SET1^IBCEF1(IBXIEN,.A,.IBZ,.IBXDATA,.IBXNOREQ)
 S (Q,Z)=0  ;,Q=$G(@A)
 F  S Z=$O(IBZ(Z)) S:'Z @A=Q Q:'Z  M IBXSAVE("OUTPT",Z)=IBZ(Z) S Q=Q+1,IBXDATA(Z)=Q D:Z>1 ID^IBCEF2(Z,"DEN1") D SVITM^IBCEF2(.IBXSAVE,Z)
 Q
 ;
DEN2 ; Output formatter Format Code for file DEN2, fields 2
 ;JWS;IB*2.0*592;US131
 N A,Z,Z1,CT
 D SET1^IBCEF1(IBXIEN,.A,.IBZ,.IBXDATA,.IBXNOREQ)
 S (CT,Z)=0  ;,Q=$G(@A)
 F  S Z=$O(IBZ(Z)) Q:'Z  D
 . S Z1=0 F  S Z1=$O(IBXSAVE("OUTPT",Z,"DEN1",Z1)) Q:'Z1  D  I CT=1,$P($G(IBXSAVE("OUTPT",Z)),U,9)'=1 Q
 .. S CT=CT+1 D ID^IBCEF2(CT,"DEN2")
 .. S IBXDATA(CT)=Z
 .. D SETGBL^IBCEFG(IBXPG,CT,2,Z,.IBXSIZE)
 K IBXDATA
 Q
 ;
DEN23 ; Output formatter format code for file DEN2, field 3 (8,186.2,1,3)
 ;JWS;IB*2.0*592;US131
 N Z,Z0,CT
 S (CT,Z)=0
 F  S Z=$O(IBXSAVE("OUTPT",Z)) Q:'Z  D
 . S Z0=0 F  S Z0=$O(IBXSAVE("OUTPT",Z,"DEN1",Z0)) Q:'Z0  D
 .. S CT=CT+1
 .. S IBXDATA(CT)="JP"
 .. D SETGBL^IBCEFG(IBXPG,CT,3,"JP",.IBXSIZE)
 K IBXDATA
 Q
 ;
DEN24 ; Output formatter Format Code for file DEN2, field 4
 ;JWS;IB*2.0*592;US131
 N Z,ZO,CT K IBXSAVE("DONE")
 S (CT,Z)=0
 F  S Z=$O(IBXSAVE("OUTPT",Z)) Q:'Z  D
 . S Z0=0 F  S Z0=$O(IBXSAVE("OUTPT",Z,"DEN1",Z0)) Q:'Z0  D
 .. S CT=CT+1
 .. I $D(IBXSAVE("DONE",Z,Z0)) Q
 .. S IBXSAVE("DONE",Z,Z0)=""
 .. ;IA# 2056
 .. S IBXDATA(CT)=$$GET1^DIQ(356.022,$P(IBXSAVE("OUTPT",Z,"DEN1",Z0,0),U),.01)
 .. D SETGBL^IBCEFG(IBXPG,CT,4,IBXDATA(CT),.IBXSIZE)
 K IBXDATA
 Q
 ;
DEN25 ; Output formatter Format Code for file DEN2, field 5
 ;JWS;IB*2.0*592;US131
 N Z,ZO,CT K IBXSAVE("DONE")
 S (CT,Z)=0
 F  S Z=$O(IBXSAVE("OUTPT",Z)) Q:'Z  D
 . S Z0=0 F  S Z0=$O(IBXSAVE("OUTPT",Z,"DEN1",Z0)) Q:'Z0  D
 .. S CT=CT+1
 .. I $D(IBXSAVE("DONE",Z,Z0)) Q
 .. S IBXSAVE("DONE",Z,Z0)=""
 .. S IBXDATA(CT)=$P(IBXSAVE("OUTPT",Z,"DEN1",Z0,0),U,2)
 .. D SETGBL^IBCEFG(IBXPG,CT,5,IBXDATA(CT),.IBXSIZE)
 K IBXDATA
 Q
 ;
DEN26 ; Output formatter Format Code for file DEN2, field 6
 ;JWS;IB*2.0*592;US131
 N Z,ZO,CT K IBXSAVE("DONE")
 S (CT,Z)=0
 F  S Z=$O(IBXSAVE("OUTPT",Z)) Q:'Z  D
 . S Z0=0 F  S Z0=$O(IBXSAVE("OUTPT",Z,"DEN1",Z0)) Q:'Z0  D
 .. S CT=CT+1
 .. I $D(IBXSAVE("DONE",Z,Z0)) Q
 .. S IBXSAVE("DONE",Z,Z0)=""
 .. S IBXDATA(CT)=$P(IBXSAVE("OUTPT",Z,"DEN1",Z0,0),U,3)
 .. D SETGBL^IBCEFG(IBXPG,CT,6,IBXDATA(CT),.IBXSIZE)
 K IBXDATA
 Q
 ;
DEN27 ; Output formatter Format Code for file DEN2, field 7
 ;JWS;IB*2.0*592;US131
 N Z,ZO,CT K IBXSAVE("DONE")
 S (CT,Z)=0
 F  S Z=$O(IBXSAVE("OUTPT",Z)) Q:'Z  D
 . S Z0=0 F  S Z0=$O(IBXSAVE("OUTPT",Z,"DEN1",Z0)) Q:'Z0  D
 .. S CT=CT+1
 .. I $D(IBXSAVE("DONE",Z,Z0)) Q
 .. S IBXSAVE("DONE",Z,Z0)=""
 .. S IBXDATA(CT)=$P(IBXSAVE("OUTPT",Z,"DEN1",Z0,0),U,4)
 .. D SETGBL^IBCEFG(IBXPG,CT,7,IBXDATA(CT),.IBXSIZE)
 K IBXDATA
 Q
 ;
DEN28 ; Output formatter Format Code for file DEN2, field 8
 ;JWS;IB*2.0*592;US131
 N Z,ZO,CT K IBXSAVE("DONE")
 S (CT,Z)=0
 F  S Z=$O(IBXSAVE("OUTPT",Z)) Q:'Z  D
 . S Z0=0 F  S Z0=$O(IBXSAVE("OUTPT",Z,"DEN1",Z0)) Q:'Z0  D
 .. S CT=CT+1
 .. I $D(IBXSAVE("DONE",Z,Z0)) Q
 .. S IBXSAVE("DONE",Z,Z0)=""
 .. S IBXDATA(CT)=$P(IBXSAVE("OUTPT",Z,"DEN1",Z0,0),U,5)
 .. D SETGBL^IBCEFG(IBXPG,CT,8,IBXDATA(CT),.IBXSIZE)
 K IBXDATA
 Q
 ;
DEN29 ; Output formatter Format Code for file DEN2, field 9
 ;JWS;IB*2.0*592;US131
 N Z,ZO,CT K IBXSAVE("DONE")
 S (CT,Z)=0
 F  S Z=$O(IBXSAVE("OUTPT",Z)) Q:'Z  D
 . S Z0=0 F  S Z0=$O(IBXSAVE("OUTPT",Z,"DEN1",Z0)) Q:'Z0  D
 .. S CT=CT+1
 .. I $D(IBXSAVE("DONE",Z,Z0)) Q
 .. S IBXSAVE("DONE",Z,Z0)=""
 .. S IBXDATA(CT)=$P(IBXSAVE("OUTPT",Z,"DEN1",Z0,0),U,6)
 .. D SETGBL^IBCEFG(IBXPG,CT,9,IBXDATA(CT),.IBXSIZE)
 K IBXDATA
 Q
 ;
TRANS ; Output formatter Format Code for file DN1, field 6
 ;JWS;IB*2.0*592;US131; IA# 2056
 I $$GET1^DIQ(399,IBXIEN_",",93)'="",$$GET1^DIQ(399,IBXIEN_",",94)'="" K IBXDATA
 S IBXDATA=$E($G(IBXDATA)) I IBXDATA'="Y" K IBXDATA
 Q
 ;
SRVDT ; Output formatter Format Code for file DEN, field 4 Service date
 ;JWS;IB*2.0*592;US131
 ;;S IBXNOREQ=$$NFT^IBCEF1(7,IBXIEN)
 N Z,IBCDT
 S IBCDT=$$GET1^DIQ(399,IBXIEN_",",.03,"I"),IBCDT=$$FMTHL7^XLFDT(IBCDT)
 S Z=0
 F  S Z=$O(IBXSAVE("OUTPT",Z)) Q:'Z  D
 . I $P($G(IBXSAVE("OUTPT",Z,"DEN")),U,11)'="" Q  ;treatment start date
 . I $P($G(IBXSAVE("OUTPT",Z,"DEN")),U,12)'="" Q  ;treatment completion date
 . I $P($G(IBXSAVE("OUTPT",Z)),U)=IBCDT Q  ;if procedure date is same as event date, don't send
 . I $P($G(IBXSAVE("OUTPT",Z)),U)'="" S IBXDATA(Z)=$P(IBXSAVE("OUTPT",Z),U)
 . Q
 Q
 ;
SRVDTQ ; Output formatter Format Code for file DEN, field 3 Date/Time Qualifier
 ;JWS;IB*2.0*592;US131
 N Z,IBCDT
 S IBCDT=$$GET1^DIQ(399,IBXIEN_",",.03,"I"),IBCDT=$$FMTHL7^XLFDT(IBCDT)
 S Z=0
 F  S Z=$O(IBXSAVE("OUTPT",Z)) Q:'Z  D
 . I $P($G(IBXSAVE("OUTPT",Z,"DEN")),U,11)'="" Q  ;treatment start date
 . I $P($G(IBXSAVE("OUTPT",Z,"DEN")),U,12)'="" Q  ;treatment completion date
 . I $P($G(IBXSAVE("OUTPT",Z)),U)=IBCDT Q  ;if procedure date is same as event date, don't send
 . I $P($G(IBXSAVE("OUTPT",Z)),U)'="" S IBXDATA(Z)=472
 Q
 ;
PROC ; Output formatter Format Code for file DEN1, field 3 Procedure Count
 N Z S Z=0
 F  S Z=$O(IBXSAVE("OUTPT",Z)) Q:'Z  D
 . S IBXDATA(Z)=$P($G(IBXSAVE("OUTPT",Z)),U,9)
 . I IBXDATA(Z)=1 S IBXDATA(Z)=""  ;number of units (default=1, therefore must be blank if =1)
 . Q
 Q
 ;
POS ; Output formatter Format Code for File DEN, field 13 Place of Service
 N IBZ,W,DEFPOS,POS,HOF,Z
 ;perform logic to obtain CL1-33 Place of Service (Claim Level) to compare to line level
 D F^IBCEF("N-HCFA SERVICE LINE CALLABLE","IBZ",,IBXIEN)
 S DEFPOS="",W=0
 F  S W=$O(IBZ(W)) Q:'W  S POS=$P($G(IBZ(W)),U,3),HOF=(POS=11!(POS=12)) S:DEFPOS=""!HOF DEFPOS=POS Q:HOF
 ;
 S Z=0 F  S Z=$O(IBXSAVE("OUTPT",Z)) Q:'Z  I $P(IBXSAVE("OUTPT",Z),U,3)'="",$P(IBXSAVE("OUTPT",Z),U,3)'=DEFPOS S IBXDATA(Z)=$P(IBXSAVE("OUTPT",Z),U,3)
 Q
 ;
OIT ; Output formatter Format Code for File OI1, field 8 Other Insurance Type
 I $$FT^IBCEF(IBXIEN)'=7 Q
 I A'=3 S IBXDATA(Z)=""
 Q
 ;
CHK(IBIEN) ;DIC("S") screen for OCCURRENCE CODE 399.041, .01 field
 N IBCHK
 I $D(IBIFN) S IBIEN=IBIFN
 I $$FT^IBCEF(IBIEN)'=7 Q 1
 S IBCHK=$P($G(^DGCR(399.1,Y,0)),"^",2)
 I $F(",01,02,03,04,05,",","_IBCHK_",") Q 1
 Q 0
 ;
