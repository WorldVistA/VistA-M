TIUPXAPI ; SLC/JER - Interface w/PCE/Visit Tracking ;04/16/13  15:22
 ;;1.0;TEXT INTEGRATION UTILITIES;**15,24,29,82,107,126,161,267,263**;Jun 20, 1997;Build 16
CREDIT(DFN,TIU,VSIT) ; Get Dx, CPT, (& SC) for the CMD's mandate
 N TIUCPT,TIUAICD,TIUICDAR,TIUCPTAR,TIUSC,DTOUT,TIUOK,TIUPRLST,CSYSINFO
 ; For Historical Visits, just QUEUE the PXAPI call and quit
 I $P(TIU("VSTR"),";",3)="E" D QUE^TIUPXAP1 Q
 ; If no Location, and not Historical Visit, then quit
 Q:+$G(TIU("VSTR"))'>0
REENTER I $G(VALMAR)="^TMP(""TIUR"",$J)",$D(TIU("PNM")) D
 . W !!,"For ",$G(TIU("PNM"))," ",$G(TIU("PID"))," Visit on "
 . W $P($G(TIU("EDT")),U,2),"..."
 D PROVLIST(.TIUPRLST)
 N TIUVDT S TIUVDT=$P($G(TIU("VSTR")),";",2)
 S CSYSINFO=$$CSYSINFO(TIUVDT)
 ; *161 Pass encounter date to GETICD as 3rd and 4th variable, then to IBDF18A
 D GETICD(TIU("LOC"),.TIUICDAR,TIUVDT)
ICDCALL D ICD(.TIUAICD,.TIUICDAR,TIUVDT,CSYSINFO) G:+$G(DTOUT) INSUFF ; **15**
 I '$D(TIUAICD),'$D(DTOUT) W !!,$C(7),"You MUST enter one or more Diagnoses." H 3 G ICDCALL
 K TIUICDAR ; **15**
 ; Pass encounter date to TIUPXAPC to pass to IBDF18A **161**
 D GETCPT^TIUPXAPC(TIU("LOC"),.TIUCPTAR,TIUVDT)
 ; Pass encounter date to TIUPXAPC,ICPTCOD,TIUPXAPM for CSV **161**
CPTCALL D CPT^TIUPXAPC(.TIUCPT,.TIUCPTAR,TIUVDT) G:+$G(DTOUT) INSUFF
 I '$D(TIUCPT),'$D(DTOUT) W !!,$C(7),"You MUST enter one or more Procedures." H 3 G CPTCALL
 K TIUCPTAR ; **15**
 D SCASK^TIUPXAPS(.TIUSC,+DFN,.TIU)
