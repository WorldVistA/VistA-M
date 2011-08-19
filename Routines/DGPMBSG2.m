DGPMBSG2 ;ALB/LM - BED STATUS ABSENCE REMAINING; 6 JUNE 90
 ;;5.3;Registration;**34**;Aug 13, 1993
 ;
A Q:$S('$D(REM):1,REM:1,1:0)  ;  +/- from previous day
 Q:$S('$D(M):1,'M:1,1:0)  ;  Movement type unknown
 D PASS,ASIH,AA,UA
 Q
 ;
PASS ;  1=AA<96; 23=From AA<96
 I NLS=1 S ^(+MV("LWD"))=$S($D(^UTILITY("DGPS",$J,+MV("LWD"))):^(+MV("LWD")),1:0)-1,^(+MV("PTS"))=$S($D(^UTILITY("DGTP",$J,+PTSDV,+MV("PTS"))):^(+MV("PTS")),1:0)-1 G PASSQ
 Q:"^1^23^"'[("^"_+M_"^")
 S ^(+MV("LWD"))=$S($D(^UTILITY("DGPS",$J,+MV("LWD"))):^(+MV("LWD")),1:0)+$S(+M=1:1,1:-1)
 S ^(+MV("PTS"))=$S($D(^UTILITY("DGTP",$J,+PTSDV,+MV("PTS"))):^(+MV("PTS")),1:0)+$S(+M=1:1,1:-1)
PASSQ S X3=5 ;  Piece position on the 1 Node in the Census File
 Q
 ;
ASIH ;  Patients on ASIH as of midnight of census date
 ;  13=To ASIH (VAH); 14=From ASIH (VAH); 40=To ASIH; 41=From ASIH; 42=While ASIH; 43=To ASIH (OTHER FACILITY); 44=Resume ASIH in parent facility 45=Change ASIH location (other fac); 46=Continue ASIH (Other Fac); 47=Discharge From NHCU
 I "^13^42^43^47^"[("^"_+M_"^") G 40
 I M'=14 Q
 S ^(+MV("PTS"))=$G(^UTILITY("DGTAS",$J,+PTSDV,+MV("PTS")))-1 ; decrease TSR ASIH to reflect return
 S ^(+MV("PWD"))=$G(^UTILITY("DGAS",$J,+MV("PWD")))-1 ; decrease BSR ASIH column to reflect return
 G ASIHQ
40 ; Entry place if irregular discharge (M=17) and previous movement TO ASIH (40)
 S ^(+MV("LWD"))=$S($D(^UTILITY("DGAS",$J,+MV("LWD"))):^(+MV("LWD")),1:0)+$S(+M=13:1,+M=43:1,+M=14:0,+M=42:-1,+M=47:-1,1:0)
 S ^(+MV("PTS"))=$S($D(^UTILITY("DGTAS",$J,+PTSDV,+MV("PTS"))):^(+MV("PTS")),1:0)+$S(+M=13:1,+M=43:1,+M=14:0,+M=42:-1,+M=47:-1,1:0)
ASIHQ S X3=8 ;  Piece position on the 1 Node in the Census File
 Q
 ;
AA ;  1=AA<96; 2=AA; 24=From AA; 25=From AA to UA; 26=From UA to AA
 I NLS=2!(NLS=26) S ^(+MV("LWD"))=$S($D(^UTILITY("DGAA",$J,+MV("LWD"))):^(+MV("LWD")),1:0)-1,^(+MV("PTS"))=$S($D(^UTILITY("DGTA",$J,+PTSDV,+MV("PTS"))):^(+MV("PTS")),1:0)-1 G AAQ
 Q:"^2^24^25^26^"'[("^"_+M_"^")
226 ; Entry place if irregular discharge (M=17) and previous movement (2) AA, (26) FROM UA TO AA
 S ^(+MV("LWD"))=$S($D(^UTILITY("DGAA",$J,+MV("LWD"))):^(+MV("LWD")),1:0)+$S(+M=2:1,+M=26:1,+$P(MDP,"^",18)=1:0,NLS=2:0,MP=2:0,MP=26:0,1:-1)
 S ^(+MV("PTS"))=$S($D(^UTILITY("DGTA",$J,+PTSDV,+MV("PTS"))):^(+MV("PTS")),1:0)+$S(+M=2:1,+M=26:1,+$P(MDP,"^",18)=1:0,NLS=2:0,MP=2:0,MP=26:0,1:-1)
AAQ S X3=6 ;  Piece position on the 1 Node in the Census File
 Q
 ;
UA ;  3=UA; 22=From UA; 25=From AA to UA; 26=From UA to AA
 I NLS=3!(NLS=25) S ^(+MV("LWD"))=$S($D(^UTILITY("DGUA",$J,+MV("LWD"))):^(+MV("LWD")),1:0)-1,^(+MV("PTS"))=$S($D(^UTILITY("DGTU",$J,+PTSDV,+MV("PTS"))):^(+MV("PTS")),1:0)-1 G UAQ
 Q:"^3^22^25^26^"'[("^"_+M_"^")
325 ; Entry place if irregular discharge (M=17) and previous movement (3) UA, (25) FROM AA TO UA
 S ^(+MV("LWD"))=$S($D(^UTILITY("DGUA",$J,+MV("LWD"))):^(+MV("LWD")),1:0)+$S(+M=3:1,+M=25:1,NLS=3:0,MP=3:0,MP=25:0,1:-1)
 S ^(+MV("PTS"))=$S($D(^UTILITY("DGTU",$J,+PTSDV,+MV("PTS"))):^(+MV("PTS")),1:0)+$S(+M=3:1,+M=25:1,NLS=3:0,MP=3:0,MP=25:0,1:-1)
UAQ S X3=7 ;  Piece position on the 1 Node in the Census File
 Q
