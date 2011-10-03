FBCHREQ2 ;AISC/DMK-RECONSIDER A DENIED NOTIFICATION ;4/28/93  11:01
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;check if user holds 'FBAASUPERVISOR' key
 Q:'$G(DUZ)
 I '$D(^XUSEC("FBAASUPERVISOR",DUZ)) W !,*7,"You must be a holder of the 'FBAASUPERVIVOR' key to reconsider a denied request.",! Q
 ;look-up a request that has been previously denied
 S DIC("S")="S FBZ=^(0) I $P(FBZ,U,15)=3&($P(FBZ,U,9)=""N""!($P(FBZ,U,12)=""N"")) K FBZ"
 D ASKV^FBCHREQ G END:X=""!(X="^") K DIC
 ;display selected request for reconsideration
 Q:'$G(DA)  W ! S DR="0:99",DIC="^FBAA(162.2," D EN^DIQ K DIC
 ;ask if correct selection
 S DIR(0)="Y",DIR("A")="Is this the correct request",DIR("B")="Yes" D ^DIR K DIR G FBCHREQ2:'Y
 ;continue and determine if legal or medical denial, reset fields
 S FB=$G(^FBAA(162.2,+FBDA,0)) G END:FB']""
 S FB1=$S($P(FB,"^",9)="N":1,$P(FB,"^",12)="N":2,1:"") G FBCHREQ2:'FB1
 S DIE="^FBAA(162.2,",DR="[FBCH REOPEN REQUEST]" D ^DIE K DIE,DR G FBCHREQ2:$D(DTOUT)!($D(DUOUT))
 S FBLENT="",DA=FBDA,DIC="^FBAA(162.2,"
 G @$S(FB1=1:"LENT1^FBCHREQ",FB1=2:"MENT1^FBCHREQ",1:"FBCHREQ2")
 ;kill variables and exit
END K DA,FBDA,FBNAME,FBSSN,FB,FB1,FBDFN,DIC,DIE,ZZ
 Q
DISPLAY ;display for a data range those requests that have been reconsidered
 ;ask date range
 D DATE^FBAAUTL Q:FBPOP
 S FBBEG=BEGDATE-.1,FBEND=ENDDATE+.9
 I '$O(^DIA(162.2,"C",0)) W !?5,*7,"No audit data on file.",! G Q
 ;check Audit file for entries
 S PGM="START^FBCHREQ2",VAR="FBBEG^FBEND^BEGDATE^ENDDATE" D ZIS^FBAAUTL G Q:FBPOP
START ;
 U IO I $E(IOST,1,2)="C-" W @IOF
 S J=0,QQ="=",$P(QQ,"=",80)="=" D HED
 F I=FBBEG:0 S I=$O(^DIA(162.2,"C",I)) Q:'I!(I>FBEND)  F  S J=$O(^(I,J)) Q:'J  S FB(1)=$G(^DIA(162.2,+J,0)),FB=$G(^FBAA(162.2,+FB(1),0)) D:FB]""
 .W !,$$NAME($P(FB,"^",4))," -",$$SSN^FBAAUTL($P(FB,"^",4),1)
 .W ?50,$$DATX^FBAAUTL($P(FB,"^"))
 .W !?5,"Field changed: ",$P(^DD(162.2,+$P(FB(1),"^",3),0),"^"),"  By: ",$P($G(^VA(200,+$P(FB(1),"^",4),0)),"^")
 .W !?10,"Date of Change: ",$$DATX^FBAAUTL($P(FB(1),"^",2))
 .I $E(IOST,1,2)="C-",$Y+4>IOSL S DIR(0)="E" D ^DIR S:'Y FBOUT=1 I Y W @IOF D HED
 .E  I $Y+4>IOSL W @IOF D HED
 I '$D(FBOUT),$E(IOST,1,2)="C-" W ! S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR
Q W ! K FB,FBOUT,FBBEG,FBEND,I,J,QQ,Y,DUOUT,DIRUT,DTOUT,BEGDATE,ENDDATE
 D CLOSE^FBAAUTL Q
NAME(X) ;
 ;X=DFN  returns patient name
 I $D(X),X Q $E($P($G(^DPT(X,0)),"^"),1,40)
 Q "Unknown"
HED ;
 W !?15,"AUDIT on FEE NOTIFICATION ENTITLEMENT CHANGE",!?25,$$DATX^FBAAUTL(BEGDATE)," TO ",$$DATX^FBAAUTL(ENDDATE),!?14,$E(QQ,1,46),!
 W !,"PATIENT NAME",?49,"DATE/TIME of NOTIFICATION",!?5,"FIELD CHANGED",?39,"SUPERVISOR",!,QQ,!!
 Q
