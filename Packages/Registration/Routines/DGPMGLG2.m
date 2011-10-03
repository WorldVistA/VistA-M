DGPMGLG2 ;ALB/LM - G&L GENERATION, CONT.; 24 MAY 90
 ;;5.3;Registration;**12,34,418**;Aug 13, 1993
 ;
 ;Finds 2 most recent locations and treating specialties for the
 ;corresponding admission (note that ASIH creates its own admission,
 ;and its TS's and wards apply to that admit only.)
 ;
 ;MV("LWD")= last ward  (actually, current ward for this MN)
 ;MV("PWD")= previous ward (just prior to MV("LWD"))
 ;MV("LTS")= last TS (actually, current TS for this MN)
 ;MV("LTS")= previous TS (just prior to MV("LTS"))
 ;
 ;Note:  ASIH is a special case, as the movement TO ASIH contains the
 ;first ASIH location and TS, which do not really apply to the NHCU/DOM
 ;corresponding admission.
 ;Thus, when returning from ASIH, the corresponding Previous data
 ;must be found in the movement prior to the move TO ASIH.
 ;
A D LAST,^DGPMGLG5
Q K X,X3,J,J1,J2
 Q
 ;
LAST S (D,MV("LWD"),MV("PWD"),MV("LTS"),MV("PTS"),MV("ASIH"),ZMV("LWD"),ZMV("LTS"),ATS,PTS)="",(WDC,TSC)=0
 ;
 I "^13^42^43^44^45^47^"'[("^"_+MV("MT")_"^") S:$P(MD,"^",6)]"" MV("LWD")=$P(MD,"^",6) ;  Last Ward
 I "^13^"[("^"_+MV("MT")_"^") S:$P(MD,"^",6)]"" ZMV("LWD")=$P(MD,"^",6) ;  Last Ward
 I "^7^"[("^"_+MV("MT")_"^") S:$P(AD,"^",6)]"" MV("LWD")=$P(AD,"^",6) ;  Last Ward
 ;  check for corres. movement for location, If admit, Quit
 I +MV("MT")=20,$P(MD,"^",24)]"",$D(^DGPM(+$P(MD,"^",24),0)) S:$P(^(0),"^",6)]"" MV("LWD")=$P(^(0),"^",6) I +MV("TT")=6,$P(^DGPM($P(MD,"^",24),0),"^",2)=1 Q
 I "^13^42^43^44^45^47^"'[("^"_+MV("MT")_"^") S:$P(MD,"^",9)]"" MV("LTS")=$P(MD,"^",9) ;  Last TS
 I "^13^"[("^"_+MV("MT")_"^"),$P(MD,"^",15)]"" S X=$O(^DGPM("ATS",DFN,$P(MD,"^",15),0)) I X D  ; looks for ASIH  admisssion
 .S ZMV("LTS")=$O(^DGPM("ATS",DFN,$P(MD,"^",15),X,0)) ; Last TS
 I ZMV("LTS")]"" S ZMV("LTS")=ZMV("LTS")_"^"_$S('$D(^DIC(45.7,+ZMV("LTS"),0)):"NO TS",$P(^(0),"^",3)]"":$P(^(0),"^",3),$P(^(0),"^")]"":$E($P(^(0),"^"),1,5),1:"NO TS") ;  Last TS
 ;
 S J=9999999.9999999-(MD+($P(MD,"^",22)/10000000))
 F  S J=$O(^DGPM("APMV",DFN,MV("CA"),J)) Q:'J!(D)  D
 .I MV("MT")=14,MV("LWD"),'MV("PWD") D ASIHR^DGPMGLG4 Q  ;checks if return from ASIH
 .I MV("LWD"),MV("MT")=20,$F("^13^43^44^45^",U_$P(MDP,"^",18)_U),'MV("PWD") D ASIHR^DGPMGLG4 Q  ;return from ASIH, TS change
 .S J2=$O(^DGPM("APMV",DFN,MV("CA"),J,0)) Q:'J2!(D)  I $D(^DGPM(J2,0)) S X=^(0) D LAST1
 ;
PREV S:MV("PWD")="" MV("PWD")=MV("LWD")
 I MV("MT")=13 S:$P(MDP,"^",6)]"" MV("PWD")=$P(MDP,"^",6) S:$P(MDP,"^",9)]"" MV("PTS")=$P(MDP,"^",9)
 I MV("TT")=3&($P(MDP,"^",18)=4) S:$P(MDP,"^",6)]"" MV("PWD")=$P(MDP,"^",6) S:$P(MDP,"^",9)]"" MV("PTS")=$P(MDP,"^",9)
 S MV("PWD")=MV("PWD")_"^"_$S($D(^DIC(42,+MV("PWD"),0)):$E($P(^(0),"^",1),1,7),1:"NO WARD") ;  Previous Ward
 S MV("LWD")=MV("LWD")_"^"_$S($D(^DIC(42,+MV("LWD"),0)):$E($P(^(0),"^",1),1,7),1:"NO WARD") ;  Last Ward
 I +MV("PWD")'=+MV("LWD") S WDC=1 ;  Ward Change
 ;
