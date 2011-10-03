SCMCTSKI ;OIBP/TEH - PCMM Inactivation Nightly Job; 18 Apr 2003  9:36 AM
 ;;5.3;Scheduling;**532**;AUG 13, 1993;Build 21
 ;
 ;
 ;=====================================================================
 ;Provider Inactivation Scheduled Date
 ;======================================================================
 Q
 ;
EN(SCMCFLG,SCALL) ;ENTRY POINT
 ;SCMCFLG := 1 when called from SCMCTSK2
 ;           parameter not passed when used with FM
 ;SCALL   := 1 for ALPHA testing
 ;           0 for Real Time
 ;           
 ;           When called from FM printout no parameters are passed
 I $G(SCMCFLG) S I(0,0)=+ENTRY
 I '$G(I(0,0)) Q "Error"
 S SCMCD0=I(0,0)
 S ALPHA=$S($G(SCALL):SCALL,1:+$P($G(^SCTM(404.44,1,1)),U,8))
 S Y=$P($G(^SCTM(404.52,+SCMCD0,0)),U,10)
 I 'ALPHA D
 .S X1=Y,X2=30 D C^%DTC
 .S $E(X,6,7)=$S(+$E(X,4,5)=2:28,+$E(X,4,5)=4:30,+$E(X,4,5)=6:30,+$E(X,4,5)=9:30,+$E(X,4,5)=11:30,1:31)
 I ALPHA D
 .S X=DT
 S EXP=X I '$G(SCMCFLG) D
 .S EXP=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 Q EXP
