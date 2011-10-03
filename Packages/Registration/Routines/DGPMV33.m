DGPMV33 ;ALB/MIR - DISCHARGE A PATIENT, CONTINUED ; 8/4/03 1:13pm
 ;;5.3;Registration;**204,544**;Aug 13, 1993
 ;
 I '$P(DGPMA,"^",4)!$S($P(DGPMA,"^",18)'=10:0,'$P(DGPMA,"^",5):1,1:0) W !,"Incomplete Discharge" S DIK="^DGPM(",DA=DGPMDA D ^DIK W "   deleted" S DGPMA="" D  G Q
 .S ^UTILITY("DGPM",$J,3,DA,"A")=$G(^("P"))
 .I $G(DGPMVI(13)) I $D(^UTILITY("DGPM",$J,1,+DGPMVI(13),"A")) S $P(^("A"),U,17)=$P($G(^("P")),U,17)
 S DGPMPTF=$P(DGPMAN,"^",16) G DQ:'DGPMPTF
 S X=$S($D(^DG(405.2,+$P(DGPMA,"^",18),0)):$P(^(0),"^",8),1:""),DR=$S(+DGPMA:"70////"_+DGPMA_";",1:"")_$S(X:"72////"_X,1:""),DIE="^DGPT(",DA=DGPMPTF K DQ,DG D ^DIE
 I +DGPMP=+DGPMA G Q
DQ S DGPMER=0 I $P(DGPMAN,"^",18)=40 D SET^DGPMV32 I DGPMAB S X1=+DGPMAB,X2=30 D C^%DTC I X'<+DGPMA D ASIH^DGPMV331
 ;I 'DGPMER,$D(^DGPM(+DGPMDA,0)) D ADM
 I DGPMN D DIS^DGPMVODS
 W !,"Patient Discharge",$S('$D(^DGPM(+DGPMDA,0)):" Deleted",DGPMA=DGPMP:"",'DGPMP:"d",1:" Updated")
Q Q
DICS ;input transform on discharge type
 S DGX1=$P(^DG(405.1,+Y,0),"^",3),DGSV=$S($D(^DIC(42,+$P(DGPM0,"^",6),0)):$P(^(0),"^",3),1:"")
 I DGX1=33,$S(DGSV="":1,DGSV'="D":1,1:0) S DGER=1 Q
 I DGX1=35,$S(DGSV="":1,DGSV'="NH":1,1:0) S DGER=1 Q
 I $S(DGX1=31:1,DGX1=32:1,1:0),$S(DGSV="":0,"NHD"[DGSV:1,1:0) S DGER=1 Q
 I DGX1=34,$S(DGSV="":1,DGSV="NH":1,1:0) S DGER=1 Q
 ;I "^21^47^48^49^"[("^"_DGX1_"^") S DGER=1 Q
 I DGX1=42,'$O(^DGPM("ATID2",+$P(^DGPM(DA,0),"^",3),9999999.9999999-^(0))) S DGER=1 Q
 S DGX=+$P(DGPMP,"^",18) I DGX,"^41^46^"[("^"_DGX_"^"),(DGX1'=DGX) S DGER=1 Q
 I "^42^47^"[("^"_DGX1_"^"),(DGX1'=$P(^DGPM(DA,0),"^",18)) S DGER=1 Q
 I "^42^47^"[("^"_DGX_"^"),(DGX1'=$P(^DGPM(DA,0),"^",18)) S DGER=1 Q
 I DGX,"^41^42^46^47^"'[("^"_DGX_"^"),("^41^42^46^47^"[("^"_DGX1_"^")) S DGER=1 Q
 I $P(DGPMAN,"^",18)=40,("^42^47^"[("^"_DGX1_"^")) S DGER=1 Q  ;if admission type is TO ASIH and d/c type is WHILE ASIH
 I $P(DGPMAN,"^",18)'=40,("^41^46^"[("^"_DGX1_"^")) S DGER=1 Q  ;if adm type not TO ASIH and d/c type FROM ASIH or CONTINUED ASIH (O.F.)
 I $P(DGPMAN,"^",18)'=40 S DGER=0 Q
 I "^41^46^"'[("^"_DGX1_"^") S DGER=0 Q
 D SET^DGPMV32 S X1=+DGPMAB,X2=30,DGHX=X D C^%DTC I ^DGPM(DA,0)>X S DGER=1,X=DGHX K DGHX Q
 S X=DGHX,DGER=0 K DGHX
 I $D(^DGPM(+$P(DGPMAN,"^",21),0)),$D(^DGPM(+$P(^(0),"^",14),0)),$D(^DGPM(+$P(^(0),"^",17),0)),($P(^(0),"^",18)=47) S DGER=1 Q  ;if discharge from NHCU/DOM is type 47
 S DGER=0 Q
SI Q:"^25^26^"[("^"_$P(DGPMA,"^",18)_"^")
 I $S('$D(^DPT(DFN,.1)):1,^(.1)="":1,1:0)&($D(^("DAC"))) S DR="401.3///@",DIE="^DPT(",DA=DFN K DQ,DG D ^DIE:$P(^("DAC"),"^",1)="S" K DR,DIC Q
 Q:'$D(^DPT(DFN,.1))  S W=^(.1) Q:W']""  S W=$O(^DIC(42,"B",W,0)),W=$S($D(^DIC(42,+W,0)):^(0),1:""),T="SERIOUSLY ILL" Q:W=""
 I $P(W,"^",14),($P(DGPMA,"^",18)>3) D  Q
 .S DR="401.3//"_$S("^22^23^24^"[("^"_$P(DGPMA,"^",18)_"^"):$S('$D(^DPT(DFN,"DAC")):"",$L($P(^("DAC"),"^",1)):T,1:""),DGPMN:T,1:"")
 .I $P(DR,"//",2)=T S DR=$S("^1^2^"[("^"_DGPMT_"^")&+DGPMA:DR_";S:X'=""S"" Y=0;401.4////"_$P(DGPMA,"."),1:DR)
 .S DIE="^DPT(",DA=DFN K DQ,DG D ^DIE K DIE,T,W
 I $D(^DPT(DFN,"DAC")) I $L($P(^("DAC"),"^",1)) S DA=DFN,DR=401.3,DIE="^DPT(" K DQ,DG D ^DIE
 K DIE,T,W Q
ADM ;update admission or check-in mvt with discharge/check-out mvt pointer
 Q
 Q:$S('DGPMN:1,'$D(^DGPM(+DGPMCA,0)):1,1:0)
 S ^UTILITY("DGPM",$J,1,+DGPMCA,"P")=DGPMAN,^UTILITY("DGPM",$J,1,+DGPMCA,"A")=$G(^DGPM(+DGPMCA,0))
 Q
