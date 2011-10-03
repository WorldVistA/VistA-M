PSGVW0 ;BIR/CML3-SHOWS ACTIVITY LOG ;16 DEC 97 / 1:38 PM 
 ;;5.0; INPATIENT MEDICATIONS ;**49,54,85**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191
 ;
 F  R !!,"Show LONG, SHORT, or NO activity log?  N// ",AT:DTIME D ALC Q:Q
 Q:"^N"[AT  S PN=1,PX="" F Q=0:0 S Q=$O(@(F_"9,"_Q_")")) Q:'Q  I $D(^(Q,0)) S AND=^(0) D:'(PN#6) NPAGE Q:PX["^"  D AL1
 Q
AL1 S PN=PN+1,UD=$P(AND,"^",3) I AT="S",UD?4N,$E(UD)=6,UD#6000 Q
 W !!?4,"Date: ",$$ENDTC^PSGMI(+AND) W:$S(UD'?4N:1,1:$E(UD,1,2)'=10) ?30,"User: ",$$ENNPN^PSGMI($P(AND,"^",2))
 W !,"Activity: ORDER ",$S(UD="":"****",'$D(^PS(53.3,UD,0)):UD,$P(^(0),"^")]"":$P(^(0),"^"),1:UD)
AL2 I UD?4N,$E(UD)=6 W !?3,"Field: ",$P(AND,"^",4) S OD=$P(AND,"^",5) I OD>2000000,$P(OD,".",2) S OD=$$ENDTC^PSGMI(OD)
 I UD?4N,$E(UD)=6 W !,"Old Data: ",OD
 I UD?4N,$E(UD)=7,$P(AND,"^",4)]"" W !?3,"Field: ",$P(AND,"^",4)
 Q
NPAGE I $E(IOST)="C" R !!,"Enter '^' to stop, or press RETURN to continue.",PX:DTIME
 Q
ALC ;
 S Q=1 W:'$T $C(7) I AT["^"!'$T S AT="^" Q
 I AT="" W "  (NO)" S AT="N" Q
 F PX="SHORT","LONG","NO" I $P(PX,AT)="" W $P(PX,AT,2) S AT=$E(AT) Q
 Q:$T  S Q=0 I AT'["?" W $C(7),"  ??" Q
 W !!,"Enter 'LONG' (or 'L') to see ALL of the entries of this activity log.  Enter    'SHORT' (or 'S') to NOT see the fields edited because of the order being",!,"renewed, discontinued, etc.  Simply press the RETURN key "
 W "(or enter 'NO', 'N',",!,"or '^') to NOT see the activity log." Q
 ;
ENA ;
 I PSGORD["U" S PN=1,PX="" F Q=0:0 S Q=$O(^PS(55,PSGP,5,+PSGORD,9,Q)) Q:'Q  I $D(^(Q,0)) S AND=^(0) D:'(PN#6) NPAGE Q:PX["^"  D AL1
 I PSGORD["P" S PN=1,PX="" F Q=0:0 S Q=$O(^PS(53.1,+PSGORD,"A",Q)) Q:'Q  I $D(^(Q,0)) S AND=^(0) D:'(PN#6) NPAGE Q:PX["^"  D AL1
 Q
