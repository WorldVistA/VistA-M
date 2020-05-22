RAUTL1 ;HISC/CAH,FPT,GJC AISC/MJK,RMO-Utility Routine ; Nov 26, 2019@16:15:02
 ;;5.0;Radiology/Nuclear Medicine;**5,9,18,71,82,84,94,47,162**;Mar 16, 1998;Build 2
 ;last modification by SS for P18 June 19,00
 ;07/28/2008 BAY/KAM RA*5*94 Remove patch 81 from 2nd line of routine
 ;02/10/2006 BAY/KAM RA*5*71 Add ability to update exam data to V/R
 ;
 ;Integration Agreements
 ;----------------------
 ;DIC(10006); DIE(10018); FILE^DIE(2053); UPDATE^DIE(2053); EN^ORB3(1362); NOTE^ORX3(868)
 ;
 I "IOSCR"'[X!(X="") S X="Unknown" Q
 G @($E(X))
 ;Set X=Inpatient Location
I S X=$S($D(^DIC(42,+$P(^RADPT(D0,"DT",D1,"P",D2,0),"^",6),0)):$P(^(0),"^"),1:"Unknown")
 Q
 ;
 ;Set X=Outpatient Location
O S X=$S($D(^SC(+$P(^RADPT(D0,"DT",D1,"P",D2,0),"^",8),0)):$P(^(0),"^"),1:"Unknown")
 Q
 ;
 ;Set X=Contract/Sharing Agreement patient location
S ;
C S X=$S($D(^DIC(34,+$P(^RADPT(D0,"DT",D1,"P",D2,0),"^",9),0)):$P(^(0),"^"),1:"Unknown")
 Q
 ;
 ;Set X=Research patient location
R S X=$S($D(^RADPT(D0,"DT",D1,"P",D2,"R")):$P(^("R"),"^"),1:"Unknown") Q
 ;
 ;Set X=time of day in external format (ex: 2:28 PM)
