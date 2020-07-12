DGPTFN1 ;ISP/RFR - PTF ICD CODE NOTIFIER;Oct 04, 2019@16:25
 ;;5.3;Registration;**932**;Aug 13, 1993;Build 210
 ;
 Q
EN ;NOTIFY PACKAGES OF CODE CHANGE(S)
 I '$D(ZTQUEUED) D
 .W @IOF
 .W !?19,"* * * PTF ICD CODE CHANGE NOTIFIER * * *",!!
 N NAME,NODE,DIC,X
 S NAME="DG PTF ICD NOTIFIER"
 I '$D(^XTMP(NAME))!($O(^XTMP(NAME,0))="") D  Q
 .I '$D(ZTQUEUED) W "THERE ARE NO DATA CHANGES TO PROCESS.",! H 3
 L +^XTMP(NAME):DILOCKTM
 I '$T D  Q
 .I '$D(ZTQUEUED) W "ANOTHER PROCESS IS ALREADY PROCESSING DATA CHANGES.",! H 3
 K ^TMP(NAME,$J)
 S NODE=0 F  S NODE=$O(^XTMP(NAME,NODE)) Q:NODE=""  D
 .I '$D(ZTQUEUED) W "PROCESSING """_NODE_"""..."
 .M ^TMP(NAME,$J)=^XTMP(NAME,NODE)
 .S DIC=101,X="DG PTF ICD DIAGNOSIS NOTIFIER"
 .D EN^XQOR
 .K DIC,X,^TMP(NAME,$J),^XTMP(NAME,NODE)
 .I '$D(ZTQUEUED) W "DONE",!
 L -^XTMP(NAME)
 I '$D(ZTQUEUED) W !,"FINISHED PROCESSING ALL DATA CHANGES.",! H 3
 Q
