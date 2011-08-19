RAORD3 ;HISC/CAH - AISC/RMO-Detailed Request Display Cont. ;05/05/09  10:31
 ;;5.0;Radiology/Nuclear Medicine;**5,15,21,27,45,41,75,99**;Mar 16, 1998;Build 5
 ;Supported IA #2056 reference to ^DIQ
 ;Supported IA #10103 reference to ^XLFDT
 I $$PTSEX^RAUTL8(RADFN)="F" D  ;display pregnancy status for females ptch 45, P#99 changed Pregnancy title.'Pregnancy Screen:' field. This field shall be a display-only field
 .W !,"Pregnant at time of order entry: ",?22,$S($P(RAORD0,"^",13)="y":"YES",$P(RAORD0,"^",13)="n":"NO",1:"UNKNOWN")
 .N RA700332,RA700380
 .S RA700332=$$GET1^DIQ(70.03,$G(RACNI)_","_$G(RADTI)_","_$G(RADFN),32)
 .S RA700380=$$GET1^DIQ(70.03,$G(RACNI)_","_$G(RADTI)_","_$G(RADFN),80)
 .I RA700332'="" W !,"Pregnancy Screen: ",RA700332
 .I RA700380'="" W !,"Pregnancy Screen Comment: ",RA700380
 W:$P(RAORD0,"^",24)="y" !?12,"*** Universal Isolation Precautions ***" W:$D(RA("VDT")) !?8,$C(7),"** Note:  Request Associated with Visit on ",RA("VDT")," **"
 W:$D(RA("RDT"))&($D(RAPKG)) !,"Desired Date:",?22,RA("RDT") W:$D(RA("PDT")) !,"Pre-op Scheduled:",?22,RA("PDT") S RAOSTS=$P(RAORD0,"^",5) I RAOSTS=8,$D(RA("SDT")) W !,"Exam Scheduled:",?22,RA("SDT")
 I RAOSTS=1 D USERCAN
 W !,"Transport:",?22,RA("TRAN")
 I $L(RA("STY_REA")) D DIWP^RAUTL5(1,68,"Reason for Study: "_RA("STY_REA")) ;P75
 D ODX^RABWUTL(RAOIFN) ;display Ordering DX and Clin Inds, Billing Aware
 I $O(^RAO(75.1,RAOIFN,"H",0)) D  Q:$G(OREND)=1!($G(RAX)="^")
 . D CHIST(RAOIFN)
 . Q
 I RAOSTS=1!(RAOSTS=3) W !,"Reason ",$S(RAOSTS=1:"Cancelled",1:"Held"),":",?22,$S($D(^RA(75.2,+$P(RAORD0,"^",10),0)):$E($P(^(0),"^"),1,50),$P(RAORD0,"^",27)]"":$E($P(RAORD0,"^",27),1,50),1:"UNKNOWN") D TEXT:RAOSTS=3
 W:$D(RA("ST")) !,"Exam Status:",?22,RA("ST") W:$D(RA("ILC")) !,"Request Submitted to: ",RA("ILC")
 G A:$P(RAORD0,"^",11)'="y",A:'$D(RADTI)!('$D(RACNI))
 W !!?7,$C(7),"** Note:  Request has been changed by the Imaging Service **"
A I $D(^RAO(75.1,RAOIFN,"T")) D ASK:$E(IOST,1,2)="C-" I $D(DIRUT) S RAX="^" K DIRUT
 Q:Y'=1  I $D(RAPKG),RAX'="^" R !!,"Press return to continue or ""^"" to escape ",X:DTIME S RAX=$E(X)
 Q
 ;
ASK W ! S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you wish to display request status tracking log",DIR("?")="Enter 'YES' if status tracking log should be displayed, or 'NO' if not." D ^DIR K DIR S:$D(DIRUT) OREND=1 Q:$D(DIRUT)!(Y=0)
 W !!?20,"*** Request Status Tracking Log ***",!,"Date/Time",?18,"Status",?31,"User",?44,"Reason",!,"-----------------",?18,"------------",?31,"-----------",?44,"------------------------------------"
 F RALNB=0:0 S RALNB=$O(^RAO(75.1,RAOIFN,"T",RALNB)) Q:'RALNB  I $D(^(RALNB,0)) S RATORD0=^(0) D PRTLOG
Q K RALNB,RATORD0,RATODT,RATOST,RATREA,RATUSR Q
 ;
PRTLOG S (X,RATODT)=$P(RATORD0,"^") I X S RATODT=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) I $P(X,".",2) D TIME^RAUTL1 S RATODT=RATODT_" "_X
 S RATOST=$P($P(^DD(75.12,2,0),$P(RATORD0,"^",2)_":",2),";"),RATUSR=$S($D(^VA(200,+$P(RATORD0,"^",3),0)):$P(^(0),"^"),1:"")
 S RATREA=$S($D(^RA(75.2,+$P(RATORD0,"^",4),0)):$P(^(0),"^"),1:"")
 W !,RATODT,?18,$E(RATOST,1,12),?31,$E(RATUSR,1,11),?44,$E(RATREA,1,35) I $E(RATREA,36,70)'="" W !,?44,$E(RATREA,36,70)
 Q
