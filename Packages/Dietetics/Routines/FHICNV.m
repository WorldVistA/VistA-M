FHICNV ; HIOFO/REL - Patch 27 Data Conversion ;11/15/00  10:32
 ;;5.0;Dietetics;**27**;Oct 11, 1995
 ; Clean up admission node
 F K=0:0 S K=$O(^FHPT(K)) Q:K<1  I $D(^FHPT(K,"A")) I $P($G(^FHPT(K,"A",0)),"^",2)'="115.01" S $P(^(0),"^",2)=115.01
 ; Clean up preferences
 S DIK="^FH(115.2,",DIK(1)="1^AD" D ENALL^DIK
 Q
