FBAAUTL4 ;AISC/CMR,dmk,WCIOFO/SAB-UTILITY ROUTINE ;7/11/2001
 ;;3.5;FEE BASIS;**4,32,77,81**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CPT(X,Y,FBSRVDT) ;return external format of CPT code
 ;INPUT   X = ien of CPT
 ;optional Y I Y return description, I 'Y return external format of CPT
 ;optional FBSRVDT - date of service
 ;OUTPUT  external format of CPT code or description of CPT code
 I '$G(X) Q ""
 N Z
 S Z=$$CPT^ICPTCOD(X,$S($G(FBSRVDT)>0:+$G(FBSRVDT),1:""),1)
 Q $S('$G(Y):$P(Z,U,2),1:$P(Z,U,3))
 ;
MOD(X,Y,FBSRVDT) ;return external format of modifier
 ;INPUT   X = ien of modifier
 ;optional Y I Y return description, I 'Y return external format of mod
 ;optional FBSRVDT - date of service
 ;OUTPUT  external format of modifier or description of CPT code
 I '$G(X) Q ""
 N Z
 S Z=$$MOD^ICPTMOD(X,"I",$S($G(FBSRVDT)>0:+$G(FBSRVDT),1:""),1)
 Q $S('$G(Y):$P(Z,U,2),1:$P(Z,U,3))
 ;
CPTDATA(W,X,Y,Z) ;get internal value of CPT
 ; input
 ;   W = IEN of PATIENT in file 162
 ;   X = IEN of VENDOR multiple in file 162
 ;   Y = IEN of INITIAL TREATMENT DATE multiple in file 162
 ;   Z = IEN of SERVICE PROVIDED multiple in file 162
 ; returns
 ;   value of SERVICE PROVIDED (internal)
 ;
 I '$G(W)!('$G(X))!('$G(Y))!('$G(Z)) Q ""
 Q $P($G(^FBAAC(W,1,X,1,Y,1,Z,0)),U)
 ;
MODDATA(W,X,Y,Z) ;get internal values of CPT Modifier
 ; input
 ;   W = IEN of PATIENT in file 162
 ;   X = IEN of VENDOR multiple in file 162
 ;   Y = IEN of INITIAL TREATMENT DATE multiple in file 162
 ;   Z = IEN of SERVICE PROVIDED multiple in file 162
 ; output
 ;   FBMODA( array of CPT MODIFIERs
 ;     FBMODA(#)=CPT MODIFIER (internal value)
 ;     where # is the IEN for an entry in the CPT MODIFIER multiple
 K FBMODA
 I '$G(W)!('$G(X))!('$G(Y))!('$G(Z)) Q
 N FBI,FBMOD
 S FBI=0 F  S FBI=$O(^FBAAC(W,1,X,1,Y,1,Z,"M",FBI)) Q:'FBI  D
 . S FBMOD=$P($G(^FBAAC(W,1,X,1,Y,1,Z,"M",FBI,0)),U)
 . Q:FBMOD=""
 . S FBMODA(FBI)=FBMOD
 Q
 ;
APS(FBJ,FBK,FBL,FBM) ; amount paid symbol
 ; input
 ;   FBJ = IEN of PATIENT in file 162
 ;   FBK = IEN of VENDOR multiple in file 162
 ;   FBL = IEN of INITIAL TREATMENT DATE multiple in file 162
 ;   FBM = IEN of SERVICE PROVIDED multiple in file 162
 ; returns symbol
 ;   where value is M (Mill Bill emergency care - 38 U.S.C. 1725)
 ;                  R (RBRVS fee schedule amount)
 ;                  F (VA fee schedule amount)
 ;                  C (contracted service amount)
 ;                  U (usual & customary - claimed)
 ;                  null if no amount paid
 N FBAP,FBRET,FBY0,FBY2
 S FBRET=""
 S FBY0=$G(^FBAAC(FBJ,1,FBK,1,FBL,1,FBM,0))
 S FBY2=$G(^FBAAC(FBJ,1,FBK,1,FBL,1,FBM,2))
 S FBAP=$P(FBY0,U,3)
 I FBAP>0 D
 . ; use fee schedule info for payment (if any)
 . I +FBAP=+$P(FBY2,U,12) S FBRET=$P(FBY2,U,13) Q:FBRET]""
 . ; if no fee schedule info then calc 75th percentile and check
 . I $P(FBY2,U,12)="" D  Q:FBRET]""
 . . S FBCPT=$$CPT($P(FBY0,U))
 . . S FBMODL=$$MODL("^FBAAC("_FBJ_",1,"_FBK_",1,"_FBL_",1,"_FBM_",""M"")","E")
 . . S FBDOS=$P($G(^FBAAC(FBJ,1,FBK,1,FBL,0)),U)
 . . I +FBAP=+$$PRCTL^FBAAFSF(FBCPT,FBMODL,FBDOS) S FBRET="F"
 . ; since not paid by a fee schedule, check prompt pay type
 . I $P(FBY2,U,2) S FBRET="C" Q
 . ; since not fee schedule or contract check POV code to identify
 . ;   Mill Bill payments
 . S:"^39^52^"[(U_$P($G(^FBAA(161.82,+$P(FBY0,U,18),0)),U,3)_U) FBRET="M"
 . Q:FBRET]""
 . ; all other payments considered u&c
 . S FBRET="U"
 Q FBRET
 ;
