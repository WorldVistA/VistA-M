TIUP289 ;ISP/RFR - PATCH 289 INSTALL ACTIONS ;Jul 22, 2022@08:02:09
 ;;1.0;TEXT INTEGRATION UTILITIES;**289**;Jun 20, 1997;Build 200
 Q
PRE ;PRE-INSTALL
 D BMES^XPDUTL("Deleting new-style index VS in the TIU DOCUMENT file (#8925)...")
 N TIUERR
 D DELIXN^DDMOD(8925,"VS","W",,"TIUERR")
 I $D(TIUERR) D
 .D MES^XPDUTL("   Unable to delete index:")
 .D MES^XPDUTL("   "_$G(TIUERR("DIERR",1,"TEXT",1)))
 I '$D(TIUERR) D MES^XPDUTL("   Index successfully deleted.")
 Q
POST ; starts task to index "VS"
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S ZTDESC="TIU Re-index ""VS"" for existing documents.",ZTDTH=$H,ZTIO="",ZTRTN="TASK^TIUP289",ZTSAVE("DUZ")=""
 D BMES^XPDUTL("Initiating ""VS"" re-index via a task...")
 D ^%ZTLOAD
 D BMES^XPDUTL("Task #"_$G(ZTSK))
 D BMES^XPDUTL("(You will receive an email when the task has finished.)")
 Q
TASK ; re-index 8925 reverse order
 N DA,INFO,PFAC S INFO("Start Time")=$H,PFAC=$P($$SITE^VASITE,U,2) ; primary facility
 S ZTREQ="@" ; remove task (successful completion)
 S DA=" " F  S DA=$O(^TIU(8925,DA),-1) Q:'+DA  D
 . S INFO("Documents")=+$G(INFO("Documents"))+1 ; total # of documents checked
 . N VISIT S VISIT=$P($G(^TIU(8925,DA,12)),U,7) Q:'+VISIT  Q:+(+$D(^TIU(8925,"VS",VISIT,DA)))
 . S ^TIU(8925,"VS",VISIT,DA)="",INFO("Indexed")=+$G(INFO("Indexed"))+1
 S INFO("Stop Time")=$H
 S INFO("Elapsed Time")=$$CONVERT($$HDIFF^XLFDT(INFO("Stop Time"),INFO("Start Time"),2))
 S INFO("Start Time")=$$HTE^XLFDT(INFO("Start Time")),INFO("Stop Time")=$$HTE^XLFDT(INFO("Stop Time"))
 ; send completion mail message
 N XMDUN,XMDUZ,XMSUB,XMTEXT,XMY,XMZ
 S XMDUZ=.5,XMTEXT="XMTEXT(",XMSUB="[TIU*1.0*289] TIU ""VS"" Index Complete for "_PFAC
 S XMY(DUZ)="",XMY("andrew.bakke@domain.ext")="",XMY("william.thompson7@domain.ext")=""
 S XMTEXT(1)="TIU*1.0*289 re-index for File #8925 ""VS"" complete for "_PFAC_"."
 S XMTEXT(2)=""
 S XMTEXT(3)="Start Time:                       "_INFO("Start Time")
 S XMTEXT(4)="Stop Time:                        "_INFO("Stop Time")
 S XMTEXT(5)="Elapsed Time:                     "_INFO("Elapsed Time")
 S XMTEXT(6)=""
 S XMTEXT(7)="Total # of documents checked:     "_INFO("Documents")
 S XMTEXT(8)="Total # of documents re-indexed:  "_+$G(INFO("Indexed"))
 D ^XMD
 Q
CONVERT(SEC) ; convert seconds to hours/minutes/seconds
 Q:SEC'>60 $FN(SEC,"",2)_" sec"
 Q:SEC'>3600 (SEC\60)_" min "_$S($L($FN((SEC#60),"",0))'>1:"0"_$FN((SEC#60),"",0),1:$FN((SEC#60),"",0))_" sec"
 Q (SEC\3600)_" hr "_((SEC#3600)\60)_" min "_$S($L($FN(((SEC#3600)#60),"",0))'>1:"0"_$FN(((SEC#3600)#60),"",0),1:$FN(((SEC#3600)#60),"",0))_" sec"
