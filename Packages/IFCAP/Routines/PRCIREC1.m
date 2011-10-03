PRCIREC1 ;WISC/SWS-Filed transform code ;9/7/06  14:22
V ;;5.1;IFCAP;**107**;Oct 20, 2000;Build 13
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;This routine serves as the input transform for the field Inventory Point in File ^PRCP(445)
 Q
START S:X'["-" X=$G(PRC("SITE"))_"-"_X
 I 'X!($L(X)>30)!(X'?3N1"-"1ANP.ANP)!('$G(PRCPPRIV)) K X Q
 I +X'=PRC("SITE") D
 . K MSG
 .S MSG(1)="  "_+X_" not current station number."
 .D EN^DDIOL(.MSG)
 .K MSG,X
 I $D(X),$O(^PRCP(445,"B",X,0)) D
 . S MSG(1)="  DUPLICATE NAME"
 . D EN^DDIOL(.MSG)
 . K MSG,X
 Q
DELETE I $P($G(^PRCP(445,D0,0)),U,3)="W" D
 . K MSG
 . S MSG(1)="YOU CANNOT DELETE WAREHOUSE TYPE INVENTORY POINTS.",MSG(1,"F")="!?2"
 . D EN^DDIOL(.MSG)
 . K MSG
 Q
