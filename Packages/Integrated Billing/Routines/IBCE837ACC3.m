IBCE837ACC3 ;EDE/JWS - ACC consume X12 claim data ;
 ;;2.0;INTEGRATED BILLING;**770**;23-MAY-18;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ; Reference to $$CPT^ICPTCOD in ICR #1995 (Supported)
 ;
 ; tag : 24 - loop 2400 process loop 2400 for incoming encounter from TAS API business.js service
 ;       NB - check for Medicare Non-Billable
24 ;LOOP 24
 ;SVx segments are service lines, SV1 = prof, SV2 = inst, SV3 = dental and 1st cpt code, SV5 - durable medical equip
 ; SV1*HC:99222*420*UN*1***1:2
 ; SV2*0301*HC:83880*509*UN*1**285.04
 ; SV3*AD:D4341:::::PERIODONTAL SCALING AND ROOT P*270**10
 I $E(SEG,1,2)="SV" D  Q
 . ;JWS;9/24/25;EBILL-6055;check procedure codes if surgical range 10000 thru 69999
 . I $E(SEG,1,3)="SVD" Q
 . N XIBPC,XIBMOD,I,X1
 . S ^TMP("IB837ACC",$J,"L",IBSLINE,$P(ARG(IBSEG),"*"))=ARG(IBSEG)
 . S XIBPC=$P($P(ARG(IBSEG),":",2),"*")
 . I $E(SEG,1,3)="SV2" S XIBMOD=$P($P(ARG(IBSEG),"*",3),":",3,6)
 . E  S XIBMOD=$P($P(ARG(IBSEG),"*",2),":",3,6)
 . I $G(IBFT)="" D FT($S($E(ARG(IBSEG),3)=1:2,$E(ARG(IBSEG),3)=2:3,$E(ARG(IBSEG),3)=3:7,1:""))
 . I $G(IBCPT)="" S IBCPT=XIBPC
 . I $G(IBFT)=3,$$OPPROV(XIBPC) S $P(^TMP("IB837ACC",$J),"^",45)=1
 . ;JWS;10/9/25;EBILL-6111;check modifiers
 . F I=1:1:$L(XIBMOD,":") S X1=$P(XIBMOD,":",I) I X1'="" D
 .. N X2,XPN
 .. S X2=$$GETMOD^IBCE837ACC4(X1)
 .. I X2 Q
 .. S XPN=$P($$CPT^ICPTCOD(XIBPC),"^",3)  ;ICR #1995 (Supported)
 .. S X2N=$$AMBMOD($E(X1))_" to "_$$AMBMOD($E(X1,2))
 .. D UP^IBCE837ACC(IBX12,111,5,XIBPC_" "_XPN_": "_X1_" "_X2N)
 .. Q
 . Q
 I $E(SEG,1,4)="CR1*" Q  ;amb info - not done at line level for VA
 I $E(SEG,1,4)="CR3*" S $P(^TMP("IB837ACC",$J,"L",IBSLINE,0),"^",8)=$P(ARG(IBSEG),"*",2,4) Q  ;durable med equip cert
 I $E(SEG,1,4)="CRC*" D  Q
 . I SEG2="07" Q  ;amb cert - not done at line level for VA
 . I SEG2=70 S $P(^TMP("IB837ACC",$J,"L",IBSLINE,0),"^",7)=$P(ARG(IBSEG),"*",2,4) Q  ;hospice
 . I SEG2="09" S $P(^TMP("IB837ACC",$J,"L",IBSLINE,0),"^",9)=$P(ARG(IBSEG),"*",2,5) Q  ;cond indicator/dme
 ; get date of service from 1st service line
 I $E(SEG,1,4)="DTP*" D  Q
 . I SEG2=472 D  Q
 .. N IBXDOS
 .. I $P(ARG(IBSEG),"*",4)="" Q
 .. S IBXDOS=3_$E($P(ARG(IBSEG),"*",4),3,8),$P(^TMP("IB837ACC",$J,"L",IBSLINE,0),"^",14)=IBXDOS
 .. I $G(IBDOS)="" S (IBDOS,IBLDOS)=IBXDOS D SET^IBCE837ACC1(IBDOS,8),SET^IBCE837ACC1(IBLDOS,39) Q
 .. I $G(IBXDOS)>IBDOS S IBLDOS=IBXDOS D SET^IBCE837ACC1(IBLDOS,39)
 .. Q
 . I SEG2=573 Q
 . I SEG2=441!(SEG2=139) S $P(^TMP("IB837ACC",$J,"L",IBSLINE,0),"^")=$P(ARG(IBSEG),"*",2),$P(^(0),"^",2)=$P(ARG(IBSEG),"*",4) Q
 . I SEG2=452 D SETL(3) Q
 . I SEG2=446 D SETL(4) Q
 . I SEG2=196 D SETL(5) Q
 . I SEG2=198 D SETL(15) Q
 . I SEG2=471 Q  ;prescription date
 . I SEG2=607 D SETL(10) Q  ;certification revision/recert date
 . I SEG2=463 D SETL(11) Q  ;DME begin therapy date
 . I SEG2=461 D SETL(12) Q  ;DME last cert date
 . I SEG2=304 Q  ;date last seen - not reported at line level for VA
 . I SEG2=738 Q  ;hemoglobin or hematocrit test date
 . I SEG2=739 Q  ;serum creatine test date
 . I SEG2="011" Q  ;shipped date
 . I SEG2=455 Q  ;x-ray date - not reported at line level for VA
 . I SEG2=454 Q  ;initial treatment date - not reported at line level for VA 
 . Q
 I $E(SEG,1,4)="REF*" D  Q
 . ;JWS;9/29/25;EBILL-6085;issue with linking payment metadata to service line for non-network CC claims
 . I SEG2="6R",$P($G(^TMP("IB837ACC",$J,"L",IBSLINE,0)),"^",6)="" D
 .. N XLCN
 .. S XLCN=$P(ARG(IBSEG),"*",3) I XLCN="" Q
 .. N X,IBIEN
 .. S X=$G(ARG(XLCN_"_SVC03")) I X="" Q
 .. N FDA,ERROR,DA,D0,DR,DIE,DIC,DI,DQ,DD,DINUM,DLAYGO,DTOUT,DUOUT
 .. S IBIEN="+1,"_IBX12_","
 .. S FDA(364.96,IBIEN,.01)=IBSLINE
 .. S FDA(364.96,IBIEN,.02)=$J(X,"",2)
 .. D UPDATE^DIE(,"FDA","IBIEN","ERROR")
 .. S $P(^TMP("IB837ACC",$J,"L",IBSLINE,0),"^",6)=X
 .. Q
 . I SEG2="VY" S $P(^TMP("IB837ACC",$J,"L",IBSLINE,0),"^",13)=$P(ARG(IBSEG),"*",3) Q  ;link sequence number - pharmacy
 . I SEG2="XZ" S $P(^TMP("IB837ACC",$J,"L",IBSLINE,0),"^",13)=$P(ARG(IBSEG),"*",3) Q  ;pharmacy prescription#
 . Q
 I $E(SEG,1,4)="PWK*" Q
 I $E(SEG,1,3)="K3*" Q
 I $E(SEG,1,4)="NTE*" D  Q
 . I SEG2="TPO" Q
 . N I
 . F I=1:1 I '$D(^TMP("IB837ACC",$J,"L",IBSLINE,"NTE",SEG2,I)) S ^(I)=$P(ARG(IBSEG),"*",3) Q
 . Q
 I $E(SEG,1,4)="HCP*" D  Q
 . N X
 . S $P(^TMP("IB837ACC",$J,"L",IBSLINE,0),"^",6)=$P(ARG(IBSEG),"*",3)  ;line level paid amt
 . S X=$P($G(^TMP("IB837ACC",$J)),"^",43),X=X+$P(ARG(IBSEG),"*",3),$P(^($J),"^",43)=X
 . Q
 I $E(SEG,1,4)="LIN*" S ^TMP("IB837ACC",$J,"L",IBSLINE,"LIN")=$P(ARG(IBSEG),"*",3,4) Q  ;pharmacy
 I $E(SEG,1,4)="CTP*" S ^TMP("IB837ACC",$J,"L",IBSLINE,"CTP")=$P(ARG(IBSEG),"*",5,6) Q  ;drug quantity
 I $E(SEG,1,4)="NM1*" D  Q
 . I SEG2=82 D  Q  ;NM101='82' - rendering provider
 .. I $P(ARG(IBSEG),"*",4)="" Q  ;other payer rendering provider
 .. S IBPN1=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5)
 .. ;11/24/25;JWS;EBILL-6206;add error 27 for missing taxonomy
 .. S OK=$$CHK35593^IBCE837ACCU($P(ARG(IBSEG),"*",10),82,IBSLINE) I OK<1 D UP^IBCE837ACC(IBX12,$S(OK=-1:27,1:4),5,IBPN1_":"_$P(ARG(IBSEG),"*",10)) Q
 .. S ^TMP("IB837ACC",$J,"L",IBSLINE,1,82)=$P(ARG(IBSEG),"*",10)_"^"_IBPN1_"^"_$S(OK=1:355.93,1:200)
 .. Q
 . I SEG2=72 D  Q   ;NM101='72' - operating physician
 .. I $P(ARG(IBSEG),"*",4)="" Q  ;other provider
 .. S IBPN1=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5)
 .. S OK=$$CHK35593^IBCE837ACCU($P(ARG(IBSEG),"*",10),72,IBSLINE) I 'OK D UP^IBCE837ACC(IBX12,4,5,IBPN1_":"_$P(ARG(IBSEG),"*",10)) Q
 .. S ^TMP("IB837ACC",$J,"L",IBSLINE,1,72)=$P(ARG(IBSEG),"*",10)_"^"_IBPN1_"^"_$S(OK=1:355.93,1:200)
 .. Q
 . I SEG2="DQ" D  Q  ;NM101='DQ' = supervising provider
 .. I $P(ARG(IBSEG),"*",4)="" Q  ;other payer supervising provider
 .. S IBPN1=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5)
 .. S OK=$$CHK35593^IBCE837ACCU($P(ARG(IBSEG),"*",10),"DQ",IBSLINE) I 'OK D UP^IBCE837ACC(IBX12,4,5,IBPN1_":"_$P(ARG(IBSEG),"*",10)) Q
 .. S ^TMP("IB837ACC",$J,"L",IBSLINE,1,"DQ")=$P(ARG(IBSEG),"*",10)_"^"_IBPN1_"^"_$S(OK=1:355.93,1:200)
 .. Q
 . I SEG2="ZZ" D  Q   ;NM101='ZZ' - other operating physician
 .. I $P(ARG(IBSEG),"*",4)="" Q  ;other provider
 .. S IBPN1=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5)
 .. S OK=$$CHK35593^IBCE837ACCU($P(ARG(IBSEG),"*",10),"ZZ",IBSLINE) I 'OK D UP^IBCE837ACC(IBX12,4,5,IBPN1_":"_$P(ARG(IBSEG),"*",10)) Q
 .. S ^TMP("IB837ACC",$J,"L",IBSLINE,1,"ZZ")=$P(ARG(IBSEG),"*",10)_"^"_IBPN1_"^"_$S(OK=1:355.93,1:200)
 .. Q
 . I SEG2="DD" D  Q   ;NM101='DD' - assistant surgeon
 .. I $P(ARG(IBSEG),"*",4)="" Q  ;other provider
 .. S IBPN1=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5)
 .. S OK=$$CHK35593^IBCE837ACCU($P(ARG(IBSEG),"*",10),"DD",IBSLINE) I 'OK D UP^IBCE837ACC(IBX12,4,5,IBPN1_":"_$P(ARG(IBSEG),"*",10)) Q
 .. S ^TMP("IB837ACC",$J,"L",IBSLINE,1,"DD")=$P(ARG(IBSEG),"*",10)_"^"_IBPN1_"^"_$S(OK=1:355.93,1:200)
 .. Q
 . I SEG2="DN" D  Q  ;referring provider
 .. I $P(ARG(IBSEG),"*",4)="" Q  ;other payer referring provider
 .. S IBPN1=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5)
 .. ;11/24/25;JWS;EBILL-6206;add error 27 for missing taxonomy
 .. S OK=$$CHK35593^IBCE837ACCU($P(ARG(IBSEG),"*",10),"DN",IBSLINE) I OK<1 D UP^IBCE837ACC(IBX12,$S(OK=-1:27,1:4),5,IBPN1_":"_$P(ARG(IBSEG),"*",10)) Q
 .. ;JWS;IB*2.0*770v11;11/11/24;EBILL-3551;address NOT ON FILE name issue
 .. I $F(IBPN1,"NOT ON FILE") S IBPN1=$G(IBPN2)
 .. S ^TMP("IB837ACC",$J,"L",IBSLINE,1,"DN")=$P(ARG(IBSEG),"*",10)_"^"_IBPN1_"^"_$S(OK=1:355.93,1:200)
 .. Q
 . I SEG2="QB" Q
 . I SEG2="PW" D NEXT^IBCE837ACC1 Q  ;VistA does not send Ambulance info at line level
 . I SEG2=45 D NEXT^IBCE837ACC1 Q  ;VistA does not send Ambulance info at line level
 . I SEG2=77 D NEXT^IBCE837ACC1 Q  ;service facility - not used at line level for VA
 . I SEG2="DK" D NEXT^IBCE837ACC1 Q
 . Q
 I $E(SEG,1,7)="PRV*PE*" Q  ;rendering provider specialty info
 I $E(SEG,1,7)="PRV*AS*" Q  ;assistant surgeon specialty info
 I $E(SEG,1,3)="LQ*" Q
 I $E(SEG,1,4)="FRM*" Q
 I $E(SEG,1,4)="TOO*" D  Q
 . F I=1:1:32 I '$D(^TMP("IB837ACC",$J,"L",IBSLINE,"TOO",I)) S ^(I)=ARG(IBSEG) Q
 . Q
 I $E(SEG,1,7)="QTY*PT*" Q
 I $E(SEG,1,7)="QTY*FL*" Q
 I $E(SEG,1,4)="MEA*" Q
 I $E(SEG,1,4)="CN1*" Q
 I $E(SEG,1,4)="PS1*" Q
 Q
 ;
 ;JWS;7/3/25;EBILL-5534;suppress claims containing vaccine codes as non-billable
