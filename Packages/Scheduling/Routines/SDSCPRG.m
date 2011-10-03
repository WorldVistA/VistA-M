SDSCPRG ;ALB/JAM/RBS - ASCD Purge encounters that have been deleted ; 1/19/07 12:39pm
 ;;5.3;Scheduling;**495**;Aug 13, 1993;Build 50
 ;;MODIFIED FOR NATIONAL RELEASE from a Class III software product
 ;;known as Service Connected Automated Monitoring (SCAM).
 ;
 ;**Program Description**
 ;  This program will check to see if an encounter in the 
 ;  SD SERVICE CONNECTED CHANGES File (#409.48)
 ;  has been deleted from the OUTPATIENT ENCOUNTER file (#409.68) and 
 ;  remove that record from file #409.48.
 Q
EN ;  Entry point
 N SDOE,NOACT,ACT,NCNT,WCNT,DA,DIK,LINE,SDI,SDJ,CNT
 K ^TMP("SDSCPRG",$J),^TMP("SDSCPMSG",$J)
 S DIK="^SDSC(409.48,",(SDOE,NOACT,ACT)=0,(NCNT,WCNT)=1
 F  S SDOE=$O(^SDSC(409.48,SDOE)) Q:'SDOE  D
 . I $$GETOE^SDOE(SDOE)="" D
 .. K ATEXT
 .. D GETS^DIQ(409.48,SDOE,"**","E","ATEXT")
 .. ; Initialize message
 .. S ^TMP("SDSCPRG",$J,"NO",1,0)="Encounters with No Action Taken: "_NOACT
 .. S ^TMP("SDSCPRG",$J,"WITH",1,0)="Encounters with Actions Taken: "_ACT
 .. I $D(ATEXT(409.481))>0 S ACT=ACT+1,^TMP("SDSCPRG",$J,"WITH",1,0)="Encounters with Actions Taken: "_ACT
 .. I $D(ATEXT(409.481))'>0 D  Q
 ... S NOACT=NOACT+1,^TMP("SDSCPRG",$J,"NO",1,0)="Encounters with No Action Taken: "_NOACT
 ... S NCNT=NCNT+1
 ... S LINE="  " F SDI=".07",".11",".05" S LINE=LINE_$G(ATEXT(409.48,SDOE_",",SDI,"E"))_"-"
 ... I $E(LINE,$L(LINE),$L(LINE))="-" S LINE=$E(LINE,1,$L(LINE)-1)
 ... S ^TMP("SDSCPRG",$J,"NO",NCNT,0)=LINE_"-Enc #: "_SDOE
 ... S DA=SDOE D ^DIK
 .. ;  Set information into ^TMP for report
 .. S WCNT=WCNT+1
 .. S LINE="  " F SDI=".07",".11",".05" S LINE=LINE_$G(ATEXT(409.48,SDOE_",",SDI,"E"))_"-"
 .. I $E(LINE,$L(LINE),$L(LINE))="-" S LINE=$E(LINE,1,$L(LINE)-1)
 .. S ^TMP("SDSCPRG",$J,"WITH",WCNT,0)=LINE_"-Enc #: "_SDOE
 .. S SDJ=SDOE F  S SDJ=$O(ATEXT(409.481,SDJ)) Q:SDJ=""  D
 ... S LINE="    ",WCNT=WCNT+1
 ... F SDI=".03",".02",".04" S LINE=LINE_$G(ATEXT(409.481,SDJ,SDI,"E"))_"-"
 ... I $G(ATEXT(409.481,SDJ,".06","E"))="YES" S LINE=LINE_"REVIEW"
 ... I $G(ATEXT(409.481,SDJ,".05","E"))="YES" S LINE=LINE_"SC YES"
 ... I $G(ATEXT(409.481,SDJ,".05","E"))="NO" S LINE=LINE_"SC NO"
 ... S ^TMP("SDSCPRG",$J,"WITH",WCNT,0)=LINE
 .. S DA=SDOE D ^DIK
 I '$D(^TMP("SDSCPRG",$J)) D  G END
 . N DIR,X,Y
 . I $E(IOST,1,2)="C-" S DIR(0)="E" W !!,"No records found to purge." D ^DIR
 I $D(^TMP("SDSCPRG",$J))>0 D
 . S CNT=0,SDJ=0
 . F  S SDJ=$O(^TMP("SDSCPRG",$J,"NO",SDJ)) Q:SDJ=""  D
 .. S CNT=CNT+1,^TMP("SDSCPMSG",$J,CNT,0)=^TMP("SDSCPRG",$J,"NO",SDJ,0)
 . I CNT>0 S CNT=CNT+1,^TMP("SDSCPMSG",$J,CNT,0)=""
 . S SDJ=0 F  S SDJ=$O(^TMP("SDSCPRG",$J,"WITH",SDJ)) Q:SDJ=""  D
 .. S CNT=CNT+1,^TMP("SDSCPMSG",$J,CNT,0)=^TMP("SDSCPRG",$J,"WITH",SDJ,0)
 . S XMZ(DUZ)="",XMDUZ="ASCD Purge Check",XMY("G.SDSC NIGHTLY TALLY")=""
 . S XMTEXT="^TMP(""SDSCPMSG"",$J,",XMSUB="ASCD PURGE REPORT"
 . NEW DIFROM
 . D ^XMD
 . K XMZ,XMTEXT,XMSUB,XMDUZ,XMY
 ;
END K ^TMP("DIERR",$J),^TMP("SDSCPRG",$J),^TMP("SDSCPMSG",$J)
 Q
