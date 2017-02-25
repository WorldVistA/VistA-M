HMPWBSO ; CNP/JD,MBS - Sign orders RPCs ;08/27/15 12:05
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;August 27, 2015;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ; RPC: HMP SIGN ORDERS
SIGN(RSLT,DFN,ORNP,ORL,ES,DATA) ;
 ;
 ;Output
 ; RSLT = 1 on success, 0 otherwise
 ; RSLT(ORIEN) = error message
 ;Input
 ; DFN - patient IEN - ^DPT(
 ; ORNP - provider IEN - ^VA(200
 ; ORL - location IEN - ^SC(
 ; ES - electronic signature
 ; DATA(ORIEN) = order IEN - ^OR(100
 ;
 N ESOK,ORID,VAL,OK,ORS,IDX,ERR
 S U="^",IDX=0,ERR=0,XQY0="OR CPRS GUI CHART"
 S RSLT=0
 I $D(^DPT(+$G(DFN)))'>1 S RSLT(0)="Invalid DFN - "_+$G(DFN) Q
 I $D(^VA(200,+$G(ORNP)))'>1 S RSLT(0)="Invalid ORNP - "_+$G(ORNP) Q
 I $D(^SC(+$G(ORL)))'>1 S RSLT(0)="Invalid ORL - "_+$G(ORL) Q
 I '$D(^XUSEC("PROVIDER",ORNP)) S RSLT(0)="Not a provider" Q
 D VALIDSIG^ORWU(.ESOK,$G(ES)) I $G(ESOK)'>0 S RSLT(0)="Signature not valid" Q
 I $D(DATA)'>1 S RSLT(0)="Invalid DATA array" Q
 S ORID=0 F  S ORID=$O(DATA(ORID)) Q:'ORID  D
 . D VALID^ORWDXA(.VAL,ORID,"ES",ORNP)
 . I $L(VAL)>0 S RSLT(ORID)=ORID_";1"_U_"E"_U_VAL,ERR=1
 . D LOCKORD^ORWDX(.OK,ORID)
 . I 'OK S RSLT(ORID)=ORID_";1"_U_"E"_U_$P(OK,U,2),ERR=1
 . S IDX=IDX+1,ORS(IDX)=ORID_";1^1^1^E"
 I ERR S RSLT=0 Q
 D SEND^ORWDX(.RSLT,DFN,ORNP,ORL,ES,.ORS)
 S ORID=0 F  S ORID=$O(DATA(ORID)) Q:'ORID  D
 . D UNLKORD^ORWDX(.OK,ORID)
 S RSLT=1
 Q
