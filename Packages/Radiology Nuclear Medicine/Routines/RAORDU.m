RAORDU ;HISC/CAH - AISC/RMO-Update Request Status ;9/7/04 11:01am
 ;;5.0;Radiology/Nuclear Medicine;**18,41,57**;Mar 16, 1998
 ; last modif JULY 5,00
 ;The variables RAOIFN and RAOSTS must be defined. The variable
 ;RAOREA is set when Canceling and Holding a request. The
 ;variable RAOSCH is set when Scheduling a request.
 ; RAOSTS=request status of exam
 ; RAESTAT=min stat exams same dt/tm^max stat^1(if stat found) 0(else)
 N RAESTAT
 I RAOSTS=2,($$PARNT^RASETU(RAOIFN,RADFN)),($P($G(RAEXM0),"^",25)) D  Q:RAOSTS=6
 . S RAESTAT=$$EN1^RASETU(RAOIFN,RADFN)
 . S RAOSTS=$S((+RAESTAT'<1)&(+RAESTAT'>8):6,1:RAOSTS)
 . K:RAOSTS=6 ORIFN,ORETURN
 . I '$D(RAF1),(+RAESTAT=9) D
 .. W !?3,"...will now designate request status as 'COMPLETE'..."
 .. W !?10,"...request status successfully updated."
 .. Q
 . Q
 I $D(ORSTS),ORSTS=11,$P(^RAO(75.1,RAOIFN,0),"^",5)=11 S ORIFN=+$P(^(0),"^",7),ORSTS="K",DA=RAOIFN,DIK="^RAO(75.1," D DELETE,^DIK K DIK D:ORIFN ST^ORX K ORSTS Q
 K N I $D(RAOREA)>1 S N=$S($D(RAOIFN):RAOIFN,$D(ORPK):ORPK,1:1) I '$D(RAOREA(N)) S N=$O(RAOREA(0))
 S DA=RAOIFN,DIE="^RAO(75.1,",DR="10///"_$S($D(RAOREA)&(RAOSTS=1!(RAOSTS=3)):"/^S X="_$S($D(N):RAOREA(N),1:RAOREA),'$D(^RAO(75.1,RAOIFN,0)):"",$P(^(0),"^",10):"@",1:"")_";I 1;5///^S X="_RAOSTS
 I $D(RAVSTFLG),$D(RAVLEDTI) S DR=DR_";17///^S X="_(9999999.9999-RAVLEDTI)
 S DR=DR_";18///^S X=""NOW"";23///"_$S($D(RAOSCH)&(RAOSTS=8):"^S X="_RAOSCH,'$D(^RAO(75.1,RAOIFN,0)):"",$P(^(0),"^",23):"@",1:"")
 S RADIV=$$SITE(),RADIV=$S($D(^RA(79,RADIV,0)):RADIV,1:$O(^RA(79,0)))
 I $D(^RA(79,+RADIV,.1)),$P(^(.1),"^",19)="y" D SETLOG
 D ^DIE K DE,DQ,DIE,DR I $$ORVR^RAORDU()=2.5 S ORIFN=$S($D(^RAO(75.1,RAOIFN,0)):+$P(^(0),"^",7),1:0),ORETURN("ORSTS")=RAOSTS D:ORIFN RETURN^ORX K ORIFN,ORETURN
 ;
 ; if oe/rr v.3 or greater do the following
 ; .send a discontinue or hold message to oe/rr if request status in file
 ;  75.1 is discontinued (1) or hold (3).
 ; .send a complete message to oe/rr if request status in file 75.1 is 
 ;  complete.
 ; .send a scheduled message to oe/rr if request status is active (6) or
 ;  scheduled (8) AND the request was not a rollback from a status of
 ;  complete.
 ;
 I $$ORVR^RAORDU()'<3 D
 . D:(RAOSTS=1)!(RAOSTS=3) EN1^RAO7CH(RAOIFN)
 . D:RAOSTS=2 EN1^RAO7CMP(RAOIFN)
 . I (RAOSTS=6) Q:$G(RA18PCHG,0)=1  ;P18 quit if procedure was changed - do not send "SC" message,because "XX" have been sent already
 . I ((RAOSTS=6)!(RAOSTS=8))&($P($G(RAORDB4),"^",5)'=2) D
 .. D EN1^RAO7SCH(RAOIFN)
 .. Q
 . Q
 ; ***** PCE changes follow *****
 I $$PCE^RAWORK(),(RAOSTS=2),$G(RASAVDR)'="[RA OVERRIDE]" D
 . N RA7003 S RA7003=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 . Q:$P(RA7003,"^",24)="Y"  ; quit if clinic stop credited
 . ;BILLING AWARE PHASE II, NO LONGER SENDING TO PTF
 . ;I $P(RA7003,"^",6)]"",($P(^DIC(42,$P(RA7003,"^",6),0),"^",3)'="D") Q
 . ;omit quit since both inpatient and outpatient data are sent to PCE
 . D COMPLETE^RAPCE(RADFN,RADTI,RACNI)
 . Q
 ; PFSS 1B project. If the request status is discontinue then send the delete event to IBB
 I RAOSTS=1 D DC^RABWIBB(RAOIFN)  ; Requirement 8
 Q
 ;
SETLOG K N I $D(RAOREA)>1 S N=$S($D(RAOIFN):RAOIFN,$D(ORPK):ORPK,1:1) I '$D(RAOREA(N)) S N=$O(RAOREA(0))
 S DR=DR_";75///^S X=$$MIDNGHT^RAUTL5($$NOW^XLFDT())",DR(2,75.12)="2////^S X="_RAOSTS_";3////^S X="_$S($G(RADUZ):RADUZ,1:DUZ)_";4///"_$S($D(RAOREA)&(RAOSTS=1!(RAOSTS=3)):"/^S X="_$S($D(N):RAOREA(N),1:RAOREA),1:"")
 Q
SETORD ;Create request in OE/RR file and add OE/RR order number to file 75.1
 ; if oe/rr v.3 or greater send an hl7 message when creating a new request/order.
 I $$ORVR^RAORDU()'<3 D EN1^RAO7NEW(RAOIFN) Q
 Q:$$ORVR^RAORDU()'=2.5
 N RAPRGST S RAPRGST=$P(RAORD0,"^",13)
 K RAMOD S $P(RABLNK," ",41)="" F I=0:0 S I=$O(^RAO(75.1,RAOIFN,"M","B",I)) Q:'I  I $D(^RAMIS(71.2,+I,0)) S RAMOD=$S('$D(RAMOD):$P(^(0),"^"),1:RAMOD_", "_$P(^(0),"^"))
 I $$ORVR^RAORDU()=2.5 S (RAPRCD,ORTX(1))=$P($G(^RAMIS(71,+$P(RAORD0,"^",2),0)),"^")_"," D
 .I $D(RAMOD) S ORTX(2)="Modifiers: "_$E(RAMOD,1,80)_","
 .S ORTX(3)="Urgency: "_$S($P(RAORD0,"^",6)=1:"STAT",$P(RAORD0,"^",6)=2:"URGENT",1:"ROUTINE")_","
 .I $P(RAORD0,"^",19)]"" S X=$P(RAORD0,"^",19),ORTX(3)=ORTX(3)_" Transport: "_$S(X="a":"AMBULATORY",X="p":"PORTABLE",X="s":"STRETCHER",1:"WHEELCHAIR")_","
 .I $D(RASEX),RASEX'="M" S ORTX(3)=ORTX(3)_" Pregnant: "_$S(RAPRGST="n":"NO",RAPRGST="y":"YES",RAPRGST="u":"UNKNOWN",1:"")
 S ORIT=$P(RAORD0,"^",2)_";RAMIS(71,"
 S DIC="^RA(79.2,",DIC(0)="N",X=+$P(^RAMIS(71,+$P(RAORD0,"^",2),0),"^",12) D ^DIC K DIC,RABLNK,RAMOD,RAPRCD S ORPURG=$S(Y<0:30,$D(^RA(79.2,+Y,.1)):+$P(^(.1),"^",6),1:30)
 S ORVP=RADFN_";DPT(",ORL=RALIFN_";SC(",ORNP=RAPIFN S ORPCL=$O(^ORD(101,"B","RA OERR EXAM",0))_";ORD(101,",ORPK=RAOIFN,ORSTS=$P(RAORD0,"^",5),ORSTRT=$P(RAORD0,"^",21) D FILE^ORX
 I $D(ORIFN),ORIFN]"" S DA=RAOIFN,DIE="^RAO(75.1,",DR="7////^S X="_ORIFN D ^DIE K DE,DQ,DIE,DR
 Q
