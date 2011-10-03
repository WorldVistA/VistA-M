LREGFR2 ;DALOI/SDV/AH/GDU Calculate Creatinine-eGFR ;Feb 2, 2004
 ;;5.2;LAB SERVICES;**377**;Sep 27, 1994;Build 4
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
 N AGE,LRTN,LRDC,LRRC,LRX,LRY,SEX,X,Y
 ;
 ; Determine test to store eFGR
 S LRDC=$P(LRNG,"^",8),LRY=""
 S LRX=$$GET1^DIQ(62.1,LRDC_",",61.1,"I")
 I LRX S LRY=$$GET1^DIQ(60,LRX_",",5,"I")
 S LRTN=$P(LRY,";",2)
 I LRTN="" D  Q
 . D FILECOM^LRVR4(LRDFN,LRIDT,"For eGFR: **eGFR not Calculated - Delta check not configured**")
 ;
 ; Quit if creatinine unchanged and eGFR already calculated and not 'pending'.
 I $P($G(LRSB(LRSB)),"^")=LRTR,$P($G(LRSB(LRTN)),"^")'="",$P(LRSB(LRTN),"^")'="pending" Q
 ;
 ; Check for eGFR dataname in test editing profile.
 ; If creatinine changed and eGFR previously calculated then warn.
 I '$D(^TMP("LR",$J,"TMP",LRTN)) D  Q
 . I $P($G(LRSB(LRSB)),"^")=LRTR Q
 . I $P($G(^LR(LRDFN,"CH",LRIDT,LRTN)),"^")'="" D FILECOM^LRVR4(LRDFN,LRIDT,"For eGFR: **eGFR not in test editing profile - Creatinine Changed**")
 ;
 ; Calculate age based on specimen date/time
 S AGE=""
 I LRCDT,DOB S AGE=($$FMDIFF^XLFDT(LRCDT,DOB,1))\365.25
 I 'AGE D  Q
 . S $P(LRSB(LRTN),"^")="canc"
 . D FILECOM^LRVR4(LRDFN,LRIDT,"For eGFR: **eGFR not Calculated - No Age Recorded**")
 ;
 S SEX=""
 I LRDPF=2 S SEX=$P(VADM(5),U)
 I LRDPF=67 S SEX=$$GET1^DIQ(67,DFN_",",.02,"I")
 I SEX=""!("MF"'[SEX) D  Q
 . S $P(LRSB(LRTN),"^")="canc"
 . D FILECOM^LRVR4(LRDFN,LRIDT,"For eGFR: **eGFR not Calculated - No Sex Recorded**")
 ;
 ; Determine race
 S LRRC=$$RACE(DFN)
 ;
 ; Compute eGFR return-value
 ; Set user(DUZ) and site(DUZ(2) in case delta check calculated during
 ; entry of reference lab results. 
 I LRTR D
 . N LREGFR,LRX,PRMT
 . S LREGFR=175*(LRTR**-1.154)*(AGE**-.203)  ; Using a constant of 175. This is to support the updated creatinine methodology
 . I SEX="F" S LREGFR=LREGFR*.742
 . I LRRC=1 S LREGFR=LREGFR*1.21
 . I 'LREGFR Q
 . S LRX=+$$GET1^DID(63.04,LRTN,"","DECIMAL DEFAULT")
 . S $P(LRSB(LRTN),"^")=$FN(LREGFR,"",LRX)
 . S $P(LRSB(LRTN),"^",4)=$G(DUZ),$P(LRSB(LRTN),"^",9)=$G(DUZ(2))
 . I LRRC="U" D FILECOM^LRVR4(LRDFN,LRIDT,"For eGFR: Race unknown, if African American multiply result by 1.210")
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
 I LRDPF=67 D
 . S XRC=$$GET1^DIQ(67,DFN_",",.06)
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
 ;*************************************************************
 ;LR(E)stimated(G)lomerular(F)iltration(R)ate: LREGFR
 ;LR(T)est(N)ame:            LRTN
 ;        (R)esults:         LRTR
 ;LR(R)ace:                  LRRC
 ;
 ;*************************************************************
 ;*                      end of routine                       *
 ;*************************************************************
