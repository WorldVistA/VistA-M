PSOMGCM1 ;BHAM ISC/JMB,SAB - management data compile/recompile ;4/15/05 3:10pm
 ;;7.0;OUTPATIENT PHARMACY;**20,28,175,185,198**;DEC 1997
 ;Ref. to $$RXSUM^FBRXUTL supp. by IA# 4395
 ;Ref. to ^PSDRUG(, supp. by IA# 221
 ;PSO*198 correct begin date to previous day @ time 999999
 ;
END K ^TMP($J),%DT,AVGCAT,AVGEQFL,AVGFEE,AVGST,CAT,CATA,CATC,CATCOST,COST,DA,DATE,DIC,DINUM,DFN,DIRUT,DIV,DV,EQCOST,EQFL,EQPREQ,DRUG,EDT,FEE,FCOST,INV,MAIL,METH,NEW,METH,METHAD,OTH,PCAT,PHYS,PP,PPCOST,PREQ,PDATE,RECOM
 K QTY30,QTY60,QTY90,QTY90P,QTY120,QTY179,QTY180,REC,R,REF,RX0,RXF,RXPREQ,SDT,ST,STAFF,STCOST,SUB,VAEL,WIND,AVGMETH,COSTPST,METHCOST,PCPP,NODE1,X,Y,ZTDESC,ZTDTH,ZTRTN,ZTSAVE
 K TFIL,TFTY,TFCT,TY,NDT,DAYS,COM,STN S:$D(ZTQUEUED) ZTREQ="@"
 Q
PURG ;purge data for a date range
 W !,"Purge Management Statistics",!! S SDT=$O(^PS(59.12,0)) I $D(SDT) S Y=SDT D DD^%DT S %DT("B")=Y
 S %DT(0)=-DT,%DT("A")="Starting date: " S %DT="EPXA" D ^%DT G:"^"[X END G RECOM:'Y S SDT=Y K %DT(0) S Y=SDT D DD^%DT S SY=Y K %DT("B"),Y
PDT W ! S %DT(0)=SDT,%DT("A")="  Ending date: " D ^%DT G:"^"[X END G:Y<0 PDT S EDT=Y W !
 W !,$C(7),$C(7) S Y=EDT D DD^%DT W !!!,"Purge from "_SY_" to "_Y,!
 S DIR("A")="Are you sure",DIR(0)="Y",DIR("B")="N" D ^DIR K DIR I $G(DIRUT)!('Y) K EDT,SDT,SY,Y W !,$C(7),"No data has been purged." Q
 S ZTDTH="",ZTRTN="P^PSOMGCM1",ZTDESC="Outpatient Pharmacy Management Data Purge",ZTIO="" F G="SDT","EDT" S:$D(@G) ZTSAVE(G)=""
 D ^%ZTLOAD W:$D(ZTSK) !!,"Task Queued !",! K SDT,EDT,G,ZTSK,ZTIO S:$D(ZTQUEUED) ZTREQ="@"
 Q
P S DIK="^PS(59.12," F DA=SDT-1:0 S DA=$O(^PS(59.12,DA)) Q:'DA!(DA>EDT)  D ^DIK
 K DIK Q
TSK ;initialize nightly mgmt. compile job
 D SETUP1^PSOAUTOC
 W ! K DIR S DIR("B")="NO",DIR(0)="Y",DIR("A")="Do you want to compile data prior to yesterday" D ^DIR I 'Y!($D(DIRUT)) G EX
 D RECOM
EX K DIR,X,Y
 Q
TASK ;compile every night
 S X1=DT,X2=-1 D C^%DTC S (EDT,SDT)=X K X1,X2 D BEG
 Q
QUE S ZTDTH=$H+1_",3600",ZTIO="",ZTRTN="TASK^PSOMGCM1",ZTDESC="Outpatient Pharmacy Daily Compile of Management Data",ZTIO=""
 D ^%ZTLOAD W:$D(ZTSK)&('$D(ZTQUEUED)) !!,"Task Queued !",! K DAY,SDT,EDT,G,ZTSK,ZTIO S:$D(ZTQUEUED) ZTREQ="@"
 Q
DAY ;recompile by day
 W ! S %DT(0)=-DT,%DT("A")="Date: " S %DT="EPXA" D ^%DT G:"^"[X END G DAY:'Y S (SDT,EDT)=Y K %DT(0) S COM=1 W !
 G Q
RECOM ;recompile data for a date range
 W ! S %DT(0)=-DT,%DT("A")="Starting date: " S %DT="EPXA" D ^%DT G:"^"[X END G RECOM:'Y S SDT=Y K %DT(0)
REDT W ! S %DT(0)=SDT,%DT("A")="  Ending date: " D ^%DT G:"^"[X END I Y<0!(Y>DT) W " ??" G REDT
 S EDT=Y S COM="R" W !
Q S ZTDTH="",ZTRTN="BEG^PSOMGCM1",ZTDESC="Outpatient Pharmacy Management Data Recompile "_$S(COM:"One Day",1:"Range of Days"),ZTIO="" F G="SDT","EDT" S:$D(@G) ZTSAVE(G)=""
 D ^%ZTLOAD W:$D(ZTSK) !!,"Task Queued !",! K SDT,EDT,G,ZTSK,ZTIO S:$D(ZTQUEUED) ZTREQ="@"
 Q
BEG S DIK="^PS(59.12,",DA=SDT-1 F  S DA=$O(^PS(59.12,DA)) Q:'DA!(DA>EDT)  D ^DIK
 K DA,DIK F NDT=SDT:1:EDT D BEG1
 D FBA G END
 Q
 ;PSO*198 seed loop to previous day @ time 999999
BEG1 K ^TMP($J) D CLE^PSOMGCOM F TY="AL","AM" S PDATE=NDT-1+.999999 F  S PDATE=$O(^PSRX(TY,PDATE)) Q:'PDATE!(PDATE>(NDT_".999999"))  D BEG2
 S PDATE=NDT D:TFIL ADD,BUILD^PSOMGCOM
 Q 
BEG2 S REC=0 F  S REC=$O(^PSRX(TY,PDATE,REC)) Q:'REC  D BEG3
 Q
BEG3 Q:'$D(^PSRX(REC,0))  S DA="" F  S DA=$O(^PSRX(TY,PDATE,REC,DA)) Q:DA=""  D
 .S RX0=^PSRX(REC,0),DFN=$P(RX0,"^",2),ST=$P(RX0,"^",3),PHYS=$P(RX0,"^",4),DRUG=$P(RX0,"^",6),DAYS=$P(RX0,"^",8)
 .Q:'DFN!('DRUG)  D:TY="AL" COM1^PSOMGCOM D:TY="AM" COM2
 Q
COM2 Q:'$P($G(^PSRX(REC,"P",DA,0)),"^",19)
 S RXF=^PSRX(REC,"P",DA,0),DV=$S($P(RXF,"^",9):$P(RXF,"^",9),1:$O(^PS(59,0))),REF(DV)=REF(DV)+1 S:$P(RXF,"^",2)="W" WIND(DV)=WIND(DV)+1 S:$P(RXF,"^",2)="M" MAIL(DV)=MAIL(DV)+1 S DATE=$P(^PSRX(REC,"P",0),"^")-.01
 S COST=$P(RXF,"^",4)*$S($P(RXF,"^",11):$P(RXF,"^",11),1:+$P($G(^PSDRUG(+$P(^PSRX(REC,0),"^",6),660)),"^",6))
 D DAYS^PSOMGCOM,STA^PSOMGCOM
 Q
FBA S (STN,DV)=0 S:'$G(DT) DT=$$DT^XLFDT
 F  S DV=$O(^PS(59,DV)) Q:'DV  D  Q:STN
 .I '$G(^PS(59,DV,"I"))!(DT'>$G(^PS(59,DV,"I"))) S STN=$P(^("INI"),"^"),STN=+$$GET1^DIQ(4,STN,99)
 I 'STN S PP="Invalid Related Institution in File #59" G MAIL
 F PDATE=SDT:1:EDT S PP=$$RXSUM^FBRXUTL(PDATE,STN) Q:+PP<0  D:+PP>0
 .S PPCOST=$P(PP,"^",2),PP=+PP D SET
 I +PP<0 S PP=$P(PP,"^",3) G MAIL
 Q
MAIL F PSO1=0:0 S PSO1=$O(^XUSEC("PSORPH",PSO1)) Q:'PSO1  S XMY(PSO1)=""
 Q:$O(XMY(""))=""
 S XMDUZ="Outpatient Pharmacy Package"
 S XMSUB="FEE Basis Cost Data - Incomplete Nightly Job"
 S PP=$E(PP_".                              ",1,42)
 S PSO(1)="**************************************************"
 S PSO(2)="*** FEE Basis Cost data was not collected for  ***"
 S PSO(3)="*** the period "_$E(SDT,4,5)_"/"_$E(SDT,6,7)_"/"_$E(SDT,2,3)_" to "_$E(EDT,4,5)_"/"_$E(EDT,6,7)_"/"_$E(EDT,2,3)_".           ***"
 S PSO(4)="***                                            ***"
 S PSO(5)="*** The reason reported was:                   ***"
 S PSO(6)="*** "_PP_" ***"
 S PSO(7)="***                                            ***"
 S PSO(8)="*** You may have to manually recompile this    ***"
 S PSO(9)="*** data at a later date.                      ***"
 S PSO(10)="**************************************************"
 S XMTEXT="PSO(" N DIFROM D ^XMD K XMSUB,XMDUZ,XMTEXT,PSO,PSO1
 Q
SET I '$D(^PS(59.12,PDATE,0)) D ADD S DV=0 F  S DV=$O(^PS(59,DV)) Q:'+DV  D
 .S ^PS(59.12,PDATE,1,DV,0)=DV_"^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0",^PS(59.12,PDATE,2,DV,0)=DV_"^0^0^0^0^0^0^0^0^0^0^0^0^0.0",^PS(59.12,PDATE,3,DV,0)=DV_"^0.00^0.00^0.00^0.00^0.00^0.00^0.00^0.00^0.00"
 S DV=0,DV=$O(^PS(59,DV)),$P(^PS(59.12,PDATE,2,DV,0),"^",13)=PP,FEE=0
 F DIV=0:0 S DIV=$O(^PS(59.12,PDATE,2,DIV)) Q:'+DIV  S FEE=FEE+$P(^PS(59.12,PDATE,2,DIV,0),"^",3)
 S $P(^PS(59.12,PDATE,2,DV,0),"^",14)=$FN($S(FEE=0:100.0,$P(^PS(59.12,PDATE,2,DV,0),"^",13)=0:0,1:(FEE/(FEE+$P(^PS(59.12,$P(PDATE,"."),2,DV,0),"^",13)))*100),"",1)
 S $P(^PS(59.12,PDATE,3,DV,0),"^",9)=$FN(PPCOST,"",2),$P(^PS(59.12,PDATE,3,DV,0),"^",10)=$FN($S(PPCOST=0!(PP=0):0,1:PPCOST/PP),"",2)
 Q
ADD S (X,DINUM)=PDATE,DIC="^PS(59.12,",DIC(0)="L" K DD,DO D FILE^DICN F DV=0:0 S DV=$O(^PS(59,DV)) Q:'+DV  D ADDEM
 Q
ADDEM S ^PS(59.12,PDATE,1,0)="^59.121A^"_DV_"^"_TFIL,^PS(59.12,PDATE,1,DV,0)=DV,^PS(59.12,PDATE,1,"B",DV,DV)=""
 S ^PS(59.12,PDATE,2,0)="^59.122A^"_DV_"^"_TFTY,^PS(59.12,PDATE,2,DV,0)=DV,^PS(59.12,PDATE,2,"B",DV,DV)=""
 S ^PS(59.12,PDATE,3,0)="^59.123A^"_DV_"^"_TFCT,^PS(59.12,PDATE,3,DV,0)=DV,^PS(59.12,PDATE,3,"B",DV,DV)=""
 Q
