PRCNRSMT ;SSI/ALA-Resubmit Equipment Requests ;[ 03/18/96  12:47 PM ]
 ;;1.0;Equipment/Turn-In Request;;Sep 13, 1996
EN ;  Review equipment requests and resubmit to equipment committee
 S DIC="^PRCN(413,",DIC(0)="AEQZ"
 I $G(PRCNCMF)="" S DIC("S")="S ST=$P(^(0),U,7) I ST=4!(ST=17)!(ST=18)&($P(^(0),U,2)=DUZ)"
 I $G(PRCNCMF)'="" S DIC("S")="S ST=$P(^(0),U,7) I (ST=4)!(ST=17)!(ST=18)&($P(^(0),U,6)=DUZ)"
 D ^DIC K DIC("S") G EXIT:Y<0
 S (IN,DA)=+Y,PRCNUSR=8 D SETUP^PRCNPRNT
 S PST=$P($G(^PRCN(413,DA,8)),U,9)
 S NST=$S(ST=4:3,ST=17:10,ST=18:39,1:ST) S:PST=45 NST=39
 G EXIT:$D(DUOUT)
QS W !,"Is this request ready to go" S %=1 D YN^DICN
 I %=0 D  G QS
 . W !!,"Enter 'Y'es if this request is ready to be resubmitted.  Request will become"
 . W !,"'Pending Equipment Committee Review/Rank' if status was 'Deferred'."
 . W !,"Or status will become 'Ready for 2237 Processing if status was 'Approved-Pending Funding'."
 . W !,"Or status will become 'Pending CMR Official Review if status was 'Returned by"
 . W !,"CMR Official-Not Approved."
 I %=1 D
 . S DIE=413,DR="6////^S X=NST;7////^S X=DT;77////^S X=ST" D ^DIE
 . W !!,"Transaction has become => ",$P(^PRCN(413.5,NST,0),U) W !
 D EXIT G EN
EXIT K DIC,DUOUT,%,DIE,DR,ST,PRCNUSR,IN,X,D0,DA,D,NST
 Q
