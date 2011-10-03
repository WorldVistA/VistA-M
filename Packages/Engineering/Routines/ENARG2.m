ENARG2 ;(WCIOFO)/JED,SAB-SKELETON ARCHIVE GLOBAL ;10/12/1999
 ;;7.0;ENGINEERING;**40,50,63**;Aug 17, 1993
 ;EXPECTS ENSH,ENRT,ENFR,ENTO ;CALLED BY ENARG1
 Q
G S (J,Z)=0,ENSTART=$P($H,",",2) W !,"Hold on, this could take awhile" D @ENRT
 W !,"Elapsed time: ",$J($P($H,",",2)-ENSTART/60,6,2)," minutes."
 K ENA,ENSTART,Z Q
 ;;
1 ;  Work orders
 F  S Z=$O(^ENG(6920,Z)) Q:Z'?1N.N  W:'(Z#500) "." D
 . Q:'$D(^ENG(6920,Z,0))  ; missing zero node
 . S Z(1)=$P($P($G(^ENG(6920,Z,5)),U,2),".") ; date complete
 . Q:Z(1)=""!(Z(1)<ENFR)!(Z(1)>ENTO)  ; outside date range
 . I '$G(ENSHOP("ALL")) S Z(2)=$P($G(^ENG(6920,Z,2)),U) Q:Z(2)=""  ; shop
 . I $G(ENSHOP("INC")),'$D(ENSHOP(Z(2))) Q  ; shop not included
 . I $G(ENSHOP("EXC")),$D(ENSHOP(Z(2))) Q  ; shop excluded
 . ; passed all checks - include on list
 . S J=J+1,^ENAR(6919.1,J,0)=Z
 Q
 ;
 ;  FSA (VA Form 2162)
2 F  S Z=$O(^ENG("FSA",Z)) Q:Z'?1N.N  W:'(Z#50) "." I $D(^ENG("FSA",Z,0)) S Z(1)=$P(^(0),U,6) I Z(1)]"",(Z(1)'<ENFR),(Z(1)'>ENTO) S J=J+1,^ENAR(6919.2,J,0)=Z
 ;  INV (Equipment File)
3 S Z=$O(^ENG(6914,Z)) Q:Z'?1N.N
 W:'(Z#200) "."
 I '$D(^ENG(6914,Z,0)) G 3
 S Z(1)=$G(^ENG(6914,Z,3))
 I $P(Z(1),U,11)=""!($P(Z(1),U,11)>ENTO) G 3 ; disp date
 I +$$CHKFA^ENFAUTL(Z) G 3 ; reported to FAP
 I 'ENEQ("J"),$P(Z(1),U,9)="Y"  G 3 ; exclude JCAHO INV
 I 'ENEQ("A"),"^1^A^"[(U_$P($G(^ENG(6914,Z,8)),U,2)_U) G 3 ; excl acct NX
 ;I 'ENEQ("A") S Z(2)=$P($G(^ENG(6914,Z,2)),U,8) I Z(2),"^10^23^70^"[(U_$E($P($G(^ENCSN(6917,Z(2),0)),U),1,2)_U) G 3 ; excl Acct NX (adp, vech, firearm) (commented out by patch EN*7*50)
 S J=J+1,^ENAR(6919.3,J,0)=Z
 G 3
 ;
 ;  PROJECT (not supported)
4 Q
 ;
 ;  CONTROL POINT ACTIVITY (will never be supported)
5 Q
 ;ENARG2
