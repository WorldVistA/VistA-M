QAOAUTO ;HISC/DAD-AUTO ENROLL RERUN FOR A DATE RANGE ;6/23/93  09:35
 ;;3.0;Occurrence Screen;;09/14/1993
 S QAMPARAM=$G(^QA(740,1,"QAM")),QAOPARAM=$G(^QA(740,1,"OS"))
 F QA=3:1:5 I $S($P(QAMPARAM,"^",QA)="":1,1:0) D PROBLEM G EXIT
 I $$CHKDEV($P($P(QAMPARAM,"^",2),";")) D PROBLEM G EXIT
 I $P(QAOPARAM,"^",9)'>0,$$CHKDEV($P($P(QAOPARAM,"^",5),";")) D PROBLEM G EXIT
 I $P(QAOPARAM,"^",9) S QAOSQUIT=0 D  G:QAOSQUIT EXIT
 . F QA=0:0 S QA=$O(^QA(740,1,"OS2",QA)) Q:QA'>0  D  Q:QAOSQUIT
 .. S X=$P($P(^QA(740,1,"OS2",QA,0),"^",2),";")
 .. I $$CHKDEV(X) D PROBLEM S QAOSQUIT=1
 .. Q
 . Q
 S QAQDIC="^QA(741.1,",QAQDIC(0)="AEMQZ",QAQUTIL="QAO"
 S QAQDIC("A")="Select AUTO ENROLL SCREEN: ",QAQDIC("B")="ALL"
 S QAQDIC("S")="S QAOS=^(0) I '$P(QAOS,""^"",4),$P(QAOS,""^"",5)"
 K ^UTILITY($J,"QAO"),^UTILITY($J,"QAM MONITOR") D ^QAQSELCT
 I $O(^UTILITY($J,"QAO",""))="" W *7,!!?5,"*** No screens selected !! ***",*7
 G:QAQQUIT EXIT
 S QAOSSCRN="" F  S QAOSSCRN=$O(^UTILITY($J,"QAO",QAOSSCRN)) Q:QAOSSCRN=""  F QAOSD0=0:0 S QAOSD0=$O(^UTILITY($J,"QAO",QAOSSCRN,QAOSD0)) Q:QAOSD0'>0  D
 . S QAO=$G(^QA(741.1,QAOSD0,0))
 . S QAMD0=+$P(QAO,"^",5),QA=$G(^QA(743,QAMD0,0))
 . I QA="" W !!?5,"*** No monitor found for screen ",QAOSSCRN," !! ***" Q
 . S ^UTILITY($J,"QAM MONITOR",$P(QA,"^"),QAMD0)=""
 . Q
 K ^UTILITY($J,"QAO") I $O(^UTILITY($J,"QAM MONITOR",""))="" W *7,!!?5,"*** No monitors found for any of the screens !! ***",*7 G EXIT
 D DATE^QAMAUTO4
EXIT ;
 K QA,QAM,QAMD0,QAMPARAM,QAO,QAOPARAM,QAOS,QAOSD0,QAOSSCRN,QAOSQUIT
 K QAQDIC,QAQQUIT,QAQUTIL,^UTILITY($J,"QAO"),^UTILITY($J,"QAM MONITOR")
 Q
CHKDEV(X) ; *** CHECK DEVICE FIELDS IN SITE PARAMETERS
 Q $S(X="":1,$O(^%ZIS(1,"B",X,0))'>0:1,1:0)
PROBLEM ; *** PROBLEM WITH SITE PARAMETERS
 W *7,!!?5,"*****************************************************************",!?5,"* Auto enroll has found important site parameters to be missing *"
 W !?5,"*     Edit the site parameters and enter the necessary data     *",!?5,"*****************************************************************",*7
 Q
