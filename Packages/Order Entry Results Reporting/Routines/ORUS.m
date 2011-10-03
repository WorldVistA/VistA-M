ORUS ; slc/KCM - Display List of Items ;6/2/92  08:09
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**91**;Dec 17, 1997
 ;
EN S Y=-1 Q:'$D(ORUS)!('$D(ORUS(0)))  S:'($D(IO)#2) IO="HOME" I 'IO S IOP=$S($D(ORIO):ORIO,1:"") D ^%ZIS
 D INIT^ORUS5
 I ORUS(0)["M" F I=0:0 D HDR,MOVE^ORUS5,SHOW,EN^ORUS1 I 'ORBACK Q:'ORMOR  Q:ORQUIT
 I ORUS(0)'["M" D:ORUS(0)["N" SORB D SORB1,EN^ORUS1
END K %,A,B,J,K,L,M,N,O,OR9,OR9Y,ORBACK,ORBUF,ORCO,ORCW,ORDA,ORDFLT,OREN,ORENL,ORENLA,ORERR,ORFLG,ORFN,ORFND,ORFNM,ORHL,ORITM,ORLK,ORMOR,ORNC,ORND,ORNE,ORNOSEL,OROD,ORPC,ORPRMT,ORPTR,ORQUIT,ORSC
 K ORUS,ORSEL,ORSEQ,ORSEQL,ORSUB,ORT9,ORTTAB,ORTB,ORTOT,ORWR,ORWRK,P,S,W,X,^XUTL("OR",$J,"ORU"),^("ORV"),^("ORW")
 Q
SHOW S L=0  ;changed 9/18/00 by CLA for OR*3*91:
 N ORTXT
 F  S L=$O(^XUTL("OR",$J,"ORV",P,L)) Q:L>ORCO!(L="")  D
 . W ! F J=0:1:ORNC-1 S X=L+(J*ORCO) I $D(^XUTL("OR",$J,"ORV",P,X)) D
 .. W ?(J*ORTB),$P(^XUTL("OR",$J,"ORV",P,X),"^",2),?(J*ORTB+5)
 .. S ORTXT=$E($P(^XUTL("OR",$J,"ORV",P,X),"^"),1,ORTB-5)
 .. F  Q:'(ORTXT["|SP")  S ORTXT=$P(ORTXT,"|",1)_$$SPACE(+$P($P(ORTXT,"|",2),"SP",2))_$P(ORTXT,"|",3,999)
 .. W ORTXT
 .. I ^(X)="MORE...^999",'$D(OR9(999)) S I=999,OR9(I)=^(X) D S91
 Q
HDR S (DX,DY)=0 X ^%ZOSF("XY") X:$D(ORUS("T")) ORUS("T") S ORHL=$Y K DX,DY Q
S9 S OR9(I)=ORUS(900,I) S:'$L($P(OR9(I),"^",2)) $P(OR9(I),"^",2)=900+I
S91 S:$L($P(OR9(I),"^",1)) OR9("B",$P(OR9(I),"^",1),I)="" S:$L($P(OR9(I),"^",2)) OR9("B",$P(OR9(I),"^",2),I)=""
 Q
SORB I 'OREN S O=OROD,A="",S=0 F I=0:0 S A=$O(@(O_"A)")) Q:A=""  S B="" F  S B=$O(@(O_"A,B)")) Q:B=""  I $D(@(ORUS_"B,0)")) S ORDA=B X ORSC I $T,$D(@(ORUS_"B,0)")) X ORWR I $L(X) S S=S+1,^XUTL("OR",$J,"ORW",S)=B
 I OREN S O=OROD,(B,S)=0 F I=0:0 S B=$O(@(O_"B)")) Q:B=""  I $D(@(ORUS_"B,0)")) S ORDA=B X ORSC I $T,$D(@(ORUS_"B,0)")) X ORWR I $L(X) S S=S+1,^XUTL("OR",$J,"ORW",S)=B
 Q
SORB1 F I=0:0 S I=$O(ORUS(900,I)) Q:I'>0  D S9
 I ORUS(0)["Q" S I=998,OR9(I)="OTHER "_ORFNM_"^998" D S91
 Q
SPACE(NUMSP) ; added by CLA 9/18/00 for OR*3*91 - return NUMSP blank spaces
 Q:+$G(NUMSP)<1 ""
 N SPACES
 S SPACES=""
 S $P(SPACES," ",NUMSP)=" "
 Q SPACES
EN1 ;Display but not prompt (accept RETURN only)
 Q:'$D(ORUS)!('$D(ORUS(0)))  S ORUS("A")="Press RETURN to continue ",ORUS(0)=ORUS(0)_"M",ORNOSEL=1,ORUS("H")="W !,""Press RETURN key to continue.""" G EN
