ORY212 ;SLC/MKB - postinit for OR*3*212 ;2/11/08  11:06
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**212**;Dec 17, 1997;Build 24
 ;
PRE ; -- preinit [clean up test accounts]
 D DAT
 Q
 ;
DLGSEND(X) ; -- Send order dialog X?
 I X="VBEC BLOOD BANK" Q 1
 I X="OR GTX AMOUNT" Q 1
 I X="OR GTX DATE/TIME" Q 1
 I X="OR GTX LAB ORDER" Q 1
 I X="OR GTX RBC MODIFIERS" Q 1
 I X="OR GTX REASON" Q 1
 I X="OR GTX RESULTS" Q 1
 I X="OR GTX SPECIMEN STATUS" Q 1
 I X="OR GTX TEXT" Q 1
 ;I X="OR GTX TRANSFUSION" Q 1
 Q 0
 ;
POST ; -- postinit
 D DGRP,URG,ORDITMS ;,COMP
 D MAIN^ORY212P ;install parameter values [created by ^XPARTPV]
 Q
 ;
DGRP ; -- ck Default Dialog, Members
 N VB,ORI,X,Y,DA,DIC,DLAYGO,DO,DD,DR,DIE
 S VB=+$O(^ORD(100.98,"B","VBEC",0)) I VB D
 . S X=$P($G(^ORD(100.98,VB,0)),U,4) D:X'>0  ;Default Dialog
 .. S X=+$O(^ORD(101.41,"B","VBEC BLOOD BANK",0))
 .. S:X $P(^ORD(100.98,VB,0),U,4)=X
 . S DA(1)=VB,DIE="^ORD(100.98,"_VB_",1,"    ;Members
 . F ORI="1^VBC","2^VBT" D
 .. S X=+$G(^ORD(100.98,VB,1,+ORI,0))
 .. I $P($G(^ORD(100.98,X,0)),U,3)'=$P(ORI,U,2) S DA=+ORI,DR=".01///"_$P(ORI,U,2) D ^DIE
 S DA(1)=$O(^ORD(100.98,"B","BB",0)) Q:'DA(1)
 Q:$O(^ORD(100.98,DA(1),1,"B",VB,0))  ;already linked
 S:'$D(^ORD(100.98,DA(1),1,0)) ^(0)="^100.981P^^"
 S DIC="^ORD(100.98,"_DA(1)_",1,",DIC(0)="NLX",DLAYGO=100.98
 S X="BLOOD PRODUCTS" K Y D ^DIC
 Q
 ;
URG ; -- create new PRE-OP urgency, add VBEC usage to STAT,ROUTINE
 N HDR,ORI,IEN
 I '$O(^ORD(101.42,"B","PRE-OP",0)) D  ;add to file [at ien #3]
 . S HDR=$G(^ORD(101.42,0)),^(0)=$P(HDR,U,1,3)_U_($P(HDR,U,4)+1),IEN=3
 . I $L($G(^ORD(101.42,3,0))) S IEN=$O(^ORD(101.42,90),-1) ;before DONE
 . S ^ORD(101.42,IEN,0)="PRE-OP^P",^(1,0)="^101.421A^1^1",^(1,0)="VBEC"
 . S ^ORD(101.42,IEN,1,"B","VBEC",1)="",^ORD(101.42,"S.VBEC","PRE-OP",IEN)=""
 . S ^ORD(101.42,"B","PRE-OP",IEN)="",^ORD(101.42,"C","P",IEN)=""
 F ORI=1,2,9 I '$O(^ORD(101.42,ORI,1,"B","VBEC",0)) D  ;add VBEC Usage
 . N DA,DIC,X,Y,DLAYGO,DO,DD
 . S DA(1)=ORI,DIC="^ORD(101.42,"_ORI_",1,",DIC(0)="LX",DLAYGO=101.421
 . S:'$D(^ORD(101.42,ORI,1,0)) ^(0)="^101.421A^^"
 . S X="VBEC" K DO,DD D ^DIC
 Q
 ;
ORDITMS ; -- install VBECS orderable items
 Q:$D(^ORD(101.43,"S.VBEC"))  ;items already exist
 N X,Y,DIC,DIE,DR,DLAYGO,DO,DD,DA,ORDG,ORI,ITEM,ORIT,SUB
 S ORDG=$O(^ORD(100.98,"B","VBEC",0)) Q:'ORDG
 F ORI=1:1 S ITEM=$T(ITEMS+ORI),X=$P(ITEM,";",3) Q:X="ZZZZ"  D
 . S DIC="^ORD(101.43,",DIC(0)="LX",DLAYGO=101.43
 . K DO,DD,Y D FILE^DICN Q:Y'>0  ;error
 . S ORIT=ORI_";99VBC",DR="1.1///"_X_";2///^S X=ORIT;5////"_ORDG
 . S DA=+Y,DIE=DIC D ^DIE S ORIT=DA
 . S X=$P(ITEM,";",4) I $L(X) D  ;define sub-types
 .. S ^ORD(101.43,DA,"VB")=X,SUB=$S(X:"VBC",1:"VBT")
 .. D SET^ORDD43(SUB,DA)
 Q
 ;
ITEMS ;;VBECS orderable;comp^test or T&S
 ;;TYPE & SCREEN;^2
 ;;RED BLOOD CELLS;1^
 ;;FRESH FROZEN PLASMA;1^
 ;;PLATELETS;1^
 ;;CRYOPRECIPITATE;1^
 ;;OTHER;1^
 ;;ABO/RH;^1
 ;;ANTIBODY SCREEN;^1
 ;;DIRECT ANTIGLOBULIN TEST;^1
 ;;TRANSFUSION REACTION WORKUP;^1
 ;;WHOLE BLOOD;1^
 ;;ZZZZ
 ;
DAT ; -- Strip "(DAT)" from name
 N X,DA,DR,DIE
 S DA=+$O(^ORD(101.43,"ID","9;99VBC",0))
 I DA,$P($G(^ORD(101.43,DA,0)),U)["(" D  ;strip "(DAT)"
 . S DR=".01///DIRECT ANTIGLOBULIN TEST",DIE="^ORD(101.43,"
 . D ^DIE
 Q
 ;
COMP ;Setup package level parameters for OR VBECS COMPONENT ORDER
 ;   [replaced by MAIN^ORY212P in POST]
 N ORX,P
 S P="OR VBECS COMPONENT ORDER"
 D GETLST^XPAR(.ORX,"PKG.ORDER ENTRY/RESULTS REPORTING",P,"Q")
 ;I $O(ORX(0)) Q  ;New parameter has already been setup
 D SET("RED BLOOD CELLS",P,5)
 D SET("FRESH FROZEN PLASMA",P,10)
 D SET("PLATELETS",P,15)
 D SET("CRYOPRECIPITATE",P,20)
 D SET("WHOLE BLOOD",P,25)
 D SET("OTHER",P,30)
 Q
 ;
SET(ONAME,P,S) ;Set the parameter
 ;ONAME=Report name
 ;P=Parameter name
 ;S=Sequence (count)
 N DA,ORERR
 S DA=0 F  S DA=$O(^ORD(101.43,"S.VBC",ONAME,DA)) Q:'DA  D
 . D EN^XPAR("PKG.ORDER ENTRY/RESULTS REPORTING",P,S,ONAME,.ORERR)
 Q
