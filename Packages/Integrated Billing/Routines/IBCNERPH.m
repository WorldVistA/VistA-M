IBCNERPH ;BP/YMG - IBCNE EIV INSURANCE UPDATE REPORT PRINT;16-SEP-2009
 ;;2.0;INTEGRATED BILLING;**416,528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; variables from IBCNERPF and IBCNERPG:
 ;   IBCNERTN = "IBCNERPF"
 ;   IBCNESPC("BEGDT") = start date for date range
 ;   IBCNESPC("ENDDT") = end date for date range
 ;   IBCNESPC("PYR",ien) = payer iens for report, if IBCNESPC("PYR")="A", then include all
 ;   IBCNESPC("PAT",ien) = patient iens for report, if IBCNESPC("PAT")="A", then include all
 ;   IBCNESPC("SORT") = sort by: 1 - Payer name, 2 - Patient Name, 3 - Clerk Name
 ;   IBCNESPC("TYPE") = report type: "S" - summary, "D" - detailed
 ;   IBOUT = "R" for Report format or "E" for Excel format
 ;
 ;   Summary report:
 ;     ^TMP($J,IBCNERTN,SORT1,SORT2)=Count
 ;     SORT1 - Payer Name or *, SORT2 - Clerk Name or 0 if not processed
 ;
 ;   Detailed report:
 ;     ^TMP($J,IBCNERTN,SORT1)=Count 
 ;     ^TMP($J,IBCNERTN,SORT1,SORT2)=Pat. Name ^ SSN ^ Date received ^ Payer Name ^ Ck AB ^ Clerk Name ^ Date Verified ^ Days old
 ;     SORT1 - Payer Name, Patient Name, or Clerk Name, SORT2 - Date received
 ;
 Q
 ;
EN(IBCNERTN,IBCNESPC,IBOUT) ; Entry point
 N CLNAME,CRT,DDATA,DLINE,EORMSG,IBPGC,IBPXT,MAXCNT,NONEMSG,NPROC,SSN,SSNLEN,SRT1,SRT2,TSTAMP,TYPE,VDATE,WIDTH,X,Y
 S (IBPGC,IBPXT)=0
 S NONEMSG="* * * N O  D A T A  F O U N D * * *"
 S EORMSG="*** END OF REPORT ***"
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
 ; If global does not exist - display No Data message
 I '$D(^TMP($J,IBCNERTN)) D LINE($$FO^IBCNEUT1(NONEMSG,$$CENTER(NONEMSG),"R"),IBOUT) G EXIT
 I TYPE="S" D  Q:$G(ZTSTOP)!IBPXT
 .; summary report
 .F  S SRT1=$O(^TMP($J,IBCNERTN,SRT1)) Q:SRT1=""!$G(ZTSTOP)!IBPXT  D
 ..I SRT1'="*",IBOUT="R" D LINE(SRT1,IBOUT)
 ..S SRT2="" F  S SRT2=$O(^TMP($J,IBCNERTN,SRT1,SRT2)) Q:SRT2=""!$G(ZTSTOP)!IBPXT  D
 ...I IBOUT="E" D LINE($S(SRT1="*":"ALL",1:SRT1)_U_$S(SRT2=0:NPROC,1:SRT2)_U_^TMP($J,IBCNERTN,SRT1,SRT2),IBOUT) Q
 ...D LINE($$FO^IBCNEUT1("  "_$S(SRT2=0:NPROC,1:SRT2),40)_"Count = "_^TMP($J,IBCNERTN,SRT1,SRT2),IBOUT)
 ...Q
 ..Q
 .Q
 I TYPE="D" D  Q:$G(ZTSTOP)!IBPXT
 .; detailed report
 .F  S SRT1=$O(^TMP($J,IBCNERTN,SRT1)) Q:SRT1=""!$G(ZTSTOP)!IBPXT  D
 ..I IBOUT="R" D LINE($$FO^IBCNEUT1($S(SRT1=0:NPROC,1:SRT1),85)_"Count = "_^TMP($J,IBCNERTN,SRT1),IBOUT)
 ..S SRT2="" F  S SRT2=$O(^TMP($J,IBCNERTN,SRT1,SRT2)) Q:SRT2=""!$G(ZTSTOP)!IBPXT  D
 ...S DDATA=$G(^TMP($J,IBCNERTN,SRT1,SRT2)),DLINE="",SSN=$P(DDATA,U,2)
 ...I IBOUT="E" D XLDATA Q
 ...S $E(DLINE,3,22)=$P(DDATA,U)
 ...S SSNLEN=$L(SSN),$E(DLINE,23,28)=$E(SSN,SSNLEN-3,SSNLEN)
 ...S $E(DLINE,29,41)=$$FMTE^XLFDT($P(DDATA,U,3)\1,"5Z")
 ...S $E(DLINE,42,69)=$P(DDATA,U,4),$E(DLINE,72,77)=$P(DDATA,U,5)
 ...S CLNAME=$P(DDATA,U,6) S:CLNAME=0 CLNAME=NPROC S $E(DLINE,78,94)=CLNAME
 ...S VDATE=$$FMTE^XLFDT($P(DDATA,U,7)\1,"5Z") S:'VDATE VDATE="  N/A" S $E(DLINE,115,127)=VDATE
 ...S $E(DLINE,127,131)=$P(DDATA,U,8)
 ...D LINE(DLINE,IBOUT)
 ...Q
 ..Q
 .Q
 ;
