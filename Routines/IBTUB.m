IBTUB ;ALB/AAS - UNBILLED AMOUNTS MENU  ;29-SEP-94
 ;;2.0;INTEGRATED BILLING;**19,123**;21-MAR-94
 ;
% D DT^DICRW S DIK="^DOPT(""IBTUB""," G:$D(^DOPT("IBTUB",6)) A
 S ^DOPT("IBTUB",0)="Unbilled Amounts Menu Options^1N^"
 F I=1:1 S X=$T(@I) Q:X=""  S ^DOPT("IBTUB",I,0)=$P(X,";;",2,99)
 D IXALL^DIK
 ;
A W ! S DIC="^DOPT(""IBTUB"",",DIC(0)="QEAM" D ^DIC G:Y'>0 END D @+Y G A
 G END
 ;
1 ;;Send Test Unbilled Amounts Bulletin
 D TEST^IBTUBUL
 Q
 ;
2 ;;Build Average Bill Amounts
 D ^IBTUBAV
 Q
 ;
3 ;;Generate Unbilled Amounts Report
 D ^IBTUBO
 Q
 ;
4 ;;View Unbilled Amounts
 D ^IBTUBV
 Q
 ;
5 ;;Auto-Generate Unbilled Amounts Report
 D AUTO^IBTUBO
 Q
 ;
6 ;;Auto-Build Average Bill Amounts
 D AUTO^IBTUBAV
 Q
 ;
END Q