INSUFF I $D(DTOUT)!(+$O(TIUAICD(0))'>0)&(+$O(TIUCPT(0))'>0)&(+$O(TIUSC(0))'>0) D  G POST
 . W !,$C(7),"Insufficient information for Workload Credit."
 . W !,"Missing information will have to be captured by another method."
 S TIUOK=$$CONFIRM(.TIUAICD,.TIUCPT,.TIUSC)
 I '+TIUOK D  G REENTER
 . W !!,"Changes Discarded. Please Enter Corrected Workload Data..." H 3
 . K TIUAICD,TIUCPT,TIUSC,TIUICDAR,TIUCPTAR
 K TIUCPTAR,TIUICDAR
 W !!,"Posting Workload Credit..."
POST N ICD,CPT,SC
 M ICD=TIUAICD,CPT=TIUCPT,SC=TIUSC
 D QUE^TIUPXAP1 ; Queue TIU/PXAPI RESOURCE
 W:'+$G(DTOUT) "Done."
 Q
 ;
CONFIRM(TIUAICD,TIUCPT,TIUSC) ; Show user and confirm
 N TIUI,TIUY,CODENO,CODSYSNO,CSYS S TIUY=0
 W !!,"You have indicated the following data apply to this visit:",!
 W !,"DIAGNOSES:"
 S TIUI=0
 F  S TIUI=$O(TIUAICD(TIUI)) Q:+TIUI'>0  D
 . S CODENO=$P(TIUAICD(TIUI),U,2) S CSYS=$P($$CODECS^ICDEX(CODENO,80),U,2) ;ICR 5747
 . S CODSYSNO="("_CSYS_" "_CODENO_") " W !?3,CODSYSNO
 . I +$G(TIUAICD(TIUI,"PRIMARY")) D  Q
 . . I $L($P(TIUAICD(TIUI),U,3))+12<57 W ?22,$P(TIUAICD(TIUI),U,3)_"  <<< PRIMARY" Q
 . . W ?22,$E($P(TIUAICD(TIUI),U,3),1,57),!,?7,"<<< PRIMARY"
 . W ?22,$E($P(TIUAICD(TIUI),U,3),1,57)
 W !!,"PROCEDURES:"
 S TIUI=0
 F  S TIUI=$O(TIUCPT(TIUI)) Q:+TIUI'>0  D
 . W !?3,$P(TIUCPT(TIUI),U,4),?12,$E($P(TIUCPT(TIUI),U,2),1,67)
 . ;Display CPT Modifiers
 . D DISMOD^TIUPXAPM(.TIUCPT,TIUI)
 I $D(TIUSC)>9 D
 . W !!,"SERVICE CONNECTION:"
 . W !?3,"Service Connected? ",$S(+$G(TIUSC("SC")):"YES",1:"NO")
 . I $D(TIUSC("AO")),+$G(TIUSC("SC"))'>0 W !?3,"Agent Orange? ",$S($G(TIUSC("AO"))]"":$P($G(TIUSC("AO")),U,2),1:"NOT ANSWERED")
 . I $D(TIUSC("IR")),+$G(TIUSC("SC"))'>0 W !?3,"Ionizing Radiation? ",$S($G(TIUSC("IR"))]"":$P($G(TIUSC("IR")),U,2),1:"NOT ANSWERED")
 . I $D(TIUSC("EC")),+$G(TIUSC("SC"))'>0 W !?3,"Environmental Contaminants? ",$S($G(TIUSC("EC"))]"":$P($G(TIUSC("EC")),U,2),1:"NOT ANSWERED")
 . I $D(TIUSC("MST")) W !?3,"MST? ",$S($G(TIUSC("MST"))]"":$P($G(TIUSC("MST")),U,2),1:"NOT ANSWERED")
 . I $D(TIUSC("HNC")) W !?3,"Head and/or Neck Cancer? ",$S($G(TIUSC("HNC"))]"":$P($G(TIUSC("HNC")),U,2),1:"NOT ANSWERED")
 W ! S TIUY=+$$READ^TIUU("Y","   ...OK","YES")
 Q +$G(TIUY)
 ;
 ; Pass encounter date to GETICD to pass to IBDF18A **161**
