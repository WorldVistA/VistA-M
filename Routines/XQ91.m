XQ91 ; SEA/MJM - Restrict availability of options (cont.) ;9/29/92  15:06 ;5/13/93  11:46 AM
 ;;8.0;KERNEL;;Jul 10, 1995
 S (XQI,XQJ)=1,XQDF="",(XQTDV,XQTOD)=0 W !
GETDV W !," Enter ",$S($O(XQDV(0))>0!($O(XQOD(0))>0):"another",1:"a")," DEVICE name (or -DEVICE to delete): " R X:DTIME S:'$T X=U G:X[U OUT
 I '$L(X) S XQTDV=XQI-1,XQTOD=XQJ-1 G GOTDV
 I X["?" S XQH="XQRESTRICT-DEVICE",XQDF=1,XQISV=XQI,XQTDV=XQI-1,XQJSV=XQJ,XQTOD=XQJ-1 D:X="?" EN^XQH D:X="??" LSTDV D:X="???" LSTFIL S XQI=XQISV,XQJ=XQJSV,XQDF="" G GETDV
 I X["?" S XQDF=1 D LSTFIL S XQDF="" G GETDV
 S XQFL=0 S:"-'"[$E(X,1) X=$E(X,2,99),XQFL=1
 S DIC=3.5,DIC(0)="MEZ" D ^DIC I Y<0 W " ??",*7 G GETDV
 I XQFL S XQOD(XQJ)=Y,XQJ=XQJ+1,XQFL=0 G GETDV
 S XQDV(XQI)=Y,XQI=XQI+1 G GETDV
 ;
GOTDV ;Remove devices to delete (XQOD) from list of devices to add (XQDV)
 I 'XQTOD!('XQTDV) G OK
 S XQNDV=XQTDV,XQNOD=XQTOD,XQFL=0 F XQI=1:1 K:XQFL XQDV(XQI-1) S:XQFL XQTDV=XQTDV-1 Q:(XQI>XQNDV)  S XQFL=0 F XQJ=1:1 Q:(XQJ>XQNOD)  I $D(XQOD(XQJ))#2,XQDV(XQI)=XQOD(XQJ) K XQOD(XQJ) S XQFL=1,XQTOD=XQTOD-1
OK ;
 S XQFL2=1
LSTOP ;
 I $O(XQOP(0))="" W !!,"You have not yet selected any options." Q
 W !!,"You've selected the following options: ",! S XQJ=0,XQI=IOM\15 F XQK=0:1 S XQJ=$O(XQOP(XQJ)) Q:XQJ=""  W:'(XQK#XQI) ! W ?(XQK#XQI*15),$P(^DIC(19,XQJ,0),U,1)
 Q:'XQFL2  S XQFL2=0
 ;
LSTRES ;List restrictions to be placed on all options
 I $L(XQDR) W !!,"These restrictions will be updated for all options selected:",!
 F XQI=1:1:5 I $D(XQFLD(XQI,"V")) W !,$P(XQFLD(XQI,0),U,1),": ",XQFLD(XQI,"V")
 ;
LSTDV ;List PERMITTED DEVICES to be added and deleted
 S XQT=IOM\10
 I (XQTDV>0) W !!,"You will add these PERMITTED DEVICES to all options chosen:",! S XQI=0,XQD=-1 F  Q:(XQI+1>XQTDV)  S XQD=$O(XQDV(XQD)) Q:XQD=""  W:'(XQI#XQT) ! W ?(XQI#XQT*10),$P(XQDV(XQD),U,2) S XQI=XQI+1
 I (XQTOD>0) W !!,$S(XQTDV:"And you ",1:"You "),"will delete these PERMITTED DEVICES from all options chosen:",! S XQI=0,XQD=-1 F  Q:(XQI+1>XQTOD)  S XQD=$O(XQOD(XQD)) Q:XQD=""  W:'(XQI#XQT) ! W ?(XQI#XQT*10),$P(XQOD(XQD),U,2) S XQI=XQI+1
 I XQDF S XQDF="" Q
 ;
OK1 R !!,"Do you wish to proceed? YES// ",X:DTIME S:'$T X=U G:X[U OUT G:(X["N"!(X["n")) OP^XQ9 I '(X["Y"!(X["y")!'$L(X)) W *7," ??",!,"Enter 'Y' or 'N'" G OK1
 ;
ACT ;Stuff the restrictions and devices into the OPTION file
 S DIE=19,DA=0 F XQI=1:1 S DA=$O(XQOP(DA)),DR=XQDR Q:DA=""  W !,$P(^DIC(19,DA,0),U,1) D ^DIE W "*" D:(XQTOD>0) KILDV I (XQTDV>0) S XQN=-1 F  S XQN=$O(XQDV(XQN)) Q:XQN=""  S DR="3.96///"_$P(XQDV(XQN),U,2) D ^DIE W "+"
 G INIT^XQ9
 ;
KILDV ;Remove PERMITTED DEVICE from option
 S DIC="^DIC(19,"_DA_",3.96,",DIK=DIC,DIC(0)="MEZ",XQN=-1,DA(1)=DA
 F  S XQN=$O(XQOD(XQN)) Q:XQN=""  S X=$P(XQOD(XQN),U,2) D ^DIC S DA=+Y D ^DIK S DA=DA(1) W "-"
 Q
LSTFIL ;Show OPTION or DEVICE file
 W !,"Do you want to see the ",$S(XQDF:"DEVICE",1:"OPTION")," file? NO// " R X:DTIME S:'$T X="N" Q:X'["Y"&(X'["y")  S X="?",DIC=$S(XQDF:3.5,1:"^DIC(19,"),DIC(0)="Q" D ^DIC K DIC S XQDF=""
 Q
 ;
OUT ;
 K XQOP,XQFLD,XQI,XQISV,XQJ,XQJSV,XQDV,XQOD,XQTDV,XQNDV,XQTOD,XQNOD,XQDF,XQFL,XQFL2,XQD,XQDR,XQK,XQM,XQN,XQR,XQT
 K DIC,DIK,DIE,DR,DA,DI,DISYS,DLAYGO,DQ,D0,D1,I,J,K,L,X,Y,XY,%,%Y,C,POP
 Q
