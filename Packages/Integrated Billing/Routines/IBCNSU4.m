IBCNSU4 ;ALB/CPM - SPONSOR UTILITIES ; 21-JAN-97
 ;;Version 2.0 ; INTEGRATED BILLING ;**52**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
GET(DFN,ARR) ; Retrieve sponsor relationships for a patient.
 ;  Input:    DFN  --  Pointer to the patient in file #2
 ; Output:    ARR  --  Passed by reference:
 ;
 ;                     ARR = #, where # is the number of relationships
 ;
 ;                     ARR(#,"REL")=1^2^3^4^5, where
 ;                       1 => sponsor name
 ;                       2 => family prefix
 ;                       3 => type (tricare/champva)
 ;                       4 => effective date (fm format)
 ;                       5 => expiration date (fm format)
 ;                       6 => pointer to the relationship in file #355.81
 ;
 ;                     ARR(#,"SPON")=1^2^3^4^5^6, where
 ;                       1 => sponsor name
 ;                       2 => sponsor dob (external format)
 ;                       3 => sponsor ssn (external format [dashes])
 ;                       4 => military status (active duty/retired)
 ;                       5 => branch (expanded from file #23)
 ;                       6 => rank
 ;
 N BRAN,REL,SPON,STAT,X,X1,XSPON,Y,Y1
 K ARR S ARR=0
 I '$G(DFN) G GETQ
 ;
 ; - look at all of the patient's sponsor relationships
 S X=0 F  S X=$O(^IBA(355.81,"B",DFN,X)) Q:'X  D
 .S REL=$G(^IBA(355.81,X,0)) Q:'REL
 .S SPON=$G(^IBA(355.8,+$P(REL,"^",2),0)) Q:'SPON
 .I $L(REL,"^")<6 S REL=REL_"^^^^^^^"
 .;
 .; - if the sponsor is a patient, gather attributes from file #2
 .I $P(SPON,"^")["DPT" D
 ..S X1=$G(^DPT(+SPON,0))
 ..S Y=$P(X1,"^",3) X ^DD("DD")
 ..S XSPON=$P(X1,"^")_"^"_Y_"^"_$$SSN($P(X1,"^",9))
 .;
 .; - if the sponsor is not a patient, go to file #355.82
 .E  D
 ..S XSPON=$G(^IBA(355.82,+SPON,0)) S:$L(XSPON,"^")<3 XSPON=XSPON_"^^"
 ..S Y=$P(XSPON,"^",2) I Y X ^DD("DD") S $P(XSPON,"^",2)=Y
 ..S Y=$P(XSPON,"^",3) I Y S $P(XSPON,"^",3)=$$SSN(Y)
 .;
 .;
 .; - build sponsor relation array
 .S $P(REL,"^",4)=$S($P(REL,"^",4)="T":"TRICARE",$P(REL,"^",4)="C":"CHAMPVA",1:"")
 .S ARR=ARR+1,ARR(ARR,"REL")=$P(XSPON,"^")_"^"_$P(REL,"^",3,6)_"^"_X
 .;
 .; - build sponsor array
 .S STAT=$S($P(SPON,"^",2)="A":"ACTIVE DUTY",$P(SPON,"^",2)="R":"RETIRED",1:"")
 .S BRAN=$P($G(^DIC(23,+$P(SPON,"^",3),0)),"^")
 .S ARR(ARR,"SPON")=$P(XSPON,"^",1,3)_"^"_STAT_"^"_BRAN_"^"_$P(SPON,"^",4)
 ;
GETQ Q
 ;
 ;
SSN(X) ; Strip dashes from SSN and add them back in.
 S:$G(X)'="" X=$TR(X,"-","")
 Q $S($G(X)="":"",1:$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,13))
