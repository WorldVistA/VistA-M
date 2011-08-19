IVMUCHK3 ;ALB/MLI - Filter routine to validate MT transmission before filing ; September 7, 1994
 ;;2.0;INCOME VERIFICATION MATCH ;**1,16**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine is a continuation of IVMUCHK.  It performs checks on incoming means test
 ; transmissions to ensure they are accurate prior to their upload into DHCP.
 ;
 ;
ZDP(STRING,DEPIEN) ; check validity of ZDP segment
 ;
 ; Input:  STRING as ZDP segment
 ;         DEPIEN as the IEN of the dependent in the array
 ;
 ; Output: ERROR message or null
 ;
 N ERROR,IVMZDP5,IVMZDP7
 S ERROR=""
 S X=$P(STRING,HLFS,2) I $L(X)>30!($L(X)<3)!(X?.N)!(X?1P.E)!(X'?1U.ANP)!(X[",")!(X?.L)!(X?." ") S ERROR="Invalid dependent name content/length" G ZDPQ
 S X=$P(STRING,HLFS,3) I X'="M",(X'="F") S ERROR="Invalid sex transmitted for dependent" G ZDPQ
 S X=$$FMDATE^HLFNC($P(STRING,HLFS,4)),%DT="P" D ^%DT I Y<0!(1701231>Y)!(($E($P(ARRAY("ZMT"),HLFS,2),1,4)-1_1231)<$P(STRING,HLFS,4)) S ERROR="Unacceptable DOB for dependent" G ZDPQ
 S X=$P(STRING,HLFS,5) I X]"",(X'?9N),(X'?3N1"-"2N1"-"4N) S ERROR="Invalid dependent SSN transmitted" G ZDPQ
 I $E(X)=9!($E(X,1,3)="000") S ERROR="SSA-invalid SSN transmitted for a dependent" G ZDPQ
 S X=$G(^DG(408.11,$P(STRING,HLFS,6),0))
 I '$P(X,"^",4) S ERROR="Invalid relationship for means test dependent" G ZDPQ
 I $P(X,"^",3)'="E",($P(X,"^",3)'=$P(STRING,HLFS,3)) S ERROR="Dependent relationship/sex are inconsistent" G ZDPQ
 I $P(STRING,HLFS,9)>($E($P(ARRAY("ZMT"),HLFS,2),1,4)-1_1231) S ERROR="Invalid Dependent Date...must be before MT year"
 S IVMZDP5=$P(STRING,HLFS,5) I IVMZDP5']"" G ZDP7
 I $D(IVMAR2(IVMZDP5)) S ERROR="Two dependents transmitted with same SSN" G ZDPQ
 S IVMAR2(IVMZDP5)=""
ZDP7 S IVMZDP7=$P(STRING,HLFS,7) I IVMZDP7']"" G ZDPQ
 I $D(IVMAR(IVMZDP7)) S ERROR="Two dependents transmitted with same 408.12 IEN" G ZDPQ
 S IVMAR(IVMZDP7)=""
ZDPQ Q ERROR
