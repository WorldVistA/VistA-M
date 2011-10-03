PSIVLB ;BIR/MV - DISPLAY PRINTED LABELS FOR AN ORDER ;30 Aug 2001  4:21 PM
 ;;5.0; INPATIENT MEDICATIONS ;**58,81**;16 DEC 97
 ;
 ; Reference to ^PS(52.6 is supported by DBIA 1231.
 ; Reference to ^PS(52.7 is supported by DBIA 2173.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ;
EN(DFN,ON,PSJALB,MORE) ;
 ;DFN   : Patient IEN
 ;ON    : IV ien#_"V" 
 ;PSJALB: 0 = including all labels 
 ;        1 = Consider active if: 
 ;            NOT Reprinted/Recycled/Cancelled/Destroyed
 ;            NOT Given/Completed in BCMA
 ;        2 = All condition in 1 but include Reprinted as active
 ;            (use for return/destroy)
 ;MORE  : 1 = Display extra info for the label
 ;
 ;This entry point is being from Protocal: PSJ PC IV LABELS ACTION
 ;
 ;* Quit if only display active labels and order is not active
 ;I PSJALB,$S(P(17)="D":1,P(17)="E":1,P(17)="N":1,1:0) Q
 ;
 K ^TMP("PSIVLB",$J),PSJIDLST
 S PSJLN=1 ;PSJLN is incrementting in SETTMP^PSJLMPRU
 S PSJL=""
 S PSIVLBNM="PSIVLB" D PIV^PSJLMPRI(DFN,ON,"","") K PSIVLBNM
 D SETTMP^PSJLMPRU("PSIVLB"," ") S PSJL=""
 S PSJL="------------------------ Labels available for "_$S(PSJALB=2:"return",1:"reprint")_" -------------------------"
 D SETTMP^PSJLMPRU("PSIVLB",PSJL) S PSJL=""
 F PSJLBN=0:0 S PSJLBN=$O(^PS(55,DFN,"IV",+ON,"BCMA",PSJLBN)) Q:'PSJLBN  D
 . NEW X,XX S XX=$G(^PS(55,DFN,"IVBCMA",PSJLBN,0)) Q:XX=""
 . F X=1:1:8 S PSJLB(X)=$P(XX,U,X)
 . I PSJALB=1,$S(PSJLB(7)]"":1,PSJLB(4)]""&("CG"[PSJLB(4)):1,1:0) Q
 . I PSJALB=2,$S(PSJLB(4)]""&("CGIS"[PSJLB(4)):1,PSJLB(7)="RP":0,PSJLB(7)]"":1,1:0) Q
 . S (PSJCNT,PSJIDLST)=$G(PSJCNT)+1
 . S PSJL=$J(PSJCNT,3)_". "_PSJLB(1),PSJLEN=$L(PSJL)+5
 . S PSJIDLST(PSJCNT)=PSJLB(1)
 . S PSJIDLST(PSJLB(1))=PSJLB(1)
 . F PSJAS="AD","SOL" D ADSOL(PSJAS)
 . S X=$S(P(8)]"":P(8),1:P(9)),PSJL=$$SETSTR^VALM1(X,PSJL,PSJLEN,$L(X))
 . D SETTMP^PSJLMPRU("PSIVLB",PSJL) S PSJL=""
 . S X=PSJLB(4) I X]"" D
 .. S X="   BCMA Status: "_$$CODES^PSIVUTL(X,55.0105,2)
 .. S X=X_" "_$$ENDTC^PSGMI(PSJLB(3))
 . S X=PSJLB(8)_X
 . S PSJL=$$SETSTR^VALM1(X,PSJL,PSJLEN,$L(X))
 . D SETTMP^PSJLMPRU("PSIVLB",PSJL) S PSJL=""
 . D:+$G(MORE) MORE
 S VALMCNT=PSJLN-1
 K PSJCNT,PSJLB,PSJLBN,PSJLEN
 Q
ADSOL(PSJAS) ;         
 F PSJADSOL=0:0 S PSJADSOL=$O(^PS(55,DFN,"IVBCMA",PSJLBN,PSJAS,PSJADSOL)) Q:'PSJADSOL  D
 . NEW X,XX,PSJLB S XX=^PS(55,DFN,"IVBCMA",PSJLBN,PSJAS,PSJADSOL,0)
 . F X=1:1:3 S PSJLB(X)=$P(XX,U,X)
 . S X=$S(PSJAS="AD":52.6,1:52.7)
 . S X=$P($G(^PS(X,+PSJLB(1),0)),U)
 . S X=X_" "_PSJLB(2)_$S(PSJLB(3)]"":" ("_PSJLB(3)_")",1:"")
 . S PSJL=$$SETSTR^VALM1(X,PSJL,PSJLEN,$L(X))
 . D SETTMP^PSJLMPRU("PSIVLB",PSJL)
 . S PSJL=""
 Q
MORE ;Display extra data for the label
 D SETTMP^PSJLMPRU("PSIVLB","HELLO") S PSJL=""
 Q
