XQOO ;SEATTLE/LUKE - Out Of Order, Man ;9/13/96  09:21
 ;;8.0;KERNEL;**10,21,47,520**;Jul 03, 1995;Build 5
 ;Per VHA Directive  2004-038, this routine should not be modified.
INIT(XQSET) ;Call for Out-of-order set creation, called by KIDS
 ;
 ;The variable XQSET should be null if this is the first pass
 ;or if KIDS thinks the user wants a new set of options
 ;
 S XQINI="",XQK=0 ;XQINI used as a flag to see if it's KIDS calling
 I XQSET]"" S:'$D(^XTMP("XQOO",XQSET,0)) XQSET="^"
 I XQSET="^" G OUT
 I XQSET]"" S XQMESS=$P(^XTMP("XQOO",XQSET,0),U) G ASK1
 ;
EN ;Entry point for Define Out Of Order Options Set option
 S XQK=0,U="^",XQSET=U
 ;
NAME ;Get name for this option set
 W !!,"Enter a short name for this set of options and or protocols: " R XQSET:DTIME S:'$T XQSET=U G:XQSET=U OUT
 I XQSET="?" W !!,"Enter a name of 20 characters or less for this set, '^' to quit, or '??' for help" G NAME
 I XQSET["??" S XQH="XQOO-NAME" D EN^XQH G NAME
 I XQSET=""!($L(XQSET)>20) W !!,"Out-of-order sets must be named with 20 or less characters.  Enter '^' to quit." G NAME
 I $D(^XTMP("XQOO",XQSET,0)) D  G:$D(DIRUT) OUT G:Y=0 NAME G ASK1
 .S XQMESS=$P(^XTMP("XQOO",XQSET,0),U)
 .W !!,"WARNING: The Out-of-order set '",XQSET,"' already exists.",!
 .S DIR("A")="Do you want to modify it? (Y/N) " S DIR(0)="Y",DIR("B")="YES" D ^DIR K DIR
 .Q
 ;
MESS ;Get the Out Of Order Message
 R !!,"What should the Out Of Order message text be? :",XQMESS:DTIME S:'$T XQMESS=U G:XQMESS=U OUT
 I XQMESS="?" W !!,"This is the message that will be shown with the options/protocols",!,"that are made out of order. For instance, ""Laboratory install in progress""" G MESS
 I XQMESS["??" S XQH="XQOO-MESS" D EN^XQH G MESS
 ;
ASK1 S XQFIL=19
ASK ;Get options to mark
 S (XQ,XQN)=""
 W !!,"Enter "_$S(XQFIL=19:"options",1:"protocols")_" you wish to mark as 'Out Of Order': "
 R XQ:DTIME S:'$T XQ=U G:XQ=U OUT G:XQ="" SET
 I XQ="?" D  G ASK
 .W !!?5,"Enter "_$S(XQFIL=19:"an option",1:"a protocol")_" name,"
 .W !?5,"a name preceded by a minus sign to remove "_$S(XQFIL=19:"an option,",1:"a protocol,")
 .W !?5,$S(XQFIL=19:"'^PR'",1:"'^OP'")_" to switch to "_$S(XQFIL=19:"protocols,",1:"options,")
 .W !?5,"an uparrow (that is '^') to quit,"
 .W !?5,"or '??' for more help."
 .Q
 I XQ["??" S XQH="XQOO" D:XQ="??" EN^XQH D:XQ="???" LIST D:XQ="????" LSTFIL S XQH="XQOO-MAIN" D:XQ="?????" EN^XQH G ASK
 I $E(XQ,1,3)="^OP"!($E(XQ,1,3)="^op") S XQFIL=19,XQSWTCH="" G ASK
 I $E(XQ,1,3)="^PR"!($E(XQ,1,3)="^pr") S XQFIL=101,XQSWTCH="" G ASK
 S XQDEL=0 I $E(XQ,1)="-" S XQDEL=1,XQ=$E(XQ,2,99)
 I XQ="*",XQDEL K ^XTMP("XQOO",XQSET,XQFIL) W !," All "_$S(XQFIL=19:"options",1:"protocols")_" removed.  Start again or '^' to quit. " G ASK
 I XQ="*" S XQSTART=1,XQEND="ZZZZZ" D FIND G ASK
 I XQ?.E1"*" S XQSTART=$E(XQ,1,$L(XQ)-1),XQEND=XQSTART_$C(127) D FIND G ASK
 ;Get a range of options allowing for name with hyphens in them
 I XQ?1E.E1"-"1E.E S XQRNG=0 D  G:'XQRNG ASK
 .;Name has hyphen, echo back the name and quit
 .S X=XQ,DIC=XQFIL,DIC(0)="EZ" D ^DIC I Y>0 S XQ=$P(Y,U,2),XQRNG=1 Q
 .;It is a range, build prompt to verify range
 .W ! K DIR S DIR("A")="Do mean the "_$S(XQFIL=19:"options",1:"protocols")_" from "_$P(XQ,"-")_" to "_$P(XQ,"-",2)_"? (Y/N)",DIR(0)="YA" D ^DIR K DIR I Y S (XQN,XQSTART)=$P(XQ,"-",1),XQEND=$P(XQ,"-",2) D FIND
 .Q
 ;
 I XQ'?1E.E1"-"1E.E S X=XQ,DIC=XQFIL,DIC(0)="MEZ" D ^DIC S:Y'<0 XQ=$P(Y,U,2) I Y<0 W " ??",*7 G ASK
 I XQDEL K ^XTMP("XQOO",XQSET,XQFIL,+Y) G ASK
 S:$E(Y(0),1,4)'="XQOO" ^XTMP("XQOO",XQSET,XQFIL,+Y)=$P(Y(0),U)_U_$P(Y(0),U,2) G ASK
 ;
FIND ;Find first option in wildcard list
 S XQN="" S:$L(XQSTART)>2 XQN=$E(XQSTART,1,$L(XQSTART)-1)
 I XQFIL=19 F XQI=0:0 S XQN=$O(^DIC(XQFIL,"B",XQN)) Q:XQN=""!($E(XQN,1,$L(XQSTART))=XQSTART)
 E  F XQI=0:0 S XQN=$O(^ORD(101,"B",XQN)) Q:XQN=""!($E(XQN,1,$L(XQSTART))=XQSTART)
 I XQN="" W !," No such ",$S(XQFIL=19:"option(s).",1:"protocol(s).") Q
 S XQSTART=XQN
 ;
FINDR I XQFIL=19 S XQON=$O(^DIC(XQFIL,"B",XQN,0)),XQON0=^DIC(XQFIL,+XQON,0)
 E  S XQON=$O(^ORD(XQFIL,"B",XQN,0)),XQON0=^ORD(XQFIL,+XQON,0)
 I XQDEL D DELET Q
 ;
GET ;Get the first option selected and put it in ^XTMP
 S XQN=XQSTART I $E(XQON,1,4)'="XQOO" S ^XTMP("XQOO",XQSET,XQFIL,+XQON)=$P(XQON0,U)_U_$P(XQON0,U,2),XQK=XQK+1
 S DIC=XQFIL,DIC(0)="MZ"
 ;
NEXT ;Find the rest of the options in this range and do likewise
 I XQFIL=19 F  Q:XQN=XQEND  S XQN=$O(^DIC(XQFIL,"B",XQN)) Q:XQN=""!(XQN]XQEND)  S XQON=$O(^DIC(XQFIL,"B",XQN,0)),XQON0=^DIC(XQFIL,+XQON,0) I $E(XQON,1,4)'="XQOO" S ^XTMP("XQOO",XQSET,XQFIL,+XQON)=$P(XQON0,U)_U_$P(XQON0,U,2),XQK=XQK+1
 E  F  Q:XQN=XQEND  S XQN=$O(^ORD(XQFIL,"B",XQN)) Q:XQN=""!(XQN]XQEND)  S XQON=$O(^ORD(XQFIL,"B",XQN,0)),XQON0=^ORD(XQFIL,+XQON,0) I $E(XQON,1,4)'="XQOO" S ^XTMP("XQOO",XQSET,XQFIL,+XQON)=$P(XQON0,U)_U_$P(XQON0,U,2),XQK=XQK+1
 Q
 ;
DELET ;Delete option(s) from the list in ^XTMP
 ;W !,XQON,"  ",XQSTART,"  ",XQDEL
 S XQN=XQSTART,XQDEL=0
 I XQFIL=19 F  K ^XTMP("XQOO",XQSET,XQFIL,+XQON) S XQN=$O(^DIC(XQFIL,"B",XQN)),XQX=XQK-1 Q:XQN=""!(XQN]XQEND)  S XQON=$O(^DIC(XQFIL,"B",XQN,0))
 E  F  K ^XTMP("XQOO",XQSET,XQFIL,+XQON) S XQN=$O(^ORD(XQFIL,"B",XQN)),XQX=XQK-1 Q:XQN=""!(XQN]XQEND)  S XQON=$O(^ORD(XQFIL,"B",XQN,0))
 Q
 ;
