PRCB1B1 ;WISC/PLT-PRCB1B continue ; 05/01/94  4:09 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;PRCC required data = quarter date
 ;PRC array
TMEN ;rollover for all single year fcp
 N PRCB,PRCD,PRCE,PRCDI,PRCRICB,PRCLOCK
 N A,B,C
 S A=$$DATE^PRC0C("T","E"),A=$P(A,"^",4)_"/"_$P(A,"^",5)_"/"_$P(A,"^",3)
 I $D(ZTQUEUED) D KILL^%ZTLOAD
 D EN^DDIOL("IFCAP Rollover Fund Control Point Balance List     Printed on "_A)
 D EN^DDIOL("    For Budget Fiscal Year: "_$P(PRCC,"^")_"    Quarter: "_$P(PRCC,"^",2))
 S B=3 D ICLOCK^PRC0B("^PRC(420,"_(+PRC("SITE"))_",",.B)
 I 'B D EN^DDIOL("    Fund Control Point file in use, try later!") QUIT
 S PRC("BBFY")=+PRCC
 S PRC("CP")=0,PRCOPT=1
 F  S PRC("CP")=$O(^PRC(420,+PRC("SITE"),1,PRC("CP"))) Q:PRC("CP")>9998!'PRC("CP")  I $P($G(^(PRC("CP"),5)),"^",7)<$P(PRCC,"^",7) S PRCD=$G(^(0)) D:PRCD]""
 . D FCPTRF
 . QUIT
 D DCLOCK^PRC0B("^PRC(420,"_(+PRC("SITE"))_",")
 QUIT
 ;
FCPTRF ; start rollup
 S PRCAPP=$$APP^PRC0C(PRC("SITE"),PRC("FY"),PRC("CP"))
 I PRCOPT=1,$P(PRCAPP,"^",1)["_/_" QUIT
 I PRCOPT=2,$P(PRCAPP,"^",1)'["_/_" QUIT
 Q:$P(PRCD,"^",20)'=1!$P(PRCD,"^",19)!'$P(PRCD,"^",21)
 S PRCB("AMOUNT")=$P($$FCPBAL^PRC0D(PRC("SITE"),PRC("CP"),PRC("FY"),1),"^",PRC("QTR"))
 Q:PRCB("AMOUNT")'>0
 S PRCE=$G(^PRC(420,+PRC("SITE"),1,+$P(PRCD,"^",21),0))
 Q:+PRCD=+PRCE!'PRCE
 S PRCAPP=$$APP^PRC0C(PRC("SITE"),PRC("FY"),+PRCE)
 I PRCOPT=1,$P(PRCAPP,"^",1)["_/_" QUIT
 I PRCOPT=2,$P(PRCAPP,"^",1)'["_/_" QUIT
 S PRCB("FRCP")=$P(PRCD,"^"),PRCB("TOCP")=$P(PRCE,"^")
 D EN^DDIOL("Roll "_$E(PRCB("FRCP"),1,30)_"  to  "_$E(PRCB("TOCP"),1,30)_"   $"_$FN(PRCB("AMOUNT"),"",2))
 S PRCACF=$$ACC^PRC0C(PRC("SITE"),PRCB("FRCP")_"^"_PRC("FY")_"^"_PRC("BBFY"))
 S PRCACT=$$ACC^PRC0C(PRC("SITE"),PRCB("TOCP")_"^"_PRC("FY")_"^"_PRC("BBFY"))
 I $P(PRCACF,"^")-$P(PRCACT,"^") D EN^DDIOL("    Error: must be in the same A/O!") QUIT
 I $P(PRCACF,"^",9)-$P(PRCACT,"^",9) D EN^DDIOL("    Error: must be in the same fund!") QUIT
 I $P(PRCACF,"^",2)'=$P(PRCACT,"^",2),$P(PRCACF,"^",8)="N" D EN^DDIOL("    Error: fund transfer not allowed") QUIT
 S PRCQT="" D A421
 I PRCQT D EN^DDIOL("    Error: Txn number can not be assigned") QUIT
 S PRCDI="420;^PRC(420,;"_(+PRC("SITE"))_"~420.01;^PRC(420,"_(+PRC("SITE"))_",1,;"_PRC("CP")
 D EDIT^PRC0B(.X,PRCDI,"30///^S X="_$P(PRCC,"^",7),"LS")
 QUIT
 ;
A421 ;add record in file 421
 S PRCF("SIFY")=PRC("SITE")_"-"_PRC("FY"),PRCB("QTR")=PRC("QTR")
 S PRCB("TDT")=$P($$DATE^PRC0C("T","E"),"^",7),PRCB("RNR")="NR"
 S PRCB("ANAMT")=""
 D POST^PRCBSTF Q:PRCQT
 QUIT
