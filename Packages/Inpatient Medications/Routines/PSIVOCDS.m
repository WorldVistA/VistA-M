PSIVOCDS ;BIR/MV - PROCESS DOSING ORDER CHECKS FOR IV ;6 Jun 07 / 3:37 PM
 ;;5.0;INPATIENT MEDICATIONS ;**181,252,257,256,347**;16 DEC 97;Build 6
 ;
 ; Reference to ^PS(51.1 is supported by DBIA #2177
 ; Reference to ^PSDRUG( is supported by DBIA #2192.
 ; Reference to ^PSSDSAPI is supported by DBIA #5425.
 ; Reference to ^PSSFDBRT is supported by DBIA #5496.
 ; Reference to $$CONV^PSSDSAPK is supported by DBIA #5497.
 ;
IN(PSJBASE) ;
 ;PSJBASE - Base(Literal value for TMP global)- Required
 ;PSIVDDSV(AD/SOL,CNT)=P1..P9
 ; P1=Drug IEN; P2=Dspl name(add/sol or CPRS OI; P3=Numeric dose & unit; P4=Bottle #
 ; P5=""; P6=""; P7=""; P8=Strength/Vol; P9=Unit
 ;
 ;These two flags below are set when stuff freq, duration to 1 & Duration rate = dose rate
 ;They are used by the output routine to generate the appropriate output messages.
 ;PSJFDB(PSJCNT,"INF_ERROR")="" & PSJFDB(PSJCNT,"FRQ_ERROR")=""
 ;
 NEW ON,PSJCNT,PSJCNTX,PSJONEFG,PSJRT,PSIVAS,PSIVAS0,PSIVDDSV,PSPDRG,PSJALLGY,X,PSJP8,PSJP8NUM,PSJP8UNT,PSJP8TME,PSJOIX
 K PSJOCDS,PSJFDB,PSIVDDSV,PSPDRG,PSJALLGY
 S PSJCNT=0
 ;PSJRT - FDB Route
 S PSJRT=$P($$MRT^PSSDSAPI(+P("MR")),U,2)
 ;Set Flag to indicate CPRS OI had no active AD/SOL.
 S PSJOIX="" F  S PSJOIX=$O(PSJIV("OI_ERROR",PSJOIX)) Q:PSJOIX=""  D
 . S PSJCNT=PSJCNT+1
 . S PSJFDB(PSJCNT,"RX_NUM")="I;;PROSPECTIVE;"_PSJCNT
 . S PSJFDB(PSJCNT,"DRUG_NM")=PSJOIX
 . S PSJFDB(PSJCNT,"OI")=$P(PSJIV("OI_ERROR",PSJOIX),U,2)
 . S PSJFDB(PSJCNT,"OI_ERROR",PSJOIX)=$P(PSJIV("OI_ERROR",PSJOIX),U)_U_"I;;PROSPECTIVE;"_PSJCNT
 D SETDD^PSIVOC(1)
 I ($G(PSIVDDSV("TOT_VOL"))=""),($G(PSJIV("TOT_VOL"))]"") S PSIVDDSV("TOT_VOL")=PSJIV("TOT_VOL")
 F PSIVAS="AD","SOL" F PSJCNTX=0:0 S PSJCNTX=$O(PSIVDDSV(PSIVAS,PSJCNTX)) Q:'PSJCNTX  D
 . S PSIVAS0=$G(PSIVDDSV(PSIVAS,PSJCNTX))
 .;PSJ*5*252 (6/29/11) - No longer need to convert "ML" to "L" now FDB handles both units for this drug.
 .;I PSIVAS="SOL" S X=$$LITER($P(PSIVAS0,U,8)) I X]"" D
 .;. S $P(PSIVAS0,U,8)=$P(X,U)
 .;. S $P(PSIVAS0,U,9)=$P(X,U,2)
 . S PSJCNT=PSJCNT+1
 . D COMMON
 . I P("DTYP")=1 S PSJOCDS("CONTEXT")="IP-IV-I" D IVPB
 . I P("DTYP")>1 S PSJOCDS("CONTEXT")="IP-IV-C" D IV
 Q
IV ;Setup input data for Continuous IV (admixture, hyperal)
 NEW PSJXRT,PSJP8ERR
 S PSJP8=$$P8^PSJMISC2(P(8))
 D BASIC
 S PSJP8NUM=+$P(PSJP8,U)
 S PSJP8UNT=$P(PSJP8,U,2)
 S PSJP8TME=$P(PSJP8,U,3)
 ;All premix are using the "Continuous Infusion" Route logic. This is so Potassium gets both single
 ;and max dosing checks.  Cisplatin premix won't work since FDB can't process as "Continuous Infusion"
 I PSIVAS="SOL" D PREMIX Q
 S PSJXRT=$$RTESCRN($P($$MRT^PSSDSAPI(+P("MR")),U,1))
 I $$ISONEAD(),$$ISALLBAG(),('$$CLASS(PSJFDB(PSJCNT,"DRUG_IEN"))),(PSJXRT'=0),$$FDBRT(PSJFDB(PSJCNT,"DRUG_IEN"),PSJXRT) D ONEAD(PSJXRT) Q
 I PSJP8="" D FREEDOSE Q
 D CONTIV
 Q
IVPB ;Setup input data for Schedule IV
 NEW X,PSJP9,PSJP15,PSJX
 S PSJOCDS(PSJCNT,"DRUG_AMT")=$P(PSIVAS0,U,8)
 S PSJOCDS(PSJCNT,"DRUG_UNIT")=$P(PSIVAS0,U,9)
 I '+$G(PSJIV("DUR")) D
 . S X=$$DURATION()
 . S PSJOCDS(PSJCNT,"DRATE")=$S(+X:X_"M",1:"")
 I +$G(PSJIV("DUR"))<1440,(+$G(PSJIV("DUR"))>0) S PSJOCDS(PSJCNT,"DRATE")=PSJIV("DUR")
 S PSJOCDS(PSJCNT,"MR_IEN")=+P("MR")
 S PSJOCDS(PSJCNT,"DO")=""
 S PSJOCDS(PSJCNT,"SCHEDULE")=P(9)
 ;
 S PSJFDB(PSJCNT,"DOSE_AMT")=$S('+$P(PSIVAS0,U,8):"",1:$P(PSIVAS0,U,8))
 S PSJFDB(PSJCNT,"DOSE_RATE")="DAY"
 S PSJFDB(PSJCNT,"DOSE_UNIT")=$P(PSIVAS0,U,9)
 ;
 S PSJONEFG=0
 ;PSJ*5*347 - P(9) contains " PRN"
 S PSJP9=P(9)
 I (P(9)[" PRN"),'$D(^PS(51.1,"APPSJ",P(9))) S PSJP9=$P(P(9)," PRN",1)
 I $$ONE^PSJORPOE(PSJP9)!$$ONCALL^PSJMISC(PSJP9) S PSJONEFG=1 D SINGLE Q
 ;I $$ONE^PSJORPOE(P(9))!$$ONCALL^PSJMISC(P(9)) S PSJONEFG=1 D SINGLE Q
 I +$G(PSJIV("DOSE_CNT")) S PSJFDB(PSJCNT,"FREQ")=$G(PSJIV("DOSE_CNT")) Q
 I +$G(PSJOCDS(PSJCNT,"DRATE")) D UND24HRS^PSJOCDS(+PSJOCDS(PSJCNT,"DRATE"),$G(P(11)),$G(P(15)),$G(P(2)),$G(P(3)),$G(P(9))) Q
 I 'PSJONEFG D
 . S X="",PSJP9=P(9)
 . S PSJX=+$O(^PS(51.1,"AC","PSJ",P(9),0))
 . S PSJP15=P(15)
 . I (P(9)["PRN"),'PSJX S PSJP15=""
 . ;I (P(9)["PRN"),'$O(^PS(51.1,"AC","PSJ",P(9),0)) S PSJP15=""
 . ;I P(15)="D",(P(11)]"") S $P(PSJP9,"@",2)=P(11)
 . I 'PSJX&(P(15)="D")&(P(11)]"") S $P(PSJP9,"@",2)=P(11)
 . ;Check for DOW schedule
 . I PSJP15="",PSJX S PSJP15=$P($G(^PS(51.1,PSJX,0)),U,5)
 . I P(9)]"" S X=$P($$FRQ^PSSDSAPI(PSJP9,PSJP15,"I",,PSJFDB(PSJCNT,"DRUG_IEN")),U)
 . I X="" S X=1 S PSJFDB(PSJCNT,"FRQ_ERROR")=""
 . S PSJFDB(PSJCNT,"FREQ")=X
 . S PSJFDB(PSJCNT,"DURATION")=1
 . S PSJFDB(PSJCNT,"DURATION_RT")="DAY"
 Q
SINGLE ;Set fields needed for Single Dose type
 ; Can't get FDB to return correct data for Continuous Infusion /w Single dose so all Continuous will be sent in as Maintenance.
 I PSJFDB(PSJCNT,"ROUTE")=("CONTINUOUS INFUSION") Q
 S PSJFDB(PSJCNT,"DOSE_TYPE")="SINGLE DOSE"
 S PSJFDB(PSJCNT,"FREQ")=1
 S PSJFDB(PSJCNT,"DURATION")=1
 S PSJFDB(PSJCNT,"DURATION_RT")=PSJFDB(PSJCNT,"DOSE_RATE")
 Q
COMMON ;Set common data for all IV types
 S PSJFDB(PSJCNT,"RX_NUM")="I;"_$G(PSJPON)_";PROSPECTIVE;"_PSJCNT
 S PSJFDB(PSJCNT,"DRUG_IEN")=$P(PSIVAS0,U)
 S PSJFDB(PSJCNT,"DRUG_NM")=$P(PSIVAS0,U,2)_" "_$P(PSIVAS0,U,3)
 S PSJFDB(PSJCNT,"DOSE_UNIT")=$P(PSIVAS0,U,9)
 S PSJFDB(PSJCNT,"ROUTE")=PSJRT
 S PSJFDB(PSJCNT,"DOSE_TYPE")="MAINTENANCE"
 S PSJFDB(PSJCNT,"SPECIFIC")=1
 ;This is set when CPRS sends Duration without entering a solution.
 I $D(PSJIV("FRQ_ERROR")) S PSJFDB(PSJCNT,"FRQ_ERROR")="",PSJFDB(PSJCNT,"FREQ")=1
 Q
BASIC ;Set basic data for non schedule IVs
 S PSJFDB(PSJCNT,"DOSE_RATE")="DAY"
 S PSJFDB(PSJCNT,"FREQ")=""
 S PSJFDB(PSJCNT,"DURATION")=1
 S PSJFDB(PSJCNT,"DURATION_RT")="DAY"
 ; SDA is set to the additive strength or volume of the solution.
 S PSJFDB(PSJCNT,"DOSE_AMT")=$P(PSIVAS0,U,8)
 Q
FREEDOSE ;Set data for free text dose
 ;"GENERAL" info only needed to pass in Dose Route and Dose Type.
 ;"Exception" node sets here to get the specified error back for free text dosing.
 S PSJFDB(PSJCNT,"FREQ")=1
 S PSJFDB(PSJCNT,"DURATION")=1
 S PSJFDB(PSJCNT,"DURATION_RT")=PSJFDB(PSJCNT,"DOSE_RATE")
 S PSJFDB(PSJCNT,"INF_ERROR")=""
 I $G(PSJP8ERR)=2!($G(PSJP8ERR)=4) S PSJFDB(PSJCNT,"WT_ERROR")=""
 I $G(PSJP8ERR)=3!($G(PSJP8ERR)=4) S PSJFDB(PSJCNT,"HT_ERROR")=""
 Q
ONEAD(PSJRT) ;Setup data for 'Continuous Infusion' IV type
 NEW PSJCLASS,PSJX
 I $G(PSJRT)=0!($G(PSJRT)="") Q
 ;Check to make sure the infusion rate is in form of "ml/hr" before applying the calculation
 S PSJFDB(PSJCNT,"FREQ")=1
 S PSJFDB(PSJCNT,"DURATION")=1
 S PSJFDB(PSJCNT,"ROUTE")=PSJRT
 I PSJP8="" D FREEDOSE Q
 S PSJFDB(PSJCNT,"DOSE_RATE")=PSJP8TME
 S PSJFDB(PSJCNT,"DURATION_RT")=PSJP8TME
 I PSJP8UNT="MILLILITERS",(PSJP8TME="HOUR") D
 . S PSJFDB(PSJCNT,"DOSE_AMT")=$$SDACI()
 . S PSJFDB(PSJCNT,"DOSE_UNIT")=$P(PSIVAS0,U,9)
 I PSJP8UNT'="MILLILITERS" D
 . S PSJFDB(PSJCNT,"FREQ")=1
 . S PSJFDB(PSJCNT,"DOSE_AMT")=PSJP8NUM
 . S PSJFDB(PSJCNT,"DOSE_UNIT")=PSJP8UNT
 . S PSJFDB(PSJCNT,"DOSE_RATE")=PSJP8TME
 . S PSJFDB(PSJCNT,"DURATION_RT")=PSJP8TME
 Q
CONTIV ;Set data needed for continuous IV with multiple drugs
 NEW PSJFREQ,PSJDIFF
 S PSJDIFF=+$$DURATION()
 ; Order has duration <24 hrs
 I PSJDIFF D UND24HRS
 ; Order has duration >= 24 hrs
 I 'PSJDIFF S PSJFDB(PSJCNT,"FREQ")=$$IVFREQ
 ;
 S PSJFDB(PSJCNT,"DURATION")=1
 S PSJFDB(PSJCNT,"DOSE_RATE")="DAY"
 S PSJFDB(PSJCNT,"DURATION_RT")="DAY"
 Q
ISONEAD() ;Return 1 if there's only one additive
 NEW X,PSJX
 I $D(PSIVDDSV("AD")),$D(PSIVDDSV("SOL")) Q 0
 I $O(PSIVDDSV("SOL",0)) Q 0
 S PSJX=0
 F X=0:0 S X=$O(PSIVDDSV("AD",X)) Q:'X  S PSJX=PSJX+1 Q:PSJX>1
 I PSJX>1 Q 0
 Q 1
ISALLBAG() ;Return 1 if not additive not in all bags
 ;***this call assuming only 1 additive entered in the order
 ;The bottle field can be either See comments, all bags, null or a numeric value (ex 1,3...)
 NEW X,PSIVAS0
 S X=$O(PSIVDDSV("AD",0))
 S PSIVAS0=$G(PSIVDDSV("AD",X))
 I +$P(PSIVAS0,U,4) Q 0
 Q 1
ISNOADD() ;Return 1 if there's no additives
 NEW X,PSJX
 I $O(PSIVDDSV("AD",0)) Q 0
 I $D(PSIVDDSV("SOL")) Q 1
 Q 0
PREMIX ;The route is always set to "Continuous Infusion" & the FREQUENCY must set to 1
 NEW X
 S PSJFDB(PSJCNT,"ROUTE")=$$RTESCRN(PSJRT)
 I PSJFDB(PSJCNT,"ROUTE")=0 S PSJFDB(PSJCNT,"ROUTE")=PSJRT
 I PSJP8="" D FREEDOSE Q
 S PSJFDB(PSJCNT,"FREQ")=1
 S PSJFDB(PSJCNT,"DOSE_AMT")=PSJP8NUM
 S PSJFDB(PSJCNT,"DOSE_UNIT")=PSJP8UNT
 S PSJFDB(PSJCNT,"DOSE_RATE")=PSJP8TME
 S PSJFDB(PSJCNT,"DURATION_RT")=PSJP8TME
 ;PSJ*5*252 (6/29/11) - No longer need to convert "ML" to "L" now FDB handles both units for this drug.
 ;S PSJFDB(PSJCNT,"ROUTE")="CONTINUOUS INFUSION"
 ;I PSJP8UNT="MILLILITERS" S X=$$LITER(PSJP8NUM) I X]"" D
 ;. S PSJFDB(PSJCNT,"DOSE_AMT")=$P(X,U)
 ;. S PSJFDB(PSJCNT,"DOSE_UNIT")=$P(X,U,2)
 Q
SDACI() ;Return Single Dose Amount for ad for 'CONTINUOUS INFUSION' FDB Route (Not classed at "VT" or "TN")
 ;Single Dose Amount(PSJSDA):
 ; For Additive - PSJSDA=(Strength/Tot vol)*Infusion Rate
 ; If can't calculate then return null
 NEW PSJSDA,X
 S PSJSDA=""
 I $D(PSIVDDSV("AD")) D
 . S X=+$G(PSIVDDSV("TOT_VOL")) Q:'X
 . S PSJSDA=($P(PSIVAS0,U,8)/X)*PSJP8NUM
 I '+PSJSDA S PSJSDA=$P(PSIVAS0,U,8),PSJFDB(PSJCNT,"INF_ERROR")=""
 Q PSJSDA
CLASS(PSJDD) ;Check if the Drug contains "VT" & "TN" classes
 ;Return 1 if "VT" or "TN"
 ;Return 0 if not
 Q:'+$G(PSJDD) 0
 NEW PSJCLASS
 S PSJCLASS=$P($G(^PSDRUG(+PSJDD,0)),U,2)
 ;I (PSJCLASS["TN")!(PSJCLASS["VT") Q 1
 I PSJCLASS["VT" Q 1
 Q 0
IVFREQ() ;Return the frequency for an continuous IV
 ; Hours needed to run a bag is defined as: Total Volume / Infusion rate
 ; # of bags needed for a day is defined as: 24 / Hours need to run a bag
 ; PSJFREQ is either in Q#H or N for # of admin per day
 NEW PSJFREQ,PSJBOT,PSJX,X,PSJTOTBG,PSJTOTBT,PSJTOTV,PSJBAGX
 S (PSJFREQ,PSJTOTBG,PSJTOTBT)=0
 S PSJTOTV=+$G(PSIVDDSV("TOT_VOL"))
 ;CONV^PSSDSAPK converts # of hours to run a bag to either Q#H or n for number of admin per day
 I +PSJTOTV,PSJP8NUM D
 . I +PSJTOTV#PSJP8NUM D
 .. S PSJFDB(PSJCNT,"DOSE_AMT")=$$ADJSDA(+PSJTOTV,PSJP8NUM,+PSJFDB(PSJCNT,"DOSE_AMT"),1)
 . S PSJBAGX=PSJTOTV/PSJP8NUM
 . I PSJBAGX<1 S PSJFREQ="Q1H"
 . S:PSJBAGX'<1 PSJFREQ=$$CONV^PSSDSAPK(PSJTOTV/PSJP8NUM)
 . S PSJTOTBG=24/(+PSJTOTV/PSJP8NUM)
 I PSIVAS="AD" D BOTTLE(PSJTOTBG,$P(PSIVAS0,U,4)) D
 . I PSJTOTBG<1,'(+PSJTOTV#PSJP8NUM) S PSJFDB(PSJCNT,"DOSE_AMT")=$$ADJSDA(+PSJTOTV,PSJP8NUM,+PSJFDB(PSJCNT,"DOSE_AMT"),0)
 I PSJFREQ=""!(PSJFREQ=0) S PSJFREQ=1 S PSJFDB(PSJCNT,"FRQ_ERROR")=""
 Q PSJFREQ
ADJSDA(PSJTOTV,PSJINFRT,PSJSDA,PSJNOTE) ;Adjust SDA
 NEW PSJBAGX,X,PSJNOTEV
 I '+$G(PSJTOTV) Q ""
 I '+$G(PSJINFRT) Q ""
 I '+$G(PSJSDA) Q ""
 S (PSJBAGX,X)=+PSJTOTV/PSJINFRT
 ;**  Removed for MOCHA 2.0 When it takes < 1 hour to run a bag. May need to bring back for MOCHA 2.1 (Daily dose check).
 ;I PSJBAGX<1 S PSJSDA=PSJSDA/PSJBAGX
 I PSJBAGX<1 D
 . S PSJFDB(PSJCNT,"FREQ")=1
 . S PSJFDB(PSJCNT,"DURATION")=1
 . S PSJFDB(PSJCNT,"DOSE_RATE")="DAY"
 . S PSJFDB(PSJCNT,"DURATION_RT")="DAY"
 I PSJBAGX'<1 D
 . S X=$J(PSJBAGX,"",0)
 . S PSJSDA=PSJSDA/(+PSJTOTV)*PSJINFRT*($S(X<24:X,1:24))
 . S PSJNOTEV=($S(X<24:X,1:24)*PSJINFRT)_" ML over "_$S(X<24:X,1:24)_" hours)."
 . I $G(PSJNOTE) D
 .. S PSJFDB(PSJCNT,"ADJ_MSG")="PLEASE NOTE: The single dose of the IV Additive has been adjusted to reflect the amount of drug infused over the nearest whole number of hours ("_PSJNOTEV
 . I '$G(PSJNOTE) D
 .. S PSJFDB(PSJCNT,"ADJ_MSG")="PLEASE NOTE:  The single dose of the IV Additive has been adjusted to reflect the amount of drug infused over the duration of the order or 24 hours; whichever is less ("_PSJNOTEV
 Q PSJSDA
UND24HRS ;Calculate freq for order <24 hrs
 NEW PSJTOTV,PSJBAG,PSJMNBAG,PSJTOTBG,PSJFREQ,PSJHRS,X
 S (PSJFREQ,PSJBAG,PSJMNBAG)=0
 S PSJTOTV=+$G(PSIVDDSV("TOT_VOL"))
 I +PSJTOTV,PSJP8NUM D
 . S PSJHRS=PSJTOTV/PSJP8NUM
 . S PSJMNBAG=PSJHRS*60
 . S PSJTOTBG=24/PSJHRS
 I '+PSJMNBAG D  Q
 . S PSJFDB(PSJCNT,"FREQ")=1
 . S PSJFDB(PSJCNT,"FRQ_ERROR")=""
 S:+PSJMNBAG PSJBAG=PSJDIFF/PSJMNBAG
 ; If the order is for < 24 hrs & Freq < 1 then adjust the SDA & Freq set to 1
 I PSJBAG<1 D  Q
 . S X=$J((PSJDIFF/60),"",0)
 . S PSJNOTEV=($S(X<24:X,1:24)*PSJP8NUM)_" ML over "_$S(X<24:X,1:24)_" hours)."
 . S PSJFDB(PSJCNT,"ADJ_MSG")="PLEASE NOTE:  The single dose of the IV Additive has been adjusted to reflect the amount of drug infused over the duration of the order or 24 hours; whichever is less ("_PSJNOTEV
 . S PSJFDB(PSJCNT,"FREQ")=1
 . S PSJFDB(PSJCNT,"DOSE_AMT")=PSJBAG*(PSJFDB(PSJCNT,"DOSE_AMT"))
 ;
 S PSJFREQ=$J(PSJBAG,"",0)
 I PSIVAS="AD" D BOTTLE(PSJFREQ,$P(PSIVAS0,U,4))
 S PSJFDB(PSJCNT,"FREQ")=PSJFREQ
 Q
 ;
BOTTLE(PSJTOTBG,PSJBOT) ;Set freq to either specified bottle or # needed for the duration/24hrs of the order
 NEW PSJTOTBT,X,PSJX
 I $$UP^XLFSTR($G(PSJBOT))="ALL BAGS" Q
 I $$UP^XLFSTR($G(PSJBOT))="SEE COMMENTS" Q
 Q:'+$G(PSJTOTBG)
 ;
 ;PSJ*5*252 - ADJSDA already adjusted the SDA so recal SDA is not needed
 I PSJTOTBG<1 S PSJFREQ=1 Q
 Q:$G(PSJBOT)=""
 S PSJTOTBT=0
 F X=1:1:$L(PSJBOT,",") S PSJX=$P(PSJBOT,",",X) S:+PSJX PSJTOTBT=PSJTOTBT+1
 S PSJFREQ=$S(PSJTOTBT>PSJTOTBG:PSJTOTBG,1:PSJTOTBT)
 I PSJTOTV#PSJP8NUM,(PSJTOTBT>PSJTOTBG) D
 . S PSJFREQ=$$CONV^PSSDSAPK(PSJTOTV/PSJP8NUM)
 I PSJFREQ=0 S PSJFREQ=1 S PSJFDB(PSJCNT,"FRQ_ERROR")=""
 Q
DURATION() ;
 ;If PSJIV("DUR") is passed in from CPRS then return the minutes if <1440 otherwise return ""
 ;If not call from CPRS then calculate from start, stop date
 NEW PSJX,X,PSJP8X
 S PSJX=""
 I +$G(PSJIV("DUR")) D  Q X
 .S PSJX=+$G(PSJIV("DUR"))
 .S X=$S(PSJX<1440:PSJX,1:"")
 I +$G(PSJIV("TOT_VOL")) D  Q X
 . S PSJP8X=$S(+$G(PSJP8NUM):PSJP8NUM,+P(8):+P(8),1:0)
 . S:PSJP8X PSJX=(+PSJIV("TOT_VOL")/PSJP8X)*60
 . S X=$S(PSJX<1440:PSJX,1:"")
 S X=$$DURATION^PSJOCDS($G(P(2)),$G(P(3)))
 Q X
FDBRT(PSJDD,PSJRT) ;Check if the ordered route can be admin by FDB for this drug
 ;PSJDD = Drug IEN
 ;PSJRT = FDB continuous dose route (ordered MR -> Standard RT ->FDB cont. Rt)
 ;Return 1 if the route can admin by FDB; 0 if this route is not specify for this drug
 NEW PSJFDBRT
 I '+$G(PSJDD)!$G(PSJRT)="" Q 0
 D GROUTE^PSSFDBRT(PSJDD,.PSJFDBRT)
 I +$G(PSJFDBRT(0))=-1 Q 1
 I $D(PSJFDBRT(PSJRT)) Q 1
 Q 0
RTESCRN(PSJRT) ; Screen routes for none "VT or "TN"
 ;Return 0 or FDB continuous dose route if the standard route(mapped to the ordered MR) is one of the six below.
 ;PSJRT - standard route
 I $G(PSJRT)="" Q 0
 I PSJRT="EPIDURAL" Q "CONTINUOUS EPIDURAL"
 I PSJRT="INTRA-ARTERIAL" Q "CONT INTRAARTER INF"
 I PSJRT="INFILTRATION" Q "CONTINUOUS INFILTRAT"
 I PSJRT="INTRACAUDAL" Q "CONT CAUDAL INFUSION"
 I PSJRT="INTRAOSSEOUS" Q "CONT INTRAOSSEOUS"
 I PSJRT="INTRATHECAL" Q "CONT INTRATHECAL INF"
 I PSJRT="INTRAVENOUS" Q "CONTINUOUS INFUSION"
 I PSJRT="NEBULIZATION" Q "CONT NEBULIZATION"
 I PSJRT="SUBCUTANEOUS" Q "CONT SUBCUTAN INFUSI"
 Q 0
LITER(PSJVOLP8) ; Convert the unit from ML to L for premix contains potassium
 ; PSJ*5*252 (6/29/11) - No longer need to convert "ML" to "L" for this drug now that FDB handles both units.
 ; FDB only accept Liter for this type for drug
 ; PSJVOLP8 - Either = volume or the infusion rate
 NEW PSJVAGEN,PSJSDA,PSJUNIT
 Q:$G(PSJVOLP8)=""
 S PSJVAGEN=$$VAGEN^PSJMISC($P(PSIVAS0,U))
 I PSJVAGEN["POTASSIUM" D
 . S PSJSDA=+(PSJVOLP8/1000)
 . S PSJUNIT="L"
 I '+$G(PSJSDA)!($G(PSJUNIT)="") Q ""
 Q PSJSDA_U_PSJUNIT
