IBDFU8 ;ALB/CJM - ENCOUNTER FORM - selection routines for form components;OCT 8,1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
SLCTBLK(FORM,SCRNSIZE,EXCLUDE) ;SCRNSIZE is the number of lines available for scrolling
 ;EXCLUDE is a block name that can be excluded (used to exclude the HEADER block from being edited)
 ;returns the block selected, returns "" if none selected
 ;only allows one to be selected
 ;
 Q:'FORM
 S SCRNSIZE=+$G(SCRNSIZE)-1
 S:SCRNSIZE<1 SCRNSIZE=4
 S EXCLUDE=$G(EXCLUDE)
 N COUNT,CNT,PICK,BLK,ARY,NAME
 S ARY="^TMP($J,""FORM BLOCKS"")"
 K @ARY
 S CNT=$$FINDALL ;FORM,EXCLUDE,ARY are inputs to FINDALL
 ;
 ;if CNT=1 return the only block
 I CNT=1 S NAME=$O(@ARY@("NAME","")) Q $S(NAME'="":$O(@ARY@("NAME",NAME,0)),1:"")
 ; 
 ;if CNT'=1 loop through the blocks, displaying them to the user and let him choose
AGAIN ;
 S (PICK,NAME)="",COUNT=0
 F  S NAME=$O(@ARY@("NAME",NAME)) Q:(PICK'="")!(NAME="")  D
 .S BLK=0 F  S BLK=$O(@ARY@("NAME",NAME,BLK)) Q:(PICK'="")!('BLK)  D  Q:NAME=""
 ..S COUNT=COUNT+1,@ARY@("#",COUNT)=BLK W !,COUNT,"   ",NAME,?38,$E($P($G(^IBE(357.1,BLK,0)),"^",13),1,42)
 ..I COUNT#SCRNSIZE=0 S PICK=$$CHOOSE
 I (PICK=""),COUNT,COUNT#SCRNSIZE'=0 S PICK=$$CHOOSE
 I PICK="" K DIR S DIR(0)="Y",DIR("A")="No block selected! Try again",DIR("B")="YES" D ^DIR K DIR I '$D(DIRUT),Y=1 G AGAIN
 I PICK="?" G AGAIN
 K @ARY
 Q $S((PICK'>0):"",1:PICK)
 ;
FINDALL() ;finds all of the blocks on FORM (except the one named EXCLUDE) and puts them on @ARY,returns the cound
 N BLK,COUNT,NODE
 S BLK="",COUNT=0 F  S BLK=$O(^IBE(357.1,"C",FORM,BLK)) Q:'BLK  S NODE=$G(^IBE(357.1,BLK,0)),NAME=$P(NODE,"^") S:(NAME'="")&(NAME'=EXCLUDE)&($P(NODE,"^",2)=FORM) @ARY@("NAME",$$UP^XLFSTR(NAME),BLK)="",COUNT=COUNT+1
 Q COUNT
 ;
CHOOSE() ;asks the user to select a blk - @ARY@("#", is the aray of blocks displayed so far(subscripted by the number on the list), @ARY@("NAME", the entire array (subscripted by name,ien)
 ;sets NAME to " " and COUNT to 0 if ? is entered - starts display of list over
 N ANS,QUIT,PICK,NEXT1,NEXT2
 S QUIT=0
 F  Q:QUIT  D  D:'QUIT MSG
 .S (PICK,ANS)=""
 .W !,"Choose 1-",COUNT,$S(COUNT<CNT:" or hit RETURN to see more",1:""),": "
 .R ANS:DTIME
 .I '$T!($E(ANS,1)="^") S PICK=-1,QUIT=1 Q
 .I ANS="" S QUIT=1 Q
 .I $E(ANS,1)="?" D HELP Q
 .;
 .;convert to upper case
 .S ANS=$$UP^XLFSTR(ANS)
 .
 .;if user entered a displayed number then he's made his choice
 .I $D(@ARY@("#",ANS)) S PICK=$G(@ARY@("#",ANS)),QUIT=1 Q
 .;
 .;if the user entered an exact name, and the name is unique then he's made his choice
 .S PICK=$O(@ARY@("NAME",ANS,PICK)) I PICK,'$O(@ARY@("NAME",ANS,PICK)) S QUIT=1 Q
 .Q:PICK  ;don't set QUIT=1 because name is not unique
 .;
 .;if the user entered a partial name accept it if there is exactly one match
 .S NEXT1=$O(@ARY@("NAME",ANS)) Q:(NEXT1="")!($E(NEXT1,1,$L(ANS))'=ANS)
 .S NEXT2=$O(@ARY@("NAME",NEXT1)) Q:($E(NEXT2,1,$L(ANS))=ANS)  ;because user did not type in enough to uniquely identify the block
 .;make sure there are not two blocks with the same name - if ok, accept it
 .S PICK=$O(@ARY@("NAME",NEXT1,PICK)) Q:'PICK  I '$O(@ARY@("NAME",NEXT1,PICK)) S QUIT=1 Q
 Q PICK
 ;
HELP ;choosing help restarts the display (by setting NAME="")
 W !,"You can choose a block by the number or by it's name.",!
 D PAUSE^IBDFU5
 S QUIT=1,NAME="",PICK="?",COUNT=0
 Q
MSG ;
 W !,"You must enter the number or name of the block!"
 D PAUSE^IBDFU5
 Q
