XQ73 ;SEA/MJM - Rubber Band Jump ("^^") Processor ;05/08/98  10:10
 ;;8.0;KERNEL;**46**;Jul 10, 1995
 ;Entry from XQ
 ;With +XQY: target opt, XQY0: 0th node
 ;with a pathway; XQ(XQ) array of alternate pathways, if any; XQDIC:
 ;P-tree of target option; XQPSM: XQDIC or mutiple trees (U66,P258)
 ;XQSV: XQY^XQDIC^XQY0 of origin (previous) option.
 ;
 ;Set the jump flag to indicate that this is a jump process
 S XQJMP=1
 ;
 ;Set XQMA to the option from whence we came.  XQNMB is set to a high
 ;number which will count down and be used to save Exit Actions and
 ;headers that are stored in ^XUTL("XQ", $J,"RBX")
 ;
 S XQMA=$P(XQSV,U,2),XQNMB=999
 ;
 ;If the "RBX" nodes already exist we know that we are already in a
 ;rubber band jump.  Set the flag XQFLG and save in XASAV the current
 ;option, load the original rubberband jump, do RBX^XQ73 to execute
 ;the stored exit actions and headers.
 ;
 I $D(^XUTL("XQ",$J,"RBX")) S XQFLG=1,XQSAV=XQY_U_XQPSM_U_XQY0,XQY=+^("RBX"),XQY0=$P(^("RBX"),U,2,99) D RBX S XQY=+XQSAV,XQPSM=$P(XQSAV,U,2),XQY0=$P(XQSAV,U,3,99) K XQFLG,XQSAV
 ;
 ;If the target option XQY is a sibling of XQMA then it's not really
 ;a jump, so load it and return to XQ.
 ;
 I $D(^XUTL("XQO",XQMA,"^",+XQY)),($P(^(+XQY),U,6)=+XQY!($P(^(+XQY),U,6)="")) S XQY0=$P(^(+XQY),U,2,99) G M^XQ
 ;
 ;Set XQTT to the stack pointer and point XQST to the primary menu.
 ;Set XQSM to 1 as a flag if this is a jump to a secondary menu.
 ;Collect the current stack IEN's in XQSTK separated by commas.
 ;
 S XQTT=^XUTL("XQ",$J,"T"),XQST=1,XQSTK="",XQSM=$S($P(^(XQTT),U)["U":1,1:0) F XQI=1:1:XQTT S %=+^XUTL("XQ",$J,XQI),XQSTK=XQSTK_%_","
 ;
 ;If XQY, the target option, is already on the stack then back down
 ;to it if we are not already in a RB jump.
 ;
 I (","_XQSTK)[(","_XQY_",") G:'$D(XQRB) NOJ^XQ72A
 ;
 ;Using XQFLAG as a flag, find XQDIC (the parent of the jump tree)
 ;if there is a "U" then it must be a common option or a secondary
 ;menu tree.
 ;
 S XQFLAG=0 I XQPSM["U" S XQFLAG=1,XQST=XQTT I XQPSM["," S XQDIC=$P(XQPSM,",",2)
 ;
 ;If there are multiple pathways find the shortest. If XQ comes back as
 ;0, you can't get there from here.
 ;
 I $D(XQ),XQ>0 D MPW^XQ72 G:XQ<0 OUT
 ;
 ;Get the jump path in XQJP and set XQI to the stack pointer as it is
 ;or was before the jump.  Set XQI to the original stack pointer.
 ;
 S XQJP=$P(XQY0,U,5) S XQI=XQTT
 ;
 ;If this is a secondary menu jump put the parent option on the
 ;beginning of the jump path.
 ;
 I XQPSM["," S XQJP=$P(XQPSM,"P",2)_","_XQJP ;Secondary menu tree
 ;
 ;If this is a common option put XUCOMMAND on the front of the jump
 ;path.
 ;
 I XQPSM="PXU" S XQJP=$O(^DIC(19,"B","XUCOMMAND",0))_","_XQJP ;Common options
 ;If we are jumping within the same tree, get the modified path (just
 ;those options not already executed.
 ;
 ;I $D(^XUTL("XQO",XQDIC,U,XQY)) D SAMTREE^XQ72 S XQJP=$P(XQNP,U,2),XQY1=+XQNP
 ;
FND ;Pop to next Menu-type option, if in path remove options below it
 S XQJP1=XQJP,XQI=XQTT+1,XQNP=$S($D(XQNP):XQNP,1:0)
 F XQII=0:0 Q:+XQNP>0  S XQI=XQI-1 S XQY1=^XUTL("XQ",$J,XQI),XQT=$P(XQY1,U,5) Q:XQI=1  I "M"[XQT F XQJ=1:1:$L(XQJP,",")-1 I $P(XQJP,",",XQJ)=+XQY1 S XQNP=XQI_U_$P($E(XQJP,$F(XQJP,+XQY1),99),",",2,99) Q
 ;
 I +XQNP>0 D
 .N XQSTP,XQJP2,XQDAD,XQI
 .S XQSTP=+XQNP,XQJP2=$P(XQNP,U,2),XQDAD=+XQY1
 .F XQI=XQTT:-1:XQSTP D
 ..S %=+^XUTL("XQ",$J,XQI)
 ..I $D(^DIC(19,%,26)),$L(^(26)) X ^(26) ;W "  ==> FND^XQ73"
 ..Q
 .S XQJP=XQJP2
 .Q
 I '$L(XQJP) G M^XQ
 F XQI=1:1 S XQYY=$P(XQJP,",",XQI) Q:XQYY=XQY!(XQYY="")  S XQJ=^XUTL("XQO",XQDIC,"^",XQYY) D ACT Q:$D(XQUIT)
 I '$D(XQUIT) S ^XUTL("XQ",$J,XQTT+1)=-1,^("T")=XQTT+1,^("RBX")=XQY_U_XQY0
OUT ;Exit here
 S:$D(XQ(XQY)) XQPSM=$P(XQ(XQY),U,3)
 K %,X,XQ,XQA,XQAL,XQCH,XQFLAG,XQHD,XQI,XQII,XQJ,XQJP,XQJMP,XQJP1,XQL,XQK,XQMA,XQNO,XQNMB,XQNP,XQSM,XQST,XQSTK,XQT,XQTT,XQYY,XQY1,Y
 ;K '$D(XQUIT) XQRB
 ;Q:'$D(XQXFLG("GUI"))
 I $D(XQUIT) K XQUIT G M1^XQ
 G M^XQ
 Q
ACT ;Execute headers & entry actions, store headers & exit actions
 I $P(XQJ,U,15),$D(^DIC(19,XQYY,20)),$L(^(20)) X ^(20) ;W "  ==> ACT^XQ73"
 I $D(XQUIT) D RB^XQUIT Q:$D(XQUIT)
 S XQHD=0 I $P(XQJ,U,18),$D(^DIC(19,XQYY,26)),$L(^(26)) X ^(26) S XQHD=1 ;W "  ==> ACT^XQ73" ;^XUTL("XQ",$J,"RBX",XQNMB)=^(26),XQNMB=XQNMB-1
 I $P(XQJ,U,16),$D(^DIC(19,XQYY,15)),$L(^(15)) S ^XUTL("XQ",$J,"RBX",XQNMB)=^(15),XQNMB=XQNMB-1
 I XQHD S ^XUTL("XQ",$J,"RBX",XQNMB)=^DIC(19,XQYY,26),XQNMB=XQNMB-1
 Q
 ;
R ;Reset XUTL("XQ") stack pointer ^("T") to 1 (primary menu) 'GO HOME'
 ;I $S('$D(^XUTL("XQ",$J,"XQM")):1,XQY=^("XQM"):1,1:0) G OUT
 I ^XUTL("XQ",$J,"T")>1 F XQI=^("T"):-1:1 D
 .S XQY=^XUTL("XQ",$J,XQI) D:+XQY<1 RBX S XQY0=$P(XQY,U,2,99) I XQI>1,$P(XQY0,U,15),$D(^DIC(19,+XQY,15)),$L(^(15)) X ^(15) ;W "  ==> R+3^XQ73"
 .S %=^XUTL("XQ",$J,XQI-1) I (XQI-1)>1,$P(%,U,18),$D(^DIC(19,+%,26)),$L(^(26)) X ^(26)
 S (XQY,XQDIC)=^XUTL("XQ",$J,"XQM"),XQY0=$P(^(1),U,2,99),^("T")=1
 S XQT=$P(XQY0,U,4)
 K XQI,XQUR S XQM3=1
 ;Q:$D(XQXFLG("GUI"))
 G M^XQ
 Q
 ;
RBX ;Execute stored exit actions to return from RB jump
 I $P(XQY0,U,15),$D(^DIC(19,XQY,15)),$L(^(15)) X ^(15) ;W "  ==> RBX+1^XQ73"
 S XQN="" F XQJ=0:0 S XQN=$O(^XUTL("XQ",$J,"RBX",XQN)) Q:XQN=""  X ^(XQN) ;W "  ==> RBX^XQ73"
 ;S ^("T")=^XUTL("XQ",$J,"T")-1,XQY=^(^("T")),XQY0=$P(XQY,U,2,99),XQDIC=$P(XQY,+XQY,2),XQY=+XQY
 F XQJ=^XUTL("XQ",$J,"T"):-1:1 Q:^(XQJ)=-1
 S ^XUTL("XQ",$J,"T")=$S(XQJ-1>0:XQJ-1,1:1) S:'$D(XQFLG) %=^(^("T")),XQY=+%,XQY0=$P(%,U,2,99),XQPSM=$P($P(%,+XQY,2,99),U),XQDIC=$S((XQPSM[","):$P(XQPSM,",",2),1:XQPSM)
 I $P(XQY0,U,17),$D(^DIC(19,XQY,26)),$L(^(26)) X ^(26) ;W "  ==> RBX^XQ73"
 K ^XUTL("XQ",$J,"RBX"),%,XQJ,XQN,XQRB
 G:'$D(XQFLG) M1^XQ
 Q
