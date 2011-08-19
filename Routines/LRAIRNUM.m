LRAIRNUM ;DoD/GEM - DoD SPECFIC ROUTINE  FIND INPATIENT REGISTER NUMBER GEM/LL ; 12/9/86  2:24 PM ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 ; This routine is only used in DoD sites  Resave as IAARNUM and remove the STOP line.
STOP Q
GO S IARNO="",IAI=$O(^DPT(IADA,"DA","AA",(9999999-IAX)\1)) I IAI>0 S IAI=$O(^(IAI,0))
 I IAI>0,$D(^DPT(IADA,"DA",IAI,0)),+^(0)'>IAX S IARNO=$S('$D(^(1)):$S($D(^(9000)):+^(9000),1:""),+^(1)>IAX:$S($D(^(9000)):+^(9000),1:""),1:"")
 S IARNO=$S($D(^DIC(9008,+IARNO,0)):$P(^(0),"^",1),1:"") K IAI Q
