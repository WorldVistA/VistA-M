IVM2071M ;ALB/RMM MT Cleanup Mailman Msg ; 23 DEC 2002
 ;;2.0;INCOME VERIFICATION MATCH;**71**;21-OCT-94
 ;
 ; A MailMan message will be sent to the user when the cleanup process
 ; is complete.
 ;
 ;
MAIL ; Send a mailman msg to user with results
 N DIFROM,NODE,MSG,XMDUZ,XMSUB,XMTEXT,XMY
 S XMSUB="Future Dated MT Distribution/Cleanup"
 S XMDUZ="IVM*2.0*71 Distribution/Cleanup",XMY(DUZ)=""
 S XMY("richard.muller@med.va.gov")=""
 S XMTEXT="MSG(",NODE=0
 S NODE=NODE+1,MSG(NODE)="Income Test Data (Z10) transmissions may not have"
 S NODE=NODE+1,MSG(NODE)="been successfully received/uploaded for Income Tests"
 S NODE=NODE+1,MSG(NODE)="where the effective date of the test has been updated"
 S NODE=NODE+1,MSG(NODE)="at the HEC."
 S NODE=NODE+1,MSG(NODE)=""
 S NODE=NODE+1,MSG(NODE)="An IVM FINANCIAL QUERY has been transmitted to the HEC"
 S NODE=NODE+1,MSG(NODE)="for each of these records."
 S NODE=NODE+1,MSG(NODE)=""
 S NODE=NODE+1,MSG(NODE)=$$REPEAT^XLFSTR("=",50)
 S NODE=NODE+1,MSG(NODE)="Number of records processed:   "_$$RJ^XLFSTR(+$G(^XTMP("IVM71",1)),12)
 S NODE=NODE+1,MSG(NODE)="Number of queries transmitted: "_$$RJ^XLFSTR(+$G(^XTMP("IVM71",2)),12)
 S NODE=NODE+1,MSG(NODE)=$$REPEAT^XLFSTR("=",50)
 S NODE=NODE+1,MSG(NODE)=""
 ;
 D ^XMD
 ;
 Q
