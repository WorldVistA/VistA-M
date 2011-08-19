PSBMLVAL ;BIRMINGHAM/EFC-BCMA MED LOG VALIDATION ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;;Mar 2004
 ;
 ;
 ;
VAL(RESULTS,DFN,PSBIEN,PSBTYPE,PSBADMIN) ;
 ;
 ; RPC: PSB VALIDATE ORDER
 ;
 ; Description: Final check of order against an actual administration
 ;              date/time used immediately after scanned med has been
 ;              validated to be a good unadministered order and by the
 ;              PSBODL (Due List) output.
 ;
 ; Variables:   DFN:      Patient IEN
 ;              PSBIEN:   Order IEN
 ;              PSBTYPE:  U:Unit Dose/V:IV
 ;              PSBADMIN: Scheduled Administration Time
 ;
 N PSBOKAY,PSBORD,PSBSCHT,PSBOST,PSBOSP,PSBDT,PSBDA,PSBNOW
 ;
 K PSBORD
 D PSJ1^PSBVT(DFN,PSBIEN_PSBTYPE)
 S PSBCNT=0
 S PSBOKAY="-1^***Unable to determine administration" ; Default Flag
 D NOW^%DTC
 ;
 ;
 I PSBSCHT'="O"&(%>PSBOSP) S RESULTS(0)="-1^Order Not Active",PSBCNT=2 Q
 ; Validate an IV
 I PSBONX?.N1"V" D  S RESULTS(0)=PSBOKAY Q
 .I PSBOSTS'="A"&(PSBOSTS'="R") S PSBOKAY="-1^Order Not Active",PSBCNT=2 Q
 .I PSBNGF S PSBOKAY="-1^marked DO NOT GIVE",PSBCNT=2 Q
 .I PSBSCHT="O" D  Q  ; Make sure One Time is not given.
 ..I $D(^PSB(53.79,"AORD",DFN,PSBONX)) S PSBOKAY="-1^Already Given",PSBCNT=2
 ..E  S PSBOKAY="0^Okay to administer"
 .S PSBOKAY="0^Okay to administer"
 ; Validate a Continuous Order
 D:PSBSCHT="C"
 .S (PSBGVN,X,Y)=""
 .I PSBOSTS'="A"&(PSBOSTS'="R") S PSBOKAY="-1^Order Not Active",PSBCNT=2 Q
 .I PSBNGF S PSBOKAY="-1^marked DO NOT GIVE",PSBCNT=2 Q
 .I $D(^PSB(53.79,"AORD",DFN,PSBIEN_PSBTYPE,PSBADMIN)) D  Q:X
 ..S X=$O(^PSB(53.79,"AORD",DFN,PSBIEN_PSBTYPE,PSBADMIN,X)) Q:'X
 ..S X=$S($P($G(^PSB(53.79,+X,0)),U,9)="G":1,1:0) Q:'X
 ..S PSBOKAY="-1^Dose already on medication log",PSBCNT=2
 .; Minutes before
 .S PSBWIN1=$$GET^XPAR("DIV","PSB ADMIN BEFORE")*-1
 .; Minutes After
 .S PSBWIN2=$$GET^XPAR("DIV","PSB ADMIN AFTER")
 .D NOW^%DTC S PSBMIN=$$DIFF^PSBUTL(PSBADMIN,%)
 .; PENDING A PC SOLUTION!
 .I PSBMIN<PSBWIN1 S PSBOKAY="1^Admin is "_(PSBMIN*-1)_" minutes before the scheduled administration time" Q
 .I PSBMIN>PSBWIN2 S PSBOKAY="1^Admin is "_(PSBMIN)_" minutes after the scheduled administration time" Q
 .S PSBOKAY="0^Okay to administer"
 ; Validate a PRN Order
 D:PSBSCHT="P"
 .I PSBOSTS'="A"&(PSBOSTS'="R") S PSBOKAY="-1^Order Not Active",PSBCNT=2 Q
 .I PSBNGF S PSBOKAY="-1^marked DO NOT GIVE",PSBCNT=2 Q
 .; CHECK Q4H STUFF SEND 1^TO SOON IF TOO SOON.
 .S PSBOKAY="1^Brief Administration History"
 .; Get Last Four Givens
 .S PSBDT=""
 .F  S PSBDT=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,PSBDT),-1) Q:PSBDT=""  D
 ..S PSBDA=""
 ..F  S PSBDA=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,PSBDT,PSBDA),-1) Q:'PSBDA  D
 ...Q:$P(^PSB(53.79,PSBDA,0),U,9)="N"
 ...S X=$$GET1^DIQ(53.79,PSBDA_",",.06)_"  "
 ...S X=X_$$GET1^DIQ(53.79,PSBDA_",",.09)_"  "
 ...S X=X_$$GET1^DIQ(53.79,PSBDA_",",.12)_"  "
 ...S X=X_$$GET1^DIQ(53.79,PSBDA_",",.21)_"  "
 ...S X=X_$$GET1^DIQ(53.79,PSBDA_",",.16)_"  "
 ...S PSBOKAY($O(PSBOKAY(""),-1)+1)=X
 ...S:$D(PSBOKAY(4)) PSBDT=0
 ; Validate a One-Time Order
 D:PSBSCHT="O"
 .S (PSBGVN,X,Y)=""
 .F  S X=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,X),-1)  Q:'X  D
 ..F  S Y=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,X,Y),-1) Q:'Y  S:($P(^PSB(53.79,Y,.1),U)=PSBONX)&($P(^PSB(53.79,Y,0),U,9)="G") PSBGVN=1,(X,Y)=0
 .I PSBGVN S PSBOKAY="-1^Dose Already on medication Log",PSBCNT=2 Q
 .; One Time are automatically expired so we don't check STATUS here
 .I PSBNGF S PSBOKAY="-1^marked DO NOT GIVE",PSBCNT=2 Q
 .S PSBOKAY="0^Okay to administer"
 ; Validate an On Call Order
 D:PSBSCHT="OC"
 .S PSBOKAY="0^Okay to administer",(PSBGVN,X,Y)=""
 .F  S X=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,X),-1)  Q:'X  D
 ..F  S Y=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,X,Y),-1) Q:'Y  S:$P(^PSB(53.79,Y,.1),U)=PSBONX PSBGVN=1,(X,Y)=0
 .I PSBGVN&('$$GET^XPAR("DIV","PSB ADMIN MULTIPLE ONCALL")) S PSBOKAY="-1^Dose Already on medication Log",PSBCNT=2 Q
 .I PSBOSTS'="A"&(PSBOSTS'="R") S PSBOKAY="-1^Order Not Active",PSBCNT=2 Q
 .I PSBNGF S PSBOKAY="-1^marked DO NOT GIVE",PSBCNT=2 Q
 .S PSBOKAY="0^Okay to administer"
 ;
 D:+PSBOKAY'=-1
 .N PSBDIFF,Y,X,PSBSTUS
 .; Ok, now we know it is on-call or cont and not on the log.
 .D:(PSBSCHT="C")!(PSBSCHT="OC"&('$G(PSBGVN)))
 ..S Y=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,""),-1)
 ..S PSBDIFF=$$FMDIFF^XLFDT($$NOW^XLFDT(),Y,2)
 ..Q:PSBDIFF>7200  ; Greater than 2 hours
 ..;Check for the status of the medication and insert status in the text
 ..I Y]"" S X=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,Y,""),-1),PSBSTUS=$P(^PSB(53.79,X,0),U,9)
 ..S PSBSTUS=$S(PSBSTUS="G":"GIVEN",PSBSTUS="H":"HELD",1:"REFUSED")
 ..S Y="*** NOTICE, "_PSBOITX_" was "_PSBSTUS_" "_(PSBDIFF\60)_" minutes ago."
 ..I +PSBOKAY=1 S PSBOKAY(1)=Y
 ..E  S PSBOKAY="1^"_Y
 ;
 D NOW^%DTC
 I PSBSCHT'="O"&(%<($$FMADD^XLFDT(PSBOST,"","",$$GET^XPAR("ALL","PSB ADMIN BEFORE")*-1))) S RESULTS(0)="-1^Order Not Active" I PSBCNT=0 S PSBCNT=1 Q
 ;
 S RESULTS(0)=PSBOKAY
 F X=1:1 Q:'$D(PSBOKAY(X))  S RESULTS($O(RESULTS(""),-1)+1)=PSBOKAY(X)
 Q
 ;
