IBDFN9 ;ALB/CJM - ENCOUNTER FORM - output transforms for data ;MAY 10, 1995
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**38,36,51**;APR 24, 1997
 ;
DSPLYCPT(IEN) ;output transform for CPT codes (file #81)
 ;example of use: S Y=$$DSPLYCPT^IBDFN9(Y)
 ;;change to api cpt;dhh
 N CODE
 S CODE=$$CPT^ICPTCOD(IEN)
 ;;I +CODE=-1 S CODE=""
 ;;E  S CODE=$P(CODE,U,2)
 ;
 ;Check status for CSV
 I $P(CODE,U,7)'=1 S CODE="" Q CODE
 S CODE=$P(CODE,U,2)
 Q CODE
 ;
DSPLYICD(IEN) ;output transform for ICD9 codes (file #80)
 ;example of use: S Y=$$DSPLYICD^IBDFN9(Y)
 ;;Q $P($G(^ICD9(+$G(IEN),0)),"^")
 ;
 ;Use API for CSV
 Q $P($$ICDDX^ICDCODE(IEN),"^",2)
 ;
DSPLYPRV(IEN) ;output transform for provider (file #200)
 ;example of use: S Y=$$DSPLYPRV^IBDFN9(Y)
 Q $P($G(^VA(200,+$G(IEN),0)),"^")
 ;
DSPLYYN(Y) ;changes 1 to YES and 0 or "" to NO
 Q:Y=1 "YES"
 Q:(Y=0)!(Y="") "NO"
 Q " "
VARVAL(Y) ;determines PCE DIM NODE VALUE
 Q:'$D(Y) ""
 Q $S(Y="SC":6,Y="AO":7,Y="IR":8,Y="EC":9,Y="MST":10,1:"")