GETICD(TIULOC,TIUICDAR,TIUVDT) ; Get ICD-9 or 10 codes for clinic
 N TIUI,TIUROW,TIUCOL,ARRY2,TIUITM,TIUPAGE,TIUCAT,INTFACE S TIUCAT=""
 ; Pass encounter date as the 5th parameter to IBDF18A **161**
 S INTFACE="DG SELECT ICD DIAGNOSIS CODES"
 D GETLST^IBDF18A(+TIULOC,INTFACE,"ARRY2",,,,TIUVDT) ;ICR 1296
 S (TIUI,TIUROW,TIUITM)=0,(TIUCOL,TIUPAGE)=1
 F  S TIUI=$O(ARRY2(TIUI)) Q:+TIUI'>0  D
 . I $P(ARRY2(TIUI),U)]"" D  I 1
 . . S TIUROW=+$G(TIUROW)+1,TIUITM=+$G(TIUITM)+1
 . . S TIUICDAR(TIUROW,TIUCOL)=TIUITM_U_$G(ARRY2(TIUI))_U_TIUCAT
 . . S TIUICDAR("INDEX",TIUITM)=$G(ARRY2(TIUI))_U_TIUCAT K ARRY2(TIUI)
 . E  D
 . . S TIUROW=+$G(TIUROW)+1,TIUCAT=$$UP^XLFSTR($P($G(ARRY2(TIUI)),U,2))
 . . S TIUICDAR(TIUROW,TIUCOL)=U_U_TIUCAT
 . . K ARRY2(TIUI)
 . I (TIUROW#20'>0),(TIUCOL=3) S TIUPAGE=TIUPAGE+1
 . I TIUROW#20'>0 S TIUCOL=$S(TIUCOL=3:1,1:TIUCOL+1),TIUROW=20*(TIUPAGE-1)
 I +$G(ARRY2(0))>0 D
 . S TIUROW=+$G(TIUROW)+1,TIUITM=TIUITM+1
 . S TIUICDAR(TIUROW,TIUCOL)=TIUITM_"^OTHER ICD^OTHER Diagnosis"
 . S TIUICDAR("INDEX",TIUITM)="OTHER ICD^OTHER Diagnosis"
 . S TIUICDAR(0)=+$G(ARRY2(0))_U_+$G(TIUROW)_U_+$G(TIUPAGE)
 . I (TIUROW#20'>0),(TIUCOL=3) S TIUPAGE=TIUPAGE+1
 . I TIUROW#20'>0 S TIUCOL=$S(TIUCOL=3:1,1:TIUCOL+1),TIUROW=20*(TIUPAGE-1)
 Q
 ; Pass encounter date as TIUVDT for CSV **161**
ICD(TIUAICD,TIUICDAR,TIUVDT,CSYSINFO) ; Select Dx's
 N TIUI,J,L,Y,TIUICD,TIUICNT,TIUPGS,TIUPG,TIUITM,TIULITM,TIUPNM
 S TIUPNM=$S($L($G(TIU("PNM"))):$G(TIU("PNM")),+$G(DFN):$$PTNAME^TIULC1(DFN),1:"the Patient")
 W !!,"Please Indicate the Diagnoses for which "_TIUPNM_" was Seen:"
 W:+$O(TIUICDAR(0)) !
 S TIUICNT=+$G(TIUICDAR(0)),TIUPGS=$P($G(TIUICDAR(0)),U,3)
 S (TIUI,J,L,Y)=0 I +TIUICNT S TIUPG=1
 F  S TIUI=$O(TIUICDAR(TIUI)) Q:+TIUI'>0  D  Q:+$G(DTOUT)
 . S J=0 W ! F  S J=$O(TIUICDAR(TIUI,J)) Q:+J'>0  D
 . . W ?((J-1)*25) W:+$P(TIUICDAR(TIUI,J),U) $J($P(TIUICDAR(TIUI,J),U),2)_" " W $E($P(TIUICDAR(TIUI,J),U,3),1,20)
 . . S TIUITM=$S(+$G(TIUICDAR(TIUI,J)):+$G(TIUICDAR(TIUI,J)),1:$G(TIUITM))
 . . S:TIUITM>+$G(TIULITM) TIULITM=TIUITM
 . I TIUI#20=0 S Y=$S(+Y:Y,1:"")_$P($$PICK^TIUPXAP2(1,+$G(TIULITM),"Select Diagnoses"_$S(+$G(TIUPG)<TIUPGS:" (<RETURN> to see next page of choices)",1:"")),U),TIUPG=+$G(TIUPG)+1 W !
 . S L=TIUI S:TIUITM>+$G(TIULITM) TIULITM=TIUITM
 I +$G(DTOUT) Q
 I L#20 S Y=$S(+Y:Y,1:"")_$P($$PICK^TIUPXAP2(1,TIULITM,"Select Diagnoses"),U)
 I +Y,$P(TIUICDAR("INDEX",+Y),U)'="OTHER ICD" D  I 1
 . N TIUI,ITEM F TIUI=1:1:($L(Y,",")-1) D  Q:+$G(DTOUT)
 . . S ITEM=$P(Y,",",TIUI)
 . . I $P(TIUICDAR("INDEX",+ITEM),U)'="OTHER ICD" D
 . . . S TIUICD=+$$ICDDATA^ICDXCODE(+CSYSINFO,$P(TIUICDAR("INDEX",+ITEM),U),TIUVDT,"E") ; ICR 5699
 . . . S TIUAICD(TIUI)=TIUICD_U_$G(TIUICDAR("INDEX",+ITEM))
 . . ; Pass encounter date to ICDOUT to pass to LEXSET for CSV **161**
 . . E  D ICDOUT(.TIUAICD,.TIUI,TIUVDT,CSYSINFO)
 Q:+$G(DTOUT)
 ; Pass encounter date to ICDOUT to pass to LEXSET for CSV **161**
 E  D ICDOUT(.TIUAICD,,TIUVDT,CSYSINFO)
 I +$O(TIUAICD(1)) D ASKPRMRY(.TIUAICD) I 1
 Q:+$G(DTOUT)
 E  I $D(TIUAICD(1)) S TIUAICD(1,"PRIMARY")=1
 Q
ASKPRMRY(TIUAICD) ; Which Dx is Primary
 N TIUI,L,Y
PRMAGN W !!,"Please indicate which of the Diagnoses is the Primary Diagnosis:",!
 S (TIUI,L,Y)=0 F  S TIUI=$O(TIUAICD(TIUI)) Q:+TIUI'>0!+Y  D
 . W:$P(TIUAICD(TIUI),U)]"" !,TIUI,?7,$P(TIUAICD(TIUI),U,3)
 . I TIUI#20=0 S Y=$P($$PICK^TIUPXAP2(1,TIUI,"Select Diagnosis","NO"),U)
 . S L=TIUI
 I L#20,'+Y S Y=$P($$PICK^TIUPXAP2(1,L,"Select Diagnosis","NO"),U)
 I +Y'>0 W !!?3,$C(7),"You must specify a Primary Diagnosis." G PRMAGN
 I +Y,$D(TIUAICD(+Y)) S TIUAICD(+Y,"PRIMARY")=1
 Q
ICDOUT(TIUAICD,TIUI,TIUVDT,CSYSINFO) ; Go off-list for Dx
 N DIC,X,Y,TIUICD,TIUOUT,CSYSIEN,NSID,SSID,CODE
 S CSYSIEN=+CSYSINFO,(NSID,SSID)=$P(CSYSINFO,U,2)
 F  D  Q:+$G(TIUOUT)
 . I $L($T(CONFIG^LEXSET)) D  I 1
 . . ; Pass encounter date to LEXSET for CSV **161**
 . . S (NSID,SSID)=$P(CSYSINFO,U,2)
 . . D CONFIG^LEXSET(NSID,SSID,TIUVDT) ; ICR 1609 ******
 . E  D  Q
 . . W !,$C(7),"You must install LEXICON UTILITY v2.0 for this function to work...Contact IRM.",!
 . . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 . . S TIUOUT=1
 . S DIC(0)="AEMQ"
 . S DIC("A")="Select "_$S(+$G(TIUICDAR(0))'>0:"Diagnosis: ",1:"Another Diagnosis"_$S($D(TIUICDAR):" (NOT from Above List)",1:"")_": ")
 . N X K DIC("B")
 . D ^DIC
 . I +$D(DTOUT)!+$D(DUOUT)!(X="") S TIUOUT=1 Q
 . S CODE=$S(NSID="ICD":Y(1),NSID="10D":Y(30),1:"")
 . I CODE]"" D  Q  ;Y(1 or 30)=DX CODE
 . . S TIUICD=+$$ICDDATA^ICDXCODE(CSYSIEN,CODE,TIUVDT,"E")
 . . I +TIUICD'>0 W !,$C(7),"ICD CODE NOT FOUND FOR EXPRESSION." Q
 . . S:$S(+$G(TIUI)'>0:1,$D(TIUAICD(+$G(TIUI))):1,1:0) TIUI=$G(TIUI)+1
 . . S TIUAICD(TIUI)=TIUICD_U_CODE_U_$P(Y,U,2)
 . W $C(7),!!,"Nothing found for ",X,"..."
 . F  D  Q:(+Y>0)!+$G(TIUOUT)
 . . N X
 . . I $L($T(CONFIG^LEXSET)) D  I 1
 . . . ; Pass encounter date to LEXSET for CSV **161**
 . . . D CONFIG^LEXSET(NSID,SSID,TIUVDT) ; ICR 1609
 . . E  D  Q
 . . . W !,$C(7),"You must install LEXICON UTILITY v2.0 for this function to work...Contact IRM.",!
 . . . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 . . . S TIUOUT=1
 . . S DIC("A")="Please try another expression, or RETURN to continue: "
 . . D ^DIC
 . . I +$D(DTOUT)!+$D(DUOUT)!(X="") S TIUOUT=1 Q
 . . S CODE=$S(NSID="ICD":Y(1),NSID="10D":Y(30),1:"")
 . . I CODE]"" D  Q  ;Y(1 or 30)=DX CODE
 . . . S TIUICD=+$$ICDDATA^ICDXCODE(+CSYSINFO,CODE,TIUVDT,"E")
 . . . S:$S(+$G(TIUI)'>0:1,$D(TIUAICD(+$G(TIUI))):1,1:0) TIUI=$G(TIUI)+1
 . . . S TIUAICD(TIUI)=TIUICD_U_CODE_U_$P(Y,U,2)
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
 D PRV^PXBUTL2(HLOC) ; ICR 3152
 I $D(PXBPMT("DEF")) S TIUPNM=$O(PXBPMT("DEF","")),Y=$O(PXBPMT("DEF",TIUPNM,0))_U_TIUPNM
 Q Y
 ;
CSYSINFO(DATE) ;Function: Coding system Information
 ; DATE is date of interest; defaults to today
 ; Returns CodesystemIENin757.3^AppNamespacein757.2^ImpDateofICD-10
 N X,X1,X2,IMPDT,CSIEN,NOW
 D NOW^%DTC S NOW=X K X
 S DATE=$S($G(DATE)>0:DATE,1:NOW)
 S X1=DATE,IMPDT=$$IMPDATE^LEXU("10D"),X2=IMPDT ; ICR 5679
 D ^%DTC I X'<0 Q 30_"^10D^"_IMPDT
 Q 1_"^ICD^"_IMPDT
