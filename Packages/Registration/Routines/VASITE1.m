VASITE1 ;ALB/AAS - LOAD VASITE FILE WITH DATA ; 10-FEB-92
 ;;5.3;Registration;;Aug 13, 1993
 ;
% S:'$D(DTIME) DTIME=300 S U="^"
 ;  -load file 389.9
 Q:$O(^VA(389.9,0))
 ;D:'$D(VAPRIM) PRIM
 W !!,"<<< Updating Time Sensitive Station Number file for all Medical Center divisions",!
 S (VADIV,VACNT)=0 F  S VADIV=$O(^DG(40.8,VADIV)) Q:'VADIV  I '$D(VA(389.9,"C",VADIV)) D
 .S VASITE=$P($G(^DG(40.8,VADIV,0)),U,2) I VASITE="" S VASITE=$P($G(^DIC(4,$P(^DG(40.8,VADIV,0),U,7),99)),U)
 .I VASITE'?3N.AN W !!,"Division ",$P(^DG(40.8,VADIV,0),"^")," has station number in incorrect format",!,"and can't be added to file.  Use the option 'Station Number (Time Sensitive)",!,"Enter/Edit' to complete entry." Q
 .K DD,DO
 .S VACNT=VACNT+1,X=VACNT,DIC(0)="L",DIC="^VA(389.9," D FILE^DICN Q:+Y<1  W ".."
 .S DA=+Y,DR=".02////2800101;.03////"_VADIV_";.04////"_VASITE S:VASITE=+VASITE&('$D(VAPRIM)) DR=DR_";.05////1;",VAPRIM=1 S DIE="^VA(389.9,"
 .D ^DIE
 .K DIC,DIE,DA,DR
 .Q
 Q
 ;
PRIM S DIR(0)="N^.5:1.5:4",DIR("A")="PRIMARY DIVISION"
 S DIR("A",1)="If you know your stations PRIMARY DIVISION, you may"
 S DIR("A",2)="enter it now.  If not it can be entered at a later time."
 S DIR("A",3)="However, it must be entered before the Billing software is used.",DIR("A",4)="  "
 D ^DIR K DIR Q:$D(DIRUT)
 I +Y S VAPRIM=+Y
 Q
 ;
NEW ; -- add new entry to time sensitive file when adding a new division
 ;     input: VASITE("NEW")=Y (after adding new entry)
 ;                         =internal number in 40.8^name^1
 ; -- called from DGPAR1
 ;
 N X,Y,DO,DD,DIC,DIE,DA,DR,DINUM S Y=VASITE("NEW")
 S VASITE("OK")=0
 G:'Y!('$P(Y,"^",3)) NEWQ
 S VADIV=+Y I $D(^VA(389.9,"C",VADIV)) G NEWQ ;not a new entry.
 ;
 S VASITE=$P($G(^DG(40.8,VADIV,0)),U,2) I VASITE="" S VASITE=$P($G(^DIC(4,$P(^DG(40.8,VADIV,0),U,7),99)),U) I VASITE="" G NEWQ ;no station number or facility entered
 ;
 I VASITE'?3N.AN S $P(VASITE("OK"),"^",2)="Division "_$P(^DG(40.8,VADIV,0),"^")_" has station number in incorrect format." G NEWQ
 ;
ADD ;  -add new entry
 ;
 L +^VA(389.9,0):10 I '$T S $P(VASITE("OK"),"^",2)="Another user appears to be adding an entry" G NEWQ
 S X=$P($G(^VA(389.9,0)),"^",3)
 L -^VA(389.9,0)
 K DD,DO,DIC,DR S DLAYGO=389.9,DIC(0)="L",DIC="^VA(389.9,"
 ;
 F X=X:1 L:$D(VAIEN) -^VA(389.9,VAIEN) I X>0,'$D(^VA(389.9,X)) S VAIEN=X L +^VA(389.9,X,0) I $T,'$D(^VA(389.9,X,0)) S DINUM=X D FILE^DICN I +Y>0 D  Q
 .S VASITE("OK")=1
 ;
EDIT ;
 S DA=+Y,DR=".02////"_DT_";.03////"_VADIV_";.04////"_VASITE,DIE="^VA(389.9,"
 D ^DIE
 ;
NEWQ ;
 I '+VASITE("OK") D
 .W !!?5,">>> An unsuccessful attempt was made to also add a new entry to"
 .W !?5,"    STATION NUMBER (TIME SENSITIVE) [#389.9] file for this division."
 .I $P(VASITE("OK"),U,2)]"" W !?5,"    *** ",$P(VASITE("OK"),U,2)," ***"
 .W !!?5,">>> Please contact your IRM service after entering division data.",!,*7
 K VAIEN,VASITE,VADIV
 Q
