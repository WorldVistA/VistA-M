FBAAFSR ;WCIOFO/TCK,SS,DMK,SAB-RBRVS FEE SCHEDULE ; 1/14/11 11:07am
 ;;3.5;FEE BASIS;**4,53,71,84,92,93,99,102,105,109,110,112,118**;JAN 30, 1995;Build 14
 ;
 Q
 ;
RBRVS(CPT,MODL,DOS,ZIP,FAC,TIME) ; calculate RBRVS Fee Schedule amount
 ; Input
 ;   CPT    = CPT/HCPCS code (external value)
 ;   MODL   = list of CPT/HCPCS modifiers (external values)
 ;            delimited by commas (e.g. "26,51")
 ;   DOS    = date of service (fileman format e.g. 2980101)
 ;   ZIP    = ZIP code of service (external 5 digit value)
 ;   FAC    = facility flag =1 if site of service is facility setting
 ;   TIME   = time in minutes, only passed on anesthesia CPT codes
 ; Returns string
 ;     dollar amount^sched year OR null value if not on RBRVS schedule
 ; Output
 ;     FBERR( array of error messages OR undefined if none
 ;
 N FBAMT,FBCF,FBCPT0,FBCPTY0,FBCY,FBERR,FBGPCIY0
 ;
 ; initialization
 S FBAMT=""
 K FBERR
 ;
 ; check for required input parameters
 I $G(CPT)="" D ERR^FBAAFS("CPT missing")
 I $G(DOS)'?7N D ERR^FBAAFS("Date of Service missing")
 I $D(FBERR) Q FBAMT
 ;
 ;if date of service prior to VA implementation, don't use RBRVS
 I DOS<2990901 Q FBAMT
 ;
 ;if modifier SG present, don't use RBRVS, patch FB*3.5*84
 I MODL["SG" Q FBAMT
 ;
 ; determine schedule calendar year based on date of service
 S FBCY=$E(DOS,1,3)+1700
 ;
 ;If date of service in 2003 but prior to Mar 1, 2003 treat as 2002
 I $E(DOS,1,3)=303,DOS<3030301 S FBCY=FBCY-1
 ;
 ; if year after most recent RBRVS schedule then use prior year schedule
 I FBCY>$$LASTCY() S FBCY=FBCY-1
 ;
 ; get procedure data from schedule for year
 D PROC(CPT,MODL,FBCY)
 ;
 ; if procedure:
 ; - covered
 ; - payable
 ; - not for anesthesia
 ; then calculate amount
 I FBCPTY0]"",'$$ANES^FBAAFS(CPT) D
 . ;
 . ;validate parameters
 . I $G(ZIP)="" D ERR^FBAAFS("Missing ZIP Code")
 . I $G(FAC)="" D ERR^FBAAFS("Missing Facility Flag")
 . I $D(FBERR) Q
 . ;
 . ; get GPCIs for calendar year
 . D ZIP(FBCY,ZIP)
 . I FBGPCIY0="" D ERR^FBAAFS("Could not determine GPCIs") Q
 . ;
 . ; get conversion factor
 . S FBCF=$$CF(FBCY,$P(FBCPT0,U,2))
 . I FBCF="" D ERR^FBAAFS("Could not determine the conversion factor") Q
 . ;
 . ; calculate full schedule amount
 . D CALC(FBCY,FAC,FBCPTY0,FBGPCIY0,FBCF)
 . ;
 . ; apply adjustments to calculation
 .  S FBAMT=$J(FBAMT,0,2)*$$ADJ(CPT,DOS)
 . ; apply multiplier based on modifier
 . I MODL]"" S FBAMT=FBAMT*$$MULT(FBCY,MODL,FBCPT0,FBCPTY0)
 ;
 ; return result
 Q $S(FBAMT>0:$J(FBAMT,0,2)_U_FBCY,1:"")
 ;
