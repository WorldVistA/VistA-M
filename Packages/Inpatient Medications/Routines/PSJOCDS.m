PSJOCDS ;BIR/MV - SET INPUT DATA FOR DOSING ORDER CHECKS ;6 Jun 07 / 3:37 PM
 ;;5.0; INPATIENT MEDICATIONS ;**181**;16 DEC 97;Build 190
 ;
 ; Reference to ^PS(55 is supported by DBIA #2191.
 ; Reference to ^PSSORPH is supported by DBIA #3234.
 ; Reference to ^PSSDSAPI is supported by DBIA #5425.
 ; Reference to ^PSSDSAPD is supported by DBIA #5426.
 ; Reference to FULL^VALM1 and PAUSE^VALM1 is supported by DBIA #10116.
 ;
 ;The Dose API will be processed separately than the DD & DT order checks
 ;
IN(PSJPON,PSJTYPE,PSJDD) ;
 ;PSJPON - Order number
 ;PSJPTYPE - UD/IV
 ;PSJDD - Dispense drug IEN (for UD order only)
 ;
 ;PSJOVR array is defined when OVERLAP^PSGOEF2 is called.
 ;
 Q:'$$DS^PSSDSAPI()
 NEW PSJOCDS,PSJFDB,PSJBASE,PSJOVR,PSJOVRLP
 K PSJOCDS,PSJFDB
 D FULL^VALM1
 I '$$PING^PSJOC("No dosing checks can be performed") Q
 K ^TMP($J,"PSJPRE"),^TMP($J,"PSJPRE1")
 S PSJBASE(1)="PSJPRE",PSJBASE(3)="PSJPRE1"
 ;
 ;;**** Commmented out complex dosing
 ;;PSJOCDSC("CX","PSJCOM") is to flag if dosing checks needs to handle comlex orders.
 ;;*I '$D(PSJOCDSC("CX","PSJCOM")) D
 ;;*. I $G(PSJCOM),$$CONJ^PSJOCDSC() S PSJOCDSC("CX","PSJCOM")=1
 ;;*I $G(PSJOCDSC("CX","PSJCOM")),'$D(PSJOCDSC("CX","ACX")) D SETLST^PSJOCDSC(PSJPON)
 ;;*I PSJTYPE="UD" D UD I $G(PSJOCDSC("CX","PSJCOM")) D COMPLEX^PSJOCDSC Q
 ;;*I PSJTYPE="IV" D IN^PSIVOCDS("PSJPRE") D:$G(PSJOCDSC("CX","PSJCOM")) IV^PSJOCDSC(PSJPON),UPDLST^PSJOCDSC(PSJPON,2)
 ;;**** End Complex dosing
 ;
 ;;****To be removed when complex dosing is ready
 I PSJTYPE="UD" D UD
 I PSJTYPE="IV" D IN^PSIVOCDS("PSJPRE")
 ;;****END
 ;
 I '$D(PSJFDB) Q
 D DOSE^PSSDSAPD(.PSJBASE,DFN,.PSJOCDS,.PSJFDB)
 D DISPLAY^PSJOCDSD
 ;;*I '$G(PSGORQF),(PSJTYPE="IV"),$G(PSJOCDSC("CX","PSJCOM")) D NODAILY^PSJOCDSP(PSJPON)
 K ^TMP($J,"PSJPRE"),^TMP($J,"PSJPRE1")
 Q
UD ;Process data from a UD order
 NEW PSJDS,PSJFREQ,X
 ;At this state a dispense drug should be selected already.  But just incase...
 Q:'+PSJDD
 K PSJOCDS,PSJFDB
 ;If the drug is to be exempted then exclude it from the dose check
 Q:$$EXMT^PSSDSAPI(PSJDD)
 S PSJCNT=1
 S PSJDS=""
 ;
 S X=$$DOSE()
 S PSJOCDS(PSJCNT,"DRG_AMT")=$P(X,U)
 S PSJOCDS(PSJCNT,"DRG_UNIT")=$P(X,U,2)
 S PSJOCDS(PSJCNT,"DO")=$P(X,U,3)
 ;
 S X=$$DATES(PSJPON)
 S X=$$DURATION($P(X,U),$P(X,U,2))
 ;S X=$$DURATION($G(PSGSD),$G(PSGFD))
 S PSJOCDS(PSJCNT,"DRATE")=$S(+X:X_"M",1:"")
 ;S PSJOCDS(PSJCNT,"DUR")=X
 ;S PSJOCDS(PSJCNT,"DUR_RT")=$S(+X:"MINUTE",1:"")
 S PSJOCDS(PSJCNT,"MR_IEN")=$G(PSGMR)
 S PSJOCDS(PSJCNT,"SCHEDULE")=$G(PSGSCH)
 D FDBDATA
 D LITTER
 Q
FDBDATA ;Set data needed by FDB's Dose API
 ;Use the OI + Dosage form when display drug name.  If OI IEN doesn't exist, use DD name
 NEW PSJOINM,PSJXSCH,X
 S PSJFDB(PSJCNT,"RX_NUM")="I;"_PSJPON_";PROSPECTIVE;"_PSJCNT
 S PSJFDB(PSJCNT,"DRUG_IEN")=PSJDD
 S PSJOINM=$$DRGNM^PSGSICHK()
 S PSJFDB(PSJCNT,"DRUG_NM")=$S(PSJOINM]"":PSJOINM,1:$$DN^PSJMISC(+PSJDD))
 I PSJOCDS(PSJCNT,"DO")=(PSJOCDS(PSJCNT,"DRG_AMT")_PSJOCDS(PSJCNT,"DRG_UNIT")) D
 . Q:PSJOCDS(PSJCNT,"DO")=""
 .;Strip off leading zero otherwise FDB triggers an "Invalid or Undefined Dose"
 . S X=PSJOCDS(PSJCNT,"DRG_AMT")
 . S PSJFDB(PSJCNT,"DOSE_AMT")=$S(+X=0:X,1:+X)
 . S PSJFDB(PSJCNT,"DOSE_UNIT")=$$UNIT^PSSDSAPI(PSJOCDS(PSJCNT,"DRG_UNIT"))
 S PSJFDB(PSJCNT,"DOSE_RATE")="DAY"
 ;
 S X="",PSJXSCH=PSGSCH
 I $G(PSGS0XT)="" S PSGS0XT=$$DOW^PSJAPIDS(PSGSCH)
 I $G(PSGS0XT)="D",$G(PSGS0Y)]"" S $P(PSJXSCH,"@",2)=$G(PSGS0Y)
 I $G(PSGSCH)]"" S X=$P($$FRQ^PSSDSAPI(PSJXSCH,$G(PSGS0XT),"I"),U)
 I X="" S X=1 S PSJFDB(PSJCNT,"FRQ_ERROR")=""
 S PSJFDB(PSJCNT,"FREQ")=X
 S PSJFDB(PSJCNT,"DURATION")=1
 S PSJFDB(PSJCNT,"DURATION_RT")="DAY"
 S PSJFDB(PSJCNT,"ROUTE")=$P($$MRT^PSSDSAPI($G(PSGMR)),U,2)
 S PSJFDB(PSJCNT,"DOSE_TYPE")="MAINTENANCE"
 S PSJFDB(PSJCNT,"SPECIFIC")=1
 ;Set data for onetime or <24 hours order
 S X=$$ONE^PSJORPOE($G(PSGSCH))
 I +X!($G(PSGST)="O")!+$$ONCALL^PSJMISC($G(PSGSCH),$G(PSGST)) D  Q
 . K PSJFDB(PSJCNT,"FRQ_ERROR")
 . S PSJFDB(PSJCNT,"DOSE_TYPE")="SINGLE DOSE"
 . S PSJFDB(PSJCNT,"DURATION")=1
 . S PSJFDB(PSJCNT,"DURATION_RT")=PSJFDB(PSJCNT,"DURATION_RT")
 . S PSJFDB(PSJCNT,"FREQ")=1
 I +PSJOCDS(PSJCNT,"DRATE") D UND24HRS(+PSJOCDS(PSJCNT,"DRATE"),$G(PSGAT),$G(PSGS0XT),PSGSD,PSGFD,PSGSCH)
 Q
