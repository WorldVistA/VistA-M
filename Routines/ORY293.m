ORY293 ;SLC/JMH - post install routine for patch OR*3*293; ;06/07/10  05:16
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**293**;Dec 17, 1997;Build 20
 ;
POST ;
 ;task out CONVERT^OROCAPI1
 D TASK
 Q
 ;
TASK ; -- queue job to convert order checks
 N ZTDESC,ZTRTN,ZTIO,ZTSAVE,ZTDTH,ZTSK,ORMSG
 S ORMSG(1)="A background job has been queued to convert order checks"
 S ORMSG(2)="from file 100 to file 100.05." D MES^XPDUTL(.ORMSG)
 S ZTDESC="Convert Order Checks",ZTRTN="CONVERT^OROCAPI1"
 S ZTIO="",ZTDTH=$H,ZTSAVE("DUZ")="" D ^%ZTLOAD K ORMSG
 S ORMSG="Task "_$S($G(ZTSK):"#"_ZTSK,1:"not")_" started."
 D MES^XPDUTL(ORMSG)
 I '$G(ZTSK) D BMES^XPDUTL("Use TASK^ORY293 to queue this job to complete conversion of order checks!")
 S ^XTMP("ORK FILE CONVERSION",0)=$$FMADD^XLFDT($$NOW^XLFDT,90)_U_$$NOW^XLFDT
 S ^XTMP("ORK FILE CONVERSION","INSTALLER")=DUZ
 Q
 ;
