XTERSUM4 ;ISF/RWF - Find error frequece ;05/27/10  14:25
 ;;8.0;KERNEL;**431**;;Build 35
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
SHOW ;Show the top error
 N DIR,XTERMAX,DIRUT,DTOUT,DUOUT,ZTSAVE
 S DIR(0)="N^1:999",DIR("A")="Number of Errors to show",DIR("B")=5
 D ^DIR Q:$D(DIRUT)
 S XTERMAX=Y,ZTSAVE("XTERMAX")=""
 D EN^XUTMDEVQ("DQ^XTERSUM4","Top Errors",.ZTSAVE)
 Q
 ;
DQ N X,D0,TOP,MAX,I
 S D0=0,U="^",MAX=$G(XTERMAX,5)
 F  S D0=$O(^%ZTER(3.077,D0)) Q:'D0  D CHECK(D0,.TOP)
 S I="A",C=1
 W "Top ",MAX," Most Common Errors",?45,$$HTE^XLFDT($H),!
 F  S I=$O(TOP(I),-1),J="" Q:('I)!(C>MAX)  F  S J=$O(TOP(I,J),-1)  Q:('J)!(C>MAX)  S C=C+1,D0=J D SHOW1(D0)
 Q
 ;
CHECK(D0,TOP) ;
 N I,X,AR
 S X=$$SUMALL(D0,.AR),TOP(X,D0)=0
 Q
 ;
SHOW1(D0) ;Show 1 error
 N X,AR,I,J
 I $Y+10>IOSL D WAIT Q:$D(DIRUT)  W @IOF
 S X=^%ZTER(3.077,D0,0)
 W !!,"Error: ",$P(X,U,1),?45,"Total Count: ",$$SUMALL(D0,.AR)
 W !,"First Seen: ",$$FMTE^XLFDT($P(X,U,2)),?45,"Last Seen: ",$$FMTE^XLFDT($P(X,U,3))
 Q:$D(AR)<10
 W !,"Distribution over ",+AR," days"
 S RANGE=""
 F J=3:-1:0 W !,?5,$S(J:J*10,1:">0")," " F I=1:1:24 W $S('AR(I):" ",AR(I)'<(J*10):"x",1:" ")
 W !,"  Time: 1--4---8--12--16--20--24"
 Q
 ;
SUMALL(IEN,RET) ;Check one error
 N H,TOTAL,CNT,T,I,X
 S H=0,TOTAL=0,CNT=0
 F  S H=$O(^%ZTER(3.077,IEN,4,H)) Q:'H  S TOTAL=TOTAL+$$SUM1(.RET,IEN,H),CNT=CNT+1
 S RET=CNT
 Q TOTAL
 ;
SUM1(RET,IEN,H) ;Sum over one day, return array
 ;New at caller
 S X=$G(^%ZTER(3.077,IEN,4,H,0)),T=0
 I $L(X) F I=1:1:24 S RET(I)=$G(RET(I))+$P(X,"~",I),T=T+$P(X,"~",I)
 Q T
 ;
WAIT ;Wait at end of page
 Q:$E(IOST,1)="P"
 N DIR
 S DIR(0)="E" D ^DIR
 Q
