PSOHLDI1 ;BIR/PWC,SAB - Automated Dispense Completion HL7 v.2.4 cont. ; 5/29/09 3:28pm
 ;;7.0;OUTPATIENT PHARMACY;**259,268,330**;DEC 1997;Build 5
 ;Reference to ^PSD(58.8 supported by DBIA 1036
 ;Reference to ^XTMP("PSA" supported by DBIA 1036
 ;This routine is called by PSOHLDIS
 ;
 ;*259 create routine to hold DRGACCT, psohldis exceeded 10k, also
 ;     add MAIL tag for Email Alert to mail group.
 ;
 Q
 ;
BINGREL ;displays to bingo board
 N NAM,NAME,RXO,SSN S ADA="",BRXP=RXID
 F XX=0:0 S XX=$O(^PS(52.11,"B",BNAM,XX)) Q:'XX  D
 .F BRX=0:0 S BRX=$O(^PS(52.11,XX,2,"B",BRX)) Q:'BRX  I BRX=BRXP S (DA,ODA)=XX
 Q:'$D(DA)
 I $P($G(^PS(52.11,DA,0)),"^",7)]"" Q
 I $P($P($G(^PS(52.11,DA,0)),"^",5),".")'=DT S DIK="^PS(52.11," D ^DIK K DIK Q
 N TM,TM1 D NOW^%DTC S TM=$E(%,1,12),TM1=$P(TM,".",2)
 S NM=$P(^DPT($P(^PS(52.11,DA,0),"^"),0),"^"),DR="6////"_$E(TM1_"0000",1,4)_";8////"_NM_"",DIE="^PS(52.11,"
 L +^PS(52.11,DA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) E  Q
 D ^DIE L -^PS(52.11,DA) I $G(X)="" S DIK="^PS(52.11," D ^DIK K DIK Q
 S RX0=^PS(52.11,DA,0),JOES=$P(RX0,"^",4),TICK=+$P($G(RX0),"^",2),GRP=$P($G(^PS(59.3,$P($G(^PS(52.11,DA,0)),"^",3),0)),"^",2)
 I GRP="T",'$G(TICK) S DIK="^PS(52.11," D ^DIK K DIK
 Q:'$G(DA)
 S PSZ=0 I '$D(^PS(59.2,DT,0)) K DD,DIC,DO,DA S X=DT,DIC="^PS(59.2,",DIC(0)="",DINUM=X D FILE^DICN S PSZ=1 Q:Y'>0 
 I PSZ=1 S DA(1)=+Y,DIC=DIC_DA(1)_",1,",(DINUM,X)=JOES,DIC(0)="",DIC("P")=$P(^DD(59.2,1,0),"^",2) K DD,DO D FILE^DICN K DIC,DA Q:Y'>0
 I PSZ=0 K DD,DIC,DO,DA S DA(1)=DT,(DINUM,X)=JOES,DIC="^PS(59.2,"_DT_",1,",DIC(0)="LZ" D FILE^DICN K DIC,DA,DO
 S DA=ODA D STATS1^PSOBRPRT,WTIME^PSOBING1
 Q
 ;
DRGACCT(RXP,PSOSITE) ;update Drug Accountability Package PSO*209,*330
 S RXP=+$G(RXP) Q:'RXP
 S PSOSITE=+$G(PSOSITE) Q:'PSOSITE    ; PSO*7*330
 N PSA,DIC,DA,DR,X,Y,DIQ,PSODA,QDRUG,QTY,JOB192
 S (JOB192,PSODA)=0
 ;check for Drug Acct background job
 S X="PSA IV ALL LOCATIONS",DIC(0)="MZ",DIC=19.2 D ^DIC S JOB192=Y
 I JOB192>0,$P($G(Y(0)),U,2)>DT D
 . S PSODA=1
 . S:'$P($G(^XTMP("PSA",0)),U,2) $P(^(0),U,2)=DT
 I JOB192'>0 D             ;check old way of scheduling
 . S X="PSA IV ALL LOCATIONS",DIC(0)="MZ",DIC=19 D ^DIC
 . K DIQ,PSA S DA=+Y,DIC=19,DIQ="PSA",DR=200,DIQ(0)="IN" D EN^DIQ1
 . I $G(PSA(19,DA,200,"I"))>DT D
 . . S PSODA=1
 . . S:'$P($G(^XTMP("PSA",0)),U,2) $P(^(0),U,2)=DT
 ;drug stocked in Drug Acct Location?
 S PSODA(1)=$S($D(^PSD(58.8,+$O(^PSD(58.8,"AOP",PSOSITE,0)),1,+$P(^PSRX(RXP,0),U,6))):1,1:0)
 ;if appropriate update ^XTMP("PSA", for Drug Acct
 S QTY=$P($G(^PSRX(RXP,0)),"^",7)
 S QDRUG=+$P($G(^PSRX(RXP,0)),"^",6)
 Q:'QDRUG
 I $G(PSODA),$G(PSODA(1)),'$D(^PSRX("AR",$$NOW^XLFDT,RXP,0)) S ^XTMP("PSA",PSOSITE,QDRUG,DT)=$G(^XTMP("PSA",PSOSITE,QDRUG,DT))+QTY
 Q
 ;
MAIL ;Send mail message
 S:'$G(DUZ) DUZ=.5
 N PSOTTEXT,PSOIEN,PSOKEYN,XMY,XMDUZ,XMSUB,XMTEXT
 S XMY("G.PSO EXTERNAL DISPENSE ALERTS")=""
 ;if no members in group, then send to PSXCMOPMGR key holders
 S PSOIEN=$O(^XMB(3.8,"B","PSO EXTERNAL DISPENSE ALERTS",0))
 I $G(FLL)'="" D
 . I FLL="P" S FLLN="Partial "_FLLN
 I '$O(^XMB(3.8,PSOIEN,1,0)) D
 . S PSOKEYN=0
 . F  S PSOKEYN=$O(^XUSEC("PSXCMOPMGR",PSOKEYN)) Q:'PSOKEYN  D
 . . S XMY(PSOKEYN)=""
 S XMDUZ="PSO EXTERNAL DISPENSE"
 S XMSUB="External Dispense - Rx Release Attempted"
 S PSOTTEXT(1)="Patient: "_NAME_"   SSN: "_PSSN
 S PSOTTEXT(2)="   Rx #: "_PSORX_"   Fill: "_FLLN
 S PSOTTEXT(3)="   Drug: "_$P(GIVECOD,"~",2)
 S PSOTTEXT(4)=""
 S PSOTTEXT(5)=ATXT
 S PSOTTEXT(6)=""
 S:ACTN]"" PSOTTEXT(7)=ACTN
 S XMTEXT="PSOTTEXT(" D ^XMD
 Q
