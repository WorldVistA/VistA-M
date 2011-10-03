XQ55 ; SEA/AMF,MJM,JLI - SEARCH FOR USERS ACCESS TO AN OPTION;
 ;;8.0;KERNEL;**140,342,483,508**;Jul 10, 1995;Build 1
 ;;Per VHA Directive 2004-038, this routine should not be modified
INIT ;
 S XQDSH="-------------------------------------------------------------------------------"
 D ^XQDATE S XQDT=%Y
OPT W ! S DIC=19,DIC(0)="AEQM" D ^DIC G:Y=-1 OUT S XQOPT=+Y
MPAT W !!,"Show menu paths" S %=2 D YN^DICN G:%<0 OUT S XQMP=2-% I '% W !!,"If you answer 'YES', the listing will include the menu path(s) each user has",!,"to access the specified option." G MPAT
 K ^TMP($J),XQR,XQP
 S K=^DIC(19,XQOPT,0),XQHDR="Access to '"_$P(K,U,2)_"'  ["_$P(K,U,1)_"]",XQSCD=0,XQCOM=0,XQNOPRNT=0
LOOP1 S K=XQOPT,(L,X(0))=0,XQD=K K XQR,XQA,XQK,XQRV S XQR(K)="" I '$L($P(^DIC(19,K,0),U,3)) D TREE1
 G LOOP2
 Q
TREE S X(L)=$O(^DIC(19,"AD",XQD,X(L))) Q:X(L)'>0  S K=X(L) G:$D(XQR(K)) TREE S XQR(K)=""
TREE1 ;
 S Y(0)=^DIC(19,K,0) G:$L($P(Y(0),U,3)) TREE S:$L($P(Y(0),U,6)) XQK(L)=$P(Y(0),U,6) S XQA(L)=K I $P(Y(0),U,16) S XQRV(L)=^DIC(19,K,3)
 D SETGLO S L=L+1,X(L)=0,(XQD,XQD(L))=K D TREE
 Q:L=1  K XQR(XQD(L)) S L=L-1 K XQA(L),XQK(L),XQRV(L) S XQD=XQD(L) G TREE
 Q
SETGLO ;
 S XQK="" F I=L:-1:0 I $D(XQK(I)),$L(XQK(I)) S XQK=XQK_XQK(I)_","
 S XQRV="" F I=L:-1:0 I $D(XQRV(I)),$L(XQRV(I)) S XQRV=XQRV_XQRV(I)_","
 S XQA="" F I=L:-1:1 I $D(XQA(I)) S XQA=XQA_XQA(I)_","
 S XQA=XQA_XQOPT,J=0 S:$D(^TMP($J,K,0)) J=^(0) S J=J+1,^(0)=J,^TMP($J,K,J)=XQK_U_XQA_U_XQRV
 Q
LOOP2 ;
 S XQPA(0)=0,XQP=0 F  S XQP=$O(^TMP($J,XQP)) Q:XQP=""  S XQN=^TMP($J,XQP,0) S XQPS="AP" D USERS S XQPS="AD" D USERS
 D USERS1 I XQNOPRNT G MUS ; 080115 - add in options from the common menu
 G LOOP3
USERS ;
 S XQU=0 F  S XQU=$O(^VA(200,XQPS,XQP,XQU)) Q:XQU'>0  I $D(^VA(200,XQU,.1)),+$$ACTIVE^XUSER(XQU) D EACHU
 Q
USERS1 ; 080115 code added to handle options on the COMMON (XUCOMMAND) menu
 N XUCOMMON
 S XUCOMMON=$O(^DIC(19,"B","XUCOMMAND",0))
 S XQP=0 F  S XQP=$O(^TMP($J,XQP)) Q:XQP=""  S XQN=^TMP($J,XQP,0) F J=1:1:XQN Q:'$D(^TMP($J,XQP,J))  I $P($P(^TMP($J,XQP,J),U,2),",")=XUCOMMON D
 . D  Q:'Y
 . . W !,"***"
 . . W !,"*** This option is available from the 'SYSTEM COMMAND OPTIONS'  ***"
 . . W !,"*** (XUCOMMAND) menu available to all active users unless       ***"
 . . W !,"*** protected by a KEY - DO YOU REALLY WANT THE ENTIRE LIST     ***"
 . . W !,"*** OF THESE USERS???                                           ***",!
 . . N DIR S DIR(0)="Y" D ^DIR S:'Y XQNOPRNT=1 Q:'Y
 . . Q
 . S XQU=0,XQPS="(C)" F  S XQU=$O(^VA(200,XQU)) Q:XQU'>0  I $D(^VA(200,XQU,.1)),+$$ACTIVE^XUSER(XQU),$$KEYCHECK() S II=1 D SETU
 Q
 ;
EACHU ;
 S II=1
 F J=1:1:XQN Q:'$D(^TMP($J,XQP,J))  I $$KEYCHECK() D SETU ; 080115
 Q
 ;
