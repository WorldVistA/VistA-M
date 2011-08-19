DGPMBSG3 ;ALB/LM - BED STATUS GENERATION; 6 JUNE 90
 ;;5.3;Registration;**34**;Aug 13, 1993
 ;
A D ADM,DISCH,OTHER,TS
 I T=2,$G(PTSDV)'=$G(LTSDV) D TSDIV ; checks for move between divisions
 Q
 ;
ADM Q:T'=1  ;  1=Admission
 S $P(LW,"^",28)=$P(LW,"^",28)+1,$P(LT,"^",28)=$P(LT,"^",28)+1 ;  Gains-Total [Cum]
 S $P(LW,"^",17)=$P(LW,"^",17)+1,$P(LT,"^",17)=$P(LT,"^",17)+1 ;  17=Cum Admissions
 S:M=9 $P(LW,"^",13)=$P(LW,"^",13)+1,$P(LT,"^",13)=$P(LT,"^",13)+1 ;  M=9 (Movement=Transfer In)  13=Cum Admis from xfer in
 S:M=18 $P(LW,"^",18)=$P(LW,"^",18)+1,$P(LT,"^",18)=$P(LT,"^",18)+1 S (E("PW"),E("PT"))="" ; M=18 (Movement=Readmission to NHCU/DOM)  18=Adm after rehosp >30 days
 Q
 ;
DISCH Q:T'=3  ;  3=Discharge
 S $P(LW,"^",5)=$P(LW,"^",5)+1,$P(LT,"^",5)=$P(LT,"^",5)+1 ;  5=Cum Discharge
 S MP=$P(MDP,"^",18) I "2^3^25^26^40^"[("^"_MP_"^") D IRREG I MP'=40 D ONEDAY Q
 I 'NLS!(NLS=1) S $P(LW,"^",24)=$P(LW,"^",24)+1,$P(LT,"^",24)=$P(LT,"^",24)+1 ;  If not showing Non-Loss set 24=Cum Losses
 ;  M=10(xfer out,), M=11(OPT-NSC), M=12(Death), M=38(Death w/autopsy), 14=Cum disch to xfer out, 16=Cum disch to OPT/NSC, 15=Cum disch to death
 I "^10^11^12^38^"[("^"_M_"^") S X=$S(M=10:14,M=11:16,1:15),$P(LW,"^",X)=$P(LW,"^",X)+1,$P(LT,"^",X)=$P(LT,"^",X)+1
 ;
ASIH ;  M=42 (While ASIH)  M=47 (Discharge From NHCU/DOM while ASIH)
 I M=42!(M=47) S X=21 S:"^12^38^"[("^"_MV("AS")_"^") X=22 S $P(LW,"^",X)=$P(LW,"^",X)+1,$P(LT,"^",X)=$P(LT,"^",X)+1 ;  12=death, 38 death w/autopsy, 22=Died while ASIH, 21=Disch while ASIH
 ;
ONEDAY ;  MV("OD") set in ONEDAY^DGPMGLG1
 I MV("OD") S ^(+MV("LWD"))=$S($D(^UTILITY("DGOD",$J,+MV("LWD"))):^(+MV("LWD")),1:0)+1,^(+MV("LTS"))=$S($D(^UTILITY("DGTOD",$J,LTSDV,+MV("LTS"))):^(+MV("LTS")),1:0)+1
 S:+MV("LWD")=+MV("PWD") E("PW")=""
 S:+MV("LTS")=+MV("PTS") E("PT")=""
 Q
 ;
IRREG ; If irregular discharge or regular discharge after a loss
 ;S MP=$P(MDP,"^",18) ; MP=Previous Movement
 I MP=40 D 40^DGPMBSG2 ; 40=TO ASIH
 I "^2^26^"[("^"_MP_"^") D 226^DGPMBSG2 ; 2=AA, 26=FROM UA TO AA
 I "^3^25^"[("^"_MP_"^") D 325^DGPMBSG2 ; 3=UA, 25=FROM AA TO UA
 Q
 ;
OTHER ;  T=4 (Lodger CheckIn), T=5 (Lodger CheckOut), T=7 (Non-Movement)
 S:"^4^5^7^"[("^"_T_"^") (E("LW"),E("LT"),E("PW"),E("PT"))=""
 Q
 ;
TS Q:T'=6  ;  T=6 (Specialty transfer)
 ;  28=Gains Cum, 29=IWT Gains Cum, 24=Losses Cum, 6=IWT Losses Cum, 8=XRF other TS Cum, 23=XRF from other TS Cum
 I TSC S $P(LT,"^",28)=$P(LT,"^",28)+1,$P(LT,"^",29)=$P(LT,"^",29)+1,$P(PT,"^",24)=$P(PT,"^",24)+1,$P(PT,"^",6)=$P(PT,"^",6)+1 I +MV("LTS")'=+MV("PTS") S $P(PT,"^",8)=$P(PT,"^",8)+1,$P(LT,"^",23)=$P(LT,"^",23)+1,(E("LW"),E("PW"))=""
 Q
TSDIV ; Interward Transfer without TS change between different divisions
 I MV("LTS")=MV("PTS") S $P(LT,"^",28)=$P(LT,"^",28)+1,$P(LT,"^",29)=$P(LT,"^",29)+1,$P(PT,"^",24)=$P(PT,"^",24)+1,$P(PT,"^",6)=$P(PT,"^",6)+1,$P(PT,"^",8)=$P(PT,"^",8)+1,$P(LT,"^",23)=$P(LT,"^",23)+1 K E("PT")
 Q
