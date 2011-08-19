PRCS0B ;WISC/PLT-UTILITY FOR PRCS-ROUTINE ; 12/19/94  1:53 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;PRCA data ^1=buyer station #, ^2=seller station #
 ;PRCB data ^1=buyer fcp #, ^2=seller fcp #
 ;PRCC= file 410 ri of buyer's issue book request
 ;PRCD data ^1=buyer's price, ^2=seller's price
IB(PRCA,PRCB,PRCC,PRCD) ;post buyer's issue book request
 N PRC,PRCRI,PRCE,PRCF,PRCG,PRCH,PRCIS
 N A,B,C
 QUIT:$D(^PRCS(410,PRCC,0))#10=0  S PRCE=^(0),PRCRI("410A")=$P($G(^(445)),"^",4)
 S PRCRI(410)=PRCC,A=$P(PRCE,"^"),PRCG=A
 S PRC("SITE")=$P(A,"-"),PRC("FY")=$P(A,"-",2),PRC("QTR")=$P(A,"-",3),PRC("CP")=$P(A,"-",4)
 D ICLOCK^PRC0B("^PRCS(410,"_PRCRI(410)_",")
 S PRCE=$G(^PRCS(410,PRCRI(410),4)),PRCIS=$P($G(^(445)),"^")
 I $P(PRCE,"^",5)="" D EDIT^PRC0B(.X,"410;^PRCS(410,;"_PRCRI(410),"24////"_PRCIS)
 D:$P(PRCE,"^")'=$P(PRCD,"^")
 . D EDIT^PRC0B(.X,"410;^PRCS(410,;"_PRCRI(410),"27////"_$P(PRCD,"^"))
 . QUIT
 D:$P(PRCE,"^",3)'=$P(PRCD,"^")!($P(PRCE,"^",10)="")
 . D EDIT^PRC0B(.X,"410;^PRCS(410,;"_PRCRI(410),"22////"_$P(PRCD,"^"))
 . D ENCODE^PRCSC2(PRCRI(410),DUZ)
 . D ERS410^PRC0G(PRCRI(410)_"^O")
 . QUIT
 I PRCRI("410A"),$D(^PRCS(410,PRCRI("410A"),0))#10=0 S PRCRI("410A")=""
 I 'PRCRI("410A") D  G:'PRCRI("410A") EXIT
 . S PRC("SITE")=$P(^PRC(420,+$P(PRCA,"^",2),0),"^")
 . S PRC("CP")=$P(^PRC(420,+PRC("SITE"),1,+$P(PRCB,"^",2),0)," ")
 . S Z=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_PRC("CP")
 . S X=$P(Z,"-",1,2)_"-"_$P(Z,"-",4)
 . D EN1^PRCSUT3 QUIT:X=""  S PRCH=X
 . S PRC("BBFY")=$$BBFY^PRCSUT(PRC("SITE"),PRC("FY"),PRC("CP"),1)
 . S X=PRCH D EN2^PRCSUT3 QUIT:Y<1
 . S PRCRI("410A")=+Y
 . D EDIT^PRC0B(.X,"410;^PRCS(410,;"_PRCRI("410A"),"1////A;3////5;40////^S X=DUZ;26///^S X=""T"";447////"_PRCC_";28.5///^S X="_PRC("BBFY"))
 . S PRCF="410;^PRCS(410,;"_PRCRI("410A")_";60"
 . S PRCF=PRCF_"~410.05;^PRCS(410,"_PRCRI("410A")_",""CO"","
 . S X="Seller's adjustment for issue book request "_PRCG
 . D ADD^PRC0B1(.X,.Y,PRCF)
 . D EDIT^PRC0B(.X,"410;^PRCS(410,;"_PRCRI(410),"447////"_PRCRI("410A"))
 . QUIT
 D DCLOCK^PRC0B("^PRCS(410,"_PRCRI(410)_",")
 ;edit seller adjustment entry inf file 410
 S PRCRI(410)=PRCRI("410A")
 S PRCE=^PRCS(410,PRCRI(410),0),A=$P(PRCE,"^",1),PRC("BBFY")=$P($G(^(3)),"^",11)
 S PRC("SITE")=$P(A,"-"),PRC("FY")=$P(A,"-",2),PRC("QTR")=$P(A,"-",3),PRC("CP")=$P(A,"-",4)
 D ICLOCK^PRC0B("^PRCS(410,"_PRCRI(410)_",")
 S PRCE=$G(^PRCS(410,PRCRI(410),4))
 I $P(PRCE,"^",5)="" D EDIT^PRC0B(.X,"410;^PRCS(410,;"_PRCRI(410),"23///^S X=""T"";24////"_PRCIS),ERS410^PRC0G(PRCRI(410)_"^O")
 D:$P(PRCE,"^",6)'=$P(PRCD,"^",2)
 . D EDIT^PRC0B(.X,"410;^PRCS(410,;"_PRCRI(410),"25////"_(-$P(PRCD,"^",2)))
 . S $P(^PRCS(410,PRCRI(410),4),"^",8)=$P(PRCD,"^",2)
 D:$P(PRCE,"^",3)'=$P(PRCD,"^",2)
 . D EDIT^PRC0B(.X,"410;^PRCS(410,;"_PRCRI(410),"22////"_(-$P(PRCD,"^",2)))
 D DCLOCK^PRC0B("^PRCS(410,"_PRCRI(410)_",")
EXIT QUIT
 ;
