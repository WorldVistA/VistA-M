RAUTL00 ;HIRMFO/GJC-Utility Routine (linked to RAUTL0) ;11/14/97  12:01
 ;;5.0;Radiology/Nuclear Medicine;**93**;Mar 16, 1998;Build 3
 ;
 ; 07/14/2008 BAY/KAM Rem Call 257549 Mod request for alert text
OENOTE ; Fire off OE/RR notification for [abnormal, amended] rad results
 ; back door fires off this notif. regardless of oe/rr version
 ; because oe/rr doesn't get abnormal/amended info in HL7 msgs
 I $$ORVR^RAORDU()=2.5 D
 . N RAWITCH S X1=$S($D(^RAMIS(71,+$P(X,"^",2),0)):$P(^(0),"^"),1:"")
 . S ORBPMSG=$S($D(RAAB):"Abnormal ",1:"")_"Imaging Results: "
 . S:$D(^RAO(75.1,+$P(X,"^",11),0)) ORIFN=+$P(^(0),"^",7)
 . S RAWITCH=$$OE1009() ; determine OE/RR Notification
 . Q:RAWITCH=-1  ; invalid OE/RR Notification, quit!
 . I RAWITCH=53!(+$O(^RARPT(RARPT,"ERR",0))) D
 .. S:$D(RAAB) ORBPMSG="Amended/"_ORBPMSG
 .. S:'$D(RAAB) ORBPMSG="Amended "_ORBPMSG
 .. Q
 . N RAVAR S RAVAR=$L(ORBPMSG),RAVAR=70-RAVAR
 . S ORBPMSG=ORBPMSG_$E(X1,1,RAVAR)
 . S ORNOTE(RAWITCH)=$S($D(ORIFN):1,1:"") D NOTE^ORX3
 . Q
 I $$ORVR^RAORDU()'<3 D
 . ; Recall RADFN, RADTI & RACNI from the RASAVE array
 . S RADFN=$G(RASAVE("RADFN")),RADTI=$G(RASAVE("RADTI"))
 . S RACNI=$G(RASAVE("RACNI"))
 . D OE3(RADFN,RADTI,RACNI,X)
 . Q
 Q
OE1009() ; Determine the notification informing OE/RR
 ; Output: OE/RR Notification [ ien for ^ORD(100.9, ]
 N RANOTY ; used to identify type of OE/RR Notification
 S RANOTY=-1 ; initalize to error condition
 I $D(RAAB) S RANOTY=25 ; Abnormal Imaging Results
 E  D
 . I '+$O(^RARPT(RARPT,"ERR",0))  S RANOTY=22 ; Imaging Results V'fied
 . E  S RANOTY=$S($$ORVR^RAORDU'<3:53,1:22) ; Imaging Result Amended
 . Q
 Q RANOTY
 ;
OE3(RADFN,RADTI,RACNI,X) ; Fire off oe/rr notifications, version 3.0+
 ; Input: 'RADFN': Patient DFN   <->   'RADTI': exam timestamp (inverse)
 ;        'RACNI': Exam ien      <->   'X'    : exam zero node
 ; *** 'RARPT' is assumed to exist and be a valid ien in file 74. ***
 N RA751,RAIENS,RAMSG,RANOTE,RAOIFN,RAREQPHY,X1
 S X1=$S($D(^RAMIS(71,+$P(X,"^",2),0)):$P(^(0),"^"),1:"")
 S RA751=$G(^RAO(75.1,+$P(X,"^",11),0))
 S RAIENS=RADTI_"~"_RACNI
 I $D(RAAB) D  ; abnormal Dx code associated with report
 . S:'+$O(^RARPT(RARPT,"ERR",0)) RANOTE="25^Abnl Imaging Reslt, Needs Attn: "_$E(X1,1,25)
 . S:+$O(^RARPT(RARPT,"ERR",0)) RANOTE="53^Amended/Abnormal Imaging Results: "_$E(X1,1,20)
 . Q
 I '$D(RAAB)  D  ; no abnormal Dx code with this report
 . S:'+$O(^RARPT(RARPT,"ERR",0)) RANOTE="22^Imaging Results,Non Critical: "_$E(X1,1,30)
 . S:+$O(^RARPT(RARPT,"ERR",0)) RANOTE="53^Amended Imaging Results: "_$E(X1,1,25)
 . Q
 S RAMSG=$P($G(RANOTE),"^",2),RAOIFN=$P(RA751,"^",7),RAREQPHY(+$P(X,"^",14))=""
 D EN^ORB3(+$G(RANOTE),RADFN,RAOIFN,.RAREQPHY,RAMSG,RAIENS)
 Q
