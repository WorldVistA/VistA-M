PSOORDA ;ISC-BHAM/LC - build detailed allergy list ;12/10/04 8:29am
 ;;7.0;OUTPATIENT PHARMACY;**44,139,152,186**;DEC 1997
 ;External reference to EN1^GMRADPT supported by DBIA 10099
 ;External reference to EN1^GMRAOR2 supported by DBIA 2422
 ;
 ;Inpatient Pharmacy's DBIA 2211 allows reference to ^TMP("PSJAL" and ^TMP("PSJDA"
 ;
 ;PSO*7*186 Newing of variables to protect their global values
 ;
BEG(DFN) N VALMCNT,DR,IEN S GMRA="0^0^111",IEN=0 D EN1^GMRADPT
 NEW PSONSP S PSONSP=$S($G(PSJINPT):"PSJDA",1:"PSODA")
 K ^TMP(PSONSP,$J) I 'GMRAL S IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)=$S($G(GMRAL)=0:"No Known Allergies",'GMRAL:"Patient has not been asked about allergies",1:"")
 S (OT,FD,DG,LTO,VY,NVY,VDG,VDGF,VDGFO,VDGO,VFD,VFDO,VOT,NDG,NDGF,NDGFO,NDGO,NFD,NFDO,NOT)=0,(NU,TY)="" D:$G(GMRAL)
 .F DR=0:0 S DR=$O(GMRAL(DR)) Q:'DR  S AG($S($P(GMRAL(DR),"^",4):1,1:2),$P(GMRAL(DR),"^",7),$P(GMRAL(DR),"^",2))=DR_"^"_$P(GMRAL(DR),"^",2)_"^"_+$P(GMRAL(DR),"^",4)_"^"_+$P(GMRAL(DR),"^",8)
 .F  S NU=$O(AG(NU)) Q:'NU  S:NU=1 VY=1 S:NU=2 NVY=1 F  S TY=$O(AG(NU,TY)) Q:TY=""  D
 ..S:VY&(TY="D") VDG=1 S:VY&(TY="DF") VDGF=1 S:VY&(TY="DFO") VDGFO=1 S:VY&(TY="DO") VDGO=1 S:VY&(TY="F") VFD=1 S:VY&(TY="FO") VFDO=1 S:VY&(TY="O") VOT=1
 ..S:NVY&(TY="D") NDG=1 S:NVY&(TY="DF") NDGF=1 S:NVY&(TY="DFO") NDGFO=1 S:NVY&(TY="DO") NDGO=1 S:NVY&(TY="F") NFD=1 S:NVY&(TY="FO") NFDO=1 S:NVY&(TY="O") NOT=1
 .S:VY IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="    Verified"
 .S:VDG IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="     Drug: "
 .S AL="" F  S AL=$O(AG(1,"D",AL)) Q:AL=""  D
 ..S DG=DG+1,IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="       "_DG_" "_AL,AGN(DG)=$P(AG(1,"D",AL),"^")
 .S:VDGF IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="     Drug/Food: "
 .S AL="" F  S AL=$O(AG(1,"DF",AL)) Q:AL=""  D
 ..S DG=DG+1,IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="       "_DG_" "_AL,AGN(DG)=$P(AG(1,"DF",AL),"^")
 .S:VDGFO IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="     Drug/Food/Other: "
 .S AL="" F  S AL=$O(AG(1,"DFO",AL)) Q:AL=""  D
 ..S DG=DG+1,IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="       "_DG_" "_AL,AGN(DG)=$P(AG(1,"DFO",AL),"^")
 .S:VDGO IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="     Drug/Other: "
 .S AL="" F  S AL=$O(AG(1,"DO",AL)) Q:AL=""  D
 ..S DG=DG+1,IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="       "_DG_" "_AL,AGN(DG)=$P(AG(1,"DO",AL),"^")
 .S:VFD IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="     Food: "
 .S AL="" F  S AL=$O(AG(1,"F",AL)) Q:AL=""  D
 ..S FD=FD+1,IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="       "_(FD+DG)_" "_AL,AGN(FD+DG)=$P(AG(1,"F",AL),"^")
 .S:VFDO IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="     Food/Other: "
 .S AL="" F  S AL=$O(AG(1,"FO",AL)) Q:AL=""  D
 ..S FD=FD+1,IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="       "_(FD+DG)_" "_AL,AGN(FD+DG)=$P(AG(1,"FO",AL),"^")
 .S:VOT IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="    Other: "
 .S AL="" F  S AL=$O(AG(1,"O",AL)) Q:AL=""  D
 ..S OT=OT+1,IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="       "_(OT+FD+DG)_" "_AL,AGN(OT+FD+DG)=$P(AG(1,"O",AL),"^")
 .S IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="        ",LTO=(OT+FD+DG),(OT,FD,DG)=0
 .S:NVY IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="Non-Verified"
 .S:NDG IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="     Drug: "
 .S AL="" F  S AL=$O(AG(2,"D",AL)) Q:AL=""  D
 ..S DG=DG+1,IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="       "_(DG+LTO)_" "_AL,AGN(DG+LTO)=$P(AG(2,"D",AL),"^")
 .S:NDGF IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="     Drug/Food: "
 .S AL="" F  S AL=$O(AG(2,"DF",AL)) Q:AL=""  D
 ..S DG=DG+1,IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="       "_(DG+LTO)_" "_AL,AGN(DG+LTO)=$P(AG(2,"DF",AL),"^")
 .S:NDGFO IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="     Drug/Food/Other: "
 .S AL="" F  S AL=$O(AG(2,"DFO",AL)) Q:AL=""  D
 ..S DG=DG+1,IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="       "_(DG+LTO)_" "_AL,AGN(DG+LTO)=$P(AG(2,"DFO",AL),"^")
 .S:NDGO IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="     Drug/Other: "
 .S AL="" F  S AL=$O(AG(2,"DO",AL)) Q:AL=""  D
 ..S DG=DG+1,IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="       "_(DG+LTO)_" "_AL,AGN(DG+LTO)=$P(AG(2,"DO",AL),"^")
 .S:NFD IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="     Food: "
 .S AL="" F  S AL=$O(AG(2,"F",AL)) Q:AL=""  D
 ..S FD=FD+1,IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="       "_(FD+DG+LTO)_" "_AL,AGN(FD+DG+LTO)=$P(AG(2,"F",AL),"^")
 .S:NFDO IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="     Food/Other: "
 .S AL="" F  S AL=$O(AG(2,"FO",AL)) Q:AL=""  D
 ..S FD=FD+1,IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="       "_(FD+DG+LTO)_" "_AL,AGN(FD+DG+LTO)=$P(AG(2,"FO",AL),"^")
 .S:NOT IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="    Other: "
 .S AL="" F  S AL=$O(AG(2,"O",AL)) Q:AL=""  D
 ..S OT=OT+1,IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="       "_(OT+FD+DG+LTO)_" "_AL,AGN(OT+FD+DG+LTO)=$P(AG(2,"O",AL),"^")
 S PSODA=IEN,PSOALL=(OT+FD+DG+LTO)
 S:$D(PSJINPT) PSJDA=IEN,PSJALL=(OT+FD+DG+LTO)
 K AL,AG,DG,FD,GMRA,GMRAL,LTO,NU,OT,TY,VY,VDG,VDGF,VDGFO,VDGO,VFD,VFDO,VOT,NDG,NDGF,NDGFO,NDGO,NFD,NFDO,NOT,NVY
 Q
