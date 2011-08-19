IVMUFNC5 ;ALB/AEG - IVM UTILITIES CONTINUED ; 8/10/05 1:39pm
 ;;2.0;INCOME VERIFICATION MATCH;**55,109**;5-10-2002
 ;
AGE(DT) ;
 N Y
 S Y=$E(DT,1,3)-1_"0000",Y=Y-10000
 Q Y
 ;
INCY(IVMMTDT) ;
 N Y
 S Y=$E(IVMMTDT,1,3)_"0000",Y=Y-10000
 Q Y
 ;
CATC(DATA) ;
 ; Extrinsic function to determine is incoming ZMT1 segment meets 
 ; one of the following groups:
 ;     1.  Cat C or Pending Adj. / Provided income info / test date
 ;         is 10/6/99 or later and Agreed to Pay is YES.
 ;     OR
 ;
 ;     2.  Category C based upon declination to provide income info
 ;         but agreed to pay deductible.
 ;
 ; Input(s):  $G(^TMP($J,"IVMCM","ZMT1")) global node - Incoming ZMT
 ;            segment.
 ;
 ; Output(s):  Function Value. 1 = Yes patient meets one of the criteria
 ;                             0 = NO test does not meet criteria.
 N MTDAT,RETV
 S RETV=0
 Q:'$D(DATA) 0
 S MTDAT("DT")=$P($G(DATA),U,2),MTDAT("MTS")=$P($G(DATA),U,3)
 S MTDAT("APD")=$P($G(DATA),U,7),MTDAT("DCLI")=$P($G(DATA),U,16)
 ; Patient Provided income information.
 I '+$G(MTDAT("DCLI")) D
 .; If Cat C or Pending Adjudication test date on or after 10/6/99
 .; Provided Income info and Agreed to Pay.
 .;
 .I $G(MTDAT("MTS"))="C",$G(MTDAT("DT"))'<2991006,$G(MTDAT("APD"))=1 S RETV=1 Q
 .I $G(MTDAT("MTS"))="P",$G(MTDAT("DT"))'<2991006,$G(MTDAT("APD"))=1 S RETV=1 Q
 ;
 ; Patient Declined to provide income information.
 I +$G(MTDAT("DCLI")) D
 .; Cat C and Agreed to Pay - No date restriction
 .I $G(MTDAT("MTS"))="C",+$G(MTDAT("APD")) S RETV=1 Q
 ;
 Q RETV
 ;
ELIG(DFN) ; Eligibility Check for Cat C uploads older than previous
 ;         income year data.
 ;
 ; Input: DFN - Patient IEN
 ; Output: Function Value 0 if Z10 upload not appropriate
 ;
 N IVMELI
 S IVMELI=0
 ; Check primary eligibility
 I $D(^DPT(DFN,.36)) S X=^(.36) D
 .; If NSC or SC < 50 0% appropriate to upload old test.
 .I $P($G(^DIC(8,+X,0)),U,9)=5!($$SC(DFN)) S IVMELI=1
 .I $P(X,U,12)=1 S IVMELI=0
 .I $P(X,U,13)=1 S IVMELI=0
 .K X
 ; If deceased patient --- don't upload.
 I +$$GET1^DIQ(2,DFN_",",.351,"I") S IVMELI=0
 ; If eligible for medicaid, don't upload.
 I +$$GET1^DIQ(2,DFN_",",.381,"I") S IVMELI=0
 ; Check PH status.
 I $P($G(^DPT(DFN,.53)),U)="Y" S IVMELI=0
 Q IVMELI
 ;
SC(DFN) ; Check to see if patient is SC 0% non-compensable.
 ; Input -- DFN Patient IEN
 ; Output -- Function value 1=Yes or 0=No
 ;
 N IVMG,IVME,IVMF,IVMY
 S IVMY=0
 ; Primary Eligibility is SC < 50 %
 I $D(^DPT(DFN,.36)),$P($G(^DIC(8,+X,0)),U,9)=3 S IVMY=1
 G:'IVMY SCQ
 ; Service Connected percentage = 0
 I $P($G(^DPT(DFN,.3)),U,2)'=0 S IVMY=0 G SCQ
 ; No Total annual VA Check amount
 I $P($G(^DPT(DFN,.362)),U,20) S IVMY=0 G SCQ
 ; POW Status indicated.
 I $P($G(^DPT(DFN,.52)),U,5)="Y" S IVMY=0 G SCQ
 ; Purple Heart Indicated.
 I $P($G(^DPT(DFN,.53)),U)="Y" S IVMY=0 G SCQ
 ; Check Secondary Eligibilities.
 F IVMG=2,4,15:1:18 S IVME(IVMG)=""
 S IVMG=0 F  S IVMG=$O(^DPT(DFN,"E","B",IVMG)) Q:'IVMG  D SEL I IVMF,$D(IVME(+IVMF)) S IVMY=0 Q
SCQ Q +$G(IVMY)
 ;
SEL ;
 S IVMF=$G(^DIC(8,+IVMG,0)) I IVMF="" Q
 S IVMF=$P(IVMF,U,9)
 I IVMF=""!('$D(^DIC(8.1,+IVMF,0))) D
 .S IVMF=""
 .Q
 Q
