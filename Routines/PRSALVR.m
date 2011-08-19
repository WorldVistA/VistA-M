PRSALVR ;HISC/REL - Leave Request ;11/30/2004
 ;;4.0;PAID;**61,93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 S DFN="",SSN=$P($G(^VA(200,DUZ,1)),"^",9) I SSN'="" S DFN=$O(^PRSPC("SSN",SSN,0))
 I 'DFN W !!,*7,"Your SSN was not found in both the New Person & Employee File!" G EX
 S TLE=$P($G(^PRSPC(DFN,0)),"^",8) S:TLE="" TLE="   " S TLI=+$O(^PRST(455.5,"B",TLE,0))
 D ^PRSAENT S ZENT="",Z1="30 31 31 31 32 33 28 35 35 34 30",Z2="AL SL CB AD NL WP CU AA DL ML RL"
 F K=1:1:11 I $E(ENT,$P(Z1," ",K)) S ZENT=ZENT_$P(Z2," ",K)_" "
 I ZENT="" W !!?5,"You are not entitled to any type of Leave." G EX
 L +^PRST(458.1,0) K DDSFILE,DA,DR
N1 S DA=$P(^PRST(458.1,0),"^",3)+1 I $D(^PRST(458.1,DA)) S $P(^PRST(458.1,0),"^",3)=DA G N1
 S $P(^PRST(458.1,0),"^",3)=DA,$P(^(0),"^",4)=$P(^(0),"^",4)+1 L -^PRST(458.1,0)
 S ^PRST(458.1,DA,0)=DA_"^"_DFN,^PRST(458.1,"B",DA,DA)="",^PRST(458.1,"C",DFN,DA)=""
 S ZOLD=^PRST(458.1,DA,0) D ED
 K DIR S DIR("A")="Do you wish to enter another Leave Request? ",DIR(0)="YA",DIR("B")="No" W ! D ^DIR G PRSALVR:Y,EX Q
ED ; Edit Leave Request
 ;
 N PPLCK,PPLCKE,SKIP
 ; if request is approved and employee has any part-time physician memos
 ; then lock appropriate pay periods
 S SKIP=0
 I $P(ZOLD,U,12),$$PTP^PRSPUT3($P(ZOLD,U,2)) D
 . ; lock applicable time cards
 . D LCK^PRSPAPU($P(ZOLD,U,2),$$FMADD^XLFDT($P(ZOLD,U,3),-1),$P(ZOLD,U,5),.PPLCK,.PPLCKE)
 . ; if problem locking time cards
 . I $D(PPLCKE) D
 . . S SKIP=1 ; set flag to skip edit of leave
 . . D TCULCK^PRSPAPU($P(ZOLD,U,2),.PPLCK) ; unlock any locked PP
 . . D RLCKE^PRSPAPU(.PPLCKE) ; report problems
 Q:SKIP  ; don't proceed with edit
 ;
 S $P(^PRST(458.1,DA,0),"^",16)=$S(ENT["D":"D",1:"H") S X="IOUON;IOUOFF" D ENDR^%ZISS
 S Y15=IOUON_"Number of "_$S(ENT["D":"Days",1:"Hours")_IOUOFF_":"
 S DDSFILE=458.1,DR="[PRSA LV REQ]" D ^DDS K DS
 I '$P(^PRST(458.1,DA,0),"^",3) S DIK="^PRST(458.1," D ^DIK K DIK Q
 I ZOLD=^PRST(458.1,DA,0) Q
 ;
 ; if timecards were locked (PTP), unpost the leave and remove the locks
 I $D(PPLCK) D
 . D ULR^PRSPLVA(ZOLD)
 . D TCULCK^PRSPAPU($P(ZOLD,U,2),.PPLCK)
 ;
 D NOW^%DTC S $P(^PRST(458.1,DA,0),"^",9,11)="R^"_DUZ_"^"_%,^PRST(458.1,"AR",DFN,DA)=""
 I $P(ZOLD,"^",12) S $P(^PRST(458.1,DA,0),"^",12,14)="^^" K ^(1)
 S Z1=$P($G(^PRST(458.1,DA,0)),"^",7) I "AL SL CB AD"[Z1 S PRT=0 D BAL^PRSALVS I BAL<0 D OK
 D CHK,UPD^PRSASAL Q
OK ; Negative Balance Message
 W !!,"WARNING: Your Leave Balance MAY go below zero!"
 R !!,"Press RETURN to Continue.",X:DTIME Q
VAL ; Validate request
 Q:'$D(Z1)  I $P(Z1,"^",1)>$P(Z1,"^",3) S STR="Start date cannot be after the ending date." G V1
 S X1=$P(Z1,"^",3),X2=$P(Z1,"^",1) D ^%DTC I X>40 S STR="Period of leave cannot exceed 40 days." G V1
 Q:$P(Z1,"^",1)<$P(Z1,"^",3)  S X=$P(Z1,"^",2)_"^"_$P(Z1,"^",4) D CNV^PRSATIM
 S Z2=$P(Y,"^",1),Z4=$P(Y,"^",2)
 I Z2'<Z4 S STR="Start time must be less than ending time." G V1
 ;The following line of code intentally commented out as unnecessary
 ;as well as causing an erroneous error message. Refer PRS*4*61
 ;I "AL SL"[$P(Z1,"^",7) S PRT=0 D BAL^PRSALVS I BAL<0 S STR="WARNING: Your leave balance MAY go below zero." D HLP^DDSUTL(.STR)
 Q
V1 S DDSERROR=1 D HLP^DDSUTL(.STR) Q
CHK ; Check if start date already posted
 S Z1=$P(^PRST(458.1,DA,0),"^",3)
 S Y=$G(^PRST(458,"AD",Z1)),PPI=$P(Y,"^",1),DAY=$P(Y,"^",2) I PPI="" Q
 Q:'$D(^PRST(458,PPI,"E",DFN,"D",DAY,10))  S Y=$G(^(2)) Q:Y[$P(^PRST(458.1,DA,0),"^",7)
 S XMB="PRSA LV TK" F XMKK=0:0 S XMKK=$O(^PRST(455.5,TLI,"T",XMKK)) Q:XMKK<1  S XMY(XMKK)=""
 S XMB(1)=$P($G(^PRSPC(DFN,0)),"^",1)
 S X=$P($G(^PRST(458.1,DA,0)),"^",3) D DTP^PRSAPPU S XMB(3)=Y,XMB(2)=""
 S LVT=";"_$P(^DD(458.1,6,0),"^",3)
 S X=$P($G(^PRST(458.1,DA,0)),"^",7),%=$F(LVT,";"_X_":") I %>0 S XMB(2)=$P($E(LVT,%,999),";",1)
 D ^XMB K XMB,XMY,XMM,XMDT,XMKK Q
EX G KILL^XUSCLEAN
