PSJLIFNI ;BIR/MV-U/D ORDER FINISHES AS IV ;13 Jan 98 / 11:32 AM
 ;;5.0;INPATIENT MEDICATIONS;**1,29,34,37,50,94,116,110,111,181,261,256,347**;16 DEC 97;Build 6
 ;
IV(PSJORD,OI) ; Prompt for missing data to be finished as IV.
 L +^PS(53.1,+PSJORD):1 I '$T W !,$C(7),$C(7),"This order is being edited by another user. Try later." D PAUSE^VALM1 Q
 D HOLDHDR^PSJOE
 ;** PSIVFN1 is used so it will display the AC/Edit screen
 ;** instead of go to the "IS this O.K." prompt
 ;** PSJLIFNI is a flag to indicate U/D finishes as IV.
 K PSJIVBD
 NEW PSIVFN1,ON55,PSGORQF,PSIVACEP,DRGOC,PSJLIFNI,PSIVOI,PSJOLDNM
 K PSGORQF
 S PSJLIFNI=1
 S PSIVAC="CF" S (P("PON"),ON,ON55)=+PSJORD_"P",DFN=PSGP
 S PSIVUP=+$$GTPCI^PSIVUTL D GT531^PSIVORFA(DFN,ON) S P("PD")=OI_U_$$OIDF^PSJLMUT1(+OI)
 D:'$D(P("OT")) GTOT^PSIVUTL(P(4))
 S P("OPI")=$$ENPC^PSJUTL("V",+PSIVUP,60,P("OPI"))
 D 53^PSIVORC1
 I $E(P("OT"))="I" D GTDATA^PSJLIFN Q:P(4)=""
 ;I $$SCHREQ^PSJLIVFD(.P),(P(9))]"",'$$PRNOK^PSGS0(P(9)) N PSGOES,X,PSGS0XT,PSJNSS S PSJNSS=1,PSGOES=1,X=P(9),PSGS0XT=P(15) D Q2^PSGS0
 I $$SCHREQ^PSJLIVFD(.P),(P(9))]"",'$$PRNOK^PSGS0(P(9)) N PSJNSS,PSGOES,PSGS0XT,PSGS0Y,PSGAT S X=P(9),PSGS0XT=P(15),PSGAT=P(11) D
 .;
 .;PSJ*5*256
 . S PSJOLDNM("ORD_SCHD")=P(9)
 . I ($G(P("RES"))'="R"),$$CHKSCHD^PSJMISC2(.PSJOLDNM) S PSGORQF=1,VALMBCK="R" Q
 . S:$G(PSJOLDNM("NEW_SCHD"))]"" P(9)=PSJOLDNM("NEW_SCHD")
 .;
 .;D EN^PSGS0 I $G(X)="" D  S PSGORQF=1 Q
 .D EN^PSGS0
 .I $G(X)="" S PSGORQF=1 Q
 .;Update the schedule if diff value enttered.
 .I ($G(X)]""),($G(P(9))]"") S P(9)=X
 .I $G(PSGS0Y)>1 S P(11)=PSGS0Y
 I $E(P("OT"))="I",'$D(DRG("AD")),('$D(DRG("SOL"))) S DNE=0 D GTIVDRG^PSIVORC2 S P(3)="" D ENSTOP^PSIVCAL
 I $D(PSGORQF) S VALMBCK="R",P(4)="" K DRG Q
 S ^TMP("PSJI",$J,0)=""
 S PSIVOK="1^3^10^25^26^39^57^58^59^63^64" D CKFLDS^PSIVORC1 I EDIT]"" D EDIT^PSIVEDT
 ;I $G(EDIT)="" D OC^PSIVOC
 I $G(DONE) S VALMBCK="R" D EXIT Q
 ;PSJ*5*261 - Remedy #490875 PSPO 2040
 D ENSTOP^PSIVCAL
 D COMPLTE^PSIVORC1
 S:$D(PSIVACEP) VALMBCK="Q"
EXIT ;
 L -^PS(53.1,+PSJORD)
 Q
ORDCHK(DFN,TYPE) ;
 ;TYPE ="DD" - Duplicate drug
 ;     ="DC" - Duplicate class
 ;     -"DI" - Drug Interaction
 ;
 NEW ON,PSJL,PSIVX,PSJOC,PSJORIEN,PSJPACK,PSJLINE
 S PSJOC=0,PSJLINE=1
 F PSIVX=0:0 S PSIVX=$O(^TMP($J,TYPE,PSIVX)) Q:'PSIVX  D
 . I TYPE="DI",($P(^TMP($J,TYPE,PSIVX,0),U,4)="CRITICAL") S PSJIREQ=1
 . D WRITE(TYPE),CONT^PSGSICHK
 .; I ON["V" D
 .;. I '$O(^PS(55,DFN,"IV",+ON,0)) D SETPSJOC Q
 .;. D DSPLORDV(DFN,ON) S PSJOC=PSJOC+1
 .; I ON'["V" D DSPLORDU(DFN,ON) S PSJOC=PSJOC+1
 .; S PSJOC(ON,PSJLINE)="",PSJLINE=PSJLINE+1
 ;D:PSJOC WRITE(TYPE)
 ;S ON="" F  S ON=$O(PSJOC(ON)) Q:ON=""  W ! S PSJLINE=PSJLINE+1 D
 ;. F PSIVX=0:0 S PSIVX=$O(PSJOC(ON,PSIVX)) Q:'PSIVX  W !,PSJOC(ON,PSIVX)  S PSJLINE=PSJLINE+1 D:'(PSIVX#6) PAUSE
 ;W !
 Q
WRITE(TYPE) ;Display order check description
 S PSJPDRG=1
 I TYPE="DD" W !!,"There are duplicate ",$P(^TMP($J,TYPE,PSIVX,0),U,2),!,"medications prescribed for this order.",! Q
 I TYPE="DC" W !!,"This medication: ",$P(^TMP($J,TYPE,PSIVX,0),U,4),!,"is in the same class as the following medication(s) within this order: "
 I TYPE="DI" W !!,"This medication: ",$P(^TMP($J,TYPE,PSIVX,0),U,2),!,"has an interaction with the following medication(s) within this order: "
 F X=0:0 S X=$O(^TMP($J,TYPE,X)) Q:'X  W !,$S(TYPE="DC":$P(^TMP($J,TYPE,X,0),U,4),TYPE="DI":$P(^TMP($J,TYPE,X,0),U,6),1:$P(^TMP($J,TYPE,X,0),U,2)),!
 Q
