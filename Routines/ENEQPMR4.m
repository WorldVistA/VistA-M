ENEQPMR4 ;WIRMFO/DH,SAB-Single PMI's ;1/11/2001
 ;;7.0;ENGINEERING;**14,35,43,48,68**;Aug 17, 1993
 ;
SDPM ;Post PMI for one device
 N PMTOT
 S DIC="^DIC(6922,",DIC(0)="AEMQ" D ^DIC G:Y'>0 OUT S ENSHKEY=+Y,ENSHOP=$P(^DIC(6922,ENSHKEY,0),U,1),ENSHABR=$P(^(0),U,2)
 S ENDATE=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3),Y=$E(DT,1,5)_"00" X ^DD("DD") S %DT("A")="Select Month: ",%DT("B")=Y,%DT="AEPMX" D ^%DT G:Y'>0 OUT S ENPMDT=$E(Y,2,5),ENPMMN=+$E(Y,4,5),ENPMYR=$E(Y,1,3)+1700
SDPM0 W !,"Are you recording a WEEKLY PMI" S %=2 D YN^DICN I %=2 S ENPM="M" G SDPM1
 G:%<0 OUT I %'=1 G SDPM0
 W !,"Recording weekly PMI's in this manner is a little unusual. Are you sure" S %=2 D YN^DICN G:%'=1 SDPM0
SDPM01 R !,"Which week? ",X:DTIME G:X="^" OUT I X?1N,X>0,X<6 S ENPM="W"_X
 E  W !,"Enter a number, 1 to 5." G SDPM01
SDPM1 I $G(ENDEL)]"" G SDPM2
 I $P($G(^DIC(6910,1,0)),U,5)]"" S ENDEL=$P(^(0),U,5) G SDPM2
SDPM10 W !,"Do you want to retain PM work orders in your Work Order File after they have",!,"been posted to the Equipment History" S %=2 D YN^DICN I %=0 D COBH1 G SDPM10
 G:%<0 OUT S ENDEL=$S(%=1:"N",%=2:"Y",1:"")
SDPM2 ;
 W !!,?10,"** Need an Equipment Record for PMI entry ("_$P("Jan^Feb^Mar^Apr^May^Jun^Jul^Aug^Sep^Oct^Nov^Dec",U,ENPMMN)_", "_ENPMYR_") **"
 W !,?15,"** (or press <RETURN> to exit this option) **"
 D GETEQ^ENUTL G:Y'>0 OUT S ENDA=+Y
 N DA S ENPMWO="PM-"_ENSHABR_ENPMDT_ENPM,(ENKILL,ENCLOSE)=0
 S ENI=0 F  S ENI=$O(^ENG(6920,"G",ENDA,ENI)) Q:'ENI  I $P($G(^ENG(6920,ENI,0)),U)[ENPMWO S DA=ENI,ENPMWOX=$P(^(0),U) D  Q
 . I $P($G(^ENG(6920,DA,5)),U,2)]"" D  Q
 .. W !,"Work Order "_ENPMWOX_" has already been posted. If you wish to"
 .. W !,"edit it, please use the 'EDIT WORK ORDER' option.",*7
 .. S ENCLOSE=$P(^ENG(6920,DA,5),U,2)
 . S DIE="^ENG(6920,",DR=$S($D(^DIE("B","ENZPMCLOSE")):"[ENZPMCLOSE]",1:"[ENPMCLOSE]") D ^DIE
 . I '$D(DA) S ENKILL=1 Q  ;pm work order deleted within ^DIE
 . I $P($G(^ENG(6920,DA,5)),U,2)]"",$E(^ENG(6920,DA,0),1,3)="PM-" D
 .. D PMHRS,PMINV S ENCLOSE=$P(^ENG(6920,DA,5),U,2)
 .. I ENDEL="Y" S DIK="^ENG(6920," D ^DIK K DIK
 I $G(ENKILL)!($G(ENCLOSE)) G SDPM2
 S ENI=0,ENPMWOX="" F  S ENI=$O(^ENG(6914,ENDA,6,ENI)) Q:'ENI  I $P(^(ENI,0),U,2)[ENPMWO S ENPMWOX=$P(^(0),U,2) Q
 I ENPMWOX]"" W !,"Work order "_ENPMWOX_" has already been posted.",*7 G SDPM2
 D:'$D(DA) SDPM4^ENEQPMR5
 G SDPM2
 ;
