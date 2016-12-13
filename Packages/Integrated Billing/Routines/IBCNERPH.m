IBCNERPH ;BP/YMG - IBCNE EIV INSURANCE UPDATE REPORT PRINT;16-SEP-2009
 ;;2.0;INTEGRATED BILLING;**416,528,549**;16-SEP-09;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; IB*2.0*549 Changes to documentation
 ; IB*2.0*549 Sort is by payer name
 ; IB*2.0*549 Allow for new sort level
 ; variables from IBCNERPF and IBCNERPG:
 ;   IBCNERTN = "IBCNERPF"
 ;   IBCNESPC("BEGDT") = start date for date range
 ;   IBCNESPC("ENDDT") = end date for date range
 ;   IBCNESPC("INSCO") = "A" (All ins. cos.) OR "S" (Selected ins. cos.)
 ;   IBCNESPC("PYR") - If this ="A", then include all
 ;   IBCNESPC("PYR",ien) - payer iens for report, if IBCNESPC("PYR")="A", then include all
 ;                       = (1) ^ (2)
 ;     (1) Display insurance company detail - 0 = No / 1 = Yes
 ;     (2) Display all or some insurance companies - A = All companies/
 ;                                                   S = Specified companies
 ;   IBCNESPC("PYR",ien,coien) - payer iens and company ien for report
 ;                             = Count for insurance company
 ;   IBCNESPC("PAT",ien) = patient iens for report, if IBCNESPC("PAT")="A", then include all
 ;   IBCNESPC("TYPE") = report type: "S" - summary, "D" - detailed
 ;   IBOUT = "R" for Report format or "E" for Excel format
 ;
 ;   Summary report:
 ;     ^TMP($J,IBCNERTN)=Total Count
 ;     ^TMP($J,IBCNERTN,SORT1)=Payer Count
 ;     ^TMP($J,IBCNERTN,SORT1,SORT2)=Company Count
 ;     SORT1 - Payer Name, SORT2 - Company Name
 ;
 ;   Detailed report:
 ;     ^TMP($J,IBCNERTN,SORT1)=Count 
 ;     ^TMP($J,IBCNERTN,SORT1,SORT2)=Count 
 ;     ^TMP($J,IBCNERTN,SORT1,SORT2,SORT3)=Payer Name ^ Insurance Company Name ^ Pat. Name ^ SSN ^
 ;                                         Date Inquiry Sent ^ Date Policy Auto Updated ^ Days old ^ 
 ;                                         Trace Number
 ;     SORT1 - Payer Name, SORT2 - Date received, SORT3 - Count
 ;
 Q
 ;