OERR ;Set ^XUTL("OR",$J,"RA",IFN of oerr,IFN of Rad/Nuc Med order)
 I $D(ORIFN),ORIFN,$D(RAOIFN),RAOIFN S ^XUTL("OR",$J,"RA",ORIFN,RAOIFN)=RADIV
 K RADR1 Q
DELETE W:'$D(ZTQUEUED) !,"Since this order has not been released will delete instead of cancel...",!
 Q
 ;
ORVR() ;returns version number of OE/RR
 ;returns 0 if OE/RR is not installed
 ;
 ;Q 3.0 ;for testing purposes
 Q $S('$D(^ORD(100.99,0)):0,'$D(^DD(100,0,"VR")):0,1:^("VR"))
 ;
ORQUIK() ;returns 1 if CPRS Order Dialogue file 101.41 exists
 ;this means the quick order conversion to file 101.41 has been
 ;done and users should no longer be allowed to edit quick order
 ;parameters in the Common Procedure file 71.3.  The quick order
 ;conversion can be done prior to installing 3.0
 Q $S('$D(^ORD(101.41,0)):0,1:1)
 ;
SITE() ; Determine the value of RADIV
 ; +$P(RA1,"^",22)=Requesting Location
 ; +$P(RA2,"^",15)=Division (pntr to 40.8)
 Q:$D(RADIV)#2 RADIV
 N RA1,RA2,RADIVSON
 S RA1=$G(^RAO(75.1,RAOIFN,0))
 S RA2=$G(^SC(+$P(RA1,"^",22),0))
 S RADIVSON=+$$SITE^VASITE(DT,+$P(RA2,"^",15))
 Q $S(RADIVSON<0:0,1:RADIVSON)