PROC(CPT,MODL,FBCY,FBNONPBL) ; get procedure data for RBRVS schedule
 ; Input
 ;   CPT    = CPT/HCPCS code (external value)
 ;   MODL   = list of CPT/HCPCS modifiers (external value)
 ;            delimited by commas
 ;   FBCY   = calendar year (4 digit)
 ;   FBNONPBL ( optional):  
 ;     if $G(FBNONPBL)=0 then will make search among payable records only in #162.97
 ;     ignoring those non-payable ones with field #.08 NONPAYABLE = 1
 ;     if $G(FBNONPBL)=1 then will make search among all items in #162.97
 ;   
 ; Output
 ;   FBCPT0  = zero node from file 162.97 OR "" if not covered
 ;   FBCPTY0 = zero node from subfile 162.971 or "" if not covered
 N CPTM,MOD,FBI
 S (FBCPT0,FBCPTY0)=""
 Q:$G(FBCY)']""!($G(CPT)']"")
 ;
 ; if modifier exists try to find entry with modifier
 I MODL]"" D
 . F FBI=1:1 S MOD=$P(MODL,",",FBI) Q:MOD=""  D  Q:FBCPTY0]""
 . . S CPTM=CPT_"-"_MOD
 . . D PROC1(CPTM,FBCY,$G(FBNONPBL))
 ;
 ; if not found with modifier, try just CPT code
 I FBCPTY0="" D PROC1(CPT,FBCY,$G(FBNONPBL))
 ;
 Q
 ;
PROC1(CPTM,FBCY,FBNONPBL) ; get procedure data for CPT-Modifier
 ; input
 ;   CPTM - CPT Code - Modifier (e.g. 57335-TC or 57335)
 ;   FBCY - 4 digit calendar year
 ;   FBNONPBL ( optional):  
 ;     if $G(FBNONPBL)=0 then will make search among payable records only in #162.97
 ;     ignoring those non-payable ones with field #.08 NONPAYABLE = 1
 ;     if $G(FBNONPBL)=1 then will make search among all items in #162.97
 ; output
 ;   FBCPT0  = zero node from file 162.97 OR "" if not covered
 ;   FBCPTY0 = zero node from subfile 162.971 or "" if not covered
 N FBDA,FBDA1
 S (FBCPT0,FBCPTY0)=""
 S FBDA=$O(^FB(162.97,"B",CPTM,0))
 S FBDA1=$S(FBDA:$O(^FB(162.97,FBDA,"CY","B",FBCY,0)),1:"")
 I $G(FBDA),$G(FBDA1) D
 . N FBI,FBSUM,FBY
 . S FBY=$G(^FB(162.97,FBDA,"CY",FBDA1,0))
 . ;if non-payable records should not be considered
 . ;then quit if this is NONPAYBLE 
 . I +$G(FBNONPBL)=0 Q:$P(FBY,U,8)=1
 . ; check if procedure covered by schedule
 . I +$G(FBNONPBL)=0,$$ANES^FBAAFS($P(CPTM,"-")),$P(FBY,U,6)']"" Q  ; missing anes base
 . I +$G(FBNONPBL)=0,'$$ANES^FBAAFS($P(CPTM,"-")) D  I FBSUM'>0 Q  ; sum of RVUs = 0
 . . S FBSUM=0 F FBI=3,4,5,6 S FBSUM=FBSUM+$P(FBY,U,FBI)
 . ; passed checks
 . S FBCPTY0=FBY
 . S FBCPT0=$G(^FB(162.97,FBDA,0))
 Q
 ;
ZIP(FBCY,ZIP) ; get GPCIs
 ; Input
 ;   FBCY  = calendar year (4 digit)
 ;   ZIP   = zip code (5 digit external value)
 ; Output
 ;   FBGPCIY0 = zero node from file 162.96 or "" if not found
 S FBGPCIY0=""
 Q:$G(FBCY)']""!($G(ZIP)']"")
 N FBDA,FBDA1
 S FBDA=$O(^FB(162.96,"B",ZIP,0))
 S FBDA1=$S(FBDA:$O(^FB(162.96,FBDA,"CY","B",FBCY,0)),1:"")
 I FBDA,FBDA1 S FBGPCIY0=$G(^FB(162.96,FBDA,"CY",FBDA1,0))
 Q
 ;
CF(FBCY,FBDA) ; get conversion factor
 ; Input
 ;   FBCY = calendar year
 ;   FBDA = optional conversion category (internal)
 ; Returns
 ;   conversion factor from file 162.99
 N FBCF,FBDA1
 I '$G(FBDA) S FBDA=4 ; use Medicine category if not specified
 S FBDA1=$O(^FB(162.99,FBDA,"CY","B",FBCY,0))
 S FBCF=$S(FBDA1:$P($G(^FB(162.99,FBDA,"CY",FBDA1,0)),U,2),1:"")
 Q +FBCF
 ;
