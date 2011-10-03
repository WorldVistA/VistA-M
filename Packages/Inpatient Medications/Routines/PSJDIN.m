PSJDIN ;BIR/MV - National Formulary Indicator Utility ;4 MAR 2000/ 4:27 PM
 ;;5.0; INPATIENT MEDICATIONS ;**50,56,76**;16 DEC 97
 ;
 ; Reference to ^PSSDIN is supported by DBIA# 3166.
 ; Reference to ^PS(52.6 is supported by DBIA# 1231.
 ; Reference to ^PS(52.7 is supported by DBIA# 2173.
 ; Reference to ^PS(50.7 is supported by DBIA# 2180.
 ; Reference tp ^PSDRUG is supported by DBIA# 2192.
 ;
DINIV(FIL,DRGTMP)      ;
 ;*Find the DD & OI IEN for the additive or solution
 ;*FIL:    52.6 or 52.7
 ;*DRGTMP: Additive or Solution's IEN
 ;
 NEW PSJDRG,PSJOI,PSJDD,PSJDIN,PSJINDEX
 S PSJDRG=$P(^PS(FIL,+DRGTMP,0),U,2),PSJOI=$P(^PS(FIL,+DRGTMP,0),U,11)
 D DIN(PSJOI,PSJDRG)
 Q
DIN(PSJOI,PSJDRG)       ;
 ;*This will issue the Restriction/guideline prompt for both OI & DD
 ;*PSJOI:   Orderable Item IEN
 ;*PSJDRG:   Dispense drug IEN
 ;
 NEW PSJDIN,PSJDD,PSJINDEX,Y,X,XIT
 D EN^PSSDIN(PSJOI,PSJDRG)
 Q:$O(^TMP("PSSDIN",$J,""))=""
 S PSJDIN=$$PROMPT^PSSDIN
 W:"DOY"[Y @IOF
 I PSJDIN="D"!(PSJDIN="Y") D  Q:XIT=U
 . W !!,"Dispense Drug Text:" W ! D TXD("DD") W !!
 I PSJDIN="O"!(PSJDIN="Y") D
 . W !!,"Orderable Item Text:" W ! D TXD("OI") W !!
 D PAUSE^VALM1,CLEAR^VALM1
 Q
TXD(N1) ;
 ;N1 = "OI" or "DD"
 ;DISPLAY OI/DD DRUG TEXT
 N N2,N3,N4,NX S XIT="",NX="PSSDIN"  ;
 S N2="" F  S N2=$O(^TMP(NX,$J,N1,N2)) Q:'N2!(XIT=U)  D
 .S N3="" F  S N3=$O(^TMP(NX,$J,N1,N2,N3)) Q:'N3!(XIT=U)  D
 ..S N4="" F  S N4=$O(^TMP(NX,$J,N1,N2,N3,N4)) Q:'N4!(XIT=U)  D
 ...W !?5,^TMP(NX,$J,N1,N2,N3,N4) I $Y>15 W ! D HLD S XIT=X
 Q
HLD ;
 W !
 ;K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR
 K DIR
 S DIR(0)="E",DIR("A")="Press Return to Continue or ""^"" to Exit: "
 D ^DIR K DIR
 W @IOF
 Q
NFIV(FIL,PSJIVIEN,PSJNF)        ;
 ;*Return N/F and msg display for ad/sol.
 ;*FIL:   "AD" or "SOL"
 ;*PSIVIEN: Additive or Solution's IEN
 ;*PSJNF:   0 node from file 50
 ;*PSJNF("NF"):  Only exist if it is a Non-formulary
 ;*PSJNF("MSG"): Return the message field to be displayed /w IV names
 ;
 S PSJNF=$G(^PSDRUG(+$P($G(^PS(FIL,+PSJIVIEN,0)),U,2),0))
 S PSJNF("NF")=$S($P(PSJNF,U,9)=1:" *N/F*",1:"")
 S PSJNF("MSG")=$P(PSJNF,U,10)
 Q
DINFLIV(DRG)   ;
 ;*This module will find all drug text that exist for the Orderable 
 ;*Items & dispense drugs associated with the Additive(s) & Solution(s)
 ;*within the IV order.  Once a drug text exist, return the <DIN> 
 ;*indicator to be displayed within the order view.
 ;
 ;*DRG:  Drug array from the IV order
 NEW PSJFIL,PSJND,PSJX,PSJFL
 F PSJFIL="AD","SOL" F PSJND=0:0 S PSJND=$O(DRG(PSJFIL,PSJND)) Q:'PSJND!$G(PSJFL)  D
 . S PSJX=$G(^PS($S(PSJFIL="AD":52.6,1:52.7),+DRG(PSJFIL,PSJND),0)) D EN^PSSDIN($P(PSJX,U,11),$P(PSJX,U,2))
 . I $O(^TMP("PSSDIN",$J,""))]"" S PSJFL=1 Q
 I '$G(PSJFL),$G(PSJORD)["P" S PSJFL=$$DINFLUD(+P("PD")),PSJFL=$S(PSJFL]"":1,1:0)
 K ^TMP("PSSDIN",$J)
 Q $S($G(PSJFL):" <DIN>",1:"")
 ;
DINFLUD(PSJOI,PSJDDA) ;
 ;*This module will find all drug text that exist for the Orderable 
 ;*items & dispense drugs associated with the unit dose order.  Once
 ;*a drug text exist, return the <DIN> indicator to be displayed with
 ;*the order view.
 ;*PSJOI:  Orderable IEN (Require)
 ;*PSJDDA: Dispense drug array within the order (Optional)
 ;
 NEW PSJFL,PSJDD
 D EN^PSSDIN(PSJOI) I $O(^TMP("PSSDIN",$J,"OI",0)) K ^TMP("PSSDIN",$J) Q "<DIN>"
 F PSJDD=0:0 S PSJDD=$O(PSJDDA(PSJDD)) Q:'PSJDD  D
 . D EN^PSSDIN(,PSJDD) I $O(^TMP("PSSDIN",$J,"DD",0)) S PSJFL=1 Q
 K ^TMP("PSSDIN",$J)
 Q $S($G(PSJFL):"<DIN>",1:"")
 ;
DINHIDE(PSJDFN,PSJORD) ;
 ;*Display drug text from the hidden action. 
 ;*PSJDFN: Patient IEN (Require)
 ;*PSJORD: Order #_"UVP" (Required)
 ;*DRG:    IV DRG array (Required for IV but Optional for UD orders)
 ;
 D:PSJORD["V" IV
 D:PSJORD["U" UD
 I PSJORD["P" D
 . D @($S($O(DRG("AD",0)):"IV",$O(DRG("SOL",0)):"IV",1:"UD"))
 I PSJORD="" D NEWUD
 K ^TMP("PSSDIN",$J)
 Q
IV ;
 ;NEW DRG,DRGI,DRGT,ND,ON55,Y
 ;D:PSJORD["P" GT531^PSIVORFA(DFN,PSJORD)
 ;I PSJORD["V" S ON55=PSJORD D GTDRG^PSIVORFB
 ;*Loop thru IV DRG array to find OI & DD IEN from each AD & SOL.
 ;
 NEW FIL,NAME,PSJDD,PSJNF,PSJOI,PSJX,Y,X,PSJXY
 D FULL^VALM1 W @IOF
 W !,"Drug restriction/guideline info:"
 F FIL="AD","SOL" F PSJX=0:0 S PSJX=$O(DRG(FIL,PSJX)) Q:'PSJX  D
 . NEW X
 . S PSJXY=1
 . SET NAME=$P(DRG(FIL,PSJX),U,2)
 . W !!,"IV "_$S(FIL="AD":"Additive",1:"Solution")_": "_NAME
 . D NFIV(FIL,+PSJX,.PSJNF) W $G(PSJNF("NF")),!
 . S X=$S(FIL="AD":$G(^PS(52.6,+DRG(FIL,PSJX),0)),1:$G(^PS(52.7,+DRG(FIL,PSJX),0)))
 . S PSJOI=$P(X,U,11),PSJDD=$P(X,U,2) D EN^PSSDIN(+PSJOI,+PSJDD)
 . D DINOI(PSJOI,3)
 . D DINDD(PSJDD,3)
 D:'$G(PSJXY) HLD
 K ^TMP("PSSDIN",$J)
 Q
UD ;
 ;*Loop thru Unit dose order for Orderable Item & Dispense drug
 ;
 NEW F,PSJDD,PSJDDX,PSJOI,PSJXY
 D FULL^VALM1 W @IOF
 W !,"Drug restriction/guideline info:"
 S F=$S(PSJORD["U":"^PS(55,PSJDFN,5,+PSJORD,",1:"^PS(53.1,+PSJORD,")
 S PSJOI=+@(F_".2)") D EN^PSSDIN(PSJOI),DINOI(PSJOI,3)
 ;*Loop thru dispense drug array
 F PSJDDX=0:0 S PSJDDX=$O(@(F_"1,"_PSJDDX_")")) Q:'PSJDDX  D
 . S PSJXY=1
 . S PSJDD=+@(F_"1,"_PSJDDX_",0)")
 . D EN^PSSDIN(PSJOI,PSJDD)
 . D DINDD(PSJDD,3)
 D:'$G(PSJXY) HLD
 K ^TMP("PSSDIN",$J)
 Q
NEWUD ;*New backdoor order doesn't have an order# yet.
 ;*Loop thru Orderable Item & Dispense drug
 ;
 NEW F,PSJDD,PSJDDX,PSJOI,PSJXY
 D FULL^VALM1 W @IOF
 W !,"Drug restriction/guideline info:"
 S PSJOI=+$G(PSGPD) D EN^PSSDIN(PSJOI),DINOI(PSJOI,3)
 ;*Loop thru dispense drug array
 F PSJDDX=0:0 S PSJDDX=$O(^PS(53.45,PSJSYSP,2,PSJDDX)) Q:'PSJDDX  D
 . S PSJXY=1
 . S PSJDD=+$G(^PS(53.45,PSJSYSP,2,PSJDDX,0))
 . D EN^PSSDIN(PSJOI,PSJDD)
 . D DINDD(PSJDD,3)
 D:'$G(PSJXY) HLD
 K ^TMP("PSSDIN",$J)
 Q
DINOI(PSJOI,COL)    ;
 ;*Display drug text for Orderable Item
 ;*OI:   Orderable Item IEN
 ;*COl:  Column to display the text in
 ;
 NEW X,XX
 W !!,?COL,"Orderable Item: "_$$OINAME^PSJLMUTL(PSJOI)_$$OINF(PSJOI),!
 I '$O(^TMP("PSSDIN",$J,"OI",PSJOI,0)) W !,?10,"No information available",! Q
 D TXD("OI") W !
 Q
DINDD(PSJDD,COL)        ;
 ;*Display drug text for Dispense drug
 ;*PSJDD:  Dispense drug IEN
 ;*COL:    Column to display the text in
 ;
 NEW X
 W !,?COL,"Dispense drug: "_$$DDNAME^PSJLMUTL(+PSJDD)_$$DDNF(PSJDD),!
 I '$O(^TMP("PSSDIN",$J,"DD",PSJDD,0)) W !?10,"No information available",! D HLD Q
 D TXD("DD"),HLD W @IOF
 Q
OINF(PSJOI)        ;
 ;*Return *N/F* if the orderable item is Non-formulary
 ;*PSJOI: Orderable item IEN
 ;
 Q $S($P($G(^PS(50.7,+PSJOI,0)),U,12)=1:" *N/F*",1:"")
 ;
DDNF(PSJDD)     ;
 ;**Return *N/F* if the dispense drug is Non-formulary
 ;*PSJDD: Dispense drug IEN
 ;
 Q $S($P($G(^PSDRUG(+PSJDD,0)),U,9)=1:" *N/F*",1:"")
        
  
   
       
  
         
