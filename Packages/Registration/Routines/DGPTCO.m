DGPTCO ;ALB/MJK - Census Output Options; 15 APR 90
 ;;5.3;Registration;;Aug 13, 1993
 ;
 D DT^DICRW S X="DGPTCO",DIK="^DOPT("""_X_""","
 G A:$D(^DOPT(X,7))
 S ^DOPT(X,0)="Census Output Options^1N^"
 F I=1:1 S Y=$T(@I) Q:Y=""  S ^DOPT(X,I,0)=$P(Y,";",3,99)
 D IXALL^DIK
 ;
A W !! S DIC="^DOPT(""DGPTCO"",",DIC(0)="IQEAM"
 D ^DIC Q:Y<0  D @+Y G A
 ;
1 ;;Census Status Report
 G ^DGPTCO1
 ;
2 ;;UnReleased Census Records
 Q
 ;
3 ;;Transmitted Census Records
 S Y=2 D RTY^DGPTUTL,^DGPTOTRL
 K DGRTY,DGRTY0 Q
 ;
4 ;;Record Inquiry
 D CEN^DGPTFMO1 K DG1,DGADM,DGCI,DGCN,DGCST,DGPTFMT,DGX Q
 ;
5 ;;Comprehensive Census Report
 Q
 ;
6 ;;Census Productivity Report
 S Y=2 D RTY^DGPTUTL D 2^DGPTFOU
 Q
 ;
7 ;;Listing of Census Records Completed
 S Y=2 D RTY^DGPTUTL D 1^DGPTFOU
 K DGSTAT Q
