XQ74 ;SEA/MJM - Phantom Jump processor ; ;4/26/91  3:18 PM
 ;;8.0;KERNEL;;Jul 10, 1995
 Q:'$D(XQMM("J"))  I '$L(XQMM("J")) K XQMM("J") G M2^XQ
 I +XQMM("J")=-1 G RESET
 ;
 S XQSV=XQY_U_XQDIC_U_XQY0,XQMMX=XQMM("J"),XQMMK=$P(XQMMX,";",1) K XQMM("J")
 I XQMMK'=+XQMMK S:$D(X) XQMMS=X D SET,CONVERT S:$D(XQMMS) X=XQMMS
 S:$P(XQMMX,";",2)'="" XQMM("J")=$P(XQMMX,";",2,99)
 K XQMMS,XQMMX
 ;
LEGAL ;See if this a legal option for this user
 S XQPSM="P"_^XUTL("XQ",$J,"XQM") I $D(^XUTL("XQO",XQPSM,"^",XQMMK)) S XQDIC=XQPSM D SETJ G ^XQ72
 S XQPSM="PXU" I $D(^XUTL("XQO",XQPSM,"^",XQMMK)) S XQDIC=XQPSM D SETJ G ^XQ72
 S XQPSM="U"_DUZ D:$S('$D(^XUTL("XQO",XQPSM,0)):1,'$D(^VA(200,DUZ,203.1)):1,1:^VA(200,DUZ,203.1)'=$P(^XUTL("XQO",XQPSM,0),U,2)) ^XQSET
 I $D(^XUTL("XQO",XQPSM,"^",XQMMK)) S XQDIC=XQPSM D SETJ G ^XQ72
 F XQI=0:0 S XQI=$O(^XUTL("XQO",XQPSM,U,XQI)) Q:XQI=""  S XQUD="P"_XQI I $P(^(XQI),U,5)="M",$D(^XUTL("XQO",XQUD,U,XQMMK)) S XQPSM="U"_DUZ_","_XQUD D SETJ G ^XQ72
 W !!,"*** WARNING ***",!!,"Background jump requested to option '",$P(^DIC(19,+XQMMK,0),U,2),"'",!,"You do not have access to this option.  Notify your computer",!,"representative."
 G OUT
 ;
SET ;Save the "XQ" stack in XQMM("OLD")
 I ^XUTL("XQ",$J,"T")>1 S XQMM("OLD")=^XUTL("XQ",$J,"T")_U F XQI=2:1:^("T") S XQMM("OLD")=XQMM("OLD")_$P(^(XQI),U,1)_U
 S XQMMSAV=XQDIC_U_XQPSM_U_+XQY_U_XQY0
 ;I XQRB S X="XQRBJ",DIC(0)="XFMZ",DIC=19 D ^DIC S ^XUTL("XQ",$J,2)=+Y_U_XQDIC_U_^DIC(19,+Y,0),^XUTL("XQ",$J,"T")=1,XQST=3
 Q
 ;
SETJ ;Set up the variables for a jump
 S XQY=+XQMMK,XQY0=$S($D(^XUTL("XQO",XQDIC,"^",XQY))#2:$P(^(XQY),U,2,99),1:"") I XQY0="" D S1^XQCHK
 S:$P(XQY0,U,4)="M" XQMMF=""
 K XQA,XQI,XQK,XQMMK,XQUD
 Q
 ;
CONVERT ;Convert option names to their internal #'s an add -1 for return
 S DIC=19,DIC(0)="XFZM",XQMMY=""
 F XQI=1:1 S X=$P(XQMMX,";",XQI) Q:X=""  D ^DIC D:Y<0 MESS1 S:Y>0 XQMMY=XQMMY_+Y_";"
 S XQMMK=$P(XQMMY,";",1),XQMMX=XQMMY_"-1"
 K DIC,X,XQI,XQJ,XQMMY,Y
 Q
 ;
MESS1 W !!,"*** WARNING ***",!!,"Background jump to option '",X,"'",!," requested, but this option does not exist on this system." G RESET
 ;
ERR ;Error message for locks, out-of-order, etc.
 S:$D(XQMMK) XQY=+XQMMK
 W !!?10,"*** WARNING ***",!!,"Illegal jump requested to option '",$P(^DIC(19,+XQY,0),U,2),"'",!,XQNO,!,XQNO1
 ;
RESET ;Reset ^XUTL to what it was before we started
 I '$D(XQMM("OLD"))!('$D(XQMMSAV)) S ^XUTL("XQ",$J,"T")=1,(XQY,XQDIC)=^("XQM"),XQY0=^DIC(19,+XQY,0) G OUT
 S XQDIC=$P(XQMMSAV,U,1),XQPSM=$P(XQMMSAV,U,2),XQY=$P(XQMMSAV,U,3),XQY0=$P(XQMMSAV,U,4,99)
 S ^XUTL("XQ",$J,"T")=$P(XQMM("OLD"),U,1)
 F XQI=2:1:^XUTL("XQ",$J,"T") S XQJ=$P(XQMM("OLD"),U,XQI) Q:XQJ=""  S XQK=$S(XQJ["P":"P",1:"U"),^XUTL("XQ",$J,XQI)=XQJ_^XUTL("XQO",XQK_$P(XQJ,XQK,2),"^",+XQJ)
 ;
OUT K XQA,XQD,XQI,XQJ,XQK,XQMM("J"),XQMM("OLD"),XQMMSAV,XQNO,XQNO1,XQRBJ,XQST,XQZ
 G M^XQ
 Q
