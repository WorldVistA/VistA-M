QAPEDI1 ;557/THM-EDIT ALL/PART OF SURVEY ANSWERS [ 07/12/95  11:56 AM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
 ;called from QAPSCRN
 ;
EN K EDIT S QAPOUT=0 W @IOF,! S QAPHDR="Edit Survey Answers" X QAPBAR
 S TITLE=$P(^QA(748,SURVEY,0),U,6) K DIR,OUT,Y
 S DIR("?",1)="       E to edit all (including demographics)"
 S DIR("?",2)="       I to edit individual questions (no demographics)"
 S DIR("?",3)="       P to print a copy of your answers for yourself"
 S DIR("?")="       Q to QUIT (also '^' or <RETURN>)"
 W !!! S DIR("A")="Selection",DIR(0)="SO^E:Edit All Questions (including demographics);I:Edit Individual Questions (no demographics);P:Print a copy for yourself;Q:Quit (also uparrow or <RETURN>)"
 D ^DIR S:$D(DTOUT) STOP=1 G:$D(DTOUT) ABORT^QAPSCRN1 G:$D(DIRUT) EXIT S ACTION=X
 S ACTION=$TR(ACTION,"eipq","EIPQ")
 I ACTION="Q" G EXIT
 I ACTION="I" G INDIV
 I ACTION="E" G EDITALL
 I ACTION="P" S USERPRT=1,%ZIS="AEQ" W !! D ^%ZIS G:POP EN
 I ACTION="P",$D(IO("Q")) S ZTREQ="@",ZTIO=ION,ZTRTN="USERPRT^QAPPT1",ZTDESC="Survey Printing for user "_DUZ F X="SURVEY","FILEDA","USERPRT" S ZTSAVE(X)=""
 I ACTION="P",$D(IO("Q")) D ^%ZTLOAD W:$D(ZTSK) !!,"Queued as task #",ZTSK,!! H 2 D ^%ZISC G EN
 I ACTION="P" D USERPRT^QAPPT1,^%ZISC
 G EN
 ;
INDIV K DANS F I=0:0 S I=$O(^QA(748.25,"E",SURVEY,I)) Q:I=""  F J=0:0 S J=$O(^QA(748.25,"E",SURVEY,I,J)) Q:J=""  S DANS(I,J)=I,DANS(I)=I,CNT=I
 I $D(QAPCNT),'$D(QNUMANS) S QNUMANS=QAPCNT
 F I=QNUMANS+1:1:CNT K DANS(I)
 Q:$D(EDIT)
 I ACTION="I" S QAPOUT=0 DO  G:QAPOUT=1 EN G:$D(OUT) EN D:$D(STOP) ABORT^QAPSCRN1 G:$D(STOP) EXIT
DIS .K QDIS,STOP
 .W @IOF,! S QAPHDR="Survey Title: "_TITLE X QAPBAR S QAPHDR="Editing Individual Questions" X QAPBAR
 .W !,">> Question number: " R QUESED:DTIME S:'$T STOP=1 Q:$D(STOP)  I QUESED=""!(QUESED[U) S QAPOUT=1 Q
 .I QUESED="?" D HELPLK^QAPUTIL1 Q:$D(STOP)  G:QUESED="" DIS I QAPQN]"" S (QUESED,QDIS)=ANSX W @IOF,! S QAPHDR="Survey Title: "_TITLE X QAPBAR
 .I QUESED?2.99"?" W !!,"Entry must be numeric, greater than zero and previously answered." H 3 G DIS
 .I QUESED["?",'$D(QDIS) G DIS
 .I QUESED]"" S QDIS=QUESED S QAPHDR="Editing Individual Questions"  X CLEOP W !,">> Question number: ",QDIS K ANSX
 .I QUESED'?1.3N,QUESED'?1.3N1"."1.3N,+QUESED>0 W !!,"Question entry must be numeric.",*7 H 2 G DIS
 .S QUESED=+$G(DANS(QUESED)),QNAME=$O(^QA(748.25,"E",SURVEY,+QUESED,0)) I +QNAME>0 S QNAME=$P(^QA(748.25,SURVEY,1,QNAME,0),U)
 .I +QNAME=0 W !!,*7,"That question was not found.  The question must be",!,"numeric, greater than zero, and already answered.",!! W !!,"Press RETURN  " R ANS:DTIME S:'$T STOP=1 S:ANS[U QAPOUT=1 Q:QAPOUT=1!($D(STOP))  G DIS
 .S QUES=+$O(^QA(748.3,FILEDA,1,"B",QNAME,0))
 .S QUEST=QNAME W !! D HDIS Q:$D(STOP)
 .W @IOF,! S QAPHDR="Survey Title: "_TITLE X QAPBAR S QAPHDR="Editing Individual Questions" X QAPBAR  W !
 .F I=0:0 S I=$O(^QA(748.25,SURVEY,1,QNAME,2,I)) Q:I=""!(+I=0)  S X=$P(^QA(748.25,SURVEY,1,QNAME,2,I,0),U,1) W X,!
 .S QAPX=$P(^QA(748.25,SURVEY,1,QNAME,1),U) D USINPT^QAPCHX1:QAPX="m",QATF^QAPCHX1:QAPX="t",QAYN^QAPCHX1:QAPX="y",WP^QAPCHX1:QAPX="w" Q:QAPOUT!$D(STOP)
 G INDIV
 ;
