XQ75 ;SEA/AMF,LUKE,JLI,BT - Lookup response for jumps ;6/14/2011
 ;;8.0;KERNEL;**47,46,157,253,553,570**;Jul 10, 1995;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;Enter at S with XQUR. Exit with XQY set to the chosen option #,
 ;with array of possibilities in XQ(XQ):XQY^menu txt [name]^XQPSM
 ;XQXT(XQXT) similarly built, holds exact matches
 ;XQY=-1 (no option found), or XQY=-2 (jumps shut down).
 ;
X ;Unless exact match is found, find all possibilities in any XQDIC
 S XQO=$O(^XUTL("XQO",XQDIC,XQO)) Q:'$S(XQO="":0,XQUR="?":XQO'="^",XQUR=0_$C(1):'$L($P(XQO,"0",1)),1:'$L($P(XQO,XQUR,1)))
 S XQYY=^XUTL("XQO",XQDIC,XQO) S XQY=+XQYY G:$D(XQ("X",+XQY)) X S %=$G(^XUTL("XQO",XQDIC,"^",+XQY)) G:%="" X S XQY0=$P(%,U,2,99)
 S XQCY=XQY,XQCY0=XQY0 D ^XQCHK I (XQCY<0)!'$$CHCKTM(XQY) S XQY=0 G X
 S:'$P(XQYY,U,2) XQ("S",+XQY)=$P(XQO,U)
 I XQUR=$P(XQO,U),'XQS S XQXT=XQXT+1,XQXT(XQXT)=+XQY_U_$P(XQY0,U,2)_"  ["_$P(XQY0,U)_"] "_U_$S($D(XQUD):XQUD_",",1:"")_XQDIC,XQXT("X",XQY)="" S:'$P(XQYY,U,2) XQXT("S",+XQY)=$P(XQO,U)
 S XQ=XQ+1,XQ1=XQ1+1,XQ(XQ)=+XQY_U_$P(XQY0,U,2)_"  ["_$P(XQY0,U)_"] "_U_$S($D(XQUD):XQUD_",",1:"")_XQDIC,XQ("X",XQY)=""
 I XQ1>19,'XQXT D C
 Q:XQY<0!(XQUR="")  G X
 Q
 ;
