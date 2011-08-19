MCARAM0H ;WASH ISC/JKL-MUSE AUTO INSTRUMENT REINIT-REMOVE RELEASE STATUS,ADD CONFIRMATION STATUS ;1/31/95  11:36
 ;;2.3;Medicine;;09/13/1996
 ;
 ;
 ;Called from ^MCARAM0
 ;Remove release status from any automated records
 ;Add confirmation status to any automated records
 N MCIEN,MCSTAT,MCRSR,MCCSA
 S (MCIEN,MCRSR,MCCSA)=0
 F  S MCIEN=$O(^MCAR(691.5,MCIEN)) Q:MCIEN="B"  I $D(^MCAR(691.5,MCIEN,"A")) D REMOVE,ADD
 W !!,MCRSR," automated records modified by removing release status."
 W !!,MCCSA," automated records modified by adding confirmation status."
 Q
REMOVE ;
 I '$D(^MCAR(691.5,MCIEN,"ES")) Q
 S MCSTAT=$P(^MCAR(691.5,MCIEN,"ES"),"^",7)
 K ^MCAR(691.5,MCIEN,"ES")
 I MCSTAT'="",$D(^MCAR(691.5,"ES",MCSTAT,MCIEN)) K ^MCAR(691.5,"ES",MCSTAT,MCIEN)
 S MCRSR=MCRSR+1
 W:(MCRSR+MCCSA)#100=0 "."
 Q
ADD ;
 I $P(^MCAR(691.5,MCIEN,0),"^",12)="C" Q
 S $P(^MCAR(691.5,MCIEN,0),"^",12)="C",MCCSA=MCCSA+1
 W:(MCRSR+MCCSA)#100=0 "."
 Q
