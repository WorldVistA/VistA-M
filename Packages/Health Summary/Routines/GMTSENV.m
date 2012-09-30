GMTSENV ;SLC/JER - Environment check routine for HS ;11/16/92  15:28
 ;;2.7;Health Summary;;Oct 20, 1995
MAIN ; Controls branching
 I $S('+$G(DUZ):1,$G(DUZ(0))'="@":1,'$D(U):1,1:0) D
 . W !,$C(7),$C(7),$C(7),"Environment is not appropriately initialized...",!
 . W "Please D ^XUP and be sure that DUZ(0)=""@"" before continuing.",!
 . K DIFQ
 Q