EN(IBCNERTN,IBCNESPC,IBOUT) ; Entry point
 ; IB*2.0*549 Delete printed fields and their variables
 ; IB*2.0*549 Allow for new sort level
 N CRT,DDATA,DLINE,EORMSG,IBPGC,IBPXT,MAXCNT,NONEMSG,NPROC,SSN,SSNLEN,SRT1,SRT2,SRT3,TSTAMP,TYPE,WIDTH,X,Y
 S (IBPGC,IBPXT)=0
 S NONEMSG="* * * N O  D A T A  F O U N D * * *"
 ; IB*2.0*549 Modify EOR msg
 S EORMSG="*****END OF REPORT*****"
 S NPROC="Not Processed"
 S TSTAMP=$$FMTE^XLFDT($$NOW^XLFDT,1) ; time of report
 S TYPE=$G(IBCNESPC("TYPE")) ; report type
 S WIDTH=$S(TYPE="S":79,1:131)
 ; Determine IO parameters
 I "^R^E^"'[(U_$G(IBOUT)_U) S IBOUT="R"
 S MAXCNT=IOSL-6,CRT=0
 S:IOST["C-" MAXCNT=IOSL-3,CRT=1
 ; print data
 S SRT1=""
 D HEADER:IBOUT="R",PHDL:IBOUT="E" I $G(ZTSTOP)!IBPXT Q
 ; IB*2.0*549 Reformat header
 ; If global does not exist - display No Data message
 I '$D(^TMP($J,IBCNERTN)) D LINE($$FO^IBCNEUT1(NONEMSG,$L(NONEMSG),"L"),IBOUT) G EXIT
 I TYPE="S" D  Q:$G(ZTSTOP)!IBPXT
 .; summary report
 .; IB*2.0*549 Add Total Auto Updated line
 .D LINE("TOTAL AUTO UPDATED = "_+$G(^TMP($J,IBCNERTN)),IBOUT)
 .W !
 .F  S SRT1=$O(^TMP($J,IBCNERTN,SRT1)) Q:SRT1=""!$G(ZTSTOP)!IBPXT  D
 ..; IB*2.0*549 Add payer count
 ..I SRT1'="*",IBOUT="R" D LINE(SRT1_" = "_+$G(^TMP($J,IBCNERTN,SRT1)),IBOUT)
 ..S SRT2="" F  S SRT2=$O(^TMP($J,IBCNERTN,SRT1,SRT2)) Q:SRT2=""!$G(ZTSTOP)!IBPXT  D
 ...; IB*2.0*549 Change line
 ...I IBOUT="E" D LINE($S(SRT1="*":"ALL",1:SRT1)_U_$S(SRT2=0:NPROC,1:SRT2)_U_^TMP($J,IBCNERTN,SRT1,SRT2),IBOUT) Q
 ...D LINE("       "_SRT2_" = "_+$G(^TMP($J,IBCNERTN,SRT1,SRT2)),IBOUT)
 ...Q
 ..Q
 .; IB*2.0*549 Add space between report and end of report line
 .W !
 .Q
 I TYPE="D" D  Q:$G(ZTSTOP)!IBPXT
 .; detailed report
 .F  S SRT1=$O(^TMP($J,IBCNERTN,SRT1)) Q:SRT1=""!$G(ZTSTOP)!IBPXT  D
 ..; IB*2.0*549 Get rid of the count line
 ..S SRT2="" F  S SRT2=$O(^TMP($J,IBCNERTN,SRT1,SRT2)) Q:SRT2=""!$G(ZTSTOP)!IBPXT  D
 ...S SRT3="" F  S SRT3=$O(^TMP($J,IBCNERTN,SRT1,SRT2,SRT3)) Q:SRT3=""!$G(ZTSTOP)!IBPXT  D
 ....S DDATA=$G(^TMP($J,IBCNERTN,SRT1,SRT2,SRT3)),DLINE="",SSN=$P(DDATA,U,4)
 ....I IBOUT="E" D XLDATA(SSN) Q
 ....; IB*2.0*549 For detailed version do not display date eIV response received,
 ....;            'Ck AB', 'Clerk/Auto' and 'Verified'
 ....; IB*2.0*549 Add fields:  Insurance Company, date eIV inquiry sent, date
 ....;                         policy auto updated, and eIV Trace number
 ....S $E(DLINE,1,24)=$E($P(DDATA,U),1,24) ;     Payer name
 ....S $E(DLINE,28,43)=$E($P(DDATA,U,2),1,16) ;  Insurance company name
 ....S $E(DLINE,46,60)=$E($P(DDATA,U,3),1,15) ;  Patient name
 ....S SSNLEN=$L(SSN),$E(DLINE,63,66)=$E(SSN,SSNLEN-3,SSNLEN)
 ....S $E(DLINE,69,76)=$E($P(DDATA,U,5),1,8) ;   Date sent
 ....S $E(DLINE,79,86)=$E($P(DDATA,U,6),1,8) ;   Date auto updated
 ....S $E(DLINE,89,95)=$J($P(DDATA,U,7),4) ;     Days
 ....S $E(DLINE,98,107)=$E($P(DDATA,U,8),1,10) ; eIV trace number
 ....D LINE(DLINE,IBOUT)
 ....Q
 ...Q
 ..Q
 .; IB*2.0*549 Add space between report and end of report line
 .W !
 .Q
 ;
EXIT ;
 ; IB*2.0*549 Left-justify end of report message
 D LINE($$FO^IBCNEUT1(EORMSG,$L(EORMSG),"L"),IBOUT)
 I CRT,IBPGC>0,'$D(ZTQUEUED) D EOL
 Q
 ;
XLDATA(SSN) ; Excel detailed output
 W !,$P(DDATA,U,1,3)_U_$E(SSN,$L(SSN)-3,$L(SSN))_U_$P(DDATA,U,5,8)
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
 N DASHES,DELTA,HDR,LEN,OFFSET,POS,STRING
 ;
 I CRT,IBPGC>0,'$D(ZTQUEUED) D EOL I IBPXT Q
 I $D(ZTQUEUED),$$S^%ZTLOAD() S (ZTSTOP,IBPXT)=1 Q
 S IBPGC=IBPGC+1
 ; IB*2.0*549 Change report name to Auto Update Report
 W @IOF,!
 S HDR=$J("",WIDTH)
 S STRING=" Auto Update Report",$E(HDR,1,$L(STRING))=STRING
 S STRING="  Page: "_IBPGC,$E(HDR,WIDTH-$L(STRING)+1,WIDTH)=STRING
 S LEN=$L(TSTAMP)
 S DELTA=(WIDTH#2),POS=(WIDTH\2+DELTA)-(LEN\2)+1
 S $E(HDR,POS,POS+$L(TSTAMP)-1)=TSTAMP
 W HDR W:TYPE="S" !
 S HDR=$$FMTE^XLFDT($G(IBCNESPC("BEGDT")),"5Z")_" - "_$$FMTE^XLFDT($G(IBCNESPC("ENDDT")),"5Z")
 W !?1,"Response Received: ",HDR
 W !?2,$S(TYPE="D":"Detailed",1:"Summary")_" Report: "
 W $S($G(IBCNESPC("PYR"))="A":"All",1:"Selected")_" Payers"
 ; IB*2.0*549 For detailed version do not display date eIV response received,
 ;            'Ck AB', 'Clerk/Auto' and 'Verified'
 ; IB*2.0*549 Add fields:  Insurance Company, date eIV inquiry sent, date
 ;                         policy auto updated, and eIV Trace number
 I TYPE="D" D
 .; IB*2.0*549 Fix selected/all insurance co
 .W "; ",$S($G(IBCNESPC("INSCO"))="S":"Selected",1:"All")
 .W " Insurance Companies; "
 .W $S($G(IBCNESPC("PAT"))="A":"All",1:"Selected")_" Patients"
 .; IB*2.0*549 Fix header for screen
 .S STRING="Payer",$E(STRING,28,45)="Insurance Co",$E(STRING,46,62)="Patient Name"
 .S $E(STRING,63,68)="SSN",$E(STRING,69,78)="Dt Sent",$E(STRING,79,88)="Auto Dt"
 .S $E(STRING,89,97)="Days",$E(STRING,98,131)="eIV Trace#"
 .W !!,?1,STRING
 S $P(DASHES,"-",WIDTH-2)="" W !,?1,DASHES
 Q
 ;
LINE(LINE,IBOUT) ; Print line of data
 I $Y+1>MAXCNT,IBOUT="R" D HEADER I $G(ZTSTOP)!IBPXT Q
 W ! W:IBOUT="R" ?1 W LINE
 Q
 ;
CENTER(LINE) ; return length of a centered line
 ; LINE - line to center
 N LENGTH,OFFSET
 S LENGTH=$L(LINE),OFFSET=IOM-$L(LINE)\2
 Q OFFSET+LENGTH
 ;
PHDL ; - Print the header line for the Excel spreadsheet
 ; IB*2.0*549 - Add report header
 N HDR,IBHDT,X
 D NOW^%DTC
 S IBHDT=$$DAT2^IBOUTL($E(%,1,12))
 W "Auto Update Report",?53,"Run On: ",IBHDT
 S HDR=$$FMTE^XLFDT($G(IBCNESPC("BEGDT")),"5Z")_" - "_$$FMTE^XLFDT($G(IBCNESPC("ENDDT")),"5Z")
 W !?1,"Response Received: ",HDR
 W !?2,$S(TYPE="D":"Detailed",1:"Summary")_" Report: "
 W $S($G(IBCNESPC("PYR"))="A":"All",1:"Selected")_" Payers"
 I TYPE="D" D
 .W "; ",$S($G(IBCNESPC("INSCO"))="S":"Selected",1:"All")
 .W " Insurance Companies; "
 .W $S($G(IBCNESPC("PAT"))="A":"All",1:"Selected")_" Patients"
 W !!
 S IBPGC=1
 D
 .I TYPE="S" S X="Payer Name^Insurance Co^Count" Q
 .I TYPE="D" D
 ..S X="Payer^Insurance Co^Patient Name^SSN^Dt Sent^Auto Dt"
 ..S X=X_"^Days^eIV Trace#"
 W X
 Q
