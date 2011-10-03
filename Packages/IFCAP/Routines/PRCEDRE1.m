PRCEDRE1 ;WISC/LDB-EDIT DAILY RECORD ; 07/16/93  9:29 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
ED ;Called from PRCEDRE to edit a daily record
 D SCR,NUM,KILL^%ZISS
 Q
SCR S (FR,TO)=$P(DRDA(0),U),BY=.01,FLDS="[PRCE DAILY RECORD EDIT]",DIC="^PRC(424.1,",L=0,IOP="HOME" D EN1^DIP
 Q
HLP0 S DY=16,DX=0 X IOXY D CLR S DY=17,DX=0 X IOXY W !!,"Enter number(s) from the left hand side of the screen"
 W !,"that correspond to the field that you would like to change."
 W !,"Enter numbers 1-4 in a list like 2,3,4 or a range like 1-3 or"
 W !,"one number at a time."
 W !,"ONLY NUMBERED PROMPTS can be edited."
 S DY=16,DX=0 X IOXY
 Q
HLP1 S DY=16,DX=0 X IOXY D CLR S DY=19,DX=0 X IOXY W HLPMSG S DY=16,DX=0 X IOXY Q
HLP ;HELP MESSAGES
 ;;Enter an amount between 0 and 999999999.99"
 ;;Enter vendor number
 ;;Enter the reference for this record 3-15 characters 
 ;;Enter any comments or description for this record -245 characters or less
NUM D ENS^%ZISS
 S DY=16,DX=0 X IOXY S DIR("A")="WHICH NUMBER(S) WOULD YOU LIKE TO EDIT (1-4): " S DIR(0)="LA^1:4"
 S DIR("?")="^D HLP0^PRCEDRE1" D ^DIR
 Q:'Y
 K PRDERD,DIR F NUM=1:1 Q:$P(Y,",",NUM)=""  S PRCERD(NUM)=$P(Y,",",NUM)
 S (DR,NUM,FLD,FLG)="" F  S NUM=$O(PRCERD(NUM)) Q:'NUM  D  Q:$D(DIRUT)
 . I PRCERD(NUM)=1,$P(^PRC(424,AUDA,0),U,9) D  Q
 ..S X="This authorization has been marked as complete and NO EDITING of the authorization amount can be done until the authorization is reopened." D MSG^PRCFQ H 3
 . K DIR S DIR(0)="424.1,"_$S(PRCERD(NUM)=1:.03,PRCERD(NUM)=2:.06,PRCERD(NUM)=3:.08,1:1.1)_"O"
 . S DIR("?")="^D HLP1^PRCEDRE1",HLPMSG=$P($T(HLP+$S(PRCERD(NUM)=1:1,PRCERD(NUM)=2:2,PRCERD(NUM)=3:3,1:4)),";;",2)
 . S DY=16,DX=0 X IOXY D CLR S DY=16,DX=0 X IOXY D ^DIR
 . I DIR(0)[".03" D AMT S Y=$S(PRCADJ:"",AAMT2<0:"",1:-AAMT2) I AAMT2<0 S Y="" W !,"Negative amounts are not valid entries for detailed daily records.",$C(7) Q
 . I $D(Y),Y']"" K DIRUT Q
 . Q:$D(DIRUT)  S FLD=Y
 . I PRCERD(NUM)'=4 S (ZDY,DY)=(PRCERD(NUM))+6,DX=24 X IOXY S IOELALL="",$P(IOELALL," ",IOM)="" W IOELALL S DX=24,DY=ZDY X IOXY W IOINHI,$S(PRCERD(NUM)'=1:FLD,1:"$"_$J((FLD/-1),12,2)),IOINLOW
 . I PRCERD(NUM)=4 F X=1:1:4 S DY=10+X,DX=24 X IOXY W IOELALL
 . I PRCERD(NUM)=4 S DY=11,DX=24 X IOXY W IOINHI,$E(FLD,1,55),?24,$E(FLD,56,101),!,?24,$E(FLD,102,157),!,?24,$E(FLD,158,213),!,?24,$E(FLD,241,245) W IOINLOW
 . S DR=$S(PRCERD(NUM)=1:.03,PRCERD(NUM)=2:.06,PRCERD(NUM)=3:.08,1:1.1)_"////^S X=FLD"
 . S DIE="^PRC(424.1,",DA=DRDA D ^DIE
 . S DR="",FLG=1
 Q:'FLG  S DA=DRDA,DIE="^PRC(424.1,"
 D NOW^%DTC S TIME=$E(%,1,12) S DIE="^PRC(424.1,",DR=".04////^S X=TIME;.1////^S X=DUZ" D ^DIE
 H 3 D SCR W !!,"Press 'RETURN' to continue" R X:DTIME Q
CLR W IOEDEOP Q
 ;
AMT ;Check for completed authorization and amount of change
 S PRCADJ=0,(AAMT,AAMT2)=X Q:X<0  S AUDA=$P($G(^PRC(424.1,DRDA,0)),U,2),AUDA0=$G(^PRC(424,+AUDA,0)),ABAL=$P(AUDA0,U,5),AAMT1=$P(^PRC(424.1,DRDA,0),U,3)/-1 Q:'AUDA
 S AAMT=$S((AAMT>AAMT1):AAMT-AAMT1,(AAMT<AAMT1):(AAMT1-AAMT),1:AAMT)
 S PODA=$P($G(^PRC(424,AUDA,0)),U,2),BAL=$$BAL^PRCH58(PODA) D NOW^%DTC S TIME=% D:BAL BUL^PRCEAU0
 I AAMT2>AAMT1 S ABAL=$P($G(^PRC(424,AUDA,0)),U,5) D  Q
 . I AAMT>ABAL D AMTOVR^PRCEDRE0 D  Q:PRCADJ
 .. D SCR Q:'PRCADJ
 .. S Y=""
 . S $P(^PRC(424,AUDA,0),U,5)=$P(^PRC(424,AUDA,0),U,5)-AAMT
 I AAMT2<AAMT1 S $P(^PRC(424,AUDA,0),U,5)=ABAL+AAMT Q
 K:AAMT2=AAMT1 X
 Q
 ;
