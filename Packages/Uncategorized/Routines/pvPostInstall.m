pvPostInstall ; Platium VistA Post Install;2018-03-16  11:07 AM
 W "Deleting source code for DSI*",!
 N R,STOP S (R,STOP)="DSI"
 N %
 F  S R=$O(^$ROUTINE(R)) Q:R=""  Q:$E(R,1,3)'=STOP  S %=##class(%Routine).Delete(R,2)
 ;
 W "Deleting source code for VEJD*",!
 N R,STOP S (R,STOP)="VEJD"
 N %
 F  S R=$O(^$ROUTINE(R)) Q:R=""  Q:$E(R,1,3)'=STOP  S %=##class(%Routine).Delete(R,2)
 ;
 W "Deleting source code for VEN*",!
 N R,STOP S (R,STOP)="VEN"
 N %
 F  S R=$O(^$ROUTINE(R)) Q:R=""  Q:$E(R,1,3)'=STOP  S %=##class(%Routine).Delete(R,2)
 ;
 W "Deleting source code for DSS*",!
 N R,STOP S (R,STOP)="DSS"
 N %
 F  S R=$O(^$ROUTINE(R)) Q:R=""  Q:$E(R,1,3)'=STOP  S %=##class(%Routine).Delete(R,2)
 ;
 W "Deleting invalid fields...",!
 F I=0:0 S I=$O(^DD(I)) Q:'I  F J=0:0 S J=$O(^DD(I,J)) Q:'J  K:'$D(^DD(I,J,0)) ^DD(I,J)
 QUIT
