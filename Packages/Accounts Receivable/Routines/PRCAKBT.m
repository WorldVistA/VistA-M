PRCAKBT ;WASH-ISC@ALTOONA,PA/CMS-AR BUILD TEMP ARCHIVE FILE ;9/10/93  8:39 AM ;9/10/93  8:26 AM
V ;;4.5;Accounts Receivable;;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 NEW ZTDESC,ZTIO,ZTRTN,ZTSAVE,%
 I $P($G(^PRCAK(430.8,0)),U,3)>0 W !!,*7,"The temporary storage file already has data!" G Q
 W !!,"This option will build the temporary storage file (AR Archive File 430.8)",!,"with all the data and corresponding transactions from the bills in the",!,"Pending Archive status."
 W !!,"The use of this option should be coordinated with the IRM System Manager to",!,"determine disk and journal space!"
 S STAT=$O(^PRCA(430.3,"AC",114,0)) I $P(^PRCA(430.3,+$G(STAT),0),U)'="PENDING ARCHIVE" W !!,*7,"The PENDING ARCHIVE File 430.3 entry is not setup properly, contact IRM." G Q
 W !!,"ARE YOU SURE YOUR SYSTEM IS READY " S %=2 D YN^DICN I %'=1 G Q
 W !,"I'll send you a mail message when I am done.",!
 S ZTRTN="DQ^PRCAKBT",ZTDESC="Build AR Archive File",ZTIO="" D ^%ZTLOAD
Q Q
DQ ;
 NEW CNT,DA,DIC,DIQ,DR,FIL,II,STAT
 L +^PRCAK("PRCAK"):1 I '$T D BUSY^PRCAKS("Build Temporary Storage") G END
 S STAT=$O(^PRCA(430.3,"AC",114,0))
 K ^TMP("PRCAK",$J),^UTILITY("DIQ1",$J) S ^TMP("PRCAK",$J,"E")=9
 S DR=.01,DIQ(0)="N"
 F FIL="430","430.01","430.02","430.051","430.098","433","433.01","433.041","433.061" S DIC="^DD("_FIL_"," D
 .F DA=0:0 S DA=$O(^DD(FIL,DA)) Q:'DA  D EN^DIQ1 D
 ..I '$D(^UTILITY("DIQ1",$J)) S ^TMP("PRCAK",$J,"E","D430")="Could not build File "_FIL_" Field Records" Q
 ..F II=0:0 S II=$O(^UTILITY("DIQ1",$J,0,II)) Q:'II  S ^TMP("PRCAK",$J,"F",FIL,II)=^(II,.01) K ^UTILITY("DIQ1",$J,0,II)
 I ^TMP("PRCAK",$J,"E")>9 D BULL G END
 D ^PRCAKBT1
 D BULL
 L -^PRCAK("PRCAK")
END Q
BULL ;Send total in bulletin
 N XMDUZ,XMSUB,XMTEXT,XMY,X1
 S XMDUZ="AR ARCHIVE PACKAGE",XMSUB="BUILD TEMP ARCHIVE FILE",XMY(+DUZ)="",XMTEXT="^TMP(""PRCAK"",$J,""E"","
 I ^TMP("PRCAK",$J,"E")>9 G R0
 S ^TMP("PRCAK",$J,"E",1)="  The AR Build Temporary Archive process successfully completed.",^TMP("PRCAK",$J,"E",2)="      A total of "_+$G(CNT)_" archive records were created."
 S ^TMP("PRCAK",$J,"E",3)=" ",^TMP("PRCAK",$J,"E",4)="You/IRM may move the archived records to permanent storage.",^TMP("PRCAK",$J,"E",5)=" ",^TMP("PRCAK",$J,"E",6)="Have a Nice Day!" G XM
R0 ;All Bills not successfully moved
 S ^TMP("PRCAK",$J,"E",1)="  The AR Build Temporary Archive process DID NOT successfully move all",^TMP("PRCAK",$J,"E",2)="  the AR Bills in the Pending Archive status to the temporary storage file."
 S ^TMP("PRCAK",$J,"E",3)="  A total of "_+$G(CNT)_" archive records were created.",^TMP("PRCAK",$J,"E",4)=" "
 S ^TMP("PRCAK",$J,"E",5)="   Below is the list of bills and explanations.",^TMP("PRCAK",$J,"E",6)="   Refer to the A/R Technical Manual for steps to correct these entries."
 S ^TMP("PRCAK",$J,"E",7)="   After corrective action has been taken, 'Unmark' these entries."
 S ^TMP("PRCAK",$J,"E",8)="   The entries will be archived when the next time the archive process is run.",^TMP("PRCAK",$J,"E",9)="  "
XM D ^XMD K ^TMP("PRCAK",$J),^UTILITY("DIQ1",$J)
 Q
