PSOAMIS0 ;BHAM ISC/SAB,BHW - pharmacy amis compile/recompile routine ;2/9/06 4:13pm
 ;;7.0;OUTPATIENT PHARMACY;**17,25,158,232**;DEC 1997
 ;
 ; reference to ^VA(200 supported by IA# 224
 ; reference to ^PSDRUG supported by IA# 221
 ;
 ;PSO*232 alter For loops to include release/dates without time stamp
 ;
 K ^TMP("PSOAMIS",$J) S X="T-1",%DT="" D ^%DT S (PSDATE,HDATE)=Y,ENDATE=Y_".9999999" S DA=PSDATE,DIK="^PS(59.1," D ^DIK D CLE,ADD
 S PSDATE=PSDATE-1+.999999                                    ;PSO*232
 F RR=0:0 S PSDATE=$O(^PSRX("AL",PSDATE)) Q:'PSDATE!(PSDATE>ENDATE)  D COM
 S PSDATE=HDATE-1+.999999                                     ;PSO*232
 F RR=0:0 S PSDATE=$O(^PSRX("AM",PSDATE)) Q:'PSDATE!(PSDATE>ENDATE)  D COM1
 S PSDATE=HDATE D BUILD
END K ^TMP("PSOAMIS",$J),DIC,I,ENT,Y,X,DINUM,%DT,PSDATE,METHAD,DA,PSODFN,DRUG,NRC,PAT,PHYS,DIV,RX,ST,STY,STY1,SDT,EDT,R,RXF,TY,ENDATE,HDATE S:$D(ZTQUEUED) ZTREQ="@"
 K RX0,RX2,DIK,C,BLD,LSTDFN,LSTDT
 Q
COM F PSODFN=0:0 S PSODFN=$O(^PSRX("AL",PSDATE,PSODFN)) Q:'PSODFN  S DA="" F TY=0:0 S DA=$O(^PSRX("AL",PSDATE,PSODFN,DA)) Q:DA=""  I $D(^PSRX(PSODFN,0)) D
 .S RX0=^PSRX(PSODFN,0),RX2=^(2),PAT=$P(RX0,"^",2),ST=$P(RX0,"^",3),DRUG=$P(RX0,"^",6)
 .D:'DA ORI D:DA REF
 Q
COM1 F PSODFN=0:0 S PSODFN=$O(^PSRX("AM",PSDATE,PSODFN)) Q:'PSODFN  S DA=0 F  S DA=$O(^PSRX("AM",PSDATE,PSODFN,DA)) Q:'DA  I $D(^PSRX(PSODFN,0)) D:$P($G(^PSRX(PSODFN,"P",DA,0)),"^",19)
 .S RX0=^PSRX(PSODFN,0),RX2=^PSRX(PSODFN,2),PAT=$P(RX0,"^",2),ST=$P(RX0,"^",3),DRUG=$P(RX0,"^",6)
 .S RXF=^PSRX(PSODFN,"P",DA,0),DIV=$S($P(RXF,"^",9):$P(RXF,"^",9),1:$P(RX2,"^",9)),$P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",14)=+$P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",14)+1
 .S $P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",$S($P(RXF,"^",2)="W":15,1:16))=+$P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",$S($P(RXF,"^",2)="W":15,1:16))+1
 .S PHYS=$S($P(RXF,"^",17):+$P(RXF,"^",17),1:$P(RX0,"^",4))
 .I $P($G(^VA(200,PHYS,"PS")),"^",6)=4 S $P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",10)=+$P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",10)+1
 .E  S $P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",11)=+$P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",11)+1
 .D STA
 Q
ORI Q:'$P(RX2,"^",13)!('$D(^PS(59,+$P(RX2,"^",9),0)))
 S RX=^PSRX(PSODFN,0),PHYS=+$P(RX,"^",4),DIV=$S($P(RX2,"^",9):$P(RX2,"^",9),1:$O(^PS(59,0))),$P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",13)=+$P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",13)+1
 S $P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",$S($P(RX,"^",11)="W":15,1:16))=+$P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",$S($P(RX,"^",11)="W":15,1:16))+1
 I $P($G(^VA(200,PHYS,"PS")),"^",6)=4 S $P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",10)=+$P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",10)+1
 E  S $P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",11)=+$P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",11)+1
 D STA
 Q
REF Q:'$P($G(^PSRX(PSODFN,1,DA,0)),"^",18)!('$D(^PS(59,$P($G(^PSRX(PSODFN,1,DA,0)),"^",9),0)))
 S RXF=^PSRX(PSODFN,1,DA,0),DIV=$S($P(RXF,"^",9):$P(RXF,"^",9),1:DIV),$P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",14)=+$P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",14)+1
 S $P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",$S($P(RXF,"^",2)="W":15,1:16))=+$P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",$S($P(RXF,"^",2)="W":15,1:16))+1
 S PHYS=$S($P(RXF,"^",17):+$P(RXF,"^",17),1:$P(RX0,"^",4))
 I $P($G(^VA(200,PHYS,"PS")),"^",6)=4 S $P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",10)=+$P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",10)+1
 E  S $P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",11)=+$P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",11)+1
 D STA
 Q
