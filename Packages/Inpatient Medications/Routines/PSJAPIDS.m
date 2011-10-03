PSJAPIDS ;BIR/MV - API TO PROCESS DOSING ORDER CHECKS FOR IV ;6 Jun 07 / 3:37 PM
 ;;5.0; INPATIENT MEDICATIONS ;**181**;16 DEC 97;Build 190
 ;
 ; Reference to ^PS(51.1 is supported by DBIA# 2177.
 ;
IVBAG(PSIVINRT,PSIVVOL,PSIVTDUR) ;
 ;Return the number of IV bags needed for a 24 hours period
 ;If the order is < 24 hrs, the return the max bags allow for the time frame
 ;
 ;PSIVINRT - Infusion Rate (ex: 125 ML/HR) (required)
 ;PSIVVOL - The volume entered for the IV Solution (ex: 1000 ML) (required)
 ;PSIVTDUR - The total volume (ex: 3000 ML)(optional), or
 ;           Duration of the order (ex: 4D or 36H) (optional)
 ;Return # of IV bags require for 24 hour time frame UNLESS:
 ;       the value is <1 then return a 1, for free text infusion rate, or
 ;       there's no volume, or bad Dur/Tot volume then return null
 ;       
 NEW PSIVBAG,PSIVDUR,PSIVDUR1,PSIVTVOL
 I '+$G(PSIVINRT)!'+$G(PSIVVOL)!'+$G(PSIVTDUR) Q ""
 S (PSIVDUR,PSIVTVOL)=""
 I $G(PSIVTDUR)]"" D
 . S PSIVTDUR=$$UP^XLFSTR(PSIVTDUR)
 . I PSIVTDUR["H"!(PSIVTDUR["D") S PSIVDUR=PSIVTDUR Q
 . I $P(PSIVTDUR," ",2)="L" S PSIVTVOL=+PSIVTDUR*1000
 . I $P(PSIVTDUR," ",2)="ML" S PSIVTVOL=+PSIVTDUR
 S PSIVBAG=1
 ;Calculate # of bags needed if Duration is passed in
 I $G(PSIVDUR)]"" D  Q $S(PSIVBAG<1:1,1:PSIVBAG)
 . S PSIVDUR1=+$$DRT^PSSDSAPD(PSIVDUR)
 . I PSIVDUR1=-1 Q
 . I PSIVDUR1>=1440 S PSIVTVOL=+PSIVINRT*24
 . I +PSIVDUR1,(PSIVDUR1<1440) S PSIVTVOL=+PSIVINRT*PSIVDUR1/60
 . S:+PSIVVOL PSIVBAG=PSIVTVOL\+PSIVVOL
 ;Calculate # of bags needed if Total volume is passed in
 I +PSIVTVOL S PSIVBAG=+PSIVTVOL\+PSIVVOL Q $S(PSIVBAG<1:1,1:PSIVBAG)
 S:+PSIVVOL PSIVBAG=(+PSIVINRT*24)\+PSIVVOL
 Q $S(PSIVBAG<1:1,1:PSIVBAG)
 ;
DOSE(PSJBASE,DFN,PSJIV) ;
 ;PSJBASE(1)=PSJBASE - Base1(Literal value for TMP global)- Required
 ;PSJBASE(3)=PSJBASE1 - Base2(Literal value for Screened display TMP global)- Required
 ;PSJDFN - Patient Internal Entry Number
 ;PSJIV(Px) - See DBIA #5385...P4 can be "ALL", "See Comments", or bottle number(s)
 ;PSJIV("TVOL_VOL") - Contains nUnit where n is # & Unit is either H,D,L,M, or DOSES 
 NEW DRG,P,PSIVAS,PSIVNM,PSJDD,PSJFDB,PSJOCDS,PSIVTDUR,PSJTOTVL,X
 I $$PING()=-1 Q
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
 D DOSE^PSSDSAPD(.PSJBASE,DFN,.PSJOCDS,.PSJFDB)
 K ^TMP($J,"PSJPRE")
 Q
SETDRG ;
 NEW PSIVX,PSIVX0,PSJDD,PSGDT,PSJCNT,%
 D NOW^%DTC S PSGDT=%
 F PSIVAS="AD","SOL" S PSJCNT=0 F PSIVX=0:0 S PSIVX=$O(PSJIV(PSIVAS,PSIVX)) Q:'PSIVX  D
 .S PSIVX0=$G(PSJIV(PSIVAS,PSIVX))
 .D:PSIVAS="AD" SETAD(+PSIVX0,$P(PSIVX0,U,2))
 .D:PSIVAS="SOL" SETSOL(+PSIVX0,$P(PSIVX0,U,2))
 Q
SETAD(PSJOI,PSJOINM) ;Check if additive is active then set the DRG array
 ;PSJOI - 50.7 ien
 ;PSJOINM - CPRS OI name
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
 I 'PSJOK,($G(PSJOINM)]"") S PSJIV("OI_ERROR",PSJOINM)=4_U_PSJOI
 Q
SETSOL(PSJOI,PSJOINM) ;Check if solution is active then set then DRG array
 ;PSJOI - 50.7 ien
 ;PSJOINM - CPRS OI name
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
 I 'PSJOK,($G(PSJOINM)]"") S PSJIV("OI_ERROR",PSJOINM)=4_U_PSJOI
 Q
DURATION(PSJDUR,PSJSCH) ;Figure out date dose limit send by CPRS
 ;Set PSJIV("DOSE_CNT") only for duratin < 24 hrs & set PSJIV("DUR") to # minutes specified in the duration field
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
 ; Set dose count for duratin in day/hour
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
