PSOSUTL ;BIR/RTR - Suspense utility routine ;12/15/95
 ;;7.0;OUTPATIENT PHARMACY;**10,34,139,167,235**;DEC 1997
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^PSNDF supported by DBIA 2195
AREC1 ;
 S $P(^PSRX(RX,"STA"),"^")=0
 S SFN=$O(^PS(52.5,"B",RX,0)) I 'SFN D CPMS Q
 D NOW^%DTC S DTTM=% S COM="Suspense "_$S($G(RXRP(RX)):"(Reprint) ",1:"")_"Label Pulled Early"_$S($G(RXP):" (Partial)",1:"") S CNT=0 F JJ=0:0 S JJ=$O(^PSRX(RX,"A",JJ)) Q:'JJ  S CNT=JJ
 D DEL S $P(^PSRX(RX,"STA"),"^")=0 K PSODEL S RFCNT=0 F RF=0:0 S RF=$O(^PSRX(RX,1,RF)) Q:'RF  S RFCNT=RF
 I 'RFCNT,'$G(RXP),'$D(RXRP(RX)) S (X,OLD)=$P(^PSRX(RX,2),"^",2) D  K DIE
 .K DIE S DA=RX,DR="22////"_DT_";101////"_DT_";25////"_DT,DIE=52 D ^DIE
 I RFCNT,'$G(RXP),'$D(RXRP(RX)) S (OLD,X)=+$P($G(^PSRX(RX,1,RFCNT,0)),"^") D  K DIE S $P(^PSRX(RX,3),"^")=DT
 .K DIE S DA(1)=RX,DA=RFCNT,DIE="^PSRX("_DA(1)_",1,",DR=".01///"_DT_";10.1///"_DT D ^DIE
 S:'$D(PDUZ) PDUZ=DUZ S CNT=CNT+1,^PSRX(RX,"A",0)="^52.3DA^"_CNT_"^"_CNT
 S ^PSRX(RX,"A",CNT,0)=DTTM_"^S^"_PDUZ_"^"_$S($G(RXP):6,'RFCNT:RFCNT,RFCNT<6:RFCNT,1:(RFCNT+1))_"^"_COM
 D CPMS
 Q
CPMS ;
 N PSOZZDD S PSOZZDD="Label printed from suspense" D EN^PSOHLSN1(RX,"SC","ZU",PSOZZDD) K PSOZZDD
 Q
 ;
DEL S DA=SFN,DIK="^PS(52.5," D ^DIK K DIK Q
 ;I 'PSODELE S NODE=^PS(52.5,SFN,0) K ^PS(52.5,"C",$P(NODE,"^",2),SFN),^PS(52.5,"AC",$P(NODE,"^",3),$P(NODE,"^",2),SFN) S $P(^PS(52.5,SFN,0),"^",2)=DT,^PS(52.5,"C",DT,SFN)="",^PS(52.5,SFN,"P")=1 D  K NODE
 ;.S X1=DT,X2=+$P($G(^PS(59.7,1,40.1)),"^",5) D C^%DTC S ^PS(52.5,"ADL",X,SFN)="" K X
 ;I $P($G(^PS(52.5,SFN,0)),"^",7)'="" N DA,DR,DIE S DA=SFN,DIE="^PS(52.5,",DR="3////P" D ^DIE
 Q
AREC N PSOZZDMS S PSOZZDMS=0 S:$P(^PSRX(RX,"STA"),"^")=5 PSOZZDMS=1
 S:$P(^PSRX(RX,"STA"),"^")=5 $P(^PSRX(RX,"STA"),"^")=0 S SFN=$O(^PS(52.5,"B",RX,0)) D:'SFN&(PSOZZDMS) CPMSG Q:'SFN  D NOW^%DTC S DTTM=% S COM="Suspense "_$S($G(RXRP(RX)):"(Reprint) ",1:"")_"Label Printed"_$S($G(RXP):" (Partial)",1:"")
 S $P(^PS(52.5,SFN,"P"),"^")=1 D  K ^PS(52.5,"AC",DFN,$P(^PS(52.5,SFN,0),"^",2),SFN) S CNT=0 F JJ=0:0 S JJ=$O(^PSRX(RX,"A",JJ)) Q:'JJ  S CNT=JJ
 .S ^PS(52.5,"ADL",$E(PSOTIME,1,7),SFN)=""
 S RFCNT=0 F RF=0:0 S RF=$O(^PSRX(RX,1,RF)) Q:'RF  S RFCNT=RF S:RF>5 RFCNT=RF+1
 S CNT=CNT+1,^PSRX(RX,"A",0)="^52.3DA^"_CNT_"^"_CNT S ^PSRX(RX,"A",CNT,0)=DTTM_"^S^"_DUZ_"^"_$S($G(RXP):6,1:RFCNT)_"^"_COM
 S $P(^PS(52.5,SFN,0),"^",8)=PSOTIME,$P(^PS(52.5,SFN,0),"^",9)=PDUZ S:'$P(^PS(52.5,SFN,0),"^",6) $P(^PS(52.5,SFN,0),"^",6)=PSOSITE
 I PSOZZDMS D CPMSG
 Q
CPMSG ;
 N PSOZZDDD S PSOZZDDD="Label printed from suspense" D EN^PSOHLSN1(RX,"SC","ZU",PSOZZDDD) K PSOZZDDD
 Q
 ;
ARECD D NOW^%DTC S CNT=0,DTTM=% F JJ=0:0 S JJ=$O(^PSRX(RX,"A",JJ)) Q:'JJ  S CNT=JJ
 S RFCNT=0 F RF=0:0 S RF=$O(^PSRX(RX,1,RF)) Q:'RF  S RFCNT=RF S:RF>5 RFCNT=RF+1
 S RXP=$P(^PS(52.5,SFN,0),"^",5)
 S CNT=CNT+1,^PSRX(RX,"A",0)="^52.3DA^"_CNT_"^"_CNT S ^PSRX(RX,"A",CNT,0)=DTTM_"^C^"_DUZ_"^"_$S($G(RXP):6,1:RFCNT)_"^"_COM K RXP
 D EN^PSOHLSN1(RX,"OD","",COM,"A")
 Q
EX Q:'$G(RXREC)  D NOW^%DTC S PSCOU=0,DTTM=% F AAA=0:0 S AAA=$O(^PSRX(RXREC,"A",AAA)) Q:'AAA  S PSCOU=AAA
 S VVV=0 F QQQ=0:0 S QQQ=$O(^PSRX(RXREC,1,QQQ)) Q:'QQQ  S VVV=QQQ S:QQQ>5 VVV=QQQ+1
 S PSOPRT=$P(^PS(52.5,SFN,0),"^",5)
 S PSOEXPI="Expired while on suspense"
 S PSCOU=PSCOU+1,^PSRX(RXREC,"A",0)="^52.3DA^"_PSCOU_"^"_PSCOU S ^PSRX(RXREC,"A",PSCOU,0)=DTTM_"^S^"_DUZ_"^"_$S($G(PSOPRT):6,1:VVV)_"^"_PSOEXPI
 D EN^PSOHLSN1(RXREC,"SC","ZE",PSOEXPI)
 K PSCOU,AAA,QQQ,VVV,PSOPRT,PSOEXPI Q
SET ; Set DEA in Suspense File
 N PSOSUDEA
 Q:'$G(X)  Q:'$D(^PSRX(X,0))
 S PSOSUDEA=$P($G(^PSRX(X,0)),"^",6) I PSOSUDEA,$D(^PSDRUG(PSOSUDEA,0)) S $P(^PS(52.5,DA,0),"^",10)=$P(^PSDRUG(PSOSUDEA,0),"^",3)
 Q
KILL Q:'$G(DA)  Q:'$D(^PS(52.5,DA,0))
 S $P(^PS(52.5,DA,0),"^",10)=""
 Q
SAS ;X-ref on Division field
 N PSOC7,PSUSPIEN S PSUSPIEN=$O(^PS(52.5,"B",DA,0)) I PSUSPIEN,$D(^PS(52.5,PSUSPIEN,0)),'$P($G(^(0)),"^",5),'$O(^PSRX(DA,1,0)) D
 .S PSOC7=$P($G(^PS(52.5,PSUSPIEN,0)),"^",7)
 .S $P(^PS(52.5,PSUSPIEN,0),"^",6)=X S:$P(^PS(52.5,PSUSPIEN,0),"^",8)&($P(^(0),"^",9))&($P(^(0),"^",11))&($P($G(^(0)),"^",7)="") ^PS(52.5,"AS",$P(^PS(52.5,PSUSPIEN,0),"^",8),$P(^(0),"^",9),X,$P(^(0),"^",11),PSUSPIEN)=""
 .S $P(^PS(52.5,PSUSPIEN,0),"^",6)=X S:$P(^PS(52.5,PSUSPIEN,0),"^",8)&($P(^(0),"^",9))&($P(^(0),"^",11))&($P($G(^(0)),"^",7)="P") ^PS(52.5,"APR",$P(^PS(52.5,PSUSPIEN,0),"^",8),$P(^(0),"^",9),X,$P(^(0),"^",11),PSUSPIEN)=""
 .K:$P(^PS(52.5,PSUSPIEN,0),"^",8)&($P(^(0),"^",9))&($P(^(0),"^",11))&($P($G(^(0)),"^",7)="P") ^PS(52.5,"AS",$P(^PS(52.5,PSUSPIEN,0),"^",8),$P(^(0),"^",9),X,$P(^(0),"^",11),PSUSPIEN)
 .I PSOC7'="" D SCMPX^PSOCMOP(PSUSPIEN,PSOC7)
 Q
KAS ;
 N PSUSPIEN,PSOC7 S PSUSPIEN=$O(^PS(52.5,"B",DA,0)) I PSUSPIEN,$D(^PS(52.5,PSUSPIEN,0)),'$P($G(^(0)),"^",5),'$O(^PSRX(DA,1,0)) D
 .K:$P(^PS(52.5,PSUSPIEN,0),"^",8)&($P(^(0),"^",9))&($P(^(0),"^",11))&($P(^(0),"^",7)="") ^PS(52.5,"AS",$P(^PS(52.5,PSUSPIEN,0),"^",8),$P(^(0),"^",9),X,$P(^(0),"^",11),PSUSPIEN)
 .K:$P(^PS(52.5,PSUSPIEN,0),"^",8)&($P(^(0),"^",9))&($P(^(0),"^",11))&($P(^(0),"^",7)="P") ^PS(52.5,"APR",$P(^PS(52.5,PSUSPIEN,0),"^",8),$P(^(0),"^",9),X,$P(^(0),"^",11),PSUSPIEN)
 .S PSOC7=$P($G(^PS(52.5,PSUSPIEN,0)),"^",7)
 .I PSOC7'="" D KCMPX^PSOCMOP(PSUSPIEN,PSOC7)
 Q
SAS1 ;Refill Division x-ref
 N PSOSPIEN,ZZZ,PSREFCNT,PSOC7 S PSOSPIEN=$O(^PS(52.5,"B",DA(1),0)) I PSOSPIEN,$D(^PS(52.5,PSOSPIEN,0)),'$P($G(^(0)),"^",5),$O(^PSRX(DA(1),1,0)) D
 .S PSOC7=$P($G(^PS(52.5,PSOSPIEN,0)),"^",7)
 .S PSREFCNT=0 F ZZZ=0:0 S ZZZ=$O(^PSRX(DA(1),1,ZZZ)) Q:'ZZZ  S PSREFCNT=PSREFCNT+1
 .I PSREFCNT=DA S $P(^PS(52.5,PSOSPIEN,0),"^",6)=X D
 ..S:$P(^PS(52.5,PSOSPIEN,0),"^",8)&($P(^(0),"^",9))&($P(^(0),"^",11))&($P($G(^(0)),"^",7)="") ^PS(52.5,"AS",$P(^PS(52.5,PSOSPIEN,0),"^",8),$P(^(0),"^",9),X,$P(^(0),"^",11),PSOSPIEN)=""
 ..S:$P(^PS(52.5,PSOSPIEN,0),"^",8)&($P(^(0),"^",9))&($P(^(0),"^",11))&($P($G(^(0)),"^",7)="P") ^PS(52.5,"APR",$P(^PS(52.5,PSOSPIEN,0),"^",8),$P(^(0),"^",9),X,$P(^(0),"^",11),PSOSPIEN)=""
 ..K:$P(^PS(52.5,PSOSPIEN,0),"^",8)&($P(^(0),"^",9))&($P(^(0),"^",11))&($P($G(^(0)),"^",7)="P") ^PS(52.5,"AS",$P(^PS(52.5,PSOSPIEN,0),"^",8),$P(^(0),"^",9),X,$P(^(0),"^",11),PSOSPIEN)
 ..I PSOC7'="" D SCMPX^PSOCMOP(PSOSPIEN,PSOC7)
 Q
KAS1 ;
 N PSOSPIEN,ZZZ,PSREFCNT,PSOC7 S PSOSPIEN=$O(^PS(52.5,"B",DA(1),0)) I PSOSPIEN,$D(^PS(52.5,PSOSPIEN,0)),'$P($G(^(0)),"^",5),$O(^PSRX(DA(1),1,0)) D
 .S PSREFCNT=0 F ZZZ=0:0 S ZZZ=$O(^PSRX(DA(1),1,ZZZ)) Q:'ZZZ  S PSREFCNT=PSREFCNT+1
 .I PSREFCNT=DA D
 ..K:$P(^PS(52.5,PSOSPIEN,0),"^",8)&($P(^(0),"^",9))&($P(^(0),"^",11))&($P(^(0),"^",7)="") ^PS(52.5,"AS",$P(^PS(52.5,PSOSPIEN,0),"^",8),$P(^(0),"^",9),X,$P(^(0),"^",11),PSOSPIEN)
 ..K:$P(^PS(52.5,PSOSPIEN,0),"^",8)&($P(^(0),"^",9))&($P(^(0),"^",11))&($P(^(0),"^",7)="P") ^PS(52.5,"APR",$P(^PS(52.5,PSOSPIEN,0),"^",8),$P(^(0),"^",9),X,$P(^(0),"^",11),PSOSPIEN)
 ..S PSOC7=$P($G(^PS(52.5,PSOSPIEN,0)),"^",7)
 ..I PSOC7'="" D KCMPX^PSOCMOP(PSOSPIEN,PSOC7)
 Q
SAS2 ;For partials
 N PSPSPIEN S PSPSPIEN=$O(^PS(52.5,"B",DA(1),0)) I PSPSPIEN,$D(^PS(52.5,PSPSPIEN,0)),$P($G(^(0)),"^",5) D
 .I DA=$P(^PS(52.5,PSPSPIEN,0),"^",5) S $P(^(0),"^",6)=X D
 ..S:$P(^PS(52.5,PSPSPIEN,0),"^",8)&($P(^(0),"^",9))&($P(^(0),"^",11))&($P($G(^(0)),"^",7)="") ^PS(52.5,"AS",$P(^PS(52.5,PSPSPIEN,0),"^",8),$P(^(0),"^",9),X,$P(^(0),"^",11),PSPSPIEN)=""
 ..S:$P(^PS(52.5,PSPSPIEN,0),"^",8)&($P(^(0),"^",9))&($P(^(0),"^",11))&($P($G(^(0)),"^",7)="P") ^PS(52.5,"APR",$P(^PS(52.5,PSPSPIEN,0),"^",8),$P(^(0),"^",9),X,$P(^(0),"^",11),PSPSPIEN)=""
 ..K:$P(^PS(52.5,PSPSPIEN,0),"^",8)&($P(^(0),"^",9))&($P(^(0),"^",11))&($P($G(^(0)),"^",7)="P") ^PS(52.5,"AS",$P(^PS(52.5,PSPSPIEN,0),"^",8),$P(^(0),"^",9),X,$P(^(0),"^",11),PSPSPIEN)
 Q
KAS2 ;
 N PSPSPIEN S PSPSPIEN=$O(^PS(52.5,"B",DA(1),0)) I PSPSPIEN,$D(^PS(52.5,PSPSPIEN,0)),$P($G(^(0)),"^",5) D
 .I DA=$P(^PS(52.5,PSPSPIEN,0),"^",5) D
 ..K:$P(^PS(52.5,PSPSPIEN,0),"^",8)&($P(^(0),"^",9))&($P(^(0),"^",11))&($P(^(0),"^",7)="") ^PS(52.5,"AS",$P(^PS(52.5,PSPSPIEN,0),"^",8),$P(^(0),"^",9),X,$P(^(0),"^",11),PSPSPIEN)
 ..K:$P(^PS(52.5,PSPSPIEN,0),"^",8)&($P(^(0),"^",9))&($P(^(0),"^",11))&($P(^(0),"^",7)="P") ^PS(52.5,"APR",$P(^PS(52.5,PSPSPIEN,0),"^",8),$P(^(0),"^",9),X,$P(^(0),"^",11),PSPSPIEN)
 Q
SDEA ;Update Suspense with DEA
 N PSSSPIEN S PSSSPIEN=$O(^PS(52.5,"B",DA,0)) Q:'$G(PSSSPIEN)
 I $D(^PS(52.5,PSSSPIEN,0)),$P($G(^("P")),"^")=0 S $P(^PS(52.5,PSSSPIEN,0),"^",10)=$P($G(^PSDRUG(+X,0)),"^",3)
 Q
SDIV N PSODINT,PSDVP,PSLOOP
 S PSODINT=+$P($G(^PS(52.5,DA,0)),"^") Q:'PSODINT
 S PSDVP=$P($G(^PS(52.5,DA,0)),"^",5) I PSDVP D  Q
 .S:$D(^PSRX(PSODINT,"P",+PSDVP,0)) $P(^(0),"^",9)=X
 S PSDVP=0 F PSLOOP=0:0 S PSLOOP=$O(^PSRX(PSODINT,1,PSLOOP)) Q:'PSLOOP  S PSDVP=PSLOOP
 I PSDVP S:$D(^PSRX(PSODINT,1,PSDVP,0)) $P(^(0),"^",9)=X Q
 S:$D(^PSRX(PSODINT,2)) $P(^(2),"^",9)=X
 Q
ZZ(RX) ; Returns VA print name, Trade Name, Generic Name
 S I50=$P(^PSRX(RX,0),U,6),ZDRUG=$P(^PSDRUG(I50,0),U)
 I $G(ZDRUG)']"" S ZDRUG="DRUG NOT ON FILE ("_I50_")" G END
 I $G(^PSRX(RX,"TN"))]"" S ZDRUG=^("TN") G END
 I $D(^PSDRUG("AQ",I50)),($D(^PSDRUG(I50,"ND"))) D
 .S Z1=$P($G(^PSDRUG(I50,"ND")),U),Z2=$P($G(^("ND")),U,3)
 .I $G(Z1),($G(Z2)) D
 ..I $T(^PSNAPIS)]"" S PSOXN=$$PROD2^PSNAPIS(Z1,Z2) S ZDRUG=$P($G(PSOXN),"^") K PSOXN Q
 ..S ZDRUG=$P($G(^PSNDF(Z1,5,Z2,2)),"^")
 .K Z1,Z2,I50
END K I50
 Q ZDRUG
