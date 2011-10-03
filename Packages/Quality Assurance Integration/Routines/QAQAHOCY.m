QAQAHOCY ;HISC/DAD-AD HOC REPORTS: INTERFACE COMPILER ;7/12/95  14:57
 ;;1.7;QM Integration Module;;07/25/1995
 ;
 S (QAQMMAX,QAQSORT)=0,QAQLEVEL=1,QAQFILE(QAQLEVEL)=QAQFILE
FLD ; *** Process the sort/print fields
 W !!,"Choose a field for menu item number ",QAQMMAX+1,", <RETURN> to end, ^ to exit."
 W !,"Select ",$S(QAQLEVEL=1:"",1:$P(QAQFILE(QAQLEVEL-1),"^",3)_" SUB-"),"FIELD: " R X:DTIME S:'$T X="^" S QAQQUIT=$S($E(X)="^":1,1:0)
 I X="?",QAQMMAX D LIST G:QAQQUIT FLD W !
 K DIC S DIC="^DD("_+QAQFILE(QAQLEVEL)_",",DIC(0)="EMNQZ",DIC("W")="S QA=+$P(^(0),""^"",2) W:QA ""  "",$S($P(^DD(QA,.01,0),""^"",2)[""W"":""(word-processing)"",1:""(multiple)"")" D ^DIC
 I Y'>0 S:X="" QAQLEVEL=QAQLEVEL-1 G EXIT:'QAQLEVEL!QAQQUIT,FLD
 S QAQDD=Y(0),$P(QAQFILE(QAQLEVEL),"^",2,3)=+Y_"^"_$P(QAQDD,"^"),QAQWP=0 ; *** QAQFILE(Level#) = Dict # ^ Fld # ^ Fld Name
 I +$P(QAQDD,"^",2) S QAQWP=($P(^DD(+$P(QAQDD,"^",2),.01,0),"^",2)["W") I 'QAQWP S QAQLEVEL=QAQLEVEL+1,QAQFILE(QAQLEVEL)=+$P(QAQDD,"^",2) G FLD
 I $D(QAQCHOSN(QAQFILE(QAQLEVEL)))#2 W !!?5,"*** You have already chosen that field !! ***",*7 G FLD
 F QA=1:1:4 S QAQTEXT(QA)=""
NAME ; *** Prompt user for the external field name
 K DIR S DIR(0)="FOA^2:30^K:X[""^"" X",DIR("A")="Menu text the user should see: ",DIR("B")=$$CASE($P(QAQDD,"^")),DIR("?")="^D EN^QAQAHOCH(""H7"")"
 D ^DIR G:$D(DIRUT) FLD S QAQTEXT(2)=Y
SORT ; *** Allow sorting on this field (Y/N)
 G:QAQWP SETLINE ; *** Don't ask sort questions for WP fields
 S X=$P(QAQDD,"^",2),%=$S($P(QAQFILE(QAQLEVEL),"^",2)=.01:1,X["F":2,X["K":2,X["V":2,1:1)
 W !,"Want to allow sorting by ",QAQTEXT(2) D YN^DICN G:%=-1 FLD S QAQTEXT(1)=(%=1),QAQSORT=QAQSORT+QAQTEXT(1) I '% W !!?5,QAQYESNO,! G SORT
DIR ; *** Set up DIR(0) for sort from/to prompts
 S X=$P(QAQDD,"^",2)
 G NUMERIC:X["N",POINTER:X["P",SET:X["S",DATE:X["D",TEXT
DATE S QAQTEXT(4)="DAO^::AETS^D DATE^QAQAHOC2" G SETLINE
NUMERIC S QAQTEXT(4)="NAO^-999999999:999999999:9^" G SETLINE
POINTER S QA=$P(QAQDD,"^",2),QA=$TR(QA,$TR(QA,".0123456789"))
 S QAQTEXT(4)="PAO^"_QA_":AEMNQZ^D POINTER^QAQAHOC2" G SETLINE
SET S QAQTEXT(4)="SAO^"_$P(QAQDD,"^",3)_"^D SET^QAQAHOC2" G SETLINE
TEXT S QAQTEXT(4)="FAO^1:60^"
SETLINE ; *** Save menu $TEXT line in ^TMP
 F QA=1:1:QAQLEVEL S QAQTEXT(3)=QAQTEXT(3)_$S(QA=QAQLEVEL:"~",1:"")_$P(QAQFILE(QA),"^",2)_$S(QA'=QAQLEVEL:",",1:$S(QAQTEXT(2)'=$P(QAQFILE(QA),"^",3):";"""_$TR(QAQTEXT(2),",;^~","    ")_"""",1:""))
 S Y=7+$L(QAQTEXT(2))+$L(QAQTEXT(3))+$L(QAQTEXT(4))-245 I Y>0 W !!?5,"*** This line is ",Y," character",$S(Y>1:"s",1:"")," too long, maximum is 245 !! ***",*7 G FLD
 S QAQMMAX=QAQMMAX+1,QAQCHOSN(QAQFILE(QAQLEVEL))=""
 S ^TMP($J,"QAQTXT",1000+QAQMMAX,0)=" ;;"_+QAQTEXT(1)_"^"_QAQTEXT(2)_"^"_QAQTEXT(3)_"^"_QAQTEXT(4)
 G FLD
EXIT ; *** Exit field questions loop
 Q
LIST ; *** Display the fields already chosen
 N X W !!,"You have already selected the following:  (Menu Item #   Menu Text)",! S QAQ=$Y,QAQMMAX(0)=QAQMMAX#2+QAQMMAX\2
 F QA=1001:1:QAQMMAX(0)+1000 S QAI=QA,QAQTAB=0 D  S QAI=QA+QAQMMAX(0),QAQTAB=40 D  I ($Y>(IOSL+QAQ-4))!(QAQMMAX(0)+1000=QA) S QAQ=$Y K DIR S DIR(0)="E" D ^DIR K DIR S QAQQUIT=$S(Y'>0:1,1:0) Q:QAQQUIT
 . S X=$P($G(^TMP($J,"QAQTXT",QAI,0)),";;",2,99)
 . Q:X=""  W:QAQTAB=0 !
 . W ?QAQTAB,$S($P(X,"^"):$J(QAI-1000,2),1:"  "),"   ",$P(X,"^",2)
 . Q
 Q
CASE(QAQ)          ; *** Convert text to initial capital letters
 N X,QA S X="" F QA=1:1:$L(QAQ) S X(0)=$E(QAQ,QA-1),X(1)=$E(QAQ,QA),X=X_$S(X(0)?.1P:$$U(X(1)),X(0)?1U:$$L(X(1)),X(1)?1U:$$L(X(1)),1:X(1))
 Q X
U(X) Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
L(X) Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
