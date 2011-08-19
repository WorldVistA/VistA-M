OCXOED15 ;SLC/RJS,CLA - Rule Editor (Expert System Editor Display) ;6/20/01  10:52
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32,105**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
 ;
S ;
 ;
 Q
EN ;
 ;
 N OCXACT F  K OCXACT S OCXACT="" D DISP(.OCXACT) Q:$$EN^OCXOED16(.OCXACT)
 ;
 Q
 ;
DISP(OCXACT) ;
 ;
 N OCXTHLN,OCXTNLN,OCXTRLN,OCXTULN,OCXTNLN
 S OCXTNLN=$C(27,91,48,109),OCXTRLN=$C(27,91,55,109),OCXTULN=$C(27,91,52,109),OCXTHLN=$C(27,91,49,109)
 ;
 W @IOF,OCXTNLN
 W !,$$CENTER($$FIELD("Expert System Editor Main Screen"),80),!
 I $L($T(VERSION^OCXOCMP)) W !,$$CENTER($$FIELD($$VERSION^OCXOCMP),80),!
 W !
 W !,"       ",$$OPT^OCXOEDT("Rule","EDRULE","16",.OCXACT),"     ",$$FIELD("Edit a Rule")
 W !
 W !,"       ",$$OPT^OCXOEDT("Element","EDELEM","16",.OCXACT),"  ",$$FIELD("Edit an Element")
 W !
 W !,"       ",$$OPT^OCXOEDT("Field","EDDF","16",.OCXACT),"    ",$$FIELD("Edit a Data Field")
 W !
 W !,"       ",$$OPT^OCXOEDT("Comp","COMP","16",.OCXACT),"     ",$$FIELD("Run the Compiler")
 W !
 W !,"       ",$$OPT^OCXOEDT("ScanDF","SCANDF","16",.OCXACT),"   ",$$FIELD("Scan for Data Fields")
 W !
 W !,"       ",$$OPT^OCXOEDT("ScanEL","SCANEL","16",.OCXACT),"   ",$$FIELD("Scan for Elements")
 W !!
 ;
 Q
 ;
CENTER(X,M) ;
 N SP S SP="",$P(SP," ",80)=" " Q $E(SP,1,((M\2)-($L(X)\2)))_X
 ;
SEP(OCXHDR) ;
 ;
 N SPACES S SPACES="",$P(SPACES," ",80-$L(OCXHDR))=" " Q OCXTNLN_OCXTHLN_OCXTULN_$G(OCXHDR)_SPACES_OCXTNLN
 ;
FIELD(OCXHDR) ;
 ;
 Q OCXTHLN_$G(OCXHDR)_OCXTNLN
 ;
DATA(OCXVAL,OCXLEN) ;
 ;
 N SPACES S SPACES="",$P(SPACES," ",OCXLEN+5)=" ",OCXVAL=$G(OCXVAL)
 I ($L(OCXVAL)>OCXLEN) Q $E(OCXVAL,1,OCXLEN-3)_"..."
 Q $E((OCXVAL_SPACES),1,OCXLEN)
 ;
 ;
DIC(OCXDIC,OCXDIC0,OCXDICA,OCXX,OCXDICS,OCXDR) ;
 ;
 N DIC,X,Y
 S DIC=$G(OCXDIC) Q:'$L(DIC) -1
 S DIC(0)=$G(OCXDIC0) S:$L($G(OCXX)) X=OCXX
 S:$L($G(OCXDICS)) DIC("S")=OCXDICS
 S:$L($G(OCXDICA)) DIC("A")=OCXDICA
 S:$L($G(OCXDR)) DIC("DR")=OCXDR
 D ^DIC Q:(Y<1) 0 Q Y
 ;
