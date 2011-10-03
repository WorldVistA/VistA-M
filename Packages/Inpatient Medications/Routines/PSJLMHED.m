PSJLMHED ;BIR/MLM-BUILD LM HEADERS ;28 Jan 98 / 2:18 PM
 ;;5.0; INPATIENT MEDICATIONS ;**4,58,85,110,148,181**;16 DEC 97;Build 190
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to CWAD^ORQPT2 is supported by DBIA 2831.
 ; Reference to ^SC is supported by DBIA 10040.
 ;
HDR(DFN) ; -- list screen header
 ;   input:       DFN := ifn of pat
 ;  output:  VALMHDR() := hdr array
 ;
 K VAIN,VADM,GMRA,PSJACNWP,PSJ,VAERR,VA,X
 S PSJACNWP=1 D ENBOTH^PSJAC
 D HDRO(DFN)
 S PSJ="   Sex: "_$P(PSJPSEX,U,2),VALMHDR(4)=$$SETSTR^VALM1($S(PSJPDD:"Last ",1:"     ")_"Admitted: "_$P(PSJPAD,U,2),PSJ,45,23)
 S PSJ="    Dx: "_PSJPDX
 S:PSJPDD VALMHDR(5)=$$SETSTR^VALM1("Discharged: "_$E($P(PSJPDD,U,2),1,8),PSJ,48,26)
 S:'PSJPDD VALMHDR(5)=$$SETSTR^VALM1("Last transferred: "_$$ENDTC^PSGMI(PSJPTD),PSJ,42,26)
 Q
 ;
