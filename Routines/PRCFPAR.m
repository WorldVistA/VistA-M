PRCFPAR ;WISC/LEM-PARTIAL NUMBER UTILITY ;9/20/94  10:05
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 N N1 S N1=$G(^PRCF(421.5,PRCF("CIDA"),1))
 S PRCF("PO")=$P(N1,U,3),PRCF("PA")=$P(N1,U,6)
 I PRCF("PA")'?1N.UN D
NEXT . ; Obtain next available Partial# for the PO
 . N K S K=0,Y=$O(^PRCF(421.9,"B",PRCF("PO"),0))
 . I Y="" S X=PRCF("PO"),DIC="^PRCF(421.9,",DLAYGO=421.9,DIC(0)="XL"
 . I Y="" K DO,DINUM,DIC("DR") D FILE^DICN S %=0 K DIC,DLAYGO Q:Y<0
 . L +^PRCF(421.9):5 I '$T W !,"Partial Number File unavailable." Q 
 . S Y(0)=^PRCF(421.9,+Y,0),Y1=$P(Y(0),"^",2)+1
 . S $P(^PRCF(421.9,+Y,0),"^",2)=Y1,PRCF("PA")=Y1
 . L -^PRCF(421.9) K Y(0),Y1,X
 . S $P(^PRCF(421.5,PRCF("CIDA"),1),U,6)=PRCF("PA")
 . Q
 ;
 N XPO S PRCF("PA")="00"_PRCF("PA")
 S PRCF("PA")=$E(PRCF("PA"),$L(PRCF("PA"))-1,$L(PRCF("PA")))
 S XPO=$P(PRCF("PO"),"-",1)_$P(PRCF("PO"),"-",2)_PRCF("PA")
 Q
HEAD W !?15,"IFCAP Partial Number Conversion Table",!!
 Q
 ;
ALPHA(NUM,ALPHA) ; Generate two-character alphanumeric Partial #
 ;     from three-character numeric
 N C,I,P
 I NUM'?1N.N S ALPHA=-1 Q
 I NUM<1!(NUM>974) S ALPHA=-1 Q
 I NUM?1N S ALPHA="0"_NUM Q
 I NUM?2N S ALPHA=NUM Q
 I NUM?3N D
 . S P(1)=NUM-100\35+1,P(2)=NUM-100#35+1
 . F I=1,2 S C(I)=$E("ABCDEFGHIJKLMNPQRSTUVWXYZ0123456789",P(I))
 . S ALPHA=C(1)_C(2) ;W:'(NUM-2#7*10) ! W ?(NUM-2#7*10),NUM,"=",ALPHA
 . Q
 Q
 ;
NUM(ALPHA,NUM) ; Generate IFCAP partial # from FMS partial #.
 S ALPHA=$TR(ALPHA,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ") S NUM=ALPHA
 I ALPHA["O"!(ALPHA=0)!(ALPHA="00") S NUM=-1 Q
 I '(ALPHA?1N!(ALPHA?2UN)) S NUM=-1 Q
 I ALPHA?1N!(ALPHA?2N) S NUM=+ALPHA Q
 F I=1,2 S C(I)=$E(ALPHA,I),P(I)=$F("ABCDEFGHIJKLMNPQRSTUVWXYZ0123456789",C(I))
 I 'P(1)!'P(2) S NUM=-1 Q
 S NUM=98+(P(1)-2*35)+P(2) W !,NUM
 Q