KEYCHECK() ; 080115 extracted common code
 ; returns 1 if user has access to the option, 0 if the user does not have access
 S XQK=$P(^TMP($J,XQP,J),U,1),XX=$L(XQK,",")-1,XQGO=1
 I XX F X=1:1:XX S Y=$P(XQK,",",X) I Y'="",('$D(^XUSEC(Y,XQU))) S XQGO=0
 S XQK=$P(^TMP($J,XQP,J),U,3),XX=$L(XQK,",")-1
 I XX F X=1:1:XX S Y=$P(XQK,",",X) I Y'="",($D(^XUSEC(Y,XQU))) S XQGO=0
 Q XQGO
 ;
SETU ;
 S XQPA=$P(^TMP($J,XQP,J),U,2)
 I '$D(XQPA(XQPA)) S I=XQPA(0)+1,XQPA(0)=I,XQPA(0,I)=XQPA,XQPA(XQPA)=I
 S XQPA=XQPA(XQPA) S:XQPS="AD" XQPA=XQPA_"(S)",XQSCD=1 S:XQPS="(C)" XQPA=XQPA_"(C)",XQCOM=1 ; 080115
 S I=$P(^VA(200,XQU,0),U,1)_U_XQU S:$D(^TMP($J,0,I)) II=$O(^TMP($J,0,I,"A"),-1)+1 S ^TMP($J,0,I,II)=XQPA
 Q
LOOP3 ;
 I $O(^TMP($J,0,0))="" W !!,"** NO USERS CAN ACCESS THIS OPTION **" G OUT
 S %ZIS="MFQ" D ^%ZIS G OUT:POP I $D(IO("Q")) K IO("Q") S ZTRTN="DQ^XQ55",ZTDESC="OPTION ACCESS BY USER",ZTSAVE("XQ*")="",ZTSAVE("^TMP($J,")="" D ^%ZTLOAD K ZTSK,ZTRTN,ZTSAVE,ZTDESC G OUT
 ;
DQ ;Entry point for queued job
 U IO
 S:'XQMP XQPA(0)=-4 S XQPG=0,XQUI=0 D NEWPG G:XQUI MUS
 S XQU=0 F  S XQU=$O(^TMP($J,0,XQU)) Q:XQU=""  D PRTU G:XQUI MUS
 D:XQMP MENUPAT G MUS
NEWPG ;
 S X="" I XQPG,$E(IOST,1)="C" D CON S XQUI=(X="^") Q:XQUI
 D HDR Q
CON ;
 W !!,"Press return to continue or '^' to escape " R X:DTIME S:'$T X=U
 Q
HDR ;
 W @IOF S XQPG=XQPG+1
 W "Page ",XQPG,?62,XQDT,!! S XQTAB=(76-$L(XQHDR))/2 W ?XQTAB,XQHDR
 W !!,"USER NAME",?27,"LAST ON",?37,"PRIMARY MENU" W:XQMP ?63,"PATH(S)"
 W !,$E(XQDSH,1,25),?27,$E(XQDSH,1,8),?37,$E(XQDSH,1,$S(XQMP:24,1:40)) W:XQMP ?63,$E(XQDSH,1,14)
 Q
PRTU ;
 I $Y>(IOSL-XQPA(0)-8) D:XQMP MENUPAT D NEWPG Q:XQUI
 S J=$P(XQU,U,2),K="" S:$D(^VA(200,J,1.1)) K=$P(^(1.1),"^") S:$L(K) K=$E(K,4,5)_"/"_$E(K,6,7)_"/"_$E(K,2,3) W !,$E($P(XQU,U,1),1,27),?27,K
 I $D(^VA(200,J,201)) S K=+^(201) I K>0,$D(^DIC(19,K,0)) W ?37,$E($P(^(0),U,1),1,24)
 I XQMP D
 .W ?63,""
 .S JJ=$O(^TMP($J,0,XQU,"A"),-1)
 .F II=1:1:JJ W $G(^TMP($J,0,XQU,II)) I II'=JJ W ","
 I 'XQMP D
 .S II=0 F  S II=$O(^TMP($J,0,XQU,II)) Q:II'>0  D
 ..I ^TMP($J,0,XQU,II)["(S)" W "  (Secondary menu)" S II="A"
 Q
MENUPAT ;
 W !!,$E(XQDSH,1,27),"     MENU PATH(S)     ",$E(XQDSH,1,29),!
 F I=1:1:XQPA(0) S K=XQPA(0,I) W !,I,".",?4 F N=1:1 Q:'$L($P(K,",",N))  W:N>1 " ... " W $P(^DIC(19,$P(K,",",N),0),U,1)
 I XQSCD W !,"(S) - secondary menu pathway"
 I XQCOM W !,"(C) - SYSTEM COMMAND OPTIONS (XUCOMMAND) menu pathway"
 Q
MUS G:X="^" OUT I $G(XQPG),$E(IOST,1)="C" W !!,"Press return when finished viewing " R X:DTIME W @IOF G OUT
 I $D(ZTSK) K ^%ZTSK(ZTSK)
OUT ;
 D ^%ZISC
KILL K XQDT,XQGO,XQN,XQP,XQR,XQRV,XQOPT,XQPA,XQUI,XQSCD,XQDSH,XQU,N,K,J,X,XQA,XQD,XQHDR,XQK,XQP,XQPS,XQMP,XQPG,XX
 K DIC,I,II,JJ,L,POP,Y,XQNOPRNT I $D(ZTQUEUED),$D(ZTSK),ZTSK>0 K ^%ZTSK(ZTSK)
 Q
