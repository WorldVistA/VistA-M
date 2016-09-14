PSJLMUT1 ;BIR/MLM - DRUG NAME DISPLAY ;05 Feb 98  1:39 PM
 ;;5.0;INPATIENT MEDICATIONS;**4,27,29,49,58,107,110,146,175,201,181,281**;16 DEC 97;Build 113
 ;
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ; Reference to ^PS(50.7 is supported by DBIA# 2180.
 ; Reference to ^PS(50.606 is supported by DBIA# 2174.
 ; Reference to EN^PSODRDU2 is supported by DBIA# 2189.
 ; Reference to ^PSDRUG( is supported by DBIA 2192.
 ;
DRGDISP(DFN,ON,NL,GL,NAME,DRUGONLY)       ;
 ;; DRUGONLY = 1/0 - Only the drug name will be returned.
 ;; NL       = The drug name display length
 ;; GL       = The give line display length, total length-6 ("Give: ")
 ;; NAME(X)  = Drug name and give line in displayable format.
 ;; ON       = IEN#_U/P (U=Unit Dose; P=Pending)
 ;
 NEW F,OIND,MARX,MR,NOTGV,SCH,PSGUPDDO,PSGGV,X,PSGX,PSGINS,DRUGNAME
 K NAME S PSGINS=""
 S:ON["U" F="^PS(55,DFN,5,+ON,"
 I ON["P" S F="^PS(53.1,+ON,",X=$G(@(F_".3)")),PSGINS=$S(X]"":X,1:"")
 I $G(@(F_"0)"))="" S NAME(1)="NOT FOUND" Q
 S OIND=$G(@(F_".2)")),PSGUPDDO=$P(OIND,U,2),X=@(F_"0)"),NOTGV=$P(X,U,22),MR=$$ENMRN^PSGMI(+$P(X,U,3))
 I '+OIND,($P(X,U,4)'="U") NEW DRG D GTDRG^PSIVORFA F X="AD","SOL" Q:+OIND  F PSGX=0:0 S PSGX=$O(DRG(X,PSGX)) Q:'PSGX  S OIND=$P(DRG(X,PSGX),U,6) Q:+OIND
 S SCH=$P($G(@(F_"2)")),U)
 I +$O(@(F_"1,0)")),'+$O(@(F_"1,1)")),PSGUPDDO="" D DD(F,.DRUGNAME)
 S:($G(DRUGNAME)=""!($G(DRUGNAME)["NOT FOUND")) DRUGNAME=$$OIDF(OIND)
 ;S PSGGV=$S(NOTGV:"*** NOT TO BE GIVEN *** ",1:"")_PSGINS_PSGUPDDO_" "_MR_" "_SCH
 S PSGGV=$S(NOTGV:"*** NOT TO BE GIVEN *** ",1:"")_$S(('$D(PSJPDDDP)&('$L(PSGUPDDO))):PSGINS,1:PSGUPDDO)_" "_MR_" "_SCH
 S PSGX=0 K PSJPDDDP
 D TXT^PSGMUTL(DRUGNAME,NL) F X=0:0 S X=$O(MARX(X)) Q:'X  S NAME(X)=$S(X>1:"  ",1:"")_MARX(X),PSGX=X
 Q:+DRUGONLY
 D TXT^PSGMUTL(PSGGV,GL) F X=0:0 S X=$O(MARX(X)) Q:'X  D
 . I X=1 S NAME(PSGX+X)="Give: "_MARX(X) Q
 . S NAME(PSGX+X)=$S(X>1:"      ",1:"")_MARX(X)
 Q
OIDF(OIND)    ; Return Orderable Item name and Dosage form.
 ;; +OIND = orderable item IEN
 NEW X,NAME
 S X=$G(^PS(50.7,+OIND,0))
 S:$P(X,U)]"" NAME=$P(X,U)_" "_$P($G(^PS(50.606,+$P(X,U,2),0)),U)
 Q $S($G(NAME)]"":NAME,1:"NOT FOUND "_+OIND_";PS(50.7")
 ;
DD(F,NAME)        ; Return Dispense drug name.
 ;; F = "^PS(55,DFN,5,+ON," or "^PS(53.1,+ON,"
 NEW X K NAME
 S X=$O(@(F_"1,0)")),X=$G(@(F_"1,"_+X_",0)"))
 I $P(X,U)]"" S NAME=$P($G(^PSDRUG(+X,0)),U)
 E  S NAME="NOT FOUND "_+X_";PSDRUG"
 I '$O(@(F_"1,1)")),+$P(X,U,2)>1 S PSGUPDDO=+$P(X,U,2)
 S PSJPDDDP=1
 Q
