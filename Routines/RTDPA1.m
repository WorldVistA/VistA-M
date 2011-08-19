RTDPA1 ;TROY ISC/MJK,PKE-Record Label Creation ; 4/2/03 10:01am
 ;;2.0;Record Tracking;**25,31,35**;10/22/91 
 I '$D(RTAPL) D APL2^RTPSET D NEXT:$D(RTAPL) K RTAPL,RTSYS Q
 ;
NEXT S RTA=+RTAPL D ASK^RTB K RTA G Q:$D(RTESC),NEXT:Y<0 S RTE=X
 S RTDC("S")="I $P(^(0),U,4)=+RTAPL,$S('$D(RTTY):1,$P(^RT(+Y,0),U,3)=+RTTY:1,1:0)",RTSEL="S",RTSEL("A")="Select Label" D ^RTUTL2 K RTSEL
 I $D(RTY) S RTION=$S('$D(RTFR):"",1:$P(RTFR,"^",4)) F RTI=0:0 S RTI=$O(RTY(RTI)) Q:'RTI  S RT=+RTY(RTI) D REC^RTL1
 I $D(RTY) D Q G NEXT
 D ASK I '$D(RTESC) D Q G NEXT
Q K RT,RTI,RTY,RTC,RT1,RTBCIFN,RTDC,RTE,RTESC,RTION
 K RTRANEW,%YV,DIC1,DIY,DIYS,N,POP
 K Y,Y2,X,X1,DIE,DIC,DA Q
ASK S RTESC="",RTRD(1)="Yes^create a new record or volume",RTRD(2)="No^do not create any new records",RTRD("B")=2,RTRD(0)="S",RTRD("A")="Do you wish to create a new record or volume? " D SET^RTRD K RTRD I $E(X)="^" S RTESC="" Q
 I $E(X)="Y" S RTSHOW="" D TYPE1:$D(RTTY),TYPE:'$D(RTTY) K RTSHOW
 Q
 ;
TYPE K RTESC W ! S DIC="^DIC(195.2,",DIC("S")="I $P(^(0),U,3)=+RTAPL,$S('$D(^(""I"")):1,'^(""I""):1,DT'>^(""I""):1,1:0)",DIC("A")="Select NEW Record Type: ",DIC(0)="IAEMQ" D ^DIC K DIC S:X="^" RTESC="" Q:Y<0  D TYPE1^RTUTL S RTKILL=""
TYPE1 D CREATE S RTTY1=+RTTY F RTTY2=0:0 S RTTY2=$O(^DIC(195.2,RTTY1,"LINKED","B",RTTY2)) Q:'RTTY2  I $D(^DIC(195.2,RTTY2,0)),'$D(^RT("AT",RTTY2,RTE)) S Y=RTTY2 D TYPE1^RTUTL,CREATE
 S Y=RTTY1 K RTTY,RTTY1,RTTY2 D:'$D(RTKILL) TYPE1^RTUTL K RTKILL Q
 ;
CREATE ;Entry pt. with RTAPL, RTE and RTTY set
 F I=0:0 S I=$O(^RT("AA",+RTAPL,RTE,I)) Q:'I  I $D(^RT(I,0)),+$P(^(0),"^",3)=+RTTY Q
 I I Q:$D(RTBKGRD)
 I I W !!?3,*7,$P(RTAPL,"^",9)," already has a '",$P(^DIC(195.2,+RTTY,0),"^"),"' record (#",I,") Vol: ",+$P(^RT(I,0),"^",7),"." I $P(^DIC(195.2,+RTTY,0),"^",17)'="y" W !?3,"[Multiple volumes are NOT allowed for this record type.]" Q
 I I D NEW^RTT1 Q
 S RTVOL=1,RTPAR="" D SET K RTVOL,RTPAR Q
 ;
SET ;Entry pt. with RTAPL, RTE, RTTY, RTVOL, and RTPAR defined; RTDIV optional
 S X=$S($D(RTDIV):+RTDIV,1:"") I 'X S X=+$O(^DIC(195.1,+RTAPL,"INST",0)),X=$S('$O(^(X)):X,1:"")
 S RTINIT="" I $D(^DIC(195.1,"AB",+RTTY,+RTAPL,+X)),$D(^DIC(195.1,+RTAPL,"INST",+X,"TYPE",+$O(^(+X,0)),0)) S RTINIT=^(0)
 D NOW^%DTC S RTNOW=%,I=$P(^RT(0),"^",3) K %
 ;D:$D(XRTL) T0^%ZOSV ; monitor record creation et, non-inter = 'rtshow
 I '$D(RTSHOW),$D(XRTL) D T0^%ZOSV
LOCK S I=I+1 S:$L(I)=4 I=10000 L +^RT(I):1 I '$T!$D(^RT(I)) L -^RT(I) G LOCK
 S ^RT(I,0)=RTE_"^"_+^DIC(195.4,1,"SITE"),^RT("B",RTE,I)="",^(0)=$P(^RT(0),"^",1,2)_"^"_I_"^"_($P(^(0),"^",4)+1),^DISV($S($D(DUZ)'[0:DUZ,1:0),"^RT(")=I S:$P(RTE,";",2)="DPT(" ^RT(I,0)=^RT(I,0)_"^^^^^^^"_+RTE,^RT("C",+RTE,I)="" L -^RT(I)
 ;
 S (RT,DA)=I,DIE="^RT(",DR="[RT NEW RECORD]"
 D ^DIE K DQ,DE,RTINIT,RTNOW D MOVE^RTUTL1
 ;S:$D(XRT0) XRTN=$T(+0) D:$D(XRT0) T1^%ZOSV ; end et, non-inter
 I '$D(RTSHOW),$D(XRT0) S XRTN=$T(+0) D T1^%ZOSV
 W:'$D(RTBKGRD) !?3,"...'",$E($P(^DIC(195.2,+RTTY,0),"^"),1,22),?30,"   VOL: ",RTVOL,"' created (#",RT,")"
 ;
MOR I '$D(RTSHOW),'$D(RTADM) Q
 N RTERROR
MOR1 S X=$S($D(RTFR):$P(RTFR,"^",4),1:""),RTERROR=0
 I $S(X']"":1,'$D(^%ZIS(1,"B",X)):1,'$D(^%ZIS(1,+$O(^(X,0)),0)):1,1:0) D  Q:POP  I RTERROR G MOR1
 . S %ZIS("A")="Select Barcode Printer: ",%ZIS="QN" D ^%ZIS K %ZIS,IO("Q") Q:POP
 . S X=ION
 . S RTA=$O(^%ZIS(1,"B",ION,0)) I ^%ZIS(1,RTA,"TYPE")="VTRM" D ER^RTL1 S RTERROR=1
 S RTION=X D REC^RTL1 K RTION Q
 Q
TRAN ;creat record transfered in
 S RTRANEW="",RTA=+RTAPL D ASK^RTB K RTA G Q:$D(RTESC),TRAN:Y<0 S RTE=X
 D ASK I '$D(RTESC) D Q G TRAN
