EHMPSRXDC ; PWC/ALB - Auto DX RX's due to Death ; Feb 10, 2026@14:57:12
 ;;1.0;ELECTRONIC HEALTH MODERNIZATION;**8**;Apr 19, 2021;Build 38
 ;
 ;External reference to File #55 supported by DBIA #2228
 ;External references to L, UL, PSOL, and PSOUL^PSSLOCK supported by DBIA #2789
 ;External references to ^PS files and routines supported by DBIA #7632
 ;
 ; Made class 1 software from routine R1PSCAN3
 ; Rob Silverman wrote R1PSCAN3
 ; cloned from PSOCAN3 and modified as an API for EHRM Data Migration.
 ;Modifications are made throughout subroutine CAN and too extensive to document in line
 Q
CAN(PSORX) ;using 'discontinued rxs due to death' as API to discontinue Rx's for EHRM
 N D,DA,DB,DC,DE,DG,DH,DI,DIC,DIE,DIG,DIH,DIK,DIR,DIQ,DIU,DIV,DIW,DK,DL,DM,DP,DQ,DU,DV,DW,DR,PSODEATH,COM,ACOM,STA,SUSD
 S STA=$S($P($G(^PSRX(PSORX,"STA")),"^")<11:1,$P($G(^("STA")),"^")=16:1,1:0) D:STA
 .I $D(^PSRX(PSORX,0)),$P($G(^PSRX(PSORX,"STA")),"^")="" D SETC
 .D REVERSE^PSOBPSU1(PSORX,,"DC",7)
 .I $D(^PSRX(PSORX,0)),$P($G(^PSRX(PSORX,2)),"^",6)'<DT S PSO0=^(0),PSO2=$G(^(2)) D
 ..S ^PSRX(PSORX,"DDSTA")="52;"_$P(^PSRX(PSORX,"STA"),"^")
 ..;remove from hold <RMS 6-11-19 This code will be used if HOLD Rx's can be successfully migrated>
 ..I $G(^PSRX(PSORX,"H"))]"" D
 ...S ^PSRX(PSORX,"DDSTA")="52;"_$P(^PSRX(PSORX,"STA"),"^")_"^"_^PSRX(PSORX,"H")
 ...K:$P(^PSRX(PSORX,"H"),"^") ^PSRX("AH",$P(^PSRX(PSORX,"H"),"^"),PSORX) S ^PSRX(PSORX,"H")=""
 ...I '$P($G(^PSRX(PSORX,2)),"^",2),$P($G(^(3)),"^") S $P(^PSRX(PSORX,2),"^",2)=$P(^(3),"^")
 ...I $G(PSODEATH),$P(^PSRX(PSORX,0),"^",2) S ^PSRX("APSOD",$P(^PSRX(PSORX,0),"^",2),PSORX)=""
 ..;delete from non-verified file
 ..I $G(^PS(52.4,PSORX,0))]"" S ^PSRX(PSORX,"DDSTA")="52.4;"_$P(^PSRX(PSORX,"STA"),"^")_"^"_^PS(52.4,PSORX,0),DIK="^PS(52.4,",DA=PSORX D ^DIK K DIK
 ..I $G(PSODEATH),$P(^PSRX(PSORX,0),"^",2) S ^PSRX("APSOD",$P(^PSRX(PSORX,0),"^",2),PSORX)=""
 ..;delete from suspense
 ..D:$O(^PS(52.5,"B",PSORX,0))
 ...S DA=$O(^PS(52.5,"B",PSORX,0)) I '$G(^PS(52.5,DA,"P")),$G(PSODEATH) S ^PSRX(PSORX,"DDSTA")="52.5;5^"_^PS(52.5,DA,0),^PSRX("APSOD",$P(^PSRX(PSORX,0),"^",2),PSORX)=""
 ...I $O(^PSRX(PSORX,1,0)),'$G(PSODEATH) S DA=PSORX,SUSD=$P($G(^PS(52.5,$O(^PS(52.5,"B",PSORX,0)),0)),"^",2) D:'$G(^PS(52.5,$O(^PS(52.5,"B",PSORX,0)),"P")) REF^PSOCAN2
 ...S DA=$O(^PS(52.5,"B",PSORX,0)),DIK="^PS(52.5," D ^DIK K DIK
 ..D SETC
 ..;activity record RMS 12-3-19 comments updated for EHRM
 ..S (COM,ACOM)="Rx Discontinued by EHRM Data Migration."
 ..S ACNT=0 F SUB=0:0 S SUB=$O(^PSRX(PSORX,"A",SUB)) Q:'SUB  S ACNT=SUB
 ..S RFCNT=0 F RF=0:0 S RF=$O(^PSRX(PSORX,1,RF)) Q:'RF  S RFCNT=RF
 ..D NOW^%DTC S ACNT=ACNT+1,^PSRX(PSORX,"A",0)="^52.3DA^"_ACNT_"^"_ACNT
 ..S ^PSRX(PSORX,"A",ACNT,0)=%_"^"_"C"_"^^"_RFCNT_"^"_"Auto DC'ed: "_ACOM
 ..;check for label/release/pending release
 ..D FIL
 ..S STAT="OD",PHARMST="" D EN^PSOHLSN1(PSORX,STAT,PHARMST,COM,"A") K COMM,PHARMST,STAT