TEXT ; display Hold Description text
 Q:'$O(^RAO(75.1,RAOIFN,1,0))
 W !,"Hold Description:",!
 K ^UTILITY($J,"W"),^(1) S DIWL=22,DIWR=75,DIWF="W"
 F RARR=0:0 S RARR=$O(^RAO(75.1,RAOIFN,1,RARR)) Q:RARR'>0  S X=^(RARR,0) D ^DIWP
 D ^DIWW
 Q
CHIST(RAY) ; display Clinical History (if applicable)
 Q:RAY'?1N.N  Q:'$O(^RAO(75.1,RAY,"H",0))
 N DIWF,DIWL,DIWR,RABAN,RARR,RAXIT
 K ^UTILITY($J,"W") S DIWL=22,DIWR=75,DIWF="",RARR=0
 F  S RARR=$O(^RAO(75.1,RAY,"H",RARR)) Q:RARR'>0  D
 . ; store into ^UTILITY($J,"W")
 . S X=$G(^RAO(75.1,RAY,"H",RARR,0)) D ^DIWP
 . Q
 S (RARR,RAXIT)=0,RABAN="Clinical History: "
 I $Y>(IOSL-4) D
 . S RAXIT=$$EOS()
 . I 'RAXIT,('$D(RAPKG)) W @IOF
 . I 'RAXIT,($D(RAPKG)) D HDR^RAORD2
 . Q
 I RAXIT S:$D(RAPKG) RAX="^" K ^UTILITY($J,"W") Q
 W !,RABAN
 F  S RARR=$O(^UTILITY($J,"W",DIWL,RARR)) Q:RARR'>0  D  Q:RAXIT
 . S X=$G(^UTILITY($J,"W",DIWL,RARR,0)) W ?22,X,!
 . I $Y>(IOSL-4) D
 .. S RAXIT=$$EOS()
 .. I 'RAXIT,('$D(RAPKG)) W @IOF
 .. I 'RAXIT,($D(RAPKG)) D HDR^RAORD2 W !
 .. Q
 . Q
 S:RAXIT&($D(RAPKG)) RAX="^" K ^UTILITY($J,"W") ; kill global
 Q
EOS() ; End of screen check for both OE/RR & Rad/Nuc Med
 ; Var List: $D(RAPKG) entry through Rad/Nuc Med, else through OE/RR
 ; Passes back 'Y', Y=1 do not continue, Y=0 continue
 ; NOTE: Sets OREND if code entered through OE/RR.  This code may be
 ;       hit when the user accesses the 'Act On Existing Orders' through
 ;       OE/RR.  'Detailed Order Display' (8^RAORR) hits ENDIS^RAORD2
 ;       which mimics (hits same code) the Rad/Nuc Med 'Detailed Request
 ;       Display' option.  The old PGBRK^ORUHDR code set OREND to 0
 ;       initially, (even though it is set to 0 upon entering this
 ;       sub-routine) and re-set it to 1 if the user enters an '^' at
 ;       the "Enter RETURN to continue or '^' to exit:" prompt.
 S Y=$$EOS^RAUTL5() S:'$D(RAPKG) OREND=Y
 Q Y
USERCAN ;user who cancelled this request
 Q:$P($G(^RAO(75.1,RAOIFN,0)),U,5)'=1  ;only look at 'discontinued'
 N RA8,RA9 S RA8=0
 F  S RA8=$O(^RAO(75.1,RAOIFN,"T",RA8)) Q:'RA8  I $G(^(RA8,0))]"",$P(^(0),U,2)=1 S RA9=RA8 ; find latest ien of 'discontinued'
 S RA("ODT")="",RA("USR")=""
 I $G(RA9) D USERCAN1
 E  D USERCAN2
 W !,"Cancelled:",?22,RA("ODT") W:RA("USR")]"" "  by ",RA("USR")
 K RA("ODT"),RA("USR")
 Q
USERCAN1 ;use request track times to get when and who cancelled
 S X=$P(^RAO(75.1,RAOIFN,"T",RA9,0),U) D:X TRDT
 S RA("USR")=$P($G(^VA(200,+$P(^RAO(75.1,RAOIFN,"T",RA9,0),U,3),0)),U)
 Q
USERCAN2 ;use vars DUZ and RAORD0 to get "who" and "when" cancelled
 S X=$P($G(RAORD0),U,18) D:X TRDT
 ; don't use  duz  if within any one of 3 rad request options
 Q:$D(RASCREEN)  Q:$D(RAOPT("ORDERPRINTS"))  Q:$D(RAOPT("ORDERPRINTPAT"))
 S RA("USR")=$P($G(^VA(200,$G(DUZ),0)),U)
 Q
TRDT S:$P(X,".",2) X=$P(X,".")_"."_$$NOSECNDS($P(X,".",2))
 S RA("ODT")=$$FMTE^XLFDT(X,"1P")
 Q
NOSECNDS(X) ; If a timestamp is associated with a date, strip off seconds.
 ; Input : X-timestamp (153048)
 ; Output: (1530)
 Q $E(X,1,4)
