SRORTRN ;BIR/MAM - PRINT RETURNS ; [ 12/16/98  12:12 PM ]
 ;;3.0; Surgery ;**88**;24 Jun 93
 K SRRET,SRURET S (SRRET,SRURET)=0 S SRET=0 F  S SRET=$O(^SRF(SRTN,29,SRET)) Q:'SRET  D TYPE
 W !!,"Number of Returns to O.R. Related to Index Procedure:   "_SRRET S X=0 F  S X=$O(SRRET(X)) Q:'X  W !,?10,"CPT Code: "_SRRET(X)
 W !!,"Number of Returns to O.R. Unrelated to Index Procedure: "_SRURET S X=0 F  S X=$O(SRURET(X)) Q:'X  W !,?10,"CPT Code: "_SRURET(X)
 Q
TYPE ; set arrays to print
 S X=^SRF(SRTN,29,SRET,0),CASE=$P(X,"^"),TYPE=$P(X,"^",3),CPT=$P(^SRF(CASE,"OP"),"^",2) I 'CPT Q
 S CPT=$P($$CPT^ICPTCOD(CPT),"^",2)
 I TYPE="R" S SRRET=SRRET+1,SRRET(SRRET)=CPT Q
 S SRURET=SRURET+1,SRURET(SRURET)=CPT
 Q
