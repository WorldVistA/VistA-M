EASEZFM ;ALB/jap,TM - Filing 1010EZ Data to Patient Database ; 3/13/09 4:51pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**1,93**;Mar 15, 2001;Build 2
 ;
QUE ;entry point from queued background job
 ;
 ;check signature verification before continuing
 K ^TMP("1010EZERROR",$J)
 Q:'$G(EASAPP)
 Q:'$D(^EAS(712,EASAPP,0))
 S EASEZNEW=$P(^EAS(712,EASAPP,0),U,11)
 S X=$G(^EAS(712,EASAPP,1))
 ;recheck signature status
 I ('$P(X,U,1))&('$P(X,U,2)) D RESET Q
 ;
 L +^EAS(712,EASAPP):60 I '$T D RESET Q
 ;check incoming data
 D CHECK
 ;
 ;get EZ1010 data into ^TMP("EZDATA" array
 D EN^EASEZC1(EASAPP,.EASDFN)
 ;
 ;store file #2 data
 L +^DPT(EASDFN):60 I '$T D RESET Q
 D F2^EASEZF1(EASAPP,EASDFN)
 L -^DPT(EASDFN)
 ;
 ;store file #408.12, #408.13, #408.21, #408.22 data
 D F408^EASEZF2(EASAPP,EASDFN)
 ;
 ;store file #355.33 data;
 ;call IB API to file health insurance and Medicare data
 D IBINS^EASEZF5(EASAPP,EASDFN)
 ;
 ;update 'new patient' remark
 I EASEZNEW D
 .S REM="New Patient record added by ELECTRONIC 10-10EZ."
 .S DA=EASDFN,DIE="^DPT(",DR=".091///^S X=REM"
 .D ^DIE
 ;update processing status if not already done
 I $P($G(^EAS(712,EASAPP,2)),U,5)="" D SETDATE^EASEZU2(EASAPP,"FIL")
 ;remove the task id
 S $P(^EAS(712,EASAPP,2),U,11)=""
 L -^EAS(712,EASAPP)
 I $D(^TMP("1010EZERROR",$J)) D MAILERR
 S ZTREQ="@"
 Q
 ;
CHECK ;check data
 ;returns '0' if any invalid data found; otherwise '1'
 N SUBIEN,X,CHK,DIK,DA
 ;remove any 'noise' from incoming data
 S SUBIEN=0 F  S SUBIEN=$O(^EAS(712,EASAPP,10,SUBIEN)) Q:+SUBIEN=0  D
 .S CHK=$P($G(^EAS(712,EASAPP,10,SUBIEN,1)),U,1)
 .I (CHK="/")!(CHK="//")!(CHK="-")!(CHK="--")!(CHK=" ")!(CHK="") D
 ..S DA=SUBIEN,DA(1)=EASAPP,DIK="^EAS(712,"_DA(1)_",10,"
 ..D ^DIK
 Q
 ;
CLEAN ; cleanup
 K ^TMP("EZDATA",$J),^TMP("EZINDEX",$J),^TMP("EZTEMP",$J),^TMP("EZDISP",$J)
 Q
 ;
MAILERR ;notify user if any data elements failed FM validator
 ;
 N XMY,XMSUB,XMDUZ,XMTEXT,Y
 ;fill-in first 6 lines of message
 S ^TMP("1010EZERROR",$J,1,0)="Errors were returned by the FileMan validator when filing 1010EZ"
 S ^TMP("1010EZERROR",$J,2,0)="data for --"
 S ^TMP("1010EZERROR",$J,3,0)="Applicant:     "_$P($G(^EAS(712,EASAPP,0)),U,4)
 S ^TMP("1010EZERROR",$J,4,0)="Application #: "_EASAPP
 S Y=DT D DD^%DT
 S ^TMP("1010EZERROR",$J,5,0)="Filing Date:   "_Y
 S ^TMP("1010EZERROR",$J,6,0)=" "
 ;setup call to MailMan
 S XMSUB="EAS 1010EZ Error Report for APP #"_EASAPP,XMDUZ=.5
 S XMY(DUZ)=""
 S XMTEXT="^TMP(""1010EZERROR"",$J,"
 D ^XMD
 K ^TMP("1010EZERROR",$J)
 Q
 ;
RESET ;remove filing date if can't continue
 S FDT=$P(^EAS(712,EASAPP,2),U,5),$P(^EAS(712,EASAPP,2),U,5)=""
 S $P(^EAS(712,EASAPP,2),U,6)="",$P(^EAS(712,EASAPP,2),U,11)=""
 I FDT K ^EAS(712,"FIL",FDT,EASAPP)
 D APPINDEX^EASEZU2(EASAPP)
 Q
