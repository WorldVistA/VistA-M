IBCRHBS7 ;ALB/ARH - RATES: UPLOAD (RC 2+) CALCULATIONS SITE ; 10-OCT-03
 ;;2.0;INTEGRATED BILLING;**245,427**;21-MAR-94;Build 7
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
A(SITE,IBXRF1) ; use Inpatient Facility National Rates to calculate Site Specific Rates
 N IBXTMPC,IBI,IBLINE,IBDRG,IBEFF,IBINA,IBCT,IBCHRG
 ;
 I $P(SITE,U,5)'=1 Q
 ;
 S IBXTMPC="IBCR RC A"
 ;
 S IBI=0 F  S IBI=$O(^XTMP(IBXTMPC,IBI)) Q:'IBI  D  I '(IBI#100) W "."
 . S IBLINE=$G(^XTMP(IBXTMPC,IBI)) Q:IBLINE=""
 . ;
 . S IBDRG="DRG"_+$P(IBLINE,U,1),IBEFF=$P(IBLINE,U,9),IBINA=$P(IBLINE,U,10),IBCT=$P(IBLINE,U,2)
 . ;
 . ;
 . I IBCT="SNF" D  Q
 .. S IBCHRG=$$ISNF^IBCRHBS8(SITE,IBLINE)
 .. D SET(IBXRF1,"SNF PD INC","SKILLED NURSING CARE",IBEFF,IBINA,IBCHRG,"")
 .. D SET(IBXRF1,"SNF PD INC","SUB-ACUTE CARE",IBEFF,IBINA,IBCHRG,"")
 . ;
 . I IBCT="DRG" D  Q
 .. S IBCHRG=$$ISR^IBCRHBS8(SITE,IBLINE) D SET(IBXRF1,"Inpt PD R&B",IBDRG,IBEFF,IBINA,IBCHRG,"")
 .. S IBCHRG=$$ISA^IBCRHBS8(SITE,IBLINE) D SET(IBXRF1,"Inpt PD Anc",IBDRG,IBEFF,IBINA,IBCHRG,"")
 .. S IBCHRG=$$IIR^IBCRHBS8(SITE,IBLINE) D SET(IBXRF1,"Inpt PD R&B ICU",IBDRG,IBEFF,IBINA,IBCHRG,"")
 .. S IBCHRG=$$IIA^IBCRHBS8(SITE,IBLINE) D SET(IBXRF1,"Inpt PD Anc ICU",IBDRG,IBEFF,IBINA,IBCHRG,"")
 Q
 ;
 ;
B(SITE,IBXRF1) ; use Outpatient Facility National Rates to calculate Site Specific Rates
 N IBXTMPC,TYPE,IBI,IBLINE,IBCPT,IBEFF,IBINA,IBCHRG,IBUT,IBFAC
 ;
 S TYPE=$P(SITE,U,5) Q:'TYPE
 ;
 S IBXTMPC="IBCR RC B"
 ;
 S IBI=0 F  S IBI=$O(^XTMP(IBXTMPC,IBI)) Q:'IBI  D  I '(IBI#100) W "."
 . S IBLINE=$G(^XTMP(IBXTMPC,IBI)) Q:IBLINE=""
 . ;
 . S IBCPT=$P(IBLINE,U,1),IBEFF=$P(IBLINE,U,13),IBINA=$P(IBLINE,U,14),IBUT=$P(IBLINE,U,10)
 . ;
 . S IBCHRG=$$FAC^IBCRHBS8(SITE,IBLINE)
 . ;
 . ;
 . I $P(IBLINE,U,2)="PHOSP" D  Q  ; Partial Hospitalization
 .. I TYPE<3 D SET(IBXRF1,"Opt PD PHosp","PARTIAL HOSPITALIZATION",IBEFF,IBINA,IBCHRG,"")
 . ;
 . I TYPE=1 D  ; Inpatient/SNF Facility 
 .. I $P(IBLINE,U,11) D SET(IBXRF1,"Inpt Fac "_IBUT,IBCPT,IBEFF,IBINA,IBCHRG,"")
 .. I $P(IBLINE,U,12) D SET(IBXRF1,"SNF Fac "_IBUT,IBCPT,IBEFF,IBINA,IBCHRG,"")
 . ;
 . I TYPE<3 D  ; Outpatient Facility Charges
 .. D SET(IBXRF1,"Opt Fac "_IBUT,IBCPT,IBEFF,IBINA,IBCHRG,"")
 . ;
 . I TYPE=3 D  ; move facility charge to physician for Freestanding if there is no global or TC
 .. S IBFAC=$$INPHYS(IBCPT,IBUT) I IBFAC<0 Q
 .. I IBFAC=26 D SET(IBXRF1,"FS Phys/Opt TC "_IBUT,IBCPT,IBEFF,IBINA,IBCHRG,"TC")
 .. I IBFAC="" D SET(IBXRF1,"FS Phys/Opt "_IBUT,IBCPT,IBEFF,IBINA,IBCHRG,"")
 ;
 Q
 ;
C(SITE,IBXRF1) ; use Physician National Rates to calculate Site Specific Rates
 N IBXTMPC,TYPE,IBI,IBLINE,IBCPT,IBEFF,IBINA,IBUT,IBMOD,IBXRF2A,IBCHRG
 ;
 S TYPE=$P(SITE,U,5) Q:'TYPE
 ;
 S IBXTMPC="IBCR RC C"
 ;
 S IBI=0 F  S IBI=$O(^XTMP(IBXTMPC,IBI)) Q:'IBI  D  W:'(IBI#100) "."
 . S IBLINE=$G(^XTMP(IBXTMPC,IBI)) Q:IBLINE=""
 . ;
 . S IBCPT=$P(IBLINE,U,1),IBEFF=$P(IBLINE,U,22),IBINA=$P(IBLINE,U,23),IBUT=$P(IBLINE,U,16),IBMOD=$P(IBLINE,U,4)
 . ;
 . S IBCHRG=$$PROF^IBCRHBS8(SITE,IBLINE)
 . ;
 . ;
 . I TYPE=3 D  Q  ; Freestanding Professional Charge
 .. I +$P(IBLINE,U,21) D SET(IBXRF1,"FS Phys "_IBUT,IBCPT,IBEFF,IBINA,IBCHRG,IBMOD)
 . ;
 . S IBXRF2A="Phys "
 . I +$P(IBLINE,U,17) S IBXRF2A="Fac/Phys ",IBMOD=$S(IBMOD="TC":"",1:IBMOD) I +$$INFAC(IBCPT) Q  ; facility
 . ;
 . I TYPE=1 D
 .. I +$P(IBLINE,U,19) D SET(IBXRF1,"Inpt "_IBXRF2A_IBUT,IBCPT,IBEFF,IBINA,IBCHRG,IBMOD)
 .. I +$P(IBLINE,U,20) D SET(IBXRF1,"SNF "_IBXRF2A_IBUT,IBCPT,IBEFF,IBINA,IBCHRG,IBMOD)
 . ;
 . I TYPE<3 D
 .. I +$P(IBLINE,U,18) D SET(IBXRF1,"Opt "_IBXRF2A_IBUT,IBCPT,IBEFF,IBINA,IBCHRG,IBMOD)
 ;
 Q
 ;
FA(SITE,IBXRF1) ; Add TC and 26 Freestanding Professional charges to create global charge
 N IBTMPX,IBCPT,IBK,IBXRF2,IB26,IB26UT,IBTC,IBTCUT,IBUT,IBITEM,IBEFF,IBINA,IBMOD,IBCHRG,IBCHRGB
 ;
 S IBTMPX="IBCR UPLOAD FS PROF"
 ;
 I $P(SITE,U,5)'=3 Q
 ;
 S IBCPT="" F  S IBCPT=$O(^TMP($J,IBTMPX,IBCPT)) Q:IBCPT=""  D
 . I $O(^TMP($J,IBTMPX,IBCPT,"00",0)) Q
 . S IBK=$O(^TMP($J,IBTMPX,IBCPT,"26",0)) Q:'IBK
 . S IBXRF2=^TMP($J,IBTMPX,IBCPT,"26",IBK),IB26=^XTMP(IBXRF1,IBXRF2,+IBK) Q:IB26=""   S IB26UT=$$UNITYPE(IBXRF2)
 . S IBK=$O(^TMP($J,IBTMPX,IBCPT,"TC",0)) Q:'IBK
 . S IBXRF2=^TMP($J,IBTMPX,IBCPT,"TC",IBK),IBTC=^XTMP(IBXRF1,IBXRF2,+IBK) Q:IBTC=""   S IBTCUT=$$UNITYPE(IBXRF2)
 . ;
 . S IBUT=IB26UT I IB26UT'=IBTCUT W !,"ERROR, UNIT TYPES DON'T MATCH ",IBCPT Q
 . ;
 . S IBITEM=$P(IB26,U,1),IBEFF="20"_$E($P(IB26,U,2),2,7),IBINA="20"_$E($P(IB26,U,3),2,7),IBMOD=""
 . ;
 . S IBCHRG=$P(IB26,U,4)+$P(IBTC,U,4) Q:'IBCHRG  S IBCHRG=$J(IBCHRG,0,2)
 . S IBCHRGB=$P(IB26,U,6)+$P(IBTC,U,6) I +IBCHRGB S IBCHRG=IBCHRG_U_$J(IBCHGB,0,2)
 . ;
 . D SET(IBXRF1,"FS Phys/Add 00 "_IBUT,IBITEM,IBEFF,IBINA,IBCHRG,IBMOD)
 ;
 K ^TMP($J,IBTMPX)
 Q
 ;
 ;
 ;
SET(IBXRF1,IBXRF2,ITEM,EFFDT,INACTDT,CHRG,MOD) ; set calculated charges into XTMP
 ;
 N IBX,IBK,IBY,IBINACT,IBMODI S IBMODI=""
 S IBX=$G(^XTMP(IBXRF1,0))
 ;
 I IBX="" W !!,"ERROR: IBXRF1 NOT SET ",IBXRF1,!! Q
 I '$D(^XTMP(IBXRF1,IBXRF2)) W !!,"ERROR: IBXRF2 NOT SET ",IBXRF2,!! Q
 ;
 S IBK=+$P(IBX,U,4)+1,$P(^XTMP(IBXRF1,0),U,4)=IBK
 S $P(^XTMP(IBXRF1,IBXRF2),U,1)=(+$G(^XTMP(IBXRF1,IBXRF2))+1)
 ;
 I $G(MOD)'="" S IBY=$$MODIFN(MOD,EFFDT) I +IBY>0 S IBMODI=+IBY
 ;
 S ^XTMP(IBXRF1,IBXRF2,IBK)=ITEM_U_$$DATE(EFFDT)_U_$$ENDDT(INACTDT)_U_+CHRG_U_IBMODI_U_$P(CHRG,U,2)
 ;
 I $E(IBXRF2,1,7)="FS Phys" S MOD=$S(MOD="":"00",1:MOD),^TMP($J,"IBCR UPLOAD FS PROF",ITEM,MOD,IBK)=IBXRF2
 Q
 ;
 ;
DATE(X) ; return yyyymmdd in FM format
 N Y S Y="" I $G(X)?8N S Y=$S($E(X,1,4)>1999:3,1:2)_$E(X,3,4)_$E(X,5,8)
 Q Y
 ;
ENDDT(X) ; return yyyymmdd date in FM format, check version inactive date
 N Y,V S Y=$$DATE($G(X)) I 'Y S V=$G(^XTMP("IBCR RC SITE","VERSION INACTIVE")) I +V S Y=V
 Q Y
 ;
MODIFN(MOD,EFFDT) ; return internal form of modifier
 ; extra check is required because there are two RR modifiers so MOD will not return any
 ; base the get on a CPT code for which RR is known to be a valid modifier
 N IBY,IBX S (IBX,IBY)="" S EFFDT=$$DATE($G(EFFDT)) I 'EFFDT S EFFDT=DT
 I $G(MOD)'="" S IBY=$$MOD^ICPTMOD(MOD,"E",EFFDT)
 I IBY<0,$G(MOD)="RR" S IBY=$$MODP^ICPTMOD("K0455","RR","E",EFFDT)
 I IBY<0,$G(MOD)="KF" S IBY=$$MODP^ICPTMOD("E0785","KF","E",EFFDT)
 I IBY>0 S IBX=+IBY
 Q IBX
 ;
 ;
INPHYS(IBCPT,UNITYPE) ; returns string of all modifiers associated with Physician charges for CPT and Unit Type
 ; if charge exists but it has no modifier then uses 00, so if CPT has no charge then returns null
 ; if a charge is found for the CPT but it has a different Unit Type then -1 is returned
 ; note: if no freestanding physician charge then can add opt facility charge as physician charge
 ; note: if only a freestanding 26 physician charge then can add the opt facility charge as TC physician charge (same unit type)
 ;
 N MOD,MODS,IBX,IBY S MODS=""
 ;
 S IBX="" F  S IBX=$O(^XTMP("IBCR RC C","A",IBCPT,IBX)) Q:IBX=""  D
 . S IBY=^XTMP("IBCR RC C",IBX) I $P(IBY,U,16)'=UNITYPE S MODS=-1 Q
 . S MOD=$P(IBY,U,4) I MOD="" S MOD="00"
 . S MODS=MODS_MOD
 Q MODS
 ;
INFAC(IBCPT) ; check if the CPT code has a charge in the Opt Facility file (table B)
 ; return true if CPT code has a Opt Facility Charge 
 N IBX S IBX=0 I $O(^XTMP("IBCR RC B","A",IBCPT,"")) S IBX=1
 Q IBX
 ;
UNITYPE(IBXRF2) ; return unit type of group of charges last piece of IBXRF2
 N IBX,IBY,IBZ S IBX=""
 S IBY=$L(IBXRF2),IBZ=$E(IBXRF2,IBY) I IBZ>0,IBZ<5 S IBX=IBZ
 Q IBX
