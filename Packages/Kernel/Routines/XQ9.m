XQ9 ; SEA/AMF,MJM - RESTRICT AVAILABILITY OF OPTIONS ;9/29/92  14:59 ;5/13/93  11:24 AM
 ;;8.0;KERNEL;;Jul 10, 1995
INIT ;
 K XQOP,XQFLD,XQDV,XQOD S (XQTDV,XQTOD,XQDF)=0 S XQOP(0)=0,XQJ=1 F XQI=2,3,3.8,3.91,3.95,3.96 S XQFLD(XQJ)=XQI,XQFLD(XQJ,0)=^DD(19,XQI,0) S XQJ=XQJ+1
 S U="^" S:'$D(DTIME)#2 DTIME=60 S %ZIS="M" D:'$D(IOM) ^%ZIS K %ZIS
OP ;
 W !!,$S($O(XQOP(0))>0:"Another ",1:"Select ") W "OPTION NAME: " R X:DTIME S:'$T X=U G:X[U OUT
 I '$L(X) S XQI=$O(XQOP(0)) G:XQI="" OUT W ! G:($O(XQOP(XQI))="") ONEOPT G GETRS
 I X["?" S XQH="XQRESTRICT-OPTION" W ! D:X="?" EN^XQH D:X="??" LSTOP D:X="???" LSTFIL G OP
 S XQM=0 S:"-'"[$E(X,1) X=$E(X,2,999),XQM=1
 S DIC=19,DIC(0)="MEZ" D ^DIC I Y<0 W " ??",*7 G OP
 I XQM W $S($D(XQOP(+Y)):"  Deleted",1:$C(7)_" ??  Option not on list") K XQOP(+Y) G OP
 I $D(^DIC(19,+Y,0)) S XQK=^(0) F XQI=1:1:5 S XQJ=$P(XQFLD(XQI,0),U,4),XQJ=$P(XQJ,";",2) I $L($P(XQK,U,XQJ)) W !?4,"CURRENT ",$P(XQFLD(XQI,0),U,1),": ",$P(XQK,U,XQJ)
 I $D(^DIC(19,+Y,3.96)) S K=$P(^DIC(19,+Y,3.96,0),U,3) S XQJ=0 F XQI=1:1:K I $D(^DIC(19,+Y,3.96,XQI,0)) S XQN=+^(0) W:(XQJ=0) !,?4,$P(XQFLD(6,0),U,1),": " W:(XQJ>0) ",  " W:'(XQJ#6) !,?22 W $P(^%ZIS(1,XQN,0),U,1) S XQJ=XQJ+1
 S XQOP(+Y)=Y G OP
ONEOPT ;
 S DA=$O(XQOP(0)),DIE=19,DR="2;3;3.01;3.8;3.91;3.95;3.96" D ^DIE
 G OUT
 ;
GETRS ;Get data for each restriction field, check it, and build DR string
 S XQI=0,XQDR=""
NEXT S XQI=XQI+1,XQN=+XQFLD(XQI) G:(XQI=6) GOTRS W !,$P(XQFLD(XQI,0),U,1)_" or '@' to delete: " R X:DTIME S:'$T X=U G:X[U OUT
 I '$L(X) G NEXT
 I X["?" S XQH="XQRESTRICT"_$S(XQN=2:"-OOO",XQN=3:"-LOCK",XQN=3.8:"-PRIORITY",XQN=3.91:"-TIMES",XQN=3.95:"-RESDEV",1:"") W ! D EN^XQH W ! S XQI=XQI-1 G NEXT
 I X["@" S XQDR=XQDR_XQFLD(XQI)_"///@;" S XQFLD(XQI,"V")="(Delete current data from this field)" G NEXT
 I XQN=2 K:$L(X)>80!($L(X)<1) X W:'$D(X)#2 !,$P(XQFLD(XQI,0),U,1)," must be free text, 1  to 80 characters in length." S:'$D(X)#2 XQI=XQI-1 G:'$D(X)#2 NEXT S XQDR=XQDR_XQFLD(XQI)_"///"_X_";" S XQFLD(XQI,"V")=X G NEXT
 I XQN=3 K:$L(X)>30!($L(X)<1)!('$D(^DIC(19.1,"B",X))) X W:'$D(X)#2 !,$P(XQFLD(XQI,0),U,1)," (1 to 30 characters) must match exactly an existing key." S:'$D(X)#2 XQI=XQI-1 G:'$D(X)#2 NEXT S XQDR=XQDR_XQN_"///"_X_";" S XQFLD(XQI,"V")=X G NEXT
 I XQN=3.8 K:+X'=X!(X>10)!(X<1) X W:'$D(X)#2 !,$P(XQFLD(XQI,0),U,1)," must be a single number between 1 and 10." S:'$D(X)#2 XQI=XQI-1 G:'$D(X) NEXT S XQDR=XQDR_XQN_"///"_X_";" S XQFLD(XQI,"V")=X G NEXT
 I XQN=3.91 K:$L(X)>9!($L(X)<9)!(X'?4N1"-"4N) X W:'$D(X)#2 !,$P(XQFLD(XQI,0),U,1)," must be 9 characters in the form '0800-1630'" S:'$D(X)#2 XQI=XQI-1 G:'$D(X)#2 NEXT S XQDR=XQDR_XQN_"///"_X_";" S XQFLD(XQI,"V")=X G NEXT
 I XQN=3.95 K:X'["Y"&(X'["y")&(X'["N")&(X'["n") X W:'$D(X)#2 !,$P(XQFLD(XQI,0),U,1)," must be 'yes' or 'no' (Y or N)" S:'$D(X)#2 XQI=XQI-1 G:'$D(X)#2 NEXT S XQDR=XQDR_XQN_"///"_X_";" S XQFLD(XQI,"V")=X
 G NEXT
 ;
GOTRS ;Continue on in the next routine (^XQ91)
 ;
 G ^XQ91
 ;
LSTOP ;List the options that have been selected thus far
 I $O(XQOP(0))="" W !!,"You have not yet selected any options." Q
 W !!,"You've selected the following options: ",! S XQJ=0,XQI=IOM\15 F XQK=0:1 S XQJ=$O(XQOP(XQJ)) Q:XQJ=""  W:'(XQK#XQI) ! W ?(XQK#XQI*15),$P(^DIC(19,XQJ,0),U,1)
 Q
 ;
LSTFIL ;Show OPTION or DEVICE file
 W !,"Do you want to see the ",$S(XQDF:"DEVICE",1:"OPTION")," file? NO// " R X:DTIME S:'$T X="N" Q:X'["Y"&(X'["y")  S X="?",DIC=$S(XQDF:3.5,1:"^DIC(19,"),DIC(0)="Q" D ^DIC K DIC S XQDF=""
 Q
 ;
OUT ;
 K XQOP,XQFLD,XQI,XQISV,XQJ,XQJSV,XQDV,XQOD,XQTDV,XQNDV,XQTOD,XQNOD,XQDF,XQFL,XQFL2,XQD,XQDR,XQK,XQM,XQN,XQR,XQT
 K DIC,DIK,DIE,DR,DA,DI,DISYS,DLAYGO,DQ,D0,D1,I,J,K,L,X,Y,XY,%,%Y,C,POP
 Q
