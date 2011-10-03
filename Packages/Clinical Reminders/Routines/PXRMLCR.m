PXRMLCR ; SLC/PJH - Create Patient List from individual finding rule; 06/08/2009
 ;;2.0;CLINICAL REMINDERS;**4,6,12**;Feb 04, 2005;Build 73
 ; 
 ; Called from PXRM PATIENT LIST CREATE protocol
 ;
START N BEG,DUOUT,DTOUT,END,LIT,PXRMDPAT,PXRMLIST,PXRMNODE,PXRMRULE,PXRMTPAT
 N TEXT
 ;Initialise
 K ^TMP("PXRMLCR",$J)
 ;Node for ^TMP lists created in PXRMRULE
 S PXRMNODE="PXRMRULE",LIT="Patient List"
 ;Reset screen mode
 W IORESET
 ;Set prompt text
 S TEXT="Select PATIENT LIST name: "
 ;Select Patient List
LIST D PLIST(.PXRMLIST,TEXT,"") I $D(DUOUT)!$D(DTOUT) D  Q
 . I $G(PXRMLIST)="" Q
 . I $P($G(^PXRMXP(810.5,PXRMLIST,0)),U,4)'="" Q
 . N DIK
 . S DA=PXRMLIST,DIK="^PXRMXP(810.5," D ^DIK
 ;
SECURE ;option to secure the list
 K PATCREAT
 I $D(PATCREAT)=0 S PATCREAT="N" D ASK^PXRMXD(.PATCREAT,"Secure list?: ",2) Q:$D(DTOUT)  G:$D(DUOUT) START
 ;
PURGE ;Option to purge the list
 K PLISTPUG
 S PLISTPUG="N" D ASK^PXRMXD(.PLISTPUG,"Purge Patient List after 5 years?: ",5) Q:$D(DTOUT)  G:$D(DUOUT) SECURE
 ;Select rule set.
RULE D LRULE(.PXRMRULE) Q:$D(DTOUT)  G:$D(DUOUT) LIST
 ;Select Date Range
DATE D DATES^PXRMEUT(.BEG,.END,LIT) Q:$D(DTOUT)  G:$D(DUOUT) RULE
 ;
 ;Ask whether to include deceased and test patients.
DPAT S PXRMDPAT=$$ASKYN^PXRMEUT("N","Include deceased patients on the list")
 Q:$D(DTOUT)  G:$D(DUOUT) DATE
TPAT S PXRMTPAT=$$ASKYN^PXRMEUT("N","Include test patients on the list")
 Q:$D(DTOUT)  G:$D(DUOUT) DPAT
 I $G(PXRMDEBG) D RUN^PXRMLCR(PXRMRULE,PXRMLIST,PXRMNODE,BEG,END,PXRMDPAT,PXRMTPAT) Q
 ;Build patient list in background
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S ZTDESC="CREATE PATIENT LIST"
 S ZTRTN="RUN^PXRMLCR(PXRMRULE,PXRMLIST,PXRMNODE,BEG,END,PXRMDPAT,PXRMTPAT)"
 S ZTSAVE("BEG")=""
 S ZTSAVE("END")=""
 S ZTSAVE("PATCREAT")=""
 S ZTSAVE("PXRMDPAT")=""
 S ZTSAVE("PXRMLIST")=""
 S ZTSAVE("PXRMNODE")=""
 S ZTSAVE("PXRMRULE")=""
 S ZTSAVE("PXRMTPAT")=""
 S ZTSAVE("PLISTPUG")=""
 S ZTIO=""
 ;
 ;Select and verify start date/time for task
 N DIR,DTOUT,DUOUT,MINDT,SDTIME,STIME,X,Y
 S MINDT=$$NOW^XLFDT
 W !,"Queue the "_ZTDESC_" for "_$P($G(^PXRMXP(810.5,PXRMLIST,0)),U)_": "
 S DIR("A",1)="Enter the date and time you want the job to start."
 S DIR("A",2)="It must be after "_$$FMTE^XLFDT(MINDT,"5Z")
 S DIR("A")="Start the task at: "
 S DIR(0)="DAU"_U_MINDT_"::RSX"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q
 S SDTIME=Y
 ;
 ;Put the task into the queue.
 S ZTDTH=SDTIME
 D ^%ZTLOAD
 W !,"Task number ",ZTSK," queued." H 2
EXIT Q
 ;
