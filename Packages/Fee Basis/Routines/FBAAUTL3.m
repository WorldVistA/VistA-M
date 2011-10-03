FBAAUTL3 ;AISC/DMK-FEE BASIS UTILITY ROUTINE ;5/12/93  13:42
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
HDR() ;this is a supported call to be used by IFCAP to determine
 ;the System Identifier for the 994 code sheets
 ;Q $S($P($G(^FBAA(161.4,1,1)),U,10)]"":$P(^(1),U,10),1:"FEN")
 Q $S($$VER5():"FEN",1:"FEE")
 ;
POV(X) ;determine ien of pov based on austin code
 ;INPUT:  X = pov code
 ;OUTPUT: ien of active record containing passed pov code or 0
 S:X']"" X=0
 Q +$O(^FBAA(161.82,"AC",X,0))
 ;
RCOMP ;entry point to re-compile templates
 S:'$D(DTIME) DTIME=300 S U="^"
 S DIR(0)="Y",DIR("A")="Re-compile FB input templates" D ^DIR K DIR G RCOMPQ:'Y
 S $P(QQ,"=",81)="" W !!?17,"Recompilation of Fee Basis Input Templates",!,QQ
 S FBMAX=^DD("ROU") F FBX="FB VENDOR UPDATE","FBAA AUTHORIZATION" S Y=$O(^DIE("B",FBX,0)) Q:'Y  I $D(^DIE(Y,"ROUOLD")),^("ROUOLD")]"",$D(^(0)) S X=$P(^("ROUOLD"),"^"),DMAX=FBMAX D EN^DIEZ
RCOMPQ ;kill off variables and exit re-compile option
 K DMAX,FBX,Y,X,QQ,FBMAX
 Q
 ;
UP(X) ;entry point to convert lower case to upper case letters
 I $G(X)']"" Q 0
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
YN ;called from input transform on Yes - No type fields to allow
 ;a user to enter:
 ;              1 = Yes     0 = No  stores Y or N
 ;
 S X=$E($$UP^FBAAUTL3(X))
 S X=$S(X:"Y",X="Y":X,X="N":X,X=0:"N",1:2)
 I X'=2 W "  (",$S(X="Y":"YES",1:"NO"),")" Q
 W *7,!?4,"NOT A VALID ENTRY!" K X
 Q
 ;
OUTYN ;called from output transform on fields that are defined as Y/N
 ;
 S Y=$S(Y="Y":"YES",Y="N":"NO",1:"")
 Q
 ;
VER5() ;returns '1' if site is running version 5 of IFCAP
 ;used to handle record layouts for FMS payments
 N X
 ;S X=$G(^DIC(9.4,+$O(^DIC(9.4,"C","PRC",0)),"VERSION"))
 S X=$$VERSION^XPDUTL("PRC")
 Q $S(+X>4:1,1:0)
 ;
IDCHK(DFN,AUTH) ;call to check if authorization being paid is
 ;an ID card.  Called during payment process.
 ;DFN = patients internal entry number
 ;AUTH= internal entry number of authorization in 161.
 ;both are required
 I $S('$G(DFN):1,'$G(AUTH):1,1:0) Q 0
 Q $S('$D(^FBAAA(+DFN,1,+AUTH,0)):0,$P(^(0),U,13)=3:1,1:0)
