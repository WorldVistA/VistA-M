ONCDTX1 ;Hines OIFO/RTK;DELETE @FAC TREATMENT FIELDS; 09/25/98
 ;;2.11;ONCOLOGY;**19,22,27,36,39,42**;Mar 07, 1995
 ;
DELATF ;Delete all treatment @fac
 S $P(^ONCO(165.5,DA,3.1),U,7)="" D SPSATFR    ;50.2
 S $P(^ONCO(165.5,DA,3.1),U,30)="" D SPSATF    ;58.7
 S $P(^ONCO(165.5,DA,3.1),U,9)="" D SCPATFR    ;138.1
 S $P(^ONCO(165.5,DA,3.1),U,32)="" D SCPATF    ;138.5
 S $P(^ONCO(165.5,DA,3.1),U,10)="" D SOSATFR   ;139.1
 S $P(^ONCO(165.5,DA,3.1),U,34)="" D SOSNATF   ;139.5
 S $P(^ONCO(165.5,DA,3.1),U,12)="" D RADATF    ;51.2
 S $P(^ONCO(165.5,DA,3.1),U,14)="" D CHEMATF   ;53.2
 S $P(^ONCO(165.5,DA,3.1),U,16)="" D HORATF    ;54.2
 S $P(^ONCO(165.5,DA,3.1),U,18)="" D IMMATF    ;55.2
 S $P(^ONCO(165.5,DA,3.1),U,20)="" D OTHATF    ;57.2
 K NTDEL Q
 ;
NCDSATF ;SURG DX/STAGING PROC @FAC (165.5,58.4)
 Q:$P(^ONCO(165.5,DA,3.1),U,5)'=""
 S $P(^ONCO(165.5,DA,3.1),U,6)=""
 W:$G(DNCATF)'=1 !!,"Deleting data from the following fields...",!
 W !," SURG DX/STAGING PROC @FAC"
 W !," SURG DX/STAGING PROC @FAC DATE"
 Q
 ;
SPSATFR ;SURGERY OF PRIMARY @FAC (R) (165.5,50.2)
 Q:$P(^ONCO(165.5,DA,3.1),U,7)'=""
 I $D(NTDEL) Q
 W:$G(DSATF)'=1 !!,"Deleting data from the following fields...",!
 W !,"  SURGERY OF PRIMARY @FAC (R)"
 Q
 ;
SPSATF ;SURGERY OF PRIMARY @FAC (F) (165.5,58.7)
 Q:$P(^ONCO(165.5,DA,3.1),U,30)'=""
 S $P(^ONCO(165.5,DA,3.1),U,8)=""
 I $D(NTDEL) Q
 W:$G(DSATF)'=1 !!,"Deleting data from the following fields...",!
 W !,"  SURGERY OF PRIMARY @FAC (F)"
 W !,"  MOST DEFINITIVE SURG @FAC DATE"
 Q
 ;
SCPATFR ;SCOPE OF LN SURGERY @FAC (R) (165.5,138.1)
 Q:$P(^ONCO(165.5,DA,3.1),U,9)'=""
 S $P(^ONCO(165.5,DA,3.1),U,11)=""
 I $D(NTDEL) Q
 W:$G(DSCATF)'=1 !!,"Deleting data from the following fields...",!
 W !,"  SCOPE OF LN SURGERY @FAC (R)"
 W !,"  NUMBER OF LN REMOVED @FAC (R)"
 Q
 ;
SCPATF ;SCOPE OF LN SURGERY @FAC (F) (165.5,138.5)
 Q:$P(^ONCO(165.5,DA,3.1),U,32)'=""
 S $P(^ONCO(165.5,DA,3.1),U,23)=""
 I $D(NTDEL) Q
 W:$G(DSCATF)'=1 !!,"Deleting data from the following fields...",!
 W !,"  SCOPE OF LN SURGERY @FAC (F)"
 W !,"  SCOPE OF LN SURGERY @FAC DATE"
 Q
 ;
SOSATFR ;SURG PROC/OTHER SITE @FAC (R) (165.5,139.1)
 Q:$P(^ONCO(165.5,DA,3.1),U,10)'=""
 I $D(NTDEL) Q
 W:$G(DSOATF)'=1 !!,"Deleting data from the following fields...",!
 W !,"  SURG PROC/OTHER SITE @FAC (R)"
 Q
 ;
SOSNATF ;SURG PROC/OTHER SITE @FAC (F) (165.5,139.5)
 Q:$P(^ONCO(165.5,DA,3.1),U,34)'=""
 S $P(^ONCO(165.5,DA,3.1),U,25)=""
 I $D(NTDEL) Q
 W:$G(DSOATF)'=1 !!,"Deleting data from the following fields...",!
 W !,"  SURG PROC/OTHER SITE @FAC (F)"
 W !,"  SURG PROC/OTHER SITE @FAC DATE"
 Q
 ;
RADATF ;Radiation @fac
 Q:$P(^ONCO(165.5,DA,3.1),U,12)'=""
 S $P(^ONCO(165.5,DA,3.1),U,13)=""
 I $D(NTDEL) Q
 W:$G(DRATF)'=1 !!,"Deleting data from the following fields...",!
 W !,"  RADIATION @FAC"
 I $G(DRATF)=1 W ?40
 I $G(DRATF)'=1 W !,"  "
 W "RADIATION @FAC DATE"
 Q
 ;
CHEMATF ;Chemotherapy @fac
 Q:$P(^ONCO(165.5,DA,3.1),U,14)'=""   ;53.3
 S $P(^ONCO(165.5,DA,3.1),U,15)=""    ;53.4
 I $D(NTDEL) Q
 W:$G(DCATF)'=1 !!,"Deleting data from the following fields...",!
 W !,"  CHEMOTHERAPY @FAC"
 W !,"  CHEMOTHERAPY @FAC DATE"
 Q
 ;
HORATF ;Hormone therapy @fac
 Q:$P(^ONCO(165.5,DA,3.1),U,16)'=""   ;54.3
 S $P(^ONCO(165.5,DA,3.1),U,17)=""    ;54.4
 I $D(NTDEL) Q
 W:$G(DHATF)'=1 !!,"Deleting data from the following fields...",!
 W !,"  HORMONE THERAPY @FAC"
 W !,"  HORMONE THERAPY @FAC DATE"
 Q
 ;
IMMATF ;Immunotherapy @fac
 Q:$P(^ONCO(165.5,DA,3.1),U,18)'=""   ;55.3
 S $P(^ONCO(165.5,DA,3.1),U,19)=""    ;55.4
 I $D(NTDEL) Q
 W:$G(DIATF)'=1 !!,"Deleting data from the following fields...",!
 W !,"  IMMUNOTHERAPY @FAC"
 W !,"  IMMUNOTHERAPY @FAC DATE"
 Q
 ;
OTHATF ;Other treatment @fac
 Q:$P(^ONCO(165.5,DA,3.1),U,20)'=""   ;57.3
 S $P(^ONCO(165.5,DA,3.1),U,21)=""    ;57.4
 I $D(NTDEL) Q
 W:$G(DOATF)'=1 !!,"Deleting data from the following fields...",!
 W !,"  OTHER TREATMENT @FAC"
 W !,"  OTHER TREATMENT @FAC DATE"
 Q
