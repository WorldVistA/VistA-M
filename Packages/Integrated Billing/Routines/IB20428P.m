IB20428P ;ALB/LBD - POST-INIT FOR IB*2.0*428; 11/25/2008 ; 1/7/10 10:49am
 ;;2.0;INTEGRATED BILLING;**428**;21-MAR-94;Build 1
 ;
MCRDED ; Update Medicare Deductible rate for CY 2010
 ; check to see if rate already entered.
 N IBA,IBERRM,IBIEN,IBRN,IBTYPE,DA,DIK
 S IBTYPE="Medicare Deductible"
 D BMES^XPDUTL("Updating Medicare Deductible Rate for 01/01/2010")
 S IBIEN=0
 F  S IBIEN=$O(^IBE(350.2,"B","MEDICARE DEDUCTIBLE",IBIEN)) Q:'IBIEN  D
 . Q:$P($G(^IBE(350.2,IBIEN,0)),"^",2)'>3090101
 . S DIK="^IBE(350.2,",DA=IBIEN D ^DIK
 S IBA(350.2,"+1,",.01)="MEDICARE DEDUCTIBLE"
 S IBA(350.2,"+1,",.02)=3100101
 S IBA(350.2,"+1,",.03)=$O(^IBE(350.1,"B","MEDICARE DEDUCTIBLE",""))
 S IBA(350.2,"+1,",.04)=1100
 D UPDATE^DIE("","IBA","","IBERRM") ; file the new record
 I $D(IBERRM) D
 . D BMES^XPDUTL("Unable to file the new rate.  The error message is as follows:")
 . S IBRN=0
 . F  S IBRN=$O(IBERRM("DIERR",1,"TEXT",IBRN)) Q:IBRN=""  D MES^XPDUTL(IBERRM("DIERR",1,"TEXT",IBRN))
 . D BMES^XPDUTL("Please check the database and then file the new rate manually.")
 . D MMSG
 E  D COMPLETE
MCRX Q
 ;
 ;
MMSG ; MailMan message to report update problem to billing groups, patch installer and patch developer
 N DA,IBC,IBGROUP,IBPARAM,IBTXT,XMDUZ,XMSUB,XMTEXT,XMY
 S XMSUB="Integrated Billing Annual Rate Update Error"
 S XMDUZ=DUZ,XMTEXT="IBTXT"
 S IBPARAM("FROM")="PATCH IB*2.0*428 CY 2010 RATE UPDATE"
 F IBGROUP="IB EDI SUPERVISOR","IB ERROR","MCCR" D
 . I $D(^XMB(3.8,"B",IBGROUP)) S IBGROUP="G."_IBGROUP,XMY(IBGROUP)=""
 S XMY(DUZ)=""
 ;
 S IBC=0
 S IBC=IBC+1,IBTXT(IBC)="This message has been sent by patch IB*2.0*428. If you have received this"
 S IBC=IBC+1,IBTXT(IBC)="message, it indicates that the patch encountered some difficulty in filing"
 S IBC=IBC+1,IBTXT(IBC)="the CY 2010 "_IBTYPE_" rate as outlined in the patch description."
 S IBC=IBC+1,IBTXT(IBC)="Please verify the integrity of file 350.2 IB ACTION CHARGE and then enter"
 S IBC=IBC+1,IBTXT(IBC)="the new rate manually. You can consult the IB*2.0*428 patch description"
 S IBC=IBC+1,IBTXT(IBC)="for additional information."
 S IBC=IBC+1,IBTXT(IBC)="  "
 S IBC=IBC+1,IBTXT(IBC)="This action only needs to be done by one person.  Please verify with the"
 S IBC=IBC+1,IBTXT(IBC)="appropriate billing supervisor that the update has been accomplished."
 D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY,.IBPARAM,"","")
MMSGQ Q  ; end of Mail Message subroutine
 ;
COMPLETE ; display message that step has completed successfully
 D BMES^XPDUTL("Update completed.")
 Q
 ;