CALC(FBCY,FAC,FBCPTY0,FBGPCIY0,FBCF) ;
 ; Input
 ;   FBCY    = calendar year (4 digit)
 ;   FAC     = facility flag (0 or 1)
 ;   FBCPTY0 = zero node from file 162.71
 ;   FBGPCI0 = zero node from file 162.61
 ;   FBCF    = conversion factor (number)
 ; Returns $ amount
 ;
 N GPCI,RVU,FBI,TMP,TMPRVU
 S FBAMT=0
 ;Old formula for RBRVS pre-2007 payment amounts 
 I DOS<3070101 D
 .S RVU(1)=$P(FBCPTY0,U,3)
 I (DOS=3070101!(DOS>3070101)&(DOS<3080101)) D
 .;New formula for RBRVS 2007 payment amounts
 .;Multiply Work RVU by the Budget Neutrality Adjustor (0.8994)
 .S TMP=$P(FBCPTY0,U,3),TMPRVU=$J((TMP*(.8994)),".",2)
 .S RVU(1)=TMPRVU
 I (DOS=3080101!(DOS>3080101)&(DOS<3090101)) D
 .;New formula for the RBRVS 2008 payment amounts
 .;Multiply Work RVU by the Budget Neutrality Adjustor (0.8994)
 .S TMP=$P(FBCPTY0,U,3),TMPRVU=$J((TMP*(.8806)),".",2)
 .S RVU(1)=TMPRVU
 ;RBRVS 2009 does not have a budget neutrality adjustor.
 I (DOS=3090101!(DOS>3090101)) D
 .S RVU(1)=$P(FBCPTY0,U,3)
 S RVU(2)=$P(FBCPTY0,U,4+FAC)
 S RVU(3)=$P(FBCPTY0,U,6)
 F FBI=2,3,4 S GPCI(FBI-1)=$P(FBGPCIY0,U,FBI)
 S FBAMT=((RVU(1)*GPCI(1))+(RVU(2)*GPCI(2))+(RVU(3)*GPCI(3)))*FBCF
 ; some procedures can't be performed in a facility setting by
 ; definition. the facility PE RVU for such a procedure is a null
 ; value.
 ; when facility setting - check for a null PE value and don't return amt
 I RVU(2)="",FAC S FBAMT=0 Q
 Q
 ;
MULT(FBCY,MODL,FBCPT0,FBCPTY0) ;returns multiplier based on table type
 ; Input
 ;   FBCY    = calendar year (4 digit)
 ;   MODL    = list of CPT/HCPCS modifiers (external values)
 ;              delimited by commas
 ;   FBCPT0  = zero node of file 162.7 for procedure
 ;   FBCPTY0 = zero node of subfile 162.71 for year
 ; Returns
 ;   multiplier value OR 1 if none
 N FBDA,FBDA1,FBI,FBML,FBPD,FBRET,FBTBL,MOD
 S FBRET=1
 S FBML=$P(FBCPTY0,U,2) ; mod level table for procedure
 I MODL]"",FBML]"",FBCY]"" D
 . S FBTBL=FBCY_"-"_FBML ; mod level table for year
 . S FBDA=$O(^FB(162.98,"B",FBTBL,0))
 . Q:'FBDA  ; table not found
 . ; loop thru the modifiers
 . F FBI=1:1 S MOD=$P(MODL,",",FBI) Q:MOD=""  D
 . . I $P($P(FBCPT0,U),"-",2)=MOD Q  ; modifier already built in schedule
 . . ; look up modifier in mod level table
 . . S FBDA1=$O(^FB(162.98,FBDA,"M","B",MOD,0))
 . . Q:'FBDA1  ; modifier not found in table
 . . S FBPD=$P($G(^FB(162.98,FBDA,"M",FBDA1,0)),U,2) ; percentage
 . . I FBPD>0 S FBRET=FBRET*(FBPD/100) ; multiplier
 Q FBRET
 ;
LASTCY() ; Determine last calendar year of RBRVS FEE schedule data
 ; based on last year for Medicine conversion factor
 N YEAR
 S YEAR=$O(^FB(162.99,4,"CY","B"," "),-1)
 Q YEAR
ADJ(CPT,DOS) ;Apply Adjustments to Fee Amount
 ;Apply 5% increase based on CR 6208 Adjustment for Medicare Mental Health Services
 ;Calculate 98% for CPT 98940,98941,98942 (RVU10AR).  
 N ADJ
 S ADJ=1.0
 I (DOS>3080630)&((CPT>90803)&(CPT<90830))&((CPT'=90820)&(CPT'=90825)) S ADJ=1.05
 I ((DOS>3091231)&(CPT>98939)&(CPT<98943)) S ADJ=0.98
 Q ADJ
 ;FBAAFSR