SEL ;select allergy for detail display
 N ORD,ORN,IEN,VALMCNT I '$G(PSOALL) S VALMSG="This patient has no Allergies!" S VALMBCK="" Q
 K DIR,DUOUT,DIRUT S DIR("A")="Select Allergies by number",DIR(0)="LO^1:"_PSOALL D ^DIR I $D(DTOUT)!($D(DUOUT)) K DIR,DIRUT,DTOUT,DUOUT S VALMBCK="" Q
SELAL N ORD,ORN,IEN,VALMCNT                                      ;PSO*7*186
 K DIR,DIRUT,DTOUT,DTOUT S PSOELSE=+Y I +Y S ALST=Y D FULL^VALM1 D
 .F ORD=1:1:$L(ALST,",") Q:$P(ALST,",",ORD)']""  S ORN=+$P(ALST,",",ORD) D DSPLY(DFN)
 ;S PSONSP=$S($G(PSJINPT):"PSJAL",1:"PSODA")
 I 'PSOELSE S VALMBCK=""
 K ALST,PSOELSE
 Q
DSPLY(DFN) ;build detailed allergy display
 NEW PSONSP S PSONSP=$S($G(PSJINPT):"PSJAL",1:"PSOAL")
 K ^TMP(PSONSP,$J),AGNL S IEN=0,NB=$G(AGN(ORN)) D EN1^GMRAOR2(NB,"AGNL")
 S IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="  Causative Agent: "_$P(AGNL,"^")
 S IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="                                  "
 S ^TMP(PSONSP,$J,IEN,0)=^TMP(PSONSP,$J,IEN,0)_"                  Severity: "
 S I="" F  S I=$O(AGNL("O",I)) Q:I=""  D
 . I $P(AGNL("O",I),"^",2)="" Q
 . S X=$$DT(+AGNL("O",I))_" "_$P(AGNL("O",I),"^",2)
 . I I=$O(AGNL("O","")) S ^TMP(PSONSP,$J,IEN,0)=^TMP(PSONSP,$J,IEN,0)_X Q
 . S IEN=IEN+1,$E(^TMP(PSONSP,$J,IEN,0),63)=X
 ;get ingredients
 S (ING,ING1)="" I $D(AGNL("I")) F IT=0:1 S IN=$O(AGNL("I",IT)) Q:'IN  D
 .S:$L(ING_";"_$P($G(AGNL("I",IN)),"^"))>230 ING1=ING1_";"_$P($G(AGNL("I",IN)),"^")
 .S:$L(ING_";"_$P($G(AGNL("I",IN)),"^"))<230 ING=ING_";"_$P($G(AGNL("I",IN)),"^")
 S IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="      Ingredients: ",ING=$E(ING,2,99999),ING1=$E(ING1,2,99999)
