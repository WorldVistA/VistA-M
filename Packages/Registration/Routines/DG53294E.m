DG53294E ;ALB/RTK DG*5.3*294 Add new Enrollment Statuses ; 10/31/00
 ;;5.3;Registration;**294**;Aug 13, 1993
 ;
 ;This routine will add the two new ENROLLMENT STATUS (#27.15) 
 ;records required for the Ineligible Project.
 ;
 N SETERR
 S SETERR=0
 I '$D(^DGEN(27.15,19,0)) D
 .N DATA
 .S DATA(.01)="NOT ELIGIBLE; REFUSED TO PAY COPAY",DATA(.02)="N"
 .I $$ADD^DGENDBS(27.15,,.DATA) D
 ..S DATA(.01)="NOT ELIGIBLE; INELIGIBLE DATE"
 ..I $$ADD^DGENDBS(27.15,,.DATA) D
 ...S SETERR=1 D BMES^XPDUTL(" New ENROLLMENT STATUS entries created successfully.")
 E  I $G(^DGEN(27.15,19,0))="NOT ELIGIBLE; REFUSED TO PAY COPAY^N" S SETERR=2
MAIL ; Send a mailman msg to user with results
 N DIFROM,%
 N DATA1,FILE,IENX,TEXT,I,X,XMDUZ,XMSUB,XMTEXT,XMY,Y,STA
 K ^TMP("DG53294E",$J)
 S XMSUB="ELIGIBILITY STATUS Add"
 S XMDUZ="DG Edit Package",XMY(DUZ)="",XMY(.5)=""
 S XMTEXT="^TMP(""DG53294E"",$J,"
 D NOW^%DTC S Y=% D DD^%DT
 S ^TMP("DG53294E",$J,1)=" Ineligible Project ELIGIBILITY STATUS Add"
 S ^TMP("DG53294E",$J,2)="  "
 I SETERR=1 S ^TMP("DG53294E",$J,3)=" New ENROLLMENT STATUS entries created successfully."
 I SETERR=0 S ^TMP("DG53294E",$J,3)=" New ENROLLMENT STATUS entries were not created successfully."
 I SETERR=2 S ^TMP("DG53294E",$J,3)=" New ENROLLMENT STATUS entries already exist on the system."
 D ^XMD
 K ^TMP("DG53294E",$J)
 Q
