XQT4 ;SEA/MJM - Menu template utilities ;08/27/97  14:52
 ;;8.0;KERNEL;**46**;Jul 10, 1995
 S U="^"
SHO ;Show a user his or her template names
 S XQUSER=$P($P(^VA(200,DUZ,0),U),",",2)_" "_$P($P(^(0),U),",")
 S U="^",(XQI,XQN,XQIT,XQV)=0
 S XQN=$O(^VA(200,DUZ,19.8,"B",XQN)) I XQN="" W !,XQUSER," doesn't have any Templates stored in the New Person File." G KIL
 D HOME^%ZIS:'$D(IOF),^XQDATE
 W @IOF,!,?10,"The menu templates of ",XQUSER," ",%Y S XQV=2
 D SHO1 F XQI=0:0 S XQN=$O(^VA(200,DUZ,19.8,"B",XQN)) Q:XQN=""  D SHO1 Q:XQIT
KIL K %,%1,%2,%Y,XQI,XQLN,XQN,XQIT,XQUSER,XQV
 Q
SHO1 ;Write out template name and the first two options in it
 S XQI=0,XQI=$O(^VA(200,DUZ,19.8,"B",XQN,XQI)),%=^VA(200,DUZ,19.8,XQI,1,1,0),%=$P(%,U,2,999),%1=+$P(%,U,1),%2=+$P(%,U,2)
 I IOST["C-",'$D(ZTQUEUED),XQV+5>21 S XQV=0 D WAIT Q:XQIT  W @IOF
 W !!,"Template name: ",XQN S XQV=XQV+2
 I %1 W !,?3,"1st option: ",$S($D(^DIC(19,%1,0))#2:$P(^(0),U,2),1:"*** Missing Option ***") S XQV=XQV+1
 I %2 W !,?6,"2nd option: ",$S($D(^DIC(19,%2,0))#2:$P(^(0),U,2),1:"*** Missing Option ***") S XQV=XQV+1
 I $L($P(%,U,3)) W !,?9,"Etc." S XQV=XQV+1
 Q
OUT ;Clean up and quit
 S XQY=+XQTSV,XQDIC=$P(XQTSV,U,2),XQY0=$P(XQTSV,U,3,99)
 K %,%1,%2,X,XQ,XQALL,XQE,XQEX,XQI,XQII,XQJ,XQLM,XQN,XQTSV,XQIT,XQUR,Y
 Q
 ;
LIST ;List all of the options in a particular Menu Template
 S U="^",XQTSV=XQY_U_XQDIC_U_XQY0
ASK S (XQALL,XQE,XQIT)=0
 R !!,"Which template? ('^' to quit) ^// ",XQUR:DTIME S:'$T!(XQUR="") XQUR=U G:XQUR=U OUT I XQUR="?" W !!,"  Enter the name of one of your templates, 'ALL' to list them all,",!?5,"or '??' to get a list of all your templates." G ASK
 I XQUR="??" N XQIT D SHO G ASK
 I XQUR="ALL"!(XQUR="all") R !,"Are saying you want to print out all your templates? (Y/N) Y// ",%:DTIME S:'$T %=U S:%="" %="Y" S:"Yy"[% XQALL=1 I %["?" W !,"Please answer 'Y' or 'N' to this question." G ASK
ASKE R !,"Show Entry and Exit Actions? (Y/N) N// ",%:DTIME S:'$T %=U G:%=U OUT S:%="" %="N" S:"Yy"[% XQE=1
 I 'XQE,"YyNn"'[% W !!,"'Y' means you'll see the MUMPS code (if any) executed",!?3,"before and after the option is run.  'N' means you won't" G ASKE
 I XQALL S XQUR="" F XQII=0:0 S XQUR=$O(^VA(200,DUZ,19.8,"B",XQUR)) Q:XQUR=""  D DEED,WAIT Q:XQIT
 G:XQALL OUT
 D FIND^XQT G:XQK ASK D DEED
 G ASK
 Q
DEED ;Decode the word processing field where templates are stored
 S XQN=$O(^VA(200,DUZ,19.8,"B",XQUR,0)),XQJ=$P(^VA(200,DUZ,19.8,XQN,1,0),U,3)
 W @IOF,!?20,"Menu Template ",XQUR,!! S XQV=3,XQLM=1
 F XQI=1:1:XQJ S %=^VA(200,DUZ,19.8,XQN,1,XQI,0),%=$P(%,U,2,999) F XQK=1:1 S XQ=$P(%,U,XQK) Q:XQ=""  S XQY=+XQ,XQEX=$P(XQ,",",3),XQY0=$S($D(^DIC(19,+XQY,0))#2:^(0),1:"") D WRITE Q:XQIT  S XQLM=XQLM+1
 Q
 ;
WRITE ;Write the Entry Action, Menu text, and Exit Action for an option
 I XQE,$P(XQY0,U,14) W !?XQLM,"Entry Action: ",^DIC(19,+XQY,20) S XQV=XQV+1
 I XQE,$P(XQY0,U,17) W !?XQLM,"Header: ",^DIC(19,+XQY,26) S XQV=XQV+1
 I XQY0]"" W !?XQLM,$P(XQY0,U,2)_"   ("_$P(XQY0,U)_")" S XQV=XQV+1
 E  W !!?XQLM,"*** Fatal Error *** Option missing from Option File ***",!?XQLM,"This template will not run.  Delete and/or rebuild it." S XQIT=1 Q
 I XQE,$P(XQY0,U,15) W !?XQLM,"Exit Action: ",^DIC(19,+XQY,15) S XQV=XQV+1
 I XQV>20,IOST["C-" D WAIT Q:XQIT  W @IOF,?10,"Template ",XQUR," continued..." S XQV=1
 Q
 ;
WAIT ;That's a screen load hold it here for a minute
 S XQIT=0 W !!,"Hit RETURN to continue, '^' to quit: " S X="" R X:DTIME S:'$T X=U S:X=U XQIT=1 S XQLM=1
 Q
 ;
KILL ;Remove a template from the New Person File
 S U="^"
 R !!,"Which template should be deleted ? ",XQUR:DTIME S:'$T XQUR=U Q:XQUR=U  I XQUR="?" W !,"Enter a template name, '??' to get a list of your templates",!,"  or '^' to quit." G KILL
 I XQUR["??" D SHO W !! G KILL
 D FIND^XQT I XQK K XQ,XQI,XQJ,XQK Q
K1 W !,"I will remove the Menu Template ",XQUR," permanently.  OK? (Y/N) N// " R %:DTIME S:'$T %=U S:%="" %="N" G:%=U K2 G:"Nn"[% KILL I "Yy"'[% W !,"Please answer 'Y' or 'N' or '^' to quit." G K1
 S DA=$O(^VA(200,DUZ,19.8,"B",XQUR,0)),DA(1)=DUZ,DIK="^VA(200,"_DA(1)_",19.8," D ^DIK
K2 K DA,DIK,XQ,XQI,XQJ,XQK
 Q
 ;
RNAM ;Rename an exsisting Menu Template
 S U="^",DA(1)=DUZ,DIC="^VA(200,"_DA(1)_",19.8,",DIC("P")=200.198,DIC(0)="AEQM",DIC("A")="Rename which template? " D ^DIC I Y<0 K %,%Y,CD,DA,DIC,FUN Q
 S DIE=DIC,DIE("P")=DIC("P"),DA=+Y,DR=".01" D ^DIE
 K CD,D,D0,DA,DI,DIC,DIE,DISYS,DR,DQ,FUN
 Q
