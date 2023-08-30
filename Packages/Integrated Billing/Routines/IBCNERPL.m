IBCNERPL ;IB/BAA/AWC - IBCN HL7 RESPONSE REPORT PRINT;25 Feb 2015
 ;;2.0;INTEGRATED BILLING;**528,737**;21-MAR-94;Build 19
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
 N CRT,DDATA,DLINE,EORMSG,IBD,IBPGC,IBPXT,MAXCNT,NONEMSG,NPROC,SSN,SSNLEN,SRT1,SRT2,TSTAMP
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
 ;
 N IBPWIDTH S IBPWIDTH=$G(INCNESPJ("WIDTH")) S:IBPWIDTH="" IBPWIDTH=$S(TYPE="E":256,1:132)  ;IB*737/DTG get correct R margin
 ;
 S WIDTH=$S(TYPE="E":200,1:132)
 S $P(DASHES,"-",WIDTH)=""
 S HDR1=$$FMTE^XLFDT($G(INCNESPJ("BEGDT")),"5Z")_" - "_$$FMTE^XLFDT($G(INCNESPJ("ENDDT")),"5Z")
 ; Determine IO parameters
 S MAXCNT=IOSL-6,CRT=0
 S:IOST["C-" MAXCNT=IOSL-3,CRT=1
 ; print data
 S SRT1=""
 ; IB*737/DTG separate excel from report
 ;D HEADER I $G(ZTSTOP)!IBPXT Q
 ; If global does not exist - display No Data message
 ;I '$D(^TMP($J,IBCNERTN)) D LINE($$FO^IBCNEUT1(NONEMSG,$$CENTER(NONEMSG),"R")) G EXIT
 ;
 ;I TYPE="E" D  Q:$G(ZTSTOP)!IBPXT
 I TYPE="E" D  Q:$G(ZTSTOP)!IBPXT  D LINE(EORMSG) I CRT,IBPGC>0,'$D(ZTQUEUED) D EOL Q
 . I '$D(ZTQUEUED),$G(IOST)["C-" W !
 . D EHDR
 . I '$D(^TMP($J,IBCNERTN)) D LINE(NONEMSG) Q
 .; excel format
 .F  S SRT1=$O(^TMP($J,IBCNERTN,SRT1)) Q:SRT1=""  D  Q:$G(ZTSTOP)!IBPXT
 ..; D LINE("PYRNAME : "_SRT1)
 ..S SRT2="" F  S SRT2=$O(^TMP($J,IBCNERTN,SRT1,SRT2)) Q:SRT2=""  D  Q:$G(ZTSTOP)!IBPXT
 ...S N=0 F  S N=$O(^TMP($J,IBCNERTN,SRT1,SRT2,N)) Q:N=""  D  Q:$G(ZTSTOP)!IBPXT
 ....S LOUT=^TMP($J,IBCNERTN,SRT1,SRT2,N)
 ....;IB*737/DTG add 4 digit year and mm/dd
 ....;S SENT=$$FMTE^XLFDT($P(LOUT,U,4),1),$P(LOUT,U,4)=SENT
 ....;S RECVD=$$FMTE^XLFDT($P(LOUT,U,5),1),$P(LOUT,U,5)=RECVD
 ....S SENT=$$FMTE^XLFDT($P(LOUT,U,4),5),$P(LOUT,U,4)=SENT
 ....S RECVD=$$FMTE^XLFDT($P(LOUT,U,5),5),$P(LOUT,U,5)=RECVD
 ....D LINE(LOUT)
 ...Q
 ..Q
 .Q
 ;
 ;I TYPE="R" D  Q:$G(ZTSTOP)!IBPXT
 I TYPE="R" D  Q:$G(ZTSTOP)!IBPXT  D EXIT ; IB*737/DTG print end of report
 . D HEADER I $G(ZTSTOP)!IBPXT Q  ; IB*737/DTG separate header from excel
 . I '$D(^TMP($J,IBCNERTN)) D LINE($$FO^IBCNEUT1(NONEMSG,$$CENTER(NONEMSG),"R")) Q  ; IB*737/DTG seperate center of msg from excel
 .; report format
 .; IB*737/DTG correct quit on '^'
 .;F  S SRT1=$O(^TMP($J,IBCNERTN,SRT1)) Q:SRT1=""!$G(ZTSTOP)!IBPXT  D
 .F  S SRT1=$O(^TMP($J,IBCNERTN,SRT1)) Q:SRT1=""  D  Q:$G(ZTSTOP)!IBPXT
 ..D LINE($$FO^IBCNEUT1($S(SRT1=0:NPROC,1:SRT1),85)_"Count = "_^TMP($J,IBCNERTN,SRT1)) Q:$G(ZTSTOP)!IBPXT
 ..S SRT2="" F  S SRT2=$O(^TMP($J,IBCNERTN,SRT1,SRT2)) Q:SRT2=""  D  Q:$G(ZTSTOP)!IBPXT
 ...S N=0 F  S N=$O(^TMP($J,IBCNERTN,SRT1,SRT2,N)) Q:N=""  D PRINT Q:$G(ZTSTOP)!IBPXT
 Q
 ;
PRINT ; Get Print Info
 ; ?3,"Payer Name",?27,"Patient Name",?50,"SSN",?56,"Dt Sent",?76,"Dt Rec'd",?96,"Trace #",?115,"Buffer #"
 S DDATA=$G(^TMP($J,IBCNERTN,SRT1,SRT2,N)),DLINE=""
 ; IB*737/DTG truncate payer to 22, patient 21
 ;S $E(DLINE,3,24)=$P(DDATA,U)  ;PAYER
 S $E(DLINE,3,25)=$E($P(DDATA,U),1,23)  ;PAYER
 ;S $E(DLINE,27,47)=$P(DDATA,U,2)  ;PATIENT
 S $E(DLINE,27,47)=$E($P(DDATA,U,2),1,22)  ;PATIENT
 S $E(DLINE,50,53)=$P(DDATA,U,3)  ;SSN
 ;IB*737/DTG remove seconds add 4 digit year
 ;S $E(DLINE,56,73)=$$FMTE^XLFDT($P(DDATA,U,4),2)  ;SENT
 ;S $E(DLINE,76,93)=$$FMTE^XLFDT($P(DDATA,U,5),2)  ;RECEIVED
 S IBD=$$FMTE^XLFDT($P(DDATA,U,4),5),IBD=$P(IBD,":",1,2),$E(DLINE,56,73)=IBD  ;SENT
 S IBD=$$FMTE^XLFDT($P(DDATA,U,5),5),IBD=$P(IBD,":",1,2),$E(DLINE,76,93)=IBD  ;RECEIVED
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
EHDR ; print header for excel
 ; IB*737/DTG new tag, header for excel only
 ;
 S IBPGC=IBPGC+1
 W "HL7 Response Report"_U_TSTAMP,!
 W ?1,HDR1,!,!
 W ?1,$S($G(INCNESPJ("PYR"))="A":"All",1:"Selected")_" Payers",!
 W "Payer Name"_U_"Patient Name"_U_"SSN"_U_"Dt Sent"_U_"Dt Rec'd"_U_"Trace #"_U_"Buffer #"
 Q
 ;
HEADER ; print header for each page
 N HDR,OFFSET,SRT
 ;
 I CRT,IBPGC>0,'$D(ZTQUEUED) D EOL I IBPXT Q
 I $D(ZTQUEUED),$$S^%ZTLOAD() S (ZTSTOP,IBPXT)=1 Q
 S IBPGC=IBPGC+1
 W @IOF,!,?1,"HL7 Response Report"
 ; IB*737/DTG start manage right margin
 ;S HDR=TSTAMP_"  Page: "_IBPGC,OFFSET=(WIDTH-$L(HDR))
 S HDR=TSTAMP_"  Page: "_IBPGC
 S OFFSET=(IBPWIDTH-$L(HDR))
 W ?OFFSET,HDR
 W !,?1,HDR1,!,!
 W ?1,$S($G(INCNESPJ("PYR"))="A":"All",1:"Selected")_" Payers"
 ;
 ;I TYPE="R" W !,?3,"Payer Name",?27,"Patient Name",?50,"SSN",?56,"Dt Sent",?76,"Dt Rec'd",?96,"Trace #",?115,"Buffer #"
 W !,?3,"Payer Name",?27,"Patient Name",?50,"SSN",?56,"Dt Sent",?76,"Dt Rec'd",?96,"Trace #",?115,"Buffer #"
 W !,?1,DASHES
 Q
 ;
LINE(LINE) ; Print line of data
 ; IB*737/DTG handle Excel Header different than report
 ; I $Y+1>MAXCNT D HEADER I $G(ZTSTOP)!IBPXT Q
 I ($Y+1)#MAXCNT=0 D  I $G(ZTSTOP)!IBPXT Q
 . I TYPE="R" D HEADER
 . I TYPE="E",(CRT),(IBPGC>0),('$D(ZTQUEUED)) D EOL
 W !,?1,LINE
 Q
 ;
CENTER(LINE) ; return length of a centered line
 ; LINE - line to center
 N LENGTH,OFFSET
 ; IB*737/DTG correct center based on report width base
 ;S LENGTH=$L(LINE),OFFSET=IOM-$L(LINE)\2
 S LENGTH=$L(LINE)
 S OFFSET=(IBPWIDTH-LENGTH)\2
 Q OFFSET+LENGTH
