XQ72 ;SEA/MJM - ^Jump Utilities ;04/16/2002  14:02
 ;;8.0;KERNEL;**47,46,157**;Jul 10, 1995
 ;
JUMP ;Entry point for D+1^XQ and  LEGAL^XQ74.
 ;With +XQY: target opt, XQY0: 0th node with pathway, XQY1: parent's
 ;0th node; XQ(XQ) array of alternate pathways, if any; XQDIC:
 ;P-tree of target option; XQPSM: XQDIC or mutiple trees (U66,P258)
 ;XQSV: XQY^XQDIC^XQY0 of origin (previous) option.
 ;
 ;** Variables **
 ;XQFLAG=1 usually means we're done.  Head for the door.
 S XQJMP=1 ;Flag indicating we are in a jump process
 N XQFLAG,XQI,XQJ,XQTT,XQSTK,XQSVSTK,XQONSTK,XQOLDSTK
 ;
 ;Get current stack pointer and Primary Menu tree, set "all done" flag
 S XQTT=^XUTL("XQ",$J,"T"),XQPMEN="P"_^("XQM")
 ;
 ;If we are already in a rubber-band jump, unwind it
 I $D(^XUTL("XQ",$J,"RBX")) S XQFLG=1,XQSAV=XQY_U_XQPSM_U_XQY0,XQY=+^("RBX"),XQY0=$P(^("RBX"),U,2,99) D RBX^XQ73 S XQY=+XQSAV,XQPSM=$P(XQSAV,U,2),XQY0=$P(XQSAV,U,3,99) K XQFLG,XQSAV
 ;
 ;Get the stack and see if target option is already on it
 S XQSTK=""
 F XQI=1:1:XQTT S XQOLDSTK(XQI)=^XUTL("XQ",$J,XQI),XQSTK=XQSTK_+XQOLDSTK(XQI)_","
 ;
 I (","_XQSTK)[(","_XQY_","),'$D(XQRB) D NOJ^XQ72A G OUT
 ;
 ;See if target option is in the current display tree (+XQDISTR)
 S XQDISTR=+XQSV
 I $S('$D(^XUTL("XQO",XQDISTR,0)):1,'$D(^DIC(19,XQDISTR,99)):1,^DIC(19,XQDISTR,99)'=$P(^XUTL("XQO",XQDISTR,0),U,2):1,1:0) L +^XUTL("XQO",XQDISTR):5 S XQSAVE=XQDIC,XQDIC=XQDISTR D ^XQSET L -^XUTL("XQO",XQDISTR) S XQDIC=XQSAVE
 I $D(^XUTL("XQO",XQDISTR,"^",+XQY)),($P(^(+XQY),U,6)=+XQY!($P(^(+XQY),U,6)="")) S XQY0=$P(^(+XQY),U,2,99),^DISV(DUZ,"XQ",XQDISTR)=XQY G OUT
 ;
 ;Set XQMA to the parent of the tree we're jumping from
 S XQMA=$P(XQSV,U,2)
 I XQMA']"" S XQMA=XQY
 ;
 ;Find shortest path to target if there are more than one in XQ(XQ)
 I $D(XQ),XQ>0 D MPW G:XQ<0 OUT
 ;
 ;Get jump path and add parent menu option.
 S XQJP=$P(XQY0,U,5)
 I XQPSM["PXU" S %=0,%=$O(^DIC(19,"B","XUCOMMAND",%)),XQJP=%_","_XQJP
 I XQPSM["," S %=$P(XQPSM,",",2),XQJP=$P(%,"P",2)_","_XQJP
 S XQNP=XQTT_U_XQJP
 ;
 ;Save stack as it was before we messed with it.
 S XQSVSTK=XQTT_U_XQSTK
 S XQONSTK="" ;Those options we put on the stack are collected here.
 ;
 ;
 ;** BEGIN PROCESSING PRIMARY AND SECONDARY JUMPS **
 ;
 S XQNOW=^XUTL("XQ",$J,XQTT)
 ;
 ;See if we are jumping FROM a Secondary menu tree
 S XQFLAG=0
 S XQSFROM=$S($P(XQNOW,U)["U":1,1:0)
 I XQSFROM D
 .N %,XQI,XQT,XQDIC
 .S XQT=XQTT
 .S XQDIC=XQPSM I XQDIC["," S XQDIC=$P(XQDIC,",",2)
 .I $D(^XUTL("XQO",XQDIC,U,+XQSV)) S XQFLAG=1 D SAMTREE Q  ;target in current tree.
 .F XQI=XQT:-1:1 S %=$P(^XUTL("XQ",$J,XQI),U,1) Q:%'[","&(%'["PXU")  D POP(XQI) ;Remove current secondary from the stack
 .Q
 G:XQFLAG B1
 ;
 ;See if we're staying in the Primary Menu's tree
 S XQFLAG=0
 I $D(^XUTL("XQO",XQPMEN,U,XQY)) D
 .S XQJP=XQMA_","_XQJP
 .S XQFLAG=1
 .D:XQTT>1 SAMTREE
 .Q
 G:XQFLAG B1
 ;
 ;See if we are jumping TO a secondary menu: just load and go.
 S XQSTO=0
 S XQFLAG=0
 I XQPSM["U" D
 .S XQSTO=1
 .S XQFLAG=1
 .I XQPSM["," S XQDIC=$P(XQPSM,",",2)
 .S (^XUTL("XQ",$J,"T"),XQST)=XQTT
 .Q
 ;
 ;
 ;
B1 ;Get the path of options and process them one by one
 S XQZ=$P(XQNP,U,2) I '$L(XQZ) S XQTT=1 G OUT
 I '$D(XQUIT) F XQSTPT=1:1 S XQD=$P(XQZ,",",XQSTPT) Q:(+XQD=+XQY)!('$L(XQD))  D JUMP1 I $D(XQUIT) S XQUIT=2 D ^XQUIT Q:$D(XQUIT)  D RXQ
 ;
 I '$D(XQUIT) D
 .N %
 .S ^DISV(DUZ,"XQ",XQMA)=XQY
 .S %=$G(^XUTL("XQO",XQDIC,"^",XQY))
 .I %="" S %=$G(^DIC(19,"AXQ",XQDIC,"^",XQY))
 .I %]"" S XQY0=$P(%,U,2,5)_"^^"_$P(%,U,7,11)_"^^"_$P(%,U,13)_"^^"_$P(%,U,15,99)
 .E  S XQFAIL=""
 .Q
 I $D(XQFAIL) K XQFAIL S XQTT=1
 ;
 ;
OUT ;Reset the stack pointer, clean up, and return to XQ
 I '$D(XQTT) S XQTT=$G(^XUTL("XQ",$J,"T")) I XQTT="" S XQTT=1
 S ^XUTL("XQ",$J,"T")=XQTT
 ;
 K %,%XQJP,X,XQ,XQCH,XQD,XQDISTR,XQEX,XQI,XQII,XQJ,XQJMP,XQJP,XQJS,XQK,XQMA,XQN,XQNO,XQNOW,XQNO1,XQNP,XQOLDSTK,XQPMEN,XQSAV,XQSTO,XQSFROM,XQST,XQSTK,XQSTPT,XQSVSTK,XQT,XQTT,XQV,XQW,XQY1,XQZ,Y,Z
 ;
 I $D(XQUIT) K XQUIT G M1^XQ
 G M^XQ
 ;
 ;
 ;** SUBROUTINES **
 ;
POP(XQSTPT) ;Pop one level on the stack
 ;Execute Exit Actions and Headers
 N %,XQY,XQY0
 S %=^XUTL("XQ",$J,XQSTPT)
 S XQY=+%,XQY0=$P(%,U,2,99)
 I $P(XQY0,U,15),$D(^DIC(19,XQY,15)),$L(^(15)) X ^(15) ;W " ==> POP^XQ72"
 S %=^XUTL("XQ",$J,XQSTPT-1)
 S XQY=+%,XQY0=$P(%,U,2,99)
 I $P(XQY0,U,17),$D(^DIC(19,XQY,26)),$L(^(26)) X ^(26) ;W " ==> POP^XQ72"
 I '$D(XQTT) S XQTT=^XUTL("XQ",$J,"T")
 S XQTT=XQTT-1 ;Reset stack pointer to next option
 Q
 ;
JUMP1 ;Check pathway for prohibitions
 ;Push intermediate option onto the stack
 ;Execute Entry Actions and Headers
 S XQST=+XQNP
 S XQY0=$S($D(^XUTL("XQO",XQMA,U,+XQD))#2:$P(^(+XQD),U,2,99),1:^DIC(19,+XQD,0)),XQMA=XQD
 S ^XUTL("XQ",$J,XQTT+1)=XQD_XQPSM_U_XQY0 ;,^("T")=XQST+XQSTPT
 I $P(XQY0,U,14) Q:'$D(^DIC(19,XQD,20))  Q:'$L(^(20))  X ^(20) ;W " ==> JUMP1^XQ72"
 Q:$D(XQUIT)
 ;
RXQ ;Return if XQUIT is cancelled by the application
 I $P(XQY0,U,17),$D(^DIC(19,XQD,26)),$L(^(26)) X ^(26) ;W " ==> JUMP1^XQ72"
 S XQTT=XQTT+1 ;Reset stack pointer
 S XQONSTK=XQTT_U_XQONSTK
 Q
 ;
MPW ;Multiple paths, choose shortest or best
 S XQ(XQ+1)=$P(XQY0,U,5),XQJ=1,%="" F XQI=0:0 S %=$O(XQ(%)) Q:%=""!(%'=+%)  S XQ(XQJ)=XQ(%),XQJ=XQJ+1
 S XQ=XQJ-1 F XQJ=1:1:$L(XQSTK,",")-2 S X=","_$P(XQSTK,",",XQJ)_"," F XQI=1:1:XQ S %=","_XQ(XQI) I %[X,'$D(Y(XQI)) S XQ(XQI)=$E(X,2,99)_$P(XQ(XQI),X,2,99),Y(XQI)=""
 F XQI=1:1:XQ S %($L(XQ(XQI),","),XQI)=XQ(XQI)
 S X="",Z=1 F XQI=1:1:XQ S X=$O(%(X)) Q:X=""  S Y="" F XQJ=0:0 S Y=$O(%(X,Y)) Q:Y=""  S XQ(Z)=%(X,Y),Z=Z+1
 F XQI=1:1:XQ S %XQJP=XQ(XQI) Q:%XQJP=""  D JMP^XQCHK Q:$L(%XQJP)
 I %XQJP="" W " ??",$C(7) S XQY=+XQSV,XQDIC=$P(XQSV,U,2),XQY0=$P(XQSV,U,3,99),XQ=-1 Q
 S XQY0=$P(XQY0,U,1,4)_U_XQ(XQI)_U_$P(XQY0,U,6,99)
 Q
 ;
SAMTREE ;Jump target is in the same tree, find the modified path
 N XQI,XQJ,XQY1
 ;Find in XQI the 1st option in XQJP not already on the stack
 F XQI=1:1:$L(XQJP,",")-1  Q:XQSTK'[($P(XQJP,",",XQI)_",")
 ;Remove that part of jump path already on the stack
 S XQNP=$P(XQJP,",",XQI,99),XQNP=$L(XQNP,",")-1_U_XQNP
 ;
 ;Calculate where we push XQNP (the new path) onto the stack
 S %=$P(XQJP,",",1,XQI-1),XQY1=$P(%,",",$L(%,","))
 ;
 ;Pop the stack until we are pointing to where we need to be
 F XQM=XQTT:-1:2 Q:$P(XQSTK,",",XQM)=XQY1  D POP(XQM)
 Q
 ;
 ;
SOLVE(XQY1,XQJP,XQNP) ;See if and where we are on the jump path.
 ;Returns the remainder of XQJP after XQY1 and everything
 ;under it is removed from the path.  With XQJP = "1,2,3,4,5,"
 ;and XQY1 = 3 (or "3,"; or "2,3"; or "1,2,3,") it returns XQNP
 ;equal to "4,5,".  If XQY1 is not in XQJP, XQNP is returned as
 ;null.
 ;
 N X,IN,OUT
 S IN=+XQY1
 S X=$S(XQY1[",":1,1:0) ;Is it a string or a number?
 S XQNP=$P($E(XQJP,$F(XQJP,XQY1)-X,99),",",2,99)
 I +XQNP=IN S XQNP="" ;No match
 Q