KILL K %,%H,%T,ACNT,DA,PDA,DIRUT,DTOUT,PSO,PSO0,PSO2,PSOD,PSOD0,PSODFN,PSODL,PSORX,PSORXJ,PSOSD,RF,RFCNT,SUB,TM,TSKDT,X,X1,X2,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 D KVAR^VADPT S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
FIL Q:'$G(PSORX)
 S PSOFC=PSORX G FILC
FILX Q:'$G(DA)
 S PSOFC=DA
FILC ;
 N PFC,PSOFFLAG
 I $P($G(^PSRX(PSOFC,2)),"^",13) G FILQ
 S PSOFFLAG=0 F PFC=0:0 S PFC=$O(^PSRX(PSOFC,1,PFC)) Q:'PFC!(PSOFFLAG)  I $P($G(^PSRX(PSOFC,1,PFC,0)),"^",18) S PSOFFLAG=1
 I PSOFFLAG G FILQ
 F PFC=0:0 S PFC=$O(^PSRX(PSOFC,"L",PFC)) Q:'PFC!(PSOFFLAG)  I $D(^PSRX(PSOFC,"L",PFC,0)),'$P($G(^(0)),"^",5) S PSOFFLAG=1
 I PSOFFLAG G FILQ
 S PSOFCSUS=$O(^PS(52.5,"B",PSOFC,0))
 I $G(PSOFCSUS),$P($G(^PS(52.5,PSOFCSUS,0)),"^",7)="L"!($P($G(^(0)),"^",7)="X") G FILQ
 S $P(^PSRX(PSOFC,3),"^",8)=$P($G(^PSRX(PSOFC,3)),"^",2)
 S $P(^PSRX(PSOFC,3),"^",2)=$P($G(^PSRX(PSOFC,2)),"^",2)
 I $P($G(^PSRX(PSOFC,"OR1")),"^",3) S $P(^PSRX(PSOFC,3),"^")=$P($G(^PSRX($P(^PSRX(PSOFC,"OR1"),"^",3),3)),"^")
FILQ K PSOFC,PSOFCSUS
 Q
 ;
SETC ;Called from Date of Death
 S $P(^PSRX(PSORX,"STA"),"^")=12,$P(^PSRX(PSORX,3),"^",5)=DT,$P(^PSRX(PSORX,3),"^",10)=$P(^PSRX(PSORX,3),"^") ;D CAN^PSOTPCAN(PSORX)
 D CHKCMOP^PSOUTL(PSORX,"D")
 Q
