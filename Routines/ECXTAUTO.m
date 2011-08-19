ECXTAUTO ;ALB/JAP,BIR/DMA-Background Queuing for Package Extracts ; 17 Mar 95 / 1:04 PM
 ;;3.0;DSS EXTRACTS;**8,24,49**;Dec 22, 1997
 ;generate extract & auto-requeue
 ;
QUE ;entry point from package extracts - determine start and stop date from 727.1
 ;and variables from setup^routine
 S EC=$O(^ECX(727.1,"AF",ECFILE,0))
 S ECDT=$P($$HTFM^XLFDT(ZTDTH,1),".")
 S ECED=$$LASTMON^ECXDEFIN(ECDT)
 S ECSD=$E(ECED,1,5)_"01"
 I '$D(ECNODE) S ECNODE=7
 ;get station number; ecinst is defined only for prosthetics
 ;automatic requeue can be setup only for site's with 1 primary prosthetics division
 S:'$D(ECINST) ECINST=+$P(^ECX(728,1,0),U)
 S ECXINST=ECINST
 K ECXDIC S DA=ECINST,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;99"
 D EN^DIQ1 S ECINST=$G(ECXDIC(4,DA,99,"I")) K DIC,DIQ,DA,DR,ECXDIC
 ;check if currently running
 I $P(^ECX(728,1,ECNODE+.1),U,ECPIECE)="R" D RUNMSG,REQUE Q
 ;check if date range has been extracted
 ;get last date for all extracts except prosthetics
 I ECGRP'="PRO" D
 .S ECLDT=$P($G(^ECX(728,1,ECNODE)),U,ECPIECE)
 ;get last date for prosthetics
 I ECGRP="PRO" D
 .S ECLDT=""
 .S ECXDA1=$O(^ECX(728,0))
 .I $D(^ECX(728,ECXDA1,1,ECXINST,0)) S ECLDT=$P(^ECX(728,ECXDA1,1,ECXINST,0),U,2)
 ;if last run date doesn't exist don't allow auto requeue to continue
 I ECLDT="" S ZTREQ="@" Q
 ;if last run date is last day of previous fy don't allow auto requeue to continue
 S X=$$CYFY^ECXUTL1(DT)
 I ECLDT=$$FMADD^XLFDT($P(X,U,3),-1) S ZTREQ="@" Q
 ;otherwise continue to check data range
 S ECFDT=$$FMADD^XLFDT(ECLDT,1)
 I ECFDT>ECED D ERROR,REQUE Q
 ;do specific extract using appropriate fiscal year logic
 S ECXLOGIC=$$FISCAL^ECXUTL1(ECSD)
 S $P(^ECX(728,1,ECNODE+.1),U,ECPIECE)="R"
 S ECSDN=$$FMTE^XLFDT(ECSD),ECEDN=$$FMTE^XLFDT(ECED),ECSD1=ECSD-.1
 L +^ECX(727,0) S EC=$P(^ECX(727,0),U,3)+1,$P(^(0),U,3,4)=EC_U_EC L -^ECX(727,0)
 S ^ECX(727,EC,0)=EC_U_DT_U_ECPACK_U_ECSD_U_$E(ECED,1,7)
 S ^ECX(727,EC,"HEAD")=ECHEAD
 S ^ECX(727,EC,"FILE")=ECFILE
 S ^ECX(727,EC,"GRP")=ECGRP
 S ^ECX(727,EC,"VER")=$G(ECVER)_U_ECXLOGIC
 S ^ECX(727,EC,"DIV")=ECXINST
 S DA=EC,DIK="^ECX(727," D IX^DIK K DIK,DA
 S ECRN=0,ECXYM=$$ECXYM^ECXUTL(ECED),EC23=ECXYM_U_EC
 S ECXSTART=$P($$HTE^XLFDT($H),":",1,2),ECXNOW=$H
 D @ECRTN
 ;set last date for all extracts except prosthetics
 S:(ECGRP'="PRO") $P(^ECX(728,1,ECNODE),U,ECPIECE)=$P(ECED,".")
 ;set last date for prosthetics
 I ECGRP="PRO" D
 .S J=$O(^ECX(728,0))
 .S $P(^ECX(728,J,1,ECXINST,0),U,2)=$P(ECED,".")
 S TIME=$P($$HTE^XLFDT($H),":",1,2)
 S $P(^ECX(727,$P(EC23,U,2),0),U,6)=ECRN
 ;set piece 3 and 4 of the zero node
 S ECLAST=$O(^ECX(ECFILE,99999999),-1),ECTOTAL=$P(^ECX(ECFILE,0),U,4)+ECRN,$P(^(0),U,3,4)=ECLAST_U_ECTOTAL K ECLAST,ECTOTAL
 D MSG
 S $P(^ECX(728,1,ECNODE+.1),U,ECPIECE)=""
 D REQUE
 Q
 ;
REQUE ;reque job for next time
 S EC=$O(^ECX(727.1,"AF",ECFILE,0))
 S ECFDT=$$HTFM^XLFDT(ZTDTH)
 S ECFDT=$$NEXTMON^ECXDEFIN(ECFDT)
 ;do not allow october extract to start from auto-requeue
 I $E(ECFDT,4,5)="10" D  Q
 .D FYMSG
 .S $P(^ECX(727.1,ECDA,0),"^",6)=""
 .S ZTREQ="@"
 S ZTDTH=$$FMTH^XLFDT(ECFDT)
 D REQ^%ZTLOAD
 Q
 ;
MSG ; send message to mail group 'DSS-ECGRP'
 S XMSUB=ECINST_" - "_ECPACK_" AUTO-REQUEUE EXTRACT FOR DSS",XMDUZ="DSS SYSTEM"
 K XMY S XMY("G.DSS-"_ECGRP_"@"_^XMB("NETNAME"))=""
 S ECMSG(1,0)="The BACKGROUND DSS-"_ECPACK_" extract (#"_$P(EC23,U,2)_") for "_ECSDN
 S ECMSG(2,0)="through "_ECEDN_" was begun on "_$P(ECXSTART,"@")_" at "_$P(ECXSTART,"@",2)
 S ECMSG(3,0)="and completed on "_$P(TIME,"@")_" at "_$P(TIME,"@",2)_"."
 S ECMSG(4,0)=" "
 S ECMSG(5,0)="A total of "_ECRN_" records were written."
 S ECMSG(6,0)=" "
 S ECMSG(7,0)="Extract time was [HH:MM:SS] "_$$HDIFF^XLFDT($H,ECXNOW,3)
 S ECMSG(8,0)=" "
 S X=$E(ECXLOGIC,5) S X=$S((X="")!(X=" "):"",1:"revision "_X_" of ")
 S ECMSG(9,0)="The data was extracted using "_X_"fiscal year "_$E(ECXLOGIC,1,4)_" logic."
 S ECMSG(10,0)=" "
 S XMTEXT="ECMSG(" D ^XMD
 Q
 ;
ERROR ; send message when job was queued to extract data already extracted
 S ECSDN=$$FMTE^XLFDT(ECSD),ECEDN=$$FMTE^XLFDT(ECED)
 S XMSUB=ECINST_" - "_ECPACK_" BACKGROUND EXTRACT FAILURE",XMDUZ="DSS SYSTEM"
 K XMY S XMY("G.DSS-"_ECGRP_"@"_^XMB("NETNAME"))=""
 S ECMSG(1,0)="The "_ECPACK_" extract was automatically requeued to extract"
 S ECMSG(2,0)="data for "_ECSDN_" through "_ECEDN_"."
 S ECMSG(3,0)="Data for this range of dates has already been extracted."
 S ECMSG(4,0)=" "
 S ECMSG(5,0)="The extract was NOT generated, but has been requeued to run"
 S ECMSG(6,0)="next month. "
 S XMTEXT="ECMSG(" D ^XMD
 Q
 ;
FYMSG ; send message for october extract
 S Y=$E(ECFDT,1,5)_"00" D DD^%DT
 S XMSUB=ECINST_" - "_ECPACK_" BACKGROUND EXTRACT FAILURE",XMDUZ="DSS SYSTEM"
 K XMY S XMY("G.DSS-"_ECGRP_"@"_^XMB("NETNAME"))=""
 S ECMSG(1,0)="There was an attempt to automatically requeue the "_ECPACK
 S ECMSG(2,0)="extract for the month of "_Y_"."
 S ECMSG(3,0)=" "
 S ECMSG(4,0)="The extract was NOT generated.  The first extract of the new fiscal"
 S ECMSG(5,0)="year will need to be queued to run after any required fiscal year"
 S ECMSG(6,0)="update is installed."
 S XMTEXT="ECMSG(" D ^XMD
 Q
 ;
RUNMSG ;
 S ECSDN=$$FMTE^XLFDT(ECSD),ECEDN=$$FMTE^XLFDT(ECED)
 S XMSUB=ECINST_" - "_ECPACK_" BACKGROUND EXTRACT FAILURE",XMDUZ="DSS SYSTEM"
 K XMY S XMY("G.DSS-"_ECGRP_"@"_^XMB("NETNAME"))=""
 S ECMSG(1,0)="The "_ECPACK_" extract was automatically requeued to extract"
 S ECMSG(2,0)="data for "_ECSDN_" through "_ECEDN_"."
 S ECMSG(3,0)="But a "_ECHEAD_" extract appears to be currently running."
 S ECMSG(4,0)=" "
 S ECMSG(5,0)="The requeued extract was NOT generated, but has been requeued"
 S ECMSG(6,0)="for next month."
 S XMTEXT="ECMSG(" D ^XMD
 Q
