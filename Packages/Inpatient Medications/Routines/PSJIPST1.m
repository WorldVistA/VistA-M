PSJIPST1 ;BIR/CML3-INSTALL INPATIENT MEDS FOR OE/RR (& MAS) ;03 OCT 96 / 8:42 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
START ;
 ;W !!,"...installing Inpatient Medications protocols for OE/RR (and MAS)..." D ^PSJONIT
 ;W !!,"...setting up Inpatient protocols..."
 S MENU="DGPM MOVEMENT EVENTS",ITEM="PSJ OR PAT ADT" D SETUP,DONE
 ;W !!,"...installing Inpatient Medications List Templates..." D ^PSJL
 Q
 ;
ENORDER ; Begin conversion of existing orders (active after t-365)
 ; THIS IS NO LONGER CALLED FROM OUR POST INIT
 ; THIS CONVERSION IS RAN THROUGH CPRS
 Q
 K ZTSAVE,ZTSK S ZTRTN="DEQORDER^PSJIPST1",ZTDTH=$H,ZTDESC="Inpatient Orders Conversion (INPATIENT MEDS POST-INIT)",ZTIO="" D ^%ZTLOAD
 ;W !!,"The conversion of existing Unit Dose orders to the new format is",$S($D(ZTSK):"",1:" NOT")," queued",!
 D MES^XPDUTL(" ")
 S PSJMESSG="The conversion of existing Unit Dose orders to the new format is"_$S($D(ZTSK):"",1:" NOT")_" queued" D MES^XPDUTL(PSJMESSG)
 ;I $D(ZTSK) W " (to start NOW).",!!,"YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED."
 I $D(ZTSK) S PSJMESSG="(to start NOW). YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED." D MES^XPDUTL(PSJMESSG)
 Q
 ;
ENPL ; Entry point to begin conversion process to change pick list
 ; from primary drug to orderable item.
 ;
 K ZTSAVE,ZTSK S ZTIO="",ZTDTH=$H,ZTDESC="Conversion of Pick Lists",ZTRTN="DEQPL^PSJIPST2" D ^%ZTLOAD
 ;W !!,"The conversion of existing pick lists from primary drug to orderable item",!,"has",$S($D(ZTSK):"",1:" NOT")," been queued"
 D MES^XPDUTL(" ")
 S PSJMESSG="The conversion of existing pick lists from primary drug to orderable item has"_$S($D(ZTSK):"",1:" NOT")_" been queued" D MES^XPDUTL(PSJMESSG)
 ;I $D(ZTSK) W " (to start NOW).",!!,"YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED."
 I $D(ZTSK) S PSJMESSG=" (to start NOW). YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED." D MES^XPDUTL(PSJMESSG)
 Q
 ;
DEQORDER ; Convert existing UD and IV orders to new format.
 ; Entries found with no 0 node will be deleted!
 ; THIS IS NO LONGER USED
 Q
 D NOW^%DTC S PSJSTART=$E(%,1,12),PCNT=0
 F DFN=0:0 S DFN=$O(^PS(55,DFN)) Q:'DFN  D CONVERT^PSJUTL1(DFN,0) S PCNT=PCNT+1
 D BADNAMES^PSJIPST3 ; sends mail message if changed names were found
 ;
 ; Send mail message when Inpatient order conversion completes.
 K PSG,XMY S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="INPATIENT MEDS ORDER CONVERSION COMPLETED",XMTEXT="PSG(",XMY(DUZ)="" D NOW^%DTC S Y=% X ^DD("DD")
 S PSG(1,0)="  The conversion of existing Unit Dose orders for use with Inpatient",PSG(2,0)="Medications 5.0 completed as of "_Y_"."
 S X=$$FMDIFF^XLFDT(%,PSJSTART,3) S:$L(X," ")>1 DAYS=+$P(X," "),X=$P(X," ",2) S HOURS=+$P(X,":"),MINS=+$P(X,":",2)
 S PSG(3,0)=" ",PSG(4,0)="This process converted orders for "_PCNT_" patients in "_$S($G(DAYS):DAYS_" day"_$E("s",DAYS'=1)_", ",1:"")_HOURS_" hour"_$E("s",HOURS'=1),PSG(5,0)=" and "_MINS_" minute"_$E("s",MINS'=1)_"."
 N DIFROM D ^XMD
 ;
DONE ;
 K DA,DFN,DIC,DIE,DIK,DINUM,DLAYGO,DR,ITEM,MENU,ON,PSG,X,XMDUZ,XMSUB,XMTEXT,XMY,Y,ZTDESC,ZTDTH,ZTIO,ZTREQ,ZTRTN,ZTSAVE,ZTSK
 Q
UNDO ; FOR DIAGNOSTIC DEVELOPMENT ONLY!!!
 F DFN=0:0 S DFN=$O(^PS(55,DFN)) Q:'DFN  S $P(^PS(55,DFN,5.1),U,11)="" D
 .F ON=0:0 S ON=$O(^PS(55,DFN,5,ON)) Q:'ON  K ^PS(55,DFN,5,ON,.2)
 .F ON=0:0 S ON=$O(^PS(55,DFN,"IV",ON)) Q:ON  K ^PS(55,DFN,"IV",ON,.2)
 ;
SETUP ;
 S MENUP=$O(^ORD(101,"B",MENU,0)) I 'MENUP W $C(7),!!,"Cannot find the protocol menu '",MENU,"'.",!,"You need to add the protocol '",ITEM,"' to this protocol menu.",! Q
 ;
SETUP1 ;
 S X=$O(^ORD(101,"B",ITEM,0)) I 'X W $C(7),!!,"Cannot find the protocol '",ITEM,"'.",!,"You need to add this protocol to the protocol menu '",MENU,"'.",! Q
 I $D(^ORD(101,MENUP,10,"B",X)) W !,"Protocol '",ITEM,"' is already set up under the protocol",!,"menu '",MENU,"'." Q
 I $D(^ORD(101,MENUP,10,0))[0 S ^ORD(101,MENUP,10,0)="^"_$P(^DD(101,10,0),"^",2)
 K DA,DD,DO,DIC S DIC="^ORD(101,"_MENUP_",10,",DIC(0)="L",DLAYGO=101.01,DA(1)=MENUP D FILE^DICN
 W !,"Protocol '",ITEM,"' ",$S($P(Y,"^",3):"",1:"NOT "),"added to the protocol menu",!,"'",MENU,"'."
 Q
 ;
ENMUD ; Mark ALL 50 drugs as UD items.
 S PSIUX="U" F DRG=0:0 S DRG=$O(^PSDRUG(DRG)) Q:'DRG  I $S('$D(^PSDRUG(DRG,"I")):1,'+^("I"):1,+^("I")>DT:1,1:0) S PSIUDA=+DRG D ENS^PSGIU
MAILMUD ;
 N DRG,APU,PSJ,XMY D NOW^%DTC S Y=% X ^DD("DD") S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="MARK ALL DRUGS AS UNIT DOSE ITEMS",XMTEXT="PSJ(",XMY(DUZ)=""
 S PSJ(1,0)="  The process to mark all ACTIVE drugs in your local drug file (50) as Unit",PSJ(2,0)="Dose items completed as of "_$P(Y,"@")_" "_$P(Y,"@",2)_"."
 N DIFROM D ^XMD
 Q
