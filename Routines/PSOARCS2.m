PSOARCS2 ;BHAM ISC/LGH,SAB - Rx archive (cont'd) ; 07/07/92
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
 S PSOACP=0 D CLOSE K:'$D(PSOACP) PSOAP K:'$D(PSOACT) PSOAT
END K PSABS,PSOAC,PSOACP,PSOACT,PSOAF,PSOAM,PSOAPAR,PSOAT,ZI,ZII,J,JJ,K,IOP,PSOACPF,X,X1,X2,PSOACPL,PSOACPM,PSPRNP,RFDATE,RFL,RM,ST,ST0,LL,KK,NM,PG,PHYS,PI,PSDIS,PSLC,PSOACRS,PSPRCNT,RFL1,PSOAPG,T,PSOAP
 K %MT,C,POP,SS,TZ,XNEW,XNM,XSS,IOUPAR,IOPAR,IOXY,%,DUSYS,DIRUT,SSN,PSRST,PSOATNM,XX,PSOAPF,IOBS,IOHG
 K %DT,%Y,D0,D1,D2,DA,DI,DIE,DIR,DLAYGO,DQ,DR,PAT,PSOACD,PSOK,RX,RX0,ZZI,IK,STOP
 D KILLARC^PSOARCCO L -^PSOARC
 Q
CLOSE I $D(PSOAT) U IO(0) S IOP=PSOAT D ^%ZIS D ^%ZISC K IOP
 I $D(PSOAP),IO(0)'=PSOAP U PSOAP W @PSOACPF U IO(0) S IOP=PSOAP D ^%ZIS D ^%ZISC K IOP
 L -^PSOARC Q
ARC ;archive info - invoked by ^PSOARC
 K DIR,DIRUT S DIR("A",1)="Are you sure you're ready to Purge your Archived Prescriptions from your"
 S DIR("A",2)="on-line prescription global?  If you do not have a current backup, exit"
 S DIR("A")="and perform the backup operation",DIR(0)="YO",DIR("B")="NO"
 D ^DIR K DIR Q:'Y!($D(DIRUT))
 K DIR,DIRUT
 I ^%ZOSF("OS")'["MSM" W !! S DIR("A")="Is Journaling Disabled on the prescription global (^PSRX)? Y/N ",DIR(0)="YO" D ^DIR K DIR Q:'Y!($D(DIRUT))
 W !!,"Deleting entries from the PRESCRIPTION file",!
 S (RX,RX1)=0 F  S RX=$O(^PSRX(RX)) Q:'RX  S PSOACD=$P(^PSRX(RX,0),"^",2),RX1=$P(^(0),"^") I $G(^PSRX(RX,"ARC"))>0 D  D MES W "."
 .Q:'$D(^PSRX(RX))
 .S PSOSUSPA=1 D EN^PSOHLSN1(RX,"Z@","","Purge order.","") S PAT=$P(^PSRX(RX,0),"^",2),DIK="^PSRX(",DA=RX D ^DIK K PSOSUSPA
 .I $D(^PS(55,PAT,0)) S DA(1)=PAT,DIK="^PS(55,"_DA(1)_",""P""," F X=0:0 S X=$O(^PS(55,PAT,"P",X)) Q:'X  I ^PS(55,PAT,"P",X,0)=RX S DA=X D ^DIK K DA,DIK
 .S DIK="^PS(52.4,",DA=RX D ^DIK K DA,DIK
 .S DA=$O(^PS(52.5,"B",RX,"")) Q:DA']""  S DIK="^PS(52.5," D ^DIK K DIK
 W $C(7),!!!,"Finished purging old prescriptions"
 W !!,"Deleting entries from the PENDING file",!
 S PDRX=0 F  S PDRX=$O(^PS(52.41,PDRX)) Q:'PDRX  D
 .S STAT=$P(^PS(52.41,PDRX,0),"^",3) I $G(STAT)="DC"!($G(STAT)="DE") D
 ..D EN^PSOHLSN($P(^PS(52.41,PDRX,0),"^"),"Z@","PURGE ORDER","""")
 ..S DIK="^PS(52.41,",DA=PDRX D ^DIK K DA,DIK,STAT W "."
 K %DT,%Y,D0,D1,D2,DA,DI,DIE,DIR,DLAYGO,DQ,DR,PAT,IK,LL,LST,PNODE,PLGTH,PDRX,PSOACD,PSOK,RX,RX1,ZZI
 Q
MES ;store archived Rx's in Pharmacy Patient file (#55)
 S LL=0,LST=""
 I '$D(^PS(55,PSOACD,"ARC",DT)) S DA=PSOACD,DIE=55,DR="101///"_DT,DR(2,55.13)="1///"_$G(RX1) D ^DIE K DIE G QMES
 F  S LL=$O(^PS(55,PSOACD,"ARC",DT,1,LL)) Q:'LL  S LST=LL
 I $G(LST),$D(^PS(55,PSOACD,"ARC",DT,1,LST,0)) S PNODE=^PS(55,PSOACD,"ARC",DT,1,LST,0) S PLGTH=$L(PNODE) I $G(PLGTH),PLGTH<220 S ^PS(55,PSOACD,"ARC",DT,1,LST,0)=PNODE_$S($E(PNODE,PLGTH)'="*":"*",1:"")_RX1 G QMES
 S DA=PSOACD,DIE=55,DR="101///"_DT,DR(2,55.13)="1///"_$G(RX1) D ^DIE K DIE
QMES Q
TAPE1 ;Invoked from ^PSOARCSV
 D PSOAT W "!" D PSOAT G:PSOAEOT TAPE1 W T(1) D PSOAT G:PSOAEOT TAPE1 W T(2) S D=+$P(T(2),"^",2),A=+$P(T(2),"^",3),DG=+$P(T(2),"^",4),GD=+$P(T(2),"^",5)
 I D>0 F TI=1:1:D D PSOAT G:PSOAEOT TAPE1 W:$D(T(2,TI)) T(2,TI)
 I A>0 F TI=1:1:A D PSOAT G:PSOAEOT TAPE1 W:$D(T(3,TI)) T(3,TI)
 I DG>0 F TI=1:1:DG D PSOAT G:PSOAEOT TAPE1 W:$D(T(4,TI)) T(4,TI)
 I GD>0 F TI=1:1:GD D PSOAT G:PSOAEOT TAPE1 W:$D(T(5,TI)) T(5,TI)
 K TI,D,A,DG,GD Q
PSOAT ;check for eot return psoaeot=1 if eot found
 U PSOAT S PSOAEOT=0 X ^%ZOSF("EOT") I Y D EOT S PSOAEOT=1
 U PSOAT Q
EOT U IO(0) W !!?5,"** End of tape detected **",!?5,"After current tape rewinds, mount next tape" U PSOAT W ^%ZOSF("REW")
READ U IO(0) W !?5,"Type <CR> to continue" R XX:DTIME I '$T G READ
 W !!,"Recording information" S PSOATNM=PSOATNM+1
 Q
VAR ;Invoked by ^PSOARCS1 and ^PSOARCS2
 S STOP=0 Q  ;*PS*5.6$C(7)
 W !,"  Check both the 'OPEN PARAMETERS' and 'ASK RIGHT MARGIN' fields of",!,"  your device file"
 S STOP=1 D ^%ZISC K IOP Q
