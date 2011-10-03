FBAAPAA ;AISC/DMK-ADD/EDIT FEE SCHEDULE ;3/17/2003
 ;;3.5;FEE BASIS;**4,21,55**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
ASK W ! S DIC="^FBAA(163.99,",DIC(0)="AEQLM",DLAYGO=163.99 D ^DIC G END:X=""!(X="^"),ASK:Y<0 S DA=+Y
 W ! S DIE=DIC,DR="[FBAA EDIT SCHEDULE]" D ^DIE G ASK
END K DA,DIC,DIE,DLAYGO,DR,X,Y Q
 ;write CPT & MOD as identifiers
 ; Input: (optional) FBDTSRV - date for Code Set Versioning
WRITE ; if FBDTSRV is not defined then today will be used as a date
 N FBAAFS,FBAACP,FBCPTX,FBI,FBMOD,FBMODLE,FBMODX,FBCPTFL,FBMODFL
 S (FBCPTFL,FBMODFL)=0
 S FBAAFS=$P(^FBAA(163.99,+Y,0),U)
 I +$G(FBDTSRV)=0 N FBDTSRV D
 . N X D NOW^%DTC S FBDTSRV=X
 S FBAACP=$P(FBAAFS,"-")
 S FBMODLE=$P(FBAAFS,"-",2)
 I $X>19 W !
 S FBCPTX=$$CPT^ICPTCOD(FBAACP,$G(FBDTSRV),1)
 I $G(FBDTSRV),+FBCPTX>0,$P(FBCPTX,U,7)=0 S FBCPTFL=1
 W ?20,"CPT: ",$S(FBCPTFL:$E($P(FBCPTX,U,3),1,25),1:$P(FBCPTX,U,3)) ; short name of CPT
 W:FBCPTFL ?50," - INACTIVE on ",$$FMTE^XLFDT(FBDTSRV) ;inactive on FBDTSRV 
 I FBMODLE]"" F FBI=1:1 S FBMOD=$P(FBMODLE,",",FBI) Q:FBMOD=""  D
 . S FBMODX=$$MOD^ICPTMOD(FBMOD,"E",$G(FBDTSRV))
 . ; if modifier data not obtained then try another API to resolve it
 . ; since there can be duplicate modifiers with same external value
 . I $P(FBMODX,U)'>0 D
 . . N FBY
 . . S FBY=$$MODP^ICPTMOD(FBAACP,FBMOD,"E",$G(FBDTSRV))
 . . I $P(FBY,U)>0 S FBMODX=$$MOD^ICPTMOD($P(FBY,U),"I",$G(FBDTSRV))
 . I $G(FBDTSRV),+FBMODX>0,$P(FBMODX,U,7)=0 S FBMODFL=1
 . W !?20,"MOD: ",FBMOD,"  ",$S(FBMODFL:$E($P(FBMODX,U,3),1,20),1:$P(FBMODX,U,3))
 . W:FBMODFL ?50," - INACTIVE on ",$$FMTE^XLFDT(FBDTSRV) ;inactive on FBDTSRV
 Q