OUT I $D(PMTOT) D COUNT^ENBCPM8
 K EN,ENI,ENX,ENPMWO,ENK,ENDATE,ENDEL,ENPM,ENPMDT,ENPMMN,ENPMWK,ENPMYR
 K ENSHABR,ENSHKEY,ENSHOP,ENY,ENDA,ENFNO,ENPMWOX,ENNXL,ENNXT,ENRS,ENNXMN
 K ENHZ,ENPMN,ENSTMN,ENKILL,ENCLOSE,ENA
 K B,C,%DT,DA,DR,D0,DIE,DIC,DIK,I,J,Y
 Q
HLD R !,"Press <RETURN> to continue...",X:DTIME S ENY=1 W @IOF
 Q
 ;
COH2 ;  Called by ENEQPMR1
 W !,"Enter the next PM work order you wish to close out, or the numeric (sequential)",!,"portion thereof, or <RETURN> to accept the default (",ENPMWO(1),"),",!,"or ""^"" to EXIT."
 Q
 ;
COBH1 ;  Called by ENEQPMR1, ENEQPMR2, or ENEQPMR6
 W !!,"  Deletion of PM work orders after they have been closed out is recommended",!,"for sites that are short on disk space. The results of the PMI will be posted"
 W !,"to the equipment history file before the PM work order is deleted.",!,"  If disk space is not a problem, then you may wish to retain PM work orders"
 W !,"in accordance with your established archive criteria. In this way, the Work",!,"Order # File will reflect scheduled as well as unscheduled work load."
 W !,"  For estimating purposes, each PM work order will consume about 300 bytes",!,"of disk space (or about 3 such work orders per block)."
 Q
 ;
PMHRS ;Extract hours from PM work order and add to PMTOT array
 ;Called by options that have closed PM work orders
 ;
 ; Input
 ;   DA      - ien of work order
 ;   PMTOT(  - (optional) array of already accumulated PM hours
 ;             PMTOT(shop ien , tech ien) = hours
 ; Output
 ;   PMTOT(  - input array + hours from this work order
 ;
 N ENHRS,ENI,ENSHKEY,ENTEC,ENY0,ENDA
 ; loop thru assigned tech multiple
 S ENI=0 F  S ENI=$O(^ENG(6920,DA,7,ENI)) Q:'ENI  D
 . S ENY0=$G(^ENG(6920,DA,7,ENI,0))
 . S ENTEC=$P(ENY0,U),ENHRS=$P(ENY0,U,2),ENSHKEY=$P(ENY0,U,3)
 . I ENSHKEY="" S ENSHKEY=$P($G(^ENG(6920,DA,2)),U)
 . I ENSHKEY>0,ENTEC>0,ENHRS>0 S PMTOT(ENSHKEY,ENTEC)=$G(PMTOT(ENSHKEY,ENTEC))+ENHRS
 Q
 ;
PMINV ;  Updates PHYSICAL INVENTORY DATE in File 6914
 ;    via call to ^ENEQNX5
 ;  Called after PM work order close-out
 ;
 ;  DA => IEN to Work Order File (returned)
 ;
 Q:$P($G(^ENG(6920,DA,5)),U,8)["D"  ;don't update on deferred work order
 N ENEQ,ENDT,ENLOC
 S ENEQ=$P($G(^ENG(6920,DA,3)),U,8),ENDT=$P($P($G(^(5)),U,2),"."),ENLOC=$P(^(0),U,4)
 N DA
 I ENEQ>0,$D(^ENG(6914,ENEQ,0)),ENDT?7N D UPDT^ENEQNX5(ENEQ,ENDT,ENLOC)
 Q
 ;ENEQPMR4
