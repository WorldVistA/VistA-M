IBCNERPL ;IB/BAA/AWC - IBCN HL7 RESPONSE REPORT PRINT;25 Feb 2015
 ;;2.0;INTEGRATED BILLING;**528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; variables from IBCNERPJ and IBCNERPK:
 ;   IBCNERTN = "IBCNERPF"
 ;   INCNESPJ("BEGDT") = start date for date range
 ;   INCNESPJ("ENDDT") = end date for date range
 ;   INCNESPJ("PYR",ien) = payer iens for report, if INCNESPJ("PYR")="A", then include all
 ;   IBCNESPJ("PAT",ien) = patient iens for report, if IBCNESPJ("PAT")="A", then include all
 ;   INCNESPJ("TYPE") = report type: "R" - Report, "E" - Excel
 ;
 ; Output :
 ;
 ;   Detailed report:
 ;     ^TMP($J,IBCNERTN,Payer Name)=Count 
 ;     ^TMP($J,IBCNERTN,Payer Name,N)=Payer Name ^ Patient Name ^ Date sent  
 ;                      ^ Date Received ^ Trace number ^ Buffer Number
 ;
 Q
 ;
EN(IBCNERTN,INCNESPJ) ; Entry point
 N CRT,DDATA,DLINE,EORMSG,IBPGC,IBPXT,MAXCNT,NONEMSG,NPROC,SSN,SSNLEN,SRT1,SRT2,TSTAMP
 N TYPE,VDATE,WIDTH,X,Y,SENT,RECVD,STATION,DEFSTAT,DASHES,HD1,HD2,HD3
 N DEFINST,HDR1,LOUT,N,SITE,VISN
 S DEFINST=$P($G(^XTV(8989.3,1,"XUS")),U,17)
 S STATION=$P($G(^DIC(4,DEFINST,99)),U)
 I STATION="" S STATION=DEFINST
 S VISN=$$VISN^IBATUTL(STATION)
 S SITE=$$SITE^VASITE,SITE=$P(SITE,U,2)_" : "_$P(SITE,U,3)
 S (IBPGC,IBPXT)=0
 S NONEMSG="* * * N O  D A T A  F O U N D * * *"
 S EORMSG="*** END OF REPORT ***"
 S NPROC="Not Processed"
 S TSTAMP=$$FMTE^XLFDT($$NOW^XLFDT,1) ; time of report
 S TYPE=$G(INCNESPJ("TYPE")) ; report type
 S WIDTH=$S(TYPE="E":200,1:132)
 S $P(DASHES,"-",WIDTH)=""
 S HDR1=$$FMTE^XLFDT($G(INCNESPJ("BEGDT")),"5Z")_" - "_$$FMTE^XLFDT($G(INCNESPJ("ENDDT")),"5Z")
 ; Determine IO parameters
 S MAXCNT=IOSL-6,CRT=0
 S:IOST["C-" MAXCNT=IOSL-3,CRT=1
 ; print data
 S SRT1=""
 D HEADER I $G(ZTSTOP)!IBPXT Q
 ; If global does not exist - display No Data message
 I '$D(^TMP($J,IBCNERTN)) D LINE($$FO^IBCNEUT1(NONEMSG,$$CENTER(NONEMSG),"R")) G EXIT
 I TYPE="E" D  Q:$G(ZTSTOP)!IBPXT
 .; excel format
 .F  S SRT1=$O(^TMP($J,IBCNERTN,SRT1)) Q:SRT1=""!$G(ZTSTOP)!IBPXT  D
 ..D LINE("PYRNAME : "_SRT1)
 ..S SRT2="" F  S SRT2=$O(^TMP($J,IBCNERTN,SRT1,SRT2)) Q:SRT2=""!$G(ZTSTOP)!IBPXT  D
 ...S N=0 F  S N=$O(^TMP($J,IBCNERTN,SRT1,SRT2,N)) Q:N=""  D
 ....S LOUT=^TMP($J,IBCNERTN,SRT1,SRT2,N)
 ....S SENT=$$FMTE^XLFDT($P(LOUT,U,4),1),$P(LOUT,U,4)=SENT
 ....S RECVD=$$FMTE^XLFDT($P(LOUT,U,5),1),$P(LOUT,U,5)=RECVD
 ....D LINE(LOUT)
 ...Q
 ..Q
 .Q
 I TYPE="R" D  Q:$G(ZTSTOP)!IBPXT
 .; report format
 .F  S SRT1=$O(^TMP($J,IBCNERTN,SRT1)) Q:SRT1=""!$G(ZTSTOP)!IBPXT  D
 ..D LINE($$FO^IBCNEUT1($S(SRT1=0:NPROC,1:SRT1),85)_"Count = "_^TMP($J,IBCNERTN,SRT1))
 ..S SRT2="" F  S SRT2=$O(^TMP($J,IBCNERTN,SRT1,SRT2)) Q:SRT2=""!$G(ZTSTOP)!IBPXT  D 
 ...S N=0 F  S N=$O(^TMP($J,IBCNERTN,SRT1,SRT2,N)) Q:N=""  D PRINT
 Q
 ;
PRINT ; Get Print Info
 ; ?3,"Payer Name",?27,"Patient Name",?50,"SSN",?56,"Dt Sent",?76,"Dt Rec'd",?96,"Trace #",?115,"Buffer #"
 S DDATA=$G(^TMP($J,IBCNERTN,SRT1,SRT2,N)),DLINE=""
 S $E(DLINE,3,24)=$P(DDATA,U)  ;PAYER
 S $E(DLINE,27,47)=$P(DDATA,U,2)  ;PATIENT
 S $E(DLINE,50,53)=$P(DDATA,U,3)  ;SSN
 S $E(DLINE,56,73)=$$FMTE^XLFDT($P(DDATA,U,4),2)  ;SENT
 S $E(DLINE,76,93)=$$FMTE^XLFDT($P(DDATA,U,5),2)  ;RECEEIVED
 S $E(DLINE,96,112)=$P(DDATA,U,6)  ;TRACE #
 S $E(DLINE,115,132)=$P(DDATA,U,7)  ;BUFFER #
 D LINE(DLINE)
 Q
 ;
EXIT ;
 D LINE($$FO^IBCNEUT1(EORMSG,$$CENTER(EORMSG),"R"))
 I CRT,IBPGC>0,'$D(ZTQUEUED) D EOL
 Q
 ;
EOL ; display "end of page" message and set exit flag
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LIN
 I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 S DIR(0)="E" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S IBPXT=1
 Q
 ;
HEADER ; print header for each page
 N HDR,OFFSET,SRT
 ;
 I CRT,IBPGC>0,'$D(ZTQUEUED) D EOL I IBPXT Q
 I $D(ZTQUEUED),$$S^%ZTLOAD() S (ZTSTOP,IBPXT)=1 Q
 S IBPGC=IBPGC+1
 W @IOF,!,?1,"HL7 Response Report"
 S HDR=TSTAMP_"  Page: "_IBPGC,OFFSET=(WIDTH-$L(HDR))
 W ?OFFSET,HDR
 W !,?1,HDR1,!,! ;AWC/  IB*2.0*528  Put in a tab and the new lines to correct a Defect
 W ?1,$S($G(INCNESPJ("PYR"))="A":"All",1:"Selected")_" Payers" ;AWC/  IB*2.0*528  Put in a tab to line up the report to correct a Defect
 I TYPE="R" W !,?3,"Payer Name",?27,"Patient Name",?50,"SSN",?56,"Dt Sent",?76,"Dt Rec'd",?96,"Trace #",?115,"Buffer #"
 I TYPE="E" W !,"Payer Name"_U_"Patient Name"_U_"SSN"_U_"Dt Sent"_U_"Dt Rec'd"_U_"Trace #"_U_"Buffer #"
 W !,?1,DASHES
 Q
 ;
LINE(LINE) ; Print line of data
 I $Y+1>MAXCNT D HEADER I $G(ZTSTOP)!IBPXT Q
 W !,?1,LINE
 Q
 ;
CENTER(LINE) ; return length of a centered line
 ; LINE - line to center
 N LENGTH,OFFSET
 S LENGTH=$L(LINE),OFFSET=IOM-$L(LINE)\2
 Q OFFSET+LENGTH
