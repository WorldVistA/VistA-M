DGPTOOL ;ALB/MJK - PTF Tools; 15 APR 90
 ;;5.3;Registration;;Aug 13, 1993
EN ;
 D DT^DICRW S X="DGPTOOL",DIK="^DOPT("""_X_""","
 G A:$D(^DOPT(X,10))
 S ^DOPT(X,0)="Special PTF Tool^1N^"
 F I=1:1 S Y=$T(@I) Q:Y=""  S ^DOPT(X,I,0)=$P(Y,";",3,99)
 D IXALL^DIK
 ;
A W !! S DIC="^DOPT(""DGPTOOL"",",DIC(0)="IQEAM"
 D ^DIC Q:Y<0  D @+Y G A
 ;
1 ;;099 Transmission
 D ^DGPTF099
 Q
 ;
2 ;;Free-Form 099
 D ^DGPTF09X
 Q
 ;
3 ;;RPO Request
 D ^DGPTRPO
 Q
 ;
4 ;;Special Transaction Print
 D PRN^DGPTRPP
 Q
 ;
5 ;;Special Transaction Purge
 D PUR^DGPTRPP
 Q
 ;
6 ;;PTF Validation
 D EN^DGPTFVC
 Q
 ;
7 ;;PTF Expanded Category Listing
 D EN^DGPTEXPR
 Q
 ;