EDITALL S EDIT=1 K STOP
 D INDIV,^QAPDEM1 G:QAPOUT=1 EN D:$D(STOP)!($D(DSTOP)) ABORT^QAPSCRN1 G:$D(STOP)!($D(DSTOP)) EXIT S QAPOUT=0
 F QAPQN=0:0 S QAPQN=$O(DANS(QAPQN)) Q:QAPQN=""!(QAPOUT=1)!($D(STOP))  F QUEST=0:0 S QUEST=$O(DANS(QAPQN,QUEST)) Q:QUEST=""  DO  I QAPOUT=1!($D(STOP)) S QUEST=999
 .D HDIS Q:$D(STOP)
 .S QAPHDR="Survey Title: "_TITLE W @IOF,! X QAPBAR S QAPHDR="Edit All Questions Sequentially" X QAPBAR W !
 .W ">> Question number: ",QAPQN,!! S QNAME=QUEST
 .S QUES=$O(^QA(748.3,FILEDA,1,"B",QUEST,0)) Q:QUES=""
 .F I=0:0 S I=$O(^QA(748.25,SURVEY,1,QNAME,2,I)) Q:I=""!(+I=0)  S X=$P(^QA(748.25,SURVEY,1,QNAME,2,I,0),U,1) W X,!
 .S QAPX=$P(^QA(748.25,SURVEY,1,QNAME,1),U) D USINPT^QAPCHX1:QAPX="m",QATF^QAPCHX1:QAPX="t",QAYN^QAPCHX1:QAPX="y",WP^QAPCHX1:QAPX="w" I QAPOUT=1!('$T) Q
 .;I $O(DANS(QAPQN))]"" W @IOF,! S QAPHDR="Survey Title: "_TITLE X QAPBAR S QAPHDR="Edit All Questions Sequentially" X QAPBAR,CLEOP
 I $D(STOP) D ABORT^QAPSCRN1 G EXIT
 K EDIT G EN
 ;
EXIT K ANS,ANSTYPE,ANSW,DR,DX,DY,GRADIENT,PRESPON,QUESED,QDIS,QNAME,USERPRT
 Q  ;kill other variables in calling program
 ;
HDIS X CLEOP I $O(^QA(748.25,SURVEY,1,QUEST,4,0))]""  F I=0:0 S I=$O(^QA(748.25,SURVEY,1,QUEST,4,I)) D:I=""!(+I=0)  Q:I=""!(+I=0)  S X=$P(^QA(748.25,SURVEY,1,QUEST,4,I,0),U,1) W X,!
 I $O(^QA(748.25,SURVEY,1,QUEST,4,0))]"" W *7,!!,"Press RETURN  " R ANS:DTIME S:'$T STOP=1 Q:$D(STOP)  W @IOF,! S QAPHDR="Survey Title: "_TITLE X QAPBAR S QAPHDR="Editing Individual Questions" X QAPBAR,CLEOP
 Q
 ;
DOC ;QDIS=question display # user sees
 ;QUESED=question selected by user
 ;QNAME=actual question pointer in 748.25
 ;QUES=question in response file, for QAPCHX1
 ;DANS()=array of answers on completed survey that a user can select
 ;       to edit.