C ;Display a screen-load of 19 possibilities and ask for a choice
 ;I $G(XQXFLG("GUI")) D  Q
 ;.D LIST^XQGS1(XQ)
 ;.S XQUR=""
 ;.Q:XQY<0
 ;.S %="" F  S %=$O(XQ(%)) Q:%=""!(%'=+%)  I XQY=+XQ(%) S XQPSM=$P(XQ(%),U,3)
 ;.Q
 S:XQ1<1 XQ1=XQ W ! F XQI=1:1:XQ1 S XQJ=XQS*20+XQI W !?4,XQJ,?9,$P(XQ(XQJ),U,2) I $D(XQ("S",+XQ(XQJ))) W ?43,"  (",XQ("S",+XQ(XQJ)),")"
ASK W !!,"Type '^' to stop, or choose a number from 1 to ",XQ," :"
 R XQJ:DTIME S:'$T XQJ=U W:XQJ["?" !!,"**> Choose an item from this list by selecting its corresponding number,",!?5,"or type a '^' to return to your menu.",! G:XQJ["?" ASK
 I XQJ=U S XQY=-1,XQ=0 Q
 I XQJ'?1N.N,$L(XQJ),XQJ'=U W $C(7),"  ??",! G ASK
 I XQJ?1N.N G C:'$D(XQ(XQJ)) D  Q:$D(XQ(+XQJ))
 .N %,XQD,XQP,Y
 .S %=XQ(XQJ),Y=+% I Y>0 D
 ..S XQP=$P(%,U,3),XQD=$S($L(XQP,",")>1:$P(XQP,",",$L(XQP,",")),1:XQP)
 ..S XQY0=$G(^XUTL("XQO",XQD,"^",Y)),XQY0=$P(XQY0,U,2,99)
 ..I XQY0="" K XQ(XQJ) S XQ=XQ-1,XQJ="" Q
 .I $L(XQJ),$D(XQ(XQJ)) S XQY=Y,XQDIC=XQD,XQPSM=XQP,XQUR="" W "  " Q
 .Q
 I XQJ?1N.N W $C(7),$P(XQ(XQJ-1#20+1),U,4),! G C
 I '$L(XQJ),XQ1'<20 S XQS=XQS+1,XQ1=0 Q
 I '$L(XQJ),XQ1<20 S XQY=-1,XQ=0 Q
 I '$D(XQ(XQJ)) G C
 K XQ S XQY=$S(XQJ=U:-3,XQJ="":-3,1:-1),XQUR=$C(95) S:XQJ=U XQJ="",XQY=-1 S:$L(XQJ) XQUR=$S($E(XQDIC,1)="P":U_XQJ,1:XQJ),XQY=0 Q
 Q
 ;
S ;Entry from XQ: Search primary, common, and secondary menus for XQUR
 I XQUR'?.ANP W $C(7) S XQY=-1 Q
 I XQPSM'="PXU" S XQDIC=$S($D(XQPSM):$P(XQPSM,"P",2),$D(XQDIC):XQDIC,1:XQY)
 E  S XQDIC="PXU"
 I '$D(XQTT) S XQTT=$G(^XUTL("XQ",$J,"T")) I XQTT="" S XQTT=1
 ;S:'$D(XQDIC) XQDIC=XQY S XQSV=XQY_U_XQDIC_U_XQY0
 S XQJ="",XQJMP=1,(XQ,XQ1,XQS,XQXT,XQY)=0
 S XQO=$E(XQUR,1,30) I XQUR'?.PUN S XQO=$$UP^XLFSTR(XQO) ;F XQI=1:1 Q:XQO?.NUP  S XQO1=$A(XQO,XQI) I XQO1<123,XQO1>96 S XQO=$E(XQO,1,XQI-1)_$C(XQO1-32)_$E(XQO,XQI+1,255)
 S XQUR=XQO,(XQO,XQO1)=$E(XQUR,1,$L(XQUR)-1)_$C($A($E(XQUR,$L(XQUR)))-1)_"z"
 I '$D(^XUTL("XQ",$J,"XQM")) S ^("XQM")=+^VA(200,DUZ,201)
 ;I '$D(^XUTL("XQ",$J,"XQW")) S ^("XQW")=$P(^VA(200,DUZ,201),U,2)
 I $D(XQJS),XQJS G OUT
 ;
 ;Check the Primary Menu first
 S XQDIC="P"_^XUTL("XQ",$J,"XQM")
 ;If there's no master copy in ^DIC(19,"AXQ"), nothing to do.
 I '$D(^DIC(19,"AXQ",XQDIC,0)) D REACT^XQ84(DUZ) S XQY=-1 G OUT
 I '$D(^XUTL("XQO",XQDIC,0)) S XQSAVE=XQPSM,XQPSM=XQDIC D MERGE^XQ12 S XQPSM=XQSAVE
 S XQXUTL=$G(^XUTL("XQO",XQDIC,0)),XQDIC19=^DIC(19,"AXQ",XQDIC,0)
 I XQXUTL="" S XQXUTL=XQDIC19
 S %=$$HDIFF^XLFDT(XQDIC19,XQXUTL,2) I %>30 S XQSAVE=XQPSM,XQPSM=XQDIC D MERGE^XQ12 S XQPSM=XQSAVE
 ;If tree is not there or out of date, remerge it
 D X G:XQY<0 OUT G:XQUR="" W
 ;
 ;Look in XUCOMMAND
 S XQDIC="PXU"
 ;I $S('$D(^XUTL("XQO",XQDIC,0)):1,^XUTL("XQO",XQDIC,0)'=^DIC(19,"AXQ",XQDIC,0):1,1:0) D MGPXU^XQ12
 I '$D(^XUTL("XQO",XQDIC,0)) D MGPXU^XQ12
 S XQXUTL=$G(^XUTL("XQO",XQDIC,0)),XQDIC19=^DIC(19,"AXQ",XQDIC,0)
 I XQXUTL="" S XQXUTL=XQDIC19
 S %=$$HDIFF^XLFDT(XQDIC19,XQXUTL,2) I %>30 D MGPXU^XQ12
 S XQO=XQO1 D X G:XQY<0 OUT G:XQUR="" W
 ;
 ;Check the top level of the Secondaries
 S XQDIC="U"_DUZ,XQO=XQO1 D:$S('$D(^XUTL("XQO",XQDIC,0)):1,'$D(^VA(200,DUZ,203.1)):1,1:^VA(200,DUZ,203.1)'=$P(^XUTL("XQO",XQDIC,0),U,2)) ^XQSET I '$D(^XUTL("XQO",XQDIC,0)),'XQXT D C G:XQY<0 OUT G:XQUR="" W
 D X G:XQY<0 OUT G:XQUR="" W
 ;
 ;Check each secondary in depth
 F XQK=0:0 Q:XQY<0!(XQUR="")  S XQUD="U"_DUZ,XQK=$O(^XUTL("XQO",XQUD,U,XQK)) Q:XQK=""  D
 .S XQCY=XQK D ^XQCHK I XQCY>0,$P(^XUTL("XQO",XQUD,U,XQK),U,5)="M" D
 ..N XQSAVE
 ..S XQST=XQK,XQDIC="P"_XQK,XQO=XQO1
 ..I '$D(^DIC(19,"AXQ","P0")) D
 ...I '$D(^XUTL("XQO",XQDIC,0)) S XQSAVE=XQPSM D MERGE^XQ12 S XQPSM=XQSAVE
 ...S XQXUTL=$G(^XUTL("XQO",XQDIC,0)),XQDIC19=$G(^DIC(19,"AXQ",XQDIC,0))
 ...Q:XQDIC19=""  ;Nothing to merge, probably a new scondary
 ...I XQXUTL="" S XQXUTL=XQDIC19
 ...S %=$$HDIFF^XLFDT(XQDIC19,XQXUTL,2) I %>30 S XQSAVE=XQPSM,XQPSM=XQDIC D MERGE^XQ12 S XQPSM=XQSAVE
 ...Q
 ..D X Q:XQY<0!(XQUR="")
 ..Q
 .Q
 G:XQY<0 OUT
 G:XQUR="" W
 ;
 I XQXT K XQ S (XQ,XQ1)=XQXT F XQI=1:1:XQ S XQ(XQI)=XQXT(XQI),%=+XQ(XQI),XQ("X",%)="" I $D(XQXT("S",%)) S XQ("S",%)=XQXT("S",%)
 ;
 I XQ=1,XQS=0 D
 .N X
 .S %=XQ(1),XQY=+%,XQPSM=$P(%,U,3)
 .S XQDIC=$S($L(XQPSM,",")>1:$P(XQPSM,",",$L(XQPSM,",")),1:XQPSM)
 .S X=$G(^XUTL("XQO",XQDIC,U,XQY))
 .I X="" S X=$G(^DIC(19,"AXQ",XQDIC,U,XQY))
 .Q:X=""
 .S XQY0=$P(X,U,2,99),XQSFLG=""
 .Q
 I $D(XQSFLG) K XQSFLG G W
 ;
 I XQ>0,'$D(XQ(XQS*20+1)) S XQY=-1 G OUT
 D:XQ>0 C G:XQY<0 OUT I XQ=0 S XQY=-1 G OUT
 ;
W ;Write out remaining text and return to XQ
 ;G:$D(XQXFLG("GUI")) OUT
 I $D(XQ("S",+XQY)),XQUR=$E(XQ("S",+XQY),1,$L(XQUR)) W $E(XQ("S",+XQY),$L(XQUR)+1,99),"   ",$P(XQY0,U,2)
 E  W $E($P(XQY0,U,2),$L(XQUR)+1,99) W:$D(XQ("S",+XQY)) "   (",XQ("S",+XQY),")"
 ;
OUT ;Exit here
 K XQ
 N % S XQ=""
 I XQY>0,$D(^XUTL("XQO",XQDIC,"^",+XQY,0)) D
 .S %=$G(^XUTL("XQO",XQDIC,"^",+XQY,0)) I %="" D
 ..H 1 ;Micro surgery must have it wait a sec
 ..S %=$G(^XUTL("XQO",XQDIC,"^",+XQY,0))
 ..Q
 .Q:%=""
 .S:%>0 XQ=+%
 .F XQI=1:1:XQ D
 ..S %=$G(^XUTL("XQO",XQDIC,"^",XQY,0,XQI)) I %="" D
 ...H 1
 ...S %=$G(^XUTL("XQO",XQDIC,"^",XQY,0,XQI))
 ...Q
 ..I %]"" S XQ(XQI)=$P(%,U)
 ..Q
 .Q
 I XQ="" S XQ=0
 ;I XQY=-1,'$D(XQHLP) W $C(7),"  ??" S XQY=+XQSV,XQDIC=$P(XQSV,U,2),XQY0=$P(XQSV,U,3,99),XQUR=""
 ;
 K %,I,J,X,XQ1,XQAP,XQCY,XQCY0,XQDIC19,XQI,XQJ,XQJMP,XQK,XQO,XQO1,XQS,XQST,XQUD,XQXT,XQXUTL,XQYY,Y
 K XQ
 Q
 ;
FIND(XQDIC) ;The expected 0th node in ^XUTL is not here
 I '$D(XQDIC) Q 0
 N %,XQT1,XQT2
 S %=$G(^DIC(19,"AXQ",XQDIC,0))
 I '$L(%) Q 0
 I $D(^XTMP("XQO","NOFIND",XQDIC)) D
 .N XQT1,XQT2,XQFLG
 .S XQT1=$H,XQFLG=0
 .S XQT2=$G(^XTMP("XQO","NOFIND",XQDIC))
 .I '$L(XQT2) Q
 .I XQT2>XQT1 K ^XTMP("XQO","NOFIND",XQDIC) Q
 .I XQT1>XQT2!($P(XQT1,",",2)-$P(XQT2,",",2)>.300) D
 ..K ^XTMP("XQO","NOFIND",XQDIC)
 ..I XQDIC="PXU" S XQFLG=1 D MGPXU^XQ12
 ..I 'XQFLG D MERGE^XQ12
 ..Q
 .Q
 I '$D(^XTMP("XQO","NOFIND",XQDIC)) S ^(XQDIC)=$H
 Q %
 ;
P ;Entry point for '"' jump to XUCOMMAND options
 I XQUR'?.ANP!(XQUR[U) W $C(7)," ??" S XQY=-1 Q
 S XQO=XQUR I XQUR'?.PUN S XQO=$$UP^XLFSTR(XQO) ;F XQI=1:1 Q:XQO?.NUP  S XQO1=$A(XQO,XQI) I XQO1<123,XQO1>96 S XQO=$E(XQO,1,XQI-1)_$C(XQO1-32)_$E(XQO,XQI+1,255)
 S XQUR=XQO ;,XQSV=XQY_U_XQDIC_U_XQY0
 S XQJ="",XQJMP=1,(XQ,XQ1,XQS,XQXT,XQY)=0
 S (XQO,XQO1)=$E(XQUR,1,$L(XQUR)-1)_$C($A($E(XQUR,$L(XQUR)))-1)_"z"
 S XQDIC="PXU" D X G:XQY<0 OUT G:XQUR="" W
 I XQXT K XQ S XQ=XQXT F XQI=1:1:XQ S XQ(XQI)=XQXT(XQI),%=+XQ(XQI),XQ("X",%)="" I $D(XQXT("S",%)) S XQ("S",%)=XQXT("S",%)
 I XQ=1,XQS=0 S %=XQ(1),XQY=+%,XQPSM=$P(%,U,3),XQDIC=$S($L(XQPSM,",")>1:$P(XQPSM,",",$L(XQPSM,",")),1:XQPSM),XQY0=$P(^XUTL("XQO",XQDIC,U,XQY),U,2,99) G OUT
 D:XQ>0 C G:XQY<0 OUT I XQ=0&('XQXT) S XQY=-1 G OUT
 G OUT
 ;
CHCKTM(XQIEN) ;check Restriction time/date
 N X,Y
 S Y=+$G(XQIEN) I Y'>0 Q 0
 D NEXT^XQ92 I X'<$$NOW^XLFDT,$G(%XQOP)=3.91 Q 0
 Q 1