NB(IBPROD) ; check proc codes for billable status to all insurances
 N X,OK
 I IBPROD="" Q 0
 S OK=0
 S X=$$FIND1^DIC(364.991,,"X","ACCPROCNONBILL") I X D
 . N XTASP
 . S XTASP=$$GET1^DIQ(364.991,X_",",.1)
 . I $F(XTASP,IBPROD_"|") S OK=1
 . Q
 Q OK
 ;JWS;7/3/25;EBILL-5534;suppress claims containing vaccine codes as non-billable;changed tag name
MNB(IBPROD) ;check for Medicare Non-Billable
 N XED,XL,XLD,PROC,PROCD,OK
 S XED=$G(^TMP("IB837ACC",$J)) I XED="" Q 0
 I $P($P(XED,"^",2),"*",3)'="M" Q 0  ; must be medicare
 S OK=0
 ; home healthcare/hospice
 I IBPROD?1"G"4N D  Q OK
 . N X S X=$E(IBPROD,2,5)
 . I +X<151 Q
 . I +X>164,+X'=299,+X'=300,+X'=493,+X'=494,+X'=495,+X'=496 Q
 . S OK=1
 . Q
 I IBPROD?1"Q"4N D  Q OK
 . N X S X=$E(IBPROD,2,5)
 . I +X'=5001,+X'=5002,+X'=5009 Q
 . S OK=1
 . Q
 ; routine labs / IB edit already checks for 80000-89999
 I IBPROD?1"8"4N D  Q OK
 . N X S X=$E(IBPROD,2,5)
 . I +X<47 Q
 . I +X>7999 Q
 . S OK=1
 . Q
 ;JWS;12/2/24;EBILL-4554;IB*2.0*770v15;added procedure codes 36415 and 36416 to Lab codes 100% covered by Medicare
 I $F(",36415,36416,",","_IBPROD_",") Q 1
 ; mammograms
 I IBPROD?1"77"3N D  Q OK
 . N X S X=$E(IBPROD,3,5)
 . I X<63 Q
 . I X>67 Q
 . S OK=1
 . Q
 ; acupuncture
 I IBPROD?1"978"2N D  Q OK
 . N X S X=$E(IBPROD,4,5)
 . I +X<10 Q
 . I +X>14 Q
 . S OK=1
 . Q
 ; hearing aid exams/services
 I IBPROD?1"925"2N D  Q OK
 . N X S X=$E(IBPROD,4,5)
 . I +X<90 Q
 . I +X>95 Q
 . S OK=1
 . Q
 ; self mgmt / education & training
 I IBPROD?1"989"2N D  Q OK
 . N X S X=$E(IBPROD,4,5)
 . I +X<60 Q
 . I +X>62 Q
 . S OK=1
 . Q
 ; refractions
 I IBPROD=92015 Q 1
 I $E(IBPROD)="H" Q 1
 I $E(IBPROD)="T" Q 1
 ;JWS;11/4/25;EBILL-6197;IB*2.0*770v51;add S codes
 I $E(IBPROD)="S" Q 1
 I IBPROD?1"978"2N D  Q OK
 . N X S X=$E(IBPROD,4,5)
 . I +X<2 Q
 . I +X>4 Q
 . S OK=1
 . Q
 I IBPROD?1"G"4N D  Q OK
 . N X S X=$E(IBPROD,2,5)
 . I +X=270!(+X=271) S OK=1
 . Q
 Q 0
 ;
