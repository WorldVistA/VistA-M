PSOCAN3 ;BIR/RTR/SAB - auto dc rxs due to death ;2/05/97 2:59pm
 ;;7.0;OUTPATIENT PHARMACY;**15,24,27,32,36,94,88,117,131,146,139,132,223,235,148,249,225,324,251,375,379**;DEC 1997;Build 28
 ;External reference to File #55 supported by DBIA 2228
 ;External references to L, UL, PSOL, and PSOUL^PSSLOCK supported by DBIA 2789
 Q
APSOD(PSODFN) ;called from file #2 date of death xref 'APOSD'
 N D,DA,DB,DC,DE,DG,DH,DI,DIC,DIE,DIG,DIH,DIK,DIR,DIQ,DIU,DIV,DIW,DK,DL,DM,DP,DQ,DU,DV,DW,DR
 S PSODEATH=1 D CAN K PSODEATH
 Q
CAN ;discontinued rxs due to death
 I $G(PSODFN),$D(^PS(52.91,PSODFN,0)) D
 .I '$P($G(^PS(52.91,PSODFN,0)),"^",3)!($P($G(^(0)),"^",3)>DT) S $P(^PS(52.91,PSODFN,0),"^",3)=DT,$P(^PS(52.91,PSODFN,0),"^",4)=5,^PS(52.91,"AX",DT,PSODFN)="" D SET^PSOTPCAN(PSODFN)
 F PSORXJ=0:0 S PSORXJ=$O(^PS(55,PSODFN,"P",PSORXJ)) Q:'PSORXJ  I $D(^(PSORXJ,0)) S PSORX=^(0) S STA=$S($P($G(^PSRX(PSORX,"STA")),"^")<11:1,$P($G(^("STA")),"^")=16:1,1:0) D:STA
 .I $D(^PSRX(PSORX,0)),$P($G(^PSRX(PSORX,"STA")),"^")="" D SETC
 .D REVERSE^PSOBPSU1(PSORX,,"DC",7)
 .I $D(^PSRX(PSORX,0)),$P($G(^PSRX(PSORX,2)),"^",6)'<DT S PSO0=^(0),PSO2=$G(^(2)) D
 ..S ^PSRX(PSORX,"DDSTA")="52;"_$P(^PSRX(PSORX,"STA"),"^")
 ..;remove from hold
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
 ..;activity record
 ..S (COM,ACOM)=$S($G(PSODEATH):"Date of Death Entered by MAS",1:"Discontinued by Pharmacy")_"."
 ..S ACNT=0 F SUB=0:0 S SUB=$O(^PSRX(PSORX,"A",SUB)) Q:'SUB  S ACNT=SUB
 ..S RFCNT=0 F RF=0:0 S RF=$O(^PSRX(PSORX,1,RF)) Q:'RF  S RFCNT=RF
 ..D NOW^%DTC S ACNT=ACNT+1,^PSRX(PSORX,"A",0)="^52.3DA^"_ACNT_"^"_ACNT
 ..S ^PSRX(PSORX,"A",ACNT,0)=%_"^"_"C"_"^^"_RFCNT_"^"_"Auto Discontinued Due to Death. "_ACOM
 ..;check for label/release/pending release
 ..D FIL
 ..S STAT="OD",PHARMST="" D EN^PSOHLSN1(PSORX,STAT,PHARMST,COM,"A") K COMM,PHARMST,STAT
 ;dc pending orders
 F PDA=0:0 S PDA=$O(^PS(52.41,"P",PSODFN,PDA)) Q:'PDA  I $P(^PS(52.41,PDA,0),"^",3)'="DC"&($P(^(0),"^",3)'="DE") D
 .I $G(PSODEATH) D
 ..S ^PS(52.41,PDA,"DDSTA")=$P(^PS(52.41,PDA,0),"^",3)_";"_+$P($G(^PS(52.41,PDA,"INI")),"^"),^PS(52.41,"APSOD",PSODFN,PDA)=""
 ..S $P(^PS(52.41,PDA,4),"^")="Date of Death Entered by MAS."
 .S $P(^PS(52.41,PDA,0),"^",3)="DC"
 .K ^PS(52.41,"AOR",PSODFN,+$P($G(^PS(52.41,PDA,"INI")),"^"),PDA)
 .S COM=$S($G(PSODEATH):"Date of Death Entered by MAS.",1:""),PL=$P(^PS(52.41,PDA,0),"^"),$P(^(0),"^",3)="DC"
 .D EN^PSOHLSN(PL,"OC",COM,"A") K COM,PL
 ;dc non-va meds
 D APSOD^PSONVNEW
KILL K %,%H,%T,ACNT,DA,PDA,DIRUT,DTOUT,PSO,PSO0,PSO2,PSOD,PSOD0,PSODFN,PSODL,PSORX,PSORXJ,PSOSD,RF,RFCNT,SUB,TM,TSKDT,X,X1,X2,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 D KVAR^VADPT S:$D(ZTQUEUED) ZTREQ="@"
 Q
CAN1 Q:$G(DODR)
 S PSOMGDFN=$G(PSODFN) ; SAVE IN CASE CANCELING RX THAT WAS MERGED TO ANOTHER DFN
 I $G(^PSRX(DA,"H"))]"" D HLD^PSOCAN2
 D REVERSE^PSOBPSU1(DA,,"DC",7)
 S PSCANVAR=0,RXDA=DA,DA=$O(^PS(52.5,"B",DA,0)) I DA,'$G(^PS(52.5,DA,"P")) S PSCANVAR=1 D
 .S SUSD=$P($G(^PS(52.5,DA,0)),"^",2)
 .S:+$G(^PS(52.5,DA,"P"))'=1 ACOM=$S(REA="C":"Discontinued",1:"Reinstated")_" while suspended. "_$G(COM)
 .S DIK="^PS(52.5," D ^DIK K DIK S DA=RXDA,RXREF=0,PSODFN=+$P(^PSRX(DA,0),"^",2)
 .D AREC^PSOCAN1 S DA=RXDA I $O(^PSRX(DA,1,0)) D REF^PSOCAN2
 I $G(REA)="C" S DA=$O(^PS(52.5,"B",RXDA,0)) I DA S DIK="^PS(52.5," D ^DIK K DIK
 I 'PSCANVAR S:$D(SPCANC) ACOM=$S(REA="C":"Discontinued",1:"Reinstated")_" during Rx cancel.  "
