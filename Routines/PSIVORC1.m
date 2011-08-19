PSIVORC1 ;BIR/MLM-PROCESS INCOMPLETE IV ORDER - CONT ;13 Jan 98 / 11:36 AM
 ;;5.0;INPATIENT MEDICATIONS ;**1,37,69,110,157,134,181,263**;16 DEC 97;Build 51
 ;
 ; Reference to ^DD("DD" is supported by DBIA 10017.
 ; Reference to ^DD( is supported by DBIA 2255.
 ; Reference to ^VA(200 is supported by DBIA 10060.
 ; Reference to ^%DT is supported by DBIA 10003.
 ; Reference to ^%DTC is supported by DBIA 10000.
 ; Reference to ^DID is supported by DBIA 2052.
 ; Reference to ^VALM is supported by DBIA 10118.
 ; Reference to ^PS(51.1 supported by DBIA #2177.
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ;
53 ; IV Type
 I $G(PSGORD)["P",$G(PSGAT),($G(P(9))]"") D
 .N X,PSGS0Y,ZZ,LYN,ZZND,ZZNDW S X=P(9) S PSGS0Y="",ZZ=0 D FIND^DIC(51.1,,,,X,,"APPSJ",,,"LYN")
 .S ZZ=$O(LYN("DILIST",2,ZZ)) I ZZ S ZZ=+LYN("DILIST",2,ZZ) I ZZ S ZZND=$G(^PS(51.1,ZZ,0)) S PSGST=$P(ZZND,U,5),PSGS0XT=$P(ZZND,U,3) I $G(PSJPWD) D
 ..N ZZNDW S ZZNDW=$G(^PS(51.1,ZZ,1,PSJPWD,0)) I $P(ZZNDW,"^",2)]"" S PSGS0Y=$P(ZZNDW,"^",2),$P(ZZND,"^",2)=PSGS0Y
 .S ZZ=0 F  S ZZ=$O(LYN("DILIST",1,ZZ)) Q:'ZZ  I $G(LYN("DILIST",1,ZZ))'=X K LYN("DILIST",1,ZZ),LYN("DILIST",2,ZZ),LYN("DILIST","ID",ZZ,1)
 .I $D(PSJPWD) S ZZ=0 F  S ZZ=$O(LYN("DILIST",2,ZZ)) Q:'ZZ  I $P($G(^PS(51.1,+LYN("DILIST",2,ZZ),1,+PSJPWD,0)),U,2)]"" S PSGS0Y=$P($G(^(0)),U,2)
 .I '$G(PSGS0Y) S ZZ=0 F  S ZZ=$O(LYN("DILIST",2,ZZ)) Q:'ZZ  Q:PSGS0Y]""  I $G(LYN("DILIST","ID",ZZ,1))]"" S PSGS0Y=$G(LYN("DILIST","ID",ZZ,1))
 .Q:(PSGS0Y=PSGAT)!'$G(PSGS0Y)!($G(IVCAT)="C")
 .S PSGNSTAT=1 W $C(7),!!,"PLEASE NOTE:  This order's admin times (",PSGAT,")"
 .W !?13," do not match the ward times (",PSGS0Y,")"
 .W !?13," for this administration schedule (",P(9),")",!
 .S DIR(0)="EA",DIR("A")="Press Return to continue..." D ^DIR K DIR  W !
 S DONE=0 N DIR S DIR(0)="SNA^A:ADMIXTURE;C:CHEMOTHERAPY;H:HYPERAL;P:PIGGYBACK;S:SYRINGE",DIR("A")="IV TYPE: "
 I $G(P("RES"))'="R",$G(PSGORD)["P" N IVCAT,IVTYPTMP S IVCAT=$P($G(^PS(53.1,+PSGORD,2.5)),"^",5) S IVTYPTMP=$S((P(9)]""):"P",$G(P(5)):"P",$G(P(23))="P":"P",1:"")
 S DIR("B")=$S($G(IVCAT)="C"!($G(IVTYPTMP)="A"):"ADMIXTURE",$G(IVCAT)="I"!($G(IVTYPTMP)="P"):"PIGGYBACK",1:"ADMIXTURE")
 D DIRQ,^DIR S:$D(DTOUT)!(X="^") DONE=1 Q:DONE  G:$E(X)="^" 53 S P(4)=Y D:"CS"[P(4) @P(4)
 I PSIVAC'="PN" D ENT^PSIVCAL K %DT S X=P(2),%DT="RTX" D ^%DT S P(2)=+Y D ENSTOP^PSIVCAL K %DT S X=P(3),%DT="RTX" D ^%DT S P(3)=+Y
OTYP ; Get order type, display type.
 S P("DTYP")=$S(P(4)="":0,P(4)="P"!(P(23)="P")!(P(5)):1,P(4)="H":2,1:3) S:PSIVAC'="CF" P("OT")=$S(P(4)="A":"F",P(4)="H":"H",1:"I")
 Q
 ;
C ; Edit Chemo order
 N DIR S DIR(0)="SA^A:ADMIXTURE;P:PIGGYBACK;S:SYRINGE",DIR("A")="CHEMOTHERAPY TYPE: " D DIRQ,^DIR S:$D(DTOUT)!(X=U) DONE=1 Q:$E(X)="^"!(DONE)  S P(23)=Y D:P(23)["S" S
 Q
 ;
S ; Edit Syringe order
56 ; Intermittent Syringe
 N DIR S DIR(0)="Y",DIR("??")="^S F1=53.1,F2=56 D ENHLP^PSIVORC1",DIR("A")="INTERMITTENT SYRINGE" D ^DIR Q:$D(DIRUT)  S P(5)=Y
 ;
55 ; Syringe Size
 N DA,DIR S DIR(0)="53.1,55" D ^DIR I $D(DTOUT)!$D(DUOUT) S DONE=1 Q
 S P("SYRS")=Y
 Q
 ;
DIRQ ; Set DIR("?") for IV Type prompt.
 S DIR("?")="Enter a code from the list above.",DIR("??")="^S F1=55.01,F2="_$S(DIR("A")["CHEMO":106,1:.04)_" D ENHLP^PSIVORC1"
 S DIR("?",1)="CHOOSE FROM:",Y=$P(DIR(0),U,2) F X=1:1:5 S DIR("?",X+1)="              "_$P($P(Y,";",X),":")_"    "_$P($P(Y,";",X),":",2)
 Q
 ;
CKFLDS ; Find required fields missing data.
 NEW PSIVASX,PSIVASY,FIL,DRGTMP
 S EDIT="" F PSIVASX="AD","SOL" D
 .I '$D(DRG(PSIVASX)) S EDIT=EDIT_U_$S(PSIVASX="AD":57,1:58) Q
 .S DNE=0 F PSIVASY=0:0 S PSIVASY=$O(DRG(PSIVASX,PSIVASY)) Q:'PSIVASY!DNE  D
 .. I $P(DRG(PSIVASX,PSIVASY),U,3)="" S EDIT=EDIT_U_$S(PSIVASX="AD":57,1:58),DNE=1
 .. I $P(DRG(PSIVASX,PSIVASY),U,4)="See Comments",(EDIT'["57") S EDIT=EDIT_U_$S(PSIVASX="AD":57,1:58),DNE=1
 S:'P("MR") EDIT=EDIT_U_3 F X=8,6,2,3 I P(X)="" S EDIT=EDIT_U_$S(X=8:59,X=6:1,X=2:10,X=3:25,1:"")
 I P("DTYP")=1 S:P(9)="" EDIT=EDIT_U_26 S:P(11)="" EDIT=EDIT_U_39
 S:$E(EDIT,1)=U EDIT=$E(EDIT,2,999)
 Q
 ;
DONE ; Kill variables and exit
 K ACTION,AD,DFN,DNE,DONE,DONE1,DRG,DRGI,DRGN,DRGT,DRGTN,EDIT,ERR,F1,F2,FIL,HDT,J,LN,LN2,ND,ON,ON1,ON55,ORIFN,P,P16,PC,PDM,PG,PN,PNME,PNOW,PSGLMT,PSGODDD
 K PSGSS,PSGSSH,PSIV,PSIVAC,PSIVAT,PSIVCV,PSIVE,PSIVHD,PSIVLN,PSIVOK,PSIVOLD,PSIVORUT,PSIVREA,PSIVSC1,PSIVSTR,PSIVSTRT,PSIVTYPE,PSIVUP,PSIVX,PSIVX1
 K PSJIVORF,PSJORF,PSJORIFN,PSJORL,PSJORNP,PSJORPF,PSJORSTS,PSJIVOF,PSJNKF,PSJORD,RB,RF,SOL,STOP,TYP,UL80,WD,WDN,WG,^TMP("PSIV",$J) D ENIVKV^PSGSETU
 Q
ENHLP ; order entry fields' help
 N PSJHP,PSJX,PSJD
 ;From within this routine, F1 and F2 will refer to file 53.1,field 56, file 55.01,field 106, or file 55.01,field .04
 D FIELD^DID(F1,F2,"","HELP-PROMPT","PSJHP")
 I X="?",$D(PSJHP("HELP-PROMPT")) S F=$G(PSJHP("HELP-PROMPT")) W !?5 F F0=1:1:$L(F," ") S F3=$P(F," ",F0) W:$L(F3)+$X>78 !?5 W F3_" "
 ;
 W:$D(^DD(F1,F2,12)) !,"("_^(12)_")" D FIELD^DID(F1,F2,"","XECUTABLE HELP","PSJX") I $D(PSJX("XECUTABLE HELP")) X PSJX("XECUTABLE HELP")
 ;
 ; new code
 D FIELD^DID(F1,F2,"","DESCRIPTION","PSJD")
 G:$S($G(X)="?":1,1:'$O(PSJD("DESCRIPTION",0))) SC F F=0:0 S F=$O(PSJD("DESCRIPTION",F)) Q:'F  I $D(PSJD("DESCRIPTION",F)) W !?2,PSJD("DESCRIPTION",F)
SC ;
 I F2=5!(F2=6) W !,"CHOOSE FROM:",!?8,0,?16,"NO",!?8,1,?16,"YES" Q
 Q
COMPLTE ;
 NEW PSIVDSFG S PSIVDSFG=0
 S P16=0,PSIVEXAM=1,(PSIVNOL,PSIVCT)=1 D GTOT^PSIVUTL(P(4)) D ^PSIVCHK I $D(DUOUT) W $C(7),!,"Order Unchanged.",! Q
 G:'$D(PSIVFN1) EDIT1
 I ERR=1 S Y=0 G EDIT1
 D CKORD^PSIVORC2 I $G(PSJFNDS)!$S($G(PSIVDSFG):0,PSIVCHG:1,1:0)!$$INFRATE^PSJMISC(DFN,ON,P(8),P("DTYP")) D
 . K PSJFNDS
 . I $$SEECMENT^PSIVEDRG() S PSGORQF=1 W !!,"*** One or more Additives has an invalid value for the bottle number(s).",! D PAUSE^PSJMISC() Q
 . D IN^PSJOCDS($G(ON),"IV","")
 . Q:$G(PSGORQF)
 . Q:'PSIVCHG
 D NOW^%DTC S P("LOG")=$E(%,1,12),P("CLRK")=DUZ_U_$P($G(^VA(200,DUZ,0)),U),P("INS")=""
 Q:$G(PSGORQF)
 W ! D ^PSIVORLB K PSIVEXAM S Y=P(2)
 W !,"Start date: " X ^DD("DD") W $P(Y,"@")," ",$P(Y,"@",2),?30," Stop date: " S Y=P(3) X ^DD("DD") W $P(Y,"@")," ",$P(Y,"@",2),!
EDIT ;
 I ERR=1 W !,"Please re-edit this order" K DIR S DIR(0)="E" D ^DIR K DIR W:'Y $C(7),"order unchanged." Q:'Y  S Y=0 G EDIT1
 ;PSJ*5*157 EFD FOR IV
 D EFDIV^PSJUTL($G(ZZND))
 W:$G(PSIVCHG) !,"*** This change will cause a new order to be created. ***"
 K DIR S DIR(0)="Y",DIR("A")="Is this O.K.",DIR("B")=$S(ERR:"NO",1:"YES"),DIR("?",1)="Enter ""Y"" to make this an active order (only allowed if no errors were"
 S DIR("?")="found in order), ""N"" to edit the order, or ""^"" to leave order unchanged.",DIR("??")="^S HELP=""EDIT"" D ^PSIVHLP"
 D ^DIR K DIR I $D(DIRUT) K DIRUT W $C(7),"Order unchanged." Q
 ;*  Kill Unit dose variables when calling from ^PSJLIFNI.
 I +Y,$G(PSJLIFNI) D
 . K ND,ND4,ND6,NDP2
 . K PSGAT,PSGCANFL,PSGDI,PSGDO,PSGDT,PSGEB,PSGEBN,PSGEFN,PSGFD,PSGFDN
 . K PSGHSM,PSGLI,PSGLIN,PSGLMT,PSGMR,PSGMRN,PSGNEDFD,PSGNEF,PSGNEFD
 . K PSGNESD,PSGOAT,PSGODO,PSGODT,PSGEA,PSGOEAV,PSGOEEF
 . K PSGOEEWF,PSGOEEG,PSGOEF,PSGOENG,PSGOES,PSGOFD,PSGOFDN,PSGOHSM
 . K PSGOINST,PSGOMR,PSGOMRN,PSGONC
 . K PSGOPD,PSOPDN,PSGOPR,PSGOPRN,PSGOSD,PSGOSDN,PSGOSI,PSGOSM
 . K PSGOST,PSGOSTN
 . K PSGPD,PSGPDN,PSGPDRG,PSGDRGN,PSGPFLG,PSGPI,PSGPR,PSGPRIO,PSGPRN
 . K PSGPTMP,PSGRRF,PSG0XT,PSGS0Y,PSGSCH,PSGSD,PSGSDN,PSGSI,PSGSM
 . K PSGST,PSGSTAT,PSGSTN,PSJACNWP,PSJACOK,PSJCOI
EDIT1 ;
 NEW XFLG,PSIVY S PSIVY=$G(Y)
 NEW X S X=$G(^TMP("PSJI",$J,0)),VALMBG=$S((X<17):1,1:(X-(X#16)))
 I PSIVY=0!'$G(PSIVFN1) S PSIVFN1=1 D EN^VALM("PSJ LM IV AC/EDIT") Q
 S PSIVCHG=0 D EDCHK^PSIVORC2 K PSIVCHG
 S VALMBCK="Q",PSIVACEP=1
 Q
