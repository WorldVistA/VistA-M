DGBTE1A ;ALB/SCK - BENEFICIARY TRAVEL FIND OLD CLAIMS PART 2; 1/22/93@1530
 ;;1.0;Beneficiary Travel;;September 25, 2001
 ;
 ;
 Q
NOW ; date/time entry for NOW
 S (Y,Y1)=$$NOW^XLFDT()
 Q
OTHR ; date/time entry for manually entered date
 S %DT(0)="-NOW" D ^%DT S Y1=Y K %DT,%DT(0)
 Q
OLD ; date/time entry for select from past dates 
LIST2 ;  find all previous claims, get total count in DGBTC and put those claims in utility file
 N X1,YY
 S (DGBTC,DGBTCH,DGBTCH1)=0
 F I=0:0 S I=$O(^DGBT(392,"AI",DFN,I)) Q:'I  S DGBTC=DGBTC+1,^TMP("DGBT",$J,DGBTC,I)=9999999.99999-I ; order through claim file
 I '$D(^TMP("DGBT",$J))!('$D(^DGBT(392,"C",DFN))) W !!?10,"There are no entries on file for this patient",! S Y1=-1 G EXIT
 ;  build temporary global array using dates in utility file, converted to external format dates 
 F I=0:0 S I=$O(^TMP("DGBT",$J,I)) Q:'I  F J=0:0 S J=$O(^TMP("DGBT",$J,I,J)) Q:'J  S K=I,VADAT("W")=^(J) D ^VADATE S ^TMP("DGBTARA",$J,K)=VADATE("E")
LIST3 ;  list claims (in external format) from temporary global, 5 at a time. Loop thru list until selection made.
 S DGBTCH=1 W ! F X1=1:1:DGBTC W !?5,X1,".",?10,^TMP("DGBTARA",$J,X1) I X1#5=0!(X1=DGBTC) D CHOZ I $D(DUOUT)!$D(DTOUT)!(Y>0) S Y1=$S(+Y>0:Y,1:-1) K DIR Q
 G:'$D(DTOUT)&Y="" LIST3
  S Y1=$S(+Y>0:Y,1:-1) K DIR
EXIT ;
 K X1,YY,DGBTCHK,^TMP("DGBT",$J),^TMP("DGBTARA",$J)
 Q
CHOZ ;  select from the displayed past claims dates for claim to be edited.
 W !! S (Y1,Y)=0,DGBTCH1=X1,DIR(0)="FO^1:5",DIR("A")="Select CLAIM"
 S DIR("A",1)="Type '^' to exit date list, or <RETURN> to display more dates"
 S DIR("?")="Entering a '^' will exit the Past CLAIM list, entering <RETURN> will continue to scroll through past dates.",DIR("?",1)="Select a Past CLAIM date by number, or enter 'N' for NOW."
 D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S Y1=-1 Q
 I Y="N"!(Y="n") W "   " D NOW Q
 Q:Y=""
 I X<DGBTCH!(X>DGBTCH1)!(X'=+X) W !?25,*7,"INVALID ENTRY!" G CHOZ ; value must be between 1 and last displayed number
 I X,$D(^TMP("DGBT",$J,X)) S Y=$O(^TMP("DGBT",$J,X,0)),Y=^TMP("DGBT",$J,X,Y),CHZFLG=1
 Q
HELP ;
 S %DT="EXR" D ^%DT
 W !!,"Time is required when adding a new CLAIM date.",!,"If there is more than one claim per date, select by number to edit."
 Q