DSPLORDU(PSGP,ON)   ; Display UD order for order check as in the Inpat Profile.
 NEW DRUGNAME,F,NODE0,NODE2,PSJID,PSJX,SCH,SD,STAT,X,Y
 S F=$S(ON["U":"^PS(55,PSGP,5,"_+ON_",",1:"^PS(53.1,"_+ON_",")
 S NODE0=$G(@(F_"0)")),NODE2=$G(@(F_"2)"))
 D DRGDISP^PSJLMUT1(PSGP,ON,39,54,.DRUGNAME,0)
 I ON["P",$P(NODE0,U,4)="F" D DSPLORDV(PSGP,ON) Q
 S SCH=$P(NODE0,U,7)
 S STAT=$P(NODE0,U,9) I STAT="A",$P(NODE0,U,27)="R" S STAT="R"
 I STAT'="P" S PSJID=$E($$ENDTC^PSGMI($P(NODE2,U,2)),1,5),SD=$E($$ENDTC^PSGMI($P(NODE2,U,4)),1,5)
 I STAT="P" S (PSJID,SD)="*****",SCH="?"
 F PSJX=0:0 S PSJX=$O(DRUGNAME(PSJX)) Q:'PSJX  D
 . S:PSJX=1 X=SCH_"  "_PSJID_"  "_SD_"  "_$E(STAT,1)
 . S:PSJX=1 DRUGNAME(1)=$$SETSTR^VALM1(X,$E(DRUGNAME(1),1,40),42,20)
 . S PSJOC(ON,PSJLINE)="        "_DRUGNAME(PSJX)
 . S PSJLINE=PSJLINE+1
 Q
DSPLORDV(DFN,ON)   ; Display IV order for order check as in the Inpat Profile.
 N DRG,DRGI,DRGT,DRGX,FIL,ND,ON55,P,PSJIVFLG,PSJORIFN,TYP,X,Y,COMPDRG
 S TYP="?" I ON["V" D
 .S Y=$G(^PS(55,DFN,"IV",+ON,0)) F X=2,3,4,5,8,9,17,23 S P(X)=$P(Y,U,X)
 .S TYP=$$ONE^PSJBCMA(DFN,ON,P(9),P(2),P(3)) I TYP'="O" S TYP="C"
 .S ON55=ON,P("OT")=$S(P(4)="A":"F",P(4)="H":"H",1:"I") D GTDRG^PSIVORFB,GTOT^PSIVUTL(P(4))
 S PSJCT=0,PSJL=""
 I ON'["V" S (P(2),P(3))="",P(17)=$P($G(^PS(53.1,+ON,0)),U,9),Y=$G(^(8)),P(4)=$P(Y,U),P(8)=$P(Y,U,5),P(9)=$P($G(^(2)),U) D GTDRG^PSIVORFA,GTOT^PSIVUTL(P(4))
 S PSJIVFLG=1 D PIVAD,SOL
 Q
SOL ;
 S PSJL=$S($G(PSJIVFLG):PSJL,1:"")_"         in"
 S DRG=0 F  S DRG=+$O(DRG("SOL",DRG)) Q:'DRG  D NAME^PSIVUTL(DRG("SOL",DRG),37,.NAME,0) S DRGX=0 F  S DRGX=$O(NAME(DRGX)) Q:'DRGX  D
 .S COMPDRG="",COMPDRG=$P(DRG("SOL",DRG),"^",2)_" "_$P(DRG("SOL",DRG),"^",3)
 .I PSJL["   in" D
 ..I $D(PSJP(2)),COMPDRG=PSJP(2) S NAME(DRGX)="*"_NAME(DRGX) Q
 ..I $D(PSJOCDT(10,COMPDRG))!($D(PSJOCDT(20,COMPDRG))) D  Q  ;PSJ*5*281 - identify the interacting drugs with an *
 ...S NAME(DRGX)="*"_NAME(DRGX) Q
 .I PSJL'["   in" S NAME(DRGX)=NAME(DRGX)
 .S PSJL=$$SETSTR^VALM1(NAME(DRGX),PSJL,13,60) D:$G(PSJIVFLG) PIV1 D SETTMP S PSJL="       "
 Q
PIVAD ; Print IV Additives.
 F DRG=0:0 S DRG=$O(DRG("AD",DRG)) Q:'DRG  D NAME^PSIVUTL(DRG("AD",DRG),39,.NAME,1) F DRGX=0:0 S DRGX=$O(NAME(DRGX)) Q:'DRGX  D
 .D  ;PSJ*5*281 - identify the interacting drugs with an *
 ..I $D(PSJP(2)),NAME(DRGX)=PSJP(2) S NAME(DRGX)="*"_NAME(DRGX) Q
 ..I $D(PSJOCDT(10,NAME(DRGX)))!($D(PSJOCDT(20,NAME(DRGX)))) S NAME(DRGX)="*"_NAME(DRGX) Q
 ..S NAME(DRGX)=" "_NAME(DRGX)
 .S PSJL=$$SETSTR^VALM1(NAME(DRGX),PSJL,9,60) D:$G(PSJIVFLG) PIV1 D SETTMP
 Q
 ;
PIV1 ; Print Sched type, start/stop dates, and status.
 K PSJIVFLG
 F X=2,3 S P(X)=$E($$ENDTC^PSGMI(P(X)),1,$S($D(PSJEXTP):8,1:5))
 I '$D(PSJEXTP) S PSJL=$$SETSTR^VALM1(TYP,PSJL,50,1),PSJL=$$SETSTR^VALM1(P(2),PSJL,53,7),PSJL=$$SETSTR^VALM1(P(3),PSJL,60,7),PSJL=$$SETSTR^VALM1(P(17),PSJL,67,1)
 E  S PSJL=$$SETSTR^VALM1(TYP,PSJL,50,1),PSJL=$$SETSTR^VALM1(P(2),53,7),PSJL=$$SETSTR^VALM1(P(3),PSJL,63,7),PSJL=$$SETSTR^VALM1(P(17),PSJL,73,1)
 Q
SETTMP ;
 S PSJOC(ON,PSJLINE)=PSJL,PSJLINE=PSJLINE+1
 Q
ORDCHK(DFN,TYPE,PIECE)   ;
 ;TYPE ="DD" - Duplicate drug
 ;     ="DC" - Duplicate class
 ;     -"DI" - Drug Interaction
 ;PIECE = The piece order number is return from ^TMP($J,"DD"...
 ;PSJOC(ON,x) = Array of inpatient orders to be displayed
 ;
 NEW ON,PSJL,PSIVX,PSJOC,PSJORIEN,PSJPACK,PSJLINE
 S PSJOC=0,PSJLINE=1
 F PSIVX=0:0 S PSIVX=$O(^TMP($J,TYPE,PSIVX)) Q:'PSIVX  D
 . S PSJPACK=$P(^TMP($J,TYPE,PSIVX,0),U,PIECE)
 . I $G(PSGORD) S PSJORD=PSGORD ; Set PSJORD if PSGORD exists and is not Null
 . I $G(PSJORD)]"" I $S($D(PSJORD):$G(PSJORD),1:$G(PSGORD))'["V",$P(PSJPACK,";")=$S($D(PSJORD):$G(PSJORD),1:$G(PSGORD)) Q  ; don't flag order that is being renewed as duplicate, only checks Unit Dose orders
 . I $G(PSJCOM),($G(PSJORD)["P") Q:$D(^PS(53.1,"ACX",PSJCOM,+PSJPACK))
 . ; Don't flag if pending renewal from CPRS
 . I $G(PSJORD)]"",(PSJORD["P"),($P($G(^PS(53.1,+PSJORD,0)),"^",24)="R"),($P(PSJPACK,";")["U"),($P($G(^PS(55,DFN,5,+$P(PSJPACK,";"),0)),"^",27)="R"),($P($G(^PS(55,DFN,5,+$P(PSJPACK,";"),0)),"^",26)=PSJORD) Q
 . I $G(PSIVRNFG),$G(ON55)["V",$P(PSJPACK,";")=$G(ON55) Q  ;PSIVRNFG set and kill in R+2^PSIVOPT2. Needed to do dupl. check on new order but not renew.
 . S PSJORIEN=$P(^TMP($J,TYPE,PSIVX,0),U,PIECE-1)
 . I TYPE="DI",($P(^TMP($J,TYPE,PSIVX,0),U,4)="CRITICAL") S PSJIREQ=1
 . ; Adding Drug Interactions check for use in Intervention defaults in PSJRXI.
 . I TYPE="DI" S PSJRXREQ=$S($P(^TMP($J,TYPE,PSIVX,0),U,4)="CRITICAL":"CRITICAL DRUG INTERACTION",1:"SIGNIFICANT DRUG INTERACTION")
 . ;I $P(PSJPACK,";",2)["O" D  Q
 . N X S X=$P(PSJPACK,";",2) I X["O" D  Q
 ..  D:PSJFST=1 PAUSE
 ..  W !!,"The patient has this "_$S($P(PSJPACK,";")["N":"Non-VA Meds",$P(PSJPACK,";",2)["O":"Outpatient",1:"")_" order:",!
 ..  I $D(^TMP($J,TYPE,PSIVX,1)) D SHOR^PSJLMUT2(TYPE,PSIVX),PAUSE S PSJFST=$S(PSJFST=0:PSJFST+2,1:PSJFST+1) Q
 ..  D EN^PSODRDU2(DFN,PSJPACK,"PSJPRE"),PAUSE S PSJPDRG=1,PSJFST=$S(PSJFST=0:PSJFST+2,1:PSJFST+1)
 . S ON=$P(PSJPACK,";") Q:$D(PSJOC(ON))
 . I ON=$G(PSIVOCON),+PSJORIEN Q
 . I ON=$G(PSIVOCON),'+PSJORIEN D SETPSJOC Q
 . ;S PSJOC=PSJOC+1,PSJPDRG=1 D:PSJOC=1 WRITE(TYPE)
 . I ON["V" D
 .. I '$O(^PS(55,DFN,"IV",+ON,0)) D SETPSJOC Q
 .. D DSPLORDV(DFN,ON) S PSJOC=PSJOC+1
 . I ON'["V" D DSPLORDU(DFN,ON) S PSJOC=PSJOC+1
 . S PSJOC(ON,PSJLINE)="",PSJLINE=PSJLINE+1
 D:PSJOC WRITE(TYPE)
 S ON="" F  S ON=$O(PSJOC(ON)) Q:ON=""  W ! S PSJLINE=PSJLINE+1,PSJFST=PSJFST+1 D
 . F PSIVX=0:0 S PSIVX=$O(PSJOC(ON,PSIVX)) Q:'PSIVX  W !,PSJOC(ON,PSIVX) S PSJLINE=PSJLINE+1 D:'(PSIVX#6) PAUSE
 W !
 Q
SETPSJOC ;Set PSJOC array to be displayed later
 NEW PIECE S PIECE=$S(TYPE="DC":4,1:2)
 S X=$$SETSTR^VALM1($P(^TMP($J,TYPE,PSIVX,0),U,PIECE),"",9,40)
 S X=$$SETSTR^VALM1("* EXISTS IN CURRENT ORDER *",X,50,27)
 S PSJOC(ON,PSJLINE)=X,PSJLINE=PSJLINE+1,PSJOC=PSJOC+1
 Q
WRITE(TYPE)        ;Display order check description
 S PSJPDRG=1
 I TYPE="DD" W !!,"This patient is already receiving the following order",$S(PSJOC>1:"s",1:"")," for ",$S($G(PSJDD)]"":$P($G(^PSDRUG(PSJDD,0)),U),1:"this drug"),":",!
 I TYPE="DC" W !!,"This patient is already receiving ",$S(PSJOC>1:"orders",1:"an order")," for the following drug",$S(PSJOC>1:"s",1:"")," in the same",!,"class as ",$S($G(PSJDD)]"":$P($G(^PSDRUG(PSJDD,0)),U),1:"the drug selected"),":",!
 I TYPE="DI" W !!,"This patient is receiving the following medication",$S(PSJOC>1:"s",1:"")," that ha",$S(PSJOC>1:"ve",1:"s")," an interaction",!,"with ",$P($G(^PSDRUG(PSJDD,0)),U),":",!
 Q
PAUSE ;
 K DIR W ! S DIR(0)="EA",DIR("A")="Press Return to continue...",DIR("?")="Press Return to continue..." D ^DIR W !
 Q
