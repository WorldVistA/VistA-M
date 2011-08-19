FSCLMPOS ;SLC/STAFF-NOIS List Manager Protocol Other Sort ;4/22/94  11:06
 ;;1.1;NOIS;;Sep 06, 1998
 ;
SORT ; from FSCLMP
 I ^TMP("FSC LIST CALLS",$J)'>1 Q
 N CNT,DIC,DIR,DONE,LASTCNT,NUM,OK,SORT,X,Y K DIC,DIR,SORT,Y
 S CNT=0,OK=1,DIC=7107.2,DIC(0)="AEMOQZ",DIC("S")="I $P(^(0),U,3)'[""W"",'$D(SORT(""N"",$P(^(0),U)))",DIC("A")="Sort by: "
 S DONE=0 F  D  I DONE Q
 .D ^DIC
 .I $D(DUOUT)!$D(DTOUT) S DONE=1,OK=0 Q
 .I Y<1 S DONE=1 Q
 .S CNT=CNT+1,SORT(CNT)=Y(0),SORT("N",$P(Y,U,2))=""
 .I CNT>4 S DONE=1 W !,"Limit of 5 fields only."
 .I CNT=1 S DIC("A")="and then sort by: "
 K DIC,SORT("N"),Y
 I 'OK Q
 I '$O(SORT(0)) Q
 W !!,"The list will be sorted by:",!
 S (LASTCNT,CNT)=0 F  S CNT=$O(SORT(CNT)) Q:CNT<1  S LASTCNT=CNT W CNT,") ",$P(SORT(CNT),U,2),$S($O(SORT(CNT)):", ",1:"")
 S DIR(0)="LAO^1:"_LASTCNT
 S DIR("A")="Select any fields to be sorted in descending order or <return>: "
 S DIR("?",1)="Descending order will sort from Z to A or highest value first."
 S DIR("?",2)="This is useful for sorting most recent dates first or"
 S DIR("?",3)="numeric value fields.  Enter any of the sequence numbers of"
 S DIR("?",4)="the fields you have selected to sort by. (ex. 1,3-4)"
 S DIR("?",5)="If you want all fields sorted in ascending order, enter <return>."
 S DIR("?",6)="Enter '^' to exit without sorting or '??' for more help."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT),Y'="" Q
 F CNT=1:1 S NUM=$P(Y,",",CNT) Q:NUM<1  S SORT(NUM,"D")=""
 D SORT^FSCUS(.SORT)
 Q
