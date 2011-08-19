DGREGE ;ALB/JDS - EDIT REGISTRATIONS/DISPOSITIONS ; 04/30/2004
 ;;5.3;Registration;**24,161,151,459,568**;Aug 13, 1993
 N SDISHDL
A W !! S DIC=2,DIC(0)="AEQM" D ^DIC K DIC G Q:Y<0 S (DFN,DA)=+Y
 I '$O(^DPT(DA,"DIS",0)) W !!,"No registrations to print from.",!! G A
F11 R !!,"Registration date/time: ",X:DTIME G A:'$T!(X?1"^".E)!(X=""),NUM:$L(X)<7 S %DT="T" D ^%DT S DFN1=9999999-Y G W1:$D(^DPT(DA,"DIS",DFN1)) W !!
HELP W ! S J=0 F I=0:0 S I=$O(^DPT(DA,"DIS",I)) Q:'I  S J=J+1,L=+(^(I,0))_"00000" W $J(J,2),".  ",$$FMTE^XLFDT($E(L,1,12),"5Z") W ?$X\40+1*40 W:$X>75 ! Q:J>20
 W !,"Enter the date and time, Entry #, or 'L' for the last registration,",!," to select the registration you wish to edit" G F11
NUM ; choose by number of find last registration
 S DFN1=0
 I X="L" S DFN1=$O(^DPT(DA,"DIS",0)) ; get last
 F I=1:1:+X S DFN1=$O(^DPT(DA,"DIS",DFN1)) Q:'DFN1
 G HELP:'DFN1
 W "   ",$$FMTE^XLFDT(9999999-DFN1,"5Z"),!!
W1 S DA=DFN1,DA(1)=DFN,L=$G(^DPT(DFN,"DIS",DFN1,0)),DP=2.101,DR=$S($P(L,U,6):"[DGREGE]",1:"[DGREGEO]")
 I $P(L,U,18) S (SDISHDL,^TMP("SDEVT HANDLE",$J))=$G(^TMP("SDEVT HANDLE",$J))+1 D BEFORE^DGDIS(DFN,9999999-DFN1,9,SDISHDL)
 S DIE="^DPT(",DA=DFN D ^DIE K DE,DQ,DIE,DR S DIE="^DPT("_DFN_",""DIS"",",DGXXXD=0 D EL
 N DGL
 S DGL=$G(^DPT(DFN,"DIS",DFN1,0))
 I $P(DGL,U,18) D
 . I "^0^1^"[(U_$P(DGL,U,2)_U),$P(DGL,U,6) D CO(DFN,9999999-DFN1,SDISHDL)
 . D EVT^DGDIS(DFN,9999999-DFN1,9,SDISHDL)
 . D VALIDATE^DGDIS(DFN,DFN1) ; -- call c/o validator
 G A
 ;
Q K %,%H,%X,%Y,C,D0,D1,DA,DFN,DFN1,DIE,DP,I,J,L,X,Y
 Q
 ;
DT I Y X ^DD("DD") W Y
 Q
EL W !!,"Updating eligibility status for this registration...",!
 S DA=DFN1,DIE("NO^")="",DA(1)=DFN,DP=2.101,DGXXX=$S($D(^DPT(DFN,.361)):$P(^(.361),"^",1),1:""),DGXXX1=$S($D(^DPT(DFN,"DIS",DFN1,0)):^(0),1:"") Q:'DGXXX1  S DGXXX2=+$P(DGXXX1,"^",13),DR="14///"_$S(DGXXX="V":1,1:0)
 I $D(^DIC(8,DGXXX2,0)),$P(^(0),"^",5)="Y",$P(^(0),"^",4)=1!($P(^(0),"^",4)=3) S DGXXX3=$S($D(^DPT(DFN,.3)):$P(^(.3),"^",2),1:""),DR=DR_";15///1;16//"_DGXXX3
 E  S DR=DR_";15///NO"
 S:$P(DGXXX1,"^",17) DR=DR_";17///@" D ^DIE G ELQ:DGXXXD
 S DGXXXD=0 D SEG^DGA4004 I DGSEG W !!,"Disposition on AMIS Segment ",DGSEG," - ",$S($D(^DG(391.1,+DGSEG,0)):$P(^(0),"^",1),1:"SEGMENT NAME UNKNOWN") K DR S DR="17///"_DGSEG D ^DIE K DE,DQ,DIE,DR
 E  W !!,"Patient falls into a means test category...AMIS 401-420 segment will be",!,"determined at time the report is generated..."
ELQ W ! K DGXXX,DGXXX1,DGXXX2,DGXXX3,DGXXXD,DR,DIE("NO^"),DGSEG Q
 ;
CO(DFN,SDDT,SDISHDL) ; -- ask check out questions
 N DFN1,SDCOQUIT,SDIS,SDOE,SDPMTDF
 S SDOE=$$GETDISP^SDVSIT2(DFN,SDDT) G COQ:'SDOE
 S SDIS=$G(^DPT(DFN,"DIS",9999999-SDDT,0))
 I '$$SCE^DGSDU(+SDOE,7,0)!($P($G(^TMP("SDEVT",$J,SDISHDL,3,"DIS",0,"BEFORE")),"^",13)'=$P(SDIS,"^",13)) D INT^SDCO6(SDOE,.SDCOQUIT)
 I '$D(SDCOQUIT) D
 .S SDPMTDF=$S($P(^DG(43,1,0),"^",32):1,$P($G(^DIC(37,+$P(SDIS,"^",7),0)),"^")="SCHEDULE FUTURE APPOINTMENT":1,1:0)
 . I $$ASK^SDCO6(SDPMTDF) D EN^SDCO(SDOE,SDISHDL,1)
COQ Q
