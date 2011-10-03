RAHLRPTT ;HISC/CAH AISC/SAW-Compiles HL7 'ORU' Message Type ; 4/26/01 10:40am
 ;;5.0;Radiology/Nuclear Medicine;**84,94**;Mar 16, 1998;Build 9
EN ; Continuation from RAHLRPT which has been split because the 10 k size problem
 ; & other inbound patch 84 utility
 ;
 ;Integration Agreements
 ;----------------------
 ;^%DT(10003); $$FIND1^DIC(2051); $$GET1^DIQ(2056); $$HLDATE^HLFNC(10106); $$HLNAME^HLFNC(10106)
 ;$$M11^HLFNC(10106); $$EN^VAFHLPID(263)
 ;read w/FileMan HL7 APPLICATION PARAMETER(10136)
 ;
INIT ;
 D:$D(RANOSEND)  ;Patch 84
 .N RATIEN,DIERR,RAERR
 .S RATIEN=$S(+RANOSEND:+RANOSEND,1:$$FIND1^DIC(771,"","X",RANOSEND,"","","RAERR"))
 .Q:'RATIEN!($D(RAERR)#2)
 .;RATELE is set to the value of the 'TELERADIOLOGY APPLICATION' (#1) field 0:No; 1:Yes
 .S RATELE=$P($G(^RA(79.7,RATIEN,0)),U,2) I 'RATELE K RATELE Q
 .;RATELX is set to the value of the 'RELEASE STUDY KEYWORD' (#1.2) field 
 .S RATELX=$P($G(^RA(79.7,RATIEN,0)),U,4)
 .S:'$L(RATELX) RATELX="Released for local dictation by National Teleradiology"
 S RASET=0,RACN0=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 S:'$D(RARPT) RARPT=+$P(RACN0,"^",17)
 Q
SETUP ; Setup basic examination information
 S:RASET RACN0=^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)
 S RADTE0=9999999.9999-RADTI,RADTECN=$E(RADTE0,4,7)_$E(RADTE0,2,3)_"-"_+RACN0,RARPT0=^RARPT(RARPT,0)
 S RAPROC=+$P(RACN0,U,2),RAPROCIT=+$P($G(^RAMIS(71,RAPROC,0)),U,12),RAPROCIT=$P(^RA(79.2,RAPROCIT,0),U,1)
 S RAPRCNDE=$G(^RAMIS(71,+RAPROC,0)),RACPT=+$P(RAPRCNDE,U,9)
 S RACPTNDE=$$NAMCODE^RACPTMSC(RACPT,DT)
 S Y=$$HLDATE^HLFNC(RADTE0) S RADTE0=$S(Y:Y,1:HLQ),Y=$$M11^HLFNC(RADFN)
 Q
TELE ;Setting TELERAD info for RAHLTCPB
 ;RATELEKN = Keyword to get the name and NPI of teleradiologist
 ;RATELENM = Teleradiologist Name
 ;RATELEPI = Teleradiologist NPI
 ;RATELEDR = Default DX for terad 'R' report
 ;RATELEDF = Default DX for terad 'F' report
 N RATIEN,DIERR,RAERR
 S RATIEN=$$FIND1^DIC(771,"","X",$G(HL("SAN")),"","","RAERR")
 Q:'RATIEN!($D(RAERR)#2)
 S RATELE=$P($G(^RA(79.7,RATIEN,0)),U,2) ;Patch 84
 I 'RATELE K RATELE Q  ;Q:'RATELE original; changed w/P94 Remedy 259432
 S RATELEKN=$P($G(^RA(79.7,RATIEN,0)),U,3) S:'$L(RATELEKN) RATELEKN="Report dictated by Teleradiologist: "
 S RATELEDR=$P($G(^RA(79.7,RATIEN,2)),U) K:'$L(RATELEDR) RATELEDR
 S RATELEDF=$P($G(^RA(79.7,RATIEN,2)),U,2) K:'$L(RATELEDF) RATELEDF
 Q
PID ;Compile 'PID' Segment
 I HL("VER")']"2.2" D
 .S X1="",X1="PID"_HLFS_HLFS_$G(VA("PID"))_HLFS_Y_HLFS_HLFS S X=VADM(1),Y=$$HLNAME^HLFNC(X) S X1=X1_Y_HLFS_HLFS
 .S X=RAVADM(3),Y=$$HLDATE^HLFNC(X) S X1=X1_Y_HLFS_$S(VADM(5)]"":$S("MF"[$P(VADM(5),"^"):$P(VADM(5),"^"),1:"O"),1:"U") S:$P(VADM(2),"^")]"" $P(X1,HLFS,20)=$P(VADM(2),"^") S RAN=RAN+1,HLA("HLS",RAN)=X1
 I HL("VER")]"2.2" S RAN=RAN+1,HLA("HLS",RAN)=$$EN^VAFHLPID(DFN,"2,3,5,7,8,19,20")
 Q
RESEND(RADFN,RADTI,RACNI) ; re-send exam message(s) to HL7 subscribers
 ;
 Q:'$G(RADFN)!'$G(RADTI)!'$G(RACNI)
 Q:'$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))  Q:'$P(^(0),U,2)
 N RABD,RAEDTT,QUIT
 ;
 I '$D(DT) D ^%DT S DT=Y
 ;
 S RAEDTT=$$RAED(RADFN,RADTI,RACNI)
 Q:'$L(RAEDTT)
 D:RAEDTT[",REG," REG^RAHLRPC
 D:RAEDTT[",CANCEL," CANCEL^RAHLRPC
 D:RAEDTT[",EXAM,"
 .S $P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),"^",30)="" ;Reset sent flag
 .N RAEXMDUN D 1^RAHLRPC
 D:RAEDTT[",RPT,"
 .N RANOSEND,RARPT D RPT^RAHLRPC
 Q
 ;
RAED(RADFN,RADTI,RACNI) ; identify correct ^RAHLRPC entry point(s)
 ;
 N RASTAT,RAIMTYP,RAORD,RETURN,RARPT
 S RASTAT=""
 ;
 S RETURN=",REG,"
 ;
 S RASTAT=$$GET1^DIQ(70.03,RACNI_","_RADTI_","_RADFN,3,"I")
 S RARPT=$$GET1^DIQ(70.03,RACNI_","_RADTI_","_RADFN,17,"I")
 ;
 S RAIMTYP=$$GET1^DIQ(72,+RASTAT,7) Q:'$L(RAIMTYP) ""
 S RAORD=$$GET1^DIQ(72,+RASTAT,3)
 ;
 S:RAORD=0 RETURN=RETURN_"CANCEL,"
 ;
 S:$$GET1^DIQ(72,+RASTAT,8)="YES" RETURN=RETURN_"EXAM," ; Generate Examined HL7 Message
 ;
 D:RETURN'[",EXAM,"
 .; also check previous statuses for 'Generate Examined HL7 Message'
 .F  S RAORD=$O(^RA(72,"AA",RAIMTYP,RAORD),-1) Q:+RAORD<1  D  Q:RETURN[",EXAM,"
 ..S RASTAT=$O(^RA(72,"AA",RAIMTYP,RAORD,0))
 ..S:$$GET1^DIQ(72,+RASTAT,8)="YES" RETURN=RETURN_"EXAM,"
 ;
 ; Check if Verified Report exists
 I RARPT]"",$$GET1^DIQ(74,RARPT_",",5,"I")="V" S RETURN=RETURN_"RPT,"
 ;
 Q RETURN
