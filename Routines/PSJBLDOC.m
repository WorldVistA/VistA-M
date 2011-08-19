PSJBLDOC ;BIR/MV - API to build ^TMP for prospective and PSJ profile drugs ;03 Aug 98 / 8:42 AM
 ;;5.0;INPATIENT MEDICATIONS ;**181,263**;16 DEC 97;Build 51
 ;
 ; Reference to ^PS(52.6 is supported by DBIA# 1231.
 ; Reference to ^PS(52.7 is supported by DBIA# 2173.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^PSDRUG is supported by DBIA# 2192.
 ; Reference to ^PSSDSAPM is supported by DBIA# 5570.
 ;
IN(DFN,LIST,PDRG,PTYP) ;
 ;Build the IPM profiles and the prospective drugs list for both PSO & PSJ if PDRG is passed in.
 ;DFN - PATIENT DFN
 ;LIST - BASE
 ;PDRG - Drug array in format of PDRG(n)=IEN (#50) ^ Drug name
 ;       Where n is a sequential number.  Drug name can be OI, Generic name from #50 or Additive/sol name
 ;PTYP - P1;P2 where P1="I" for Inpatient & "O" for Outpatient, P2= PSJ order#
 NEW PSJONCNT,PSJDCNT,PSJDRGND,PSJWON
 S PSJONCNT=0
 S PSJWON=$P($G(PTYP),";",2)
 D PROFILE(DFN,PSJWON)
 Q
PROFILE(DFN,PSJWON)     ;Setup ^TMP for the active meds to be on the OC profile list.
 ;DFN:    Patient internal entry number
 ;PSJWON: The current order number being working on.  It can be null.
 ;        It is the order being work on (RN, FN..) and should be on the prospective list.
 ;Output: ^TMP($J,"ORDERS",PSJINX)=DRUG CLASS^NATIONAL DRUG FILE ENTRY
 ;        _"A"_PSNDFA PRODUCT NAME ENTRY_DISPENSE DRUG NAME^OE/RR #
 ;        _ORDER NUMBER(P/I/V)_";I"
 ;
 NEW BDT,COD,DDRUG,DDRUGND,EDT,F,ON,ON1,PST,WBDT,X,PSJORIEN,%
 S PSJWON=$G(PSJWON)
 D NOW^%DTC S (BDT,WBDT)=%,EDT=9999999
 S F="^PS(55,DFN,5," F  S WBDT=$O(^PS(55,DFN,5,"AUS",WBDT)) Q:'WBDT  F ON=0:0 S ON=$O(^PS(55,DFN,5,"AUS",WBDT,ON)) Q:'ON  S COD=ON_"U" D:COD'=PSJWON UD
 S F="^PS(53.1," F PST="P","N" F ON=0:0 S ON=$O(^PS(53.1,"AS",PST,DFN,ON)) Q:'ON  D
 . S COD=ON_"P" Q:COD=PSJWON
 . I $G(PSJCOM),($G(PSJWON)["P") Q:$D(^PS(53.1,"ACX",PSJCOM,+ON))
 . I $O(^PS(53.1,+ON,"AD",0))!$O(^PS(53.1,+ON,"SOL",0)) D PIV Q
 . D UD
 S WBDT=BDT F  S WBDT=$O(^PS(55,DFN,"IV","AIS",WBDT)) Q:'WBDT  F ON=0:0 S ON=$O(^PS(55,DFN,"IV","AIS",WBDT,ON)) Q:'ON  S COD=ON_"V" D:COD'=PSJWON IV
 K PSJWON
 Q
UD ;Get the dispense drugs for the Unit Dose orders.
 NEW X,PSJQUIT,PSJCNT,DDRUG,DDRUGN,PSJX,PSJOI,PSJEXPDD
 S X=@(F_ON_",0)")
 Q:$P(X,U,9)="R"
 Q:$P(X,U,9)="D"
 Q:$P(X,U,9)="E"
 S PSJORIEN=$P(X,U,21),DDRUG=0
 ;
 ;Use the first active DD within the order. If >1 DD, use OI_Dosage form for display name
 S ON1=0,PSJCNT=0 F  S ON1=$O(@(F_ON_",1,"_ON1_")")) Q:'ON1  S PSJCNT=PSJCNT+1
 S PSJOI=+$G(@(F_ON_",.2)"))
 S ON1=0,PSJQUIT=0 F  S ON1=$O(@(F_ON_",1,"_ON1_")")) Q:'+ON1!PSJQUIT  S DDRUG=@(F_ON_",1,"_ON1_",0)") D
 . Q:'+DDRUG
 . S PSJX=$P(DDRUG,U,3)
 . I PSJX]"",(PSJX'>BDT) Q
 . D SETIN("PROFILE",$S(PSJCNT>1:$$OIDF^PSJLMUT1(+$G(PSJOI)),1:$P($G(^PSDRUG(DDRUG,0)),U)),+DDRUG,COD) S PSJQUIT=1
 ;Quit when an active DD within the order if found
 Q:+$G(PSJQUIT)
 ;
 ;No DD found from the order. Get one from the OI
 I '+PSJOI D SETIN("PROFILE","NOT FOUND: "_COD,"",COD,1) Q
 S DDRUG=$P($$DRG^PSSDSAPM(+PSJOI,"I"),U)
 I +DDRUG D SETIN("PROFILE",$S(PSJCNT>1:$$OIDF^PSJLMUT1(+$G(PSJOI)),1:$P($G(^PSDRUG(DDRUG,0)),U)),+DDRUG,COD) Q
 ;
 ;Get the first DD from OI
 I '+DDRUG S DDRUG=$O(^PSDRUG("ASP",PSJOI,0)) I +DDRUG D SETIN("PROFILE",$S(PSJCNT>1:$$OIDF^PSJLMUT1(+$G(PSJOI)),1:$P($G(^PSDRUG(DDRUG,0)),U)),+DDRUG,COD) Q
 ;
 ;Set exception when no DD found
 I '+DDRUG D SETIN("PROFILE",$$OIDF^PSJLMUT1(+$G(PSJOI)),"",COD,1) Q
 Q
PIV ;Get the dispense drugs for the Pending IV orders.
 NEW PSJ0,PSJX,DDRUG,PSJNM
 S PSJX=^PS(53.1,+ON,0),PSJORIEN=$P(PSJX,U,21) Q:$P(PSJX,U,27)="R"
 S ON1=0 F  S ON1=$O(^PS(53.1,+ON,"AD",ON1)) Q:'ON1  D
 . S PSJX=^PS(53.1,+ON,"AD",ON1,0),PSJ0=$$IV0("AD",+PSJX)
 . S PSJNM=$P(PSJ0,U)_" "_$P(PSJX,U,2),DDRUG=$P(PSJ0,U,2)
 . I '+DDRUG D SETIN("PROFILE",PSJNM,"",COD,4) Q
 . D SETIN("PROFILE",$P(PSJ0,U)_" "_$P(PSJX,U,2),$P(PSJ0,U,2),COD)
 S ON1=0 F  S ON1=$O(^PS(53.1,+ON,"SOL",ON1)) Q:'ON1  D
 . S PSJX=^PS(53.1,+ON,"SOL",ON1,0) D
 . I $$PREMIX^PSJMISC(+PSJX) D
 .. S PSJ0=$$IV0("",+PSJX)
 .. S PSJNM=$P(PSJ0,U)_" "_$P(PSJX,U,2),DDRUG=$P(PSJ0,U,2)
 .. I '+DDRUG D SETIN("PROFILE",PSJNM,"",COD,4) Q
 .. D SETIN("PROFILE",$P(PSJ0,U)_" "_$P(PSJX,U,2),$P(PSJ0,U,2),COD)
 Q
IV ;Get the dispense drugs for the IV orders.
 NEW PSJ0,PSJX,DDRUG,PSJNM
 S PSJX=^PS(55,DFN,"IV",ON,0),PSJORIEN=$P(PSJX,U,21)
 Q:$P(PSJX,U,17)="R"
 Q:$P(PSJX,U,17)="D"
 Q:$P(PSJX,U,17)="E"
 S ON1=0 F  S ON1=$O(^PS(55,DFN,"IV",ON,"AD",ON1)) Q:'ON1  D
 . S PSJX=^PS(55,DFN,"IV",ON,"AD",ON1,0),PSJ0=$$IV0("AD",+PSJX)
 . S PSJNM=$P(PSJ0,U)_" "_$P(PSJX,U,2),DDRUG=$P(PSJ0,U,2)
 . I '+DDRUG D SETIN("PROFILE",PSJNM,"",COD,4) Q
 . D SETIN("PROFILE",PSJNM,DDRUG,COD)
 ; Only include Pre-mix in the OC.
 S ON1=0 F  S ON1=$O(^PS(55,DFN,"IV",ON,"SOL",ON1)) Q:'ON1  D
 . S PSJX=^PS(55,DFN,"IV",ON,"SOL",ON1,0)
 . I $$PREMIX^PSJMISC(+PSJX) D
 .. S PSJ0=$$IV0("",+PSJX)
 .. S PSJNM=$P(PSJ0,U)_" "_$P(PSJX,U,2),DDRUG=$P(PSJ0,U,2)
 .. I '+DDRUG D SETIN("PROFILE",PSJNM,"",COD,4) Q
 .. D SETIN("PROFILE",PSJNM,DDRUG,COD)
 Q
SETIN(PSJFLG,PSJNM,DDRUG,ON,PSJCODE) ;Set ^TMP($J,"PSJPRE,"IN" arrays.
 ;ON = ON with "U/V/P"
 ;PSJFLG = "PROSPECTIVE" or "PROFILE"
 ;PSJNM = This should be the AD/SOL print name or IV order.  Use Dispense drug name if U/D order
 ;PSJPON = 4 piece pharmacy order #
 NEW PSJPON
 Q:$G(PSJFLG)=""
 S PSJONCNT=$G(PSJONCNT)+1
 S PSJPON="I;"_ON_";"_PSJFLG_";"_PSJONCNT
 I '+$G(DDRUG) D  Q
 . I +$G(PSJCODE) D NODD($G(PSJCODE),PSJNM,PSJPON,LIST)
 Q:$$SUP^PSSDSAPI(+DDRUG)
 I $G(PSJNM)="" S PSJNM=$P($G(^PSDRUG(+DDRUG,0)),U)
 S ^TMP($J,LIST,"IN",PSJFLG,PSJPON)=+$$GCN^PSJMISC(+DDRUG)_U_$$GTVUID^PSJMISC(+DDRUG)_U_+DDRUG_U_PSJNM_U_$G(PSJORIEN)_U_"I"
 Q
IV0(PSJAD,PSIVIEN) ;Return ad/sol zero node
 ;PSJAD = "AD" is passed in if it additive, otherwise it's null
 I PSJAD="AD" Q $G(^PS(52.6,+$G(PSIVIEN),0))
 I $G(PSJAD)="" Q $G(^PS(52.7,+$G(PSIVIEN),0))
 Q ""
NODD(PSJCODE,PSJOIDF,PSJPON,PSJBASE) ;Set ^TMP for OI without a dispense drug
 ;PSJCODE - A numeric code to trigger the appropriate exception message 
 ;PSJOIDF - Orderable Item name_Dose form (can be CPRS OI)
 ;PSJPON - Pharmacy order #
 ;PSJBASE - Base subscript
 Q:$G(PSJOIDF)=""
 Q:$G(PSJBASE)=""
 Q:'+$G(PSJCODE)
 ;S PSJIV("OI_ERROR",PSJOIDF)=$G(PSJCODE)_U_$G(PSJPON)
 S ^TMP($J,PSJBASE,"IN","EXCEPTIONS","OI",PSJOIDF)=PSJCODE_U_$G(PSJPON)
 Q
