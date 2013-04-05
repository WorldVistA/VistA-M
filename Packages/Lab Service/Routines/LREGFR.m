LREGFR ;DALOI/STAFF - Calculate Creatinine-eGFR ;02/28/12  20:15
 ;;5.2;LAB SERVICE;**289,313,350**;Sep 27, 1994;Build 230
 ;
 ; Reference to EN^DDIOL supported by IA #10142
 ; Reference to $$GET1^DIQ supported by IA #2056
 ; Reference to DEM^VADPT supported by IA # 10061
 ;
 ; This routine is a delta check for the lab test eGFR called by delta
 ; check CREATININE-EGFR. The eGFR test is calculated.
 ;
 ; Provided Data
 ;   DOB - Patient's date of birth
 ; LRDFN - entry in LAB DATA file
 ; LRIDT - inverse date/time of entry in LAB DATA file
 ;  LRNG - variable containing normals/units and delta check
 ;  LRSB - dataname for creatinine result
 ;
STRT(DFN,LRTR) ; Start Processing the Routine
 ; Call with DFN = parent file ien
 ;          LRTR = serum creatinine value as mg/dl
 ;
 ; Do not calculate eGFR if called from group data review.
 I $D(LRGVP) Q
 ;
 N AGE,LRFLG,LRTN,LRDC,LRRC,LRX,LRY,SEX,X,Y
 ;
 ; Determine test to store eFGR
 S LRDC=$P(LRNG,"^",8),LRY=""
 S LRX=$$GET1^DIQ(62.1,LRDC_",",61.1,"I")
 I LRX S LRY=$$GET1^DIQ(60,LRX_",",5,"I")
 S LRTN=$P(LRY,";",2)
 I LRTN="" D  Q
 . I $$CHKDUP(LRDFN,LRIDT,"For eGFR: **eGFR not Calculated - Delta check not configured**") Q
 . D FILECOM^LRVR4(LRDFN,LRIDT,"For eGFR: **eGFR not Calculated - Delta check not configured**")
 ;
 ; Quit if creatinine unchanged and eGFR already calculated and not 'pending'.
 I $P($G(LRSB(LRSB)),"^")=LRTR,$P($G(LRSB(LRTN)),"^")'="",$P(LRSB(LRTN),"^")'="pending" Q
 ;
 ; Check for eGFR dataname in test editing profile.
 ; If creatinine changed and eGFR previously calculated then warn.
 I '$D(^TMP("LR",$J,"TMP",LRTN)) D  Q
 . I $P($G(LRSB(LRSB)),"^")=LRTR Q
 . I $P($G(^LR(LRDFN,"CH",LRIDT,LRTN)),"^")'="" D
 . . I $$CHKDUP(LRDFN,LRIDT,"For eGFR: **eGFR not in test editing profile - Creatinine Changed**") Q
 . . D FILECOM^LRVR4(LRDFN,LRIDT,"For eGFR: **eGFR not in test editing profile - Creatinine Changed**")
 ;
 ; Calculate age based on specimen date/time
 S AGE=""
 ; If no collection date/time then set from specimen LRIDT.
 I $G(LRCDT)="" N LRCDT S LRCDT=$P(^LR(LRDFN,"CH",LRIDT,0),"^")
 I LRCDT,DOB S AGE=($$FMDIFF^XLFDT(LRCDT,DOB,1))\365.25
 I 'AGE D  Q
 . S $P(LRSB(LRTN),"^")="canc"
 . I $$CHKDUP(LRDFN,LRIDT,"For eGFR: **eGFR not Calculated - No Age Recorded**") Q
 . D FILECOM^LRVR4(LRDFN,LRIDT,"For eGFR: **eGFR not Calculated - No Age Recorded**")
 ;
 S LRFLG=0
 I AGE<18!(AGE>70) S LRFLG=$$GET^XPAR("DIV^PKG","LR EGFR AGE CUTOFF",1,"Q")
 I AGE<18,LRFLG?1(1"1",1"3") D  Q
 . I $$CHKDUP(LRDFN,LRIDT,"For eGFR: **eGFR not Calculated - Age <18**") Q
 . D FILECOM^LRVR4(LRDFN,LRIDT,"For eGFR: **eGFR not Calculated - Age <18**")
 . S $P(LRSB(LRTN),"^")="canc"
 I AGE>70,LRFLG>1 D  Q
 . I $$CHKDUP(LRDFN,LRIDT,"For eGFR: **eGFR not Calculated - Age >70**") Q
 . D FILECOM^LRVR4(LRDFN,LRIDT,"For eGFR: **eGFR not Calculated - Age >70**")
 . S $P(LRSB(LRTN),"^")="canc"
 ;
 S SEX=""
 I LRDPF=2 S SEX=$P(VADM(5),U)
 I LRDPF=67 S SEX=$$GET1^DIQ(67,DFN_",",.02,"I")
 I SEX=""!("MF"'[SEX) D  Q
 . S $P(LRSB(LRTN),"^")="canc"
 . I $$CHKDUP(LRDFN,LRIDT,"For eGFR: **eGFR not Calculated - No Sex Recorded**") Q
 . D FILECOM^LRVR4(LRDFN,LRIDT,"For eGFR: **eGFR not Calculated - No Sex Recorded**")
 ;
 ; Determine race
 S LRRC=$$RACE(DFN)
 ;
 I LRTR'>0 D  Q
 . S $P(LRSB(LRTN),"^")="canc"
 . I $$CHKDUP(LRDFN,LRIDT,"For eGFR: **eGFR not Calculated - Creatinine <=0**") Q
 . D FILECOM^LRVR4(LRDFN,LRIDT,"For eGFR: **eGFR not Calculated - Creatinine <=0**")
 ;
 ; Compute eGFR return-value
 ; Set user(DUZ) and site(DUZ(2) in case delta check calculated during entry of reference lab results.
 N LRCMETH,LREGFR,LRFACTOR,LRX
 S LRCMETH=+$$GET^XPAR("DIV^PKG","LR EGFR METHOD",1,"Q")
 S LRFACTOR=$S(LRCMETH=0:186,LRCMETH=1:175,1:186)
 S LREGFR=LRFACTOR*(LRTR**-1.154)*(AGE**-.203)
 I SEX="F" S LREGFR=LREGFR*.742
 I LRRC=1 S LREGFR=LREGFR*1.21
 ;
 I 'LREGFR Q
 ;
 I LREGFR>60,$$GET^XPAR("DIV^PKG","LR EGFR RESULT SUPPRESS",1,"Q") S LREGFR=">60"
 E  S LRX=+$$GET1^DID(63.04,LRTN,"","DECIMAL DEFAULT"),LREGFR=$FN(LREGFR,"",LRX)
 ;
 S $P(LRSB(LRTN),"^")=LREGFR
 S $P(LRSB(LRTN),"^",4)=$G(DUZ),$P(LRSB(LRTN),"^",9)=$G(DUZ(2))
 ;
 I LRRC="U" D
 . I $$CHKDUP(LRDFN,LRIDT,"For eGFR: Race unknown, if African American multiply result by 1.210") Q
 . D FILECOM^LRVR4(LRDFN,LRIDT,"For eGFR: Race unknown, if African American multiply result by 1.210")
 ;
 I LREGFR=">60" D
 . I $$CHKDUP(LRDFN,LRIDT,"For eGFR: eGFR results >60 are imprecise. Many variables affect the") Q
 . D FILECOM^LRVR4(LRDFN,LRIDT,"For eGFR: eGFR results >60 are imprecise. Many variables affect the")
 . D FILECOM^LRVR4(LRDFN,LRIDT,"calculated result. Interpretation of eGFR results >60 must be")
 . D FILECOM^LRVR4(LRDFN,LRIDT,"monitored over time.")
 ;
 Q
 ;
 ;
RACE(DFN) ; Get Race
 ;  Call with DFN = ien of PATIENT file (#2)
 ;  Returns   XRC = 1 (African American)
 ;                  0 (non African American)
 ;                  U (unknown)
 ;
 N XA,XB,XC,XD,XE,XRC
 S XA="BLACK",XB="AFRICAN",XC="HISPANIC,",XD="UNKNOWN",XE="DECLINED"
 S XRC=""
 ;
 ; If patient from PATIENT file (#2).
 I LRDPF=2 D
 . N VADM
 . D DEM^VADPT
 . S XRC=$P($G(VADM(12,1)),U,2)
 . S:XRC="" XRC=$P($G(VADM(8)),U,2)
 ;
 ; If patient from REFERRAL file (#67).
 I LRDPF=67 S XRC=$$GET1^DIQ(67,DFN_",",.06)
 ;
 ; If race not defined then set to unknown.
 I XRC="" S XRC="U"
 ;
 ; If race contains "BLACK" or "AFRICAN" but not HISPANIC then return "1"
 I XRC[XA!(XRC[XB) I XRC'[XC S XRC=1
 ;
 ; If unknown or declined then return "U"
 I XRC[XD!(XRC[XE) S XRC="U"
 ; If not unknown or African-American then return "0"
 I XRC'=1,XRC'="U" S XRC=0
 Q XRC
 ;
 ;
CHKDUP(LRDFN,LRIDT,LRSBCOM) ; Check for duplicate comment
 ; Call with  LRDFN = File #63 internal entry number
 ;            LRIDT = inverse date/time
 ;          LRSBCOM = comment to check if duplicate
 ;
 ; Returns    LRDUP = 0 (not a duplicate), 1 (comment exists - duplicate)
 ;
 N LRDUP,LRI,LRY,LRX
 S (LRDUP,LRI)=0,LRY=$TR(LRSBCOM," ",""),LRY=$$UP^XLFSTR(LRY)
 F  S LRI=$O(^LR(LRDFN,"CH",LRIDT,1,LRI)) Q:'LRI  D  Q:LRDUP
 . S LRX=$P($G(^LR(LRDFN,"CH",LRIDT,1,LRI,0)),"^")
 . S LRX=$TR(LRX," ",""),LRX=$$UP^XLFSTR(LRX)
 . I LRX=LRY S LRDUP=1
 Q LRDUP
 ;
 ;*************************************************************
 ;LR(E)stimated(G)lomerular(F)iltration(R)ate: LREGFR
 ;LR(T)est(N)ame:            LRTN
 ;        (R)esults:         LRTR
 ;LR(R)ace:                  LRRC
 ;
 ;*************************************************************
 ;*                      end of routine                       *
 ;*************************************************************
