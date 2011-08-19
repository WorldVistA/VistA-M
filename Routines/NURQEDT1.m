NURQEDT1 ;HIRMFO/MH,RM,YH-EDIT QI SUMMARY (#217) FILE ;1/22/97  15:28
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
EN8 ; Entry from the Edit All QI Summary Data [NURQA-PT-ALL] option.
 Q:'$$SURGENVR^NURQUTL1(2,1)
 D EDTCOMM^NURQEDT0(0) S NURQSDA=DA
 I DA>0 D
 .  D E5^NURQEDT0 Q:NURQOUT
 .  D E3^NURQEDT0 Q:NURQOUT
 .  S DA(1)=DA D E2^NURQEDT0 Q:NURQOUT  K DA S DA=NURQSDA
 .  D E7^NURQEDT0 Q:NURQOUT
 .  D E8^NURQEDT0 Q:NURQOUT
 .  S NURQSDA(1)=NURQSDA,NURQSDA=$$GETLOC^NURQEDT0(NURQSDA(1))
 .  Q:NURQSDA'>0  K DA M DA=NURQSDA
 .  D E1^NURQEDT0 Q:NURQOUT
 .  S DA(2)=DA(1),DA(1)=DA D RELIND
 .  Q
 D Q^NURQEDT0
 Q
RELIND ; Edit Performance Measure data.
 ;  Input Variables: DA(2)=survey IEN in file 217.
 ;                   DA(1)=location IEN in 217.04.
 ;
 S NURQDA(2)=DA(2),NURQDA(1)=DA(1)
 I DA(2)'>0 W !,"CANNOT EDIT PERFORMANCE MEASURE.",!! G QRI
 K ^TMP("DILIST",$J) D LIST^DIC(748.26,","_DA(2)_",","","",1)
 I +$G(^TMP("DILIST",$J,0))'>0 D  G QRI
 .  W !!,"For PERFORMANCE MEASURE: You have to complete the questions for this",!,"particular survey in the QA QUESTIONS FILE ^QA(748.25).",!!
 .  Q
REASK ; Jump back here to ask for another Performance Measure.
 S NURQOUT=0,(NURQDA,Y)=$$PERFORM^NURQUTL(NURQDA(2),NURQDA(1)) G:+Y'>0 QRI
 K NURQFDA,NURQIEN S NURQFDA(217.43,"?+1,"_NURQDA(1)_","_NURQDA(2)_",",.01)="QA(748.25,"_NURQDA(2)_",1,"_+Y_","
 D UPDATE^DIE("","NURQFDA","NURQIEN") S NURQDA=+NURQIEN(1) K NURQIEN
 S NURDFLT="" K DA M DA=NURQDA S DIE="^NURQ(217,"_DA(2)_",2,"_DA(1)_",3,",DR=".01" D ^DIE K DIE,DR I $D(Y) S NURQOUT=1 G QRI
 I '$D(^NURQ(217,NURQDA(2),2,NURQDA(1),3,NURQDA,0)) G REASK
 S DIE="^NURQ(217,"_DA(2)_",2,"_DA(1)_",3,",DR="5;5.5" D ^DIE K DIE,DIC,DR I $D(Y) S NURQOUT=1 G QRI
RLIC ; edit Rationale, method of determining variance, conclusion,
 ; recommendation/action, person/group taking action, date of
 ; implemented, and effectiveness of action taken
 K DA S DA(3)=NURQDA(2),DA(2)=NURQDA(1),DA(1)=NURQDA
 M DA=NURQDA S DIE="^NURQ(217,"_DA(2)_",2,"_DA(1)_",3,"
 S DR="1;8;9.5;10;11;13;19"
 D ^DIE K DIE,DA,DR I '$D(Y) G REASK
 S NURQOUT=1
QRI ; Exit RELIND and clean up.
 K NURFLAG,NURQ1ST,NURQSEQ,^TMP("DILIST",$J),DIROUT,DTOUT,DUOUT,NURDFLT,NURQ,NURQDA,X,Y
 Q
