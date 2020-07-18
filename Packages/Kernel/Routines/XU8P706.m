XU8P706 ;OAK_BP/BDT - POST ROUTINE 706 REINDEX THE LOC1 X-REF; 2/07/19
 ;;8.0;KERNEL;**706**;Jul 10, 1995;Build 2
 ;;Per VHA Directive 6402, this routine should not be modified.
 ; 
 Q
 ;
PRE ; Delete x-ref
 I $G(^DD(4,720,1,1,0))="4^LOC1^MUMPS" D DELIX^DDMOD(4,720,1,"K")
 Q
 ;
POST ; Re-index the LOC nodes
 D DEL,BUILD
 Q
DEL ;
 N DIK
 S DIK="^DIC(4,"
 S DIK(1)=720
 D ENALL2^DIK
 Q
BUILD ;
 N DIK
 S DIK="^DIC(4,"
 S DIK(1)=720
 D ENALL^DIK
 Q
