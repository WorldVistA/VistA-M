PSGRET ;BIR/CML3-ENTER RETURNS ;17 SEP 97 /  1:41 PM
 ;;5.0; INPATIENT MEDICATIONS ;**31**;16 DEC 97
 ;
 ; Reference to ^PS(50.7 is supported by DBIA# 2180
 ; Reference to ^PS(51.2 is supported by DBIA #2178
 ; Reference to ^PS(55 is supported by DBIA# 2191
 ;
 N PSJNEW,PSGPTMP,PPAGE,PSGEFN S PSJNEW=1
 D ENCV^PSGSETU Q:$D(XQUIT)  S (PSGONNV,PSGRETF)=1 K PSGPRP
 ;
GP ;
 D ENDPT^PSGP G:PSGP'>0 DONE I '$O(^PS(55,PSGP,5,"AUS",+PSJPAD)) W $C(7),!,"(Patient has NO active or old orders.)" G GP
 D ENL^PSGOU G:"^N"[PSGOL GP S PSGPTMP=0,PPAGE=1 D ^PSGO G:'PSGON GP S PSGLMT=PSGON,(PSGONC,PSGONR)=0
 F  W !!,"Select ORDER",$E("S",PSGON>1)," 1-",PSGON,": " R X:DTIME W:'$T $C(7) S:'$T X="^" Q:"^"[X  D:X?1."?" H I X'?1."?" D ENCHK^PSGON W:'$D(X) $C(7),"  ??" Q:$D(X)
 G:"^"[X GP F PSGRET=1:1:PSGODDD F PSGRET1=1:1 S PSGRET2=$P(PSGODDD(PSGRET),",",PSGRET1) Q:'PSGRET2  K DA S (PSGORD)=^TMP("PSJON",$J,PSGRET2) D R G:Y GP
 G GP
 ;
DONE ;
 D ENKV^PSGSETU K ^TMP("PSJON",$J),DO,DRG,MR,OD,PSGLMT,PSGODDD,PSGOL,PSGON,PSGONC,PSGONR,PSGONV,PSGONNV,PSGORD,PSGRET,PSGRET1,PSGRET2,PSGRETF,SCH,Y1,Z Q
 ;
R ;
 S MR=$P($G(^PS(55,PSGP,5,+PSGORD,0)),"^",3),Y=$G(^(.2)),SCH=$P($G(^(2)),"^"),DO=$P(Y,"^",2),DRG=$P(Y,"^"),DRG=$S(DRG'=+DRG:"NOT FOUND",'$D(^PS(50.7,DRG,0)):DRG,$P(^(0),"^")]"":$P(^(0),"^"),1:DRG_";PS(50.7,")
 S:MR]"" MR=$S(MR'=MR:MR,'$D(^PS(51.2,MR,0)):MR,$P(^(0),"^",3)]"":$P(^(0),"^",3),$P(^(0),"^")]"":$P(^(0),"^"),1:MR_";PS(51.2,") W !!,"----------------------------------------",!,DRG,!,"Give: ",DO," ",MR," ",SCH
 I '$O(^PS(55,PSGP,5,+PSGORD,1,0)) D  Q
 .W !!,"No Dispense drugs have been entered for this order. At least one Dispense drugs",!,"must be associated with an order before dispensing information may be entered.",!!
 .N DIR S DIR(0)="E" D ^DIR S Y=$S(Y:0,1:1)
 S Y=$O(^PS(55,PSGP,5,+PSGORD,1,0)) I '$O(^(Y)),$D(^(Y,0)) S DRG=$P(^(0),"^"),UD=$P(^(0),"^",2),DRG=$$ENDDN^PSGMI(DRG)
 I  W !!,"Dispense drug: ",DRG,"  (U/D: ",$S('UD:1,1:UD),")"
 E  K DA,DIC S DA(1)=PSGP,DA(2)=+PSGORD,DA=+PSGORD,DIC="^PS(55,"_PSGP_",5,"_+PSGORD_",1,",DIC(0)="AEQM" W ! D ^DIC K DIC Q:Y'>0
 K DA,DR S DA=+Y,DA(2)=PSGP,DA(1)=+PSGORD,DIE="^PS(55,"_PSGP_",5,"_+PSGORD_",1,",DR=.08 S:$P($G(^PS(55,PSGP,5,+PSGORD,1,DA,0)),"^",8) $P(^(0),"^",8)="" W ! D ^DIE S Y=$D(DUOUT)!$D(DTOUT)
 Q
 ;
H ;
 W !!?2,"Select the orders (by number) for which you want to enter returns." D:X'="?" H2^PSGON Q
