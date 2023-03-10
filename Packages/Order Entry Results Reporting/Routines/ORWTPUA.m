ORWTPUA ;SLC/STAFF Personal Preference - Utility Alerts ;Jul 19, 2021@12:39:02
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**85,243,296,539,405**;Oct 24, 2000;Build 211
 ;
START(USER) ; $$(user) -> user's surrogate start date/time
 Q $P($G(^XTV(8992,+$G(USER),0)),U,3)
 ;
STOP(USER) ; $$(user) -> user's surrogate stop date/time
 Q $P($G(^XTV(8992,+$G(USER),0)),U,4)
 ;
CHKSURR(USER,SURR) ; $$(user,surrogate) -> 1 if ok else 0^reason for reject
 N OK,START
 S USER=+$G(USER),SURR=+$G(SURR)
 I USER=SURR Q "0^You cannot specify yourself as your own surrogate!"
 S START=$$GET1^DIQ(8992,(SURR_","),.02,"I")
 I START<.5 Q 1
 I START=USER Q "0^You are designated as the surrogate for this user - can't do it!"
 S OK=1 F  S START=$$GET1^DIQ(8992,(START_","),.02,"I") Q:START'>0  I START=USER S OK=0 Q
 I 'OK Q "0^This forms a circle which leads back to you - can't do it!"
 Q 1
 ;
CHKSURRO(USER,SURR,START,STOP) ; Check if surrogate has a surrogate
 ; designated for same time period
 N OK,RSLT,SURSTOP,SURSTRT,X
 S OK=1
 I +STOP=0 S STOP=9999999
 I +START>0 D
 . D GETSURRS^ORWTPR(.RSLT,SURR)
 . I RSLT>0 D
 .. S X=0
 .. F  S X=$O(RSLT(X)) Q:X=""  D  Q:+OK=0
 ... S SURSTRT=$P(RSLT(X),U,3)
 ... S SURSTOP=$P(RSLT(X),U,4)
 ... I +SURSTOP=0 S SURSTOP=9999999
 ... I START<=SURSTRT,STOP>=SURSTOP S OK=0 Q
 ... I START>SURSTRT,START<SURSTOP S OK=0 Q
 ... I STOP>SURSTRT,STOP<SURSTOP S OK=0 Q
 .. I OK=0 S OK="0^"_$S(+SURR>0:$P($G(^VA(200,SURR,0)),U,1),1:SURR)_" has a surrogate scheduled during the same time period of "_$$FMTE^XLFDT(SURSTRT,5)_$S(SURSTOP'=9999999:" through "_$$FMTE^XLFDT(SURSTOP,5),1:" with no end date")_"!"
 Q OK
 ;
GETSURR(USER) ; $$(user ien) -> surrogate ien
 Q $$CURRSURO^XQALSURO(+$G(USER))
 ;
SAVESURR(USER,SURR,START,STOP) ; save user's surrogate info
 N RET
 S STOP=$G(STOP)
 ;D REMVSURO^XQALSURO(USER,$S(SURR=-1:"",1:SURR),$S(START>0:START,1:"")) Q:((SURR=-1)!(STOP=0)) 1
 I (STOP=0)!(SURR=-1) D REMVSURO^XQALSURO(USER,$S(SURR=-1:"",1:SURR),$S(START>0:START,1:"")) Q 1
 S RET=$$SETSURO1^XQALSURO(USER,SURR,START,STOP)
 Q RET