HDRO(DFN) ; Standardized part of profile header.
 N PSJCLIN,PSJAPPT,PSJCLINN,RMORDT S (PSJCLIN,PSJAPPT)=0,(RMORDAT,PSJCLINN)="" I $G(PSJORD) D
 . S PSJCLIN=$S($G(PSJORD)["V":$G(^PS(55,DFN,"IV",+PSJORD,"DSS")),$G(PSJORD)["U":$G(^PS(55,DFN,5,+PSJORD,8)),$G(PSJORD)["P":$G(^PS(53.1,+PSJORD,"DSS")),1:"")
 . S:PSJCLIN PSJAPPT=$P($G(PSJCLIN),U,2) I PSJCLIN,PSJAPPT S PSJCLINN=$P($G(^SC(+PSJCLIN,0)),U)
 K VALMHDR I PSJCLINN]"" S PSJ=VADM(1),PSJ=$$SETSTR^VALM1("   Clinic: "_PSJCLINN,PSJ,28,26)
 I PSJCLINN="" S PSJ=VADM(1),PSJ=$$SETSTR^VALM1($S('PSJPDD:"     ",1:"Last ")_"Ward: "_PSJPWDN,PSJ,30,18)
 S X=$$CWAD^ORQPT2(DFN)
 S:X]"" X=IORVON_X_IORVOFF,PSJ=$$SETSTR^VALM1(X,PSJ,80-$L(X),80) S VALMHDR(1)=PSJ
 S PSJ="   PID: "_$P(PSJPSSN,U,2)
 S RMORDT=$S($G(PSJPDD):"Last ",1:"     ")_"Room-Bed: "_$G(PSJPRB)
 I PSJCLINN]"",PSJAPPT S RMORDT="Clinic Date: "_$$ENDTC^PSGMI(PSJAPPT),RMORDT=$P(RMORDT,"  ")_" "_$P(RMORDT,"  ",2)
 S PSJ=$$SETSTR^VALM1(RMORDT,PSJ,26,28),VALMHDR(2)=$$SETSTR^VALM1("Ht(cm): "_PSJPHT_" "_PSJPHTD,PSJ,55,25)
 S PSJ="   DOB: "_$P($P(PSJPDOB,U,2)," ")_" ("_PSJPAGE_")",VALMHDR(3)=$$SETSTR^VALM1("Wt(kg): "_PSJPWT_" "_PSJPWTD,PSJ,55,25)
 Q
 ;
INIT(PSJPROT) ; -- init bld vars
 ; PSJPROT=1:UD ONLY; 2:IV ONLY; 3:BOTH
 K PSJUDPRF,^TMP("PSJ",$J),^TMP("PSJON",$J),^TMP("PSJPRO",$J)
 S:PSJPROT=1 PSJUDPRF=1
 D KILL^VALM10(),EN^PSJO1(PSJPROT)
 I '$D(^TMP("PSJ",$J)) W !!,?22,"NO ORDERS FOUND FOR "_$S(PSJOL="S":"SHORT",1:"LONG")_" PROFILE." S VALMQUIT=1 D PAUSE^PSJLMUTL Q
 S PSJTF=0,PSJLN=1,PSJEN=1,PSJC="" F  S PSJC=$O(^TMP("PSJ",$J,PSJC)) Q:PSJC=""  D
 .S PSJF="^PS("_$S("AO"[PSJC:"55,"_PSGP_",5,",PSJC="DF":"55,"_PSGP_",5,",1:"53.1,")
 .I PSJTF'=$E(PSJC,1)!(PSJC="CC")!(PSJC="CD")!(PSJC="BD") Q:PSJC="CB"  Q:PSJC="O"  Q:PSJC="DF"  D TF S PSJTF=$E(PSJC,1)    ;DAM 8-29-07 Added Q:PSJC="CB"  Q:PSJC="O"
 .S PSJST="" F  S PSJST=$O(^TMP("PSJ",$J,PSJC,PSJST)) Q:PSJST=""  D
 .. S PSJS="" F  S PSJS=$O(^TMP("PSJ",$J,PSJC,PSJST,PSJS)) Q:PSJS=""  Q:PSJC="CB"  Q:PSJC="O"  Q:PSJC="DF"  D ON      ;DAM 8-29-07  Added Q:PSJC="CB"  Q:PSJC="O"
 .;
 .;DAM 8-29-07   New code to place Pending Orders after Pending Renewal Orders on the roll and scroll display.  Non-Active Orders appear last.
 S PSJTF=0,PSJC="" F  S PSJC=$O(^TMP("PSJ",$J,PSJC)) Q:PSJC=""  D
 . S PSJF="^PS("_$S("AO"[PSJC:"55,"_PSGP_",5,",PSJC="DF":"55,"_PSGP_",5,",1:"53.1,")
 . I PSJC="CB" D TF S PSJTF=$E(PSJC,1)                            ;These are Pending Orders
 . I PSJC="CB" S PSJST="" F  S PSJST=$O(^TMP("PSJ",$J,PSJC,PSJST)) Q:PSJST=""  D
 . . S PSJS="" F  S PSJS=$O(^TMP("PSJ",$J,PSJC,PSJST,PSJS)) Q:PSJS=""   D ON
 . I PSJC="DF" D TF S PSJTF=$E(PSJC,1)                              ;These are recently DC Orders (mv)
 . I PSJC="DF" S PSJST="" F  S PSJST=$O(^TMP("PSJ",$J,PSJC,PSJST)) Q:PSJST=""  D
 . . S PSJS="" F  S PSJS=$O(^TMP("PSJ",$J,PSJC,PSJST,PSJS)) Q:PSJS=""   D ON
 . I PSJC="O" D TF S PSJTF=$E(PSJC,1)                              ;These are Non-Active Orders
 . I PSJC="O" S PSJST="" F  S PSJST=$O(^TMP("PSJ",$J,PSJC,PSJST)) Q:PSJST=""  D
 . . S PSJS="" F  S PSJS=$O(^TMP("PSJ",$J,PSJC,PSJST,PSJS)) Q:PSJS=""   D ON
 .; END DAM changes
 .;
 S VALMCNT=PSJLN-1
DONE ;
 K PSJC,PSJEN,PSJLN,PSJST,PSJS,CNT,PSJPRI
 Q
 ;
ON ;
 S PSJSCHT=$S(PSJOS:PSJS,1:PSJST)
 S PSJO="" F FQ=0:0 S PSJO=$O(^TMP("PSJ",$J,PSJC,PSJST,PSJS,PSJO)) Q:PSJO=""  S DN=^(PSJO)   D
 .N PRJPRI S PSJPRI=$S(PSJO["V":$P($G(^PS(55,PSGP,"IV",+PSJO,.2)),"^",4),PSJO["U":$P($G(^PS(55,PSGP,5,+PSJO,.2)),"^",4),1:$P($G(^PS(53.1,+PSJO,.2)),"^",4))
 .S ^TMP("PSJON",$J,PSJEN)=PSJO,PSJL=$J(PSJEN,4) D @$S(PSJO["V":"PIV^PSJLMPRI(PSGP,PSJO,PSJF,DN)",PSJO["U":"PUD^PSJLMPRU(PSGP,PSJO,PSJF,DN)",1:"PIV^PSJLMPRI(PSGP,PSJO,PSJF,DN)") S ^TMP("PSJPRO",$J,0)=PSJEN,PSJEN=PSJEN+1
 Q
 ;
TF ; Set up order type header
 NEW PSJDFHDR
 I $D(^TMP("PSJ",$J,PSJC)) D
 .S PSJDCEXP=$$RECDCEXP^PSJP()
 .S PSJDFHDR="RECENTLY DISCONTINUED/EXPIRED (LAST "_+$G(PSJDCEXP)_" HOURS)"
 .N C,X,Y S C=PSJC,Y="",$P(Y," -",40)=""
 .S X=$S(C="A":$$TXT^PSJO("A"),C["CC":$$TXT^PSJO("PR"),C["CD":$$TXT^PSJO("PC"),C["C":$$TXT^PSJO("P"),C["BD":$$TXT^PSJO("NC"),C["B":$$TXT^PSJO("N"),C["DF":PSJDFHDR,1:$$TXT^PSJO("NA"))
 .S ^TMP("PSJPRO",$J,PSJLN,0)=$E($E(Y,1,(80-$L(X))/2)_" "_X_$E(Y,1,(80-$L(X))/2),1,80),PSJLN=PSJLN+1
 Q
TEST ;
 N X,Y S Y="",$P(Y," -",40)=""
 F X="A C T I V E","P E N D I N G   R E N E W A L S","P E N D I N G ","N O N - V E R I F I E D","N O N - A C T I V E" W !,$E($E(Y,1,(80-$L(X))/2)_" "_X_$E(Y,1,(80-$L(X))/2),1,80)
 Q
