PSGORVW ;BIR/CML3-UNIT DOSE EXPANDED VIEW FOR OE/RR ;04 APR 94 / 11:06 AM
 ;;5.0; INPATIENT MEDICATIONS ;**58**;16 DEC 97
 ;
 ; Reference to ^PSDRUG is supported by DBIA 2191.
 ;
EN(PSGP,PSGORD) ;
 N AT,D,DRG,F,FL,HSM,Q,R,ST,SM,ST,UD,X,Y
 S $P(FL,"-",80)="",F="^PS("_$S(PSGORD["N":"53.1,",1:"55,"_PSGP_",5,")_+PSGORD_","
 S ST=$G(@(F_"0)")),AT=$G(^(2)),Y=$P($G(^(6)),"^")
 S SM=$P(ST,"^",4),HSM=$P(ST,"^",5),ST=$S($P(ST,"^",9)="P":"",1:$P(ST,"^",7)),AT=$P(AT,"^",5) S:Y]"" Y=$$ENSET^PSGSICHK(Y)
 ;
WRT ;
 W !,"Schedule Type:",?22,$$ENSTN^PSGMI(ST)
 W !,"Admin Times:",?22,$S(AT:AT,1:"NOT FOUND")
 W !,"Self Med:",?22,$P("NO^YES","^",SM+1) I SM,HSM W "  (HOSPITAL SUPPLIED)"
 W !,"Special Instructions:",?22 I Y]"" F Q=1:1:$L(Y) S X=$P(Y," ",Q) W:$L(X)+$X>78 !?22 W X_" "
 W !?48,"Units",?56,"Units",?64,"Inactive",!," Dispensed Drugs",?43,"U/D",?48,"Disp'd",?56,"Ret'd",?64,"Date",!,FL
 F X=0:0 S X=$O(@(F_"1,"_X_")")) Q:'X  S DRG=$G(^(X,0)) I DRG]"" D  ;
 .S UD=$P(DRG,"^",2),D=$P(DRG,"^",6)+$P(DRG,"^",10)+$P(DRG,"^",12),R=+$P(DRG,"^",7),Y=$P(DRG,"^",3) I Y S Y=$$ENDTC^PSGMI(Y)
 .S DRG=$S(DRG="":"NOT FOUND",'DRG:$P(DRG,"^"),$P($G(^PSDRUG(+DRG,0)),"^")]"":$P(^(0),"^"),1:$P(DRG,"^")_";PSDRUG(")
 .W !?1,DRG,?43,$S(UD:UD,1:1),?48,D,?56,R W:Y ?64,Y Q
 I $O(@(F_"12,0)")) W !!,"Provider Comments:" F Q=0:0 S Q=$O(@(F_"12,"_Q_")")) Q:'Q  N Y,Y2 S Y=" "_^(Q,0) F KKA=2:1 S Y2=$P(Y," ",KKA) Q:Y2=""  W:$L(Y2)+$X>79 !?2 W " ",Y2
 K KKA
 I $O(@(F_"3,0)")) W !!,"Comments:" F Q=0:0 S Q=$O(@(F_"3,"_Q_")")) Q:'Q  W !?2,^(Q,0)
 ;
DONE ;
 Q