TSC ;looks for most recent, or corresponding TS if one was associated with
 ;the movement
 S X=$O(^DGPM("ATS",DFN,MV("CA"),9999999.999999-MD))
 S ATS=$O(^DGPM("ATS",DFN,MV("CA"),+X,0)) ;  ATS=Associated TS
 I 9999999.9999999-MD=X D  ; If the TS is a corresponding one, look for one previous.
 .S X3=$O(^DGPM("ATS",DFN,MV("CA"),+X)) I X3 S PTS=$O(^(X3,0)) ;  PTS=Previous TS
 ;
 S:MV("LTS")="" MV("LTS")=ATS
 I MV("PTS")="" S MV("PTS")=$S(PTS]"":PTS,1:MV("LTS")) I PTS="" S E("PT")="" I MV("TT")=6 S TSC=1
 S MV("PTS")=MV("PTS")_"^"_$S('$D(^DIC(45.7,+MV("PTS"),0)):"NO TS",$P(^(0),"^",3)]"":$P(^(0),"^",3),$P(^(0),"^")]"":$E($P(^(0),"^"),1,5),1:"NO TS") ;   Previous TS
 S MV("LTS")=MV("LTS")_"^"_$S('$D(^DIC(45.7,+MV("LTS"),0)):"NO TS",$P(^(0),"^",3)]"":$P(^(0),"^",3),$P(^(0),"^")]"":$E($P(^(0),"^"),1,5),1:"NO TS") ;  Last TS
 I +MV("PTS")'=+MV("LTS") S TSC=1 ;  TS Change
 D TSDIV^DGPMGLG4 ; retrieves associated divisions for TS's.
 Q
 ;
LAST1 ;  Ward location
 ;  Service (NH or Dom) check
 I $P(X,"^",6)]"" S D1=0 F II="LWD","PWD" Q:D1  I MV(II)="" S MV(II)=$P(X,"^",6),D1=1 I "^42^43^44^45^47^"[("^"_+MV("MT")_"^") S X1=$S($D(^DIC(42,+MV(II),0)):$P(^(0),"^",3),1:"") D  ;p-418
 .I "^NH^D^"'[("^"_X1_"^")&($P(^(0),"^",17)'=1) S MV(II)="",D1=0 ;p-418 added second condition for IMLTC wards
 ;
 ;  Facility TS
 I $P(X,"^",9)]"" S D1=0 F II="LTS","PTS" Q:D1  I MV(II)="" S MV(II)=$P(X,"^",9),D1=1
 S D1=0 F II="LTS","PTS","LWD","PWD" I MV(II)]"" S D1=D1+1
 S:D1=4 D=1 K D1
 Q
