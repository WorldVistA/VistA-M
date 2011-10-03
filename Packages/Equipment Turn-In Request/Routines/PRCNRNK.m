PRCNRNK ;SSI/ALA-Rank Requests for Committee ;[ 07/19/96  10:43 AM ]
 ;;1.0;Equipment/Turn-In Request;;Sep 13, 1996
SELECT ; Select a transaction
 W @IOF S DIC("S")="I $P(^(0),U,7)=10!($P(^(0),U,7)=31)",DIC="^PRCN(413,"
 S DIC(0)="AEQZ" D ^DIC K DIC("S") G EXIT:Y<0
 S IN=+Y,PRCNUSR=8 D SETUP^PRCNPRNT Q:$D(EDIT)
 K DUOUT S DR="[PRCNRNK]",DIE="^PRCN(413,",DA=IN D ^DIE
 G SELECT
EXIT K DIC,DIE,DA,IN,PRCNUSR,PRCC,OLDRANK,LPRI,PRCNDEF,EDIT,OLD,RANKMAX
 K DR,C,D,D0
 Q
RANKMAX ; Calculate maximum equipment committee rank
 S OLDRANK=$P($G(^PRCN(413,IN,6)),U,3),(RANKMAX,I)=0
 F  S I=$O(^PRCN(413,"E",I)) Q:'I  S RANKMAX=I
 S RANKMAX=RANKMAX+1
 Q
EN ;Check on entered priority
 K:+X'=X!(X>999)!(X<1)!(X?.E1"."1N.N) X
 I $G(X)="" Q
 ; Check if priority X already exists for this service
 Q:'$D(^PRCN(413,"E",X))
 Q:$D(^PRCN(413,"E",X,DA))
 NEW I
 I $D(^PRCN(413,"E",X)) S START=X D DOWN S DA=ORGDA
 K START,ORGDA
 Q
DOWN ; Insert this transaction & shift others one priority #
 S LPRI=RANKMAX S ORGDA=DA NEW DA S DA=ORGDA
 S ^PRCN(413,"E",START,ORGDA)=""
 S NXPR=START D GETDA
 I OTHDA'="",OTHDA'=DA S NXPR=START D GETPR
 K OTHDA,DA,NXPR,START,OLDA
 Q
DRANK ; Display ranks. Called as special help for rank fld.
 W !!,"Ranking list:" S I=0,PRCNCT=0
 F  S I=$O(^PRCN(413,"E",I)) Q:'+I  D  Q:$G(PRCC)'=""
 . S J=$O(^PRCN(413,"E",I,"")),PRCNCT=PRCNCT+1
 . I PRCNCT>20 D CHKPG Q:$G(PRCC)'=""
 . W !,I,?8,$P(^PRCN(413,J,0),U),?28,$P(^PRCN(413,J,0),U,18)
 K I,J,PRCC,PRCNCT
 Q
CHKPG ; If printing to screen & it is full, clear screen
 W !,"Hit RETURN to continue or '^' to quit. "
 R PRCC:DTIME S:'$T PRCC=U I PRCC'?1"^".E K PRCC Q
 S PRCNCT=0
 Q
GETPR S NXPR=$O(^PRCN(413,"E",NXPR))
 I NXPR'=(START+1) S NXPR=START+1 D SETDA Q
 I NXPR=(START+1) D SETDA S START=NXPR,DA=OTHDA D GETDA G GETPR
 Q
SETDA S $P(^PRCN(413,OTHDA,6),U,3)=NXPR,^PRCN(413,"E",NXPR,OTHDA)=""
 K ^PRCN(413,"E",START,OTHDA)
 Q
GETDA S OLDA="" F  S OLDA=$O(^PRCN(413,"E",NXPR,OLDA)) Q:OLDA=""  S:OLDA'=DA OTHDA=OLDA
 Q
