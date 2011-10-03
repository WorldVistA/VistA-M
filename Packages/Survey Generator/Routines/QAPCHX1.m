QAPCHX1 ;557/THM-EDITING OF ANSWERS [ 07/12/95  7:11 AM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
 ;called from QAPEDI1
 ;
USINPT ;multiple choice
 K ANS,QANS,STOP
 S ANSTYPE=$P(^QA(748.25,SURVEY,1,QNAME,0),U,3),GRADIENT=$P(^(0),U,4)
 S INSERT=$S(ANSTYPE="a":"letter",1:"number"),CNTA=0
 I "^a^n^"[ANSTYPE F QANS=0:0 S QANS=$O(^QA(748.25,SURVEY,1,QNAME,3,QANS)) Q:QANS=""!(+QANS=0)  S CNTA=CNTA+1,ANS($S(ANSTYPE="a":$C(CNTA+96),1:CNTA))=$P(^QA(748.25,SURVEY,1,QNAME,3,QANS,0),U)
 ;Likert scale
 I ANSTYPE="l" D LIKRTLAB^QAPCHX K QANS
 ;
DIS I ANSTYPE'="l" W !! DO
 .S (X,Y,CNTA)=0 F  S X=$O(ANS(X)) Q:X=""  S CNTA=CNTA+1 ;count answers
 .S REM=CNTA#2,CNTA=(CNTA\2)+REM
 .F XX=1:1:CNTA S X=XX S:ANSTYPE="a" X=$C(X+96) W X,". ",ANS(X) S:ANSTYPE="a" X=$C($A(X)+CNTA) S:ANSTYPE'="a" X=X+CNTA W:$D(ANS(X)) ?40,X,". ",ANS(X),!
 I $D(REM),REM>0 W !
 ;
A1 S DA(1)=FILEDA,PRESPON=$P(^QA(748.3,DA(1),1,QUES,0),U,2)
 S:PRESPON=" " PRESPON="Question skipped"
 W !?5,"Previous response: ",PRESPON,! S QLINE=$S(ACTION="I":$Y+1,1:$Y) W !
A1A W ?5,"Enter the ",INSERT," of your response: "_$S(PRESPON["skipped":"",1:PRESPON_"// ")
 R ANSW:DTIME S:'$T STOP=1 S:ANSW[U QAPOUT=1 Q:QAPOUT=1!($D(STOP))
 I ANSTYPE="a" S ANSW=$TR(ANSW,"ABCDEFGHIJKLMNOPQRSTUVWXYZ ","abcdefghijklmnopqrstuvwxyz")
 I ANSW="" Q
 I '$D(ANS(ANSW)) W *7,!!,"You must enter a ",$S(ANSTYPE="a":"letter",1:"number")," from the selection given.   " H 2 X CLEOP1 G A1A
 ;
A2 K DR S (DIC,DIE)="^QA(748.3,DA(1),1,",DA=QUES,DIC(0)="NM",DR="1////"_ANSW D ^DIE
 K ANS,ANSW,INSERT,DIC,DIE,X
 Q
 ;
QAYN ;yes/no/na
 K STOP S DA(1)=FILEDA W !! S PRESPON=$P(^QA(748.3,DA(1),1,QUES,0),U,2)
 S PRESPON=$S(PRESPON="Y":"Yes",PRESPON="N":"No",PRESPON="NA":"Not applicable",1:"Question skipped")
 W ?5,"Previous response: ",PRESPON,! S QLINE=$S(ACTION="I":$Y+1,1:$Y) W !
 ;
QAYNA W ?5,"Enter Yes, No, or Not applicable (Y/N/NA): "_$S(PRESPON["skipped":"",1:PRESPON_"// ") R ANSW:DTIME S:'$T STOP=1 S:ANSW[U QAPOUT=1 Q:QAPOUT=1!($D(STOP))
 S ANSW=$TR(ANSW,"any ","ANY"),ANSW=$E(ANSW,1,2)
 I ANSW="" Q
 I ANSW'="N",ANSW'="Y",ANSW'="NA" W *7 W !!,"Enter Y for Yes or N for No or NA for not applicable. " H 2 X CLEOP1 G QAYNA
 ;
B2 K DR S DA(1)=FILEDA,(DIC,DIE)="^QA(748.3,DA(1),1,",DA=QUES,DIC(0)="NM",DR="1////"_ANSW D ^DIE
 K ANSW,DIC,DIE,X
 Q
 ;
QATF ;true/false/na
 K STOP S DA(1)=FILEDA W !! S PRESPON=$P(^QA(748.3,DA(1),1,QUES,0),U,2)
 S PRESPON=$S(PRESPON="T":"True",PRESPON="NA":"Not applicable",PRESPON="F":"False",1:"Question skipped")
 W ?5,"Previous response: ",PRESPON,! S QLINE=$S(ACTION="I":$Y+1,1:$Y) W !
 ;
QATFA W ?10,"True, False, or NA (T/F/NA): "_$S(PRESPON["skipped":"",1:PRESPON_"// ")
 R ANSW:DTIME S:'$T STOP=1 S:ANSW[U QAPOUT=1 Q:QAPOUT=1!($D(STOP))
 S ANSW=$TR(ANSW,"anft ","ANFT"),ANSW=$E(ANSW,1,2)
 I ANSW="" S ANSW=" " Q
 I ANSW'="T",ANSW'="F",ANSW'="NA" W *7,!!,"Enter T for True, F for False, or NA for not applicable." H 2 X CLEOP1 G QATFA
 ;
 ;file answer
C2 K DR S DA(1)=FILEDA,(DIC,DIE)="^QA(748.3,DA(1),1,",DA=QUES,DIC(0)="NM",DR="1////"_ANSW D ^DIE
 K ANSW,DIC,DIE,X
 Q
 ;
WP ;wp response
 S QAPEDTR=$P($G(^VA(200,+DUZ,1)),U,5),QAPEDTR=$S(QAPEDTR=2:"SCREENMAN",1:"LINE EDITOR") ;see which wp editor they use
 W !! S QLINE=$Y
WP1 W "This will be a word processing response.",!!,"Press RETURN to enter a response,",!?6,"^ to skip response entry or Q to QUIT    RETURN// " R ANS:DTIME I '$T S QAPOUT=1 Q
 I ANS["?" X CLEOP1 W " ^ will skip entering any response to this question",!," RETURN will allow you to enter a response",!," Q will allow you to abort or suspend",!!,"Press RETURN  " R ANS:DTIME S:'$T QAPOUT=1 Q:'$T  X CLEOP1 G WP1
 I ANS[U Q
 S ANS=$TR(ANS,"q","Q") I ANS="Q" S QAPOUT=1 Q
 I QAPEDTR'["SCREENMAN" W @IOF,!
 K DR S DA(1)=FILEDA,(DIC,DIE)="^QA(748.3,DA(1),1,",DA=QUES,DIC(0)="NM",DR=2 D ^DIE
 K DIC,DIE,X,QAPEDTR
 W @IOF,! X QAPBAR
 Q
