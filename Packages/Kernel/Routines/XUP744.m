XUP744 ;ALB/CMC - XU*8*744 POST-INIT ; 2/1/21 4:33pm
 ;;8.0;KERNEL;**744**;Jul 10, 1995;Build 1
 ;
QUE ;Queue off the CPRS TAB update for existing NPI records
 N ZTIO,ZTSK,ZTRTN,ZTDESC,ZTSAVE,ZTDTH,Y
 S ZTIO="",ZTRTN="EN^XUP744",ZTDTH=$H
 S ZTDESC="XU*8.0*744 Post-Install CPRS TAB UPDATE PROCESS"
 D ^%ZTLOAD
 I '$G(ZTSK) D MES^XPDUTL("   **** Queuing job failed!!!") Q
 D MES^XPDUTL("   Job number #"_ZTSK_" was queued.")
 Q
EN ;
 N NPI,CNT,CNT2,CNT3,CNT4,ISSUE,IEN,IEN2,NAME,XUARR,XURET,STRT,END,TERMDATE
 S STRT=$$NOW^XLFDT
 S NPI="",CNT=0,CNT2=0,CNT3=0,CNT4=0
 F  S NPI=$O(^VA(200,"ANPI",NPI)) Q:NPI=""  D
 .S IEN=$O(^VA(200,"ANPI",NPI,"")),CNT=CNT+1
 .S TERMDATE=$P($G(^VA(200,IEN,0)),U,11) ;Termination date
 .I TERMDATE'="" S CNT2=CNT2+1 Q  ;If Termination Date is set, quit
 .;CHECK IF TITLE AND REMARKS ARE "NON-VA PROVIDER"
 .I $$GET1^DIQ(200,IEN_",",8)="NON-VA PROVIDER"&($$GET1^DIQ(200,IEN_",",53.9)="NON-VA PROVIDER") D
 ..;Update CPRS tab
 ..N INACTDT,FDA,IENS,ORDIEN
 ..S CNT3=CNT3+1
 ..S INACTDT=$P($G(^VA(200,IEN,"PS")),"^",4),IENS=+IEN_","
 ..S ORDIEN=$O(^ORD(101.13,"B","NVA","")) Q:ORDIEN=""
 ..I '$D(^VA(200,+IEN,"ORD","B",ORDIEN)) D  Q
 ...;S ^XTMP("XCPRS-TAB",IEN)=""
 ...S FDA(200.010113,"+1,"_IENS,.01)="NVA"
 ...S FDA(200.010113,"+1,"_IENS,.02)=$$DT^XLFDT()
 ...I INACTDT'="" S FDA(200.010113,"+1,"_IENS,.03)=INACTDT
 ...D UPDATE^DIE("E","FDA")
 ...S CNT4=CNT4+1
 ...K FDA
 S END=$$NOW^XLFDT
 D MAIL(CNT,CNT2,CNT3,CNT4,STRT,END) ;SEND MAIL WITH STATS
 Q
MAIL(CNT,CNT2,CNT3,CNT4,STRT,END) ;
 N XMDUZ,XMTEXT,XMSUB,XMY,XMZ,XUDUN,MSGXU
 S XUDUN(1)="Post-Init routine XUP744 has completed updating CPRS tab for existing entries."
 S XUDUN(2)="Process Started at:  "_$$FMTE^XLFDT(STRT)_"  -  Completed at: "_$$FMTE^XLFDT(END)
 S XUDUN(3)="",XUDUN(4)="Total Number of NPI records reviewed: "_CNT
 S XMSUB="CPRS TAB Update - XU*8*744 - SITE: "_$P($$SITE^VASITE,"^",3)
 S XUDUN(5)=""
 S XUDUN(6)="Total Number of NPI records Terminated: "_CNT2
 S XUDUN(7)=""
 S XUDUN(8)="Total Number of NPI records with NON-VA Provider Remarks and Title: "_CNT3
 S XUDUN(9)=""
 S XUDUN(10)="Total Number of NPI records updated with CPRS Tab: "_CNT4
 S XMTEXT="XUDUN(",XMDUZ=.5,XMY(DUZ)=""
 I $$PROD^XUPROD()=1 D
 .S XMY("Christine.Chesney@domain.ext")="",XMY("John.Williams30ec0c@domain.ext")="",XMY("Chintan.Naik@domain.ext")=""
 D ^XMD
 Q
