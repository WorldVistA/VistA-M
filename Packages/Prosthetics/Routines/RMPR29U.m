RMPR29U ;PHX/JLT-2529-3 UTILITIES[ 11/28/94  3:55 PM ]
 ;;3.0;PROSTHETICS;**2,41,50,62**;Feb 09, 1996
 ;
 ; ODJ - patch 50 - 7/17/00 nois STL-0400-42007
 ;                  In POST subroutine ensure that if a 660 pointer
 ;                  in a 664.2 record points to non-existant 660 the
 ;                  routine does not crash.
 ; RVD patch #62  - PCE and suspense link.
 ;
ST ;DISPLAY ASSIGNED WORK ORDER
 S DIE="^RMPR(664.1,",DA=RMPRDA,DR="27////^S X=DUZ;15////^S X=PEMP;16///A" D ^DIE
 ;W !!,?5,"Work Order Number: ",RMPRWO,!,?5,"Assigned to: ",$P($P(^VA(200,+PEMP,0),U,1),",",2)_" "_$P($P(^VA(200,+PEMP,0),U,1),",",1) Q
 Q
INVD(INVP,IVIT) ;GET DEFAULTS FOR INVENTORY ITEM
 ;SEE DBA #698 ; CUSTODIAL PACKAGE  - IFCAP ;CUSTODIAL ISC - WASHINGTON
 N DIC,Y,DA S DIC="^PRCP(445,"_INVP_",1,",DA(1)=INVP,DIC(0)="MNZ",X=IVIT D ^DIC I +Y'>0 S (VEN,COST)="" Q
 S VEN=$S($G(VEN)="":$P(Y(0),U,12),1:VEN),COST=$P(Y(0),U,15) I +VEN,$D(^PRC(440,+VEN,0)) S VEN=$P(^(0),U,1)
 Q
ITV(VEN,ITM) ;GET DEFAULT VENDOR FOR ITEM
 ;SEE DBA #801 ; CUSTODIAL PACKAGE - IFCAP  ; CUSTODIAL ISC - WASHINGTON
 N DIC,Y S VEN=$S($P(^PRC(441,ITM,0),U,8):$P(^(0),U,8),1:$O(^PRC(441,ITM,2,"B",0))) I 'VEN S VDR="" Q
 S DIC="^PRC(441,"_ITM_",2,",DA(1)=ITM,DIC(0)="MNZ",X=VEN D ^DIC I +Y>0 S VDR=Y(0,0)
 E  S VDR=""
 Q
ITC(VEN,ITM) ;DEFAULT COST FOR ITEM
 ;SEE DBA # 801 ; CUSTODIAL PACKAGE - IFCAP ; CUSTODIAL ISC - WASHINGTON
 N DIC,Y I VEN="" S VEN=$S($P(^PRC(441,ITM,0),U,8):$P(^(0),U,8),1:$O(^PRC(441,ITM,2,"B",0))) I 'VEN S COST="" Q
 S DIC="^PRC(441,"_ITM_",2,",DA(1)=ITM,DIC(0)="MNZ",X=VEN D ^DIC I +Y>0 S COST=$P(Y(0),U,2)
 E  S COST=""
 Q
