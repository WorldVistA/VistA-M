XU8P328D ;OIFOO/SO- SCAN FOR PATIENT COUNTY BEGIN WITH "ZZ";6:36 AM  8 Jul 2004
 ;;8.0;KERNEL;**328**;Jul 10, 1995
 ; Post Install Entry Point
 N FIX S FIX=0
 I '$D(XPDNM) D DEVICE Q:POP  Q:$D(ZTSK)  U IO
SCAN ;
 D MES^XPDUTL("Begin Patient File scan for patients with ""ZZ..."" County...")
 N DFN S DFN=0 N II N CNT S CNT=0
 F II=0:1 S DFN=$O(^DPT(DFN)) Q:'DFN  D
 . I (II/10000)=(II\10000) D MES^XPDUTL("Scanned: "_II_" patients so far.")
 . N PDATA,FLDS,DIERR,ZER
 . S FLDS=".01;.0905;.114;.115;.116;.117"
 . ; .01=NAME
 . ; .0905=1U4N
 . ; .114=CITY
 . ; .115=STATE FILE POINTER
 . ; .116=ZIP CODE
 . ; .117=COUNTY MULTIPLE IEN
 . ;
 . D GETS^DIQ(2,DFN_",",FLDS,"I","PDATA","ZER")
 . N CIEN S CIEN=+$G(PDATA(2,DFN_",",.117,"I")) Q:'CIEN
 . N SIEN S SIEN=+$G(PDATA(2,DFN_",",.115,"I")) Q:'SIEN
 . N CO S CO=$$GET1^DIQ(5.01,CIEN_","_SIEN_",",".01")
 . I CO="" Q
 . I CO]"",$E(CO,1,2)'="ZZ" Q
 . S CNT=CNT+1
 . I 'FIX D NAME
 . I FIX D
 .. N ZIP S ZIP=$G(PDATA(2,DFN_",",.116,"I")) Q:ZIP=""
 .. N CITY S CITY=$G(PDATA(2,DFN_",",.114,"I")) Q:CITY=""
 .. N ZDATA
 .. D POSTALB^XIPUTIL(ZIP,.ZDATA)
 .. I $D(ZDATA("ERROR")) D NAME,MES^XPDUTL("  **Unable to find Patient's ZIP code.") Q
 .. N III,FLAG S FLAG=0
 .. F III=1:1:ZDATA D
 ... I ZDATA(III,"CITY")["*" S ZDATA(III,"CITY")=$TR(ZDATA(III,"CITY"),"*","") ; Remove trailing "*"
 ... I ZDATA(III,"CITY")=CITY,ZDATA(III,"STATE POINTER")=SIEN,ZDATA(III,"POSTAL CODE")=ZIP D  Q
 .... S FLAG=1
 .... ; IA #4453
 .... N DIERR,ZERR,FDA
 .... S FDA(2,DFN_",",.117)=ZDATA(III,"COUNTY")
 .... D FILE^DIE("E","FDA","ZERR")
 .... I $D(DIERR) D NAME,MES^XPDUTL("  **Unable to file Patient's COUNTY.") Q
 .... Q
 ... Q
 .. I 'FLAG D NAME,MES^XPDUTL("  ** City and State do not match ZIP code.")
 .. Q
 . Q
 D MES^XPDUTL("Total Number of Patients who's County begins with ""ZZ"": "_CNT)
 D MES^XPDUTL("Total Number of Patients examined: "_II)
 D MES^XPDUTL("Finished Patient File scan.")
 I '$D(XPDNM) D ^%ZISC
 Q
 ;
FIX ; Repair Entry Point
 N FIX S FIX=1
 D DEVICE Q:POP  Q:$D(ZTSK)  U IO
DEQUE ; Queued Entry Point
 D SCAN
 Q
 ;
NAME ; Display Name
 N X
 S X="Name: "_PDATA(2,DFN_",",.01,"I")_"; 1U4N: "_PDATA(2,DFN_",",.0905,"I")_"; Current County: "_CO
 D MES^XPDUTL(X)
 Q
 ;
DEVICE ; Use P-MESSAGE for default device
 N %ZIS S %ZIS="MQ",%ZIS("B")="P-MESSAGE"
 D ^%ZIS Q:POP
 I $D(IO("Q")) D  K IO("Q") Q
 . N ZTSAVE,ZTRTN,ZTDESC
 . S ZTSAVE("FIX")=""
 . S ZTRTN="DEQUE^XU8P328D"
 . S ZTDESC="QUEUED 'ZZ'_COUNTY REPAIR"
 . D ^%ZTLOAD
 . D HOME^%ZIS
 . Q
 Q