CHKBI(X,Y) ;called to determine if batch number or invoice number
 ;already exists
 ;X= next batch/invoice number
 ;Y=1 if Batch
 ;Y undefined if invoice number passed
 ;returns a truth if X is ok for next batch/invoice #
 ;
 I 'X Q ""
 I $G(Y) Q $S($D(^FBAA(161.7,"B",X)):"",1:1)
 I '$G(Y) Q $S($D(^FBAA(162.1,"B",X)):"",$D(^FBAAI("B",X)):"",$D(^FBAAC("C",X)):"",1:1)
 ;
MODL(FBAN,FBFLAG) ;return sorted list given array of modifiers
 ; Input
 ;   FBAN - closed root of array containing modifiers
 ;          the data must be in nodes descendent from this root.
 ;          The subscripts of the nodes below FBAN must be
 ;          positive numbers. The CPT MODIFIER internal value
 ;          must be the first piece in these nodes or in the
 ;          0-node descendent from these nodes.
 ;          i.e.
 ;            ARRAY(number)=CPT MODIFIER (internal value)
 ;                  OR
 ;            ARRAY(number,0)=CPT MODIFIER (internal value)
 ;   FBFLAG - (optional) flag, E or I, default I
 ;          I to return internal values of modifiers
 ;          E to return external values of modifiers
 ; Returns string of sorted modifiers (e.g. "1,3,7") 
 ;
 N FBI,FBRET,FBSORT,FBX,FBZERO
 S FBRET=""
 S FBFLAG=$G(FBFLAG,"I")
 ;
 ; if any descendent data then determine if it is 0-node descendent
 S FBZERO=0 I $O(@FBAN@(0)),$D(@FBAN@($O(@FBAN@(0)),0))#2 S FBZERO=1
 ;
 ; loop thru input array and place modifiers in a sort array
 S FBI=0 F  S FBI=$O(@FBAN@(FBI)) Q:'FBI  D
 . ; get the cpt modifier
 . I FBZERO S FBX=$P(@FBAN@(FBI,0),U)
 . E  S FBX=$P(@FBAN@(FBI),U)
 . I FBFLAG="E" D
 . . ; convert to external value
 . . S FBX=$$MOD^ICPTMOD(FBX,"I")
 . . I FBX>0 S FBX=$P(FBX,U,2)
 . . E  S FBX=""
 . I FBX]"" S FBSORT(FBX)=""
 ;
 ; loop thru sorted array and add the modifiers to return value
 S FBX="" F  S FBX=$O(FBSORT(FBX)) Q:FBX=""  S FBRET=FBRET_","_FBX
 ;
 ; strip leading comma (if any)
 I $E(FBRET)="," S FBRET=$E(FBRET,2,999)
 ;
 ; return value
 Q FBRET
 ;
REPMOD(FBJ,FBK,FBL,FBM) ; Replace CPT Modifier(s) in payment
 ; input
 ;   FBJ = IEN of PATIENT in file 162
 ;   FBK = IEN of VENDOR multiple in file 162
 ;   FBL = IEN of INITIAL TREATMENT DATE multiple in file 162
 ;   FBM = IEN of SERVICE PROVIDED multiple in file 162
 ;   FBMODA( array of modifiers
 ;      where FBMODA(number)=CPT Modifier (internal)
 ;
 N FBI,FBIENS,FBFDA
 S FBIENS=FBM_","_FBL_","_FBK_","_FBJ_","
 ;
 ; delete any existing CPT MODIFIER entries from global
 I $O(^FBAAC(FBJ,1,FBK,1,FBL,1,FBM,"M",0)) D
 . K FBFDA S FBI=0
 . F  S FBI=$O(^FBAAC(FBJ,1,FBK,1,FBL,1,FBM,"M",FBI)) Q:'FBI  D
 . . S FBFDA(162.06,FBI_","_FBIENS,.01)="@"
 . D FILE^DIE("","FBFDA") D MSG^DIALOG()
 ;
 ; create CPT MODIFIER entries from data in array FBMODA
 I $O(FBMODA(0)) D
 . K FBFDA S FBI=0 F  S FBI=$O(FBMODA(FBI)) Q:'FBI  D
 . . S FBFDA(162.06,"+"_FBI_","_FBIENS,.01)=FBMODA(FBI)
 . D UPDATE^DIE("","FBFDA") D MSG^DIALOG()
 ;
 Q
 ;
 ;FBAAUTL4
