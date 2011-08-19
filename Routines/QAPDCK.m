QAPDCK ;557/THM-INPUT TRANSFORM CHECKS [ 03/04/95  6:53 AM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
EN1 ;field .015 in 748.26
 ;see if question number exists
 N %X,%Y,CURNUM S SURVEY=$S($D(SURVEY):SURVEY,1:DA(1))
 S CURNUM=$P($G(^QA(748.25,SURVEY,1,DA,0)),U,2) Q:+CURNUM=X  ;no change
 I $D(^QA(748.25,"E",SURVEY,X)) W !!,*7,"That number already exists.",! H 1 K X Q
 ;verifiy the change of question number
 I CURNUM]"",CURNUM'=X DO
 .W *7,!!,"You are about the change the number of this question.",!,"Is that what you want to do",*7 S %=2 D YN^DICN I %'=1 K X
 .W !!
 .K %,%Y,CURNUM
 Q
