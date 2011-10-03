ORWTPUA ; SLC/STAFF Personal Preference - Utility Alerts ; 4/20/07 10:01am
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**85,243,296**;Oct 24, 2000;Build 19
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
GETSURR(USER) ; $$(user ien) -> surrogate ien
 Q $$CURRSURO^XQALSURO(+$G(USER))
 ;
SAVESURR(USER,SURR,START,STOP) ; save user's surrogate info
 N RET
 D REMVSURO^XQALSURO(USER) Q:SURR=-1 1
 S RET=$$SETSURO1^XQALSURO(USER,SURR,START,STOP)
 Q RET
