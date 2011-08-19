ALPBFRM2 ;OIFO-DALLAS MW,SED,KC-SCREEN DISPLAY FORMATTING UTIL ;01/01/03
 ;;3.0;BAR CODE MED ADMIN;**8**;Mar 2004
 ;
F80(DATA,MLDATE,RESULTS) ; format basic output for screen (80-column) display...
 ; DATA = array passed by reference containing the data record to be formatted
 ; MLDATE = a date from which med log data is retrieved
 ; returns RESULTS array with formatted output (note:  total lines returned in RESULTS(0))
 N ALPBCMNT,ALPBMDT,ALPBTEXT,ALPBX,LINE
 S RESULTS(0)=0
 S RESULTS(1)=" Order Number: "_$S($P($G(DATA(0)),"^")'="":$P(DATA(0),"^"),1:"??")
 S RESULTS(1)=$$PAD^ALPBUTL(RESULTS(1),50)_"Start: "
 S RESULTS(1)=RESULTS(1)_$S($P($G(DATA(1)),"^")'="":$$FMTE^XLFDT($P(DATA(1),"^")),1:"<not on file>")
 S RESULTS(2)="         Type: "_$$OTYP^ALPBUTL($P(DATA(3),"^"))
 S RESULTS(2)=$$PAD^ALPBUTL(RESULTS(2),51)_"Stop: "
 S RESULTS(2)=RESULTS(2)_$S($P($G(DATA(1)),"^",2)'="":$$FMTE^XLFDT($P(DATA(1),"^",2)),1:"<not on file>")
 S RESULTS(3)="       Status: "_$P($P(DATA(0),"^",3),"~",2)
 S LINE=3
 ; drug(s)...
 I +$O(DATA(7,0)) D
 .S LINE=LINE+1
 .S RESULTS(LINE)="         Drug: "
 .S ALPBX=0
 .F  S ALPBX=$O(DATA(7,ALPBX)) Q:'ALPBX  D
 ..S RESULTS(LINE)=$G(RESULTS(LINE))_$P(DATA(7,ALPBX,0),"^",2)
 ..I +$O(DATA(7,ALPBX)) D
 ...S LINE=LINE+1
 ...S RESULTS(LINE)=" "
 ...S RESULTS(LINE)=$$PAD^ALPBUTL(RESULTS(LINE),14)
 .K ALPBX
 ;
 ; any additives...
 I +$O(DATA(8,0)) D
 .S LINE=LINE+1
 .S RESULTS(LINE)="Additive Info: "
 .S ALPBX=0
 .F  S ALPBX=$O(DATA(8,ALPBX)) Q:'ALPBX  D
 ..S RESULTS(LINE)=RESULTS(LINE)_$P(DATA(8,ALPBX,0),"^",2)
 ..; if UNITS isn't already contained in ADDITIVE NAME, add it...
 ..I $P(DATA(8,ALPBX,0),"^",3)'=""&($P(DATA(8,ALPBX,0),"^",2)'[$P(DATA(8,ALPBX,0),"^",3)) S RESULTS(LINE)=RESULTS(LINE)_" "_$P(DATA(8,ALPBX,0),"^",3)
 ..I +$O(DATA(8,ALPBX)) D
 ...S LINE=LINE+1
 ...S RESULTS(LINE)=" "
 ...S RESULTS(LINE)=$$PAD^ALPBUTL(RESULTS(LINE),14)
 .K ALPBX
 ;
 ; any solutions...
 I +$O(DATA(9,0)) D
 .S LINE=LINE+1
 .S RESULTS(LINE)="Solution Info: "
 .S ALPBX=0
 .F  S ALPBX=$O(DATA(9,ALPBX)) Q:'ALPBX  D
 ..S RESULTS(LINE)=RESULTS(LINE)_$P(DATA(9,ALPBX,0),"^",2)
 ..; if UNITS isn't already contained in SOLUTION NAME, add it...
 ..I $P(DATA(9,ALPBX,0),"^",3)'=""&($P(DATA(9,ALPBX,0),"^",2)'[$P(DATA(9,ALPBX,0),"^",3)) S RESULTS(LINE)=RESULTS(LINE)_" "_$P(DATA(9,ALPBX,0),"^",3)
 ..I +$O(DATA(9,ALPBX)) D
 ...S LINE=LINE+1
 ...S RESULTS(LINE)=" "
 ...S RESULTS(LINE)=$$PAD^ALPBUTL(RESULTS(LINE),14)
 .K ALPBX
 ;
 ; give ($P(DATA(4),"^",1)=DOSAGE  $P(DATA(4),"^",2)=ROUTE  $P(DATA(4),"^",3)=SCHEDULE)...
 S LINE=LINE+1
 S RESULTS(LINE)="         Give: "_$P($G(DATA(4)),"^")_" "_$P($G(DATA(4)),"^",2)_" "_$P($G(DATA(4)),"^",3)
 ; provider, pharmacist or entry person, and verifier...
 S LINE=LINE+1
 S RESULTS(LINE)="     Provider: "_$P($G(DATA(2)),"^")
 S RESULTS(LINE)=$$PAD^ALPBUTL(RESULTS(LINE),43)_"RPh/Entry by: "_$P($G(DATA(2)),"^",2)
 I $P($G(DATA(2)),"^",3)'="" D
 .S LINE=LINE+1
 .S RESULTS(LINE)="  Verified by: "_$P(DATA(2),"^",3)
 ; administration times...
 S LINE=LINE+1
 S RESULTS(LINE)=" Admin. Times: "_$P($G(DATA(4)),"^",4)
 ; provider comments, special instructions or other print info...
 I +$O(DATA(5,0)) D
 .M ALPBCMNT=DATA(5)
 .D FTEXT^ALPBFRMU(78,.ALPBCMNT,.ALPBTEXT)
 .K ALPBCMNT
 .S ALPBX=0
 .F  S ALPBX=$O(ALPBTEXT(ALPBX)) Q:'ALPBX  D
 ..S LINE=LINE+1
 ..S RESULTS(LINE)=ALPBTEXT(ALPBX,0)
 .K ALPBTEXT,ALPBX
 ; med log data...
 I +$O(DATA(10,0)) D
 .S LINE=LINE+1
 .S RESULTS(LINE)="BCMA Medication Log History since "_$$FMTE^XLFDT(MLDATE)
 .S LINE=LINE+1
 .S RESULTS(LINE)=" Log Date"
 .S RESULTS(LINE)=$$PAD^ALPBUTL(RESULTS(LINE),16)_"Message"
 .S RESULTS(LINE)=$$PAD^ALPBUTL(RESULTS(LINE),31)_"Log Entry Person"
 .I $O(DATA(10,"B",MLDATE))="" D
 ..S LINE=LINE+1
 ..S RESULTS(LINE)="No entries to report."
 .S ALPBMDT=MLDATE
 .F  S ALPBMDT=$O(DATA(10,"B",ALPBMDT)) Q:'ALPBMDT  D
 ..S ALPBX=0
 ..F  S ALPBX=$O(DATA(10,"B",ALPBMDT,ALPBX)) Q:'ALPBX  D
 ...S LINE=LINE+1
 ...S RESULTS(LINE)=" "_$$FDATE^ALPBUTL(ALPBMDT)
 ...S RESULTS(LINE)=$$PAD^ALPBUTL(RESULTS(LINE),16)_$P(DATA(10,ALPBX,0),"^",3)
 ...S RESULTS(LINE)=$$PAD^ALPBUTL(RESULTS(LINE),31)_$S($P(DATA(10,ALPBX,0),"^",2)'="":$P(DATA(10,ALPBX,0),"^",2),1:"<not on file>")
 ..K ALPBX
 .K ALPBMDT
 S LINE=LINE+1
 S RESULTS(LINE)=$$REPEAT^XLFSTR("-",80)
 S RESULTS(0)=LINE
 Q
 ;
HDR(DATA,TYPE,PG,RESULTS) ; screen display header...
 ; DATA = array passed by reference containing the data record to be formatted
 ; TYPE = either 'A' for ALL orders or 'C' for CURRENT orders.  if null, not used in construction
 ;        of first line of returned array
 ; PG   = page number
 ; RESULTS = an array passed by reference into which the formatted output will be saved
 ; returns RESULTS array with formatted output (note:  total lines returned in RESULTS(0))
 N ALPBX,LINE
 I $G(TYPE)="" S TYPE="X"
 I $G(PG)="" S PG=0
 S RESULTS(0)=0
 S RESULTS(1)=$S(TYPE="A":"ALL ",TYPE="C":"CURRENT ",1:"")_"ORDERS"
 S RESULTS(1)=$$PAD^ALPBUTL(RESULTS(1),70)_"Page: "_$J(PG,3)
 S RESULTS(2)=$P($G(DATA(0)),"^")
 S RESULTS(2)=$$PAD^ALPBUTL(RESULTS(2),32)_"SSN: "_$P($G(DATA(0)),"^",2)
 S RESULTS(2)=$$PAD^ALPBUTL(RESULTS(2),48)_"Ward: "_$P($G(DATA(0)),"^",5)
 S RESULTS(3)="This record last updated: "_$S($P(DATA(0),"^",8)'="":$$FMTE^XLFDT($P(DATA(0),"^",8)),1:"<date not on file>")
 S RESULTS(3)=$$PAD^ALPBUTL(RESULTS(3),48)_"Room: "_$P(DATA(0),"^",6)_" Bed: "_$P(DATA(0),"^",7)
 S LINE=3
 I +$O(DATA(1,0)) D
 .S LINE=LINE+1
 .S RESULTS(LINE)="Allergies: "
 .S ALPBX=0
 .F  S ALPBX=$O(DATA(1,ALPBX)) Q:'ALPBX  D
 ..S RESULTS(LINE)=RESULTS(LINE)_$P(DATA(1,ALPBX,0),"^",2)
 ..I +$O(DATA(1,ALPBX)) S RESULTS(LINE)=RESULTS(LINE)_"; "
 S LINE=LINE+1
 S RESULTS(LINE)=$$REPEAT^XLFSTR("-",80)
 S RESULTS(0)=LINE
 Q
