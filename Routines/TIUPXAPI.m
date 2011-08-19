TIUPXAPI ; SLC/JER - Interface w/PCE/Visit Tracking ;5/8/03@10:26
 ;;1.0;TEXT INTEGRATION UTILITIES;**15,24,29,82,107,126,161**;Jun 20, 1997
CREDIT(DFN,TIU,VSIT) ; Get Dx, CPT, (& SC) for the CMD's mandate
 N CPT,ICD,ICDARR,CPTARR,SC,DTOUT,TIUOK,TIUPRLST
 ; For Historical Visits, just QUEUE the PXAPI call and quit
 I $P(TIU("VSTR"),";",3)="E" D QUE^TIUPXAP1 Q
 ; If no Location, and not Historical Visit, then quit
 Q:+$G(TIU("VSTR"))'>0
REENTER I $G(VALMAR)="^TMP(""TIUR"",$J)",$D(TIU("PNM")) D
 . W !!,"For ",$G(TIU("PNM"))," ",$G(TIU("PID"))," Visit on "
 . W $P($G(TIU("EDT")),U,2),"..."
 D PROVLIST(.TIUPRLST)
 N TIUVDT S TIUVDT=$P($G(TIU("VSTR")),";",2)
 ; *161 Pass encounter date to GETICD as 3rd and 4th variable, then to IBDF18A
 D GETICD(TIU("LOC"),.ICDARR,TIUVDT)
ICDCALL D ICD(.ICD,.ICDARR,TIUVDT) G:+$G(DTOUT) INSUFF ; **15**
 I '$D(ICD),'$D(DTOUT) W !!,$C(7),"You MUST enter one or more Diagnoses." H 3 G ICDCALL
 K ICDARR ; **15**
 ; Pass encounter date to TIUPXAPC to pass to IBDF18A **161**
 D GETCPT^TIUPXAPC(TIU("LOC"),.CPTARR,TIUVDT)
 ; Pass encounter date to TIUPXAPC,ICPTCOD,TIUPXAPM for CSV **161**
CPTCALL D CPT^TIUPXAPC(.CPT,.CPTARR,TIUVDT) G:+$G(DTOUT) INSUFF
 I '$D(CPT),'$D(DTOUT) W !!,$C(7),"You MUST enter one or more Procedures." H 3 G CPTCALL
 K CPTARR ; **15**
 D SCASK^TIUPXAPS(.SC,+DFN,.TIU)
INSUFF I $D(DTOUT)!(+$O(ICD(0))'>0)&(+$O(CPT(0))'>0)&(+$O(SC(0))'>0) D  G POST
 . W !,$C(7),"Insufficient information for Workload Credit."
 . W !,"Missing information will have to be captured by another method."
 S TIUOK=$$CONFIRM(.ICD,.CPT,.SC)
 I '+TIUOK D  G REENTER
 . W !!,"Changes Discarded. Please Enter Corrected Workload Data..." H 3
 . K ICD,CPT,SC,ICDARR,CPTARR
 K CPTARR,ICDARR
 W !!,"Posting Workload Credit..."
POST D QUE^TIUPXAP1 ; Queue TIU/PXAPI RESOURCE
 W:'+$G(DTOUT) "Done."
 Q
CONFIRM(ICD,CPT,SC) ; Show user and confirm
 N TIUI,TIUY S TIUY=0
 W !!,"You have indicated the following data apply to this visit:",!
 W !,"DIAGNOSES:"
 S TIUI=0
 F  S TIUI=$O(ICD(TIUI)) Q:+TIUI'>0  D
 . W !?3,$P(ICD(TIUI),U,2),?12,$E($P(ICD(TIUI),U,3),1,67)
 . W:+$G(ICD(TIUI,"PRIMARY")) "  <<< PRIMARY"
 W !!,"PROCEDURES:"
 S TIUI=0
 F  S TIUI=$O(CPT(TIUI)) Q:+TIUI'>0  D
 . W !?3,$P(CPT(TIUI),U,4),?12,$E($P(CPT(TIUI),U,2),1,67)
 . ;Display CPT Modifiers
 . D DISMOD^TIUPXAPM(.CPT,TIUI)
 I $D(SC)>9 D
 . W !!,"SERVICE CONNECTION:"
 . W !?3,"Service Connected? ",$S(+$G(SC("SC")):"YES",1:"NO")
 . I $D(SC("AO")),+$G(SC("SC"))'>0 W !?3,"Agent Orange? ",$S($G(SC("AO"))]"":$P($G(SC("AO")),U,2),1:"NOT ANSWERED")
 . I $D(SC("IR")),+$G(SC("SC"))'>0 W !?3,"Ionizing Radiation? ",$S($G(SC("IR"))]"":$P($G(SC("IR")),U,2),1:"NOT ANSWERED")
 . I $D(SC("EC")),+$G(SC("SC"))'>0 W !?3,"Environmental Contaminants? ",$S($G(SC("EC"))]"":$P($G(SC("EC")),U,2),1:"NOT ANSWERED")
 . I $D(SC("MST")) W !?3,"MST? ",$S($G(SC("MST"))]"":$P($G(SC("MST")),U,2),1:"NOT ANSWERED")
 . I $D(SC("HNC")) W !?3,"Head and/or Neck Cancer? ",$S($G(SC("HNC"))]"":$P($G(SC("HNC")),U,2),1:"NOT ANSWERED")
 W ! S TIUY=+$$READ^TIUU("Y","   ...OK","YES")
 Q +$G(TIUY)
 ; Pass encounter date to GETICD to pass to IBDF18A **161**
