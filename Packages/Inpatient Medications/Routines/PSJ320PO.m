PSJ320PO ;BIR/TC - Post Install routine for patch PSJ*5*320 ;06/16/15
 ;;5.0;INPATIENT MEDICATIONS ;**320**;9/30/97;Build 7
 ;
 ; Reference to ^PS(55 is supported by DBIA #2191.
 ; Reference to ^OR(100 is supported by DBIA# 3582.
 ;
QUE ;
 N NAMSP,PATCH,JOBN,ZTSK,ZTRTN,ZTIO,ZTDTH,ZTDESC,Y,ZTQUEUED,ZTREQ,ZTSAVE,CNT,PSJCNT,SBJM,RESTART,SMSG
 S NAMSP="PSJ320PO"
 S JOBN="PSJ*5*320 Post Install"
 S PATCH="PSJ*5*320"
 S Y=$$NOW^XLFDT S ZTDTH=$$FMTH^XLFDT(Y)
 ;
 D BMES^XPDUTL("=============================================================")
 D MES^XPDUTL("Queuing background job for "_JOBN_"...")
 D MES^XPDUTL("Start time: "_$$HTE^XLFDT(ZTDTH))
 D MES^XPDUTL("A MailMan message will be sent to the installer upon Post")
 D MES^XPDUTL("Install Completion.  This may take 4-5 minutes.")
 D MES^XPDUTL("==============================================================")
 ;
 S ZTRTN="EN^"_NAMSP,ZTIO=""
 S (SBJM,ZTDESC)="Background job for "_JOBN
 S ZTSAVE("JOBN")="",ZTSAVE("ZTDTH")="",ZTSAVE("DUZ")="",ZTSAVE("SBJM")=""
 D ^%ZTLOAD
 D:$D(ZTSK)
 . D MES^XPDUTL("*** Task #"_ZTSK_" Queued! ***")
 . D BMES^XPDUTL("")
 . S ZTSAVE("ZTSK")=""
 D BMES^XPDUTL("")
 K XPDQUES
 Q
 ;
EN ; Do mail message
 N PSJDFN,DA,STARTH,STOPH,SUBJ
 S STARTH=$$HTE^XLFDT(ZTDTH)
 K ^TMP("PSJOR",$J),^TMP("PSJTEXT",$J) S PSJCNT=0
 S PSJLOC="" F  S PSJLOC=$O(^DPT("CN",PSJLOC)) Q:PSJLOC=""  D
 .S PSJDFN=0 F  S PSJDFN=$O(^DPT("CN",PSJLOC,PSJDFN)) Q:PSJDFN'>0  D
 ..S PSJDTS=DT F  S PSJDTS=$O(^PS(55,PSJDFN,5,"AUS",PSJDTS)) Q:PSJDTS'>0  F PSJL=5,"IV" D
 ...S PSJON=0 F  S PSJON=$O(^PS(55,PSJDFN,PSJL,"AUS",PSJDTS,PSJON)) Q:+PSJON'>0  D 
 ....S PSJORDN1=$P($G(^PS(55,PSJDFN,PSJL,+PSJON,0)),U,21) S PSJNODE4=$G(^OR(100,+PSJORDN1,4)),PSJND=$E(PSJNODE4,$L(PSJNODE4)-1,$L(PSJNODE4)) I PSJND["UU" D
 .....S PSJCNT=PSJCNT+1,$P(PSJLINE," ",77)=""
 .....S PSJDATA=$E(PSJDFN_PSJLINE,1,20)_" "_$E(+PSJORDN1_PSJLINE,1,15)_" "_PSJNODE4
 .....S ^TMP("PSJOR",$J,PSJCNT)=PSJDATA
 ;
 ;Send message
 S Y=$$NOW^XLFDT S STOPH=$$FMTH^XLFDT(Y),STOPH=$$HTE^XLFDT(STOPH)
 S XMDUZ="PSJ*5*320 POST INSTALL Complete"
 S XMY(DUZ)=""
 S ^TMP("PSJTEXT",$J,1)="The background job "_ZTSK_" began "_STARTH_" and "
 S ^TMP("PSJTEXT",$J,2)="ended "_STOPH_"."
 S ^TMP("PSJTEXT",$J,3)=" "
 I PSJCNT<1 S ^TMP("PSJTEXT",$J,4)="     NO AFFECTED ORDERS FOUND     " D MAIL K ^TMP("PSJTEXT",$J),^TMP("PSJOR",$J) Q
 S ^TMP("PSJTEXT",$J,4)="The following orders contain ""UU"" in Node 4 of the Order File (#100) "
 S ^TMP("PSJTEXT",$J,5)=" "
 S ^TMP("PSJTEXT",$J,6)="          STEPS TO CORRECT THE DATA     "
 S ^TMP("PSJTEXT",$J,7)=" 1)  Discontinue the affected order(s) and re-enter them "
 S ^TMP("PSJTEXT",$J,8)=" 2)  Using Fileman, delete the patient from BCBU Workstation (file #53.7)"
 S ^TMP("PSJTEXT",$J,9)=" 3)  Do a Single Patient Init (PSB BCBU INIT SINGLE PT) for each patient "
 S ^TMP("PSJTEXT",$J,10)=" "
 S ^TMP("PSJTEXT",$J,11)=" If you have any questions on this process, please log a remedy ticket "
 S ^TMP("PSJTEXT",$J,12)=" "
 S ^TMP("PSJTEXT",$J,13)="  DFN                ORDER #         NODE 4   "
 S PSJTXLN=14
 F PSJCNT=0:0 S PSJCNT=$O(^TMP("PSJOR",$J,PSJCNT)) Q:'PSJCNT  S ^TMP("PSJTEXT",$J,PSJTXLN)=$G(^TMP("PSJOR",$J,PSJCNT)),PSJTXLN=PSJTXLN+1
 D MAIL
 K ^TMP("PSJTEXT",$J),^TMP("PSJOR",$J)
 Q
MAIL ;
 N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY,I
 S XMDUZ="INPT PHARMACY",XMSUB=SBJM,XMTEXT="^TMP(""PSJTEXT"","_$J_","
 S XMY(DUZ)=""
 D ^XMD
 Q ""
 ;