LITTER ;FDB requires "L" instead of ML for the particular conditions below
 NEW PSJXDO
 Q:'$G(PSJDD)
 Q:$G(PSJFDB(1,"ROUTE"))'="INTRAVENOUS"
 Q:$G(PSGST)'="R"
 Q:$$VAGEN^PSJMISC(PSJDD)'["POTASSIUM"
 Q:$$CLASS^PSJMISC(PSJDD)'="TN102"
 S PSJXDO=PSJOCDS(PSJCNT,"DO")
 I PSJXDO["ML" D
 . Q:'+PSJXDO
 . S (PSJOCDS(PSJCNT,"DRG_AMT"),PSJFDB(PSJCNT,"DOSE_AMT"))=+(+PSJXDO/1000)
 . S (PSJOCDS(1,"DRG_UNIT"),PSJFDB(PSJCNT,"DOSE_UNIT"))="L"
 Q
UND24HRS(PSJDUR,PSGAT,PSGS0XT,PSGSD,PSGFD,PSGSCH) ;
 ;*** This line tag is called by ^PSIVOCDS also ***
 ;PSJDUR - order duration in minutes
 ;PSGAT - admin times
 ;PSGS0XT - Order Frequency
 NEW PSJNDOSE,PSJFRQ1,PSJFRQ2,PSJFRQX
 Q:'+$G(PSJDUR)
 ; Set frequency to # of amdin times
 I ($G(PSGAT)]"") D  Q
 . S PSJNDOSE=$$CNTDOSE(PSGSD,PSGFD)
 . I PSJNDOSE S PSJFDB(PSJCNT,"FREQ")=PSJNDOSE Q
 ; Set frequency based on frequency(51.1)
 S PSJFRQ2=+$P($$FRQ^PSSDSAPI($G(PSGSCH),$G(PSGS0XT),"I"),U)
 I +$G(PSGS0XT)!PSJFRQ2 D  Q
 . S PSJFRQX=$S(+$G(PSGS0XT):+PSGS0XT,1:(PSJFRQ2*60))
 . S PSJFRQ1=(+PSJDUR)/PSJFRQX
 . S PSJFDB(PSJCNT,"FREQ")=$J(PSJFRQ1,"",0)
 ; If no admin times or frequency(51.1) set error
 S PSJFDB(PSJCNT,"FREQ")=1
 S PSJFDB(PSJCNT,"FRQ_ERROR")=""
 Q