ADD S DA=RXDA,RXREF=0,PSODFN=+$P(^PSRX(DA,0),"^",2) S:$G(PSOOPT)=3 REA="L"
 D:'$G(PSCANVAR) AREC^PSOCAN1 S:REA="L" REA="C"
 S:REA'="C" $P(^PSRX(DA,"STA"),"^")=0,$P(^(7),"^")=""
 N PSOTPCNZ S PSOTPCNZ=0 I $P(^PSRX(DA,"STA"),"^")'=12 S PSOTPCNZ=1
 S:REA="C"&($P(^PSRX(DA,"STA"),"^")<12)!($P(^("STA"),"^")=16) $P(^PSRX(DA,"STA"),"^")=12 I $P($G(^PSRX(DA,"STA")),"^")=12,$G(PSOTPCNZ) D CAN^PSOTPCAN(DA)
 K PSOTPCNZ
 I REA="R" D
 .I $P(^PSRX(DA,3),"^",8) S $P(^PSRX(DA,3),"^",2)=$P(^PSRX(DA,3),"^",8),$P(^(3),"^",8)=""
 .S $P(^PSRX(DA,3),"^")=$S($P(^PSRX(DA,3),"^",10):$P(^(3),"^",10),$G(PSOCANHD):PSOCANHD,$P(^(3),"^",5):$P(^(3),"^",5),1:$P(^(3),"^")),$P(^(3),"^",5)="",$P(^(3),"^",10)=""
 I REA="C" D
 .S $P(^PSRX(DA,3),"^",10)=$P(^PSRX(DA,3),"^")
 .S:'$P(^PSRX(DA,3),"^",5) $P(^PSRX(DA,3),"^",5)=DT
 .I $O(^PS(52.41,"ARF",DA,0)),'$O(^PS(52.41,"APSOD",PSODFN,0)) S HLDDA=DA,DA=$O(^PS(52.41,"ARF",DA,0)),DIK="^PS(52.41," D ^DIK S DA=HLDDA K HLDDA
 .;check for label/release/pending release
 .I $G(PSOOPT)'=3 D FILX
 S PSONOOR=$S($D(PSONOOR):PSONOOR,1:"D"),STAT=$S(REA="C":"OD",1:"SC"),PHARMST=$S(REA="C":"",1:"CM")
 S COM=$S(REA="C":$S($G(PSOOPT)=3&('$G(DUP)):"Renewed",1:"Discontinued")_" by Pharmacy",1:"Reinstated by Pharmacy")
 D EN^PSOHLSN1(DA,STAT,PHARMST,$S(COM["Discontinued"&($D(INCOM)):INCOM,1:COM),$S($G(PSOOPT)=3&('$G(DUP)):"",1:PSONOOR)) K COM,STAT,PHARMST,PSCANVAR
 I REA="C" D
 .I $G(^PS(52.4,DA,0))]"" S PSCDA=DA,DIK="^PS(52.4," D ^DIK S DA=PSCDA K DIK,PSCDA
 I $G(PSOMGDFN)'="" S PSODFN=PSOMGDFN K PSOMGDFN
 S PSVC=$P(^PSRX(DA,0),"^",16)
 Q:(REA="C")!($P(^PSRX(DA,2),"^",10)]"")
 Q:$D(^XUSEC("PSORPH",DUZ))!('$P(PSOPAR,"^",2))
 S PSRXIN=DA,DIC="^PS(52.4,",DLAYGO=52.4,(X,DINUM)=PSRXIN,DIC(0)="ML"
 S DIC("DR")="1////"_$G(PSODFN)_";2////"_DUZ_";4////"_DT
 K DD,DO D FILE^DICN K DD,DO,DIC,DLAYGO,DINUM
 K DA,DIK S DA=PSRXIN K PSRXIN S $P(^PSRX(DA,"STA"),"^")=1 D NVER^PSOCAN2
 W !,"Rx # "_$P(^PSRX(DA,0),"^")_" is still non-verified!"
 Q
OERR I '$D(^XUSEC("PSORPH",DUZ)),'$P($G(PSOPAR),"^",2) S VALMSG="Invalid Action Selection!",VALMBCK="" Q
 S PSOPLCK=$$L^PSSLOCK(PSODFN,0) I '$G(PSOPLCK) D LOCK^PSOORCPY S VALMSG=$S($P($G(PSOPLCK),"^",2)'="":$P($G(PSOPLCK),"^",2)_" is working on this patient.",1:"Another person is entering orders for this patient.") K PSOPLCK S VALMBCK="" Q
 K PSOPLCK S PSOCANRD=+$P($G(^PSRX($P(PSOLST(ORN),"^",2),0)),"^",4),PSOCANRA=1
 I $P(^PSRX($P(PSOLST(ORN),"^",2),"STA"),"^"),$P(^("STA"),"^")=1!($P(^("STA"),"^")=4) S:$G(SPEED) PSONOORS=$G(PSONOOR) D DEL^PSOCAN4 S:$G(PSONOORS)'="" PSONOOR=$G(PSONOORS) K PSONOORS D KCAN D ULP Q
 D PSOL^PSSLOCK($P(PSOLST(ORN),"^",2)) I '$G(PSOMSG) S VALMSG=$S($P($G(PSOMSG),"^",2)'="":$P($G(PSOMSG),"^",2),1:"Another person is editing this order."),VALMBCK="" K PSOMSG D KCAN D ULP Q
 I '+^PSRX($P(PSOLST(ORN),"^",2),"OR1"),$P(^("STA"),"^")=12 S VALMSG="Rx Cannot be Reinstated.  No Orderable Item." D KCAN D ULP D PSOUL^PSSLOCK($P(PSOLST(ORN),"^",2)) Q
 I $P($G(^PSRX($P(PSOLST(ORN),"^",2),"STA")),"^")=12,$P($G(^("PKI")),"^") S VALMSG="Cannot be Reinstated - Digitally Signed" D KCAN D ULP D PSOUL^PSSLOCK($P(PSOLST(ORN),"^",2)) Q
 I $P($G(^PSRX($P(PSOLST(ORN),"^",2),"STA")),"^")=12 S PSOCANRZ=1
 D HLDHDR^PSOLMUTL S X=$P(^PSRX($P(PSOLST(ORN),"^",2),0),"^"),PS=$S($P(^PSRX($P(PSOLST(ORN),"^",2),"STA"),"^")=12:"Reinstate: ",1:"Discontinue: ")
 S POERR=1,DFNHLD=PSODFN,DA=$P(PSOLST(ORN),"^",2) N PSOREINS S PSOREINS=1
 I $P(^PSRX(DA,3),"^",5) S PSOCANHD=$P(^PSRX(DA,3),"^",5)
 D LMNO I $G(PSOQUIT) D ULP,KCAN S VALMBCK="R" Q
 D:$P($G(^PSRX($P(PSOLST(ORN),"^",2),"STA")),"^")=12 RMP
 D PSOUL^PSSLOCK($P(PSOLST(ORN),"^",2))
 K POERR,PSCAN,PSI,PSL S PSODFN=DFNHLD K DFNHLD D ULP
 D KCAN
 Q
ULP D UL^PSSLOCK(+$G(PSODFN))
 Q
 ;
LMNO ; Calls LMNO^PSOCAN
 N PSODFN,PSORX,RXN,RX0
 S PSPOP=0,RXNUM=X S PSODFN=+$P(^PSRX(DA,0),"^",2) D LMNO^PSOCAN
 Q
 ;
KCAN ;
 K PSOCANRA,PSOCANRC,PSOCANRD,PSOCANRN,PSOCANRP,PSOCANRZ,PSOMSG,PSOCANHD,PSOQUIT
 Q
 ;
KCAN1 ;
 K PSOCANRC,PSOCANRD,PSOCANRN,PSOCANRP,PSOCANRZ
 Q
 ;
RMP D RMP^PSOCAN3N
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
 S $P(^PSRX(PSORX,"STA"),"^")=12,$P(^PSRX(PSORX,3),"^",5)=DT,$P(^PSRX(PSORX,3),"^",10)=$P(^PSRX(PSORX,3),"^") D CAN^PSOTPCAN(PSORX)
 D CHKCMOP^PSOUTL(PSORX,"D")
 Q
