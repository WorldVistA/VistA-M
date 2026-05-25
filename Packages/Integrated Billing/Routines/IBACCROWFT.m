IBACCROWFT ;EDE/WCJ - ACC (Automated Community Care) Claims - Roll Up Utilities ; 24-APR-2024
 ;;2.0;INTEGRATED BILLING;**770**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
LKUPSCRN(Y) ; Look Up Screen
 ; only let them pick facilities in our table
 N RET,IEN,STATION
 S RET=0
 S STATION=$$GET1^DIQ(4,+Y,99)
 I STATION="" Q RET
 I '$D(^IBA(364.99,"B",STATION)) Q RET
 S IEN=$O(^IBA(364.99,"B",STATION,""),-1)
 I '+IEN Q RET
 I '$$GET1^DIQ(364.99,IEN,.04,"I") Q RET
 S RET=1
 Q RET
 ;
MCD(STATION) ; Medical Center Division
 ; pass in the complete 3-7 character station number
 ; and get the MCD to bill from 40.8 
 ; or DEFAULT DIVISION from site parameter file if we can't find a MCD for a VAMC
 ; VAMC will have 3 digit number or 3 digit followed by A then whatever
 ;
 N SCREEN,MCD
 ;
 ;wcj;IB770;v37;EBILL-5371
 ;I +STATION=STATION!($E(STATION,4)="A") D
 ;. S SCREEN="I $P(^(0),U,7),$$GET1^DIQ(4,$P(^(0),U,7),99)=STATION"
 ;. S MCD=$$FIND1^DIC(40.8,,"X",STATION,"AD",SCREEN,"RETURN")
 ;
 S SCREEN="I $P(^(0),U,7),$$GET1^DIQ(4,$P(^(0),U,7),99)=STATION"
 S MCD=$$FIND1^DIC(40.8,,"X",STATION,"AD",SCREEN,"RETURN")
 I $G(MCD) Q MCD
 ;
 ;maybe grab the default from the site parameters
 Q $$GET1^DIQ(350.9,1,1.25,"I")
 ;
 ;leave 
 ;
 N RET,IEN,LOOP,WL
 S RET=0
 ; use new crosswalk to see what it rolls up to
 I '$D(^IBA(364.99,"B",STATION)) Q RET
 S IEN=$O(^IBA(364.99,"B",STATION,""),-1) I 'IEN Q RET
 S WL=$P($G(^IBA(364.99,IEN,0)),U,2)
 I WL="" Q RET
 S LOOP=0 F  S LOOP=$O(^IBA(364.99,"C",WL,LOOP)) Q:'LOOP  I $P($G(^IBA(364.99,LOOP,0)),U,4) S RET=1 Q
 I 'RET Q RET
 ;
 ;get the pointer into 40.8
 N DIC,X,Y
 S X=$P($G(^IBA(364.99,LOOP,0)),U)
 S DIC(0)="MX",DIC=40.8 D ^DIC  ;ICR #2817 (Controlled)
 I Y<0 Q RET
 Q Y
 ;
 ;WCJ;v8;10/24/24
RUST(STATION) ; roll-up station aka division
 ; pass in the complete 3-7 character station number
 ; and get the Division for 4 sites that use them
 ; or 0 if can't figure out.
 ; 
 N RET,IEN,LOOP,WL
 I $G(STATION)="" Q ""
 S RET=STATION
 ; use new crosswalk to see what it rolls up to
 I '$D(^IBA(364.99,"B",STATION)) Q $E(STATION,1,3)
 S IEN=$O(^IBA(364.99,"B",STATION,""),-1) I 'IEN Q $E(STATION,1,3)  ; don't think it could ever get here and yet there was code here
 S WL=$P($G(^IBA(364.99,IEN,0)),U,2)
 I WL="" Q STATION
 S LOOP=0 F  S LOOP=$O(^IBA(364.99,"C",WL,LOOP)) Q:'LOOP  I $P($G(^IBA(364.99,LOOP,0)),U,4) S RET=1 Q
 I 'RET Q STATION
 ;
 Q $P(^IBA(364.99,LOOP,0),U)
 ;
