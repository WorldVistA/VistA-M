ORQ13 ;slc/dcm-Get patient orders in context ; 08 May 2002  2:12 PM
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**141,165**;Dec 17, 1997
 ;
EN ; -- Event Delayed: 24=All Delayed orders, or
 ;     15=Admission, 16=Discharge, 17=Transfer, 25=OR, 26=Manual
 ;     or EVENT=ptr to Patient Event in #100.2
 D UNDO I $G(EVENT) D EN1 Q
 N TYPE,EVT,EVENT,IFN,X0,TM,STS
 S TYPE=$S(FLG=15:"A",FLG=16:"D",FLG=17:"T",FLG=25:"O",FLG=26:"M",1:"ADTOM")
 S EVT=0 F  S EVT=+$O(^ORE(100.2,"AE",+PAT,EVT)) Q:EVT<1  S EVENT=+$O(^(EVT,0)) D
 . Q:TYPE'[$P($G(^ORD(100.5,EVT,0)),U,2)  ;Q:$$LAPSED^OREVNTX(EVENT)
 . S IFN=0 F  S IFN=$O(^OR(100,"AEVNT",PAT,EVENT,IFN)) Q:IFN<1  D ADD(IFN)
 S ^TMP("ORR",$J,ORLIST,"TOT")=ORLST
 Q
 ;
EN1 ; -- Delayed for EVENT [and related Pt Events]
 N DAD,CHLD S DAD=+$P($G(^ORE(100.2,EVENT,1)),U,5) ;EVENT=child
 I DAD<1,$O(^ORE(100.2,"DAD",EVENT,0)) S DAD=EVENT ;EVENT=parent
 D:DAD<1 EVNT(EVENT) I DAD D
 . D EVNT(DAD) S CHLD=0
 . F  S CHLD=+$O(^ORE(100.2,"DAD",DAD,CHLD)) Q:CHLD<1  D EVNT(CHLD)
 S ^TMP("ORR",$J,ORLIST,"TOT")=ORLST
 Q
 ;
EVNT(EVENT) ; -- Orders tied to EVENT in #100.2
 N DONE,IFN,I,X,ORDER
 S DONE=$G(^ORE(100.2,EVENT,1)) D:DONE  ;get released, dc'd orders
 . S I=+$O(^ORE(100.2,EVENT,10,"B"),-1),X=$P($G(^(I,0)),U,2) Q:X="LP"!(X="CA")  ;skip if lapsed or cancelled
 . S ORDER=+$P($G(^ORE(100.2,EVENT,0)),U,4) D:ORDER ADD(ORDER,"RL")
 . S IFN=0 F  S IFN=$O(^ORE(100.2,EVENT,2,IFN)) Q:IFN<1  D ADD(IFN,"RL")
 . S IFN=0 F  S IFN=$O(^OR(100,"AEVNT",PAT,EVENT,IFN)) Q:IFN<1  I IFN'=ORDER,'$D(^ORE(100.2,EVENT,2,IFN)) D ADD(IFN,"RL")
 . S IFN=0 F  S IFN=$O(^ORE(100.2,EVENT,3,IFN)) Q:IFN<1  D ADD(IFN,"DC")
 I 'DONE S IFN=0 F  S IFN=$O(^OR(100,"AEVNT",PAT,EVENT,IFN)) Q:IFN<1  D ADD(IFN)
 Q
 ;
ADD(IFN,TYPE)        ; -- add EVENT order to list?
 N X0,X3,DA,X8,TM,CURR
 S X0=$G(^OR(100,IFN,0)),X3=$G(^(3)) Q:'$D(ORGRP(+$P(X0,U,11)))
 Q:$P(X3,U,8)  I $P(X3,U,9),'$P($G(^OR(100,$P(X3,U,9),3)),U,8) Q
 I $P(X3,U,3)=12,$P($G(^OR(100,+$P(X3,U,6),0)),U,17)=EVENT Q  ;changed
 S CURR=$P(X3,U,7) S:CURR<1 CURR=+$O(^OR(100,IFN,8,"?"),-1) ;current/last
 S DA=0 F  S DA=+$O(^OR(100,IFN,8,DA)) Q:DA<1  S X8=$G(^(DA,0)) D
 . S TM=$P(X8,U) Q:TM<SDATE  Q:TM>EDATE
 . I DA'=CURR,$P(X8,U,15)'=11 Q  ;current or unrel action
 . I DETAIL<2!'$L($G(TYPE)) D GET^ORQ12(IFN,ORLIST,DETAIL,DA) Q
 . S ORLST=ORLST+1,^TMP("ORGOTIT",$J,IFN,DA)=""
 . S ^TMP("ORR",$J,ORLIST,EVENT,TYPE,ORLST)=IFN_";"_DA
 Q
 ;
UNDO ; -- un-invert dates from ORQ1
 N X S X=EDATE,EDATE=SDATE,SDATE=X
 S SDATE=9999999-SDATE,EDATE=9999999-EDATE
 Q
 ;
QUIT ; -- stop
 Q
