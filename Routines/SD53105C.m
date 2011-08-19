SD53105C ;ALB/JRP - BULLETINS FOR PATCH 105;12-MAR-1997
 ;;5.3;Scheduling;**105,132**;Aug 13, 1993
 ;
BULL1 ;Generate/send completion bulletin for cleanup #1 (see EN^SD53105A)
 ;
 ;Input  : ^TMP($J,"SD53105A") defined as follows
 ;           ^("XMIT") = Total Checked
 ;                       ^ Total deleted because of bad Encounter ptr
 ;                       ^ Total deleted because of bad Del Enc ptr
 ;                       ^ Total marked for retransmission
 ;           ^("DEL") = Total Checked ^ Total Deleted
 ;           ^("ERR") = Total Checked ^ Total Deleted
 ;           ^("TIME") = Start (FM) ^ End (FM)
 ;           ^("STOP") = Task asked to stop (1/0)
 ;Output : None
 ;Notes  : Existance of ^TMP($J,"SD53105A") is assumed
 ;
 ;Declare varibales
 N XMB,XMTEXT,XMY,XMDUZ,XMZ,NODE,LINE
 ;Initialize bulletin space
 K ^TMP($J,"SD53105-BULL1")
 S LINE=1
 ;Asked to stop
 I (^TMP($J,"SD53105A","STOP")) D
 .S ^TMP($J,"SD53105-BULL1",LINE)="*** Note that process was asked to stop and did not run to completion ***"
 .S ^TMP($J,"SD53105-BULL1",(LINE+1))=" "
 .S LINE=LINE+2
 ;Time summary
 S NODE=^TMP($J,"SD53105A","TIME")
 S ^TMP($J,"SD53105-BULL1",LINE)="Process began on "_$$FMTE^XLFDT($P(NODE,"^",1))_" and completed on "_$$FMTE^XLFDT($P(NODE,"^",2))
 S ^TMP($J,"SD53105-BULL1",(LINE+1))=" "
 S LINE=LINE+2
 ;Transmitted Outpatient Encounter file summary
 S NODE=^TMP($J,"SD53105A","XMIT")
 S ^TMP($J,"SD53105-BULL1",LINE)="A total of "_(+$P(NODE,"^",1))_" entries in the Transmitted Outpatient Encounter file were"
 S ^TMP($J,"SD53105-BULL1",(LINE+1))="checked and "_(+$P(NODE,"^",2))_" of them were deleted because of bad pointers to the"
 S ^TMP($J,"SD53105-BULL1",(LINE+2))="Outpatient Encounter file and "_(+$P(NODE,"^",3))_" of them were deleted because of bad"
 S ^TMP($J,"SD53105-BULL1",(LINE+3))="pointers to the Deleted Outpatient Encounter file.  In addition to this,"
 S ^TMP($J,"SD53105-BULL1",(LINE+4))=(+$P(NODE,"^",4))_" entries were marked for re-transmission because they were rejected and"
 S ^TMP($J,"SD53105-BULL1",(LINE+5))="did not contain a reason for rejection in the Transmitted Outpatient"
 S ^TMP($J,"SD53105-BULL1",(LINE+6))="Encounter Error file."
 S ^TMP($J,"SD53105-BULL1",(LINE+7))=" "
 S LINE=LINE+8
 ;Deleted Outpatient Encounter file summary
 S NODE=^TMP($J,"SD53105A","DEL")
 S ^TMP($J,"SD53105-BULL1",LINE)="A total of "_(+$P(NODE,"^",1))_" entries in the Deleted Outpatient Encounter file were"
 S ^TMP($J,"SD53105-BULL1",(LINE+1))="checked and "_(+$P(NODE,"^",2))_" of them were deleted because an associated entry in the"
 S ^TMP($J,"SD53105-BULL1",(LINE+2))="Transmitted Outpatient Encounter file could not be found."
 S ^TMP($J,"SD53105-BULL1",(LINE+3))=" "
 S LINE=LINE+4
 ;Transmitted Outpatient Encounter Error file summary
 S NODE=^TMP($J,"SD53105A","ERR")
 S ^TMP($J,"SD53105-BULL1",LINE)="A total of "_(+$P(NODE,"^",1))_" entries in the Transmitted Outpatient Encounter Error file"
 S ^TMP($J,"SD53105-BULL1",(LINE+1))="were checked and "_(+$P(NODE,"^",2))_" of them were deleted because of bad pointers to the"
 S ^TMP($J,"SD53105-BULL1",(LINE+2))="Transmitted Outpatient Encounter file."
 S ^TMP($J,"SD53105-BULL1",(LINE+3))=" "
 S LINE=LINE+4
 ;Send completion bulletin
 S XMB="SCDX AMBCARE TO NPCDB SUMMARY"
 S XMB(1)="ACRP cleanup of files 409.73, 409.74, and 409.75"
 S XMTEXT="^TMP($J,""SD53105-BULL1"","
 S XMY(DUZ)=""
 S XMDUZ="ACRP - SD*5.3*105"
 D ^XMB
 ;Done - clean up and quit
 K ^TMP($J,"SD53105-BULL1")
 Q
 ;
