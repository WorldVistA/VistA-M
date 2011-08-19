ALPBFRM1 ;OIFO-DALLAS MW,SED,KC -STANDARD PRINT FORMATTING UTIL;01/01/03
 ;;3.0;BAR CODE MED ADMIN;**8**;Mar 2004
 ;
F132(DATA,DAYS,MLCNT,RESULTS,ALPPAT) ; format data into a 132-column
 ; output array...
 ; DATA = an array containing a specific order node for a selected
 ;        patient in file 53.7
 ; DAYS = a number that represents the number of initial boxes
 ;        (1 box = 1 day) to add to lines 4-10 (max=7 -- note that
 ;        this is usually a 3-day MAR, but a 7-day MAR could be
 ;        returned from this format utility)
 ; MLCNT = Number of Med-log entries to print with orders
 ; RESULTS = an array passed by reference into which the formatted
 ;           entry is set up returns a formatted array in RESULTS
 ;           (note: total line count is returned at RESULTS(0))
 I $D(DATA)="" Q
 ;
 N ALPBADM,ALPBDAYS,ALPBDRUG,ALPBIBOX,ALPBNBOX,ALPBPBOX,ALPBSTOP,ALPBTEXT,ALPBTIME,ALPBX,DATE,LINE,BOLDON,BOLDOFF,X,ALPBPRNG,ALPBFLG,ALPBPRN,ALPBMLC
 ; to use BOLD, comment out the next line and remove comments from
 ; the following five lines...
 S BOLDON="<<",BOLDOFF=">>"
 ;S X="IOINHI;IOINORM"
 ;D ENDR^%ZISS
 ;S BOLDON=$G(IOINHI)
 ;S BOLDOFF=$G(IOINORM)
 ;D KILL^%ZISS
 ;
 ;S MLCNT=$S(+$P($G(^ALPB(53.71,1,2)),U,4)>0:+$P(^ALPB(53.71,1,2),U,4),1:1)
 I $G(DAYS)="" S DAYS=3
 I DAYS>7 S DAYS=7
 S DATE=$$DT^XLFDT()
 D FDATES^ALPBUTL(DATE,DAYS,.ALPBDAYS)
 ; get administration timing (needed for formatting various lines)
 S ALPBX=$P($G(DATA(4)),"^",4)
 I ALPBX="" S ALPBADM=0
 I ALPBX'="" D
 .S ALPBADM=0
 .F I=1:1 Q:$P(ALPBX,"-",I)=""  D
 ..S ALPBADM(I)=$P(ALPBX,"-",I)
 ..S ALPBADM=ALPBADM+1
 ; line 1...
 S RESULTS(1)=""
 S RESULTS(1)=$$PAD^ALPBUTL(RESULTS(1),66)_"Admin"
 ; line 2...
 S RESULTS(2)="Start"
 S RESULTS(2)=$$PAD^ALPBUTL(RESULTS(2),25)_"Stop"
 S RESULTS(2)=$$PAD^ALPBUTL(RESULTS(2),66)_"Times"
 S RESULTS(2)=$$PAD^ALPBUTL(RESULTS(2),74)_ALPBDAYS(0)
 I DAYS=3 S RESULTS(2)=RESULTS(2)_"   Notes"
 ; line 3...
 S RESULTS(3)=$$REPEAT^XLFSTR("-",132)
 ; line 4...
 ; start and stop date/times...
 S RESULTS(4)=$S($P($G(DATA(1)),"^")'="":$$FMTE^XLFDT($P(DATA(1),"^")),1:"Not on file")
 S RESULTS(4)=$$PAD^ALPBUTL(RESULTS(4),25)_$S($P($G(DATA(1)),"^",2)'="":$$FMTE^XLFDT($P(DATA(1),"^",2)),1:"Not on file")
 ;
 ; end of fixed line format, continue...
 S LINE=4
 ; get drug(s)...
 I +$O(DATA(7,0)) D
 .S LINE=LINE+1
 .S RESULTS(LINE)=""
 .S ALPBX=0
 .F  S ALPBX=$O(DATA(7,ALPBX)) Q:'ALPBX  D
 ..S ALPBDRUG=$G(BOLDON)_$P(DATA(7,ALPBX,0),"^",2)_$G(BOLDOFF)
 ..;S RESULTS(LINE)=$G(RESULTS(LINE))_$P(DATA(7,ALPBX,0),"^",2)
 ..S RESULTS(LINE)=$G(RESULTS(LINE))_ALPBDRUG
 ..K ALPBDRUG
 ..I +$O(DATA(7,ALPBX)) S LINE=LINE+1
 ; any additives...
 I +$O(DATA(8,0)) D
 .S LINE=LINE+1
 .S RESULTS(LINE)=" Additive(s): "
 .S ALPBX=0
 .F  S ALPBX=$O(DATA(8,ALPBX)) Q:'ALPBX  D
 ..S ALPBDRUG=$P(DATA(8,ALPBX,0),"^",2)
 ..; if UNITS is not already contained in ADDITIVE NAME, add it...
 ..I $P(DATA(8,ALPBX,0),"^",3)'=""&(ALPBDRUG'[$P(DATA(8,ALPBX,0),"^",3)) S ALPBDRUG=ALPBDRUG_" "_$P(DATA(8,ALPBX,0),"^",3)
 ..S ALPBDRUG=$G(BOLDON)_ALPBDRUG_$G(BOLDOFF)
 ..S RESULTS(LINE)=RESULTS(LINE)_ALPBDRUG
 ..K ALPBDRUG
 ..I +$O(DATA(8,ALPBX)) D
 ...S LINE=LINE+1
 ...S RESULTS(LINE)=" "
 ...S RESULTS(LINE)=$$PAD^ALPBUTL(RESULTS(LINE),14)
 .K ALPBX
 ; any solutions...
 I +$O(DATA(9,0)) D
 .S LINE=LINE+1
 .S RESULTS(LINE)=" Solution(s): "
 .S ALPBX=0
 .F  S ALPBX=$O(DATA(9,ALPBX)) Q:'ALPBX  D
 ..S ALPBDRUG=$P(DATA(9,ALPBX,0),"^",2)
 ..; if UNITS is not already contained in SOLUTION NAME, add it...
 ..I $P(DATA(9,ALPBX,0),"^",3)'=""&(ALPBDRUG'[$P(DATA(9,ALPBX,0),"^",3)) S ALPBDRUG=ALPBDRUG_" "_$P(DATA(9,ALPBX,0),"^",3)
 ..S ALPBDRUG=$G(BOLDON)_ALPBDRUG_$G(BOLDOFF)
 ..S RESULTS(LINE)=RESULTS(LINE)_ALPBDRUG
 ..K ALPBDRUG
 ..I +$O(DATA(9,ALPBX)) D
 ...S LINE=LINE+1
 ...S RESULTS(LINE)=" "
 ...S RESULTS(LINE)=$$PAD^ALPBUTL(RESULTS(LINE),14)
 .K ALPBX
 ; give ($P(DATA(4),"^",1)=DOSAGE  $P(DATA(4),"^",2)=ROUTE  $P(DATA(4),"^",3)=SCHEDULE)...
 S LINE=LINE+1
 S RESULTS(LINE)="        Give: "_$P($G(DATA(4)),"^")_" "_$P($G(DATA(4)),"^",2)_" "_$P($G(DATA(4)),"^",3)
 ;Set PRN Flag
 S ALPBPRNG=0
 S:$P($G(DATA(4)),"^",3)["PRN" ALPBPRNG=1
 ;
 ; provider comments, special instructions, and other print info...
 I +$O(DATA(5,0)) D
 .K ALPBCMNT
 .M ALPBCMNT=DATA(5)
 .S ALPBCOL=60
 .D FTEXT^ALPBFRMU(ALPBCOL,.ALPBCMNT,.ALPBTEXT)
 .K ALPBCMNT
 .S ALPBX=0
 .F  S ALPBX=$O(ALPBTEXT(ALPBX)) Q:'ALPBX  D
 ..S ALPBLINE=ALPBTEXT(ALPBX,0)
 ..S LINE=LINE+1
 ..S RESULTS(LINE)=ALPBLINE
 .K ALPBCOL,ALPBLINE,ALPBTEXT,ALPBX
 ;S LINE=LINE+1,RESULTS(LINE)=""
 ;
 ; provider, pharmacist or entry person, and verifier...
 S LINE=LINE+1
 S RESULTS(LINE)="    Provider: "_$P($G(DATA(2)),"^")
 S LINE=LINE+1
 S RESULTS(LINE)="RPh/Entry by: "_$P($G(DATA(2)),"^",2)
 I $P($G(DATA(2)),"^",3)'="" D
 .S LINE=LINE+1
 .S RESULTS(LINE)=" Verified by: "_$P(DATA(2),"^",3)
 ; order number and type...
 S LINE=LINE+1
 S RESULTS(LINE)="     Order #: "_$P(DATA(0),"^")
 S RESULTS(LINE)=$$PAD^ALPBUTL(RESULTS(LINE),25)_"Type: "_$$OTYP^ALPBUTL($P($G(DATA(3)),"^"))
 ; order status...
 S LINE=LINE+1
 S RESULTS(LINE)="      Status: "_$P($P(DATA(0),"^",3),"~",2)
 ;
 ; med log data...
 S LINE=LINE+1
 S RESULTS(LINE)="BCMA MEDICATION LOG HISTORY"
 ;I $G(MLDATE)'="" S RESULTS(LINE)=RESULTS(LINE)_" (since "_$$FMTE^XLFDT(MLDATE)_")"
 I +$O(DATA(10,0))=0 D
 .S LINE=LINE+1
 .S RESULTS(LINE)=" No Medication Log entries are on file for this order."
 I +$O(DATA(10,0)) D
 .S LINE=LINE+1
 .S RESULTS(LINE)=" Log Date"
 .S RESULTS(LINE)=$$PAD^ALPBUTL(RESULTS(LINE),16)_"Message"
 .S RESULTS(LINE)=$$PAD^ALPBUTL(RESULTS(LINE),31)_"Log Entry Person"
 .I $O(DATA(10,"IMLOG",0))="" D
 ..S LINE=LINE+1
 ..S RESULTS(LINE)=" No entries since the above date are on file."
 .;S ALPBMDT=MLDATE
 .S ALPBMDT=0,ALPBMLC=1
 .F  S ALPBMDT=$O(DATA(10,"IMLOG",ALPBMDT)) Q:'ALPBMDT!(ALPBMLC>MLCNT)  D
 ..S ALPBX=0
 ..F  S ALPBX=$O(DATA(10,"IMLOG",ALPBMDT,ALPBX)) Q:'ALPBX!(ALPBMLC>MLCNT)  D
 ...S LINE=LINE+1,ALPBMLC=ALPBMLC+1
 ...S RESULTS(LINE)=" "_$$FDATE^ALPBUTL($P(DATA(10,ALPBX,0),"^",1))
 ...S RESULTS(LINE)=$$PAD^ALPBUTL(RESULTS(LINE),16)_$P(DATA(10,ALPBX,0),"^",3)
 ...S RESULTS(LINE)=$$PAD^ALPBUTL(RESULTS(LINE),31)_$S($P(DATA(10,ALPBX,0),"^",2)'="":$P(DATA(10,ALPBX,0),"^",2),1:"<not on file")
 ..K ALPBX
 .K ALPBMDT,ALPBMLC
 ;
 ; BCMA LAST ACTION
 I +$G(ALPPAT)>0 D
 .S ALPBX=0
 .F  S ALPBX=$O(DATA(7,ALPBX)) Q:'ALPBX  D
 ..S ALPDRUG=$P(DATA(7,ALPBX,0),"^",1),ALPBDNM=$P(DATA(7,ALPBX,0),"^",2)
 ..Q:+ALPDRUG'>0
 ..S ALPLACT=$$LACT^ALPBUTL3(ALPPAT,ALPDRUG)
 ..I ALPLACT'="" D
 ...S LINE=LINE+1,RESULTS(LINE)=$$REPEAT^XLFSTR("-",75)
 ...S LINE=LINE+1
 ...S RESULTS(LINE)="Last action for "_ALPBDNM_"  "_" was "_$P(ALPLACT,"^",3)_" on "_$$FDATE^ALPBUTL($P(ALPLACT,"^",1))
 ...S RESULTS(LINE)=RESULTS(LINE)_" By "_$S($P(ALPLACT,"^",2)'="":$P(ALPLACT,"^",2),1:"<not on file>")
 K ALPLACT,ALPDRUG,ALPBX
 ;
 I LINE<11 F I=1:1 Q:LINE=11  D
 .S LINE=LINE+1
 .S RESULTS(LINE)=""
 ;
 ; now add admin times and initial boxes to lines 4-10 as required
 ; by number of administration times...
 S ALPBIBOX="______|"
 S ALPBNBOX="******|"
 I +$G(ALPBADM)=0 S ALPBADM=8
 ;S ALPBPRN=ALPBADM+4
 S ALPBSTOP=$P($G(DATA(1)),"^",2)
 F I=1:1:ALPBADM D
 .S ALPBPRN=I+3
 .S ALPBADMT=$G(ALPBADM(I))
 .I ALPBADMT="" S ALPBADMT="    "
 .I '$D(RESULTS(I+3)) D
 ..S RESULTS(I+3)=" "
 ..S LINE=LINE+1
 .S RESULTS(I+3)=$$PAD^ALPBUTL(RESULTS(I+3),65)_"| "
 .S RESULTS(I+3)=RESULTS(I+3)_$S($L(ALPBADMT)=2:ALPBADMT_"00",1:ALPBADMT)
 .S RESULTS(I+3)=$$PAD^ALPBUTL(RESULTS(I+3),74)_"|"
 .F J=1:1:DAYS D
 ..S ALPBDAY=ALPBDAYS(J)_"."_ALPBADMT
 ..S ALPBPBOX=ALPBIBOX
 ..I ALPBDAY=ALPBSTOP!(ALPBDAY>ALPBSTOP) S ALPBPBOX=ALPBNBOX
 ..S RESULTS(I+3)=RESULTS(I+3)_ALPBPBOX
 .K ALPBADMT,ALPBPBOX,ALPBDAY
 K ALPBIBOX,ALPBNBOX
 ; if PRN med, add line for documenting effectiveness...
 I +ALPBPRNG D
 .S ALPBFLG=0,ALPBPRN=ALPBPRN+1
 .S:'$D(RESULTS(ALPBPRN)) RESULTS(ALPBPRN)=" ",ALPBFLG=1
 .S RESULTS(ALPBPRN)=$$PAD^ALPBUTL(RESULTS(ALPBPRN),63)_"  PRN Effectiveness:_____________"
 .S:ALPBFLG LINE=LINE+1
 S LINE=LINE+1
 S RESULTS(LINE)=$$REPEAT^XLFSTR("-",132)
 S RESULTS(0)=LINE
 Q
