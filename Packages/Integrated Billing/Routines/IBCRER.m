IBCRER ;ALB/ARH - RATES: CM RC NATIONAL ENTER/EDIT OPTION ; 13-FEB-2007
 ;;2.0;INTEGRATED BILLING;**370**;21-MAR-94;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ; Enter/Edit Option: enter National Interim Reasonable Charges
 N IBI,IBX,IBXL,IBLN,IBEFF,IBTYPE S IBXL="",$P(IBXL,"-",80)=""
 ;
 W !,"Enter National Reasonable Charges:",!
 W !,"This option is used to enter the National Interim Reasonable Charges. "
 W !,"These non-site specific charges are provided when new CPT/HCPCS codes are"
 W !,"released as interim charges until the next full release of Reasonable Charges.",!
 W !,"Procedures and their charge data are entered then they will be added to the "
 W !,"appropriate charges sets for every division of Reasonable Charges defined "
 W !,"on your system.  Enter Professional Charges first.",!
 W !,"This option should ONLY be used to add the National Interim Reasonable Charges.",!
 ;
 F IBI=1:1 D  Q:IBLN<0  W !,IBXL,!
 . D CHGLN^IBCRER1(.IBEFF,.IBTYPE,.IBLN) Q:IBLN<1  W !
 . D DISPLN(IBLN) W !
 . I +$$ASKLN(IBLN) W ! D SAVELN(IBLN) W !
 ;
 Q
 ;
