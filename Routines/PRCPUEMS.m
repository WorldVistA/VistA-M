PRCPUEMS ;WISC/RFJ-nightly task to set emergency stock level        ;31 Jan 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;  this program should be queued to run nightly
 N %,I
 S I=0 F  S I=$O(^PRCP(445,I)) Q:'I  S %=0 F  S %=$O(^PRCP(445,I,1,%)) Q:'%  S D=$G(^(%,0)) I $P(D,"^",11)>0,$P(D,"^",7)'>$P(%,"^",11) S $P(^PRCP(445,I,0),"^",9)="Y" Q
 Q
