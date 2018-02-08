PSNFTP3 ;HP/ART - PPS-N NDF Updates File Transfer ;05/15/2017
 ;;4.0;NATIONAL DRUG FILE;**513**; 30 Oct 98;Build 53
 ;
 Q
 ;
VERIFY ; PPS-N installation verification
 N NOW,RUN,START,PSNHLD,NODE,JOB,TYPE
 D NOW^%DTC S NOW=%,TYPE="I"
 S JOB=0 F  S JOB=$O(^XTMP("PSN PPS VERIFY",JOB)) Q:'JOB  S PSNHLD=""  F  S PSNHLD=$O(^XTMP("PSN PPS VERIFY",JOB,PSNHLD)) Q:PSNHLD=""  S NODE=$G(^XTMP("PSN PPS VERIFY",JOB,PSNHLD,0)) D
 . S START=$P(NODE,"^",2),RUN=$$FMDIFF^XLFDT(NOW,START,2) I RUN>3600 D
 . . K ^XTMP("PSN PPS VERIFY",JOB,PSNHLD,0)
 . . D MSG
 Q
 ;
MSG ; send error message to indicate installation did not complete
 N PSGRP,PSDA,PSNTXT,XMSUB,XMTEXT
 S XMSUB="ERROR: PPS-N "_$S(TYPE="D":"download",TYPE="I":"install",1:"")_" did not complete"
 S PSNFILE=$S($D(PSREMFIL):PSREMFIL,$D(PSNHLD):PSNHLD,1:"")
 I $D(DUZ) S XMY(DUZ)=""
 S PSDA=0 F  S PSDA=$O(^XUSEC("PSNMGR",PSDA)) Q:'PSDA  S XMY(PSDA)=""
 S PSGRP="",PSGRP=$$GET1^DIQ(57.23,1,5) I PSGRP'="" S XMY($$MG^PSNPPSMG(PSGRP))=""
 S PSGRP="",PSGRP=$$GET1^DIQ(57.23,1,6) I PSGRP'="" S XMY($$MG^PSNPPSMG(PSGRP))=""
 S PSNTXT(1)="**************************************************************************"
 S PSNTXT(2)="*** An error occurred during "_$S(TYPE="D":"download",1:"install")_" of the following Update file(s): ***"
 S PSNTXT(3)="**************************************************************************"
 S PSNTXT(4)="The following file(s) could not be "_$S(TYPE="D":"downloaded",1:"installed")_":"
 S PSNTXT(5)=""
 S PSNTXT(6)="      Update file Name"
 S PSNTXT(7)="      -------------------"
 S PSNTXT(8)="      "_PSNFILE
 S PSNTXT(9)=""
 S PSNTXT(10)="Error: "_$$EC^%ZOSV
 S PSNTXT(11)=""
 S PSNTXT(12)="How to correct your error:"
 S PSNTXT(13)="1. Rerun the "_$S(TYPE="D":"downloaded",TYPE="I":"installed",1:"")_" option to re-attempt retrieval."
 S PSNTXT(14)="2. Contact the National Help Desk or enter a ticket."
 S PSNTXT(15)=""
 S PSNTXT(16)="Further details can be found on the Download/Install Status Report option."
 S XMTEXT="PSNTXT("
 D ^XMD K XMSUB,XMY,XMTEXT
 Q
