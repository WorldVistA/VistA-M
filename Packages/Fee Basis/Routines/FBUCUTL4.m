FBUCUTL4 ;ALBISC/TET - UTILITY CONTINUATION ;5/14/93  15:06
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
PRIME(FBDA,FBUCP) ;determine if claim is a primary (points to itself)
 ;INPUT:  FBDA = ien of unauthorized claim
 ;        FBUCP = zero node of fbda
 ;OUTPUT: 1 if yes, 0 if no
 Q $S('+$G(FBDA):0,$G(FBUCP)']"":0,FBDA=$P(FBUCP,U,20):1,1:0)
 ;
SECOND(FBDA,FBUCP) ;determine if claim is a secondary (points to another)
 ;INPUT:  FBDA = ien of unauthorized claim
 ;        FBUCP = zero node of fbda
 ;OUTPUT: 1 if yes, 0 if no
 Q $S('+$G(FBDA):0,$G(FBUCP)']"":0,FBDA'=$P(FBUCP,U,20):1,1:0)
 ;
LINK(FBDA,FBUCP) ;is this a claim which can be linked to a primary?
 ;claims which can be linked are only primaries with no secondaries OR only secondaries
 ;INPUT:  FBDA = ien of unauthorized claim
 ;        FBUCP = zero node of unauthorized claim
 ;OUTPUT: 1 if yes, 0 if no
 I $S('+$G(FBDA):1,$G(FBUCP)']"":1,1:0) Q 0
 Q $S($$SECOND(FBDA,FBUCP):1,$$PRIME(FBDA,FBUCP)&('+$O(^FB583("AMS",+$P(FBUCP,U,20),0))):1,1:0)
 ;
LINKTO(FBDA,FBUCP,FBLINK) ;is this a primary claim to which a secondary can be linked?
 ;claim which is a primary and not claim selected to be linked
 ;INPUT:  FBDA = ien of unauthorized claim
 ;        FBUCP = zero node of unauthorized claim
 ;        FBLINK = claim ien which is to be linked
 ;OUTPUT: 1 if yes, 0 if no
 I $S('+$G(FBDA):1,$G(FBUCP)']"":1,'+$G(FBLINK):1,1:0) Q 0
 Q $S($$PRIME(FBDA,FBUCP)&(FBDA'=FBLINK):1,1:0)
 ;
ID ;display identifiers
 N FBZ S FBZ=$$FBZ^FBUCUTL(+Y)  Q:Y']""  W ?15,$E($$VET^FBUCUTL(+$P(FBZ,U,4)),1,20),?38,$E($$VEN^FBUCUTL(+$P(FBZ,U,3)),1,20)
 W ?61,$E($$PROG^FBUCUTL(+$P(FBZ,U,2)),1,14),!,$E($P($$PTR^FBUCUTL("^FB(162.92,",+$P(FBZ,U,24)),U),1,16)
 W ?19,"TREATMENT FROM: ",$$DATX^FBAAUTL(+$P(FBZ,U,5)),?44,"TREATMENT TO: ",$$DATX^FBAAUTL(+$P(FBZ,U,6))
 W ! Q
PARSE(FBARY) ;set piece positions variable, and get # of pieces for printing
 ;INPUT:  FBARY = (not subscripted) - piece positions
 ;OUTPUT: FBW = piece positions
 ;        FBPL = # of pieces
 S FBARY=$G(FBARY),FBW=$P(FBARY,";",2),FBPL=($L(FBW,"^"))-1
 Q
LINE(FBARY,FBI,FBPL,FBW) ;write line
 ;INPUT:  FBPL = # of pieces
 ;        FBW = piece positions
 ;        FBARY = specific array entry
 ;OUTPUT: write line of info
 N FBP,FBY S FBY=$P(FBARY,";",2) W:$L(FBARY,"^")>5 ! W !,$S($L(FBI)<2:" ",1:""),FBI F FBP=1:1:FBPL Q:$P(FBY,U,FBP)']""  D
 .I $P(FBY,U,FBP)="!" W ! I FBP>1 S FBW=$P(FBW,U,1,FBP-1)_U_"!"_U_$P(FBW,U,FBP,FBPL)
 .I $P(FBY,U,FBP)'="!" W ?($P(FBW,U,FBP)),$P(FBY,U,FBP)
 Q
FBO() ;set fbo string if 0 or not defined
 N FBI,Z S FBI=0 F  S FBI=$O(^FB(162.92,FBI)) Q:'FBI  S Z=$G(^FB(162.92,FBI,0)) I $P(Z,U,2),$P(Z,U,4) S FBO=$S(+$G(FBO):FBO_$P(Z,U,4)_U,1:$P(Z,U,4)_U)
 Q $G(FBO)
 ;
PAD(L,V,C,O) ;set fixed length field
 ;INPUT:  L=length of field/V=variable/C=character to append/O=order
 ;          1 for beginning,2 for ending
 ;OUTPUT: fixed length field
 N X S $P(X,C,L)="" I O=2 S V=V_($E(X,1,(L-$L(V))))
 I O=1 S V=($E(X,1,(L-$L(V))))_V
 Q $G(V)