EX() ;CPT code exception checking
 N XL,XCT,XCT1,XR
 S XL="" F XCT=0:1 S XL=$O(^TMP("IB837ACC",$J,"L",XL)) Q:XL=""  I $P($G(^(XL,0)),"^",16)=1!($P($G(^(0)),"^",19)=1) S XCT1=$G(XCT1)+1
 S XR=XCT_"^"_$G(XCT1)
 Q XR
 ;
EX1(IBPROD) ;Medicare Excluded Services - dialysis proc codes
 N XED,XL,XLD,PROC,PROCD,OK
 S XED=$G(^TMP("IB837ACC",$J)) I XED="" Q 0
 I $P($P(XED,"^",2),"*",3)'="M" Q 0
 S OK=1
 I $E(IBPROD,1,2)=90 D  Q OK
 . N X S X=$E(IBPROD,3,5)
 . I +X=999 Q
 . I +X>934,+X<937 Q
 . I +X>944,+X<948 Q
 . I +X>950,+X<963 Q
 . S OK=0
 . Q
 Q 0
 ;
FT(FT) ;
 I FT="" Q
 S IBFT=FT,IBCPT=$P($P(ARG(IBSEG),":",2),"*")
 Q
 ;
SETL(PIECE) ;
 S $P(^TMP("IB837ACC",$J,"L",IBSLINE,0),"^",PIECE)=$P(ARG(IBSEG),"*",4) Q
 Q
 ;
