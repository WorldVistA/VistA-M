QAPSCRN ;557/THM-USER INPUT FOR SURVEYS [ 07/07/95  9:27 AM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
 D SCREEN^QAPUTIL S X="TRAP^QAPUTIL2",@^%ZOSF("TRAP")
EN S QAPOUT=0,MSSG=">> Question skipped <<",MSSG0="W *7,!!,?(IOM-$L(MSSG)\2),MSSG"
 W @IOF,! S QAPHDR="Survey Data Entry" X QAPBAR
 ;DIC("S") screens out all but "ready for use" statuses
 K DIC S DIC="^QA(748,",DIC(0)="AEQMZ",DIC("A")="Select a survey: ",DIC("S")="I $P(^(0),U,4)=""r""" D ^DIC K DIC G:X=""!(X[U) QUIT^QAPSCRN1
 ;change status automatically when expired
 S LASTDATE=$P(Y(0),U,3) I LASTDATE]"",DT>LASTDATE W *7,!!,"This survey is no longer active.",!! S:$P(Y(0),U,4)'="d" $P(^QA(748,+Y,0),U,4)="e" H 2 G EN
 ;
CONT S SURVEY=+Y,QAPNAME=$P(Y(0),U),TITLE=$P(Y(0),U,6),X="`"_DUZ D HASH^XUSHSHP S USER=X
 S DMANMSTR=$P(Y(0),U,8) ;are ALL demographics required?
 S (SVST,LQUES)="" K IFN,QUIT
 ;find any suspended response
 F DA=0:0 S DA=$O(^QA(748.3,"AC",USER,SURVEY,DA)) Q:DA=""!($D(QUIT))  I $P(^QA(748.3,DA,0),U,3)="s" S IFN=DA S QUIT=1 Q
 ;if no suspended response, see if one completed
 K DA,QUIT I '$D(IFN) S IFN=$O(^QA(748.3,"AC",USER,SURVEY,0))
 I IFN]"" S X=$G(^QA(748.3,IFN,0)),SVST=$P(X,U,3),LQUES=$P(X,U,4),LORD=+$P(X,U,5) I +LQUES=0 S LQUES="<no questions answered>"
 S CNT=0,PASSX=$P(Y(0),U,9) ;for multi-participation
 S PASSX=$TR(PASSX,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 W @IOF,! X QAPBAR S QAPHDR="Survey: "_TITLE X QAPBAR W !! S QLINE=$Y X CLEOP1
 I SVST="c",PASSX="" W !!,*7,"You may not participate more than once in this survey.",!!,"Press RETURN  " R ANS:DTIME  G EXIT^QAPUTIL
 I SVST="c",PASSX]"" W !!,*7,"You have already taken and completed this survey.",!,"You may participate again only if you know the correct password.",!!
 I PASSX=""!(SVST'="c") G PASSN
 S QLINE=$Y-1
PASSM X ^%ZOSF("EOFF")
 W BLDON,"Enter ^ to exit",BLDOFF W !!
 W "Enter MULTI-PARTICIPATION PASSWORD: " R X:DTIME G:'$T!(X[U) QUIT^QAPSCRN1
 S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I X'=PASSX W *7,!!,"Incorrect password " H 2 S CNT=CNT+1 X CLEOP1
 I X=PASSX G STR1
 I CNT>2 W !!,*7,"You don't know the password !",! X ^%ZOSF("EON") H 2 G QUIT^QAPSCRN1
 I PASSX]"",X'=PASSX G PASSM
 ;
PASSN I SVST="s" W !!,"This is a restart of a previous session.",!,"The last question answered was # ",LQUES,".",!!,"Press RETURN  " R ANS:DTIME G:'$T!(ANS[U) QUIT^QAPSCRN1
 I SVST="s" S:LORD=99999 LORD=0 S (DISP,CQUES)=LORD,QAPCNT=+LQUES G HELPINS
 I SVST="i" W !!,"You appear to be already working on this survey at another terminal.",!! H 3 G QUIT^QAPSCRN1
 S CNT=0,PASSX=$P(Y(0),U,7)
 ;
PASSR I PASSX="" G STR1
 S PASSX=$P(Y(0),U,7) X ^%ZOSF("EOFF") X CLEOP W !,"Enter SURVEY PASSWORD: " R X:DTIME G:'$T!(X[U) QUIT^QAPSCRN1
 S PASSX=$TR(PASSX,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I X'=PASSX W *7,!!,"Incorrect password " H 2 S CNT=CNT+1
 I X=PASSX G STR1
 I CNT>2 W !!,*7,"You do not know the password !",! X ^%ZOSF("EON") H 2 G QUIT^QAPSCRN1
 I PASSX]"",X'=PASSX G PASSR
 ;
STR1 K NEWREC X ^%ZOSF("EON") S (DIC,DIE)="^QA(748.3,",DLAYGO=748.3,DIC(0)="LM",X=SURVEY,DIC("DR")="2///^S X=""`""_DUZ" K DO,DD D FILE^DICN S FILEDA=+Y K DIC,DO,X,Y,DLAYGO,DA S NEWREC=1 ;must use /// to force encryption of DUZ via input xform
 S (DISP,QUES)=""
 ;
HELPINS G:+LQUES>0 EN1^QAPSCRN1 S QLINE=4 X CLEOP1 W !!,"Do you want to see instructions"  S %=1 D YN^DICN I %=1 X CLEOP D INSTRUCT^QAPUTIL W !!,"Press RETURN  " R ANS:DTIME K ANS I '$T S DSTOP=1 G KILL^QAPSCRN1
 I $D(DTOUT) S DSTOP=1 K EDIT G KILL^QAPSCRN1
 I $D(%Y),%Y["?" W !!,"Enter Y to see instructions or N to skip them.  " H 3 X CLEOP1 W ! G HELPINS
 I %<1,$D(NEWREC) D ABORT^QAPSCRN1 G:$D(STOP) QUIT^QAPSCRN1
 I %<1,'$D(NEWREC) G QUIT^QAPSCRN1
 ;
 G EN1^QAPSCRN1
