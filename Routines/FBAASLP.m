FBAASLP ;AISC/GRR-PRINT SUSPENSION LETTERS ;7/NOV/2006
 ;;3.5;FEE BASIS;**12,4,23,69,101**;JAN 30, 1995;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 D DATE^FBAAUTL G END:FBPOP  K FBAAS S (FBAAOUT,FBSLW,FBPRG,FBCTR,FBY)=0,UL="",$P(UL,"=",80)="="
 D ^FBAASL G END:FBAAOUT
RDCODE S DIR(0)="Y",DIR("A")="For All Suspension codes",DIR("B")="YES",DIR("?")="'Yes' to print suspension letters for all suspension codes, 'No' to select specific codes." D ^DIR K DIR W ! G END:$D(DUOUT),END:$D(DTOUT),SEL:'Y
 ;ask edi/non-edi/all claims
AHEAD S DIR(0)="SA^1:EDI;2:NON-EDI;3:ALL",DIR("A")="Only print letters for claims that were submitted via (EDI/NON-EDI/ALL):",DIR("B")="ALL"
 S DIR("?",1)=" Enter EDI to just print suspension letters for EDI claims from the FPPS system."
 S DIR("?",2)=" Enter NON-EDI to just print suspension letters for claims that are not EDI."
 S DIR("?",3)=" Enter ALL to print suspension letters for both EDI and NON-EDI claims."
 S DIR("?")=" "
 D ^DIR K DIR G END:$D(DIRUT)
 S FBENA=Y
 S VAR="BEGDATE^ENDDATE^FBSLW",VAL=BEGDATE_"^"_ENDDATE_"^"_FBSLW
 I $G(DFN) S VAR="DFN^"_VAR,VAL=DFN_"^"_VAL
 I $G(IFN) S VAR="IFN^"_VAR,VAL=IFN_"^"_VAL
 I $G(FBDEN) S VAR="FBDEN^"_VAR,VAL=FBDEN_"^"_VAL
 I $G(FBENA) S VAR="FBENA^"_VAR,VAL=FBENA_"^"_VAL
 S K=0 F J=1:1:FBCTR S K=$O(FBPRG(K)) S VAR=VAR_"^FBPRG("""_K_""")",VAL=VAL_"^"_+FBPRG(K)
 I $D(FBAAS) F J=0:0 S J=$O(FBAAS(J)) Q:J'>0  S VAR=VAR_"^FBAAS("_J_")",VAL=VAL_"^"
 S PGM="START^FBAASLP",IOP="Q" D ZIS^FBAAUTL G:FBPOP END
START K ^UTILITY($J),^TMP($J) U IO S UL="",$P(UL,"=",80)="=",FBPG=1
 I $G(FBPRG("O")) S FBLET=+FBPRG("O") F K=0:0 S K=$O(^FBAAC("AI",K)) Q:K'>0  I $S($G(IFN):IFN=K,1:1) D STRT
 I $G(FBPRG("P")),$D(^FBAA(162.1,"AG")) S FBLET=+FBPRG("P") D ^FBAASL1 K ^TMP($J)
 I $G(FBPRG("C")),$D(^FBAA(162.2,"AI")) S FBLET=+FBPRG("C") D ^FBCHSLP
 I $G(FBPRG("I")),$D(^FBAAI("AI")) S FBLET=+FBPRG("I") D ^FBCHSL1
 I '$G(FBGOT) W !,"There are no suspension letters found that meet the criteria you have",!,"specified."
END K FBAAS,UL,X,J,K,L,M,VNAM,VST1,VST2,VCITY,VSTATE,FBDT,FBA,VZIP,PNAME,A1,A2,CPT,FBDOS,FBRR,FBXX,DIC,DIWL,DIWF,BEGDATE,ENDDATE,FBAA,FBDRUG,FBFORM,FBI,FBLET,FBPDT,FBRX,FBSLW,FBSW,I,PGM,VAL,VAR,Z,ZZ,FBAAPGM,Y,PSSN,DIRUT
 K FBAAOUT,FBCTR,FBPRG,FBY,FBMOD,FBMODLE,DFN,IFN,FBDEN,FBGOT,FBENA
 K ^UTILITY($J),^TMP($J)
 D CLOSE^FBAAUTL Q
MORE F J=0:0 S J=$O(^FBAAC("AI",K,FBDT,J)) Q:J'>0  I $S($G(DFN):DFN=J,1:1) D:$D(^DPT(J,0)) GOTP I $D(^FBAAV(K,0)) D MID
 Q
GOTV S Y(0)=^FBAAV(K,0),VNAM=$P(Y(0),"^",1),FBSW=0
 I VNAM["," S VNAM=$P(VNAM,",",2)_" "_$P(VNAM,",",1)
 S VST1=$P(Y(0),"^",3),VST2=$P(Y(0),"^",14),VCITY=$P(Y(0),"^",4),VSTATE=$S($D(^DIC(5,+$P(Y(0),"^",5),0)):$P(^(0),"^",2),1:"  "),VZIP=$P(Y(0),"^",6) S Y=DT D PDATE^FBAAUTL
 W:'$G(FBPG) @IOF K:$G(FBPG) FBPG W:(IOSL)>70 !!!! W !!!!!!!!!!!,?5,VNAM,?60,FBPDT,!,?5,VST1,! I VST2]"" W ?5,VST2,!
 W ?5,VCITY,"  ",VSTATE,"  ",VZIP,!!!!
WPBEG S DIWL=1,DIWF="WC79" K ^UTILITY($J,"W")
 I $D(^FBAA(161.3,FBLET,1,1)) F FBRR=0:0 S FBRR=$O(^FBAA(161.3,FBLET,1,FBRR)) Q:FBRR'>0  S FBXX=^(FBRR,0),X=FBXX D ^DIWP
 D ^DIWW:$D(FBXX) K FBXX
 Q
MID S FBA=0 F FBAA=0:0 S FBA=$O(^FBAAC("AI",K,FBDT,J,FBA)) Q:FBA=""  I $S(FBSLW=0:1,FBSLW=1&($D(FBAAS(FBA))):1,1:0) D MORE2
 Q
MORE2 F L=0:0 S L=$O(^FBAAC("AI",K,FBDT,J,FBA,L)) Q:L'>0  F M=0:0 S M=$O(^FBAAC("AI",K,FBDT,J,FBA,L,M)) Q:M'>0  I $D(^FBAAC(J,1,K,1,L,1,M,0)) S Z(0)=^(0) D:$P(Z(0),"^",20)'="R" BOT
 Q
WPBOT D ACT:$D(FBACRR) K FBACRR
 S DIWL=1,DIWF="WC79" K ^UTILITY($J,"W") W !!
 I $D(^FBAA(161.3,FBLET,2)) F FBRR=0:0 S FBRR=$O(^FBAA(161.3,FBLET,2,FBRR)) Q:FBRR'>0  S FBXX=^(FBRR,0),X=FBXX D ^DIWP
 D ^DIWW:$D(FBXX) K FBXX
 Q
BOT Q:$S($G(FBDEN):$P(Z(0),U,3)>0,1:0)
 N FBY3,FBFPPSC
 S FBY3=$G(^FBAAC(J,1,K,1,L,1,M,3))
 S FBFPPSC=$P(FBY3,U)
 Q:$S(FBENA=2&(FBFPPSC]""):1,FBENA=1&(FBFPPSC=""):1,1:0)
 N FBY,FBX,T,TAMT,FBAC,FBJ,FBCSID,FBUNITS,FBADJLR,FBADJLA,FBRRMKL,FBFPPSL
 I FBSW=1 D GOTV,HED S FBSW=0,FBGOT=1
 S FBDOS=$S($D(^FBAAC(J,1,K,1,L,0)):$P(^(0),"^",1),1:"")
 S CPT=$P(Z(0),"^",1),A1=$P(Z(0),"^",2)+.0001,A2=$P(Z(0),"^",3)+.0001,A1=$P(A1,".",1)_"."_$E($P(A1,".",2),1,2),A2=$P(A2,".",1)_"."_$E($P(A2,".",2),1,2)
 I CPT]"" S CPT=$$CPT^FBAAUTL4(CPT)
 S T=$P(Z(0),U,5)
 I T]"" S T=$P($G(^FBAA(161.27,+T,0)),U)
 S TAMT=$FN($P(Z(0),U,4),"",2)
 S FBX=$$ADJLRA^FBAAFA(M_","_L_","_K_","_J_",")
 S FBY=$G(^FBAAC(J,1,K,1,L,1,M,2))
 S FBFPPSL=$P(FBY3,U,2)
 S FBCSID=$P(FBY,U,16)
 S FBUNITS=$P(FBY,U,14)
 S FBADJLR=$P(FBX,U)
 F FBJ=1:1 S FBAC=$P(FBADJLR,",",FBJ) Q:FBAC=""  S FBACRR(FBAC)=""
 S FBADJLA=$P(FBX,U,2)
 S FBRRMKL=$$RRL^FBAAFR(M_","_L_","_K_","_J_",")
 S FBMODLE=$$MODL^FBAAUTL4("^FBAAC("_J_",1,"_K_",1,"_L_",1,"_M_",""M"")","E")
 I $Y+4>IOSL W @IOF D HED
 W !!,$E(PNAME,1,26),?33,PSSN,?49,FBCSID
 W !,$$DATX^FBAAUTL(FBDOS),?10,CPT_$S($G(FBMODLE)]"":"-"_$P(FBMODLE,","),1:""),?33,FBUNITS
 I $P($G(FBMODLE),",",2)]"" D
 . N FBI
 . F FBI=2:1 S FBMOD=$P(FBMODLE,",",FBI) Q:FBMOD=""  D
 . . I $Y+4>IOSL W @IOF D HED W !,"  (continued)"
 . . W !,?15,"-",FBMOD
 W !,?10,$J(A1,6),?24,$J(A2,6)
 ; write adjustment reasons, if null then write suspend code
 W ?35,$S(FBADJLR]"":FBADJLR,1:T)
 ; write adjustment amounts, if null then write amount suspended
 W ?49,$S(FBADJLA]"":FBADJLA,1:TAMT)
 W ?66,FBRRMKL
 I FBFPPSC]"" W !,?10,"FPPS Claim ID: ",FBFPPSC,?38,"FPPS Line Item: ",FBFPPSL
 W !
 I FBADJLR="" G:FBA=4&($D(^FBAAC(J,1,K,1,L,1,M,1))) WPFT D
 . S DIWL=1,DIWF="WC79",FBI=FBA K ^UTILITY($J,"W")
 . F FBRR=0:0 S FBRR=$O(^FBAA(161.27,FBI,1,FBRR)) Q:FBRR'>0  S FBXX=^(FBRR,0),X=FBXX D ^DIWP
 . D ^DIWW:$D(FBXX) K FBXX
 Q
ACT ; print table of adjustment reason descriptions
 ; Input 
 ;    FBACRR( - required, array
 ;    FBACRR(FBADJRE)=""
 ;    where FBADJRE = adjustment reason code, external value
 N FBADJRE,FBI,FBACT
 W !,"*Adjustment Code Text:"
 S FBADJRE="" F  S FBADJRE=$O(FBACRR(FBADJRE)) Q:FBADJRE=""  D
 . ; get description of code in FBACT
 . I $$AR^FBUTL1(,FBADJRE,FBSCDT,"FBACT")<0 Q  ; quit if error
 . ; print code and description
 . K ^UTILITY($J,"W")
 . S DIWL=1,DIWF="WC79"
 . ; include code in output
 . S X=$$LJ^XLFSTR("("_FBADJRE_")",7," ") D ^DIWP
 . S DIWF="WC79I7"
 . ; include description in output
 . S FBI=0 F  S FBI=$O(FBACT(FBI)) Q:FBI=""  S X=FBACT(FBI) I X]"" D ^DIWP
 . D ^DIWW
 Q
 ;
HED W !,"PATIENT NAME",?33,"SSN",?49,"PATIENT ACCOUNT NUMBER"
 W !,"SVC DATE",?10,"CPT-MOD",?33,"UNITS"
 W !,?10,"AMT CLAIMED",?24,"AMT PAID",?35,"ADJ CODE",?49,"ADJ AMT",?66,"REMIT REMARKS"
 W !,UL Q
 ;
GOTP ; Utilize new API for Name Standardization
 ;
 S Y(0)=^DPT(J,0),PNAME=$P(Y(0),"^",1),PSSN=$TR($$SSNL4^FBAAUTL($$SSN^FBAAUTL(J)),"-","")
 I PNAME["," D
 .N FBNAMES
 .S FBNAMES("FILE")=2,FBNAMES("IENS")=J_",",FBNAMES("FIELD")=.01
 .S PNAME=$$NAMEFMT^XLFNAME(.FBNAMES)
 Q
SEL W !! S DIC="^FBAA(161.27,",DIC(0)="AEQM" D ^DIC G ENDSL:X=""!(X="^"),SEL:Y<0 S DA=+Y,FBAAS(DA)="",FBSLW=1 G SEL
ENDSL I '$D(FBAAS) W !!,*7,"No suspension codes selected!" G END
 G AHEAD
PSEL F FBA=0:0 S FBA=$O(FBAAS(FBA)) Q:FBA'>0  I $D(^FBAAC("AI",FBA)) F FBDT=BEGDATE-.001:0 S FBDT=$O(^FBAAC("AI",FBA,FBDT)) Q:FBDT'>0!(FBDT>ENDDATE)  D MORE
 G END
WPFT S DIWL=1,DIWF="WC79" K ^UTILITY($J,"W")
 F FBRR=0:0 S FBRR=$O(^FBAAC(J,1,K,1,L,1,M,1,FBRR)) Q:FBRR'>0  S FBXX=^(FBRR,0),X=FBXX D ^DIWP
 D ^DIWW:$D(FBXX) K FBXX
 Q
STRT N FBACRR,FBSCDT S FBSW=1 S Z=$O(^FBAAC("AI",K,BEGDATE-.001)) S FBDT=BEGDATE-.001 F ZZ=0:0 S FBDT=$O(^FBAAC("AI",K,FBDT)) D WPBOT:FBDT'>0&(FBSW=0)!(FBDT>ENDDATE)&(FBSW=0) Q:FBDT'>0!(FBDT>ENDDATE)  S FBSCDT=FBDT D MORE
 Q
