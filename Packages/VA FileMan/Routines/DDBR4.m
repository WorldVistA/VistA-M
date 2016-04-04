DDBR4 ;SFISC/DCL-LOAD CURRENT LIST ;NOV 04, 1996@13:49
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
LOADCL(DDBSA,DDBFLG,DDBPMSG,DDBL,DDBC,DDBLST) ;
 ;DDBSA=source array by value
 ;DDGFLG=no flags currently available
 ;DDBPMSG=text to be displayed (centered) on top line
 ;DDBL=display line default 1st screen/line (22 in most cases)
 ;DDBC=location of column tab array used with right/left arrow keys
 ;DDBLST=location of current list (BROWSER expects ^TMP("DDBLST",$J))
 I $G(DDBSA)']"" N X S X(1)="SOURCE ARRAY("_DDBSA_")" D BLD^DIALOG(202,.X) Q
 I '$D(@DDBSA) N X S X(1)="SOURCE ARRAY("_DDBSA_")" D BLD^DIALOG(202,.X) Q
 N DDBRE,DDBLN,DDBRPE,DDBPSA,DDBTO,I,X,Y
 N DDBFNO,DDBDM,DDBSF,DDBTL,DDBTPG,DDBZN,DDBFTR,DDBHDR,DDBHDRC,DDBST
 S DDBHDR=$$CTXT($G(DDBPMSG,"VA FileMan Browser"),$J("",IOM+1),IOM)
 S DDBHDRC=+$G(DDBHDRC)
 S DDBTL=$P($G(@DDBSA@(0)),"^",3) S:DDBTL'>0 DDBTL=$O(@DDBSA@(" "),-1)
 I DDBTL'>0 D  I DDBTL'>0 D BLD^DIALOG(1700,"*NO TEXT* "_DDBSA) Q
 .N I S I=0 F  S I=$O(@DDBSA@(I)) Q:I'>0  S DDBTL=I
 .Q
 S DDBZN=$D(@DDBSA@(DDBTL,0))#2,DDBTPG=DDBTL\DDBSRL+(DDBTL#DDBSRL'<1),DDBDM=DDBSA="^TMP(""DDB"",$J)",DDBSF=1
 S DDBC=$G(DDBC,"^TMP(""DDBC"",$J)")
 S DDBPSA=0,DDBFLG=$G(DDBFLG)
 S DDBL=$G(DDBL,0) S:DDBL<0 DDBL=0 S:DDBL>DDBTL DDBL=DDBTL
 S (DDBRE,DDBRPE)="",DDBTO=0,DDBST=IOM
 S DDBLST=$G(DDBLST,"^TMP(""DDBLST"",$J)"),DDBLN=$S($D(@DDBLST@("A",DDBSA)):^(DDBSA),1:$O(@DDBLST@(" "),-1)+1)
 D SAVEDDB^DDBR2(DDBLST,DDBLN,1)
 Q
 ;
CTXT(X,T,W) ;Center X in T which is W characters wide (usually spaces) and W for screen width
 Q:X="" $G(T)
 N HW
 S W=$G(W,79),HW=W\2
 S $E(T,HW-($L(X)\2),HW-($L(X)\2)+$L(X))=X Q T
OREF(X) N X1,X2 S X1=$P(X,"(")_"(",X2=$$OR2($P(X,"(",2)) Q:X2="" X1 Q X1_X2_","
OR2(%) Q:%=")"!(%=",") "" Q:$L(%)=1 %  S:"),"[$E(%,$L(%)) %=$E(%,1,$L(%)-1) Q %
 ;
CHDR(D) ;Change Header Message in Window Title
 ;D=direction 1 is down, -1 is up, if 0 restore back to original msg.
 N C
 S C=DDBHDRC+D
 I C<0!(C>DDBTL) W $C(7) Q
 S DDBHDRC=C
ENCHDR I 'DDBHDRC S DDBHDR=$$CTXT^DDBR(DDBPMSG,$J("",IOM+1),IOM)
 E  D
 .I DDBZN S DDBHDR=$$CTXT^DDBR($E(@DDBSA@(DDBHDRC,0),DDBSF,DDBST)_$J("",IOM+1),"",IOM) Q
 .S DDBHDR=$$CTXT^DDBR($E(@DDBSA@(DDBHDRC),DDBSF,DDBST)_$J("",IOM+1),"",IOM)
 .Q
 I DDBRSA S DDBRSA(DDBRSA,"DDBHDRC")=DDBHDRC,DDBRSA(DDBRSA,"DDBHDR")=DDBHDR
 ; repaint screen
 D RPS^DDBRGE
 Q