EXIT ;
 D LINE($$FO^IBCNEUT1(EORMSG,$$CENTER(EORMSG),"R"),IBOUT)
 I CRT,IBPGC>0,'$D(ZTQUEUED) D EOL
 Q
 ;
XLDATA ; Excel detailed output
 W !,$P(DDATA,U)_U_$E(SSN,$L(SSN)-3,$L(SSN))_U_$$FMTE^XLFDT($P(DDATA,U,3)\1,"5Z")_U_$P(DDATA,U,4,5)
 W U_$S($P(DDATA,U,6)=0:NPROC,1:$P(DDATA,U,6))
 S VDATE=$$FMTE^XLFDT($P(DDATA,U,7)\1,"5Z") W U_$S('VDATE:" N/A",1:VDATE)_U_$P(DDATA,U,8)_U_^TMP($J,IBCNERTN,SRT1)
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
 N DASHES,HDR,OFFSET,SRT
 ;
 I CRT,IBPGC>0,'$D(ZTQUEUED) D EOL I IBPXT Q
 I $D(ZTQUEUED),$$S^%ZTLOAD() S (ZTSTOP,IBPXT)=1 Q
 S IBPGC=IBPGC+1
 W @IOF,!,?1,"Pt. Insurance Update Report"
 S HDR=TSTAMP_"  Page: "_IBPGC,OFFSET=WIDTH-$L(HDR)
 W ?OFFSET,HDR
 S SRT=$G(IBCNESPC("SORT"))
 I TYPE="S" W !,?1,"Sorted by: Clerk Name"
 I TYPE="D" W !,?1,"Sorted by: "_$S(SRT=1:"Payer Name",SRT=2:"Patient Name",1:"Clerk Name")
 S HDR=$$FMTE^XLFDT($G(IBCNESPC("BEGDT")),"5Z")_" - "_$$FMTE^XLFDT($G(IBCNESPC("ENDDT")),"5Z")
 S OFFSET=WIDTH-$L(HDR)
 W ?OFFSET,HDR
 W !,?1,$S(TYPE="D":"Detailed",1:"Summary")_" Report: "
 W $S($G(IBCNESPC("PAT"))="A":"All",1:"Selected")_" Patients; "
 W $S($G(IBCNESPC("PYR"))="A":"All",1:"Selected")_" Payers"
 I TYPE="D" W !!,?3,"Patient Name",?23,"SSN",?29,"Dt Rec'd",?42,"Payer",?70,"Ck AB",?78,"Clerk/Auto",?115,"Verified",?127,"Days"
 S $P(DASHES,"-",WIDTH)="" W !,?1,DASHES
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
 N X
 S IBPGC=1
 I TYPE="S" S X="Payer Name^Clerk Name^Count"
 I TYPE="D" S X="Patient Name^SSN^Date Received^Payer^Ck AB^Clerk/Auto^Verified^Days^Count"
 W X
 Q
