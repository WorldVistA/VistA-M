TIUP113P ; SLC/JAK - Post-Install for TIU*1*113 Cont. ;9/24/03
 ;;1.0;TEXT INTEGRATION UTILITIES;**113**;Jun 20, 1997
MAIL ; -- Send message to user who initiated post-install
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,XMMG
 N TIUI,TIUK,TIUS,TIUTXT
 S XMDUZ="PATCH TIU*1*113 DIVISION LOADING",XMY(.5)=""
 S:$G(DUZ) XMY(DUZ)=""
 F TIUK=3,5 S TIUTXT(TIUK)=""
 S TIUTXT(1)="Task Started: "_$$FMTE^XLFDT($G(^XTMP("TIUP113","T0")))
 S TIUTXT(2)="Task   Ended: "_$$FMTE^XLFDT($G(^XTMP("TIUP113","T1")))
 I $G(^XTMP("TIUP113","STOP")) D
 . S TIUTXT(4)="Task STOPPED: "_$$FMTE^XLFDT($G(^XTMP("TIUP113","STOP")))_"."
 . S TIUTXT(6)="The post-install has not completed."
 . S TIUTXT(7)="To restart invoke MAIN^TIUP113 from Programmer mode."
 . S TIUTXT(8)="The task will continue from the last entry processed."
 E  D
 . F TIUK=9,13,16,20,24 S TIUTXT(TIUK)=""
 . S TIUTXT(4)="Task and post-install COMPLETED successfully."
 . S TIUTXT(6)="This patch post-install has reviewed all of the "_+$P($G(^TIU(8925,0)),U,4)
 . S TIUTXT(7)="entries in the TIU DOCUMENT file, and has attempted to"
 . S TIUTXT(8)="load each with DIVISION data."
 . S TIUTXT(10)="There are "_+$G(^XTMP("TIUP113","EX"))_" total exception entries"
 . S TIUTXT(11)="that could not be loaded with DIVISION data,"
 . S TIUTXT(12)="however. Here's how they break down by types:",TIUI=13
 . F TIUS=1,2 D
 . . S TIUTXT(TIUI+TIUS)=$P($T(EXHDR+TIUS),";",3)_+$G(^XTMP("TIUP113","EX",TIUS))_" entry/entries"
 . S TIUTXT(17)="Next, you can print the entries by type of exception so"
 . S TIUTXT(18)="you can review them before continuing, or you can skip"
 . S TIUTXT(19)="the printing and finish the post-install."
 . S TIUTXT(21)="To print: invoke DEVICE^TIUP113 from Programmer mode"
 . S TIUTXT(22)="          (instructions for finishing the post-install"
 . S TIUTXT(23)="          are included in this call)"
 . S TIUTXT(25)="To finish: invoke UPDATE^TIUP113 from Programmer mode"
 S XMTEXT="TIUTXT(",XMSUB="PATCH TIU*1*113 Division Loading"
 D ^XMD
 Q
EXHDR ; -- Exception entry headers
 ;;A. Cannot determine DIVISION from Hospital Location: 
 ;;B. Attempted to load DIVISION data but entry in use: 
