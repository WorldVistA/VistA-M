SD53138B ;ALB/SEK - BULLETIN FOR PATCH 138;12-JAN-1998
 ;;5.3;Scheduling;**138**;Aug 13, 1993
 ;
BULL1 ;Generate/send completion bulletin for clean-up (see EN^SD53138A)
 ;
 ;Input  : ^TMP($J,"SD53138A") defined as follows
 ;           ^("XMIT") = Total Checked
 ;                       ^ Total marked for retransmission
 ;           ^("TIME") = Start (FM) ^ End (FM)
 ;           ^("STOP") = Task asked to stop (1/0)
 ;Output : None
 ;Notes  : Existance of ^TMP($J,"SD53138A") is assumed
 ;
 ;Declare varibales
 N XMB,XMTEXT,XMY,XMDUZ,XMZ,NODE,LINE
 ;Initialize bulletin space
 K ^TMP($J,"SD53138-BULL1")
 S LINE=1
 ;Asked to stop
 I (^TMP($J,"SD53138A","STOP")) D
 .S ^TMP($J,"SD53138-BULL1",LINE)="*** Note that process was asked to stop and did not run to completion ***"
 .S ^TMP($J,"SD53138-BULL1",(LINE+1))=" "
 .S LINE=LINE+2
 ;Time summary
 S NODE=^TMP($J,"SD53138A","TIME")
 S ^TMP($J,"SD53138-BULL1",LINE)="Process began on "_$$FMTE^XLFDT($P(NODE,"^",1))_" and completed on "_$$FMTE^XLFDT($P(NODE,"^",2))
 S ^TMP($J,"SD53138-BULL1",(LINE+1))=" "
 S LINE=LINE+2
 ;Transmitted Outpatient Encounter file summary
 S NODE=^TMP($J,"SD53138A","XMIT")
 S ^TMP($J,"SD53138-BULL1",LINE)="A total of "_(+$P(NODE,"^",1))_" entries in the Transmitted Outpatient Encounter file were"
 S ^TMP($J,"SD53138-BULL1",(LINE+1))="checked and "_(+$P(NODE,"^",2))_" entries were marked for re-transmission because they were"
 S ^TMP($J,"SD53138-BULL1",(LINE+2))="rejected and did not contain a reason for rejection in the"
 S ^TMP($J,"SD53138-BULL1",(LINE+3))="Transmitted Outpatient Encounter Error file."
 S ^TMP($J,"SD53138-BULL1",(LINE+4))=" "
 S LINE=LINE+5
 ;Send completion bulletin
 S XMB="SCDX AMBCARE TO NPCDB SUMMARY"
 S XMB(1)="ACRP clean-up of file 409.75"
 S XMTEXT="^TMP($J,""SD53138-BULL1"","
 S XMY(DUZ)=""
 S XMDUZ="ACRP - SD*5.3*138"
 D ^XMB
 ;Done - clean-up and quit
 K ^TMP($J,"SD53138-BULL1")
 Q
 ;
 ;
LATEBULL() ;Determine if user wishes to prevent generation of Late ACRP
 ; Related Activity bulletin
 ;
 ;Input  : None
 ;Output : 1 = Yes
 ;         0 = No
 ;        -1 = User abort/time out
 ;
 ;Declare variables
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;Set up call to Reader
 S DIR("?",1)="Generation of the Late ACRP Related Activity bulletin will be prevented"
 S DIR("?",2)="by removing the mail group contained in the LATE ACTIVITY MAIL GROUP"
 S DIR("?",3)="field (#217) of the MAS PARAMETERS file (#43) at the beginning of the"
 S DIR("?")="process and restoring it at the end of the process"
 S DIR(0)="Y"
 S DIR("A")="Prevent generation of Late ACRP Related Activity bulletin"
 S DIR("B")="NO"
 ;Call Reader
 D ^DIR
 ;Abort/time out
 Q:($D(DIRUT)) -1
 ;Convert answer to proper output
 Q $S((+Y<1):0,1:1)
 ;
OK() ;Determine if user wishes to continue
 ;
 ;Input  : None
 ;Output : 1 = Yes
 ;         0 = No
 ;Notes  : Zero (0) is returned on user abort/time out
 ;
 ;Declare variables
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;Set up call to Reader
 S DIR(0)="Y"
 S DIR("A")="OK to continue"
 S DIR("B")="NO"
 ;Call Reader
 D ^DIR
 ;Convert answer to proper output
 Q $S((+Y<1):0,1:1)
 ;
GETLAMG() ;Return pointer to and name of mail group contained in LATE
 ; ACTIVITY MAIL GROUP field (#217) of the MAS PARAMETERS file (#43)
 ;
 ;Input  : None
 ;Output : Ptr ^ Name - Pointer to mail group ^ Name of mail group
 ;Notes  : NULL will be returned if a valid mail group isn't found
 ;
 ;Declare variables
 N MGPTR,MGNAME,SD53138T,SD53138M
 ;Get internal & external value of field
 D GETS^DIQ(43,"1,",217,"IE","SD53138T","SD53138M")
 Q:($D(SD53138M)) ""
 ;Grab pointer and name from array
 S MGPTR=SD53138T(43,"1,",217,"I")
 S MGNAME=SD53138T(43,"1,",217,"E")
 ;No value - return NULL
 Q:(('MGPTR)!(MGNAME="")) ""
 ;Done
 Q MGPTR_"^"_MGNAME
 ;
SETLAMG(MGPTR,DELOK) ;Update value contained in the LATE ACTIVITY MAIL GROUP
 ; field (#217) of the MAS PARAMETERS file (#43)
 ;
 ;Input  : MGPTR - Pointer to mail group
 ;         DELOK - Flag indicating if deletion is allowed
 ;                 1 = Yes - MGPTR can be zero
 ;                 0 = No - MGPTR can not be zero (default)
 ;Output : None
 ;
 ;Check input
 S MGPTR=+$G(MGPTR)
 S DELOK=+$G(DELOK)
 Q:(('MGPTR)&('DELOK))
 ;Declare variables
 N SD53138F,SD53138M
 ;Validate pointer
 I (MGPTR) Q:($$EXTERNAL^DILFD(43,217,"",MGPTR,"SD53138M")="")
 ;Convert 0 to @ (if deleting)
 S:('MGPTR) MGPTR="@"
 ;Set up FDA array
 S SD53138F(43,"1,",217)=MGPTR
 ;Update
 D FILE^DIE("S","SD53138F","SD53138M")
 ;Done
 Q
