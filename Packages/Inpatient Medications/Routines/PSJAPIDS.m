PSJAPIDS ;BIR/MV - API TO PROCESS DOSING ORDER CHECKS FOR IV ;6 Jun 07 / 3:37 PM
 ;;5.0;INPATIENT MEDICATIONS ;**181,252**;16 DEC 97;Build 69
 ;
 ; Reference to ^PSDRUG is supported by DBIA #2192.
 ; Reference to ^PS(51.1 is supported by DBIA# 2177.
 ; Reference to ^PS(52.6 is supported by DBIA# 1231.
 ; Reference to ^PS(52.7 is supported by DBIA# 2173.
 ; Reference to ^PSSDSAPI is supported by DBIA# 5425.
 ; Reference to DRT^PSSDSAPD is supported by DBIA# 5617.
 ; Reference to DOSE^PSSDSAPD is supported by DBIA# 5426.
 ;
DOSE(PSJBASE,DFN,PSJIV) ;
 ;PSJBASE(1)=PSJBASE - Base1(Literal value for TMP global)- Required
 ;PSJBASE(2)=PSJBASE1 - Base2(Literal value for Screened display TMP global)- Required
 ;PSJDFN - Patient Internal Entry Number
 ;PSJIV(Px) - See DBIA #5385...P4 can be "ALL", "See Comments", or bottle number(s)
 ;PSJIV("TVOL_VOL") - Contains nUnit where n is # & Unit is either H,D,L,M, or DOSES
 ;PSJIV(X,"OI_ERROR",OI Name) - OI ien ^ Pharm # ^ Enhance flag(use in ENHFLG sub routine)
 NEW DRG,P,PSIVAS,PSIVNM,PSJDD,PSJFDB,PSJOCDS,PSIVTDUR,PSJTOTVL,X
 I $$PING()=-1 D  Q
 . F X=0:0 S X=$O(PSJBASE(X)) Q:'X  D
 .. M ^TMP($J,PSJBASE(X),"OUT")=^TMP($J,"PSJPRE","OUT")
 Q:$G(PSJIV("IV_TYPE"))=""
 Q:'+$G(DFN)
 S PSJTOTVL=0
 F X=0:0 S X=$O(PSJBASE(X)) Q:'X  K:PSJBASE(X)]"" ^TMP($J,PSJBASE(1))
 S P("DTYP")=+PSJIV("IV_TYPE")
 S P("MR")=$G(PSJIV("MR_IEN"))
 S P(8)=$G(PSJIV("INF_RATE"))
 S P(9)=$G(PSJIV("SCHEDULE"))
 ;Admin times and Freq are not available from CPRS
 S P(11)=""
 S P(15)=""
 D SETDRG
 S PSJIV("DUR")="",PSJIV("TOT_VOL")=""
 I PSJIV("TVOL_DUR")]"" D
 . S PSIVTDUR=$$UP^XLFSTR(PSJIV("TVOL_DUR"))
 . I PSIVTDUR["M" S PSJIV("TOT_VOL")=+PSIVTDUR
 . I PSIVTDUR["L" S PSJIV("TOT_VOL")=+PSIVTDUR*1000,PSIVTDUR=PSJIV("TOT_VOL")_"M"
 . ;get dose count for intermittent
 . I P("DTYP")=1 D DURATION(PSIVTDUR,P(9)) Q
 . ;Convert PSJIV("DUR") to minutes
 . I P("DTYP")=2,$S(PSIVTDUR["H":1,PSIVTDUR["D":1,1:0) S PSJIV("DUR")=$$DRT^PSSDSAPD(PSIVTDUR)
 D IN^PSIVOCDS(PSJBASE(1))
 D ENHFLG
 I $$CHKDS() S PSJFDB("PACKAGE")="I" D DOSE^PSSDSAPD(.PSJBASE,DFN,.PSJOCDS,.PSJFDB)
 K ^TMP($J,"PSJPRE")
 Q
CHKDS() ;Check if dosing check should be performed
 ;PSJFLG=1 means dosing check should be performed
 NEW PSJX,PSJFLG
 I $G(PSJFDB(1,"ENH"))=0 Q 1
 S PSJFLG=0
 F PSJX=0:0 S PSJX=$O(PSJFDB(PSJX)) Q:'PSJX  Q:PSJFLG  D
 . I '$D(PSJFDB(PSJX,"OI_ERROR")) S PSJFLG=1 Q
 . I +$G(PSJFDB(PSJX,"OI")),$$SETENH(1,+PSJFDB(PSJX,"OI")) S PSJFLG=1
 Q PSJFLG
SETDRG ;
 NEW PSIVX,PSIVX0,PSJDD,PSGDT,PSJCNT,%
 D NOW^%DTC S PSGDT=%
 F PSIVAS="AD","SOL" S PSJCNT=0 F PSIVX=0:0 S PSIVX=$O(PSJIV(PSIVAS,PSIVX)) Q:'PSIVX  D
 .S PSIVX0=$G(PSJIV(PSIVAS,PSIVX))
 .D:PSIVAS="AD" SETAD(+PSIVX0,$P(PSIVX0,U,2),$P(PSIVX0,U,5))
 .D:PSIVAS="SOL" SETSOL(+PSIVX0,$P(PSIVX0,U,2),$P(PSIVX0,U,5))
 Q
SETAD(PSJOI,PSJOINM,PSJFLG) ;Check if additive is active then set the DRG array
 ;PSJOI - 50.7 ien
 ;PSJOINM - CPRS OI name
 ;PSJFLG - 1 if the Enhanced order checks were done.  0 if not.
 Q:'+$G(PSJOI)
 NEW PSJOK,PSIVIEN,PSJINACT
 S PSJOK=0
 F PSIVIEN=0:0 S PSIVIEN=$O(^PS(52.6,"AOI",PSJOI,PSIVIEN)) Q:'PSIVIEN  Q:PSJOK  D
 . S PSJINACT=$G(^PS(52.6,PSIVIEN,"I"))
 . I PSJINACT]"",(PSJINACT'>PSGDT) Q
 . I $G(^PS(52.6,PSIVIEN,0))]"" D
 .. S PSJOK=1
 .. S PSJCNT=PSJCNT+1
 .. S DRG("AD",PSJCNT)=PSIVIEN_U_$P(PSIVX0,U,2)_U_$P(PSIVX0,U,3)_U_$S('+$P(PSIVX0,U,4):"",1:$P(PSIVX0,U,4))
 .. S PSJDD=+$$IVDDRG^PSJMISC("AD",PSIVIEN)
 .. S:+PSJDD PSJIV("DRG",PSJDD)=+$G(PSJFLG)
 ;I 'PSJOK,($G(PSJOINM)]"") S PSJIV("OI_ERROR",PSJOINM)=4_U_PSJOI_U_$$SETENH($G(PSJFLG),PSJOI)
 I 'PSJOK,($G(PSJOINM)]"") S PSJIV("OI_ERROR",PSJOINM)=4_U_PSJOI_U_1
 Q
SETSOL(PSJOI,PSJOINM,PSJFLG) ;Check if solution is active then set then DRG array
 ;PSJOI - 50.7 ien
 ;PSJOINM - CPRS OI name
 ;PSJFLG - 1 if the Enhanced order checks were done.  0 if not.
 Q:'+$G(PSJOI)
 NEW PSJOK,PSIVIEN,PSJINACT,PSJPREMX
 S PSJOK=0,PSJPREMX=0
 F PSIVIEN=0:0 S PSIVIEN=$O(^PS(52.7,"AOI",PSJOI,PSIVIEN)) Q:'PSIVIEN  Q:PSJOK  D
 . I '+$P($G(^PS(52.7,+PSIVIEN,0)),U,2) Q
 . S PSJINACT=$G(^PS(52.7,PSIVIEN,"I"))
 . I PSJINACT]"",(PSJINACT'>PSGDT) Q
 . I '$$PREMIX^PSJMISC(+PSIVIEN) S PSJPREMX=1
 . I $G(^PS(52.7,PSIVIEN,0))]"" D
 .. S PSJOK=1
 .. S PSJCNT=PSJCNT+1
 .. S DRG("SOL",PSJCNT)=PSIVIEN_U_$P(PSIVX0,U,2)_U_$P(PSIVX0,U,3)
 .. S PSJTOTVL=PSJTOTVL+(+$P(PSIVX0,U,3))
 .. S PSJDD=+$$IVDDRG^PSJMISC("SOL",PSIVIEN)
 .. S:+PSJDD PSJIV("DRG",PSJDD)=+$G(PSJFLG)
 ;I 'PSJOK,($G(PSJOINM)]"") S PSJIV("OI_ERROR",PSJOINM)=4_U_PSJOI_U_$$SETENH($G(PSJFLG),PSJOI)
 I 'PSJOK,($G(PSJOINM)]"") S PSJIV("OI_ERROR",PSJOINM)=4_U_PSJOI_U_1
 Q
SETENH(PSJFLG,PSJOI) ;Reset PSJFLG to 0 only if GCN message is needed for the dosing check
 NEW PSJDD
 I '+$D(PSJFLG) Q 0
 I PSJFLG=0 Q 0
 I '+$G(PSJOI) Q PSJFLG
 ;If PSJFLG=1 (CPRS did DI & DT) then check if no GCN for any of the DDs tie to OI then reset PSJFLG=0 to signal PDM
 ; to get the check done for the OI error.
 S PSJDDFLG=0
 F PSJDD=0:0 S PSJDD=$O(^PSDRUG("ASP",PSJOI,PSJDD)) Q:'PSJDD  Q:PSJDDFLG  D
 . I +$$GCN^PSJMISC(PSJDD) S PSJDDFLG=1 Q
 Q PSJDDFLG
ENHFLG ;Set the enhance flag so dosing error message won't display if enhance OC already displayed.
 NEW PSJX,PSJOINM
 F PSJX=0:0 S PSJX=$O(PSJFDB(PSJX)) Q:'PSJX  D
 . ;If "OI_ERROR" existed than set the "ENH" flag for that PSJX set
 . S PSJOINM=$O(PSJFDB(PSJX,"OI_ERROR",""))
 . I PSJOINM]"" D  Q
 .. S PSJFDB(PSJX,"ENH")=$P($G(PSJIV("OI_ERROR",PSJOINM)),U,3)
 . I '$D(PSJFDB(PSJX,"DRUG_IEN")) Q
 . S PSJFDB(PSJX,"ENH")=+$G(PSJIV("DRG",+PSJFDB(PSJX,"DRUG_IEN")))
 Q
DURATION(PSJDUR,PSJSCH) ;Figure out date dose limit send by CPRS
 ;Set PSJIV("DOSE_CNT") only for duration < 24 hrs & set PSJIV("DUR") to # minutes specified in the duration field
 NEW PSJDOW,PSJCNT,PSJDUR1,PSJCNT1
 I $G(PSJDUR)="" Q
 I $G(PSJSCH)="" Q
 S PSJDUR1=0,PSJCNT1=""
 S PSJDOW=$$DOW(PSJSCH)
 ; PSJDUR1 - Duration in minutes (#_M)
 I $S(PSJDUR["DOSES":0,PSJDUR["H":1,PSJDUR["D":1,1:0) S PSJDUR1=$$DRT^PSSDSAPD(PSJDUR)_"M" S PSJIV("DUR")=+PSJDUR1
 ;
 S PSJCNT=$$FRQ^PSSDSAPI(PSJSCH,PSJDOW,"I",PSJDUR1)
 ; PSJCNT1 - Dose count from Duration
 I PSJDUR["DOSES" S PSJCNT1=+PSJDUR
 I PSJDUR["M" D
 . I '+$G(PSJTOTVL) S PSJIV("FRQ_ERROR")="" Q
 . I +PSJDUR>(PSJTOTVL*(+$P(PSJCNT,U,2))) S PSJIV("DUR")=""
 . S PSJCNT1=(+PSJDUR)/PSJTOTVL
 ; Set dose count to the less between Duration or schedule
 I PSJCNT1,(PSJCNT1<+PSJCNT) D
 . I PSJCNT1'=$J(PSJCNT1,"",0) S PSJIV("FRQ_ERROR")="" Q
 . S PSJIV("DOSE_CNT")=PSJCNT1
 . S:+$P(PSJCNT,U,2) PSJIV("DUR")=(1440/$P(PSJCNT,U,2))*PSJCNT1
 ; Set dose count for duration in day/hour
 I +PSJDUR1,($P(PSJCNT,U)<$P(PSJCNT,U,2)) S PSJIV("DOSE_CNT")=+PSJCNT
 Q
DOW(PSJSCH) ;Check if Schedule is a date of week
 ;Return "D" if date of week
 NEW PSJSCHNO,PSJDOW,PSJFOUND
 I $G(PSJSCH)="" Q ""
 S PSJDOW=0,PSJFOUND=0
 F PSJSCHNO=0:0 S PSJSCHNO=$O(^PS(51.1,"APPSJ",PSJSCH,PSJSCHNO)) Q:'PSJSCHNO!(PSJDOW)  D
 .I $P($G(^PS(51.1,PSJSCHNO,0)),"^",5)="D" S PSJDOW=1
 .I $D(^PS(51.1,PSJSCHNO,0)) S PSJFOUND=1
 I PSJDOW Q "D"
 I PSJFOUND Q ""
 I PSJSCH["@" Q "D"
 Q ""
PING() ;Return -1 if the system is down.
 S ^TMP($J,"PSJPRE","IN","PING")=""
 D IN^PSSHRQ2("PSJPRE")
 Q +$G(^TMP($J,"PSJPRE","OUT",0))
