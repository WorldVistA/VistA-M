FSCLD ;SLC/STAFF-NOIS List Definition ;1/17/98  17:06
 ;;1.1;NOIS;;Sep 06, 1998
 ;
DEFINE ; from FSCLMP
 N DESC,EVENT,METHOD,NAME,NOTIFY,NUM,OK,OWNER,TYPE K DESC
 S NOTIFY=""
 W !!,"Please use the following conventions for personal lists:"
 W !,"Manual or Active update lists should begin with your LASTNAME and then"
 W !,"something descriptive (separate your name and description with a '-')"
 W !,"Storage-Only lists should be TEMP-LASTNAME"
 W !,"If the list is to be used by your office or site, use your NOIS location"
 W !,"abbreviation instead of your last name."
 W !,"Examples:  SMITH-SUPPORT, SMITH-DEV, or TEMP-SMITH, ISL-OLD CALLS",!
 D NAME^FSCMU("",.NAME,.OK) I 'OK Q
 D OWNER^FSCMU(DUZ,.OWNER,.OK) I 'OK Q
 D DESC^FSCMU1(0,.DESC,.OK) I OK="" Q
 D TYPE^FSCMU("",.TYPE,.OK) I 'OK Q
 I TYPE="A"!(TYPE="M") D  I 'OK Q
 .I TYPE="A" D METHOD^FSCMU1("",.METHOD,.OK) I 'OK Q
 .I TYPE="A",$L(METHOD) D EVENT^FSCMU1("",.EVENT,.OK) I 'OK Q
 .I TYPE="A",$L(METHOD),$L(EVENT) S NOTIFY=METHOD_U_EVENT
 .W ! D DEF(NAME,0,.OK) I 'OK Q
 W ! D ASK(.OK) I 'OK Q
 S NUM=0 D SAVE^FSCLDS(NAME,.NUM,OWNER,.DESC,TYPE,NOTIFY)
 S FSCLNAME=NAME,FSCLNUM=NUM
 Q
 ;
DEF(FSCLNAME,FSCLNUM,OK) ; from FSCLDR
 N FSCQUERY
 S FSCLNUM=+$G(FSCLNUM),FSCQUERY=1,OK=1 K ^TMP("FSC DEFINE",$J)
 W !,"Query Definition:"
 D BROWSE^FSCQB("",FSCLNAME,0,.OK,"Add","^TMP(""FSC DEFINE"",$J)")
 I $D(DTOUT) S OK=""
 Q
 ;
ASK(OK) ; from FSCLMPS
 N DIR,Y K DIR S OK=0
 S DIR(0)="YAO",DIR("A")="Save this list definition: ",DIR("B")="YES"
 S DIR("?",1)="Enter YES to save this list definition."
 S DIR("?",2)="Enter NO or '^' to exit without saving the list, '??' for more help."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 I Y'=1 W !,"List Definition was NOT Saved." H 2 Q
 S OK=1
 Q
