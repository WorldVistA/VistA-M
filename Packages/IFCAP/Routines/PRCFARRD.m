PRCFARRD ;WISC@ALTOONA/CTB-ROUTINE TO DISPLAY FMS RECEIVING REPORT TRANSACTION ;6/23/95  14:44
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D HILO^PRCFQ
LOAD Q:'$D(^TMP("PRCFARR",$J))  N X,X5,X8 S X=$G(^TMP("PRCFARR",$J,1,0))
 I '$D(PRCFPO) N PRCFPO S PRCFPO=$G(PRCFA("PODA"))
 S X5=$G(^TMP("PRCFARR",$J,5,0))
 S C(1)="RR" ; Transaction Type
 S C(2)=$P(X,U,6) ; Transaction Date
 S C(3)=$P(X,U,3)_"-"_$P(X,U,4)_"-"_$P(X,U,5) ; Obligation Number
 S C(4)=$P(X5,U,11) ; Liquidation Code
 N BOC,FMSLN,I,L,LNO I +$G(PRCFPO) D
 . S I=0 F  S I=$O(^PRC(442,PRCFPO,22,"B",I)) Q:I=""  S LNO="" D
 . . S LNO=$O(^PRC(442,PRCFPO,22,"B",I,LNO)) Q:LNO=""
 . . S FMSLN=$P($G(^PRC(442,PRCFPO,22,LNO,0)),U,3)
 . . S FMSLN="000"_FMSLN,L=$L(FMSLN),FMSLN=$E(FMSLN,L-2,L)
 . . S BOC(FMSLN)=I
 . . Q
 . Q
 I $D(BOC(991)),$D(PRCFPO) S BOC(991)=$P($G(^PRC(442,PRCFPO,23)),U,1)
SE S $P(SP," ",20)=""
 W @IOF,!,IOINLOW,$E(SP,1,15),"OBLIGATION NUMBER: ",IOINHI,C(3),IOINLOW,"     PARTIAL #: ",IOINHI W:$D(PRCFA("PARTIAL")) PRCFA("PARTIAL")
 I $D(PO(11)) S XX=$P(PO(11),"^",12) I XX]"" W !!,IOINLOW,$E(SP,1,10),"TOTAL AMOUNT OF RECEIVING REPORT: ",IOINHI,"$",$FN(XX,",",2) K XX
 W !!,IOINLOW,"TRANSACTION TYPE: ",IOINHI,C(1),IOINLOW,$E(SP,1,5),"TRANSACTION DATE: ",IOINHI,C(2),IOINLOW,"      REF #: ",IOINHI,C(3)
 W !,IOINLOW,$E(SP,1,7),"LIQ. CODE: ",IOINHI,$E(C(4)_"    ",1,4),!
 N J,K S J=7,K=8
 F  S J=$O(^TMP("PRCFARR",$J,J)) Q:+J'=J  D  G:K["^" EXIT
 . S X8=$G(^TMP("PRCFARR",$J,J,0)) Q:$P(X8,U)'=8
 . I K+3>IOSL R:$E(IOST,1,2)="C-" !,"   ** More **  Hit <Return> to Continue, Enter '^' to Exit ",K:DTIME Q:K["^"  W @IOF S K=1
 . W !,IOINLOW,"Item #: ",IOINHI,$J($P(X8,U,3),4)
 . W IOINLOW,"   FMS Line #: ",IOINHI,$E($P(X8,U,2)_"   ",1,3)
 . W IOINLOW,"   BOC: ",IOINHI,$G(BOC($P(X8,U,2)))
 . W IOINLOW,"   FMS Amount: ",IOINHI,$J($FN($P(X8,U,10)/100,",",2),14)
 . ;W IOINLOW,"  Liq. Amount: ",IOINHI,$FN($P(X8,U,4)/100,"",2)
 . S K=K+1
 . Q
EXIT K SP W ! I IOST'["C-Q" W IOINLOW K C,IOINLOW,IOINHI
 Q
