RAHLRPT2 ;HISC/GJC-Compiles HL7 'ORU' Message Type ; 4/26/01 10:40am
 ;;5.0;Radiology/Nuclear Medicine;**47**;Mar 16, 1998;Build 21
 ;
 ;called from RAHLRPT1
 ;
 ;Integration Agreements
 ;----------------------
 ; ^DIWP(10011)
 ;
OBXTCOM ;Compile 'OBX' segment for tech comments
 S RAOBX(2)=$G(RAXX)
 S RAOBX(3)="TX",RAOBX(4)="TCM"_$E(HLECH)_"TECH COMMENT"_$E(HLECH)_"L"
 S RAOBX(12)=$$OBX11(+$P(RAZXAM,U,17)),(RAI,RAJ)=0
 F  S RAI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"L",RAI)) Q:'RAI  D
 .Q:'$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"L",RAI,"TCOM"))
 .S RAJ=RAJ+1,RAFT=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"L",RAI,"TCOM"))
 .S RAOBX(2)=$G(RAXX)+RAJ,RAOBX(6)=$$ESCAPE^RAHLRU(RAFT)
 .D BLSEG^RAHLRU1("OBX",.RAOBX)
 .Q
 S RAXX=$G(RAOBX(2))
 K RAFT,RAOBX Q
 ;
OBXCPTM ;Compile 'OBX' segment for CPT modifiers
 S RAOBX(2)=$G(RAXX)
 S RAOBX(3)="CE",RAOBX(4)="C4"_$E(HLECH)_"CPT MODIFIERS"_$E(HLECH)_"L"
 S RAOBX(12)=$$OBX11(+$P(RAZXAM,U,17)),(RAI,RAJ)=0
 F  S RAI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CMOD",RAI)) Q:'RAI  D
 .S RAJ=RAJ+1,RAPTR=+$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CMOD",RAI,0))
 .S RAOBX(2)=RAXX+RAJ,RAOBX(6)=$$CPTMOD^RAHLRU(RAPTR,HLECH,DT)
 .D BLSEG^RAHLRU1("OBX",.RAOBX)
 .Q
 S RAXX=$G(RAOBX(2))
 Q
 ;
OBXRPT ;Compile the 'OBX' segment for Report Text
 S RAOBX(2)=$G(RAXX)
 I $O(^RARPT(+$P(RAZXAM,U,17),"R",0)) D
 .S RAOBX(3)="TX",RAOBX(4)="R"_$E(HLECH)_"REPORT"_$E(HLECH)_"L"
 .S RAOBX(12)=$$OBX11^RAHLRPT2(+$P(RAZXAM,U,17))
 .K ^UTILITY($J,"W") S DIWF="",DIWR=75,(DIWL,RADIWL)=1
 .S RAI=0 F  S RAI=$O(^RARPT(+$P(RAZXAM,U,17),"R",RAI)) Q:'RAI  D
 ..S X=$G(^RARPT(+$P(RAZXAM,U,17),"R",RAI,0)) D ^DIWP
 ..Q
 .S (RAI,RAJ)=0 F  S RAI=$O(^UTILITY($J,"W",RADIWL,RAI)) Q:'RAI  D
 ..S RAJ=RAJ+1,RAOBX(2)=RAXX+RAJ
 ..S RAOBX(6)=$$ESCAPE^RAHLRU($G(^UTILITY($J,"W",RADIWL,RAI,0)))
 ..D BLSEG^RAHLRU1("OBX",.RAOBX)
 ..Q
 .S RAXX=$G(RAOBX(2))
 .Q
 K DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,RADIWL,RAOBX,^UTILITY($J,"W")
 Q
 ;
OBX11(RARPT) ;set OBX-11 (Observ. Rslt Status) correctly
 ;input : RARPT =IEN of the RAD/NUC MED REPORT record
 ;        RAZRPT=zero node of the RAD/NUC MED REPORT record
 ;return: OBX-11 (as 'Y')
 Q:RARPT=0 ""
 N Y S:$D(^RARPT(RARPT,"ERR",1,0))#2 Y="C" ;corrected result
 S:'$D(Y)#2 Y=$S(($P(^RARPT(RARPT,0),U,5)="V")!($P(^RARPT(RARPT,0),U,5)="EF"):"F",1:"R")  ;"EF" reports send "F" (Final) in OBX-11
 ;S:'$D(Y)#2 Y=$S($P(^RARPT(RARPT,0),U,5)="V":"F",1:"R")
 Q Y
 ;
