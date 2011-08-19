GECSMUT2 ;WISC/RFJ/KLD-maintenance utilities ;13 Oct 98
 ;;2.0;GCS;**19,33**;MAR 14, 1995
 Q
 ;
 ;
RETRAN ;  mark a batch for retransmission
 N %,GECS,GECSBATC,GECSDATA,GECSDICS
 D ^GECSSITE Q:'$G(GECS("SITE"))
 D BATNOFMS^GECSUSEL Q:'$G(GECS("BATDA"))
 S GECS("SITECOM")=GECS("SITE")_GECS("SITE1")
 S GECSDICS="S %=^(0) I $P($P(%,U),""-"")=GECS(""SITECOM""),$P($P(%,U),""-"",2)=GECS(""SYSID""),$P(%,U,4)'="""",$P(%,U,3)=""T"",$S($P(%,U,6)="""":1,$P(%,U,6)=GECS(""BATDA""):1,1:0)"
 F  W ! S GECSBATC=$$BATCHSEL^GECSUSEL(GECSDICS) Q:'GECSBATC  D
 .   S GECSDATA=$G(^GECS(2101.3,GECSBATC,0)) I GECSDATA="" Q
 .   I $E($P(GECSDATA,"^",4),1,5)=$E(DT,1,5),$E(DT,6,7)>9,$P(GECSDATA,"^",2)="AMS" D
 .   .   W !!,"WARNING -- If you have already sent the AMIS code sheets for this month and the",!,"code sheets are duplicates, Austin will reject messages for each of the",!,"duplicates."
 .   S XP="READY TO MARK BATCH FOR RETRANSMISSION",XH="Enter 'YES' to mark batch for retransmission, 'NO' or '^' to exit."
 .   I $$YN^GECSUTIL(2)'=1 Q
 .   D MARK(GECSBATC)
 .   W !
 .   S %=0 F  S %=$O(^GECS(2100,"AB",GECS("BATCH"),%)) Q:'%  I $D(^GECS(2100,%,0)) D
 .   .   S $P(^GECS(2100,%,"TRANS"),"^",2)="Y",^GECS(2100,"AE","Y",%)=""
 .   .   W $J($P(^GECS(2100,%,0),"^"),10)
 .   .   I $X>68 W !
 .   W !,"Batch Number ",GECS("BATCH")," ready for transmission."
 Q
 ;
 ;
MARK(DA) ;  mark batch for transmission
 N D0,DDH,DI,DQ,DIC,DIE,DR,X,Y
 S (DIC,DIE)="^GECS(2101.3,",DR=".5////B;4///@;5///@"
 D ^DIE
 K ^GECS(2101.3,DA,2)
 Q
