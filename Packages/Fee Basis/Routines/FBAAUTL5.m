FBAAUTL5 ;ACAMPUS/DMK-UTILITY ROUTINE ;4/17/2000
 ;;3.5;FEE BASIS;**3,4,21**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
INPUT ;called from input transform of 163.99 to determine if CPT and
 ;or modifier is a valid entry in appropriate file.
 Q:'$D(X)
 N A,B,FBI,FBMOD,FBMODA,FBMODX
 ;
 S A=$P(X,"-"),B=$P(X,"-",2)
 ;
 ;sort modifiers so lookups will work
 I B]"" D  S $P(X,"-",2)=B
 . F FBI=1:1 S FBMOD=$P(B,",",FBI) Q:FBMOD=""  S FBMODA(FBMOD)=""
 . S (FBMOD,B)=""
 . F  S FBMOD=$O(FBMODA(FBMOD)) Q:FBMOD=""  S B=B_","_FBMOD
 . S:$E(B)="," B=$E(B,2,999)
 ;
 ; check for valid pattern
 I ('(X?5AN)&'(X?5AN1"-"2AN.17(1","2AN,1""))) K X Q
 ;
 ;check for valid CPT code
 I $P($$CPT^ICPTCOD(A,"",1),U)'>0 D EN^DDIOL("CPT code not valid!") K X Q
 ;
 ; check for valid modifiers
 I B]"" F FBI=1:1 S FBMOD=$P(B,",",FBI) Q:FBMOD=""  D
 . S FBMODX=$$MOD^ICPTMOD(FBMOD,"E")
 . ; if modifier data not obtained then try another API to resolve it
 . ; since there can be duplicate modifiers with same external value
 . I $P(FBMODX,U)'>0 D
 . . N FBY
 . . S FBY=$$MODP^ICPTMOD(A,FBMOD,"E")
 . . I $P(FBY,U)>0 S FBMODX=$$MOD^ICPTMOD($P(FBY,U),"I")
 . I $P(FBMODX,U)'>0 D EN^DDIOL("CPT Modifier "_FBMOD_" not valid!") K X
 Q:'$D(X)
 ;
 ;display
 S FBX="CPT: "_$P($$CPT^ICPTCOD(A,"",1),U,3)
 D EN^DDIOL(FBX,"","!?20")
 I B]"" F FBI=1:1 S FBMOD=$P(B,",",FBI) Q:FBMOD=""  D
 . S FBMODX=$$MOD^ICPTMOD(FBMOD,"E")
 . ; if modifier data not obtained then try another API to resolve it
 . ; since there can be duplicate modifiers with same external value
 . I $P(FBMODX,U)'>0 D
 . . N FBY
 . . S FBY=$$MODP^ICPTMOD(A,FBMOD,"E")
 . . I $P(FBY,U)>0 S FBMODX=$$MOD^ICPTMOD($P(FBY,U),"I")
 . S FBX="MOD: "_FBMOD_"  "_$P(FBMODX,U,3)
 . D EN^DDIOL(FBX,"","!?20")
 Q
 ;
PSA(X) ;get psa from institution
 ;input   X = ien of psa
 ;output  station number from instutution file\
 Q $S($D(^DIC(4,+$G(X),99)):$E(^(99),1,3),1:"")
 ;
EXTPV(X) ;call used to determine Purpose of Visit Austin code
 ;               x = pointer to 161.82
 ;               Output = Austin code
 Q $S('$G(X):"",1:$P($G(^FBAA(161.82,+X,0)),U,3))
SUB(X) ;used to get station number and substation if one exists
 ;from the IFCAP software. This call is used during
 ;transmission of payment batches to Austin.
 ;
 ; X = "STATION NUMBER-OBLIGATION NUMBER"
 ;      EXAMPLE:  699-C12345
 I '+$G(X) Q ""
 N PRCS,Y
 S PRCS("X")=X,PRCS("TYPE")="FB"
 D EN1^PRCS58 ;call to IFCAP to get obligation information
 K PRCSCPAN
 I Y=-1 Q ""
 Q $S($P(Y,U,10)]"":$P(Y,U,10),1:$E($P(Y,U,2),1,3))
