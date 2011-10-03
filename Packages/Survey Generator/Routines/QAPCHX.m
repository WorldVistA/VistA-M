QAPCHX ;557/THM-INPUT OF ANSWERS [ 06/22/95  8:14 AM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;called by OUT3^QAPSCRN
 ;
USINPT ;multiple choice
 K ANS
 S ANSTYPE=$P(^QA(748.25,SURVEY,1,QUES,0),U,3),GRADIENT=$P(^(0),U,4)
 S INSERT=$S(ANSTYPE="a":"letter",1:"number"),CNTA=0
 I "^a^n^"[ANSTYPE F QANS=0:0 S QANS=$O(^QA(748.25,SURVEY,1,QUES,3,QANS)) Q:QANS=""!(+QANS=0)  S CNTA=CNTA+1,ANS($S(ANSTYPE="a":$C(CNTA+96),1:CNTA))=$P(^QA(748.25,SURVEY,1,QUES,3,QANS,0),U)
 ;Likert scale
 I ANSTYPE="l" K QANS,ANS D LIKRTLAB
 I ANSTYPE'="l" W !! DO
 .S (X,Y,CNTA)=0 F  S X=$O(ANS(X)) Q:X=""  S CNTA=CNTA+1 ;count answers
 .S REM=CNTA#2,CNTA=(CNTA\2)+REM
 .F XX=1:1:CNTA S X=XX S:ANSTYPE="a" X=$C(X+96) W X,". ",ANS(X) S:ANSTYPE="a" X=$C($A(X)+CNTA) S:ANSTYPE'="a" X=X+CNTA W:$D(ANS(X)) ?40,X,". ",ANS(X),!
 I $D(REM),REM>0 W !
 ;
A1 D FILE W !! S QLINE=$Y
A1A W ?10,"Enter the ",INSERT," of your response: "
 R ANSW:DTIME I '$T!(ANSW[U) S QAPOUT=1 Q
 I ANSTYPE="a" S ANSW=$TR(ANSW,"ABCDEFGHIJKLMNOPQRSTUVWXYZ ","abcdefghijklmnopqrstuvwxyz")
 I ANSW="" S ANSW=" " X MSSG0 H 1 G A2
 I '$D(ANS(ANSW)) W *7,!!,"You must enter a ",$S(ANSTYPE="a":"letter",1:"number")," from the selection given.   " H 2 X CLEOP1 W ! G A1A
 ;file answer
A2 S (DIC,DIE)="^QA(748.3,DA(1),1,",X=QUES,DIC(0)="LM",DIC("DR")="1////"_ANSW K DO,DD D FILE^DICN
 K ANS,ANSW,INSERT,DIC,DIE,X,DX,DY,QLINE,QANS,ANSTYPE,GRADIENT,XCOL
 Q
 ;
QAYN ;yes/no/na
 D FILE W !! S QLINE=$Y
 ;
QAYNA W ?5,"Enter Yes, No, or Not applicable (Y/N/NA): " R ANSW:DTIME I '$T!(ANSW[U) S QAPOUT=1 Q
 S ANSW=$TR(ANSW,"any ","ANY"),ANSW=$E(ANSW,1,2)
 I ANSW="" S ANSW=" " X MSSG0 H 1 G B2
 I ANSW'="N",ANSW'="Y",ANSW'="NA" W *7 W !!,"Enter Y for Yes or N for No or NA for not applicable. " H 2 X CLEOP1 W ! G QAYNA
 ;file answer
 ;
B2 S (DIC,DIE)="^QA(748.3,DA(1),1,",X=QUES,DIC(0)="LM",DIC("DR")="1////"_ANSW K DO,DD D FILE^DICN
 K ANSW,DIC,DIE,X
 Q
 ;
QATF ;true/false/na
 D FILE W !! S QLINE=$Y
 ;
QATFA W ?10,"True, False, or Not applicable (T/F/NA): "
 R ANSW:DTIME I '$T!(ANSW[U) S QAPOUT=1 Q
 S ANSW=$TR(ANSW,"anft ","ANFT"),ANSW=$E(ANSW,1,2)
 I ANSW="" S ANSW=" " X MSSG0 H 1 G C2
 I ANSW'="T",ANSW'="F",ANSW'="NA" W *7,!!,"Enter T for True, F for False, or NA for not applicable." H 2 X CLEOP1 W ! G QATFA
 ;file answer
C2 S (DIC,DIE)="^QA(748.3,DA(1),1,",X=QUES,DIC(0)="LM",DIC("DR")="1////"_ANSW K DO,DD D FILE^DICN
 K ANSW,DIC,DIE,X
 Q
 ;
WP ;wp response
 D FILE S QAPEDTR=$P($G(^VA(200,+DUZ,1)),U,5),QAPEDTR=$S(QAPEDTR=2:"SCREENMAN",1:"LINE EDITOR") ;see which wp editor they use
 I $D(^QA(748.3,FILEDA,1,"B",QUES)) S (DIC,DIE)="^QA(748.3,DA(1),1,",DA=$O(^QA(748.3,FILEDA,1,"B",QUES,0))
 I '$D(^QA(748.3,FILEDA,1,"B",QUES)) S (DIC,DIE)="^QA(748.3,DA(1),1,",X=QUES,DIC(0)="LM" K DO,DD D FILE^DICN S DA=+Y
 W !! S QLINE=$Y
WP1 W "This will be a word processing response.",!!,"Press RETURN to enter a response,",!?6,"^ to skip response entry or Q to QUIT    RETURN// " R ANS:DTIME I '$T S QAPOUT=1 Q
 I ANS["?" X CLEOP1 W " ^ will skip entering any response to this question",!," RETURN will allow you to enter a response",!," Q will allow you to abort or suspend",!!,"Press RETURN  " R ANS:DTIME S:'$T QAPOUT=1 Q:'$T  X CLEOP1 G WP1
 I ANS[U Q
 S ANS=$TR(ANS,"q","Q") I ANS="Q" S QAPOUT=1 Q
 I ANS'="",ANS'="^" W *7,!!,"Invalid answer - must be Q, ^, or RETURN" H 3 X CLEOP1 W ! G WP1
 I QAPEDTR'["SCREENMAN" W @IOF,!
 S (DIC,DIE)="^QA(748.3,DA(1),1,",X=QUES,DIC(0)="LM",DR=2 D ^DIE
 K DIC,DIE,X,QAPEDTR
 Q
 ;
FILE K DA,DIC,DIE,X S DA=FILEDA I '$D(^QA(748.3,DA,1,0)) S ^QA(748.3,DA,1,0)="^748.31^^" ;question node for FILE^DICN
 S DA(1)=FILEDA
 Q
 ;
LIKRTLAB ;print Likert labels and gradient
 S LKDTA=$G(^QA(748.25,SURVEY,1,QUES,0))
 S LFTLBL=$P(LKDTA,U,5),RGTLBL=$P(LKDTA,U,6),LDIRECT=$P(LKDTA,U,7) S:LDIRECT="" LDIRECT="a" ;default
 S:LDIRECT="a" LDIRECT="F Y=1:1:GRADIENT" S:LDIRECT="d" LDIRECT="F Y=GRADIENT:-1:1" S LDIRECT=LDIRECT_" S X=X_Y_""   "",ANS(Y)="""""
 S:LFTLBL="" LFTLBL="Poor" S:RGTLBL="" RGTLBL="Excellent" ;default
 S X="("_LFTLBL_")   " X LDIRECT
 S X=X_"("_RGTLBL_")"
 W !!,?(IOM-($L(X))\2),X,!!
 K LKDTA,LDIRECT,X,Y
 Q
