XQ11 ;SEA/MJM - Menu Utilities ;1/08/2006
 ;;8.0;KERNEL;**155,372**;Jul 10, 1995;Build 3
 ;
COPY ;Make a copy of a menu-type option
 S XQA=$S(DUZ(0)["@":1,$D(^XUSEC("XUMGR",DUZ)):1,$D(^XUSEC("XUPROGMODE",DUZ)):1,1:0)
 S XQD="",%=0 I $D(^VA(200,DUZ,19.6,0)),$L($P(^(0),U,3)),$P(^(0),U,3)>0 F XQI=0:0 S %=$O(^VA(200,DUZ,19.6,%)) Q:%=""!(%'?1N.N)  S XQD=XQD_^(%,0)_","
 I 'XQA,'$L(XQD) W !!,"Sorry.  You need to be assigned a valid name space to proceed." H 6 S XQH="XQNAMSPAC" D EN^XQH Q
 ;
 S DIC="^DIC(19,",DIC(0)="AEMQZ",DIC("A")="Menu you would like to make a copy of: " D ^DIC
 Q:Y=-1  S XQYO=+Y
 W !!,"WARNING ** Option names must be carefully named to avoid system damage!!",!?5,"Do you want more information?  Yes// "
 R XQUR:DTIME S:"Nn"'[$E(XQUR,1) XQUR="Y" I "Yy"[$E(XQUR,1) S XQH="XQNAMSPAC" D EN^XQH
ASK W !!,"What is the new menu's name: " R XQUR:DTIME S:'$T XQUR=U G:XQUR[U OUT
 S XQF=1 I 'XQA S XQF=0 F XQI=1:1 S %=$P(XQD,",",XQI) Q:%=""  I %=$E(XQUR,1,$L(%)) S XQF=1 Q
 I 'XQF W !!?5,"Sorry.  Your new option must begin with: " F XQI=1:1 S %=$P(XQD,",",XQI) Q:%=""  W $S(XQI=1:"",1:" or "),%
 I 'XQF G ASK
 ;
 S (XQF,XQF0,XQF1)=0 I $D(^DIC(19,"B",XQUR)) S XQYN=$O(^(XQUR,0)) W !!?5,"Sorry, this option name is already in use." S XQF=1
 I XQF,$P(^DIC(19,XQYN,0),U,5)=DUZ S XQF0=1
REP I XQF,XQF0 W !!?5,"Do you want to replace it?  No// " R %:DTIME S:'$T %=U G:%=U OUT S:%="" %="N" G:"Nn"[$E(%) ASK S:"Yy"[$E(%) XQF1=1 I %["?" W !!?5,"If you answer 'Y' the existing option will be replaced by the one you're creating." G REP
 I XQF,'XQF1 G ASK
 I $L(XQUR)>30!(+XQUR=XQUR)!($L(XQUR)<3)!'(XQUR'?1P.E)!(XQUR'?.UNP) W *7,!!?5,"3 to 30 uppercase characters, please." G ASK
 ;
TXT ;Get the new menu text
 W !!,"The old menu text is ","""",$P(^DIC(19,+XQYO,0),U,2),"""",!
 K DIR S DIR("?")="Please enter 10 to 50 characters describing what the new option does.",DIR(0)="19,1",DIR("A")="What will option say?"
 D ^DIR S XQUR0=X G:$D(DIRUT) OUT
 ;R XQUR0:DTIME S:'$T XQUR0=U G:XQUR0[U OUT G:'$L(XQUR0) TXT I $E(XQUR0,1)="?"!($L(XQUR0)<10)!($L(XQUR0)>50)!(XQUR0'?. W !!?5,"Please enter 10 to 50 characters describing what the new option does." G TXT
 S XQUP=$$UP^XLFSTR(XQUR0) ;F XQI=1:1 Q:XQUP?.NUP  S %=$A(XQUP,XQI) I %<123,%>96 S XQUP=$E(XQUP,1,XQI-1)_$C(%-32)_$E(XQUP,XQI+1,255)
 ;
FIL ;Get FileMan to put this all in.
 S DIR("?")="'Y' means create the new menu. 'N' means don't.",DIR(0)="YA",DIR("A")="Is everything OK? ",DIR("B")="No" D ^DIR G:$D(DIRUT) OUT I Y=0 D OUT G ^XQ11
 I 'XQF S DIC(0)="LMXZ",X=XQUR,DLAYGO=19 D FILE^DICN S XQYN=Y
 S %X="^DIC(19,"_+XQYO_",",%Y="^DIC(19,"_+XQYN_"," D %XY^%RCR
 ;S $P(^DIC(19,+XQYN,0),U)=XQUR S DIK="^DIC(19,",DA=+XQYN D IX^DIC
 S DIE="^DIC(19,",DR=".01///"_XQUR_";1///"_XQUR0_";3.6////"_DUZ_";",DA=+XQYN D ^DIE S ^DIC(19,+XQYN,"U")=$E(XQUP,1,30)
 ;
OUT K %,%1,%X,%Y,C,D,D0,DA,DDH,DI,DIC,DIE,DIG,DIH,DIK,DIR,DIU,DIV,DIW,DLAYGO,DQ,DR,X,XQA,XQD,XQF,XQF0,XQF1,XQH,XQI,XQUP,XQUR,XQUR0,XQYN,XQYO,Y
 Q
