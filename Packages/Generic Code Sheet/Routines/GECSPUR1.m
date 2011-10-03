GECSPUR1 ;WISC/RFJ/KLD-purge code sheets (purge routine)                ;01 Nov 93
 ;;2.0;GCS;**23**;MAR 14, 1995
 Q
 ;
 ;
DQ ;  queue comes here
 N GECSBADA,GECSBATC,GECSCOUN,GECSDA,GECSDATA,GECSNOW,GECSTRAN,PAGE,SCREEN
 S SCREEN=0 I '$D(ZTQUEUED),IO=IO(0),$E(IOST)="C" S SCREEN=1
 D NOW^%DTC S Y=% D DD^%DT S GECSNOW=Y,PAGE=1 U IO D H
 W !!,"   STATION: ",GECS("SITE")_GECS("SITE1"),!,"BATCH TYPE: ",$S($G(GECSSYS)="*":"** ALL **",1:GECS("BATCH")),!,"      USER: ",$P($G(^VA(200,DUZ,0)),"^")
 W !!,"Deleting all code sheets created or transmitted before: ",GECSDATE
 ;
 ;  delete transmitted batches
 W !!,"deleting batches and code sheets contained in batches:"
 S (GECSCOUN,GECSBADA)=0 F  S GECSBADA=$O(^GECS(2101.3,GECSBADA)) Q:'GECSBADA  S GECSDATA=$G(^(GECSBADA,0)),GECSBATC=$P(GECSDATA,"^") D
 .   N GECSSUF
 .   S GECSSUF=GECS("SITE")_GECS("SITE1")
 .   I $P(GECSBATC,"-")'=GECSSUF Q
 .   I $G(GECSSYS)'="*",$P(GECSDATA,"^",2)'=GECS("SYSID") Q
 .   I $G(GECSSYS)'="*" I $P(GECSDATA,"^",6)=""!($P(GECSDATA,"^",6)'=GECS("BATDA")) Q
 .   I $P(GECSDATA,"^",10)'<GECSDT Q
 .   W !?5,GECSBATC
 .   D KILLBATC(GECSBADA)
 .   W "  --deleted, cleaning up associated code sheets:"
 .   ;  remove code sheets associated with batch
 .   W !?14
 .   S GECSDA=0 F  S GECSDA=$O(^GECS(2100,"AB",GECSBATC,GECSDA)) Q:'GECSDA  W $J($P($G(^GECS(2100,GECSDA,0)),"^"),10) D KILLCS(GECSDA) W:$X>68 !?14 S GECSCOUN=GECSCOUN+1
 ;
 ;  delete code sheets created before date and not batched
 W !,"cleaning up code sheets:",!?14
 S GECSDA=0 F  S GECSDA=$O(^GECS(2100,GECSDA)) Q:'GECSDA  S GECSDATA=$G(^(GECSDA,0)) D
 .   I $G(GECSSYS)'="*" I $P(GECSDATA,"^",2)'=GECS("SYSID")!($P(GECSDATA,"^",3)'=GECS("BATDA")) Q
 .   ;  delete code sheet if batch number is not found
 .   S GECSTRAN=$G(^GECS(2100,GECSDA,"TRANS"))
 .   I GECSTRAN'="",$P(GECSTRAN,"^",9)'="",'$O(^GECS(2101.3,"B",$P(GECSTRAN,"^",9),0)) W $J($P(GECSDATA,"^"),10) D KILLCS(GECSDA) W:$X>68 !?14 S GECSCOUN=GECSCOUN+1 Q
 .   ;
 .   ;  do not delete if code sheet has batch number, batched code
 .   ;  sheets deleted above
 .   I $P(GECSTRAN,"^",9)'="" Q
 .   I ($P(GECSDATA,"^",6)'=GECS("SITE"))&($P(GECSDATA,"^",7)'=GECS("SITE1")) Q
 .   I $P(GECSDATA,"^",10)>GECSDT Q
 .   W $J($P(GECSDATA,"^"),10) D KILLCS(GECSDA) W:$X>68 !?14 S GECSCOUN=GECSCOUN+1
 ;
 W !!,"Finished - deleted ",GECSCOUN," code sheets."
 ;
 ;  clean stack file
 I $G(GECSDTST) D
 .   W !,"cleaning up stack file:",!?14
 .   S GECSDA=0 F  S GECSDA=$O(^GECS(2100.1,GECSDA)) Q:'GECSDA  S GECSDATA=$G(^(GECSDA,0)) D
 .   .   I $P($P(GECSDATA,"^",3),".")>GECSDTST Q
 .   .   W $P(GECSDATA,"^"),!?14
 .   .   D KILLSTAC(GECSDA)
 Q
 ;
 ;
H ;  header
 S %=GECSNOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W !,"CODE SHEET/TRANSMISSION RECORD DELETION TRANSCRIPT ",%
 S %="",$P(%,"-",81)="" W !,%
 Q
 ;
 ;
KILLBATC(DA) ;  kill batch da from file 2101.3
 I '$D(^GECS(2101.3,DA)) Q
 N %,DIC,DIK,X,Y
 S DIK="^GECS(2101.3," D ^DIK
 Q
 ;
 ;
KILLCS(DA) ;  delete code sheet da
 I '$D(^GECS(2100,DA)) Q
 N %,DIC,DIK,X,Y
 S DIK="^GECS(2100," D ^DIK
 Q
 ;
 ;
KILLSTAC(DA)       ;  delete stack file entry da
 I '$D(^GECS(2100.1,DA)) Q
 N %,DIC,DIK,X,Y
 S DIK="^GECS(2100.1," D ^DIK
 Q
