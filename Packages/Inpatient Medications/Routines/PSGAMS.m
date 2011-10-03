PSGAMS ;BIR/CML3-AMIS REPORT ;25 AUG 94 / 12:07 PM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
 D ENCV^PSGSETU I $D(XQUIT) Q
 S HLP="AMIS" D ENDTS G:'SD!'FD DONE K P S P=0 F Q=0:0 S Q=$O(^PS(53.5,"AB",Q)) Q:'Q  S QQ=$O(^(Q,0)) I QQ,QQ'>FD S P=P+1,P(Q)=""
 I P W $C(7),$C(7),!!?32,"*** WARNING ***",!,"PICK LISTS need to be filed away for the following ward group",$E("s",P>1),", or this AMIS"
 I  W !,"report will not be accurate for the date range asked for." F Q=0:0 S Q=$O(P(Q)) Q:'Q  W !?3,$S($D(^PS(57.5,Q,0)):$P(^(0),"^"),1:Q)
 ;
GO ;
 S RTN="AMS" D EN3^PSGTI I 'POP,'$D(IO("Q")) D ENQ D:IO'=IO(0)!($E(IOST)'="C") ^%ZISC
 ;
DONE ;
 D ENKV^PSGSETU K ^UTILITY("PSG",$J),DRG,FD,HLP,ND,NU,P,PR,RTN,SD,ST,STOP,STRT,W,WN,ZTOUT Q
 ;
ENQ ;
 K ^UTILITY("PSG",$J) F ST=SD:0 S ST=$O(^PS(57.6,ST)) Q:'ST!(ST>FD)  S W=0 F  S W=$O(^PS(57.6,ST,1,W)) Q:'W  S WN=$S(W'=+W:"UNKNOWN",'$D(^DIC(42,W,0)):W,$P(^(0),"^")]"":$P(^(0),"^"),1:W) D GPR
 D ^PSGAMS0 Q
 ;
GPR ;
 S PR=0 F  S PR=$O(^PS(57.6,ST,1,W,1,PR)) Q:'PR  S DRG=0 F  S DRG=$O(^PS(57.6,ST,1,W,1,PR,1,DRG)) Q:'DRG  I $D(^(DRG,0)) S ND=^(0) D ADD
 Q
 ;
ADD ;
 S NU=$G(^UTILITY("PSG",$J,WN)),$P(NU,"^")=+NU+$P(ND,"^",2)-$P(ND,"^",4),$P(NU,"^",2)=$P(NU,"^",2)+$P(ND,"^",3)-$P(ND,"^",5),^(WN)=NU Q
 ;
 ;
ENDTS ;
 S (SD,FD)=0,PSGID=$S(HLP'="COST AT DISCHARGE":$O(^PS(57.6,0)),1:$O(^PS(55,"AUDDD",0))) I 'PSGID W $C(7),!!?10,"***  THERE IS NO DATA FOR THIS REPORT, YET.  ***" Q
 K %DT S FIRST=$E($$ENDTC^PSGMI(PSGID),1,8),%DT="EXP",D="START" D DT I Y>0 S (STRT,%DT(0))=+Y,D="STOP" D DT I Y>0 S (STOP,FD)=+Y,X1=STRT,X2=-1 D C^%DTC S SD=X F X="STRT","STOP" S @X=$P($$ENDTC^PSGMI(@X)," ")
 K %DT,FIRST Q
 ;
DT ;
 S Y=-1 F  W !!,"Enter ",D," DATE: " R X:DTIME W:'$T $C(7) S:'$T X="^" D DTM:X?1."?",^%DT:"^"'[X I Y>0!("^"[X) W:Y'>0 $C(7),!?3,"No ",D," date chosen, or ",HLP," report run." Q
 Q
 ;
DTM ;
 S X1=HLP="COST AT DISCHARGE",X2=$S(D="START"&X1:" ",1:"")
 W !!?2,"Enter the ",D," date of the range of dates for this ",HLP," report "_X2_"to run." W:X1 "  " W:'X1 ! W "The start and stop dates may be the same, in effect, a one day report."
 W:D="STOP" "  "_$S(X1:" ",1:"")_"The stop"_$S(X1:" ",1:"")_"date may not come before the start date." W !?2,"Dates are inclusive.  (The first date found is "_FIRST_".)" Q
 ;
ENDC ;
 S PSGID=$O(^PS(57.6,0)) I 'PSGID W $C(7),!!?10,"** There is no data for this report, yet. **" Q
 S FIRST=$$ENDTC^PSGMI(PSGID) Q