SAVELN(LN) ; Save charge to Charge Master (#363.2), identify Charge Set based on Type (I/P) and Indicators (I/S/O/F)
 ; freestanding sites will recieve any fs indicated charge as a professional charge regardless of charge type
 N IBTYP,IBBRTY,IBITM,IBEFF,IBMOD,IBCHGU,IBINCR,IBCHGI,IBINP,IBSNF,IBOPT,IBFS,IBCARE,IBCS,IBCS0,IBCSN,IBBR0,IBCNT
 ;
 S IBCNT=0 S IBTYP=$P($G(LN),U,4) I IBTYP="" W !,"Missing Charge Type, Not Saved" Q
 S IBBRTY=$S(IBTYP="I":"RC FACILITY",IBTYP="P":"RC PHYSICIAN",1:"") I IBBRTY="" W !,"Bad Bill Rate, Not Saved" Q
 ;
 S IBITM=+LN,IBEFF=+$P(LN,U,2),IBMOD=$P(LN,U,3),IBCHGU=+$P(LN,U,5),IBINCR=$P(LN,U,6),IBCHGI=$P(LN,U,7)
 S IBINP=+$P(LN,U,8),IBSNF=+$P(LN,U,9),IBOPT=+$P(LN,U,10),IBFS=+$P(LN,U,11)
 ;
 S IBCS=0 F  S IBCS=$O(^IBE(363.1,IBCS)) Q:'IBCS  D
 . S IBCS0=$G(^IBE(363.1,IBCS,0)),IBCSN=$P(IBCS0,U,1) I $E(IBCSN,1,3)'="RC-" Q
 . S IBCARE=$S(IBCSN["INPT ":"INP",IBCSN["SNF ":"SNF",IBCSN["OPT ":"OPT",IBCSN["FS ":"FS",1:"") Q:IBCARE=""
 . ;
 . S IBBR0=$G(^IBE(363.3,+$P(IBCS0,U,2),0))
 . I $P(IBBR0,U,1)'[IBBRTY,IBCARE'="FS" Q
 . I $P(IBBR0,U,4)'=2 Q
 . I IBINCR="PR",$P(IBBR0,U,5)'=1 Q
 . I IBINCR="ML",$P(IBBR0,U,5)'=4 Q
 . I IBINCR="MN",$P(IBBR0,U,5)'=5 Q
 . I IBINCR="HR",$P(IBBR0,U,5)'=6 Q
 . ;
 . I +IBFS,IBCARE="FS" D ADDCHG(IBCS,IBITM,IBEFF,IBCHGU,IBMOD,IBCHGI,LN) S IBCNT=IBCNT+1 Q
 . I +IBINP,IBCARE="INP" D ADDCHG(IBCS,IBITM,IBEFF,IBCHGU,IBMOD,IBCHGI,LN) S IBCNT=IBCNT+1 Q
 . I +IBSNF,IBCARE="SNF" D ADDCHG(IBCS,IBITM,IBEFF,IBCHGU,IBMOD,IBCHGI,LN) S IBCNT=IBCNT+1 Q
 . I +IBOPT,IBCARE="OPT" D ADDCHG(IBCS,IBITM,IBEFF,IBCHGU,IBMOD,IBCHGI,LN) S IBCNT=IBCNT+1 Q
 ;
 I 'IBCNT W !,"No Reasonable Charges set found for ",IBBRTY,$S(IBINCR="ML":" Ambulance",IBINCR="MN":" Anesthesia",IBINCR="HR":" Observation",1:""),", Charge Not Added."
 Q
 ;
ADDCHG(CS,ITM,EFF,CHG,MOD,CHGI,LN) ; Add charge to Charge Master
 N IBCI S CS=+$G(CS),ITM=+$G(ITM),EFF=+$G(EFF),CHG=+$G(CHG),MOD=$G(MOD),CHGI=$G(CHGI) Q:'CHG
 ;
 S IBCI=$$ITCHG^IBCRCI(CS,ITM,EFF,MOD)
 I +IBCI W !,"Active charge already exists ",$P($G(^IBE(363.1,CS,0)),U,1),", Charge Not Added." Q
 ;
 S IBCI=$$ADDCI^IBCREF(CS,ITM,EFF,CHG,,MOD,,CHGI)
 I +IBCI D DISPLN($P($G(LN),U,1,7)) W ?45,"added "_$P($G(^IBE(363.1,CS,0)),U,1)
 I 'IBCI D DISPLN($P($G(LN),U,1,7)) W ?45,"CHARGE NOT ADDED "_$P($G(^IBE(363.1,CS,0)),U,1)
 Q
 ;
ASKLN(LN) ; Ask user if charge should be saved
 ; Returns: 1 for save, 0 for no or invalid
 N IBX,DIR,DUOUT,DTOUT,DIRUT,X,Y S IBX=0
 I $G(LN)'="",$P(LN,U,8,11)'[1 W !,"No Sites Selected, Charge Not Added." Q 0
 S DIR("?")="Enter Yes to save the charge for all divisions, otherwise enter No."
 ;
 S DIR(0)="Y",DIR("A")="Save Charge for all Divisions",DIR("B")="No" D ^DIR I Y=1 S IBX=1
 I $D(DTOUT)!$D(DUOUT) S IBX=0
 Q IBX
 ;
DISPLN(LN) ; Print charge line
 ; string 'cpt ifn^eff dt^mod ifn^type (I/P)^charge^incr type (PR/ML/HR/MN)^incr charge^inpt^snf^opt^free'
 Q:$G(LN)=""
 W !,$P($$CPT^ICPTCOD(+LN),U,2),$S(+$P(LN,U,3):"-"_$P($$MOD^ICPTMOD(+$P(LN,U,3),"I"),U,2),1:"")
 W ?11,$$DATE(+$P(LN,U,2)),?21,$S($P(LN,U,4)="I":"Inst",1:"Prof"),?27,$J(+$P(LN,U,5),8,2)
 W $S(+$P(LN,U,7):"+"_$J(+$P(LN,U,7),0,2),1:""),$S($P(LN,U,6)="PR":"",1:$$LOW^XLFSTR($P(LN,U,6)))
 W ?47,$S(+$P(LN,U,8):"Inpt ",1:""),$S(+$P(LN,U,9):"SNF ",1:""),$S(+$P(LN,U,10):"Opt ",1:""),$S(+$P(LN,U,11):"FreeSt ",1:"")
 Q
 ;
DATE(X) ; returns VA date in external form
 N Y S Y="" I $G(X)?7N.E S Y=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 Q Y
