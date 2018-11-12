RCDPRTEX ;ALB/LMH - Claims Matching Report for Excel ;30-SEP 2016
 ;;4.5;Accounts Receivable;**315,339**;Mar 20, 1995;Build 2
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
PRINT ; Entry point for printing the Excel version of the report (either in foreground or background)
 ; Input: 
 ;    RCEXCEL=1 here
 ; Output: 
 ;    Report is printed in text format for Excel (turn on logging)
 ; 
 U IO
 K ^TMP("RCDPRTPB",$J),^TMP("IBRBT",$J),^TMP("IBRBF",$J)
 N DAT,RCBIL,RCBIL0,RCNAM,RCPAY,RCPAY1,RCREC,RCREC1,RCRECTDA,RCSSN,RCTYP,CRT,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 N RCSTOP,PAGE,SEPLINE,X,XX,Y,RCNO
 S CRT=$S(IOST["C-":1,1:0) ; 1 - Print to Screen, 0 - Otherwise
 I '$D(ZTQUEUED) U 0 W !!?5,"Compiling Claims Matching Report for Excel output. Please wait ... " U IO
 ;
 ; build the initial ^TMP("RCDPRTPB",$J) scratch global
 D @($S(RCSORT=1:"PAT",RCSORT=2:"BILL",RCSORT=3:"DATE",RCSORT=4:"REC",RCSORT=5:"TYPE")_"^RCDPRTP0")
 ;
 S IOSL=999999 ; Long screen length for Excel output
 S PAGE=0,RCSTOP=0,$P(SEPLINE,"-",81)=""
 ;
 I '$D(^TMP("RCDPRTPB",$J)) D  Q
 . W:CRT @IOF W:'CRT $C(13)    ; initial form feed or page reset for no data found
 . W !!?5,"No data found for this report."
 . I CRT,'$D(ZTQUEUED) S DIR(0)="E" D ^DIR K DIR
 . D ^%ZISC
 . Q
 ;
START ;
 N RCPAT0,NAME,BILLNUM,BILLFROM,BILLTO,RXCOV,RCIBFN,DOB,AMT,CHGTYP,STATUS
 N RCH,AMT1,PAYOR,PST,FILLFROM,FILLTO,ONHOLD,RCAMT,RCAMT1,RCIBDAT,STRING,RCBILL0
 N RCQ,RCSSN,RCTP,RCEXNAM,ELIG,FPCBILL,POSTDATE,RCDOB,RCFLAG,BAL,DATE,DEBTOR,RCDATE,RCDEBTOR,RCNAME
 D EXCELHD
 ;
 S RCNAM="" F  S RCNAM=$O(^TMP("RCDPRTPB",$J,RCNAM)) Q:RCNAM=""  D
 .S RCBILL=0 F  S RCBILL=$O(^TMP("RCDPRTPB",$J,RCNAM,RCBILL)) Q:'RCBILL  D
 ..D DEMOG
 ..D PROC^RCDPRTP1 ;    Process each third party bill for a patient.
 ..K ^TMP("IBRBT",$J),^TMP("IBRBF",$J)
 ;
 D ^%ZISC
 K ^TMP("RCDPRTPB",$J)
 Q
 ;
DEMOG ; Demographic data for third party bills &  
 ;        first party charges detail line header 
 ; 
 S RCPAT0=$G(^TMP("RCDPRTPB",$J,RCNAM))
 S DATE=$G(^TMP("RCDPRTPB",$J,RCNAM,RCBILL))
 S RCNAME=$P(RCNAM,"^")
 S RCBILL0=$G(^PRCA(430,RCBILL,0))
 S RCDFN=$P($G(^PRCA(430,RCBILL,0)),U,7)
 S RCDOB=$P($G(^DPT(RCDFN,0)),U,3)
 S DOB=$$FMTE^XLFDT(RCDOB,"5Z")
 S DEBTOR=$P($G(RCBILL0),U,9)
 S RCDEBTOR=$O(^RCD(340,"B",RCDFN_";DPT(",0)) Q:'RCDEBTOR
 S RCSSN=$$SSN^RCFN01($G(RCDEBTOR))
 S ELIG=$P($G(RCPAT0),U,2)
 Q
 ;
PRNTPAT ; setup & print third party bills (called by PROC^RCDPRTP1 for Excel output only)
 S RCTP=RCBILL,RCIBDAT=$G(^TMP("IBRBT",$J,RCBILL,RCBILL))
 S STATUS=$$STAT^RCDPRTP2(RCTP) Q:STATUS="CN"!(STATUS="CB")  ;Added a last minute check for cancelled third party bills
 S RXCOV=$S('$G(^TMP("IBRBT",$J,RCBILL)):"NO",1:"YES")
 S BILLNUM=$P(RCIBDAT,U,4) ; BILL #
 S PST=$P(RCIBDAT,U,5) ; P/S/T
 S BILLFROM=$$DATE^RCDPRTP2($P(RCIBDAT,U)) ; bill date from
 S BILLTO=$$DATE^RCDPRTP2($P(RCIBDAT,U,2)) ; bill date to
 S RCDATE=$S($G(RCTP(RCTP)):RCTP(RCTP),$G(^TMP("RCDPRTPB",$J,RCNAM,RCBILL)):^(RCBILL),1:"") I RCTP=RCBILL!($D(RCTP(RCTP))) S POSTDATE=$$DATE^RCDPRTP2(RCDATE)
 S RCIBFN=RCTP
 S RCDATE=$P($G(^PRCA(430,+RCTP,0)),U,14)
 S POSTDATE=$S(RCDATE=DATE:$$DATE^RCDPRTP2(RCDATE),RCDATE'=DATE:"^")
 S PAYOR=$P(RCIBDAT,U,7) ; payor
 S RCAMT=$P($G(^PRCA(430,+RCTP,0)),"^",3) ; amt billed
 S RCAMT1=$P($G(^PRCA(430,+RCTP,7)),"^",7) ; amt paid
 S RCTYPE=$$TYP^IBRFN(RCTP) ;Third party bill type of care
 S RCTYPE=$S(RCTYPE="":-1,RCTYPE="PR":"P",RCTYPE="PH":"R",1:RCTYPE)
 S RCFLAG=RCTYPE
 S RCTP=RCBILL
 D EXCELPAT
 ;
EXCELTPB ; print other assoc. third party bills
 S RCTP=0 F  S RCTP=$O(^TMP("IBRBT",$J,RCBILL,RCTP)) Q:'RCTP  D
 .S STATUS=$$STAT^RCDPRTP2(RCTP) Q:STATUS="CN"!(STATUS="CB")  ;Added a last minute check for cancelled third party bills
 .I RCBILL=RCTP Q  ; don't reprint the bill that was paid.
 .S RCIBDAT=$G(^TMP("IBRBT",$J,RCBILL,RCTP))
 .I 'RCAN,($P(RCIBDAT,"^",3)) Q  ; exclude cancelled bills
 .D DEMOG
 .S RXCOV=$S('$G(^TMP("IBRBT",$J,RCBILL)):"NO",1:"YES")
 .S BILLNUM=$P(RCIBDAT,U,4) ; BILL #
 .S PST=$P(RCIBDAT,U,5) ; P/S/T
 .S BILLFROM=$$DATE^RCDPRTP2($P(RCIBDAT,U)) ; bill date from
 .S BILLTO=$$DATE^RCDPRTP2($P(RCIBDAT,U,2)) ; bill date to
 .S RCDATE=$P($G(^PRCA(430,+RCTP,0)),U,14)
 .S POSTDATE=$S(RCDATE=DATE:$$DATE^RCDPRTP2(RCDATE),RCDATE'=DATE:"^")
 .S RCIBFN=RCTP
 .S PAYOR=$P(RCIBDAT,U,7) ; payor 
 .S RCAMT=$P($G(^PRCA(430,+RCTP,0)),"^",3) ; amt billed
 .S RCAMT1=$P($G(^PRCA(430,+RCTP,7)),"^",7) ; amt paid
 .S RCTYPE=$$TYP^IBRFN(RCTP) ;Third party bill type of care
 .S RCTYPE=$S(RCTYPE="":-1,RCTYPE="PR":"P",RCTYPE="PH":"R",1:RCTYPE)
 .D EXCELPAT
 ;
PRNTFPC ; print associated first party charges
 ; This code screens entries from file 350.1 returned by API - RELBILL^IBRFN
 N RCACTYP,I,J    ;Do the next section of code only if Care Types were selected - Stored in RCTYPE([care type])
 ; We must loop through all Bills and First party charges for this screening
 I $D(RCTYPE)>1 S I=0 F  S I=$O(^TMP("IBRBF",$J,I)) Q:'I  S J=0 F  S J=$O(^TMP("IBRBF",$J,I,J)) Q:'J  D
 . S RCACTYP=$P(^TMP("IBRBF",$J,I,J),U,6) Q:RCACTYP=""  ;6th piece is Action Type
 . I RCACTYP["TRICARE"!(RCACTYP["CHAMPA") Q  ;Not needed for screening 1st party charges
 . I RCACTYP["RX" S RCTYP="R" D KILFPTY^RCDPRTP1 Q
 . I RCACTYP["OPT"!(RCACTYP["OBSERV") S RCTYP="O" D KILFPTY^RCDPRTP1 Q
 . I RCACTYP["INPT"!(RCACTYP["NHCU")!(RCACTYP["ADMIS")!(RCACTYP["MEDICARE DECUCTIBLE") S RCTYP="I" D KILFPTY^RCDPRTP1 Q
 . Q
 ;
 S RCTP(0)=0 F  S RCTP(0)=$O(^TMP("IBRBF",$J,RCTP(0))) Q:'RCTP(0)!$G(RCQ)  D
 .S RCTP=0 F  S RCTP=$O(^TMP("IBRBF",$J,RCTP(0),RCTP)) Q:'RCTP!$G(RCQ)  D 
 ..S RCNO=1
 ..S RCIBDAT=$G(^TMP("IBRBF",$J,RCTP(0),RCTP))
 ..S RCIBFN=$P(RCIBDAT,U,4) I RCIBFN S RCIBFN=$O(^PRCA(430,"B",RCIBFN,0))
 ..D DEMOG
 ..S RXCOV=$S('$G(^TMP("IBRBT",$J,RCBILL)):"NO",1:"YES")
 ..S FILLFROM=$$DATE^RCDPRTP2(+RCIBDAT) ; Bill from
 ..S FILLTO=$$DATE^RCDPRTP2($P(RCIBDAT,U,2)) ; Bill to
 ..S CHGTYP=$P(RCIBDAT,U,6)
 ..S RCIBFN=$P(RCIBDAT,"^",4) I RCIBFN S RCIBFN=$O(^PRCA(430,"B",RCIBFN,0))
 ..S FPCBILL=$P(RCIBDAT,U,4)
 ..S STATUS=$$STAT^RCDPRTP2(RCIBFN) ; Status
 ..S ONHOLD=$P(RCIBDAT,U,7) ; # Days On Hold
 ..S AMT=$P(RCIBDAT,U,5) ; Amount billed
 ..S BAL=$S($G(^PRCA(430,+RCIBFN,7)):+($P(^(7),"^")+$P(^(7),"^",2)+$P(^(7),"^",3)+$P(^(7),"^",4)+$P(^(7),"^",4)),1:0)
 ..D EXCELFPC
 .Q
 Q
 ;
EXCELHD ; Print an Excel CSV header record
 ;
 ; Input: None
 ; Output: Header line printed for CSV format (excel)
 ;
 W:CRT @IOF W:'CRT $C(13)    ; initial form feed or page reset for Excel header line
 N RCH
 S STRING=""
 S RCH=$$CSV("","Patient")
 S RCH=$$CSV(RCH,"SSN")
 S RCH=$$CSV(RCH,"DOB")
 S RCH=$$CSV(RCH,"Prim. Elig")
 S RCH=$$CSV(RCH,"RX Cvg")
 S RCH=$$CSV(RCH,"Bill Type")
 S RCH=$$CSV(RCH,"Bill#")
 S RCH=$$CSV(RCH,"P/S/T")
 S RCH=$$CSV(RCH,"Chg Type")
 S RCH=$$CSV(RCH,"Status")
 S RCH=$$CSV(RCH,"Bill From")
 S RCH=$$CSV(RCH,"Bill To")
 S RCH=$$CSV(RCH,"Posted")
 S RCH=$$CSV(RCH,"Amt Billed")
 S RCH=$$CSV(RCH,"Amt Pd")
 S RCH=$$CSV(RCH,"Bal")
 S RCH=$$CSV(RCH,"Care Type")
 S RCH=$$CSV(RCH,"On Hold")
 S RCH=$$CSV(RCH,"Payor")
 W RCH
 Q
 ;
EXCELPAT ; Print patient third party bills
 ;
 ; Input: None
 ; Output: Detail line printed for CSV format (excel)
 ;
 N RCD
 S STRING=""
 S RCD=$$CSV("",RCNAME)_"^"_$E(RCNAME,1)_$E(RCSSN,6,9)
 S RCD=$$CSV(RCD,DOB)
 S RCD=$$CSV(RCD,ELIG)
 S RCD=$$CSV(RCD,RXCOV)
 S RCD=$$CSV(RCD,"Third Party Bill")
 S RCD=$$CSV(RCD,BILLNUM)
 S RCD=$$CSV(RCD,PST)
 S RCD=$$CSV(RCD,"^")
 S RCD=$$CSV(RCD,STATUS)
 S RCD=$$CSV(RCD,BILLFROM)
 S RCD=$$CSV(RCD,BILLTO)
 S RCD=$$CSV(RCD,POSTDATE)
 S RCD=$$CSV(RCD,RCAMT)
 S RCD=$$CSV(RCD,RCAMT1)
 S RCD=$$CSV(RCD,"^")
 S RCD=$$CSV(RCD,RCTYPE)
 S RCD=$$CSV(RCD,"^")
 S RCD=$$CSV(RCD,PAYOR)
 W !,RCD
 K RCTP(RCTP)
 Q
 ;
EXCELFPC ; Print patient first party charges
 ;
 ; Input: None
 ; Output: Detail line printed for CSV format (excel)
 ;
 N RCB
 S STRING=""
 S RCB=$$CSV("",RCNAME)_"^"_$E(RCNAME,1)_$E(RCSSN,6,9)
 S RCB=$$CSV(RCB,DOB)
 S RCB=$$CSV(RCB,ELIG)
 S RCB=$$CSV(RCB,"^")
 S RCB=$$CSV(RCB,"First Party Charge")
 S RCB=$$CSV(RCB,FPCBILL)
 S RCB=$$CSV(RCB,"^")
 S RCB=$$CSV(RCB,CHGTYP)
 S RCB=$$CSV(RCB,STATUS)
 S RCB=$$CSV(RCB,FILLFROM)
 S RCB=$$CSV(RCB,FILLTO)
 S RCB=$$CSV(RCB,"^")
 S RCB=$$CSV(RCB,AMT)
 S RCB=$$CSV(RCB,"^")
 S RCB=$$CSV(RCB,BAL)
 S RCB=$$CSV(RCB,"^")
 S RCB=$$CSV(RCB,ONHOLD)
 W !,RCB
 Q
 ;
CSV(STRING,DATA) ; Build the Excel data string for CSV format
 ; Input: STRING - Current string being built or ""
 ; DATA - New data to be added to the string
 ; Returns: STRING - Updated string with DATA added
 ; 
 S DATA=""_$TR(DATA,$C(94))
 S STRING=$S(STRING="":DATA,1:STRING_"^"_DATA)
 Q STRING
 ;
