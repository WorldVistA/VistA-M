SDWLCU4 ;IOFO BAY PINES/JS - EWL FILE 409.3 CLEANUP ;2/4/03
 ;;5.3;scheduling;**280**;AUG 13 1993
 I '$D(^SCTM(404.46,"B","1.2.3.2")) D
         .K DO S DIC(0)="LM",DIC("DR")=".02////1;.03////"_DT,DIC="^SCTM(404.46,",X="1.2.3.2" D FILE^DICN
         I '$D(^SCTM(404.45,"B","SD*5.3*280")) D
         .S ENTRY=$O(^SCTM(404.46,"B","1.2.3.2",0))
         .S DIC("DR")=".02////"_(+ENTRY)_";.03////"_DT_";.04////1",DIC(0)="LM"
         .K DO S X="SD*5.3*280",DIC="^SCTM(404.45," D FILE^DICN
