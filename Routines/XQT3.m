XQT3 ;SEA/MJM Create menu templates (cont.);11/20/89  11:12 AM ;01/09/2001  13:33
 ;;8.0;KERNEL;**46,37,155**;Jul 10, 1995
STORE ;See if this is what the User wants and if so store it
 W @IOF,!,"You have chosen the following options in this order:",!!
 S XQN="" F XQI=0:0 S XQN=$O(XQLIST(XQN)) Q:XQN=""  W !,$P(XQLIST(XQN),U,4),"    (",$P(XQLIST(XQN),U,3),")"
 W !!,"Are we in agreement so far? [Y/N] Y// " R %:DTIME S:%="" %="Y" S:'$T %=U G:%=U OUT I %["?"!("YyNn"'[%) W !!,"Please answer 'Y' or 'N'",*7 H 10 G STORE
 I "Nn"[% W !!,"OK, lets take it from the top...." D O1 H 10 G EN^XQT2
 W @IOF,!!,"Fine.  Since all menu-type options will be processed in the background",!,"  you will only be asked to respond to the following:",!!
 S XQN=0 F XQI=0:0 S XQN=$O(XQLIST(XQN)) Q:XQN=""  I "MQ"'[$P(XQLIST(XQN),U,6) W !,$P(XQLIST(XQN),U,4),"    (",$P(XQLIST(XQN),U,3),")"
 W !!,"Are these the functions you want when you invoke this template? [Y/N] Y// " R %:DTIME S:'$T %=U G:%=U OUT S:%="" %="Y" I %["?"!("YyNn"'[%) W !!,*7,"Please answer 'Y' or 'N'" H 10 G STORE
 I "Nn"[% W !!,"OK, lets take it from the top...." D O1 H 10 G EN^XQT2
 ;
NAM ;Get a legitimate name for this template and file it.
 W !!,"Enter a name (6 characters or less in UPPER CASE)",!?5,"for this template or '^' to quit: " R XQUR:DTIME S:'$T XQUR=U G:XQUR=U OUT
 I XQUR["??" S XQH="XQTNAM" D EN^XQH S XQUR="" G NAM
 I XQUR[U W !!,"A menu template name may not contain the '^' character.",!,"Are you telling me you want to quit? [Y/N] N// " R XQUR:DTIME S:'$T XQUR=U G:XQUR=U OUT S:XQUR="" XQUR="N" I "Nn"[XQUR G NAM
 I XQUR="" W *7," ??" G NAM
 I $L(XQUR)>6 W *7,!!,"Six (6) characters or less, please." G NAM
 I XQUR["?" W !!,"A six character (or less) name like 'LAB', or 'E1',",!," something you will remember." S XQUR="" G NAM
 S XQUP=XQUR I XQUR'?.PUN S XQUP=$$UP^XLFSTR(XQUP) ;F XQI=1:1 Q:XQUP?.NUP  S %=$A(XQUP,XQI) I %<123,%>96 S XQUP=$E(XQUP,1,XQI-1)_$C(%-32)_$E(XQUP,XQI+1,255)
 S XQUR=XQUP
 W !!,"'",XQUR,"' it is.  In the future you will start this template by typing '[",XQUR,"'"
 ;
RPT ;Set the default for repeating the template
 W !!,"After you have finished using '",XQUR,"' will you want it to repeat? [Y/N] N// " R %:DTIME S:'$T %=U G:%=U OUT S:%="" %="N"
 I %["?" W !!,?5,"Please answer Yes or No."
 I %["??" S XQH="XQTREPEAT" D EN^XQH G RPT
 S XQTRPT=0 I "Yy"[% S XQTRPT=1
 ;
 ;Create the 'DR' strings to load the template into ^VA(200,DUZ,19.8)
 ;
 S XQJ=0,XQDR(0)="1///"_XQTRPT_U
 F XQI=1:1:XQOPN-1 S:$L(XQDR(XQJ))>200 XQJ=XQJ+1,XQDR(XQJ)="1///+" S XQDR(XQJ)=XQDR(XQJ)_$P(XQLIST(XQI),U,1)_","_$P(XQLIST(XQI),U,2)_","_$S($D(XQLIST(XQI,0)):"E",1:"")_$S($D(XQLIST(XQI,1)):"X",1:"")_"^"
 ;
FIL ;File this template in the New Person File
 K DIC,DIE,DR,DA
 S X=XQUR,DA=0,U="^",DA(1)=DUZ,DIC="^VA(200,"_DA(1)_",19.8,",DIC(0)="NFL"
 I '$D(^VA(200,DUZ,19.8,0)) S ^(0)="^200.198^^"
 I $D(^VA(200,DUZ,19.8,"B",X)) W !,"You already have a template called ",X,".  Do you want to replace it? N// " R %:30 S:%="" %="N" S:'$T %=U G:%=U OUT G:"Yy"'[% NAM S DA=$O(^(X,0)),DIK=DIC D ^DIK S X=XQUR
 I '$D(^VA(200,DUZ,19.8,"B",X)) D FILE^DICN
 S DA=$O(^VA(200,DUZ,19.8,"B",X,0))
 S DIE=DIC
 F XQI=0:1:XQJ S DR=XQDR(XQI) D ^DIE
 ;
OUT ;Clean up, restore XQY and quit
 ;S XQY=+XQTSV,XQDIC=$P(XQTSV,U,2),XQY0=$P(XQTSV,U,3,99)
 I $D(XQTSV) S XQY=+XQTSV,XQDIC=$P(XQTSV,U,2),XQY0=$P(XQTSV,U,3,99)
 I '$D(XQTSV) S XQY=^(^XUTL("XQ",$J,"T")),XQDIC=$P($P(XQY,U),+XQY,2),XQY0=$P(XQY,U,2,99),XQY=+XQY
 K XQTSV
 ;
 ;Come to O1 if we're restarting from "Are We In Agreement" Store+4, +9
O1 K %,D0,DA,DI,DIC,DQ,DR,XQA,XQAA,XQDR,XQH,XQH1,XQH2,XQI,XQJ,XQK,XQLIST,XQLK,XQN,XQNM,XQOO,XQOPN,XQRD,XQRL,XQSAV,XQSN,XQTF,XQTF1,XQTM,XQTRPT,XQTT,XQTXT,XQUR
 K XQT,XQT1,XQTSAV,XQUP,XQFLAG,XQFLG,XQL,XQLN,XQSAVE,XQX
 Q
