PRPFARC ;CTB/ALTOONA   PATIENT FUNDS ARCHIVE  ;1/7/98  12:25 PM
V ;;3.0;PATIENT FUNDS;**6,7,9**;JUNE 1, 1989
 N X,MTIO,NAME,PGCOUNT,XPDNM,ZTQUEUED
 S X="This option will cause all transactions of all cards to be written to tape in alphabetical order" D MSG^PRPFU1
 K ^TMP($J,"PRPFARC")
 S PGCOUNT=0
 S %A="Are You Ready to Begin",%B="",%=1 D ^PRPFYN Q:%'=1
 S MESSAGE="BUILDING ALPHABETIC CROSS REFERENCE IN ^TMP.  ITEMS=PATIENTS"
 S TREC=$P(^PRPF(470,0),"^",4)
 G DONE:TREC<1 ;  By REW 3*9   QUIT:TREC=0
 D BEGIN^PRPFU
 S DA=0 F  D  S XCOUNT=XCOUNT+COUNT D:'$D(ZTQUEUED) PERCENT^PRPFU Q:'DA
 . F COUNT=1:1:LREC S DA=$O(^PRPF(470,DA)) Q:'DA  S:$D(^DPT(DA,0)) ^TMP($J,"PRPFARC",$P(^DPT(DA,0),"^"),DA)=""
 . QUIT
 K X S $P(X," ",40)=""
 W !!!!,"100% complete."_$P(X," ",1,40),!
 D:$G(XPDNM)="" KILL^%ZISS
HDR W !!,"You now need to enter the header information:"
 S DIR(0)="FA^3:30",DIR("A")="Select Header Line 1: ",DIR("B")=$S($D(LINE(1)):LINE(1),1:"VA MEDICAL CENTER"),DIR("?")="Enter the first line of the header to be printed on the archive record tape or an '^' to quit"
 D ^DIR K DIR I $$DIR^PRPFU2 D TERM QUIT
 S LINE(1)=Y
 S DIR(0)="FA^3:30",DIR("A")="Select Header Line 2: ",DIR("?")="Enter the second line of the header to be printed on the archive record tape or an '^' to quit" S:$D(LINE(2)) DIR("B")=LINE(2)
 D ^DIR K DIR I $$DIR^PRPFU2 D TERM QUIT
 S LINE(2)=Y
 S DIR(0)="FOA^3:30",DIR("A")="Select Header Line 3: ",DIR("?")="Enter the third line of the header to be printed on the archive record tape or an '^' to quit" S:$D(LINE(3)) DIR("B")=LINE(3)
 D ^DIR K DIR I Y]"",$$DIR^PRPFU2 D TERM QUIT
 S LINE(3)=Y
 W !! F I=1:1:3 W LINE(I),!
 D NOW^PRPFQ S LINE(4)=%X
 S DIR("A")="IS THIS OK",DIR(0)="Y" D ^DIR I $$DIR^PRPFU2 D TERM QUIT
 I 'Y W !!,"OK, you may now edit this information.",! G HDR
 S %ZIS("A")="Select Tape/HFS Device: "
 D ^%ZIS I POP D TERM QUIT
 S MTIO=IO D HOME^%ZIS
 S PRPF("ARCHIVE")=""
 U MTIO W "1^PATIENT FUNDS ARCHIVE^"_$$DATE^PRPFU1(DT),!,"2^"_LINE(1),!,"2^"_LINE(2)
 U MTIO I $G(LINE(3))]"" W !,"2^"_LINE(3)
 U MTIO W !,"3^~~PRPF~~^"_$P(^PRPF(470,0),"^",4)_"^^"
 U MTIO W !,"4^NAME^CLAIM^SSN"
 U MTIO W !,"5^LANDSCAPE^COURIER NEW^24",!
 S MESSAGE="ARCHIVING PATIENT FUNDS CARDS.  ITEMS=PATIENT NAME"
 S NAME="" F I=0:1 S NAME=$O(^TMP($J,"PRPFARC",NAME)) Q:NAME=""
 S TREC=I
 QUIT:TREC=0
 U IO D BEGIN^PRPFU
 S NAME="" F  U MTIO D  S XCOUNT=XCOUNT+COUNT U IO D:'$D(ZTQUEUED) PERCENT^PRPFU Q:NAME=""
 . F COUNT=1:1:LREC S NAME=$O(^TMP($J,"PRPFARC",NAME)) Q:NAME=""  D
 . . S DA=0 F  S DA=$O(^TMP($J,"PRPFARC",NAME,DA)) Q:'DA  D
 . . . S DFN=DA
 . . . U MTIO D EN2^PRPFCD
 . . . QUIT
 . . QUIT
 . QUIT
 U MTIO W !!,"ARCHIVE COMPLETED*^^*"
 D:$G(XPDNM)="" KILL^%ZISS
 D CLOSE^PRPFU,END^PRPFU
DONE D ADD("ARCHIVE",DT)
 U IO W !!,"ARCHIVE COMPLETED",$C(7)
 QUIT
TERM ;
 U IO W "  OPTION TERMINATED",$C(7) Q
ADD(TYPE,THRU) ;ADD ENTRY TO ARCHIVE HISTORY FILE
 NEW DIC,X,%,%H,%I,DA,DR,DLAYGO
 D NOW^%DTC S X=%
 K DD,D0 S DIC="^PRPF(470.9,",DIC(0)="ML",DLAYGO=470.9
 S DIC("DR")="1///"_TYPE I $D(THRU) S DIC("DR")=DIC("DR")_";2///"_THRU
 D FILE^DICN
 QUIT
