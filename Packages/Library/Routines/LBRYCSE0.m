LBRYCSE0 ;ISC2/DJM-COPY SPECIFIC EDITING ;[ 06/03/97  4:16 PM ]
 ;;2.5;Library;**2**;Mar 11, 1996
START F I=1:1:3 S LS(I)=""
 I $D(A(1)) S LS(1)=", (E)dit, (R)emove"
 S:$D(A(E0-1)) LS(2)=", (B)ackup"
 S:$D(A(E1+1)) LS(3)=", (F)orward"
 S LINE="Choose: (I)nsert"_LS(1)_LS(2)_LS(3)_"."
 W !!,LINE,"  Exit// "
ASK S DTOUT=0 R X:DTIME E  W $C(7) S DTOUT=1 G ^LBRYCSE
 I X="" G ^LBRYCSE
 I X=" " S:$D(^TMP("LBRY",DUZ,7)) X=^(7)
 I X="??" S XQH="LBRY CSE CHOICE PROMPT" D EN^XQH G CONT^LBRYCSE
 I X="^" G ^LBRYCSE
 I $L(X)=2,"Bb"[$E(X,1),"?"[$E(X,2) D  G PAS
 . W !,"You may BACKUP to any 'ID NUM' before the lowest one on the screen."
 I $L(X)=2,"Ff"[$E(X,1),"?"[$E(X,2) D  G PAS
 . W !,"You may go FORWARD to any 'ID NUM' including the lowest one on the screen."
 I $D(A(E0-1)),"Bb"[$E(X,1) D UTIL,BACKUP^LBRYCK0 G CONT^LBRYCSE
 I $D(A(E1+1)),"Ff"[$E(X,1) D UTIL,FORWARD^LBRYCK0 G CONT^LBRYCSE
 I "Rr"[$E(X,1) D UTIL S X=$E(X,2,999) D REMOVE^LBRYCSE G:$G(DTOUT) KILL D CON^LBRYCSE S LBUDT=1 G CONT^LBRYCSE
 I "Ee"[$E(X,1) D UTIL S X=$E(X,2,999) D QUERY^LBRYCSE G:'$D(YDT) KILL G CONT^LBRYCSE
 I "Ii"[$E(X,1),$L(X)>1,$E(X,2)'="?" D  G PAS
 . W !,"You may only add a '?' to an 'I' choice."
 I "Ii"[$E(X,1) D UTIL S X=$E(X,2) D ENTER^LBRYCSE G:'$D(YDT) KILL D CON^LBRYCSE G CONT^LBRYCSE
 W !!,"You can select I, E, R, B or F if they are in the above prompt."
 W !,"You may enter a '?' after any choice for help.  Enter '??' for more help."
PAS S XZ="Continue// " D PAUSE^LBRYUTL K XZ
 G CONT^LBRYCSE
UTIL K ^TMP("LBRY",DUZ,7) S ^(7)=X Q
UDT NEW I S (COPY,TOTAL,CO681)=0,LBCLS=D0
 F  S COPY=$O(^LBRY(681,"AC",LBCLS,COPY)) Q:COPY'>0  D
 . S COPY1=0 F  S COPY1=$O(^LBRY(681,"AC",LBCLS,COPY,COPY1)) Q:COPY1'>0  D
 . . S COPY2=$G(^LBRY(681,COPY1,1)),START=$P(COPY2,U,10),STOP=$P(COPY2,U,11)
 . . I START="",STOP="" S CO681=CO681+1 Q
 . . I START]"",STOP="",START-DT<1 S CO681=CO681+1 Q
 . . I START="",STOP]"",STOP-DT'<0 S CO681=CO681+1 Q
 . . I START]"",STOP]"",START-DT<1,STOP-DT'<0 S CO681=CO681+1
FINI S:($G(CO681))=0 CO681="" S X=CO681
KILL K COPY,COPY1,COPY2,I,LS,LBCLS,LBUDT,LINE,TOTAL,XQH,START,STOP,CO681
 Q
