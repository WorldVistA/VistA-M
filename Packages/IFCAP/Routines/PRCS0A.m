PRCS0A ;WISC/PLT-UTILITY FOR PRCS-ROUTINE ; 08/08/94  12:09 PM
V ;;5.1;IFCAP;**23**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;PRCA data ^1=station #,^2=fcp #,^3=rb fy (4-digit), ^4=rb qtr
 ;PRCB=amount entered
 ;PRCC=1 if obligated, 2 if committed amount
 ;Z=0 if allowed, 1 if st/fcp swich fail, 2 if rollover fail
OVCOM(PRCA,PRCB,PRCC) ;EF over commit switch and rollover check for commited/obligated amount entered
 N A,B,C,D,E,F,G,H,Z
 I PRCB'>0 QUIT 0
 ; Patch 5.1*23  ; comment out the statement that skip rest of the check
 ;  when dealing with 4th quarter 1358 in new Fiscal year.
 ;  (Overcommit check is not working on prior 4th quarter 1358 only.)
 ;I $P($$DATE^PRC0C($P(^PRC(420,+PRCA,0),"^",9),"I"),"^",1,2)]$P(PRCA,"^",3,4) QUIT 0
 S Z=1 S:$G(PRCC)="" PRCC=2
 S A=$P($$DATE^PRC0C("T","E"),"^",1,2)
 S B=$P(PRCA,"^",3,4) ;S B=$$QTRDATE^PRC0D($P(PRCA,"^",3),$P(PRCA,"^",4)),B=$P(B,"^",1,2)
 S C=$P($G(^PRC(420,+PRCA,0)),"^",2) S:C=4 C=$P($G(^PRC(420,+PRCA,1,+$P(PRCA,"^",2),0)),"^",13)
 S D=$P($G(^PRC(420,+PRCA,0)),"^",8)
 S:D-2 D=$P($G(^PRC(420,+PRCA,1,+$P(PRCA,"^",2),0)),"^",20)
 S E=$$FCPBAL^PRC0D(+PRCA,+$P(PRCA,"^",2),$E(B,3,4),PRCC)
 S F=$P(PRCA,"^",4)
 ;S:PRCB'>$P(E,"^",F)!(C=5)!(B<A) Z=0
 S:PRCB'>$P(E,"^",F)!(C=5) Z=0
 I Z,C=1 S:A=B Z=0 I 1
 E  I Z,C=2 S:B]A Z=0 I 1
 E  I Z,C=3 S:A']B Z=0
 I Z,D=2 D
 . S Z=2,G="" F H=$P(B,"^",2):-1:1 S G=G+$P(E,"^",H)
 . S:PRCB'>G Z=0
 . QUIT
 QUIT Z
 ;
