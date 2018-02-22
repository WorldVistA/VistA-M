XVEMDPT ;DJB/VEDD**Pointers In, Pointers Out [1/7/97 3:13pm];2017-08-15  12:21 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
PTI ;Pointers In
 I '$D(^DD(ZNUM,0,"PT")) D  S FLAGG=1 Q
 . W ?30,"No files point to this file."
 NEW FLAGPT,HD,Z1,ZCNT,ZFILE,ZFILEN,ZFLD
 D INIT^XVEMDPR,HD
 S ZFILE="",ZCNT=1,HD="HD"
 F  S ZFILE=$O(^DD(ZNUM,0,"PT",ZFILE)) Q:ZFILE=""!FLAGQ  S FLAGPT=0 D @$S($D(^DIC(ZFILE,0)):"PTIYES",1:"PTINO") I 'FLAGPT S ZFLD="" F  S ZFLD=$O(^DD(ZNUM,0,"PT",ZFILE,ZFLD)) Q:ZFLD=""!FLAGQ  D PTIPRT
EX ;
 Q
PTINO ;Get file name, using a subfile
 NEW UP
 I '$D(^DD(ZFILE,0,"UP")) S FLAGPT=1 Q
 S UP=ZFILE
 F  S UP=^DD(UP,0,"UP") Q:$D(^DIC(UP,0))  Q:'$D(^DD(UP,0,"UP"))
 I '$D(^DIC(UP,0)) S FLAGPT=1 Q
 S ZFILEN=$P(^DIC(UP,0),U)
 Q
PTIYES ;Get file name
 S ZFILEN=$P(^DIC(ZFILE,0),U)
 Q
PTIPRT ;
 W !,$J(ZCNT,4),".",?6,ZFILE,?21,$E(ZFILEN,1,25),?48
 I $D(^DD(ZFILE,ZFLD,0)),$P(^(0),U)]"" D  ;
 . W $E($P(^(0),U),1,22)," (",ZFLD,")"
 E  W "--> Field ",ZFLD," does not exist."
 S ZCNT=ZCNT+1 I $Y>XVVSIZE D PAGE Q:FLAGQ
 Q
PTO ;Pointers Out
 NEW CNT,FILE,HD,NAME,NODE0,NUMBER,Z1,ZDD
 D INIT^XVEMDPR S HD="HD1" D @HD,PTOGET
 Q
PTOGET ;
 S ZDD="",CNT=1
 F  S ZDD=$O(^TMP("XVV","VEDD",$J,"TMP",ZDD)) Q:ZDD=""!(FLAGQ)  S NAME="" F  S NAME=$O(^DD(ZDD,"B",NAME)) Q:NAME=""  S NUMBER="",NUMBER=$O(^DD(ZDD,"B",NAME,"")) D PTOLIST Q:FLAGQ
 I CNT=1 W !!!!!?20,"This file has no fields that",!?20,"point to other files."
 Q
PTOLIST ;
 Q:^DD(ZDD,"B",NAME,NUMBER)=1  ;If node equals 1 it is TITLE not NAME
 S NODE0=^DD(ZDD,NUMBER,0)
 Q:$P(NODE0,U,2)'["P"&($P(NODE0,U,2)'["V")
 I $P(NODE0,U,2)["P" Q:$P(NODE0,U,3)']""
 W !?1,$S(ZDD'=ZNUM:"MULT",1:""),?6,$J(NUMBER,8),?16,NAME
 S FILE="^"_$P(NODE0,U,3)_"0)"
 W ?48,$S($P(NODE0,U,2)["V":"Variable Pointer",$D(@FILE):$E($P(@FILE,U),1,30),1:"-->No such file")
 S CNT=CNT+1 I $Y>XVVSIZE D PAGE Q:FLAGQ=1
 Q
HD ;Pointers to this file
 W !?3,"Pointers TO this file..",!?9,"GLOBAL",?22,"FILE  (Truncated to 25)",?50,"FIELD   (Truncated to 22)"
 W !?6,"-------------",?21,"-------------------------",?48,"------------------------------"
 Q
HD1 ;Pointers from this file
 W !?3,"Pointers FROM this file..",!?6,"FLD NUM",?26,"FIELD NAME",?52,"FILE (Truncated to 30)"
 W !?6,"--------",?16,"------------------------------",?48,"------------------------------"
 Q
PAGE ;
 I FLAGP,$E(XVVIOST,1,2)="P-" W @XVV("IOF"),!!! D @HD Q
 D PAUSEQE^XVEMKC(2) Q:FLAGQ  W @XVV("IOF") D @HD
 Q
