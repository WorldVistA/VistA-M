DG53367A ;ALB/RTK DG*5.3*367 Add new POS entry ; 3/09/01
 ;;5.3;Registration;**367**;Aug 13, 1993
 ;
 ;This routine will add HUMANITARIAN EMERGENCY Eligibility
 ;code to the ELIGIBILITY multiple of those PERIOD OF
 ;SERVICE file (#21) entries that do not currently have it.
 ;These additions are required for the Ineligible Project.
 ;
 N SETERR
 S SETERR=0
 S IEN21=0
 F  S IEN21=$O(^DIC(21,IEN21)) Q:'IEN21  D
 . I '$D(^DIC(21,IEN21,"E",8)) D
 . . K DATA,FDAIEN,IEN,MSG
 . . S IEN="+1,"_IEN21_","
 . . S DATA(21.01,IEN,.01)=8
 . . S FDAIEN(1)=8
 . . D UPDATE^DIE("","DATA","FDAIEN","MSG") S SETERR=1
MAIL ; Send a mailman msg to user with results
 N DIFROM,%
 N DATA1,FILE,IENX,TEXT,I,X,XMDUZ,XMSUB,XMTEXT,XMY,Y,STA
 K ^TMP("DG53367A",$J)
 S XMSUB="POS File HUMANITARIAN EMERGENCY Add"
 S XMDUZ="DG Edit Package",XMY(DUZ)="",XMY(.5)=""
 S XMTEXT="^TMP(""DG53367A"",$J,"
 D NOW^%DTC S Y=% D DD^%DT
 S ^TMP("DG53367A",$J,1)=" Ineligible Project POS Entry Add"
 S ^TMP("DG53367A",$J,2)="  "
 I SETERR=1 S ^TMP("DG53367A",$J,3)=" New POS entries created successfully."
 I SETERR=0 S ^TMP("DG53367A",$J,3)=" New POS entries not created - correct entries already exist."
 D ^XMD
 K ^TMP("DG53367A",$J)
 Q
