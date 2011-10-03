PRCNOTHR ;SSI/ALA-Other request reviewers ;[ 11/04/96  10:17 AM ]
 ;;1.0;Equipment/Turn-In Request;**1,11**;Sep 13, 1996
CON ;  Concurring Official's review and approval
 S DIC="^PRCN(413,",DIC(0)="AEQZ",DIC("S")="I $P(^(0),U,7)=9" D ^DIC
 K DIC("S") G Q2:Y<0 S (IN,DA)=+Y
 ;  Check to see if you are one of the concurring officials for
 ;  this transaction
 I '$D(^PRCN(413,DA,5)) W $C(7)," ??  No Concurring Officials for this transaction!" G Q2
 S PRCNDZ=$O(^PRCN(413.3,"B",DUZ,""))
 I 'PRCNDZ W !,$C(7),"  ??  You are not a Concurring Official!" K PRCNDZ G CON
 I '$D(^PRCN(413,DA,5,"B",PRCNDZ)) W !,$C(7),"  ??  You are not a Concurring Official for this transaction!" K PRCNDZ G CON
 S NUM=$O(^PRCN(413,DA,5,"B",PRCNDZ,""))
 S D0=DA,D1=NUM,PRCNUSR=5 D SETUP^PRCNPRNT
ASK K % W !!,"Do you approve this Equipment Request" D YN^DICN
 S PRCNANS=% G Q2:%=-1
 I %=0 W !,"Answer 'Y' or 'N'." G ASK
 S $P(^PRCN(413,DA,5,NUM,0),U,2)=$S(%=2:"N",1:"Y"),$P(^(0),U,3)=DT
EX S ^PRCN(413,DA,5,NUM,1,0)="^^"_DT,DIWETXT="COMMENTS"
 W !,"COMMENTS"
 NEW DIC S DIC="^PRCN(413,"_DA_",5,"_NUM_",1," D EN^DIWE
 I '$D(^PRCN(413,DA,5,NUM,1,1)) W !,$C(7),"Please enter an explanation of your decision." G EX
 D ES^PRCNUTL I $G(FAIL)<1 G EXIT
CS ; Check if all concurring officials have answered.
 S (DIS,N,SUB,TOT)=0 F  S N=$O(^PRCN(413,DA,5,N)) Q:'N  D
 . S STAT=$P(^PRCN(413,DA,5,N,0),U,2),TOT=TOT+1
 . S:STAT]"" ANS(STAT)=$G(ANS(STAT))+1,SUB=SUB+1
 I SUB'<TOT D
 . I (+$G(ANS("Y"))/TOT*100)<50 D  Q:DIS
 .. S DIE=413,DR="6////^S X=15;7////^S X=DT" D ^DIE
 .. S KEY="PRCNPPM" D FND^PRCNMESG S XMDUZ="CONCURRING OFFICIALS"
 .. S XMB="PRCNPPM2",XMB(1)=$P(^PRCN(413,DA,0),U),MSGN=99
 .. D MES^PRCNMESG
 .. S DIS=1
 . S DIE=413,DR="6////^S X=32;7////^S X=DT" D ^DIE
Q2 K ANS,CFL,D0,D1,FAIL,STAT,TOT,DIS,SUB,XMB,DIC,XMDUZ,PRCNCMR,PRCNRQS
 I $G(PRCNANS)=1 W !!,"Transaction will be returned to PPM for final review",!
EXIT K DIC,DIE,DA,DR,X,Y,PRCNUSR,IN,XMY,XMTEXT,C,J,N,NUM,FAIL,%,D,MSGN
 K PRCNANS,DIWETXT,PRCNDZ
 Q
