GECSREP0 ;WISC/RFJ/KLD-reports                                          ;08 Nov 93
 ;;2.0;GCS;**13,14**;MAR 14, 1995
 Q
 ;
 ;
READYBAT ;  print code sheets ready for batching
 N %X,DIJ,DP,GECS
 D ^GECSSITE Q:'$G(GECS("SITE"))
 D BATNOFMS^GECSUSEL Q:'$G(GECS("BATDA"))
 S DIS(0)="I $P(^GECS(2100,D0,0),U,3)=GECS(""BATDA"")"
 S DIC="^GECS(2100,",L=0,(BY,FLDS)="[GECS READY FOR BATCHING]" W ! D EN1^DIP
 I $E(IOST)="C",'$D(ZTSK) D R^GECSUTIL
 D ^%ZISC
 Q
 ;
 ;
READYTRA ;  print code sheets ready for transmission
 N %X,DIJ,DP,GECS
 D ^GECSSITE Q:'$G(GECS("SITE"))
 D BATNOFMS^GECSUSEL Q:'$G(GECS("BATDA"))
READYTR1 ;  call to print code sheets ready for transmission with
 ;  all variables defined
 S (BY,FLDS)="[GECS READY FOR TRANSMISSION]"
 S XP="Do you want to print the code sheet",XH="'YES' will print a listing of the CODE Sheet.",XH(1)="'NO' will print a listing of the code sheet ID."
 W ! S %=$$YN^GECSUTIL(2) I %=0 Q
 I %=1 S FLDS="[GECS TRANSMIT LIST]"
 S DIS(0)="I $P(^GECS(2100,D0,0),U,3)=GECS(""BATDA""),$P(^GECS(2100,D0,0),U,6)=GECS(""SITE""),$P(^GECS(2100,D0,0),U,7)=GECS(""SITE1"")"
 S DIC="^GECS(2100,",L=0 W ! D EN1^DIP
 I $E(IOST)="C",'$D(ZTSK) D R^GECSUTIL
 D ^%ZISC
 Q
 ;
 ;
BATCHES ;  status of all batches
 N %X,DIJ,DP,GECS
 D ^GECSSITE Q:'$G(GECS("SITE"))
 D BATNOFMS^GECSUSEL Q:'$G(GECS("BATDA"))
 S GECS("SITEHLD")=GECS("SITE")_GECS("SITE1")
 S DIS(0)="I $S($P(^GECS(2101.3,D0,0),""-"",1)=GECS(""SITEHLD"")&($P(^GECS(2101.3,D0,0),U,6)=GECS(""BATDA"")):1,1:0)"
 S DIC="^GECS(2101.3,",L=0,(BY,FLDS)="[GECS BATCH STATUS]" W ! D EN1^DIP
 I $E(IOST)="C",'$D(ZTSK) D R^GECSUTIL
 D ^%ZISC
 Q
 ;
 ;
WAITBAT ;  listing of batches awaiting transmission
 N %X,DIJ,DP,GECS
 D ^GECSSITE Q:'$G(GECS("SITE"))
 D BATNOFMS^GECSUSEL Q:'$G(GECS("BATDA"))
 S XP="Do you want a detailed listing",XH="'YES' will print the ID or actual code sheets by batch.",XH(1)="'NO' will only print the batch numbers."
 W ! S %=$$YN^GECSUTIL(2) I '% Q
 S GECS("SITEHLD")=GECS("SITE")_GECS("SITE1")
 I %=1 D READYTR1 Q
 S DIS(0)="S %=^GECS(2101.3,D0,0) I $S($P(^GECS(2101.3,D0,0),""-"",1)=GECS(""SITEHLD"")&($P(^GECS(2101.3,D0,0),U,3)=""B"")&($P(^GECS(2101.3,D0,0),U,6)=GECS(""BATDA"")):1,1:0)"
 S DIC="^GECS(2101.3,",L=0,(BY,FLDS)="[GECS BATCHES WAITING]" D EN1^DIP
 I $E(IOST)="C",'$D(ZTSK) D R^GECSUTIL
 D ^%ZISC
 Q