ING F IG=1:1:$L(ING) Q:$P(ING,";",IG)=""  S LCC=IG,LC=0
 F IG=1:1:$L(ING) Q:$P(ING,";",IG)=""  D
 .S:$L(^TMP(PSONSP,$J,IEN,0)_$P(ING,";",IG))>50 LC=LC+1,IEN=IEN+1,$P(^TMP(PSONSP,$J,IEN,0)," ",19)=" "
 .S ^TMP(PSONSP,$J,IEN,0)=$G(^TMP(PSONSP,$J,IEN,0))_$P(ING,";",IG)_$S($G(LC)=0&($G(IG)=LCC):"",$G(IG)<LCC:", ",$G(LC)>0&($G(IG)=LCC):"",$G(LC)>0&($G(IG)<LCC):", ",1:"")
 I '$D(ING2)&($G(ING1)]"") S ING2=1,ING=ING1 G ING
 S IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="" S ODT=$S($D(AGNL("C",1)):$P(AGNL("C",1),"^"),1:"*******.******"),OD=$P(ODT,".")
 ;
 ;get drug class
 S CLS="" I $D(AGNL("V")) F CT=0:1 S CPT=$O(AGNL("V",CT)) Q:'CPT  S CLS=CLS_","_$P($G(AGNL("V",CPT)),"^",2)
 S IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="    VA Drug Class: ",CLS=$E(CLS,2,99999)
 F CG=1:1:$L(CLS) Q:$P(CLS,",",CG)=""  S LCC=CG,LC=0
 F CG=1:1:$L(CLS) Q:$P(CLS,",",CG)=""  D
 .S:$L(^TMP(PSONSP,$J,IEN,0)_$P(CLS,",",CG))>50 IEN=IEN+1,$P(^TMP(PSONSP,$J,IEN,0)," ",19)=" "
 .S ^TMP(PSONSP,$J,IEN,0)=$G(^TMP(PSONSP,$J,IEN,0))_$P(CLS,",",CG)_$S($G(LC)=0&($G(CG)=LCC):"",$G(CG)<LCC:", ",$G(LC)>0&($G(CG)=LCC):"",$G(LC)>0&($G(CG)<LCC):", ",1:"")
 ;
 S IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="       Originated: "_$E(OD,4,5)_"/"_$E(OD,6,7)_"/"_$E(OD,2,3)
 S ^TMP(PSONSP,$J,IEN,0)=^TMP(PSONSP,$J,IEN,0)_"                       Originator: "_$P(AGNL,"^",2)
 S IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="         Verified: "_$S($P(AGNL,"^",4)="VERIFIED":"Yes",$P(AGNL,"^",4)="NOT VERIFIED":"No ",1:"   ")
 S ^TMP(PSONSP,$J,IEN,0)=^TMP(PSONSP,$J,IEN,0)_"                              OBS/Hist: "_$P(AGNL,"^",5)
 S IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)=""
 ;get originator comments
 S IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="         Comments: "  ;,ORC=$E(ORC,2,99999)
 ;S ORC="" I $D(AGNL("C",1)) F ORT=0:0 S ORT=$O(AGNL("C",1,ORT)) Q:'ORT!(ORT>8)!($L(ORC)+$L($G(AGNL("C",1,ORT,0)))>432)  S ORC=ORC_";"_$G(AGNL("C",1,ORT,0))
 ;S ORC=$E(ORC,2,99999) F OG=1:1:$L(ORC) Q:$P(ORC,";",OG)=""  S:$L(^TMP(PSONSP,$J,IEN,0)_$P(ORC,";",OG))>75 IEN=IEN+1,$P(^TMP(PSONSP,$J,IEN,0)," ",1)=" " S ^TMP(PSONSP,$J,IEN,0)=$G(^TMP(PSONSP,$J,IEN,0))_" "_$P(ORC,";",OG)
 I $D(AGNL("C",1)) F ORT=0:0 S ORT=$O(AGNL("C",1,ORT)) Q:'ORT  S IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)=$G(AGNL("C",1,ORT,0))
 ;get signs/symptoms
 S IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)=""
 S SYM="" I $D(AGNL("S")) F SNM=0:0 S SNM=$O(AGNL("S",SNM)) Q:'SNM  S SYM=SYM_","_$G(AGNL("S",SNM))
 S IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="   Signs/Symptoms: ",SYM=$E(SYM,2,99999)
 F SG=1:1:$L(SYM) Q:$P(SYM,",",SG)=""  S LCC=SG,LC=0
 F SG=1:1:$L(SYM) Q:$P(SYM,",",SG)=""  D
 .S:$L(^TMP(PSONSP,$J,IEN,0)_$P(SYM,",",SG))>50 IEN=IEN+1,$P(^TMP(PSONSP,$J,IEN,0)," ",19)=" "
 .S ^TMP(PSONSP,$J,IEN,0)=$G(^TMP(PSONSP,$J,IEN,0))_$P(SYM,",",SG)_$S($G(LC)=0&($G(SG)=LCC):"",$G(SG)<LCC:", ",$G(LC)>0&($G(SG)=LCC):"",$G(LC)>0&($G(SG)<LCC):", ",1:"")
 S IEN=IEN+1,^TMP(PSONSP,$J,IEN,0)="        Mechanism: "_$P(AGNL,"^",6)
 ;
 I $D(PSJINPT) S PSJAL=IEN D EXT Q
 S PSOAL=IEN D EN^PSOLMAL
EXT K AGNL,CG,CLS,CPT,CT,IG,IN,ING,ING1,ING2,IPT,IT,LC,LCC,NB,NUM,OD,ODT,OG,ORC,ORT,SG,SNM,SYM,Y
 Q
DT(DT) ; - Convert FM Date to MM/DD/YYYY
 Q $E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
