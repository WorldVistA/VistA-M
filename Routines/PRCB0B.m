PRCB0B ;WISC/PLT-utility recalculate fcp balance ; 12/12/94  8:56 AM
V ;;5.1;IFCAP;**145**;Oct 20, 2000;Build 3
 ;Per VHA Directive 2004-038, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;prca=station #,prcb=fcp #, prcc=running balance fy (2-digit), prcd=quarter #
 ;total committed, obligated, ceiling txn amount
FCP(PRCA,PRCB,PRCC,PRCD) ;EF value: 1^=fcp bal (uncommited), 2^=fiscal bal (unobligated)
 ; 3^=total commited amt, 4^=total obligated amt, 5^=total ceiling amt
 N PRCRI,PRCE,PRCF,PRCG,PRCH,PRCJ,PRCT,PRCACP
 N A,B,C,D
 S PRCC=$P($$YEAR^PRC0C(PRCC),"^",2) F A=1:1:3 S PRCT(A)=""
 S PRCB=$P(PRCB," ")
 S PRCE=$P($$QTRDATE^PRC0D(PRCC,PRCD),"^",7)_"-"_PRCA_"-"_PRCB_"-",PRCH=PRCE_"~"
 F  S PRCE=$O(^PRCS(410,"RB",PRCE)),PRCRI(410)=0 QUIT:PRCE]PRCH!'PRCE  W:'$D(ZTQUEUED) !,PRCE D
 . F  S PRCRI(410)=$O(^PRCS(410,"RB",PRCE,PRCRI(410))) QUIT:'PRCRI(410)  S PRCF=$G(^PRCS(410,PRCRI(410),0)),PRCG=$P(PRCF,"^",2),PRCF=$P(PRCF,"^",4) I PRCG'="CA"  S A=$G(^(4)),B=$G(^(7)) D
 .. S PRCACP=$P($G(^PRCS(410,PRCRI(410),4)),"^",14)
 .. I PRCG="O" S:$P(B,"^",6)]"" PRCT(1)=PRCT(1)+$J($P(A,"^",8),0,2) S:$P(A,"^",10)]"" PRCT(2)=PRCT(2)+$J($P(A,"^",3),0,2) QUIT
 .. I PRCG="C" S PRCT(3)=PRCT(3)+$J($P(A,"^",3),0,2) QUIT
 .. I PRCG="A",PRCF=1 S:$P(B,"^",6)]"" PRCT(1)=PRCT(1)+$J($P(A,"^",8),0,2) S:$P(A,"^",10)]"" PRCT(2)=PRCT(2)+$J($P(A,"^",3),0,2) QUIT
 .. ;txn from option: enter fcp adjustment data or post issue book
 .. I PRCG="A" S PRCT(1)=PRCT(1)+$J($P(A,"^",8),0,2) S:PRCACP'="Y" PRCT(2)=PRCT(2)+$J($P(A,"^",3),0,2) QUIT
 .. QUIT
 S A=PRCT(3)-PRCT(1),B=PRCT(3)-PRCT(2)
 QUIT A_"^"_B_"^"_PRCT(1)_"^"_PRCT(2)_"^"_PRCT(3)
 ;
 ; see fcp comments
PO(PRCA,PRCB,PRCC,PRCD) ;EF value: 1^=fcp bal (uncommited), 2^=betgetary bal (unobligated)
 ; 3^=total commited amt, 4^=total obligated amt, 5^=total ceiling amt
 N PRCRI,PRCE,PRCF,PRCT
 N A,B,C,D
 S PRCB=$P(PRCB," "),PRCC=+$$YEAR^PRC0C(PRCC) F A=1:1:3 S PRCT(A)=""
 S PRCE=$$QTRDATE^PRC0D(PRCC,PRCD)
 S A=$P(PRCE,"^",8)+100,A=$$DATE^PRC0C(A,"H")
 S PRCG=$$QTRDATE^PRC0D(+A,$P(A,"^",2))
 S PRCE=$P(PRCE,"^",7)-1,PRCG=$P(PRCG,"^",7)-1
 F  S PRCE=$O(^PRC(442,"AB",PRCE)) Q:PRCE>PRCG!'PRCE  D
 . S PRCRI(442)=0
 . F  S PRCRI(442)=$O(^PRC(442,"AB",PRCE,PRCRI(442))) QUIT:'PRCRI(442)  S PRCF=$G(^PRC(442,PRCRI(442),0)) I $P(PRCF,"^",12)="",+PRCF=PRCA,+$P(PRCF,"^",3)=+PRCB D:$P($G(^(12)),"^",2)]""&($G(^(7))-45)
 .. S PRCT(1)=PRCT(1)+$P(PRCF,"^",16),PRCT(2)=PRCT(2)+$P(PRCF,"^",16)
 .. QUIT
 . QUIT
 S A=PRCT(3)-PRCT(1),B=PRCT(3)-PRCT(2)
 QUIT A_"^"_B_"^"_PRCT(1)_"^"_PRCT(2)_"^"_PRCT(3)
 ;
 ; see fcp comments
REC(PRCA,PRCB,PRCC,PRCD) ;EF value: 1^=fcp bal (uncommited), 2^=betgetary bal (unobligated)
 ; 3^=total commited amt, 4^=total obligated amt, 5^=total ceiling amt
 N PRCRI,PRCE,PRCF,PRCT
 N A,B,C,D
 S PRCC=$P($$YEAR^PRC0C(PRCC),"^",2) F A=1:1:3 S PRCT(A)=""
 S PRCB=$P(PRCB," "),PRCE=PRCA_"-"_PRCC_"-"_PRCD_"-"_PRCB
 S PRCRI(417)=0
 F  S PRCRI(417)=$O(^PRCS(417,"C",PRCE,PRCRI(417))) QUIT:'PRCRI(417)  S PRCF=$G(^PRCS(417,PRCRI(417),0)) D
 . S A=$P(PRCF,"^",20)
 . N TYPE,OBL,CUTOFF S TYPE=$P(PRCF,"^",17),OBL=$P(PRCF,"^",18),CUTOFF=$P($G(^PRCS(417,PRCRI(417),1)),"^")
 . I CUTOFF'=1 S PRCT(1)=PRCT(1)+A
 . I CUTOFF=1,TYPE'="CC",$E(OBL,4,7)'?4A S PRCT(1)=PRCT(1)+A
 . S PRCT(2)=PRCT(2)+A
 . QUIT
 S A=PRCT(3)-PRCT(1),B=PRCT(3)-PRCT(2)
 QUIT A_"^"_B_"^"_PRCT(1)_"^"_PRCT(2)_"^"_PRCT(3)
 ;
