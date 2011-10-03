GECSUSTA ;WISC/RFJ/KLD-code sheet status utilities                      ;01 Nov 93
 ;;2.0;GCS;**15**;MAR 14, 1995
 Q
 ;
 ;
RETAIN(DA)         ; retain code sheet da in file
 ;  take out all batching and transmission parameters
 I '$D(^GECS(2100,DA)) Q
 N %,D,D0,DI,DIC,DIE,DQ,DR,X,Y
 S (DIC,DIE)="^GECS(2100,",DR=".1///@;.15///@;.6///@;.8///@;.85///@;.95///@;" D ^DIE
 K ^GECS(2100,DA,"TRANS")
 Q
 ;
 ;
STATUS(DA) ;  show status of code sheet da
 ;  0=retained in file
 N %,X,Y
 W !?1,"Status: << "
 I '$D(^GECS(2100,DA,"TRANS")) W "RETAINED IN FILE >>" Q 0
 ;  1=ready for batching
 S %=^GECS(2100,DA,"TRANS")
 I $P(%,"^")="Y" D  Q 1
 . S X=$P(%,"^",7) W "READY FOR BATCHING [Priority: ",$P(%,"^",10),", Trans Date: ",$E(X,4,5),"-",$E(X,6,7),"-"
 . S Y=X D DD^%DT W $E($P(Y,",",2),2,5),"] >>"
 ;  2=ready for transmission
 I $P(%,"^",2)="Y" D  Q 2
 . S X=$P(%,"^",7) W "READY FOR TRANSMISSION IN BATCH ",$P(%,"^",9)," [Date:",$E(X,4,5),"-",$E(X,6,7),"-"
 . S Y=X D DD^%DT W $E($P(Y,",",2),2,5),"] >>"
 ;  3=transmitted (regular code sheet)
 I $P(%,"^",9)'="" D  Q 3
 . S X=$P($G(^GECS(2101.3,+$O(^GECS(2101.3,"B",$P(%,"^",9),0)),0)),"^",4) W "TRANSMITTED IN BATCH ",$P(%,"^",9)
 . I X'="" D
 . . W " ",$E(X,4,5)_"-"_$E(X,6,7)_"-"
 . . S Y=X D DD^%DT W $E($P(Y,",",2),2,5)," <<"
 ;  3=transmitted (fms code sheet)
 I $P($G(^GECS(2100,DA,0)),"^",2)="FMS",$P(%,"^",3)'="" W "TRANSMITTED IN STACK: ",$P(%,"^",3)," <<" Q 3
 W "RETAINED IN FILE >>" Q 0
