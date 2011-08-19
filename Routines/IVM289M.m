IVM289M ;ALB/RMM IVM Patient File Xref Cleanup Mailman Msg ; 01/27/2004
 ;;2.0;INCOME VERIFICATION MATCH;**89**:21-OCT-94
 ;
 ; This routine was created to handle MailMan message for the
 ; Cleanup in Patch IVM*2*89
 ;
MAIL ; Send a mailman msg to user with results
 N DIFROM,%,X,XMDUZ,XMSUB,XMTEXT,XMY,Y,MSG
 N LNCNT
 ;
 K ^TMP("IVM289",$J)
 S XMSUB="IVM Patient File Xref Cleanup"
 S XMDUZ="IVM Cleanup Package",XMY(DUZ)=""
 S XMTEXT="MSG("
 ;
BLDHD ; Build the message head section of the report
 S LNCNT=0
 S LNCNT=LNCNT+1,MSG(LNCNT)="        IVM Patient File Xref Cleanup"
 S LNCNT=LNCNT+1,MSG(LNCNT)="        Patch IVM*2.0*89 Post Install"
 S LNCNT=LNCNT+1,MSG(LNCNT)=$$REPEAT^XLFSTR("=",50)
 ;
BLDBDY ; Build the data section of the report
 S LNCNT=LNCNT+1,MSG(LNCNT)=" Recap of Purged Xrefs for Future Dated"
 S LNCNT=LNCNT+1,MSG(LNCNT)="            Income Tests"
 S LNCNT=LNCNT+1,MSG(LNCNT)=$$REPEAT^XLFSTR("-",50)
 S LNCNT=LNCNT+1,MSG(LNCNT)="      Invalid 301.5 record pointers: "_$$RJ^XLFSTR($FN(^XTMP("IVM289",0,"IVM"),","),6)
 S LNCNT=LNCNT+1,MSG(LNCNT)="     Invalid 408.31 record pointers: "_$$RJ^XLFSTR($FN(^XTMP("IVM289",0,"DGMT"),","),6)
 S LNCNT=LNCNT+1,MSG(LNCNT)="             Duplicate xref entries: "_$$RJ^XLFSTR($FN(^XTMP("IVM289",0,"DUP"),","),6)
 S LNCNT=LNCNT+1,MSG(LNCNT)=$$REPEAT^XLFSTR("-",50)
 S LNCNT=LNCNT+1,MSG(LNCNT)="                Total xrefs checked: "_$$RJ^XLFSTR($FN(^XTMP("IVM289",0,"TOT"),","),6)
 S LNCNT=LNCNT+1,MSG(LNCNT)="                Total xrefs deleted: "_$$RJ^XLFSTR($FN(^XTMP("IVM289",0,"DEL"),","),6)
 S LNCNT=LNCNT+1,MSG(LNCNT)=$$REPEAT^XLFSTR("-",50)
 ;
SNDMSG ; Send the MailMan message
 D ^XMD
 ;
 Q