POST ;POST JOB SECTION TO 2319
 S (TCST,THRS,TLCST,CST,HRS,LCST,RHR,RLM)=0,DA660=+$P(^RMPR(664.2,RMPRWO,0),U,2),RWK=$P(^(0),U),RMPRSH=$S($P(^(0),U,7):$P(^(0),U,7),1:$P(^(0),U,6)),RMPRCD=$P(^RMPR(664.2,RMPRWO,0),U,10)
 ;added by #62
 I $G(DA660),'$D(^RMPR(660,DA660,10)) D
 .S (RMPCAMIS,RMPRDFN)=""
 .S RMPCAMIS=$G(^RMPR(660,DA660,"AMS"))
 .S:$D(^RMPR(660,DA660,0)) RMPRDFN=$P(^RMPR(660,DA660,0),U,2)
 .I RMPCAMIS,RMPRDFN S ^TMP($J,"RMPRPCE",660,DA660)=RMPCAMIS_"^"_RMPRDFN
 F RI=0:0 S RI=$O(^RMPR(664.2,RMPRWO,1,RI)) Q:RI'>0  I $D(^(RI,0)) S CST=$P(^(0),U,3),QTY=$P(^(0),U,2) S CST=$J(CST*QTY,0,2),TCST=TCST+CST
 F RI=0:0 S RI=$O(^RMPR(664.3,"C",DA660,RI)) Q:RI'>0  I $D(^RMPR(664.3,RI,0)) F RT=0:0 S RT=$O(^RMPR(664.3,RI,1,RT)) Q:RT'>0  D
 .S HRS=$P(^RMPR(664.3,RI,1,RT,0),U,2),LCST=$P(^(0),U,3),LCST=$J(HRS*LCST,0,2),TLCST=TLCST+LCST,RHR=RHR+$P(HRS,"."),RLM=RLM+$P(HRS,".",2)
 .S THRS=THRS+HRS
 ;
 ; p50 - if 660 record does not exist permit LB section to be created
 ;       in case need to refer to costs of work done on canceled requests
 S $P(^RMPR(660,DA660,"LB"),U,6)=THRS,$P(^("LB"),U,7)=$J(TLCST,0,2),$P(^("LB"),U,8)=$J(TCST+RMPRSH,0,2),$P(^("LB"),U,9)=$J(TLCST+TCST+RMPRSH,0,2)
 S $P(^RMPR(660,DA660,"LB"),U,11)=RMPRCD
 ;
 ; p50 - only update 660 0rec if already exists (ie not canceled)
 I DA660,$D(^RMPR(660,DA660,0)) D
 . S RDEL=$P(^RMPR(660,DA660,0),U,12),$P(^(0),U,12)=RMPRCD
 . K:RDEL ^RMPR(660,"CT",RDEL,DA660),^RMPR(660,"CD",RDEL,DA660)
 . I RMPRCD S DA=DA660,DIE="^RMPR(660,",DR="83///@" D ^DIE
 . S DA=DA660,DIK="^RMPR(660," D IX^DIK
 . Q
 S RMPRDA=$O(^RMPR(664.1,"C",RWK,0)),DA=$O(^RMPR(664.1,"AC",RMPRDA,DA660,0)) I +DA S $P(^RMPR(664.1,RMPRDA,2,DA,0),U,4)=$J(TCST+RMPRSH,0,2),$P(^(0),U,11)=$J(TLCST+TCST+RMPRSH,0,2)
 Q
EN4(RDA) ;CREATE JOB RECORD
 S RMPR("REF")=$P(^RMPR(664.1,RDA,0),U,4),$P(^(0),U,20)="",RN=+$P(^(0),U,24)
 K DIC,Y F RT=0:0 S RT=$O(^RMPR(664.1,RDA,2,RT)) Q:RT'>0  I $D(^(RT,0)) S DA660=$P(^(0),U,5) I +DA660,'$D(^RMPR(664.2,"C",DA660)) D  S $P(^RMPR(664.1,RDA,0),U,24)=RN
 .K DA,D0,DD,DO S DIC="^RMPR(664.2,",DIC(0)="LZ",X=$P(^RMPR(664.1,RDA,0),U,13) D FILE^DICN Q:+Y'>0
 .S RN=RN+1,$P(^RMPR(664.2,+Y,0),U,2)=DA660,$P(^(0),U,3)=RMPR("STA"),$P(^(0),U,4)=RN,$P(^(0),U,8)=RMPR("REF") S DA=+Y,DIK="^RMPR(664.2," D IX1^DIK I $D(^RMPR(660,DA660,0)) D
 ..S $P(^RMPR(660,DA660,"LB"),U,5)=DA,$P(^RMPR(664.1,RDA,2,RT,0),U,6)=DA,DA=DA660,DIE="^RMPR(660,",DR="83///^S X=$P(^RMPR(664.1,RDA,0),U,1)" D ^DIE
 Q
CR(SCR) ;CREATE WORK ORDER
 N DIC,Y,DIR S RMPRWO=1 D FQ^RMPRDT Q:'$D(RMPRFY)!('$D(RMPRQTR))  S:'$D(RMPRTMP) RMPRWO=$$STAN^RMPR31U(RMPR("STA"))_"-"_RMPRFY_"-"_RMPRQTR I $D(RMPRTMP) D
 .S RMPRWO=$$STAN^RMPR31U($P(^RMPR(664.1,RMPRDA,0),U,15))_"T-"_RMPRFY_"-"_RMPRQTR
 I '$D(^RMPR(669.1,"B",RMPRWO)) S DIC="^RMPR(669.1,",DLAYGO=669.1,DIC(0)="LZ",X=RMPRWO D FILE^DICN K DLAYGO
 S RDA=$O(^RMPR(669.1,"B",RMPRWO,0)) Q:'RDA
 L +^RMPR(669.1,RDA,0):1 I '$T W !!,$C(7),"Someone is editing this record!" G EXIT
 S RN=$P(^RMPR(669.1,RDA,0),U,2)+1 F I=1:1:4-$L(RN) S RN="0"_RN
 S RMPRWO=RMPRWO_"-"_SCR_"-"_RN
 S $P(^RMPR(669.1,RDA,0),U,2)=RN L -^RMPR(669.1,RDA,0) Q
