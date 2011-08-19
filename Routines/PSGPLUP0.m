PSGPLUP0 ;BIR/CML3-UPDATING FOR PSGPLUP OCCURS HERE ;06 AUG 96 / 10:53 PM
 ;;5.0; INPATIENT MEDICATIONS ;**50,129**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA #2191.
 ; Reference to ^PS(59.7 is supported by DBIA #2181
 ; Reference to ^DIC(42 is supported by DBIA #1377.
 ; Reference to ^DPT( is supported by DBIA #10035.     
 ;
ENQ ; check for a previous update, if there is one "unflag" updated orders.
 ;
 I '$$LOCK^PSGPLUTL(PSGPLG,"PSGPL") H 60 G ENQ
 D NOW^%DTC S PSJACNWP=1,PSGAU="",PSGDT=%,(PDRG,PN,PST,RB,TM,WDN)="",EST=$S($P(PSGPLTND,"^",13):"A",1:"Z"),PSJACNWP=1
 F  S PSGX=$Q(^PS(53.5,"AU",PSGPLG)),PSGXP=$P(PSGX,"53.5",2) Q:$P(PSGXP,",",2,3)'=("""AU"","_PSGPLG)  D UNFLAG
 K PSGP,PSGORD,I,X,PSGX,PSGXP
 ;
 ; check each patient in the ward group
 ;
 S X1=$P(PSGPLS,"."),X2=-1 D C^%DTC S PSGPLUPO=X_(PSGPLS#1)
 F PSGPLWD=0:0 S (WD,PSGPLWD)=$O(^PS(57.5,"AC",PSGPLWG,PSGPLWD)) Q:'PSGPLWD  S WDN=$P($G(^DIC(42,WD,0)),"^") I WDN]"" S PSGPLWDN=$S('WSF:WDN,1:"zns") F PSGP=0:0 S PSGP=$O(^DPT("CN",WDN,PSGP)) Q:'PSGP  D UP
 ;
 ; check each patient on original Pick List (to catch any that have since moved to a different ward group but had action, for example orders DC'd)
 S PSGX="",PSGX=$Q(^PS(53.5,"AC",PSGPLG)),PSGXP=$P(PSGX,"53.5",2) Q:$P(PSGXP,",",2,3)'=("""AC"","_PSGPLG)  S PSGP=+$P(PSGX,"^",3) D:$D(^PS(55,"AUE",PSGP)) UP
 F  S PSGX=$Q(@PSGX) Q:$P(PSGX,",",2,3)'=("""AC"","_PSGPLG)  S PSGP=+$P(PSGX,"^",3) D:$D(^PS(55,"AUE",PSGP)) UP
 K ^PS(53.5,"AC",PSGPLG) F PSG=.01,.02,.05 K DA,DIK S DIK="^PS(53.5,",DIK(1)=PSG,DA=PSGPLG D EN1^DIK
 D NOW^%DTC S $P(^PS(53.5,PSGPLG,0),"^",10)=%
 ;
DONE ;
 D UNLOCK^PSGPLUTL(PSGPLG,"PSGPL") K %,%X,%Y,DA,DIK,DRG,EST,NST,PSJJORD,PN,PSGPLO,PSGAU,PSGNDATE,PSGPLS,PSGPLUPO,PSGPLWD
 K PSGPLWDN,PSGX,PSGXP,PST,PSGUP,PSGORD,PSJACNWP,RB,SD,TM,X,X1,X2 Q
 ;
UP ; if patient has an update (AUE xref on UD subfile), add order and drug multiples to Pick List and flag as updated.
 ; if patient not on last pick list (i.e., transferred or admitted
 ; and has no orders, add to Pick List patient multiple and flag as updated (do PATIENT^PSGPL1).
 D ^PSJAC,ENUNM^PSGOU
 S DFN=PSGP,WD=0,WDN=$G(^DPT(PSGP,.1)),RB=$G(^DPT(PSGP,.101)) S:WDN]"" WD=+$O(^DIC(42,"B",WDN,0))
 S TM=$S(RB="":"",1:$P($G(^PS(57.7,WD,1,+$O(^PS(57.7,"AWRT",WD,RB,0)),0)),"^"))
 F X="RB","TM","WDN" S:@X="" @X="zz"
 ; check to see if pat has moved to a new ward group, if so leave location alone on this PL and print only orders newly DC'd
 ; Determine if patient is on the same or different ward group
 ; (GRP=1:Same,GRP=0:Different)
 S GRP=1 I WD S GRP=$O(^PS(57.5,"AB",WD,0)) Q:'GRP  S GRP=GRP=$P(^PS(53.5,PSGPLG,0),U,2)
 S PN=$P(PSGP(0),"^"),PN=$S(PN]"":$E(PN,1,12),1:PSGP)_"^"_PSGP
 I WD,GRP,$G(^PS(53.5,PSGPLG,1,PSGP,0)) S $P(^PS(53.5,PSGPLG,1,PSGP,0),U,2,4)=TM_U_WDN_U_RB
 I GRP,'$G(^PS(53.5,PSGPLG,1,PSGP,0)) S PSGAU=1 D PATIENT^PSGPL1
 ;
 ;Update orders already on PL for this patient.
 N PSJSITE,PSJPRN S PSJSITE=0,PSJSITE=$O(^PS(59.7,PSJSITE)) I $P($G(^(PSJSITE,26)),U,5)=1 S PSJPRN=1
 I GRP F PSJJORD=0:0 S PSJJORD=$O(^PS(55,"AUE",PSGP,PSJJORD)) Q:'PSJJORD  I $D(^PS(55,PSGP,5,PSJJORD,0)),$D(^(2)) S SD=$P(^(2),"^",4) I (SD'<PSGPLUPO)!($D(^PS(53.5,PSGPLG,1,PSGP,1,"B",PSJJORD))) D UP1
 ;
 ;If patient is on a different WG update only DE orders.
 I 'GRP D NOW^%DTC S PSGDT=%,X1=$P(PSGPLS,"."),X2=-1 D C^%DTC S PSGPLD=X_(PSGPLS#1) D
 .F PST="C","O","OC","P","R" F SD=PSGPLD:0 S SD=$O(^PS(55,PSGP,5,"AU",PST,SD)) Q:'SD  F PSJJORD=0:0 S PSJJORD=$O(^PS(55,PSGP,5,"AU",PST,SD,PSJJORD)) Q:'PSJJORD  D
 ..I $D(^PS(53.5,PSGPLG,1,PSGP,1,"B",PSJJORD)) S PSGNDATE=$S($P(^PS(53.5,PSGPLG,0),"^",10)]"":$P(^PS(53.5,PSGPLG,0),"^",10),1:$P(^PS(53.5,PSGPLG,0),"^",9)) I SD>PSGNDATE D UP1
 Q
 ;
UP1 ;
 S (NST,PST)=$P(^PS(55,PSGP,5,PSJJORD,0),"^",7) Q:(NST="")!(('GRP)&("DE"'[$P(^PS(55,PSGP,5,PSJJORD,0),"^",9)))  S PSGPLO=PSJJORD D ENASET Q
 Q
 ;
ENASET ; 
 ; if you're adding an order that is already on the PL, delete the old one first
 I $D(^PS(53.5,PSGPLG,1,PSGP,1,"B",PSJJORD)) D  D ^DIK K DIK
 .N PSGOST S PSGOST=$P($$LASTREN^PSJLMPRI(PSGP,PSJJORD_"U"),"^",4) I PSGOST D
 ..N PSGPLS,PSGPLF S PSGPLS=$P(PSGPLTND,"^",3),PSGPLF=$P(PSGPLTND,"^",4) I PSGOST>PSGPLS&(PSGOST<PSGPLF) D
 ...N PSGPLO S PSGPLO=$O(^PS(53.5,PSGPLG,1,PSGP,1,"B",PSJJORD,999),-1)
 ...M PSGPLREN(53.5,PSGPLG,1,PSGP,1,PSGPLO)=^PS(53.5,PSGPLG,1,PSGP,1,PSGPLO) S PSGPLREN("B",PSGP,PSJJORD,PSGPLO)=PSGOST
 ...N PSGPLX F PSGPLX="AC","AU" M PSGPLREN(53.5,PSGPLX,PSGPLG)=^PS(53.5,PSGPLX,PSGPLG)
 .K DA,DIK S DA=$O(^PS(53.5,PSGPLG,1,PSGP,1,"B",PSJJORD,0)),DA(2)=PSGPLG,DA(1)=PSGP,DIK="^PS(53.5,"_PSGPLG_",1,"_PSGP_",1,"
 .S:$D(^PS(53.5,DA(2),1,DA(1),0)) $P(^(0),U,5)=""
 .S:$D(^PS(53.5,DA(2),1,DA(1),1,DA,0)) $P(^(0),U,5)=""
 ; go to ^PSGPL1 to add new orders to the PL. (unless the patient has no ward, in which case he's probably discharged)
 N PSGPLWD S PSGPLWD=WD
 S (DDC,PSGAU)=1 D ENASET^PSGPL1 S DR=".05////1",DIE="^PS(53.5,"_PSGPLG_",1,"_PSGP_",1,",DA(2)=PSGPLG,DA(1)=PSGP,DA=PSGORD D ^DIE K DIE
 Q
UNFLAG ; unset "old" update flag
 ;
 S PSGP=+$P(PSGX,"^",3),PSGORD=+$P(PSGX,"^",4)
 S $P(^PS(53.5,PSGPLG,1,PSGP,0),"^",5)="" K @PSGX
 S:PSGORD $P(^PS(53.5,PSGPLG,1,PSGP,1,PSGORD,0),"^",5)=""
 Q
