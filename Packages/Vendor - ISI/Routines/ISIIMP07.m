ISIIMP07 ;ISI Group/MLS -- Problem Create Utility
 ;;1.0;;;Jun 26,2012;Build 93
 Q
VALIDATE() 
 ; Validate import array contents
 I $G(ISIPARAM("DEBUG"))>0 D  
 . W !,"+++Read in values+++ (07)",!
 . I $D(ISIMISC) W $G(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,ISIMISC(X)
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 S ISIRC=$$VALPROB^ISIIMPU4(.ISIMISC)
 Q ISIRC
 ;
MAKEPROB()
 ; Create Problem entry
 S ISIRC=$$CREATE(.ISIMISC)
 Q ISIRC
 ;
CREATE(ISIMISC)
 ; Input - ISIMISC(ARRAY)
 ; Format:  ISIMISC(PARAM)=VALUE
 ;     eg:  ISIMISC("PROVIDER")=126 
 ;
 ; Output - ISIRC [return code]
 ;          ISIRESUL(0)=1
 ;          ISIRESUL(1)=IEN
 ;
 I $G(ISIPARAM("DEBUG"))>0 D  
 . W !,"+++ISIIMP07: Values prior to PROBLEM CREATION+++",!
 . I $D(ISIMISC) W $G(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,"ISIMISC("_X_")="_ISIMISC(X)
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 ;
 ; Double check to prevent duplicates
 I $$DUPCHECK($G(ISIMISC("ICDIEN")),$G(ISIMISC("DFN")),$G(ISIMISC("ENTERED"))) Q "-9^Duplicate Entry Found: CREATE~ISIIMP07"
 ;    
 N GMPDFN,GMPPROV,GMPVAMC,GMPFLD
 K GMPDFN,GMPPROV,GMPVAMC,GMPFLD
 S GMPDFN=ISIMISC("DFN") ; patient dfn
 S GMPPROV=ISIMISC("PROVIDER") ;Provider IEN
 S GMPVAMC=$$KSP^XUPARAM("INST")  
 S GMPFLD(".01")=ISIMISC("ICDIEN")_U_ISIMISC("ICD") ;Code IEN ^ ICD
 S GMPFLD(".03")=0 ;
 S GMPFLD(".05")="^"_ISIMISC("EXPNM") ;Expression text
 S GMPFLD(".08")=$G(ISIMISC("ENTERED")) ; DATE ENTERED 
 S GMPFLD(".12")=ISIMISC("STATUS") ;Active/Inactive
 S GMPFLD(".13")=ISIMISC("ONSET") ;Onset date
 S GMPFLD("1.01")=ISIMISC("EXPIEN")_"^"_ISIMISC("EXPNM") ;^LEX(757.01 ien,descip
 S GMPFLD("1.02")="P" ;CONDITION (1.01)
 S GMPFLD("1.03")=ISIMISC("PROVIDER") ;Entered by
 S GMPFLD("1.04")=ISIMISC("PROVIDER") ;Recording provider
 S GMPFLD("1.05")=ISIMISC("PROVIDER") ;Responsible provider
 S GMPFLD("1.06")=$S($O(^DIC(49,"B","MEDICINE","")):$O(^DIC(49,"B","MEDICINE","")),1:1) ;SERVICE/SECTION (#49)
 S GMPFLD("1.07")=$G(ISIMISC("RESOLVED")) ; Date resolved
 S GMPFLD("1.08")=$G(ISIMISC("LOCATION")) ; Clinic (#44)
 S GMPFLD("1.09")=$G(ISIMISC("RECORDED")) ;DATE RECORDED
 S GMPFLD("1.1")=0 ;Service Connected
 S GMPFLD("1.11")=0 ;Agent Orange exposure
 S GMPFLD("1.12")=0 ;Ionizing radiation exposure
 S GMPFLD("1.13")=0 ;Persian Gulf exposure
 S GMPFLD("1.14")=ISIMISC("TYPE") ;Accute/Chronic (A,C)
 S GMPFLD("1.15")="" ;Head/neck cancer
 S GMPFLD("1.16")="" ;Military sexual trauma
 S GMPFLD("10",0)=0 ;auto set ""
 I $G(ISIMISC("SNOMED"))'="" D  
 . S GMPFLD(80001)=ISIMISC("SNOMED")_U_ISIMISC("SNOMED")
 . N SCTD S SCTD=$$GETDES^LEXTRAN1("SCT",$G(ISIMISC("EXPNM")))
 . I +SCTD=1 S SCTD=$P(SCTD,U,2),GMPFLD(80002)=SCTD_U_SCTD
 . Q
 D NEW^GMPLSAVE
 I '$D(DA) Q "-1^Error creating problem"
 S ISIRESUL(0)=1
 S ISIRESUL(1)=DA
 ;
 ; Add support to populate V POV file
 I $G(ISIMISC("VPOV"))="Y" S ISIMISC("PROBIEN")=DA D IVPOV^ISIIMP27(.ISIMISC)
 ;
 Q 1
 ;
DUPCHECK(ICDIEN,DFN,RECORDDT)
 ;Checks for (possible) duplicate entries in PROBLEM file
 ; INPUT:
 ;   ICDIEN = ICD (#80) ien
 ;   DFN = patient DFN
 ;   RECORDDT = DATE RECORDED (1.09) Filman format
 ; OUTPUT:
 ;   OUT = '1' means duplicate found
 ;
 N OUT S OUT=0
 S DFN=+$G(DFN) I '$D(^DPT(DFN,0)) Q OUT_U_"Bad DFN" ;can't find patient
 S RECORDDT=+$G(RECORDDT) I 'RECORDDT Q OUT_U_"Bad RECORDDT" ;no valid date
 S ICDIEN=+$G(ICDIEN) I '$D(^ICD9(ICDIEN)) Q OUT_U_"Bad ICDIEN"
 I '$D(^AUPNPROB("AC",DFN)) Q OUT_U_"No PROBLEMS found for DFN:"_$G(DFN)
 I '$D(^AUPNPROB("B",ICDIEN)) Q OUT_U_"No PROBLEMS found for ICD9:"_$G(ICDIEN)
 N PROBIEN S PROBIEN=0 F  S PROBIEN=$O(^AUPNPROB("B",ICDIEN,PROBIEN)) Q:'PROBIEN!OUT  D  
 . I $P($G(^AUPNPROB(PROBIEN,0)),U,12)'="A" Q ;only Active
 . I $P($G(^AUPNPROB(PROBIEN,1)),U,9)=RECORDDT,$P($G(^AUPNPROB(PROBIEN,0)),U,2)=DFN S OUT=PROBIEN Q
 . Q
 Q OUT