CNTDOSE(PSGSD,PSGFD) ;Count # of admins to set the Freq to
 ;only do this if the start & stop dates are within 24 hours.
 NEW PSJX,PSJADMIN,PSJCNT,PSJSTRTM,PSJSTPTM,PSJDTFLG
 I $G(PSGAT)="" Q 0
 I $G(PSGSD)="" Q 0
 I $G(PSGFD)="" Q 0
 I ($$FMDIFF^XLFDT(PSGFD,PSGSD,2)/60)>1440 Q 0
 S PSJCNT=0
 S PSJSTRTM=$E($P(PSGSD,".",2)_"0000",1,4)
 S PSJSTPTM=$E($P(PSGFD,".",2)_"0000",1,4)
 S PSJDTFLG=0
 I $P(PSGSD,".")=$P(PSGFD,".") S PSJDTFLG=1
 F PSJX=1:1 S PSJADMIN=$P(PSGAT,"-",PSJX) Q:PSJADMIN=""  D
 . S PSJADMIN=$E($P(PSGAT,"-",PSJX)_"0000",1,4)
 . I PSJDTFLG D  Q
 .. I (PSJSTRTM'>PSJADMIN),(PSJADMIN<PSJSTPTM) S PSJCNT=PSJCNT+1
 . I (PSJSTRTM'>PSJADMIN) S PSJCNT=PSJCNT+1
 . I (PSJSTPTM>PSJADMIN) S PSJCNT=PSJCNT+1
 Q PSJCNT
DURATION(PSGSD,PSGFD) ;Figure out the duration from the start, stop dates
 ;Return the diff between Stop - Start date in minutes.  If > 1 day then return null
 NEW PSJDIFF
 I '$D(PSGFD)!'$D(PSGSD) Q ""
 S PSJDIFF=$$FMDIFF^XLFDT(PSGFD,PSGSD,2)/60
 I (PSJDIFF<1440) Q PSJDIFF
 Q ""
DOSE() ;Figure out the dose, unit, & dosage Ordered
 ;Return 3 pieces: Numeric Dose ^ Unit ^ Dosage Ordered
 NEW PSJDS,PSJND0,PSJND2,X,PSJX,PSJXDOX,PSJNDS,PSJALLGY
 S PSJDS=""
 ;Subsequence orders in the Complex order has the PSGDO from the first order. Get new PSGDO
 I $G(PSJCOM),$G(PSJPON)["U" S PSGDO=$P($G(^PS(55,DFN,5,+PSJPON,.2)),U,2)
 ;If the dose & unit exist use them
 I $G(PSJDOSE("DO")) Q PSJDOSE("DO")_U_$G(PSGDO)
 ;Get dd, dose, unit from the order
 I $G(PSGORD)]"",'+$G(PSJDD) D
 . I PSGORD["P" S PSJND2=$G(^PS(53.1,+PSGORD,.2)),PSJDD=$O(^PS(53.1,+PSGORD,1,"B",0))
 . I PSGORD["U" S PSJND2=$G(^PS(55,DFN,5,+PSGORD,.2)),PSJDD=$O(^PS(53.1,+DFN,5,+PSGORD,1,"B",0))
 ;If no numeric dose and there is a dosage ordered then get dose & unit from the order
 I $D(PSGORD),$G(PSGDO)]"" D
 . S PSJDS=$P($G(PSJND2),U,5,6)
 Q:+PSJDS PSJDS_U_$G(PSGDO)
 ;Get dispense unit per dose and figure out numeric and unit
 I +$G(PSJDD),($G(PSGDO)]"") D
 . S PSJDS=$$DOSE1()
 . I $P($G(PSJXDOX(1)),U,11)=$$UP^XLFSTR(PSGDO) Q:+PSJDS
 . S PSJDS=""
 . S PSJX=$G(PSJXDOX(1))
 . I +PSJX S X=+PSGDO/+PSJX S PSJDS=$$DOSE1(X)
 . I $P($G(PSJXDOX(1)),U,11)=$$UP^XLFSTR(PSGDO) Q:+PSJDS
 . S PSJDS=""
 Q:+PSJDS PSJDS
 I +$G(PSJDD),($G(PSGDO)=""),($G(PSGORD)="") D
 . S PSJDS=$$DOSE1($S(+$G(PSGUD):PSGUD,1:1))
 Q:+PSJDS PSJDS
 ;Figure out dose & unit from the dispense drug.  Dosage Ordered is required for multiple dispense drugs
 I $G(PSGDO)="" D
 . S PSJND0=$$DD53P45^PSJMISC()
 . I PSJND0="" S PSJND0=$G(PSGDRG)
 . S X=+$P(PSJND0,U,2) S PSJDS=$$DOSE1($S(X:X,1:1))
 Q:+PSJDS PSJDS
 Q "^^"_$G(PSGDO)
DOSE1(PSJDUP) ;
 ;PSJDUP - Dispense unit per dose
 NEW PSJDS
 Q:'+$G(PSJDD)
 K PSJXDOX
 S PSJDS=""
 D DOSE^PSSORPH(.PSJXDOX,+PSJDD,"U",,$G(PSJDUP))
 S:$G(PSJXDOX(1)) PSJDS=$P(PSJXDOX(1),U,1,2)_U_$P(PSJXDOX(1),U)_$P(PSJXDOX(1),U,2)
 Q PSJDS
DATES(PSJPON) ;Check the correct Start, Stop dates to use
 ;PSJOCDSC("CX",PSGsd/PSGfd,on)=default PSGsd/PSGfd date _^_ PSGsd/PSGfd _^_PSJFLG
 ; PSJFLG=1 if start or stop date has changed.
 ;For some reaons, PSGSD redefined to cal start date for Complex order (one with duration),
 ; PSGFD redefined to cal stop date.  These 2 fields reflect the default start, stop dates if they
 ; were edited.
 ;
 NEW PSJXSD,PSJXFD,PSJP1,PSJP2,PSJFLG
 I '+$G(PSJPON) Q $G(PSGSD)_U_$G(PSGFD)_U_0
 S PSJFLG=0
 S PSJP1=$G(PSGSD),PSJP2=$G(PSGFD)
 I $D(PSJOCDSC("CX","PSGSD")) D
 . S PSJXSD=$G(PSJOCDSC("CX","PSGSD",+PSJPON))
 . S PSJXFD=$G(PSJOCDSC("CX","PSGFD",+PSJPON))
 . I PSGSD=$P(PSJXSD,U,2) S PSJP1=$P(PSJXSD,U)
 .;
 . I $P(PSJXFD,U,2)]"",(PSGFD=$P(PSJXFD,U,2)) S PSJP2=$P(PSJXFD,U)
 . I $P(PSJXFD,U,2)="" S $P(PSJXFD,U,2)=PSGFD,PSJP2=PSGFD
 .;
 .; I $P(PSJXFD,U,2)="" S $P(PSJXFD,U,2)=PSGFD
 .; I PSGFD=$P(PSJXFD,U,2) S PSJP2=$P(PSJXFD,U)
 . I (PSJXSD]"")!(PSJXFD]"") D
 .. I $S($G(PSGSD)'=$P(PSJXSD,U,2):1,$G(PSGFD)'=$P(PSJXFD,U,2):1,1:0) S PSJFLG=1
 Q PSJP1_U_PSJP2_U_PSJFLG