REMOV R !!,"Remove all options previously selected? ",XQ:DTIME S:'$T XQ=U G:XQ[U OUT I XQ["N"!(XQ["n") W !!,"OK, you may continue." G ASK
 K ^XTMP("XQOO",XQSET)
 Q
LSTFIL ;Show Option File
 N XQE,XQR,XQS
 D RANGE^XQOO2(.XQS,.XQE,.XQR) I XQR D BXREF^XQOO2(XQS,XQE)
 Q
 ;
LIST ;List users and options selected so far.
 W @IOF S (XQT,XQM)=0
 F XQFIL0=19,101 D
 .S XQT=0,XQN=0,XQN=$O(^XTMP("XQOO",XQSET,XQFIL0,XQN)) I XQN="" W !!,"No "_$S(XQFIL0=19:"menu options",1:"protocols")_" selected yet" Q
 .W !!,"You will place Out Of Order the following "_$S(XQFIL0=19:"options:",1:"protocols:"),! F XQI=0:0 D:$Y+3>IOSL WAIT Q:XQ=U  W !,$P(^XTMP("XQOO",XQSET,XQFIL0,XQN),U,2)_"   ["_$P(^(XQN),U)_"]   (IEN = "_XQN_")" S XQN=$O(^(XQN)) Q:XQN=""
 .Q
 Q
 ;
