PSJLIFN ;BIR/MV-IV FINISH USING LM ;13 Jan 98 / 11:32 AM
 ;;5.0;INPATIENT MEDICATIONS ;**1,29,34,37,42,47,50,56,94,80,116,110,181,261,252,313,333**;16 DEC 97;Build 2
 ;
 ; Reference to ^PS(51.2 is supported by DBIA #2178.
 ; Reference to ^PS(52.6 supported by DBIA #1231.
 ; Reference to ^PS(52.7 supported by DBIA #2173.
 ; Reference to ^PSDRUG( is supported by DBIA #2192.
 ; Reference to ^PSOORDRG is supported by DBIA #2190.
 ; Reference to ^%DT is supported by DBIA #10003.
 ; Reference to ^VALM is supported by DBIA #10118.
 ; Reference to ^VALM1 is supported by DBIA #10116.
 ; Reference to RE^VALM4 is supported by DBIA #10120.
 ;
EN ; Display order with numbers.
 L +^PS(53.1,+PSJORD):1 I '$T W !,$C(7),$C(7),"This order is being edited by another user. Try later." D PAUSE^VALM1 Q
 NEW PSJOCFG
 S PSJOCFG="FN IV"
 D PENDING K PSJREN,PSJOCFG
 L -^PS(53.1,+PSJORD)
 Q
PENDING ; Process pending order.
 ;* PSIVFN1 is used so it will display the AC/Edit screen
 ;* instead of go to the "IS this O.K." prompt
 ;* PSIVACEP only when accept the order. Original screen won't redisp.
 ;* PSJLMX is defined in WRTDRG^PSIVUTL and it was being call in PSJLIVMD & PSJLIVFD
 ;*        to count # of AD/SOL 
 NEW PSIVFN1,PSIVACEP,PSJLMX,PSIVOI,PSJOCCHK,PSJFNDS
 K PSJIVBD ;This variable was left over from the new backdoor order entry.
 ; PSJOCCHK is set so if EDIT was use instead of FN to finish order the OC is triggered
 S PSJOCCHK=1
 ;* PSJFNDS is set so dosing is trigger during finishing without changes to the add/sol
 S PSJFNDS=1
 S PSIVAC="CF" S (P("PON"),ON)=+PSJORD_"P",DFN=PSGP
 S PSIVUP=+$$GTPCI^PSIVUTL D GT531^PSIVORFA(DFN,ON)
 D:'$D(P("OT")) GTOT^PSIVUTL(P(4))
 NEW PSJL
 N PSIVNUM,PSJSTAR S PSIVNUM=1
 Q:ON'=PSJORD
 I $G(PSJLYN)]"" Q:ON'=PSJLYN
 S PSJMAI=ON
 I P("OT")="I" D  Q
 . S PSJSTAR="(5)^(7)^(9)^(10)"
 . D EN^VALM("PSJ LM IV INPT PENDING") ;; ^PSJLIVMD
 S PSJSTAR="(1)^(2)^(3)^(5)^(7)^(9)"
 D GTDATA D EN^VALM("PSJ LM IV PENDING") ;; ^PSJLIVFD
 K PSJMAI Q
 ;
DISPLAY ;
 S PSGACT=""
 S VALMSG="Press Return to continue"
 D:$E(P("OT"))="I" EN^VALM("PSJ LM IV INPT DISPLAY")
 D:$E(P("OT"))'="I" EN^VALM("PSJ LM IV DISPLAY")
 K PSJDISP
 S:'$G(PSJHIS) VALMBCK=""
 Q
GTDATA ;
 ;* D:P(4)="" 53^PSIVORC1 Q:P(4)=""  S P("DTYP")=$S(P(4)="":0,P(4)="P"!(P(23)="P")!(P(5)):1,P(4)="H":2,1:3)
 S P("DTYP")=$S(P(4)="":0,P(4)="P"!(P(23)="P")!(P(5)):1,P(4)="H":2,1:3)
 I 'P(2) D
 .I P("RES")="R" S PSJREN=1
 .D ENT^PSIVCAL K %DT S X=P(2),%DT="RTX" D ^%DT S P(2)=+Y
 I 'P(3) D ENSTOP^PSIVCAL K %DT S X=P(3),%DT="RTX" D ^%DT S P(3)=+Y
 I 'P("MR") S P("MR")=$O(^PS(51.2,"B","INTRAVENOUS",0))_"^IV"
 Q
FINISH ; Prompt for missing data
 ;* Ord chk for Inpat. pending only. Pend renew should not be checked.
 ;* PSIVOCON needed so this order will be excluded from the order
 ;*          list(ORDCHK^PSJLMUT1)
 ;* PSGORQF defined means cancel the order due to order check.
 ;Q:'$$LS^PSSLOCK(DFN,PSJORD)
 N PSJCOM,PSIVEDIT
 S PSJCOM=+$P($G(^PS(53.1,+PSJORD,.2)),"^",8)
 K PSJIVBD,PSGRDTX,PSIVEDIT
 N FIL,PSIVS,DRGOC,PSIVXD,DRGTMP,PSIVOCON,PSGORQF,ON55,NSFF K PSGORQF S NSFF=1
 S (ON,PSIVOCON,ON55,PSGORD)=PSJORD D GTDRG^PSIVORFA Q:PSJORD'=PSJMAI  I $G(PSJLYN)]"" Q:PSJORD'=PSJLYN
 D UDVARS^PSJLIORD
 I $G(PSJPROT)=3,'$$ENIVUD^PSGOEF1(PSJORD) K NSFF Q
 D HOLDHDR^PSJOE
 ;PRE UAT group requested to not show the second screen since FDB OC has more text and provider override reason appears after 2nd screen 
 ; force the display of the second screen if CPRS order checks exist
 ;I $O(^PS(53.1,+PSJORD,12,0))!$O(^PS(53.1,+PSJORD,10,0)) D
 ;.Q:$G(PSJLMX)=1   ;no second screen to display
 ;.S VALMBG=16 D RE^VALM4,PAUSE^VALM1 S VALMBG=1
 S P("OPI")=$$ENPC^PSJUTL("V",+PSIVUP,60,P("OPI"))
 ;I $E(P("OT"))="I" D GTDATA Q:P(4)=""
 ;I $E(P("OT"))="I",'$D(DRG("AD")),('$D(DRG("SOL"))) D
 I $G(P("RES"))'="R" D 53^PSIVORC1
 I $G(P(4))]"",$G(P(15))]"",$G(P(9))]"",$$SCHREQ^PSJLIVFD(.P) D
 . N PSGS0XT,X,PSJNSS S PSJNSS=1,X=P(9),PSGS0XT=P(15) D Q2^PSGS0
 I P(4)="" D RE^VALM4 Q
 I $E(P("OT"))="I" D GTDATA  D
 . I '$D(DRG("AD")),('$D(DRG("SOL"))) S DNE=0 D GTIVDRG^PSIVORC2 S P(3)="" D ENSTOP^PSIVCAL
 S VALMBG=1
 I $E(P("OT"))="F" S DNE=0 I $G(PSGORQF) D RE^VALM4 Q
 I $G(PSGORQF) S VALMBCK="R",P(4)="" K DRG Q
 ;
 ; Will prompt users to choose Dispense IV Additive when more than one are available for the Orderable Item
 N PSJQUIT S PSJQUIT=0 D MULTADDS I $G(PSJQUIT) S VALMBCK="R" Q
 ;
 S PSIVEDIT=""
 S PSIVOK="1^3^10^25^26^39^57^58^59^63^64" D CKFLDS^PSIVORC1 I EDIT]"" D EDIT^PSIVEDT
 ;S PSIVOK="1^3^10^25^26^39^57^58^59^63^64" D CKFLDS^PSIVORC1 I EDIT]"" S PSIVEDIT=EDIT D EDIT^PSIVEDT
 ;I $G(EDIT)="" D OC^PSIVOC D:'$G(PSGORQF) IN^PSJOCDS($G(ON),"IV","") Q:$G(PSGORQF)
 I $D(PSIVEDIT) D OC^PSIVOC
 ;PSJ*5*261 - Remedy #490875 PSPO 2040 
 D ENSTOP^PSIVCAL
 ;D:'$G(PSGORQF) IN^PSJOCDS($G(ON),"IV","")
  ;If quit then restore DRG( to pre-edit state
 I $G(PSGORQF) D GT531^PSIVORFA(DFN,ON) Q
 I $G(DONE) S VALMBCK="R" Q
 ;* PSJFNDS is set so dosing is trigger during finishing without changes to the add/sol
 ;S PSJFNDS=1
 D COMPLTE^PSIVORC1
 S:$G(PSIVACEP) VALMBCK="Q"
 ;Reset PSJFNDS so if FN again, the dosing check is triggered.
 S:'$G(PSIVACEP) PSJFNDS=1
 I $G(PSGORQF) S VALMBG=1 D RE^VALM4
 K NSFF
 Q
 ;
MULTADDS ; If there are multiple IV Additives per Orderable Item, it will prompt for selection
 N TMPDRG
 S PSJQUIT=0
 I $O(DRG("AD",0)) D  I PSJQUIT D SAVEDRG^PSIVEDRG(.DRG,.TMPDRG) Q
 . D SAVEDRG^PSIVEDRG(.TMPDRG,.DRG)
 . N PSIDX,OI,IVLIST
 . F PSIDX=1:1 Q:'$D(DRG("AD",PSIDX))  D  I PSJQUIT Q
 . . S OI=$P(DRG("AD",PSIDX),"^",6) I 'OI Q
 . . K IVLIST D IVADDCNT(OI,.IVLIST) I $O(IVLIST(""),-1)'>1 Q
 . . W !!,"More than one dispense IV Additives are available for:"
 . . W !,"Orderable Item: ",$$GET1^DIQ(50.7,OI,.01)
 . . W !,"  Ordered Dose: ",$P(DRG("AD",PSIDX),"^",3)
 . . W !!,"Please select the correct dispense IV Additive below for this order:"
 . . N DIR,IVADD,IVCNT,X,Y,DIRUT,DUOUT
 . . S DIR("?")="Please select the correct dispense IV Additive below for this order:"
 . . F IVCNT=1:1 Q:'$D(IVLIST(IVCNT))  D  I PSJQUIT Q
 . . . S IVADD=IVLIST(IVCNT)
 . . . S X="  "_IVCNT_"  "_$$GET1^DIQ(52.6,IVADD,.01)
 . . . S $E(X,45)="Additive Strength: "_$S($$GET1^DIQ(52.6,IVADD,19)'="":$$GET1^DIQ(52.6,IVADD,19)_" "_$$GET1^DIQ(52.6,IVADD,2),1:"N/A")
 . . . S DIR("A",IVCNT)=X
 . . S DIR("A")="Select (1 - "_(IVCNT-1)_"): "
 . . S DIR(0)="LA^1:"_(IVCNT-1) D ^DIR I $D(DUOUT)!$D(DIRUT) S PSJQUIT=1 Q
 . . I (Y>0) D
 . . . S $P(DRG("AD",PSIDX),"^",1,2)=+IVLIST(+Y)_"^"_$$GET1^DIQ(52.6,+IVLIST(+Y),.01)
 . W !
 Q
 ;
ORDCHK ;* Do order check for Inpatient Meds IV.
 ; PSGORQF is defined (CONT^PSGSICHK) if not log an intervention
 ; No longer use after PSJ*5*181
 K PSGORQF
 Q
 ;NEW DRGOC
 ;D OCORD Q:$G(PSGORQF) 
 ;D GTIVDRG^PSIVORC2 S P(3)="" D ENSTOP^PSIVCAL
ORDCHKA ;* Do order check against existing orders on the profile
 ;No longer use as of PSJ*5*181
 Q
 F PSIVAS="AD","SOL" Q:$G(PSGORQF)  S FIL=$S(PSIVAS="AD":52.6,1:52.7) D
 . F PSIVX=0:0 S PSIVX=$O(DRG(PSIVAS,PSIVX)) Q:'PSIVX!($G(PSGORQF))  D
 .. S DRGTMP=DRG(PSIVAS,PSIVX)
 .. ;* Do only 1 duplicate warning when order has >1 of the same additive
 .. Q:$D(PSJADTMP(+DRGTMP))
 .. D ORDERCHK^PSIVEDRG(PSGP,ON,$D(DRGOC(ON)))
 .. S DRGOC(ON,PSIVAS,PSIVX)=DRG(PSIVAS,PSIVX)
 .. S PSJADTMP(+DRGTMP)=""
 K PSJADTMP
 Q
OCORD ;* Do order check for each drug against the drugs within the order.
 ;OCORD was called by ORDCHK.  This entry point is no longer use as of PSJ*5*181
 Q
 NEW X,Y,DDRUG,PSIVX,PSJAD,PSJSOL,TMPDRG
 D SAVEDRG^PSIVEDRG(.TMPDRG,.DRG)
 ; Find the corresponding DD for the additive within the order
 F X=0:0 S X=$O(DRG("AD",X)) Q:'X  D
 . S DDRUG=$P($G(^PS(52.6,+DRG("AD",X),0)),U,2)
 . S:+DDRUG (DDRUG(DDRUG),PSJAD(DDRUG))=$D(DDRUG(DDRUG))+1
 ;
 ; Find the corresponding DD for the solution
 ;
 F X=0:0 S X=$O(DRG("SOL",X)) Q:'X  D
 . S DDRUG=$P($G(^PS(52.7,+DRG("SOL",X),0)),U,2)
 . S:+DDRUG (DDRUG(DDRUG),PSJSOL(DDRUG))=$D(DDRUG(DDRUG))+1
 ;
 ; Loop thru each additive to check for DD,DI & DC against the
 ; order's dispense drugs
 ;
 NEW PSJDFN,INTERVEN S INTERVEN=""
 S PSJDFN=DFN ;DFN will be killed when call ^PSOORDRG
 F PSIVX=0:0 S PSIVX=$O(PSJAD(PSIVX)) Q:'PSIVX  D
 . K DDRUG(PSIVX) D DRGCHK^PSOORDRG(PSJDFN,PSIVX,.DDRUG)
 . I PSJAD(PSIVX)>1 S ^TMP($J,"DD",1,0)=PSIVX_U_$P($G(^PSDRUG(PSIVX,0)),U)_"^^"_ON_";I"
 . NEW TYPE F TYPE="DD","DI","DC" D ORDCHK^PSJLIFNI(PSJDFN,TYPE)
 F PSIVX=0:0 S PSIVX=$O(PSJSOL(PSIVX)) Q:'PSIVX  D
 . K DDRUG(PSIVX) D DRGCHK^PSOORDRG(PSJDFN,PSIVX,.DDRUG)
 . NEW TYPE F TYPE="DI" D ORDCHK^PSJLIFNI(PSJDFN,TYPE)
 S DFN=PSJDFN
 D SAVEDRG^PSIVEDRG(.DRG,.TMPDRG)
 Q
 ;
IVADDCNT(OI,IVLIST) ; Returns the number of IV Addtives Associated to the OI and Marked for IV Order Dialog
 ;Input: OI - PHARMACY ORDERABLE ITEM file (#50.7) IEN
 ;Output: $$IVADDCNT - Number of IV Additives linked to the Orderable Item
 ;        IVLIST(IV_IEN) - List of IV Additives linked to the Orderable Item
 N IVADD,IVADDCNT
 S IVADDCNT=0,IVADD=""
 F  S IVADD=$O(^PS(52.6,"AOI",OI,IVADD)) Q:'IVADD  D
 . ; Not Used in the IV Order Dialog
 . I '$$GET1^DIQ(52.6,IVADD,17,"I") Q
 . ; Other IV Solution is INACTIVE
 . I $$GET1^DIQ(52.6,IVADD,12,"I"),($$GET1^DIQ(52.6,IVADD,12,"I")'>DT) Q
 . ; Other IV Dispense Drug
 . S IVADDCNT=IVADDCNT+1,IVLIST(IVADDCNT)=IVADD
 Q
