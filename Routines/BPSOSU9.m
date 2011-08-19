BPSOSU9 ;BHAM ISC/FCS/DRS/FLS - copied for ECME ;03/07/08  10:41
 ;;1.0;E CLAIMS MGMT ENGINE;**1,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;----------------------------------------------------------------------
 ;Standard W and String Formatting Functions
 ;----------------------------------------------------------------------
WCENTER(TEXT,IOM,UL) ;EP
 S:$G(IOM)="" IOM=80
 W ?IOM-$L(TEXT)/2,TEXT,!
 I $G(UL) W ?IOM-$L(TEXT)/2,$TR($J("",$L(TEXT))," ","-"),!
 Q
 ;----------------------------------------------------------------------
 ;W Standard Underlined HEADER
WHEADER(TEXT,IOF,IOM) ;EP
 Q:$G(TEXT)=""
 S:$G(IOF)="" IOF="#"
 S:$G(IOM)="" IOM=80
 W @IOF,!
 D WCENTER(TEXT,IOM)
 D WCENTER($TR($J("",$L(TEXT))," ","-"),IOM)
 Q
 ;----------------------------------------------------------------------
 ;W Column HEADERs (with option to underline)
WCOLUMNS(INDENT,COLDEFS,CNAMES,ULINE) ;EP
 N CHEAD1,CHEAD2,INDEX,CDEF
 Q:$G(CNAMES)=""
 S:$G(INDENT)="" INDENT=0
 S:$G(COLDEFS)="" COLDEFS=2
 S:$G(ULINE)="" ULINE=1
 ;
 S COLDEFS=$J("",COLDEFS)
 S (CHEAD1,CHEAD2)=""
 F INDEX=1:1:$L(CNAMES,",") D
 .S CDEF=$P(CNAMES,",",INDEX)
 .S CHEAD1=CHEAD1_$S(INDEX=1:"",1:COLDEFS)_$$LJBF($P(CDEF,":",1),$P(CDEF,":",2))
 .S:ULINE CHEAD2=CHEAD2_$S(INDEX=1:"",1:COLDEFS)_$TR($J("",$P(CDEF,":",2))," ","-")
 W ?INDENT,CHEAD1,!
 W:ULINE ?INDENT,CHEAD2,!
 Q
 ;----------------------------------------------------------------------
WDATA(INDENT,COLDEFS,VNAMES) ;EP
 N INDEX,DEF,DLINE,VAR,LEN
 Q:$G(VNAMES)=""
 S:$G(INDENT)="" INDENT=0
 S:$G(COLDEFS)="" COLDEFS=2
 ;
 S COLDEFS=$J("",COLDEFS)
 S DLINE=""
 F INDEX=1:1:$L(VNAMES,",") D
 .S DEF=$P(VNAMES,",",INDEX)
 .S VAR=$P(DEF,":",1)
 .S LEN=$P(DEF,":",2)
 .S DLINE=DLINE_$S(INDEX=1:"",1:COLDEFS)_$$LJBF($S(VAR="":"",1:$G(@VAR)),LEN)
 W ?INDENT,DLINE,!
 Q
 ;
 ;----------------------------------------------------------------------
 ;Left justifies and blank fills
LJBF(X,L) ;EP
 Q $E(X_$J("",L-$L(X)),1,L)
 ;----------------------------------------------------------------------
 ;Right justifies and blank fills
RJBF(X,L) ;EP
 Q $E($J("",L-$L(X))_X,1,L)
 ;----------------------------------------------------------------------
 ;CENTER justifies and blank fills
CJBF(X,L) ;
 Q $$LJBF($E($J("",(L-$L(X))\2)_X,1,L),L)
 ;----------------------------------------------------------------------
 ;Convert lower case characters to upper case characters
UCASE(X) ;EP
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;----------------------------------------------------------------------
 ;Convert upper case characters to lower case characters
LCASE(X) ;
 Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 ;----------------------------------------------------------------------
 ;Delete leading and trailing blanks
CLIP(X) ;EP
 F  D  Q:$E(X,1)'=" "
 .S:$E(X,1)=" " X=$E(X,2,$L(X))
 F  D  Q:$E(X,$L(X))'=" "
 .S:$E(X,$L(X))=" " X=$E(X,1,$L(X)-1)
 Q X
