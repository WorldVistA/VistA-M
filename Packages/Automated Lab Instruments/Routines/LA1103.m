LA1103 ;SLC/RWF -  TO CHECK THE STATUS OF THE LSI-11 INTERFACE ; 8/5/87  21:0 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
ASK ;from LRJOB
 I '$D(^LA("Q")) W !,"There are no LAB routines running to check" Q
 S X=$O(^LAB(62.4,0)) I (X<1)!(X>91) W !,"There are no Interface's in the Auto-instrument file." Q
 F LR=1:10:91 IF $D(^LAB(62.4,LR,0)) W !,"Checking Interface # ",LR D AS1
 K I,LR,Q,X,LROLD,LRCNT,LRPCNT,T,LROUT,LRANS Q
AS1 I '$D(^LA(LR,"I")) W "  Routine for this Interface not started." Q
 S T=LR,X=0,LROUT=1,LROLD=^LA(LR,"I") D OUT K LRPCNT
AS2 W !,"Interface check ... This may take a minute. "
 F I=1:1:15 Q:^LA(LR,"I")>LROLD  H 2
 S LRCNT=^LA(LR,"I"),LRANS=^LA(LR,"I",LRCNT)
 W !,"Interface data line is ",$S(LROLD=LRCNT:"NOT WORKING",1:"OK "_LRANS),!
 IF LROLD=LRCNT,'$D(LRPCNT) W !,"LET ME TRY ONCE MORE" S LRPCNT=1 G AS2
 Q
OUT S LRCNT=^LA(T,"O")+1,^("O")=LRCNT,^("O",LRCNT)=LROUT
 LOCK ^LA("Q") S Q=^LA("Q")+1,^("Q")=Q,^("Q",Q)=T LOCK
 Q
ACK ;Build and send the ACK triger/responce string
 F LR=1:10:91 I $D(^LAB(62.4,LR,0)) W:'$D(ACK) !,"Sending string for Interface # ",LR D AC2
 K I,LR,LROUT,Q,LRCNT,X Q
AC2 S LROUT="" F I=LR:1:LR+9 S X=$S($D(^LAB(62.4,I,0)):^(0),1:""),LROUT=LROUT_$E(100+$P(X,"^",13),2,3)_$E(100+$P(X,"^",14),2,3)
 S T=LR D OUT W:'$D(ACK) !?10,"$L(",LROUT,")=",$L(LROUT) Q