WAIT ;Skip to the head of the next page
 I 1 S XQ="" R:IOST["C-" !!,"Press RETURN to continue, or '^' to quit.",XQ:DTIME S:'$T XQ=U W @IOF
 Q
 ;
SET ;Set 0th node in ^XTMP global
 I XQFIL=19,'$D(XQSWTCH) S XQFIL=101 G ASK
 D ^XQDATE
 I $D(^XTMP("XQOO",XQSET,0)) S XQMESS=$P(^(0),U)
 S ^XTMP("XQOO",XQSET,0)=XQMESS_U_%Y_U_$P(^VA(200,DUZ,0),",")
 S ^XTMP("XQOO",0)=DT_U_DT+7
 ;
OUT ;Clean up
 ;
 I '$D(XPDNM),'$D(^XTMP("XQOO",XQSET,0)),$D(^XTMP("XQOO",XQSET)) D
 .;Temporary Fix: ^ at protocol prompt leaves partial set (no 0th node)
 .S DIR(0)="Y",DIR("B")="YES"
 .S DIR("A")="Delete this set of options? (Y/N) "
 .D ^DIR
 .I Y K ^XTMP("XQOO",XQSET)
 .E  D ^XQDATE S ^XTMP("XQOO",XQSET,0)=XQMESS_U_%Y_U_$P(^VA(200,DUZ,0),","),^XTMP("XQOO",0)=DT_U_DT+7
 .Q
 ;
 I '$D(XPDNM),$D(^XTMP("XQOO",XQSET,0)) D
 .S DIR(0)="Y",DIR("B")="NO"
 .S DIR("A")="Should I mark these options/protocols out-of-order now? (Y/N) "
 .D ^DIR I Y D OFF^XQOO1(XQSET)
 .Q
 ;
 K %,%Y,DIRUT,XQ,XQDEL,XQEND,XQFIL,XQFIL0,XQH,XQI,XQINI,XQK,XQM,XQMESS,XQN,XQON,XQON0,XQRNG,XQSTART,XQSWTCH,XQT,XQX,X,Y
 Q
