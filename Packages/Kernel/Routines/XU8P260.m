XU8P260 ;OAK-BP/BDT ;STATE FILE CORRECTION; [11/13/02 7:35am]
 ;;8.0;KERNEL;**260**;Jul 10, 1995
 ;Correct misspelling for Chittenden county of Vermont
CRTP ;
 N X
 ;loop through sub-file county of Vermont
 S X=0 F  S X=$O(^DIC(5,50,1,X)) Q:X'>0  D
 .;correct VA CODE for LAMOILLE
 .I $P($G(^DIC(5,50,1,X,0)),"^")="LAMOILLE" D
 ..S $P(^DIC(5,50,1,X,0),"^",3)="015"
 .;check misspelling
 .I $P($G(^DIC(5,50,1,X,0)),"^")="CHITTENDON" D
 ..;correct misspelling
 ..S $P(^DIC(5,50,1,X,0),"^")="CHITTENDEN"
 ..;reindex to correct misspelling for B x-ref
 N DA,DIK S DIK="^DIC(5," D IXALL2^DIK
 N DA,DIK S DIK="^DIC(5," D IXALL^DIK
 Q