NOW S %=$P($H,",",2),X=DT_(%\60#60/100+(%\3600)+(%#60/10000)/100) D TIME
 Q
 ;Input X=FM date/time, Output X=time (external format)
TIME S X=$E($P(X,".",2)_"0000",1,4),%=X>1159 S:X>1259 X=X-1200 S X=X\100_":"_$E(X#100+100,2,3)_" "_$E("AP",%+1)_"M" S:$P(X,":")=0 X=12_":"_$P(X,":",2)
 Q
 ;
ELAPSED ;Pass parameters X (from date) and X1 (to date)
 ;Variable Y is returned as either an elapsed time in the form DD:HH:MM where DD=days, HH=hours, MM=minutes or as the string 'Neg. Time' indicating a negative elapsed time
 ;Variable Y1 is returned as the # of minutes of elapsed time
 I '$D(RAMTIME) S DIC="^DD(""FUNC"",",DIC(0)="FX",RAX=X,X="MINUTES" D ^DIC K DIC S X=RAX S:$D(^DD("FUNC",+Y,1)) RAMTIME=^(1) I '$D(RAMTIME) W $C(7),!!,"Can't continue --- No 'MINUTES' function found in File Manager" K Y,Y1 G Q
 X RAMTIME S Y1=X I X<0 S Y="Neg. Time" G Q
MINUTS S X(1)=X\1440,X=X-(1440*X(1)),X(2)=X\60,X(3)=X-(60*X(2)),Y=$E(100+X(1),2,3)_":"_$E(100+X(2),2,3)_":"_$E(100+X(3),2,3)
Q K RAX,X Q
 ;
UPDATE ;Entry point for Update Rad/Nuc Med Exam Status option
 I $O(RACCESS(DUZ,""))="" D SETVARS^RAPSET1(0)
 I $G(RAIMGTY)="" D SETVARS^RAPSET1(1)
 I $G(RAIMGTY)="" K XQUIT Q  ; didn't sign-on to an imaging location
 D ^RACNLU G UPQ:"^"[X
 I $D(^RA(72,"AA",RAIMGTY,9,+RAST)),'$D(^XUSEC("RA MGR",DUZ)) W !!?3,$C(7),"You do not have the appropriate access privileges to act on completed exams." G UPDATE
 I $D(^RA(72,"AA",RAIMGTY,0,+RAST)) W !!?3,$C(7),"Exam has been 'cancelled' therefore the status cannot be changed." G UPDATE
 ;D UP1 I RAOR>0 S DA(2)=RADFN,DA(1)=RADTI,DA=RACNI,DIE="^RADPT("_DA(2)_",""DT"","_DA(1)_",""P"",",DR="100///""NOW""",DR(2,70.07)="2///U;3////"_$S($G(RADUZ):RADUZ,1:DUZ) D ^DIE
 D UP1 I RAOR>0 D
 .L +^RADPT(RADFN,"DT",RADTI,"P",RACNI):$G(DILOCKTM,3)
 .N RAIEN
 .S RAIENS="+1,"_RACNI_","_RADTI_","_RADFN_","
 .S RAFDA(70.07,RAIENS,.01)="NOW"
 .K RAERR D UPDATE^DIE("E","RAFDA","RAIEN","RAERR")
 .K RAFDA,RAIENS
 .I $D(RAERR) S RAERR="Error in update of 70.07, .01 "_$G(RAERR("DIERR",1,"TEXT",1)) K RAERR("DIERR") L -^RADPT(RADFN,"DT",RADTI,"P",RACNI) K RAIEN Q
 .S RAIENS=RAIEN(1)_","_RACNI_","_RADTI_","_RADFN_","
 .S RAFDA(70.07,RAIENS,2)="U"
 .S RAFDA(70.07,RAIENS,3)=$S($G(RADUZ):RADUZ,1:DUZ)
 .D FILE^DIE(,"RAFDA","RAERR")
 .L -^RADPT(RADFN,"DT",RADTI,"P",RACNI)
 .I $D(RAERR) S RAERR="Error in update of 70.07, 2,3 "_$G(RAERR("DIERR",1,"TEXT",1)) K RAERR("DIERR")
UPQ K RAFDA,RAIENS
 K %,D,DA,DE,DIC,DIE,DQ,DR,I,J,POP,RACS,RAEND,RAF5,RAFL,RAFST,RAI,RAIX,RAJ1,RAORDIFN,RAPRIT,RAHEAD,RASN,RAOR,RASTI,RASSN,RADATE,RAST,RACN,RACNI,RADFN,RADTE,RADTI,RANME,RAPRC,RARPT,X,Y,Z,^TMP($J,"RAEX"),C,DIPGM Q
 ;
 ;Exam status updating and accompanying updates to status log, oe/rr
UP1 N RA8,RAEXEDT S RA8=0 ;use this to flag when one alert has been sent
 ;Line change for RA*5*82
 S RAEXEDT=$$CMPAFTR^RAO7XX(1) ;P18 if procedure changed in RAEDCN or RAEDPT sends XX message to CPRS if needed
 ; RA EDITCN and RA EDITPT should process this case only
 I $D(RAOPT("EDITCN"))!($D(RAOPT("EDITPT"))) D UP2,UPK Q
 ; see if this case belongs to a printset
 N:'$D(RAPRTSET) RAPRTSET N:'$D(RAMEMARR) RAMEMARR
 D EN2^RAUTL20(.RAMEMARR) ;043099 always recalculate RAPRTSET
 ; if not print set, then just process this case only
 I 'RAPRTSET D UP2,UPK Q
 ;case belongs to print set, so process all members of same print set
 N RACNISAV,RA7
 S RACNISAV=RACNI,RA7=0
 F  S RA7=$O(RAMEMARR(RA7)) Q:RA7=""  S RACNI=RA7 D UP2
 S RACNI=RACNISAV
 G UPK
UP2 ;Remedy Call 124379 Patch *71 BAY/KAM Added next line
 ;Patch RA*5*82 next line commented out
 ;D:$G(RAHLTCPB)'=1 EXM^RAHLRPC
 ;
 S DA(2)=RADFN,DA(1)=RADTI,DA=RACNI,DIE="^RADPT("_DA(2)_",""DT"","_DA(1)_",""P"","
 N RAAFTER,RABEFORE
 D STUFF^RASTREQ1 I RAOR<0,$D(RASN) W:'$D(RAONLINE)&('$D(ZTQUEUED)) !?5,"...exam status remains '",RASN,"'." K DIE,RACS,RAPRIT D  Q
 .D:$G(RAEXEDT) EXM^RAHLRPC ; DO statement added by RA*5*82
 ;W:'$D(RAONLINE)&('$D(ZTQUEUED)) !?3,"...will now designate exam status as '",RASN,"'... for case no. ",$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),U)
 N RASSAN,RACNDSP S RASSAN=$$SSANVAL^RAHLRU1(RADFN,RADTI,RACNI)
 S RACNDSP=$S((RASSAN'=""):RASSAN,1:$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),U))
 I $$USESSAN^RAHLRU1() W:'$D(RAONLINE)&('$D(ZTQUEUED)) !?3,"...will now designate exam status as '",RASN,"'",!?25,"...for case no. ",RACNDSP
 I '$$USESSAN^RAHLRU1() W:'$D(RAONLINE)&('$D(ZTQUEUED)) !?3,"...will now designate exam status as '",RASN,"'... for case no. ",$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),U)
 ; S DR="3////"_RASTI_$S($P(RAMDV,"^",10):";75///^S X=$$MIDNGHT^RAUTL5($$NOW^XLFDT())",1:"")
 ; user duz could be in RADUZ, if session is from the Voice recognition
 ;S DR(2,70.05)=$S($P(RAMDV,"^",11)&('$D(ZTQUEUED)):".01;",1:"")_"2////"_RASTI_";3////"_$S($G(RADUZ):RADUZ,1:DUZ)
 ;D ^DIE
 ;*** P162 mod on timeout INC7406782 use DILOCKTM
 ;*** else default to three
 L +^RADPT(RADFN,"DT",RADTI,"P",RACNI):$G(DILOCKTM,3)
 ;*** P162 end
 N RAIEN
 S RAIENS=RACNI_","_RADTI_","_RADFN_","
 S RAFDA(70.03,RAIENS,3)=RASTI
 K RAERR D FILE^DIE(,"RAFDA","RAERR")
 I $D(RAERR) S RAERR="Error in update of 70.03 "_$G(RAERR("DIERR",1,"TEXT",1)) K RAERR("DIERR") L -^RADPT(RADFN,"DT",RADTI,"P",RACNI) G UP2K ;L - P18
 I $P(RAMDV,"^",10) D
 .N RAERR2
 .S RAIENS="+1,"_RACNI_","_RADTI_","_RADFN_","
 .S RAFDA(70.05,RAIENS,.01)=$$MIDNGHT^RAUTL5($$NOW^XLFDT())
 .D UPDATE^DIE(,"RAFDA","RAIEN","RAERR")
 .K RAFDA,RAIENS
 .I $D(RAERR) S RAERR="Error in update of 70.05, .01 "_$G(RAERR("DIERR",1,"TEXT",1)) K RAERR("DIERR")
 .Q:'$D(RAIEN(1))
 .I $P(RAMDV,"^",11),('$D(ZTQUEUED)) D
 ..S DIE=DIE_RACNI_",""T"",",DA=RAIEN(1)
 ..S DR=".01"
 ..D ^DIE
 .S RAIENS=RAIEN(1)_","_RACNI_","_RADTI_","_RADFN_","
 .S RAFDA(70.05,RAIENS,2)=RASTI
 .S RAFDA(70.05,RAIENS,3)=$S($G(RADUZ):RADUZ,1:DUZ)
 .K RAERR2 D FILE^DIE(,"RAFDA","RAERR2")
 .I $D(RAERR2) S RAERR2="Error in update of 70.05 2,3 "_$G(RAERR2("DIERR",1,"TEXT",1)),RAERR=$S($D(RAERR):RAERR_";"_RAERR2,1:RAERR2)
 ;Patch RA*5*82 added next line send EXM message after status update, not before the update
 D:'$D(RAERR) EXM^RAHLRPC
 L -^RADPT(RADFN,"DT",RADTI,"P",RACNI)
 ;
UP2K K DE,DQ,DIE,DR,RAFDA,RAIENS K:$D(RAERR) RACS,RAPRIT Q:$D(RAERR)  W:'$D(RAONLINE)&('$D(ZTQUEUED)) !?10,"...exam status ",$S($G(RABEFORE)>$G(RAAFTER):"backed down",1:"successfully updated"),"." D ^RAORDC
 I RA8=0,$D(^RA(72,RASTI,"ALERT")),$P(^("ALERT"),"^")="y" D:$$ORVR^RAORDU()=2.5 OERR D:$$ORVR^RAORDU()'<3 OERR3 S RA8=1
 I $D(^RA(72,RASTI,0)),$P(^(0),"^",3)>1,RACS'="Y",$S('$D(RAF5):1,$P(^DIC(42,+RAF5,0),U,3)="D":1,1:0) D EN^RAUTL0
 K RACS,RAORDIFN,RAPRIT,RAF5
 Q
UPK K ORIFN,ORVP,ORNOTE,ORBPMSG,RACS,RAORDIFN,RAPRIT,RAF5
 Q
OERR ;Send Alert to OERR after pt examined
 S ORVP=RADFN_";DPT(",ORBPMSG="Rad Pt Examined - "_$S($D(^RAMIS(71,RAPRIT,0)):$E($P(^(0),"^"),1,24),1:"Unknown") S:$D(^RAO(75.1,+RAORDIFN,0)) ORIFN=+$P(^(0),"^",7) S ORNOTE(21)=$S($D(ORIFN):1,1:"") D NOTE^ORX3
 Q
OERR3 ; Send RADIOLOGY PATIENT EXAMINED notification via oe/rr v3
 ; Called from UP1
 ;
 ; RADFN,RADTI,RACNI,RAPRIT must be defined
 Q:'$D(RADFN)!('$D(RADTI))!('$D(RACNI))!('$D(RAPRIT))
 ;
 N RAIENS,RAMSG,RAOIFN,RAOSTS,RAONODE,RADPTNDE,RAREQPHY
 S RADPTNDE=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 S RAOIFN=$P(RADPTNDE,U,11) Q:'RAOIFN  ;file 75.1 ien
 S RAONODE=$G(^RAO(75.1,+RAOIFN,0))
 S RAOSTS=$P(RAONODE,U,5) Q:RAOSTS'=6  ;active exams only
 S RAOIFN=$P(RAONODE,U,7) ;file 100 ien
 S RAREQPHY=+$P(RADPTNDE,U,14) ;ordering provider
 S RAREQPHY(RAREQPHY)=""
 S RAMSG="Imaging Pt Examined - "_$S($D(^RAMIS(71,RAPRIT,0)):$E($P(^(0),U),1,24),1:"Unknown"),RAMSG=$E(RAMSG,1,51)
 S RAIENS=RADTI_"~"_RACNI
 ;
 ; oe parameters:
 ;         ORN: notification id (#100.9 ien)
 ;         |     ORBDFN: patient id (#2 ien)
 ;         |     |     ORNUM: order number (#100 ien)
 ;         |     |     |        ORBADUZ: recipient array
 ;         |     |     |        |     ORBPMSG: message text
 ;         |     |     |        |     |      ORBPDATA exam dt~case iens
 ;         |     |     |        |     |      |
 D EN^ORB3(21,RADFN,RAOIFN,.RAREQPHY,RAMSG,RAIENS)
 Q
 ;
 ;Called by many report programs. Sets RACRT() array containing all
 ;exam statuses that are to be included on the report.  RACRT is set
 ;to the piece of the Exam Status File #72 record that corresponds
 ;to the report being generated.
CRIT F I=0:0 S I=$O(^RA(72,I)) Q:'I  I $D(^(I,.3)),$P(^(.3),"^",RACRT)="y" S RACRT(I)=""
 Q
