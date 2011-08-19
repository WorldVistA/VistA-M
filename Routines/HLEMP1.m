HLEMP1 ;ALB/CJM-HL7 - Selector for Events Log Profiles  ;07/10/2003
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13,1995
 ;
SELECT(USER,SCRNSIZE) ;
 ;Input:
 ;  USER - the owner's DUZ
 ;  SCRNSIZE is the number of lines available for scrolling
 ;Output;
 ;  function returns ien of profile if selection is made, 0 otherwise
 ;
 Q:'$G(USER) 0
 I '$G(SCRNSIZE) S SCRNSIZE=10
 S SCRNSIZE=+$G(SCRNSIZE)-1
 S:SCRNSIZE<1 SCRNSIZE=1
 N COUNT,CNT,PICK,PROFILE,ARY,NAME
 S ARY="^TMP($J,""PROFILES"")"
 K @ARY
 S CNT=$$FINDALL(USER,ARY)
 ;
 ;return failure if no profiles found
 Q:CNT=0 0
 ;
 ;if CNT=1 return the only profile
 I CNT=1 S NAME=$O(@ARY@("NAME","")) Q $S(NAME'="":$O(@ARY@("NAME",NAME,0)),1:"")
 ;
 ;if CNT>1 loop through the profiles, displaying them to the user and let him choose
 W !,"Please select the profile you wish to use"
AGAIN ;
 S (PICK,NAME)="",COUNT=0
 F  S NAME=$O(@ARY@("NAME",NAME)) Q:(PICK'="")!(NAME="")  D
 .S PROFILE=0 F  S PROFILE=$O(@ARY@("NAME",NAME,PROFILE)) Q:(PICK'="")!('PROFILE)  D  Q:NAME=""
 ..S COUNT=COUNT+1,@ARY@("#",COUNT)=PROFILE W !,COUNT,"   ",NAME
 ..I COUNT#SCRNSIZE=0 S PICK=$$CHOOSE(ARY)
 I (PICK=""),COUNT,COUNT#SCRNSIZE'=0 S PICK=$$CHOOSE(ARY)
 I PICK="" K DIR S DIR(0)="Y",DIR("A")="No profile selected! Try again",DIR("B")="YES" D ^DIR K DIR I '$D(DIRUT),Y=1 G AGAIN
 I PICK="?" G AGAIN
 K @ARY
 Q $S((PICK'>0):"",1:PICK)
 ;
FINDALL(USER,ARY) ;finds all of the profiles belonging to USER and puts them on @ARY,returns the count
 N PROFILE,COUNT,NAME
 S NAME="",COUNT=0 F  S NAME=$O(^HLEV(776.5,"C",USER,NAME)) Q:'$L(NAME)  S PROFILE=$O(^HLEV(776.5,"C",USER,NAME,0)) I PROFILE,$D(^HLEV(776.5,PROFILE,0)) S @ARY@("NAME",$$UP^XLFSTR(NAME),PROFILE)="",COUNT=COUNT+1
 Q COUNT
 ;
CHOOSE(ARY) ;asks the user to select a profile - @ARY@("#", is the array of profiles displayed so far(subscripted by the number on the list), @ARY@("NAME", the entire array (subscripted by name,ien)
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
 .S NEXT2=$O(@ARY@("NAME",NEXT1)) Q:($E(NEXT2,1,$L(ANS))=ANS)  ;because user did not type in enough to uniquely identify the profile
 .;make sure there are not two profiles with the same name - if ok, accept it
 .S PICK=$O(@ARY@("NAME",NEXT1,PICK)) Q:'PICK  I '$O(@ARY@("NAME",NEXT1,PICK)) S QUIT=1 Q
 Q PICK
 ;
HELP ;choosing help restarts the display (by setting NAME="")
 W !,"You can choose a profile by the number or by it's name.",!
 D PAUSE
 S QUIT=1,NAME="",PICK="?",COUNT=0
 Q
MSG ;
 W !,"You must enter the number or name of the profile!"
 D PAUSE
 Q
PAUSE ;
 N ANS
 W !,$C(7),"Press RETURN to continue..." R ANS:DTIME
 Q
