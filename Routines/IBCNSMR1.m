IBCNSMR1 ;ALB/AAS - MEDICARE BILLS ; 9-SEP-97
 ;;2.0;INTEGRATED BILLING;**92,103**;21-MAR-94
 ;
% G RPRT^IBCNSMRA
 ;
BULL ; -- send bulletin
 N CNT1,I,J,X,Y,IBSITE,IBT,IBGRP,XMDUZ,XMN,XMTEXT,XMY,XMSUB,XMZ,XCNP
 K ^TMP($J,"IBT")
 ;
 S IBT="^TMP($J,""IBT"")"
 S IBSITE=$P($$SITE^VASITE,"^",2,3)
 S XMSUB="IB MRA ANALYSIS REPORT FOR "_$TR(IBSITE,"^","-")
 S @IBT@(1)="ACTIVITY     := $$MRA-ANALYSIS$$"
 S @IBT@(2)="SITE         := $$"_IBSITE_"$$"
 S @IBT@(3)="SUMMARY DATA := "
 S @IBT@(4)="$$0$$:"_+$G(CNT)_U_+$G(CNT(0))_U_+$G(CNT(1))_U_+$G(CNT(2))_U_+$G(CNT("OP"))_U_+$G(CNT("OP",0))_U_+$G(CNT("OP",1))_U_+$G(CNT("OP",2))_U_+$G(CNT("IN"))_U_+$G(CNT("IN",0))_U_+$G(CNT("IN",1))_U_+$G(CNT("IN",2))
 S @IBT@(5)="$$1$$:"_+$G(CNT("B"))_U_+$G(CNT("B",0))_U_+$G(CNT("B",1))_U_+$G(CNT("B",2))_U_+$G(CNT("D"))_U_+$G(CNT("D",0))_U_+$G(CNT("D",1))_U_+$G(CNT("D",2))_U_+$G(CNT("P"))_U_+$G(CNT("P",0))_U_+$G(CNT("P",1))_U_+$G(CNT("P",2))
 S @IBT@(5)=@IBT@(5)_U_+$G(CNT("N"))_U_+$G(CNT("N",0))_U_+$G(CNT("N",1))_U_+$G(CNT("N",2))
 ;
 S @IBT@(6)="$$2$$:"_+$G(CNT("C"))_U_+$G(CNT("C",0))_U_+$G(CNT("C",1))_U_+$G(CNT("C",2))_U_+$G(CNT("R"))_U_+$G(CNT("R",0))_U_+$G(CNT("R",1))_U_+$G(CNT("R",2))_U_+$G(CNT("W"))_U_+$G(CNT("W",0))_U_+$G(CNT("W",1))_U_+$G(CNT("W",2))
 S @IBT@(6)=@IBT@(6)_U_+$G(CNT("T"))_U_+$G(CNT("T",0))_U_+$G(CNT("T",1))_U_+$G(CNT("T",2))
 ;
 S @IBT@(7)="$$3$$:"_+$G(CNT("X"))_U_+$G(CNT("X",0))_U_+$G(CNT("X",1))_U_+$G(CNT("X",2))_U_+$G(CNT("Z"))_U_+$G(CNT("Z",0))_U_+$G(CNT("Z",1))_U_+$G(CNT("Z",2))_U_+$G(CNT("A"))_U_+$G(CNT("A",0))_U_+$G(CNT("A",1))_U_+$G(CNT("A",2))
 S @IBT@(7)=@IBT@(7)_U_+$G(CNT("F"))_U_+$G(CNT("F",0))_U_+$G(CNT("F",1))_U_+$G(CNT("F",2))
 ;
 S @IBT@(8)="$$4$$:"_+$G(CNT("M"))_U_+$G(CNT("M",0))_U_+$G(CNT("M",1))_U_+$G(CNT("M",2))_U_+$G(CNT("M","OP"))_U_+$G(CNT("M","OP",0))_U_+$G(CNT("M","OP",1))_U_+$G(CNT("M","OP",2))
 S @IBT@(8)=@IBT@(8)_U_+$G(CNT("M","IN"))_U_+$G(CNT("M","IN",0))_U_+$G(CNT("M","IN",1))_U_+$G(CNT("M","IN",2))_U_+$G(CNT("M",4))_U_+$G(CNT("M",5))_U_+$G(CNT("M",6))_U_+$G(CNT("M",7))
 ;
 S @IBT@(9)="INSURANCE COMPANY TOTALS := "
 S IBNM="",CNT1=10
 F  S IBNM=$O(CNT(3,IBNM)) Q:IBNM=""  D
 .S @IBT@(CNT1)="$$"_(CNT1-4)_"$$:"_IBNM_U_+$G(CNT(3,IBNM))_U_+$G(CNT(3,IBNM,0))_U_+$G(CNT(3,IBNM,1))_U_+$G(CNT(3,IBNM,2))
 .S CNT1=CNT1+1
 ;
 S @IBT@(CNT1)="ANNUAL DATA := ",CNT1=CNT1+1
 D SORT
 ;
 D SEND
BULLQ Q
 ;
SEND S XMDUZ="INTEGRATED BILLING PACKAGE" ; ,XMTEXT="IBT("
 S XMTEXT="^TMP($J,""IBT"","
 K XMY S XMN=0
 S XMY(DUZ)=""
 S XMY("G.IB-MRA-SERVER@ISC-ALBANY.VA.GOV")=""
 D ^XMD
 K X,Y,IBI,IBT,IBGRP,XMDUZ,XMTEXT,XMY,XMSUB
 K ^TMP($J,"IBT")
 Q
 ;
SORT ; -- Run through list by insurance company
 N I,J,K,L,M,N,P,X,Y,Z,ZZ
 S I=0
 F  S I=$O(^TMP("IB-MRA-CNT",$J,I)) Q:I=""!(IBQUIT)  D  ;insur. co
 .S J=0
 .F  S J=$O(^TMP("IB-MRA-CNT",$J,I,J)) Q:J=""!(IBQUIT)  D  ;year
 ..S K=""
 ..F  S K=$O(^TMP("IB-MRA-CNT",$J,I,J,K)) Q:K=""!(IBQUIT)  D  ;bill type
 ...S L=0
 ...F  S L=$O(^TMP("IB-MRA-CNT",$J,I,J,K,L)) Q:L=""!(IBQUIT)  D  ;proc
 ....S M=0
 ....F  S M=$O(^TMP("IB-MRA-CNT",$J,I,J,K,L,M)) Q:M=""!(IBQUIT)  D  ;ar status
 .....S N=0
 .....F  S N=$O(^TMP("IB-MRA-CNT",$J,I,J,K,L,M,N)) Q:N=""!(IBQUIT)  S X=+$G(^(N)),Y=+$G(^(N,0)),Z=+$G(^(1)),ZZ=+$G(^(2)) D LINE ;ibstatus
 ;......;S P=0 ;alive
 ;......;F  S P=$O(^TMP("IB-MRA-CNT",$J,I,J,K,L,M,N,P)) Q:P=""!(IBQUIT)  S X=+$G(^(P)),Y=+$G(^(P,0)),Z=+$G(^(1)),ZZ=+$G(^(2)) D LINE
 Q
 ;
LINE ;
 S IBNM=$P($G(^DIC(36,I,0),"UNKNOWN"),"^")
 S @IBT@(CNT1)="$$"_(CNT1-4)_"$$:"_IBNM_U_J_U_K_U_$P(M,"^",2)_U_N_U_X_U_Y_U_Z_U_ZZ
 S CNT1=CNT1+1
 Q