CLE F I=0:0 S I=$O(^PS(59,I)) Q:'I  S METHAD(I)=+$P($G(^PS(59,I,5)),"^",2),^TMP("PSOAMIS",$J,"AMIS",I)=0
 Q
STA S STY=$P($G(^PS(53,ST,0)),"^",6)
 S $P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",$S(STY=1:2,STY=2:4,STY=3:6,STY=4:1,STY=5:17,1:12))=+$P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",$S(STY=1:2,STY=2:4,STY=3:6,STY=4:1,STY=5:17,1:12))+1
 S NRC=$P($G(^PSDRUG(DRUG,0)),"^",3) I NRC["A"!(NRC["C") S $P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",7)=$P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",7)+1
 S:DRUG=$G(METHAD(DIV)) $P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",8)=$P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",8)+1
 I '$D(^TMP("PSOAMIS",$J,DIV,PAT)) S ^TMP("PSOAMIS",$J,DIV,PAT)="",$P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",9)=$P(^TMP("PSOAMIS",$J,"AMIS",DIV),"^",9)+1
 Q
BUILD ;set global node
 F I=0:0 S I=$O(^PS(59,I)) Q:'I  S ^PS(59.1,$P(PSDATE,"."),1,I,0)=$P(^PS(59.1,$P(PSDATE,"."),1,I,0),"^")_"^"_^TMP("PSOAMIS",$J,"AMIS",I) D
 .F IFN=2:1:18 S $P(^PS(59.1,$P(PSDATE,"."),1,I,0),"^",IFN)=+$P(^PS(59.1,$P(PSDATE,"."),1,I,0),"^",IFN)
 K PAT,IFN,^TMP("PSOAMIS",$J)
 Q
ADD Q:$G(^PS(59.1,$P(PSDATE,"."),0))
 S (X,DINUM)=$P(PSDATE,"."),DIC="^PS(59.1,",DIC(0)="L" K DD,DO D FILE^DICN K DD,DO
 S I=0 F  S I=$O(^PS(59,I)) Q:'I  S ^PS(59.1,$P(PSDATE,"."),1,0)="^59.11PA^"_I,^PS(59.1,$P(PSDATE,"."),1,I,0)=I,^PS(59.1,$P(PSDATE,"."),1,"B",I,I)="" S $P(^PS(59.1,$P(PSDATE,"."),1,0),"^",4)=($P(^PS(59.1,$P(PSDATE,"."),1,0),"^",4)+1)
 Q
