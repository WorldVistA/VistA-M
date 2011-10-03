QAPXFER1 ;557/THM-IMPORT A SURVEY [ 06/22/95  2:27 PM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
EN S IOP="HOME" D ^%ZIS,SCREEN^QAPUTIL K IOP
 S QAPHDR="Import a Survey" W @IOF,! X QAPBAR
 I $D(DUZ)#2=0 W !!,"Your DUZ is not defined.",*7,! H 2 G EXIT
 ;
SEE S QLINE=2 X CLEOP1 W !,"Do you need instructions for this option" S %=2 D YN^DICN G:$D(DTOUT)!(%<0) EXIT I %=1 D INST
 I $D(%Y),%Y["?" W !!,"Enter Y for instructions or N to skip them." H 2 G SEE
 ;
ASK W @IOF,! X QAPBAR W ! S DIC=3.9,DIC(0)="AEQMNZ",DIC("A")="Enter message number/subject: " D ^DIC G:X=""!(X[U) EXIT
 S MSGNUM=+Y G:MSGNUM<0 EXIT
 ;
ASK1 K ^TMP($J) W @IOF,! X QAPBAR W !!,"Message: ",$P(Y(0),U),!!
 S XMZ=MSGNUM,XMPOS=2.99,XMCHAN="SERVER" D GET^XML X XMREC
 I XMRG'["$GLO ^TMP($J,""QAP""" W *7,!!,"This message is NOT an imported survey !!   " H 2 G ASK
 W "Is this the correct message" S %=2 D YN^DICN G:$D(DTOUT) EXIT
 I $D(%Y),%Y["?" W !!,"Enter Y if it is the correct message or N if not." H 3 G ASK1
 I %<1 G EXIT
 I %=2 G ASK
 F XMPOS=.99:0 X XMREC Q:XMER<0  S ^TMP($J,"QAPXM",XMZ,2,XMPOS,0)=XMRG
 S SVYNAME=$P(^TMP($J,"QAPXM",XMZ,2,5,0),"^",1),SVYSITE=$P(^(0),"^",2)
 S QLINE=$Y-1
ASK2 K %,ONFILE,XMER,XMPOS,XMREC,XMRG
 I $D(^QA(748,"B",$E(SVYNAME,1,30))) S ONFILE=1,QLINE=3 X CLEOP1 W !!,">> ",SVYNAME," <<",*7,!!,"You already have a survey by this name on file.",!,"Do you want to continue anyway" S %=2 D YN^DICN I $D(DTOUT) G EXIT
 I $D(%Y),%Y["?" W !!,"Enter Y to install the message or N to reselect." H 3 X CLEOP1 G ASK2
 I $D(%),%'=1 G ASK
 ;
 I $D(ONFILE) K STOP,NEWNAME W @IOF,! X QAPBAR DO  G:$D(STOP) EXIT I %<0 G ASK
 .S QLINE=$Y W !!
RENAME .W *7,"Do you want to rename the survey" S %=2 D YN^DICN I $D(DTOUT) S STOP=1 Q
 .I $D(%Y),%Y["?" W !!,"Enter Y to rename the survey or N to leave it as is." H 3 X CLEOP1 W ! G RENAME
 .Q:%'=1
 .;
NEWNAME .X CLEOP1 W !!,"New survey name: " R NEWNAME:DTIME I '$T!(NEWNAME["^") S STOP=1 Q
 .I NEWNAME?1.100"?"!(NEWNAME'?1.40UNP) W !!,*7,"Enter the new name for the survey [1-40 UPPERCASE characters or punctuation.]" H 3 G NEWNAME
 .;
NEWASK .W @IOF X QAPBAR W !!,"The new name will be '",NEWNAME,"'",!,"     Ok" S %=1 D YN^DICN I $D(DTOUT)!(%<0) S STOP=1 Q
 .I $D(%Y),%Y["?" W !!,"Enter Y to accept this name or N to enter another one." H 3 X CLEOP1 W ! G NEWASK
 .G:%=2 NEWNAME
 I $D(NEWNAME) S SVYNAME=NEWNAME
 S QAPHDR="Importing survey: "_SVYNAME W @IOF,! X QAPBAR
 S QAPHDR="from "_SVYSITE X QAPBAR
 F I=4:2 S X=$G(^TMP($J,"QAPXM",XMZ,2,I,0)) Q:X=""!(X["$END")  S Y=$E(^TMP($J,"QAPXM",XMZ,2,(I+1),0),1,999),@X=Y
 F I=I+2:2 S X=$G(^TMP($J,"QAPXM",XMZ,2,I,0)) Q:X=""!(X["$END")  S Y=$E(^TMP($J,"QAPXM",XMZ,2,(I+1),0),1,999),@X=Y
 K DO,DD S X="TEMP NAME",DIC(0)="LQMZ",(DIE,DIC)="^QA(748," D FILE^DICN S NEWDA=+Y
 K DO,DD S (DINUM,X)=NEWDA,DIC(0)="LQM",(DIE,DIC)="^QA(748.25," D FILE^DICN S NEWDA1=+Y K DIC,DIE,X,Y,DINUM
 W !!,"Installing basic survey data  " H 1
 S %X="^TMP($J,""QAP"",999998,",%Y="^QA(748,"_NEWDA_"," D %XY^%RCR
 W !,"Installing the survey questions  " H 1
 S %X="^TMP($J,""QAP"",999999,",%Y="^QA(748.25,"_NEWDA1_"," D %XY^%RCR
 W !,"Cleaning up non-exportable fields  " H 1
 S DR=".01///"_SVYNAME_";.03///@;.04///@;.05///d;.055///^S X=""`""_DUZ;4///@",DA=NEWDA,(DIC,DIE)="^QA(748," D ^DIE
 S DA(1)=NEWDA
 F AUTHED=0:0 S AUTHED=$O(^QA(748,DA(1),5,"B",AUTHED)) Q:AUTHED=""  F DA=0:0 S DA=$O(^QA(748,DA(1),5,"B",AUTHED,DA)) Q:DA=""  S DIK="^QA(748,DA(1),5," D ^DIK
 K ^QA(748,"B","TEMP NAME",DA(1))
 W !,"Re-indexing the survey and questions  "
 S DA=NEWDA F DIK="^QA(748,","^QA(748.25," D IX^DIK
 W !!,"Checking the DEMOGRAPHICS for invalid pointers  ",! H 1
 S (ANS,DEMO)="" F  S DEMO=$O(^QA(748,NEWDA,1,"B",DEMO)) Q:DEMO=""!(ANS[U)  F DA=0:0 S DA=$O(^QA(748,NEWDA,1,"B",DEMO,DA)) Q:DA=""  DO  Q:ANS[U
 .S DTA=^QA(748,NEWDA,1,DA,0) Q:$P(DTA,U,2)'="p"
 .S DEMONAME=$P(DTA,U,1),FILEPTR=$P(DTA,U,3),FILENUM=$P($G(^QA(748.2,+FILEPTR,0)),U,1),FILENAME=$P($G(^DIC(+FILENUM,0)),U)
 .I FILENAME="" W *7,!,"Demographic ",DEMONAME," points to a file which",!," does not exist in your DEMOGRAPHIC REFERENCE file.",!
 .I $Y>(IOSL-4) W !!,"Press RETURN to continue or ""^"" to exit: " R ANS:DTIME
 ;
FIN W !,"Finished. ",!!,"This imported survey must be made ready for use.",!!,"You have been made the creator/author of it and you must",!,"review the entire survey before releasing it.",!!,"Press RETURN  " R ANS:DTIME
 G EXIT
 ;
INST S QAPOUT=0 S QLINE=3 X CLEOP1
 W !,"This option will import a survey which has been sent to you in a",!
 W "MailMan message.  It is entirely automatic.",!!,"All you have to do "
 W "is supply the number or subject of the MailMan",!
 W "message which contains the survey.",!!,"Once the program has imported "
 W "the survey, you will have been made",!,"the creator of it.  It will be up "
 W "to you to make any corrections needed.",!!,"Press RETURN  " R ANS:DTIME I '$T!(ANS[U) S QAPOUT=1
 Q
 ;
EXIT K MSGNUM G EXIT^QAPUTIL
