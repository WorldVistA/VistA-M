ECDTPD ;ALB/DAN Delete Test Patient Data from file #721 ;1/19/17  12:03
 ;;2.0;EVENT CAPTURE;**134**;;Build 12
 ;
 Q  ;Don't allow processing from the top
 ;
DEL ;Delete test patient data
 N PDT,DFN,ECIEN,PROC,CNT,PRCNM,ECDEL
 S CNT=0,ECDEL=1
 K ^TMP($J,"ECPAT") ;Delete temp storage for deleted records
 S DFN=0 F  S DFN=$O(^ECH("APAT",DFN)) Q:'+DFN  I $$TESTPAT^VADPT(DFN) D
 .S PDT=0 F  S PDT=$O(^ECH("APAT",DFN,PDT)) Q:'+PDT  S ECIEN=0 F  S ECIEN=$O(^ECH("APAT",DFN,PDT,ECIEN)) Q:'+ECIEN  D
 ..S PROC=$P($G(^ECH(ECIEN,0)),U,9) S PRCNM=$S($P(PROC,";",2)[725:$$GET1^DIQ(725,+PROC_",",1),1:"")
 ..I "^CH103^CH104^CH105^CH106^CH107^CH108^CH109^"'[("^"_PRCNM_"^") D SAVE,FILE^ECEFPAT S CNT=CNT+1 ;If test patient and procedure isn't in the list then delete the record
 D MAIL
 S $P(^XTMP("ECDELETE","DEL"),U,3)=0 ;Set status to completed
 K ^TMP($J,"ECPAT") ;Delete storage as no longer needed
 Q
 ;
SAVE ;Save information from record to be deleted for email message
 N DATA,NAMESSN,PIECE
 D GETS^DIQ(721,ECIEN_",","1;2;3;6;7;8;9","IE","DATA")
 S NAMESSN=DATA(721,ECIEN_",",1,"E")_" ("_$$GET1^DIQ(2,DATA(721,ECIEN_",",1,"I"),.09)_")"
 F PIECE=6,3,7,2,8,9 S ^TMP($J,"ECPAT",NAMESSN,ECIEN)=$G(^TMP($J,"ECPAT",NAMESSN,ECIEN))_DATA(721,ECIEN_",",PIECE,"E")_$S(PIECE'=9:"^",1:"")
 Q
 ;Send email with results of processing
MAIL ;
 N XMSUB,ECTEXT,XMDUZ,XMY,XMZ,XMTEXT,KIEN,DIFROM,NAME,LINE
 K ^TMP($J,"XMTEXT")
 S XMDUZ="Event Capture Package"
 S XMY($G(DUZ,.5))="" ;Set recipient to installer or postmaster
 S KIEN=0 F  S KIEN=$O(^XUSEC("ECMGR",KIEN)) Q:'+KIEN  S XMY(KIEN)="" ;Holders of ECMGR included in email, XUSEC read allowed by DBIA #10076
 S ^TMP($J,"XMTEXT",1)="The deletion of test patient data has completed."
 S ^TMP($J,"XMTEXT",2)="Below are the results."
 S ^TMP($J,"XMTEXT",3)=""
 S ^TMP($J,"XMTEXT",4)=$S('+$G(CNT):"No",1:CNT)_" test patient records were deleted."
 S LINE=5 ;start with line 5 to add to message
 I $G(CNT) D
 .S ^TMP($J,"XMTEXT",LINE)="",LINE=LINE+1
 .S ^TMP($J,"XMTEXT",LINE)="Deleted records, by NAME (SSN), are shown below in the following format:",LINE=LINE+1
 .S ^TMP($J,"XMTEXT",LINE)="DSS UNIT^LOCATION^CATEGORY^DATE/TIME^PROCEDURE^VOLUME",LINE=LINE+1
 .S ^TMP($J,"XMTEXT",LINE)="",LINE=LINE+1
 .S NAME="" F  S NAME=$O(^TMP($J,"ECPAT",NAME)) Q:NAME=""  D
 ..S ^TMP($J,"XMTEXT",LINE)=NAME,LINE=LINE+1,^TMP($J,"XMTEXT",LINE)=$$REPEAT^XLFSTR("-",$L(NAME)),LINE=LINE+1
 ..S REC=0 F  S REC=$O(^TMP($J,"ECPAT",NAME,REC)) Q:'+REC  S ^TMP($J,"XMTEXT",LINE)=^TMP($J,"ECPAT",NAME,REC),LINE=LINE+1
 ..S ^TMP($J,"XMTEXT",LINE)="",LINE=LINE+1
 S XMTEXT="^TMP($J,""XMTEXT"",",XMSUB="Test patient record deletion"
 D ^XMD ;Send email
 K ^TMP($J,"XMTEXT") ;No longer needed
 Q