OPPROV(XIBPC) ;check procedure code to determine if operating provider is required on UB-04 institutional claim
 ;I +$E(XIBPC,1,2)>9,+$E(XIBPC,1,2)<70
 N XIB,XIB1,XIBPC1,I,OK
 S XIB=$$FIND1^DIC(364.991,,"X","ACCPROCOPPROV")
 I 'XIB Q 0
 S XIB1=$$GET1^DIQ(364.991,XIB_",",.1)
 I '+XIB1 Q 0
 S OK=0 F I=1:1:$L(XIB1,"|") S XIBPC1=$P(XIB1,"|",I) I XIBPC1'="" D  I OK Q
 . I XIBPC=$P(XIBPC1,":") S OK=1 Q
 . I $F(XIBPC1,":") D  Q
 .. I +XIBPC>$P(XIBPC1,":"),+XIBPC<$P(XIBPC1,":",2) S OK=1 Q
 .. I +XIBPC=$P(XIBPC1,":",2) S OK=1 Q
 Q OK
 ;
AMBMOD(X2) ;
 N X,NM,I
 S NM="",X=$$FIND1^DIC(364.991,,"X","ACCAMBMOD1") I X D
 . N X1
 . S X1=$$GET1^DIQ(364.991,X_",",.1)
 . S X=$$FIND1^DIC(364.991,,"X","ACCAMBMOD2") I X S X1=$G(X1)_$$GET1^DIQ(364.991,X_",",.1)
 . F I=1:1:$L(X1,"|") I $P($P(X1,"|",I),":")=X2 S NM=$P($P(X1,"|",I),":",2) Q
 . Q
 Q NM
 ;
NOTE(IBIEN,TEXT) ; create history entry
 N IBDATA
 S IBDATA(1)=TEXT
 D WP^DIE(364.94,"1,"_IBX12_",",10,"A","IBDATA","ERROR")
 Q
 ;
