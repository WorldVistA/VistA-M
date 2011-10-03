PRCXTST ;Routine to create "AB" entries for split off 2237s ;8/24/95  08:31
 ;;5.0;IFCAP;**23**;4/21/95
 N N
 S N=0 F  S N=$O(^PRCS(410,N)) Q:'N  I $P($G(^(N,0)),U,4)'=1&('$D(^PRCS(410,N,"IT","AB"))) D
 .S DA(1)=N,DIK="^PRCS(410,"_DA(1)_",""IT"",",DIK(1)=".01^AB"
 .D ENALL^DIK K DA,DIK
 QUIT
