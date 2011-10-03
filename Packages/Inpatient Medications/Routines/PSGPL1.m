PSGPL1 ;BIR/CML3-GATHER PICK LIST DATA ;26 JAN 99 / 9:30 AM
 ;;5.0; INPATIENT MEDICATIONS ;**25,50**;16 DEC 97
 ;
 ; Reference to ^PSI(58.1 is supported by DBIA# 2284.
 ; Reference to ^PS(55    is supported by DBIA# 2191.
 ; Reference to ^PSD(58.8 is supported by DBIA# 2283.
 ; Reference to ^DIC(42   is supported by DBIA# 10039.
 ; 
EN ; entry point for PSGPL - get ward info, loop thru patients
 N PRINT S PRINT=0
 I $G(RERUN)=2,$D(OG) D
 .F  I $$LOCK^PSGPLUTL(OG,"PSGPL") Q
 .K DA,DIK S DIK="^PS(53.5,",DA=OG D ^DIK K DIK I $D(^PS(57.5,PSGPLWG,2)),+^(2)=OG S ^(2)=$P(^(2),"^",6,20)
 F  I $$LOCK^PSGPLUTL(PSGPLG,"PSGPL") Q
 S PSGPLTND=$G(^PS(53.5,PSGPLG,0)) G:PSGPLTND="" DONE S WSF=$P(PSGPLTND,"^",7),EST=$S($P(PSGPLTND,"^",13):"A",1:"Z")
 D NOW^%DTC S PSGDT=%,X1=$P(PSGPLS,"."),X2=-1 D C^%DTC S PSGPLD=X_(PSGPLS#1)
 F PSGPLWD=0:0 S PSGPLWD=$O(^PS(57.5,"AC",PSGPLWG,PSGPLWD)) Q:'PSGPLWD  S WDN=$P($G(^DIC(42,PSGPLWD,0)),"^") I WDN]"" D
 .S PSGPLWDN=$S('WSF:WDN,1:"zns") F PSGP=0:0 S PSGP=$O(^DPT("CN",WDN,PSGP)) Q:'PSGP  S PSJACNWP=1 D ^PSJAC,ENUNM^PSGOU D
 ..S TM="zz",RB=PSJPRB S:RB="" RB="zz" I RB'="zz" S X=+$O(^PS(57.7,"AWRT",PSGPLWD,RB,0)) I X,$D(^PS(57.7,PSGPLWD,1,X,0)),$P(^(0),"^")]"" S TM=$P(^(0),"^")
 ..S PSJJORD=0 D PATIENT Q:'$O(^PS(55,PSGP,5,"AUS",PSGPLS))
 ..F PST="C","O","OC","P","R" F SD=PSGPLD:0 S SD=$O(^PS(55,PSGP,5,"AU",PST,SD)) Q:'SD  F PSJJORD=0:0 S PSJJORD=$O(^PS(55,PSGP,5,"AU",PST,SD,PSJJORD)) Q:'PSJJORD  D ENASET
 ;
 I $D(^PS(53.5,PSGPLG)) S DIK="^PS(53.5,",DA=PSGPLG D
 .F DIK(1)=.01,.02,.05 D EN1^DIK
 .K DIK D NOW^%DTC S $P(^PS(53.5,PSGPLG,0),"^",9)=% S:IO]"" PRINT=1
 ;
DONE ;
 D UNLOCK^PSGPLUTL(PSGPLG,"PSGPL")
 D:PRINT ^PSGPLR
 D ^%ZISC,ENKV^PSGSETU K DRG,PSGP,PSGORD,PN,PSGPLC,PSGPLD,PSGPLO,PSGPLTND,PSGPLWD,PSGPLWDN,PSGMAR,PSJACNWP,PSJJORD,PSGLOCK,P,ST,SD,TM,WSF,DDC Q
 ;
ENASET ; this tag can be called from above or from update (^PSGPLUP0)
 ; if order not being edited (OE), on hold (HD), non-verified (NV) or self-med (SM) get units (^PSGPL0)
 S PSGPLDC="",PSGLOCK="",NST=$S(SD<PSGPLS:EST,1:PST)
 L +^PS(55,PSGP,5,PSJJORD):1 I  K ^PS(55,"AUE",PSGP,PSJJORD) S PSGLOCK=1
 G:NST=EST A1
 S PSGPLDC=$S('PSGLOCK:"OE",$P($G(^PS(55,PSGP,5,PSJJORD,0)),"^",9)="H":"HD",$P($G(^(0)),"^",5):"SM",'$P($G(^PS(55,PSGP,5,PSJJORD,4)),"^",9):"NV",1:"")
 ;
A1 ; if there are orders, set the order and drug multiples.
 ;    PSJJORD = unit dose subfile order ien
 ;    PSGORD  = PL order multiple ien
 ;    DRG     = unit dose subfile dispense drug multiple ien
 ;    PSGDRG  = PL dispense drug multiple ien
 I '$D(^PS(53.5,PSGPLG,1,PSGP,1)) S ^(1,0)="^53.52A^0^0"
 S PSGORD=(+$P(^PS(53.5,PSGPLG,1,PSGP,1,0),"^",3)+1),$P(^(0),"^",3,4)=PSGORD_"^"_(+$P(^(0),"^",4)+1)
 S ^PS(53.5,PSGPLG,1,PSGP,1,PSGORD,0)=PSJJORD_"^"_NST_"^"_"^"_PSGPLDC,$P(^PS(53.5,PSGPLG,1,PSGP,1,PSGORD,0),U,6)=$P($G(^PS(55,PSGP,5,PSJJORD,.2)),"^"),^PS(53.5,PSGPLG,1,PSGP,1,"B",PSJJORD,PSGORD)=""
 I $D(^PS(55,PSGP,5,PSJJORD,1))=10 S DDC=0 F DRG=0:0 S DRG=$O(^PS(55,PSGP,5,PSJJORD,1,DRG)) Q:'DRG  S DND=$G(^(DRG,0)) I DND D
 .S:PSGPLDC]"" PSGPLC=PSGPLDC I PSGPLDC="" S PSGPLO=PSJJORD D ^PSGPL0
 .I '$D(^PS(53.5,PSGPLG,1,PSGP,1,PSGORD,1)) S ^(1,0)="^53.53A^0^0"
 .S PSGDRG=(+$P(^PS(53.5,PSGPLG,1,PSGP,1,PSGORD,1,0),"^",3)+1),$P(^(0),"^",3,4)=PSGDRG_"^"_(+$P(^(0),"^",4)+1)
 .I PSGPLDC'?1.A S PSGPLC=$$WS^PSGPL1(+DND,+PSGPLWD,PSGPLC,PSGDT)
 .I $S($P(DND,"^",3):$P(DND,"^",3)\1'>PSGPLF,1:NST=EST)  S ^PS(53.5,PSGPLG,1,PSGP,1,PSGORD,1,PSGDRG,0)=DRG_"^"_$S(NST=EST:"",1:$P(DND,"^",3)\1_"DI"),^PS(53.5,PSGPLG,1,PSGP,1,PSGORD,1,"B",DRG,PSGDRG)="",DDC=DDC+1 Q
 .S ^PS(53.5,PSGPLG,1,PSGP,1,PSGORD,1,PSGDRG,0)=DRG_"^"_$S(PSGPLC&$P(DND,"^",2):PSGPLC*$S($P($P(DND,"^",2),".",2)]"":$P($P(DND,"^",2),".")+1,1:$P(DND,"^",2)),1:PSGPLC),^PS(53.5,PSGPLG,1,PSGP,1,PSGORD,1,"B",DRG,PSGDRG)="",DDC=DDC+1
 I PSGLOCK L -^PS(55,PSGP,5,PSJJORD)
 K PSGDRG Q
PATIENT ; add a patient to Pick List.  Can also be called from ^PSGPLUP0.
 I '$D(^PS(53.5,PSGPLG,1)) S ^(1,0)="^53.51PA^0^0"
 S $P(^(0),"^",3,4)=PSGP_"^"_($P(^PS(53.5,PSGPLG,1,0),"^",4)+1)
 ;The naked indicator on the line above references the global reference to the right of the equal sign.
 S ^PS(53.5,PSGPLG,1,PSGP,0)=PSGP_"^"_TM_"^"_WDN_"^"_RB,^PS(53.5,PSGPLG,1,"B",PSGP,PSGP)=""
 I $G(PSGAU)=1 S DR=".05////1",DIE="^PS(53.5,"_PSGPLG_",1,",DA(1)=PSGPLG,DA=PSGP D ^DIE K DIE
 Q
WS(DND,WD,PSGPLC,PSGDT) ;
 N AOU,DRUG
 F F="^PSD(58.8,","^PSI(58.1," I $D(@(F_"""D"","_DND_","_WD_")"))  D
 .F AOU=0:0 S AOU=$O(@(F_"""D"","_DND_","_WD_","_AOU_")")) Q:'AOU!(PSGPLC="WS")  D
 ..S DRUG=$O(@(F_AOU_",1,""B"","_DND_",0)")) Q:'DRUG  S X=$P($G(^(DRUG,0)),U,3) I 'X!(X>PSGDT) S PSGPLC="WS"
 Q PSGPLC