GETICD(TIULOC,ICDARR,TIUVDT) ; Get ICD-9 codes for clinic
 N TIUI,TIUROW,TIUCOL,ARRY2,TIUITM,TIUPAGE,TIUCAT S TIUCAT=""
 ; Pass encounter date as the 5th parameter to IBDF18A **161**
 D GETLST^IBDF18A(+TIULOC,"DG SELECT ICD-9 DIAGNOSIS CODES","ARRY2",,,,TIUVDT)
 S (TIUI,TIUROW,TIUITM)=0,(TIUCOL,TIUPAGE)=1
 F  S TIUI=$O(ARRY2(TIUI)) Q:+TIUI'>0  D
 . I $P(ARRY2(TIUI),U)]"" D  I 1
 . . S TIUROW=+$G(TIUROW)+1,TIUITM=+$G(TIUITM)+1
 . . S ICDARR(TIUROW,TIUCOL)=TIUITM_U_$G(ARRY2(TIUI))_U_TIUCAT
 . . S ICDARR("INDEX",TIUITM)=$G(ARRY2(TIUI))_U_TIUCAT K ARRY2(TIUI)
 . E  D
 . . S TIUROW=+$G(TIUROW)+1,TIUCAT=$$UP^XLFSTR($P($G(ARRY2(TIUI)),U,2))
 . . S ICDARR(TIUROW,TIUCOL)=U_U_TIUCAT
 . . K ARRY2(TIUI)
 . I (TIUROW#20'>0),(TIUCOL=3) S TIUPAGE=TIUPAGE+1
 . I TIUROW#20'>0 S TIUCOL=$S(TIUCOL=3:1,1:TIUCOL+1),TIUROW=20*(TIUPAGE-1)
 I +$G(ARRY2(0))>0 D
 . S TIUROW=+$G(TIUROW)+1,TIUITM=TIUITM+1
 . S ICDARR(TIUROW,TIUCOL)=TIUITM_"^OTHER ICD^OTHER Diagnosis"
 . S ICDARR("INDEX",TIUITM)="OTHER ICD^OTHER Diagnosis"
 . S ICDARR(0)=+$G(ARRY2(0))_U_+$G(TIUROW)_U_+$G(TIUPAGE)
 . I (TIUROW#20'>0),(TIUCOL=3) S TIUPAGE=TIUPAGE+1
 . I TIUROW#20'>0 S TIUCOL=$S(TIUCOL=3:1,1:TIUCOL+1),TIUROW=20*(TIUPAGE-1)
 Q
 ; Pass encounter date as TIUVDT for CSV **161**
ICD(ICD,ICDARR,TIUVDT) ; Select Dx's
 N I,J,Y,TIUICD,TIUICNT,TIUPGS,TIUPG,TIUITM,TIULITM,TIUPNM
 S TIUPNM=$S($L($G(TIU("PNM"))):$G(TIU("PNM")),+$G(DFN):$$PTNAME^TIULC1(DFN),1:"the Patient")
 W !!,"Please Indicate the Diagnoses for which "_TIUPNM_" was Seen:"
 W:+$O(ICDARR(0)) !
 S TIUICNT=+$G(ICDARR(0)),TIUPGS=$P($G(ICDARR(0)),U,3)
 S (I,J,L,Y)=0 I +TIUICNT S TIUPG=1
 F  S I=$O(ICDARR(I)) Q:+I'>0  D  Q:+$G(DTOUT)
 . S J=0 W ! F  S J=$O(ICDARR(I,J)) Q:+J'>0  D
 . . W ?((J-1)*25) W:+$P(ICDARR(I,J),U) $J($P(ICDARR(I,J),U),2)_" " W $E($P(ICDARR(I,J),U,3),1,20)
 . . S TIUITM=$S(+$G(ICDARR(I,J)):+$G(ICDARR(I,J)),1:$G(TIUITM))
 . . S:TIUITM>+$G(TIULITM) TIULITM=TIUITM
 . I I#20=0 S Y=$S(+Y:Y,1:"")_$P($$PICK^TIUPXAP2(1,+$G(TIULITM),"Select Diagnoses"_$S(+$G(TIUPG)<TIUPGS:" (<RETURN> to see next page of choices)",1:"")),U),TIUPG=+$G(TIUPG)+1 W !
 . S L=I S:TIUITM>+$G(TIULITM) TIULITM=TIUITM
 I +$G(DTOUT) Q
 I L#20 S Y=$S(+Y:Y,1:"")_$P($$PICK^TIUPXAP2(1,TIULITM,"Select Diagnoses"),U)
 I +Y,$P(ICDARR("INDEX",+Y),U)'="OTHER ICD" D  I 1
 . N I,ITEM F I=1:1:($L(Y,",")-1) D  Q:+$G(DTOUT)
 . . S ITEM=$P(Y,",",I)
 . . I $P(ICDARR("INDEX",+ITEM),U)'="OTHER ICD" D
 . . . S TIUICD=+$O(^ICD9("AB",$P(ICDARR("INDEX",+ITEM),U)_" ",0))
 . . . S ICD(I)=TIUICD_U_$G(ICDARR("INDEX",+ITEM))
 . . ; Pass encounter date to ICDOUT to pass to LEXSET for CSV **161**
 . . E  D ICDOUT(.ICD,.I,TIUVDT)
 Q:+$G(DTOUT)
 ; Pass encounter date to ICDOUT to pass to LEXSET for CSV **161**
 E  D ICDOUT(.ICD,,TIUVDT)
 I +$O(ICD(1)) D ASKPRMRY(.ICD) I 1
 Q:+$G(DTOUT)
 E  I $D(ICD(1)) S ICD(1,"PRIMARY")=1
 Q
ASKPRMRY(ICD) ; Which Dx is Primary
 N I,L,Y
PRMAGN W !!,"Please indicate which of the Diagnoses is the Primary Diagnosis:",!
 S (I,L,Y)=0 F  S I=$O(ICD(I)) Q:+I'>0!+Y  D
 . W:$P(ICD(I),U)]"" !,I,?7,$P(ICD(I),U,3)
 . I I#20=0 S Y=$P($$PICK^TIUPXAP2(1,I,"Select Diagnosis","NO"),U)
 . S L=I
 I L#20,'+Y S Y=$P($$PICK^TIUPXAP2(1,L,"Select Diagnosis","NO"),U)
 I +Y'>0 W !!?3,$C(7),"You must specify a Primary Diagnosis." G PRMAGN
 I +Y,$D(ICD(+Y)) S ICD(+Y,"PRIMARY")=1
 Q
ICDOUT(ICD,TIUI,TIUVDT) ; Go off-list for Dx
 N DIC,X,Y,TIUICD,TIUOUT
 F  D  Q:+$G(TIUOUT)
 . I $L($T(CONFIG^LEXSET)) D  I 1
 . . ; Pass encounter date to LEXSET for CSV **161**
 . . D CONFIG^LEXSET("ICD","ICD",TIUVDT)
 . E  D  Q
 . . W !,$C(7),"You must install LEXICON UTILITY v2.0 for this function to work...Contact IRM.",!
 . . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 . . S TIUOUT=1
 . S DIC(0)="AEMQ"
 . S DIC("A")="Select "_$S(+$G(ICDARR(0))'>0:"Diagnosis: ",1:"Another Diagnosis"_$S($D(ICDARR):" (NOT from Above List)",1:"")_": ")
 . N X K DIC("B")
 . D ^DIC
 . I +$D(DTOUT)!+$D(DUOUT)!(X="") S TIUOUT=1 Q
 . I $G(Y(1))]"" D  Q
 . . S TIUICD=+$O(^ICD9("AB",$P(Y(1),U)_" ",0))
 . . S:TIUICD'>0 TIUICD=+$O(^ICD9("AB",$P(Y(1),U)_"0 ",0))
 . . I +TIUICD'>0 W !,$C(7),"ICD CODE NOT FOUND FOR EXPRESSION." Q
 . . S:$S(+$G(TIUI)'>0:1,$D(ICD(+$G(TIUI))):1,1:0) TIUI=$G(TIUI)+1
 . . S ICD(TIUI)=TIUICD_U_Y(1)_U_$P(Y,U,2)
 . W $C(7),!!,"Nothing found for ",X,"..."
 . F  D  Q:(+Y>0)!+$G(TIUOUT)
 . . N X
 . . I $L($T(CONFIG^LEXSET)) D  I 1
 . . . ; Pass encounter date to LEXSET for CSV **161**
 . . . D CONFIG^LEXSET("ICD","ICD",TIUVDT)
 . . E  D  Q
 . . . W !,$C(7),"You must install LEXICON UTILITY v2.0 for this function to work...Contact IRM.",!
 . . . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 . . . S TIUOUT=1
 . . S DIC("A")="Please try another expression, or RETURN to continue: "
 . . D ^DIC
 . . I +$D(DTOUT)!+$D(DUOUT)!(X="") S TIUOUT=1 Q
 . . I +$G(Y(1))>0 D  Q
 . . . S TIUICD=+$O(^ICD9("AB",$P(Y(1),U)_" ",0))
 . . . S:$S(+$G(TIUI)'>0:1,$D(ICD(+$G(TIUI))):1,1:0) TIUI=$G(TIUI)+1
 . . . S ICD(TIUI)=TIUICD_U_Y(1)_U_$P(Y,U,2)
 . . W $C(7),!!,"Nothing found for ",X,"..."
 Q
PROVLIST(PROVLIST) ; Identify primary provider
 N PRIMARY,DFLT,DUOUT S DFLT=""
 W !
 I +$P($G(TIUPRM0),U,8)=0 Q
 I +$P($G(TIUPRM0),U,8)=1 S DFLT=$$DFLTDOC(+TIU("VLOC"))
 I +DFLT=DUZ S PROVLIST(1,"NAME")=DUZ,PROVLIST(1,"PRIMARY")=1 Q
 I +DFLT S DFLT=$P(DFLT,U,2)
 S:DFLT']"" DFLT=$S($$PROVIDER^TIUPXAP1(DUZ,DT):$$PERSNAME^TIULC1(DUZ),1:"")
ASKPR S PRIMARY=+$$ASKDOC(DFLT)
 I +PRIMARY'>0 Q
 I '+$$PROVIDER^TIUPXAP1(PRIMARY,DT) D  G ASKPR
 . W !,$C(7),"  Selected user is not a known PROVIDER. Please choose another..."
 S PROVLIST(1,"NAME")=DUZ
 I PRIMARY=DUZ S PROVLIST(1,"PRIMARY")=1
 E  S PROVLIST(2,"NAME")=PRIMARY,PROVLIST(2,"PRIMARY")=1,PROVLIST(1,"PRIMARY")=0
 Q
ASKDOC(DFLT) ; Call ^DIC to look-up provider
 N DIC,X,Y
 S DIC=200,DIC(0)="AEMQ",DIC("A")="Select PRIMARY PROVIDER: "
 I $G(DFLT)]"" S DIC("B")=$G(DFLT)
 D ^DIC
 Q +Y
DFLTDOC(HLOC) ; Get the default Provider
 N PXBPMT,TIUPNM,Y S Y=""
 D PRV^PXBUTL2(HLOC)
 I $D(PXBPMT("DEF")) S TIUPNM=$O(PXBPMT("DEF","")),Y=$O(PXBPMT("DEF",TIUPNM,0))_U_TIUPNM
 Q Y
