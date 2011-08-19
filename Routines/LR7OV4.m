LR7OV4 ;DALOI/DCM/RLM-Immediate Lab Collect Utilities ;12/18/97 08:35
 ;;5.2;LAB SERVICE;**187,256,272**;Sep 27, 1994
ON(DIV) ;Check Immediate Collect parameter is on
 ;DIV=DUZ(2) division pointer
 Q:'$G(DIV) 0
 Q:'$L($G(^LAB(69.9,1,7,DIV,0))) 0
 Q:'$L($O(^LAB(69.9,1,7,DIV,0))) 0
 Q +$P($G(^LAB(69.9,1,7,DIV,0)),"^",6)
SHOW(DIV,LIST) ;Show current settings in LIST array
 ;DIV=DUZ(2) division pointer
 ;LIST=where you want the text returned
 Q:'$G(DIV)
 N NODE,CTR,X,CTR,CCNT,I,X1,X2,X3,X4,SP,INC
 Q:'$G(^LAB(69.9,1,7,DIV,0))  S NODE=^(0)
 S CTR=0,CCNT=0
 S X=$S('$P(NODE,"^",2):"NO ",1:"")_"COLLECTION ON HOLIDAYS "
 S X=$$S^LR7OS(1,0,$J(X,48)),CTR=CTR+1,LIST(CTR)=X
 S CTR=CTR+1,LIST(CTR)=""
 F I="SUN","MON","TUE","WED","THU","FRI","SAT" D
 . I $D(^LAB(69.9,1,7,DIV,I)) S X=^(I) D
 .. S CTR=CTR+1,LIST(CTR)=$$S^LR7OS(1,0,I_" Collection Between: ")
 .. S X1=$E("0000",($L(+$P(X,U,2))+1),4)_$P(X,U,2)
 .. S X2=$E("0000",($L(+$P(X,U,3))+1),4)_$P(X,U,3)
 .. S X3=$E(X1,1,2)_":"_$E(X1,3,4)
 .. S X4=$E(X2,1,2)_":"_$E(X2,3,4)
 .. S LIST(CTR)=LIST(CTR)_$$S^LR7OS(30,24,$J(X3_"  and  "_X4,17))
 S CTR=CTR+1,LIST(CTR)=""
 S CTR=CTR+1,LIST(CTR)="Laboratory Service requires at least "_$P(NODE,"^",4)_" minutes to collect this order."
 S CTR=CTR+1,LIST(CTR)=""
 Q
VALID(DIV,TIME) ;Validate immediate collection time
 ;Function returns 1 if TIME is valid, 0 if not ^ user feedback text
 ;DIV=DUZ(2) division pointer
 ;TIME=Date/time of collection
 N MSG
 I '$G(TIME) S MSG="Invalid Date/time" Q 0_"^"_MSG
 I '$P(TIME,".",2) S MSG="Time must be entered" Q 0_"^"_MSG
 I '$G(DIV) S MSG="Division unknown" Q 0_"^"_MSG
 N NODE,M,S,H,X,Y,DAY,NODE1,NOP,%A,%DT,%T,D,D1,I,NOW1,X2
 Q:'$G(^LAB(69.9,1,7,DIV,0)) 0 S NODE=^(0)
 I '$P(NODE,"^",2),$$FIND1^DIC(40.5,,"QX",$P(TIME,".")) D  Q 0_"^"_MSG
  . D FIND^DIC(40.5,,"2","X","`"_$$FIND1^DIC(40.5,,"QX",$P(TIME,".")),,,,,"LRHLDY")
  . S MSG="Sorry, service not offered on: "_$G(LRHLDY("DILIST","ID",1,2)) K LRHLDY
 S X=TIME,M=$P(NODE,U,4),D=$$NOW^LRAFUNC1 D DATE^LRORDIM
 I $$FMADD^XLFDT(TIME,,,2)'>NOW1 S MSG="MUST BE "_M_" MINUTES IN THE FUTURE" Q 0_"^"_MSG
 S H=$S($P(NODE,U,5):$P(NODE,U,5),1:24) D DATE^LRORDIM
 I TIME>NOW1 S MSG="MUST BE LESS THAN "_H_" HRS IN THE FUTURE" Q 0_"^"_MSG
 S DAY=$E($$DOW^LRAFUNC1(TIME),1,3)
 S NODE1=$G(^LAB(69.9,1,7,DUZ(2),DAY)),NOP=0,X2=$P($$FMADD^XLFDT(TIME,,,2),".",2),X2=$E(X2,1,4)_$E("0000",($L(X2)+1),4)
 ;TIME is given a buffer of 2 minutes for potential processing delays in the variable X2
 ;This buffer also allows orders scheduled at midnight to be processed when lab parameter is set to 2359
 ;Seconds are stripped off prior to final concatenation.  This prevents
 ;errors in later comparisons with times in file 69.9.
 S:'$L(NODE1)!('$P(NODE1,"^")) NOP=1
 I NOP=1 S MSG="SERVICE NOT OFFERED ON "_DAY Q 0_"^"_MSG
 I NOP=0 D  I NOP=2 Q 0_"^"_MSG
 . S:X2<$P(NODE1,U,2)!(X2>$P(NODE1,U,3)) NOP=2
 . I NOP=2 S MSG="SERVICE FOR ["_DAY_"] OFFERED BETWEEN "_$E("0000",($L(+$P(NODE1,U,2))+1),4)_$P(NODE1,U,2)_" AND "_$E("0000",($L(+$P(NODE1,U,3))+1),4)_$P(NODE1,U,3)_" Hrs "
 I 'NOP S MSG="DATE/TIME ACCEPTED" Q 1_"^"_MSG
 Q 0
PROMPT ;Prompt for Immediate Lab Collect time
 N %DT,X
 W !! S %DT("A")="Enter Collection Date/Time: ",%DT="AETS"
 S X=$$DEFTIME($G(DUZ(2))) I +X S %DT("B")=$P(X,"^",2)
 D ^%DT
 Q
DEFTIME(DIV) ;Get next valid immediate collect time
 ;Function returns time if possible, "" if not ^message
 ;Internal time^External time^Minimum response time^Maximum hours ahead allowed
 ;DIV=division pointer
 I '$G(DIV) S MSG="Division unknown" Q ""_"^"_MSG
 N NODE,M,S,H,X,Y,DAY,NODE1,NOP,%A,%DT,%T,D,D1,I,NOW1
 Q:'$G(^LAB(69.9,1,7,DIV,0)) "" S NODE=^(0)
 Q:'$P(NODE,"^",6) ""
 S M=$P(NODE,U,4)+1,D=$$NOW^LRAFUNC1 D DATE^LRORDIM
 S:$P(NOW1,".",2) $P(NOW1,".",2)=$E($P(NOW1,".",2),1,4)
 Q NOW1_"^"_$$FMTE^XLFDT(NOW1)_"^"_$P(NODE,U,4,5)
TEST ;Test call
 N X,DAVE,Y,I,TXT
 S X=$$ON($G(DUZ(2)))
 I 'X W !!,"Immediate Lab Collect parameter is not turned on" Q
 D SHOW($G(DUZ(2)),.DAVE)
 S I=0 F  S I=$O(DAVE(I)) Q:'I  W !,DAVE(I)
 D PROMPT Q:'Y
 S X=$$VALID($G(DUZ(2)),Y)
 W !,$P(X,"^",2)
 Q
