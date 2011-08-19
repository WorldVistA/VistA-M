PRCNPPM ;SSI/ALA-PPM Equipment Request Process ;[ 08/07/96  2:58 PM ]
 ;;1.0;Equipment/Turn-In Request;**10**;Sep 13, 1996
REV ;  Review transaction
 S DIC("S")="I $P(^(0),U,7)=6!($P(^(0),U,7)=27)!($P(^(0),U,7)=32)"
 S DIC="^PRCN(413,",DIC(0)="AEQZ",DIE=413 D ^DIC G EXIT:+Y<0 K DIC("S")
 S (IN,DA)=+Y,STAT=$P(^PRCN(413,DA,0),U,7),STATS="6^^27^^^32^"
 D CMR
 F PRCNUSR=1:1:7 Q:STAT=$P(STATS,U,PRCNUSR)
 S DR=$S(STAT=6:"[PRCNPPM]",STAT=27:"[PRCNPPM1]",1:"[PRCNPPM2]")
 D SETUP^PRCNPRNT,^DIE
 I $G(STAT)=6,$P($G(^PRCN(413,DA,4)),U)="Y" W !!,"Transaction sent to Engineering for Review",!!
 I $G(STAT)=9 W !!,"Transaction sent to Selected Concurring Officials for Review",!!
 G REV
EXIT K IN,DA,STAT,STATS,PRCNUSR,DR,DIC,DIE,PRCNC,PRCN,PRCNCMR,PRCNDATA
 K PRCNDAT4,PROG,FL,I,%,D,D0,SERV,LPRI,OLDPRI,PRIMAX,REQ,X,J
 Q
CMR S PRCNC=$P(^PRCN(413,DA,0),U,16),PRCNCMR=""
 S PRCNCMR=$P(^ENG(6914.1,PRCNC,0),U,2)_U_$P($G(^(20)),U)
 Q
MES ;  Send mail message from PPM to requestor and CMR Official
 I $G(PRCNCMR)="" D CMR
 S XMB(1)=$P(^PRCN(413,D0,0),U),XMDUZ=DUZ
 I MSGN'=6 D
 . S REQ=$P(^PRCN(413,DA,0),U,2),XMY(REQ)=""
 . F II=1:1 S PRCNCMN=$P(PRCNCMR,U,II) Q:PRCNCMN=""  D
 . . I PRCNCMN'="" S XMY(PRCNCMN)=""
 I MSGN=6 D
 . NEW Y
 . S Y=$P(^PRCN(413,D0,5,D1,0),U,5) X ^DD("DD") S XMB(2)=Y,XMB="PRCNCONC"
 . NEW DA S DA=D0 D CON^PRCNMESG
 . S KEY="PRCNPPM" D FND^PRCNMESG
 . S MSG(1)=""
 S XMB=$S(MSGN=1:"PRCNPPM1",1:$G(XMB))
 I $G(CFL)=0 Q
 I $G(NOD)="" G MS
 ;  Append the explanation text to end of this mail message
 S NL=$P($G(^PRCN(413,DA,NOD,0)),U,3)
 I NL'="" F II=1:1:NL S MSG(II)=$G(^PRCN(413,DA,NOD,II,0))
MS S XMTEXT="MSG(" D ^XMB
 K NL,MSGN,II,MSG,PRCNCMN,PRCNVA1,PRCNVA2,KEY,CFL,NOD,XMB,XMTEXT
 K PRCNCMR,PRCN,XMDUZ
 Q
MESG ; Display message w/number of transactions for PPM stages
 W !,$C(7)
 D WOC^PRCNTIPP
 NEW ERROR S ERROR=""
 S PJ=0 F ST=6,7,10,13,19,27,32,33,37,39 D
 . S NI=0 F  S NI=$O(^PRCN(413,"AC",ST,NI)) Q:'+NI  S STA(ST)=$G(STA(ST))+1
 S NXI="" F  S NXI=$O(STA(NXI)) Q:NXI=""  D
 . S TEX3=$P(^PRCN(413.5,NXI,0),U),TEX1=$S(STA(NXI)=1:"is",1:"are")
 . S TEX2=$S(STA(NXI)=1:"request",1:"requests")
 . W !,?3,"There "_TEX1_" "_STA(NXI)_" equipment "_TEX2_" "_TEX3_"."
 K STA S PJ=0 F ST=6,23,25 D
 . S NI=0 F  S NI=$O(^PRCN(413.1,NI)) Q:'+NI  D
 . . ;
 . . I '$D(^PRCN(413.1,NI,0)) D  QUIT  ;FNC-1101-30237
 . . . QUIT:$D(ERROR(NI))  S ERROR(NI)=""
 . . . W !!,?3,"There is an invalid internal entry number in the "
 . . . W "TURN-IN REQUEST file."
 . . . W !,?3,"Please call NVS to review internal entry number ",NI
 . . . W " in file 413.1",!
 . . . ;
 . . I $P(^PRCN(413.1,NI,0),U,7)=ST S STA(ST)=$G(STA(ST))+1
 . . ;
 W ! S NXI="" F  S NXI=$O(STA(NXI)) Q:NXI=""  D
 . S TEX3=$P(^PRCN(413.5,NXI,0),U),TEX1=$S(STA(NXI)=1:"is",1:"are")
 . S TEX2=$S(STA(NXI)=1:"request",1:"requests")
 . W !,?3,"There "_TEX1_" "_STA(NXI)_" turn-in "_TEX2_" "_TEX3_"."
 K PJ,ST,NI,STA,NXI,TEX1,TEX2,TEX3
 Q
