XUPSPD1 ;CS/DW - NEW PERSON File Report continued ; 1 May 2004
 ;;8.0;KERNEL;**309**; Jul 10, 1995;
 Q
 ;
NOTICE(XUT) ; Notify that the update is complete for the site.
 ;If called within a task, protect variables
 I $D(ZTQUEUED) N %,DIFROM
 ;
 N RDT
 D NOW^%DTC S Y=% X ^DD("DD")
 S RDT=$P(Y,"@",1)_"@"_$P($P(Y,"@",2),":",1,2)
 ;
 N XMY,XMTEXT,XMDUZ,XUSUB,XUWHAT,XUSITE,XUPLACE,XUNUM
 ;
 S XUSITE=$$SITE^VASITE
 S XUPLACE=$P(XUSITE,"^",2)
 S XUNUM=$P(XUSITE,"^",3)
 ;
 S XMDUZ=.5
 S XMY(DUZ)=""
 S XMY("G.XUPS IDENTITY MANAGEMENT@FORUM.VA.GOV")=""
 S XMSUB="XUPS NPF CLEANUP UPDATE - "_XUPLACE_"("_XUNUM_")"
 ;
 S XUWHAT(1)=" NEW PERSON file cleanup (XU*8*309) is complete."
 S XUWHAT(2)=""
 S XUWHAT(3)="        Facility Name: "_XUPLACE
 S XUWHAT(4)="       Station Number: "_XUNUM
 S XUWHAT(5)=""
 S XUWHAT(6)=" Total linked entries: "_XUT(1)
 S XUWHAT(7)="    Total NPF updates: "_XUT(2)
 S XUWHAT(8)=""
 S XUWHAT(9)="            Date/Time: "_RDT
 ;
 S XMTEXT="XUWHAT("
 ;
 D ^XMD
 ;
 Q
