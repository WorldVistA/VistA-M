IBDFN9 ;ALB/CJM - ENCOUNTER FORM - output transforms for data ;05/10/95
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**38,36,51,63**;APR 24, 1997;Build 80
 ;
 ;
DSPLYCPT(IEN) ;output transform for CPT codes (file #81)
 ;example of use: S Y=$$DSPLYCPT^IBDFN9(Y)
 ;;change to api cpt;dhh
 N IBDCODE
 S IBDCODE=$$CPT^ICPTCOD(IEN)
 ;;I +CODE=-1 S CODE=""
 ;;E  S CODE=$P(CODE,U,2)
 ;
 ;Check status for CSV
 I $P(IBDCODE,U,7)'=1 S IBDCODE="" Q IBDCODE
 S IBDCODE=$P(IBDCODE,U,2)
 Q IBDCODE
 ;
DSPICD10(IEN) ;output transform for ICD10 codes (file #8010)
 ;example of use: S Y=$$DSPICD10^IBDFN9(Y)
 ;Use API for CSV
 Q $P($$ICDDATA^ICDXCODE("10D",IEN,DT),"^",2)
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
