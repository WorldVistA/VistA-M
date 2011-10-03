FSCLMPQR ;SLC/STAFF-NOIS List Manager Protocol Query Remove ;1/13/98  13:06
 ;;1.1;NOIS;;Sep 06, 1998
 ;
REMOVE ; from FSCLMP
 I '^TMP("FSC LIST CALLS",$J) W !,$C(7),"You can't delete from an empty list." H 2 Q
 N DIR,SELECT,X,Y K DIR
 S DIR(0)="SAMO^S:Selected Calls;L:Lists;Q:Query;A:All Calls"
 S DIR("A")="Remove using: " W !,"(S)elected Calls, (L)ists, (Q)uery, (A)ll Calls"
 S DIR("?",1)="Enter S to a remove selected calls from the last."
 S DIR("?",2)="Enter L to remove calls from the list that are on selected lists."
 S DIR("?",3)="Enter Q to remove calls from the list using a specific criteria."
 S DIR("?",4)="Enter A to remove all calls on the list."
 S DIR("?",5)="Note: changing a list does not change what is stored on the list."
 S DIR("?",6)="When a list is changed it appears as (MODIFIED)."
 S DIR("?",7)="Enter '^' to exit without changing the list or '??' for more help."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 S SELECT=Y
 D
 .I SELECT="S" D  Q
 ..N CALL,CHOICE,DEFAULT,LNUM,OK
 ..K ^TMP("FSC SELECT",$J,"RVALUES")
 ..S CHOICE="1-"_+@VALMAR,DEFAULT="" D SELECT^FSCUL(CHOICE,"",DEFAULT,"RVALUES",.OK)
 ..I '$O(^TMP("FSC SELECT",$J,"RVALUES",0)) Q
 ..W !
 ..S LNUM=0 F  S LNUM=$O(^TMP("FSC LIST CALLS",$J,"IDX",LNUM)) Q:LNUM<1  S CALL=+$O(^TMP("FSC LIST CALLS",$J,"ICX",+$O(^(LNUM,0)),0)) D
 ...S ^TMP("FSC MERGE",$J,LNUM,CALL)=""
 ..K ^TMP("FSC LIST CALLS",$J)
 ..S (LNUM,VALMCNT)=0 F  S LNUM=$O(^TMP("FSC MERGE",$J,LNUM)) Q:LNUM<1  S CALL=$O(^(LNUM,0)) D
 ...I '$D(^TMP("FSC SELECT",$J,"RVALUES",LNUM)) D SETUP^FSCLMPQU(.VALMCNT,CALL)
 ..D COUNT^FSCLMPQU(VALMCNT)
 ..K ^TMP("FSC MERGE",$J),^TMP("FSC SELECT",$J,"RVALUES")
 .I SELECT="A" D  Q
 ..K ^TMP("FSC LIST CALLS",$J)
 ..S ^TMP("FSC LIST CALLS",$J)="0^0"
 ..D HDR^FSCLMPQU
 .I SELECT="L" D  Q
 ..N CALL,CALLX,LIMITS,LINDX,LISTNUM,LISTS,LNAME,LNUM,OK,TIME K LIMITS,LISTS
 ..D LIST^FSCLMPQU(.LISTS,.LIMITS,.OK)
 ..I '$O(LISTS(0)) Q
 ..W !
 ..S LNUM=0 F  S LNUM=$O(^TMP("FSC LIST CALLS",$J,"ICX",LNUM)) Q:LNUM<1  S CALL=+$O(^(LNUM,0)) D
 ...S ^TMP("FSC MERGE",$J,LNUM,CALL)=""
 ..K ^TMP("FSC LIST CALLS",$J)
 ..S (LNUM,VALMCNT)=0 F  S LNUM=$O(^TMP("FSC MERGE",$J,LNUM)) Q:LNUM<1  S CALL=$O(^(LNUM,0)) D  I $D(VALMQUIT) Q
 ...S OK=1,LISTNUM=0 F  S LISTNUM=$O(LISTS(LISTNUM)) Q:LISTNUM<1  D  I 'OK Q
 ....S LNAME=$P(^FSC("LIST",+$P(LISTNUM,"."),0),U),LINDX=+$P(LISTNUM,".",2)
 ....I LNAME="MRE:" D  Q
 .....S TIME="" F  S TIME=$O(^FSCD("MRE","AUTC",LINDX,TIME)) Q:TIME=""  D  Q:'OK
 ......S CALLX=0 F  S CALLX=$O(^FSCD("MRE","AUTC",LINDX,TIME,CALLX)) Q:CALLX<1  I CALLX=CALL S OK=0 Q
 ....I LNAME="MRA:" D  Q
 .....S TIME="" F  S TIME=$O(^FSCD("MRA","AUTC",LINDX,TIME)) Q:TIME=""  D  Q:'OK
 ......S CALLX=0 F  S CALLX=$O(^FSCD("MRA","AUTC",LINDX,TIME,CALLX)) Q:CALLX<1  I CALLX=CALL S OK=0 Q
 ....I $D(@LISTS(LISTNUM)@(CALL)) D CHECK(CALL,LISTS(LISTNUM),LIMITS(LISTNUM),.OK)
 ...I OK D SETUP^FSCLMPQU(.VALMCNT,CALL) I (VALMCNT#10)=0 D CHECK^FSCLML(.VALMQUIT) I $D(VALMQUIT) S VALMBCK="Q" Q
 ..D COUNT^FSCLMPQU(VALMCNT)
 ..K ^TMP("FSC MERGE",$J)
 .I SELECT="Q" D  Q
 ..D QUERY^FSCLMPQU("Remove")
 I '$D(VALMQUIT) D EMPTY^FSCLMPQU
 S VALMBG=1
 Q
 ;
CHECK(CALL,LIST,LIMIT,OK) ;
 N CNT,DATEO,NUM
 I 'LIMIT S OK=0 Q
 S OK=1
 I $P(LIMIT,U,2) D  Q
 .S CNT=0,NUM="A" F  S NUM=$O(@LIST@(NUM),-1) Q:NUM<1  S CNT=CNT+1 I NUM=CALL S:CNT'>$P(LIMIT,U,2) OK=0 Q
 S DATEO=$P(^FSCD("CALL",CALL,0),U,3)
 I DATEO'<$P(LIMIT,U,3),DATEO'>$P(LIMIT,U,4) S OK=0
 Q