ITA(RY) ;CHK FOR AMIS CODE PASS Y AND RMPRDA
 Q:'$D(RMPRDA)  Q:$P($G(^RMPR(664.1,RMPRDA,0)),U,15)'=RMPR("STA")  N Y,X,DIC,DR,DIE,DA,DIRUT,DTOUT,SCR K FLA
 S SCR=$P(^RMPR(664.1,RMPRDA,0),U,11) S DR=$S(SCR'="R":"1;2;3;4",1:"1;2;5;6") I SCR="W" S DR="1;2;4"
 I SCR'="R",'$P(^RMPR(661,RY,0),U,5),('$P(^(0),U,6)) W !!,$C(7),"Orthotic Lab AMIS Codes have not been entered for this item" S FLA=1
 I SCR="R",'$P(^RMPR(661,RY,0),U,7),('$P(^(0),U,8)) W !!,$C(7),?5,"Restoration AMIS Codes have not been entered for this item" S FLA=1
 I $D(FLA) S DIR(0)="Y",DIR("A")="Would You like to enter them now",DIR("B")="Y" D ^DIR Q:$D(DIRUT)!($D(DTOUT))!(+Y'>0)  K Y,X S DA=RY,DIE="^RMPR(661," D ^DIE
 K FLA Q
PAID(EMP) ;GET PAID LABOR HOURS
 ;CALLED BY RMPR29B
 ;VARIABLES REQUIRED: EMP - ENTRY NUMBER FOR EMPLOYEE IN FILE 200
 ;VARIABLE SET :      RMPR450 - GET HOURLY WAGE RATE.
 ;this call is no longer being used, trying to clean up!
 Q 0
 ; REWRITE ACCORDING TO SAC
AUL ;check for lab or clinic
 ;this input transform is no longer going to be supported, remove
 ;by version 4.
 ;
 ;I '$D(RMPR)!('$D(RMPRSITE)) K X Q
 ;I X'=RMPR("STA") W !!,?5,$C(7),"VAF 10-2529-3 request cannot be processed locally" K X Q
 ;I '$P($G(^RMPR(669.9,$G(RMPRSITE),0)),U,6) W !!,?5,$C(7),"You cannot process VAF 10-2529-3 work orders." K X Q
 Q
EXIT N RMPR,RMPRSITE K ^TMP($J,"RMPRPCE") D KILL^XUSCLEAN Q
CHKCPT(RDATA) ;check for cpt modifier - change of Type of Transaction.
 N RMHCPC,RMCPT,RMCI,RMC,RMCLEN,RMLPIECE,RMF,RMFPIECE,RMTYPE,RMPRA,R4DA
 S RMTYPE=$P(RDATA,U,1),RMPRA=$P(RDATA,U,2),R4DA=$P(RDATA,U,3)
 S RMHCPC=$P($G(^RMPR(664.1,RMPRA,2,R4DA,2)),U,1)
 S RMCPT=$P($G(^RMPR(664.1,RMPRA,2,R4DA,2)),U,2) Q:'$G(RMHCPC)
 I ((RMTYPE="R")!(RMTYPE="X")),(RMCPT'["RP"),($G(^RMPR(661.1,RMHCPC,4))["RP") D ADDRP
 I ((RMTYPE="I")!(RMTYPE="S")),(RMCPT["RP") D DELRP
 K RMHCPC,RMCI,RMC,RMCLEN,RMLPIECE,RMF,RMFPIECE,RMTYPE,RMPRA,R4DA Q
 ;return to (-3) ADD/EDIT option
DELRP ;logic for deleting 'RP' modifier with transaction change.
 F RMCI=1:1:8 S RMC=$P(RMCPT,",",RMCI) I RMC="RP" S $P(RMCPT,",",RMCI)="" D
 .S RMF=$F(RMCPT,",,"),RMFPIECE=$E(RMCPT,1,RMF-2)
 .S RMLPIECE=$E(RMCPT,RMF,32),RMCPT=RMFPIECE_RMLPIECE,RMCLEN=$L(RMCPT)
 .I $E(RMCPT,1)="," S RMCPT=$E(RMCPT,2,RMCLEN)
 .I $E(RMCPT,RMCLEN)="," S RMCPT=$E(RMCPT,1,RMCLEN-1)
 .S $P(^RMPR(664.1,RMPRA,2,R4DA,2),U,2)=RMCPT
 Q
 ;
ADDRP ;logic for adding 'RP' modifier with transaction change.
 S RMCPT=RMCPT_",RP" S $P(^RMPR(664.1,RMPRA,2,R4DA,2),U,2)=RMCPT
 Q
