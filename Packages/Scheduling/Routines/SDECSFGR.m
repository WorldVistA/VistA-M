SDECSFGR ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
 ; NOTE TO PROGRAMMERS;  Use entry point EN.  Do not use the
 ; first line of this routine, as pending initiatives in MDC
 ; might make a formal list on the first line of a routine
 ; invalid.  GTH 07-10-95
 ;
 ; Given a file or subfile number and global reference form,
 ; this routine will return the global reference in the form
 ; specified.
 ;
 ; F (form) is optional but if passed should equal 1 or 2.
 ; If F is not passed the default form will be 1.
 ;
 ;   F = 1 will be in the form ^GLOBAL(DA(2),11,DA(1),11,DA,
 ;   F = 2 will be in the form ^GLOBAL(D0,11,D1,11,D2,
 ;
 ; Formal list:
 ;
 ; 1) S = subfile number (call by value)
 ; 2) G = global reference (call by reference)
 ; 3) F = global reference form (call by value)
 ;
 ; *** NO ERROR CHECKING DONE ***
 ;
START ;
 ; D = Field
 ; I = Counter
 ; L = Level
 ; N = Node
 ; P = Parent
 ;
 NEW D,I,L,N,P
 ;
 S G="",L=1
 I '$D(^DD(S,0,"UP")) D NOPARENT Q
 D BACKUP
 S G=^DIC(P,0,"GL")
 I $G(F)=2 D  S G=G_"D"_(I+1)_"," I 1
 . F I=0:1 S G=G_"D"_I_","_N(99-L)_",",L=L-1 Q:L=0
 . Q
 E  D  S G=G_"DA,"
 . F L=L:-1:0 Q:L=0  S G=G_"DA("_L_"),"_N(99-L)_","
 . Q
 Q
 ;
BACKUP ; BACKUP TREE
 S P=^DD(S,0,"UP")
 S D=$O(^DD(P,"SB",S,""))
 S N(99-L)=$P($P(^DD(P,D,0),"^",4),";",1)
 S:N(99-L)'=+N(99-L) N(99-L)=""""_N(99-L)_""""
 I $D(^DD(P,0,"UP")) S S=P,L=L+1 D BACKUP
 Q
 ;
NOPARENT ; for no parent
 S G=^DIC(S,0,"GL")
 I $G(F)=2 S G=G_"D0" I 1
 E  S G=G_"DA,"
 Q
 ;
DIC(S) ;PEP - Extrinsic entry to return root global from FILE number
 NEW G
 D EN(S,.G)
 S G=$P(G,"DA,")
 Q G
 ;
EN(S,G,F) ;PEP - RETURN SUBFILE GLOBAL REFERENCE
 G START
 ;--------------------