RECOM ;recompiles AMIS data
 K ^TMP("PSOAMIS",$J)
 W ! S %DT(0)=-DT,%DT("A")="Recompile AMIS Starting: " S %DT="EPXA" D ^%DT G:"^"[X END G RECOM:'Y S (HDATE,SDT)=Y K %DT(0)
REDT W ! S %DT(0)=SDT,%DT("A")="Ending Stats Date: " D ^%DT G:"^"[X END S EDT=Y I Y<0 G REDT
 S EDT=EDT_".9999999"
 S ZTRTN="BEG^PSOAMIS0",ZTDESC="Recompile Outpatient AMIS Data",ZTIO="" F G="SDT","EDT","HDATE" S:$D(@G) ZTSAVE(G)=""
 D ^%ZTLOAD W:$D(ZTSK) !!,"Task Queued !",! K SDT,EDT,G,ZTSK,ZTIO
 Q
BEG K LSTDFN,LSTDT,^TMP("PSOAMIS",$J) S LSTDT="",PSDATE=SDT,BLD=0
 S PSDT=SDT-1 F  S PSDT=$O(^PS(59.1,PSDT)) Q:'PSDT!(PSDT>EDT)  K ^PS(59.1,PSDT),^PS(59.1,"B",PSDT,PSDT)
 F I=0:0 S I=$O(^PS(59,I)) Q:'I  S METHAD(I)=+$P($G(^PS(59,I,5)),"^",2)
 S PSDATE=PSDATE-1+.999999                                    ;PSO*232
 F R=0:0 S PSDATE=$O(^PSRX("AL",PSDATE)) Q:'PSDATE!(PSDATE>EDT)  F RXN=0:0 S RXN=$O(^PSRX("AL",PSDATE,RXN)) Q:'RXN  S DA="" F TY=0:0 S DA=$O(^PSRX("AL",PSDATE,RXN,DA)) Q:DA=""  I $D(^PSRX(RXN,0)) D
 .S RX0=^PSRX(RXN,0),RX2=^(2),PAT=$P(RX0,"^",2),ST=$P(RX0,"^",3),DRUG=$P(RX0,"^",6)
 .D:'DA ORI1 D:DA REF1
 S PSDATE=HDATE-1+.999999                                     ;PSO*232
 F R=0:0 S PSDATE=$O(^PSRX("AM",PSDATE)) Q:'PSDATE!(PSDATE>EDT)  F RXN=0:0 S RXN=$O(^PSRX("AM",PSDATE,RXN)) Q:'RXN  S DA=0 F  S DA=$O(^PSRX("AM",PSDATE,RXN,DA)) Q:'DA  I $D(^PSRX(RXN,0)) D:$P($G(^PSRX(RXN,"P",DA,0)),"^",19)
 .S RX0=^PSRX(RXN,0),RX2=^(2),PAT=$P(RX0,"^",2),ST=$P(RX0,"^",3),DRUG=$P(RX0,"^",6)
 .S RXF=^PSRX(RXN,"P",DA,0),DIV=$S($P(RXF,"^",9):$P(RXF,"^",9),1:$P(RX2,"^",9))
 .D PAR
 ;
 Q
ORI1 Q:'$P(RX2,"^",13)
 S RX=^PSRX(RXN,0),PHYS=+$P(RX,"^",4),DIV=$S($P(RX2,"^",9):$P(RX2,"^",9),1:$O(^PS(59,0)))
 D SETNODE
 S $P(^PS(59.1,$P(PSDATE,"."),1,DIV,0),"^",14)=$P($G(^PS(59.1,$P(PSDATE,"."),1,DIV,0)),"^",14)+1
 S $P(^PS(59.1,$P(PSDATE,"."),1,DIV,0),"^",$S($P(RX,"^",11)="W":16,1:17))=$P(^PS(59.1,$P(PSDATE,"."),1,DIV,0),"^",$S($P(RX,"^",11)="W":16,1:17))+1
 D SETUP
 Q
REF1 Q:'$P($G(^PSRX(RXN,1,DA,0)),"^",18)
 S RXF=^PSRX(RXN,1,DA,0),DIV=$S($P(RXF,"^",9):$P(RXF,"^",9),1:DIV)
PAR D SETNODE
 S PHYS=$S($P(RXF,"^",17):+$P(RXF,"^",17),1:$P(RX0,"^",4))
 S $P(^PS(59.1,$P(PSDATE,"."),1,DIV,0),"^",15)=$P(^PS(59.1,$P(PSDATE,"."),1,DIV,0),"^",15)+1
 S $P(^PS(59.1,$P(PSDATE,"."),1,DIV,0),"^",$S($P(RXF,"^",2)="W":16,1:17))=$P(^PS(59.1,$P(PSDATE,"."),1,DIV,0),"^",$S($P(RXF,"^",2)="W":16,1:17))+1
 D SETUP
 Q
SETUP ;
 I $P($G(^VA(200,PHYS,"PS")),"^",6)=4 S $P(^PS(59.1,$P(PSDATE,"."),1,DIV,0),"^",11)=$P(^PS(59.1,$P(PSDATE,"."),1,DIV,0),"^",11)+1
 E  S $P(^PS(59.1,$P(PSDATE,"."),1,DIV,0),"^",12)=$P(^PS(59.1,$P(PSDATE,"."),1,DIV,0),"^",12)+1
 S STY=$P($G(^PS(53,ST,0)),"^",6)
 S $P(^PS(59.1,$P(PSDATE,"."),1,DIV,0),"^",$S(STY=1:3,STY=2:5,STY=3:7,STY=4:2,STY=5:18,1:13))=+$P(^PS(59.1,$P(PSDATE,"."),1,DIV,0),"^",$S(STY=1:3,STY=2:5,STY=3:7,STY=4:2,STY=5:18,1:13))+1
 S NRC=$P($G(^PSDRUG(DRUG,0)),"^",3) I NRC["A"!(NRC["C") S $P(^PS(59.1,$P(PSDATE,"."),1,DIV,0),"^",8)=$P(^PS(59.1,$P(PSDATE,"."),1,DIV,0),"^",8)+1
 S:DRUG=$G(METHAD(DIV)) $P(^PS(59.1,$P(PSDATE,"."),1,DIV,0),"^",9)=$P(^PS(59.1,$P(PSDATE,"."),1,DIV,0),"^",9)+1
 I '$D(^TMP("PSOAMIS",$J,DIV,$P(PSDATE,"."),PAT)) S ^TMP("PSOAMIS",$J,DIV,$P(PSDATE,"."),PAT)="",$P(^PS(59.1,$P(PSDATE,"."),1,DIV,0),"^",10)=$P(^PS(59.1,$P(PSDATE,"."),1,DIV,0),"^",10)+1
 Q
SETNODE ;
 I '$G(^PS(59.1,$P(PSDATE,"."),0)) D
 .S (X,DINUM)=$P(PSDATE,"."),DIC="^PS(59.1,",DIC(0)="L" K DD,DO D FILE^DICN K DD,DO
 .S ^PS(59.1,$P(PSDATE,"."),1,0)="^59.11PA^"
 .F I=0:0 S I=$O(^PS(59,I)) Q:'I  S ^PS(59.1,$P(PSDATE,"."),1,I,0)=I_"^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0",^PS(59.1,$P(PSDATE,"."),1,"B",I,I)="" D
 ..S $P(^PS(59.1,$P(PSDATE,"."),1,0),"^",3)=I,$P(^PS(59.1,$P(PSDATE,"."),1,0),"^",4)=($P(^PS(59.1,$P(PSDATE,"."),1,0),"^",4)+1)
 Q