HELP(CALL) ;General help text routine
 N HTEXT
 I CALL=1 D
 .S HTEXT(1)="Enter 'Y' to overwrite this existing list. Enter 'N' to"
 .S HTEXT(2)="use a different patient list name."
 ;
 I CALL=2 D
 .S HTEXT(1)="Enter 'Y' to make the list private or 'N' to make it public."
 .S HTEXT(2)="You can give other users access to your private lists in the Patient List Menu screens."
 ;
 I CALL=3 D
 .S HTEXT(1)="Enter Y to save the patient to a Reminder Patient List. Enter N to not save the output."
 ;
 I CALL=4 D
 .S HTEXT(1)="Enter Y to turn on debug output."
 .S HTEXT(2)="The debug output will send a series of MailMan messages to the requestor of the report"
 .S HTEXT(3)="-**WARNING**- the reminder report will take longer to run if you turn on this option!"
 D HELP^PXRMEUT(.HTEXT)
 Q
 ;
PLIST(LIST,TEXT,IENO) ;Select Patient List
 N X,Y,DIC,DLAYGO
PL1 S DIC=810.5,DLAYGO=DIC,DIC(0)="QAEMZL"
 S DIC("A")=TEXT
 S DIC("S")="I $P($G(^(100)),U)'=""N"""
 ;If this is a new entry save the creator, make the TYPE public and
 ;CLASS local.
 S DIC("DR")=".07///`"_DUZ_";.08///PUB;100///L"
 W !
 D ^DIC
 I X="" W !,"A patient list name must be entered" G PL1
 I X=(U_U) S DTOUT=1
 I Y=-1 S DUOUT=1
 I $D(DTOUT)!$D(DUOUT) Q
 ;
 ;I copy mode dissallow copy to same list
 I IENO=$P(Y,U) W !,"A patient list cannot be copied to itself." G PL1
 ;
 I ($P(Y,U,3)=1) S LIST=$P(Y,U) Q
 ;Check if OK to overwrite
 N OWRITE
 S OWRITE=$$ASKYN^PXRMEUT("N","Okay to overwrite "_$P(Y,U,2),"PXRMLCR",1)
 Q:$D(DTOUT)  G:$D(DUOUT)!('OWRITE) PL1
 S OWRITE=$$LDELOK^PXRMEUT($P(Y,U,1))
 I 'OWRITE D  G PL1
 . W !,"In order to overwrite a list you must be the creator or a Reminder Manager!"
 ;Return list ien
 S LIST=$P(Y,U)
 Q
 ;
LRULE(RULE) ;Select List Rule
 N X,Y,DIC
LR1 S DIC=810.4,DIC(0)="QAEMZ"
 S DIC("A")="Select LIST RULE SET: "
 ;Only allow rule sets with components
 S DIC("S")="I $P(^(0),U,3)=3"
 W !
 D ^DIC
 I X="" W !,"A list rule set name must be entered" G LR1
 I X=(U_U) S DTOUT=1
 I Y=-1 S DUOUT=1
 I $D(DTOUT)!$D(DUOUT) Q
 ;Return rule ien
 S RULE=$P(Y,U)
 ;Check that rule set is valid
 N ERROR,LR,LRTYPE,NL,OP,SEQ,SUB,TEMP,TEXT
 S SUB=$O(^PXRM(810.4,RULE,30,0))
 I SUB="" W !,"Rule set has no component rules" G LR1
 S (ERROR,SUB)=0,NL=1
 F  S SUB=$O(^PXRM(810.4,RULE,30,SUB)) Q:'SUB  D  Q:ERROR
 .S TEMP=$G(^PXRM(810.4,RULE,30,SUB,0))
 .S SEQ=$P(TEMP,U,1),LR=$P(TEMP,U,2),OP=$P(TEMP,U,3)
 .I SEQ="" S NL=NL+1,TEXT(NL)=" Sequence is missing.",ERROR=1
 .I LR="" S NL=NL+1,TEXT(NL)=" List rule is missing.",ERROR=1
 .I OP="" S NL=NL+1,TEXT(NL)=" Operation is missing.",ERROR=1
 .;The Insert operation can only be used with finding rules.
 .I OP="F",LR'="" D
 ..S LRTYPE=$P(^PXRM(810.4,LR,0),U,3)
 ..I LRTYPE'=1 S NL=NL+1,TEXT(NL)=" Insert operation can only be used with finding rules.",ERROR=1
 I ERROR D  G LR1
 .S TEXT(1)="The rule set is incomplete or incorrect:"
 .D EN^DDIOL(.TEXT)
 Q
 ;
 ;Build list and clear ^TMP files
RUN(PXRMRULE,PXRMLIST,PXRMNODE,BEG,END,PXRMDPAT,PXRMTPAT) ;
 ;Process rule set and update final patient list
 D START^PXRMRULE(PXRMRULE,PXRMLIST,PXRMNODE,BEG,END,"","","",PXRMDPAT,PXRMTPAT,"")
 ;Clear ^TMP lists created for rule
 D CLEAR^PXRMRULE(PXRMRULE,PXRMNODE)
 Q
 ;
REMOVE(IEN) ;
 S $P(^PXRM(810.4,IEN,0),U,10)=""
 Q "@1"
 ;
