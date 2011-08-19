FBAACCB1 ;AISC/GRR-CLERK CLOSE BATCH CONTINUED ; 11/24/10 10:27am
 ;;3.5;FEE BASIS;**55,61,116**;JAN 30, 1995;Build 30
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
PHARM ;ENTRY FOR PHARMACY BATCH CALCULATE TOTAL DOLLARS AND LINE COUNT
 ; HIPAA 5010 - count line items that have 0.00 amount paid
 F A=0:0 S A=$O(^FBAA(162.1,"AE",B,A)) Q:A'>0  F B2=0:0 S B2=$O(^FBAA(162.1,"AE",B,A,B2)) Q:B2'>0  I $D(^FBAA(162.1,A,"RX",B2,0)) S Z(0)=^(0) D MOREP
 G FIN^FBAACCB
MOREP S T=T+$P(Z(0),"^",16),C=C+1 Q
 ;
TRAV ;ENTRY FOR TRAVEL BATCH CALCULATE TOTAL DOLLARS AND LINE COUNT
 ; HIPAA 5010 - count line items that have 0.00 amount paid
 F J=0:0 S J=$O(^FBAAC("AD",B,J)) Q:J'>0  F K=0:0 S K=$O(^FBAAC("AD",B,J,K)) Q:K'>0  I $D(^FBAAC(J,3,K,0)) S Z(0)=^(0) D MORET
 G FIN^FBAACCB
 ;
MORET S T=T+$P(Z(0),"^",3),C=C+1 Q
LISTC S Q="",$P(Q,"=",80)="=",(FBAAOUT,FBLISTC)=0,IOP=$S($D(ION):ION,1:"HOME") D ^%ZIS K IOP
PRTC D HEDC
 F I=0:0 S I=$O(^FBAAI("AC",B,I)) Q:I'>0!(FBAAOUT)  I $D(^FBAAI(I,0)) S Z(0)=^(0) D CMORE
 Q
CMORE N FBADJLR,FBFPPSC,FBFPPSL,FBX,FBY3
 S K=$P(Z(0),"^",3),J=$P(Z(0),"^",4) D ENV^FBAACCB0 S N=$$NAME^FBCHREQ2(J),S=$$SSN^FBAAUTL(J),FBIN=I,FBAC=$P(Z(0),"^",8)+.0001,FBAP=$P(Z(0),"^",9)+.0001,FBVP=$P(Z(0),"^",14),ZS=$P(Z(0),"^",13)
 S FBAC=$P(FBAC,".",1)_"."_$E($P(FBAC,".",2),1,2),FBAP=$P(FBAP,".",1)_"."_$E($P(FBAP,".",2),1,2)
 S FBSC=$P(Z(0),"^",11),FBSC=$S(FBSC="":"",$D(^FBAA(161.27,FBSC,0)):$P(^(0),"^",1),1:""),FBFD=$P(Z(0),"^",6),FBTD=$P(Z(0),"^",7) S FBPDT=FBFD D CDAT S FBFD=FBPDT,FBPDT=FBTD D CDAT S FBTD=FBPDT
 S FBY3=$G(^FBAAI(I,3))
 S FBFPPSC=$P(FBY3,U)
 S FBFPPSL=$P(FBY3,U,2)
 S FBX=$$ADJLRA^FBCHFA(I_",")
 S FBADJLR=$P(FBX,U)
 D FBCKI(I)
 S B(1617)=$S(B="":"",$D(^FBAA(161.7,B,0)):$P(^(0),"^"),1:"")
 S FBIN(1)=$P(Z(0),"^",2)
 D WRITC
 Q
WRITC I $Y+7>IOSL D ASKH^FBAACCB0:$E(IOST,1,2)["C-" Q:FBAAOUT  W @IOF D HEDC
 W !!,$S('$D(ZS):"",ZS="R":"*",1:"")
 W N,?35,S,?60,B(1617)
 W !,?3,V,?45,VID,?58,FBIN,?70,$$DATX^FBAAUTL($E(FBIN(1),1,7))
 I FBFPPSC]"" W !,?4,"FPPS Claim ID: ",FBFPPSC,"   FPPS Line: ",FBFPPSL
 W !,$S($D(QQ):QQ_")",1:""),FBVP,$S(FBCAN]"":"+",1:""),?4,FBFD,?13,FBTD,?22,$J(FBAC,6),?32,$J(FBAP,6),?45,$S(FBADJLR]"":FBADJLR,1:FBSC)
 W:$P(Z(0),"^",24) ?56,"Discharge ",$$ICD^FBCSV1(+$P(Z(0),"^",24),$P(Z(0),"^",6)) W ! ;CSV
 I $D(^FBAAI(I,"DX")) S FBDX=^("DX") F FBK=1:1:5 Q:$P(FBDX,"^",FBK)=""  D WRTDX
 I $D(^FBAAI(I,"PROC")) S FBPROC=^("PROC") W ! F FBL=1:1:5 Q:$P(FBPROC,"^",FBL)=""  D WRTPC
 S A2=FBAP D PMNT^FBAACCB2 K A2
 Q
CDAT S FBPDT=$E(FBPDT,4,5)_"/"_$S($E(FBPDT,6,7)="00":$E(FBPDT,2,3),1:$E(FBPDT,6,7)_"/"_$E(FBPDT,2,3))
 Q
HEDC W "Patient Name",?20,"('*' Reimbursement to Veteran   '+' Cancellation Activity)",!,?13,"('#' Voided Payment)",?60,"Batch Number"
 W !,?3,"Vendor Name",?45,"Vendor ID",?57,"Invoice #",?68,"Dt Inv Rec'd",!,?3,"FR DATE",?14,"TO DATE  CLAIMED   PAID",?41,"ADJ CODE",!,Q,!
 Q
CHNH ; FB*3.5*116
 S (J,FZ("CNT"))=0 F  S J=$O(^FBAAI("AC",B,J)) Q:J'>0  I $D(^FBAAI(J,0)) S Z(0)=^(0) D MORECH D:$P(FZ,U,15)'="Y" INVCNT
 S:$G(FZ("CNT")) $P(FZ,U,10)=FZ("CNT") K FZ("CNT")  ; CNH batch
 G FIN^FBAACCB
 ;
MORECH ; HIPAA 5010 - count line items that have 0.00 amount paid
 S T=T+$P(Z(0),"^",9),C=C+1
 ; FB*3.5*116 - build array of invoices
 ;do not build array for CH batches not exempt from the pricer
 Q:($P(FZ,"^",18)'="Y")&($P(FZ,"^",15)="Y") 
 S FBARY($P(Z(0),"^"))=+$P(Z(0),"^",9)
 Q
 ;
WRTDX W ?4,"Dx: ",$$ICD9^FBCSV1($P(FBDX,"^",FBK),$P($G(Z(0)),"^",6)),"  " Q  ;CSV
WRTPC W ?4,"Proc: ",$$ICD0^FBCSV1($P(FBPROC,"^",FBL),$P($G(Z(0)),"^",6)),"  " Q  ;CSV
MORE ;
 N FBADJLA,FBADJLR,FBFPPSC,FBFPPSL,FBX,TAMT
 S J=$P(Z(0),"^",5),D=$P(Z(0),"^",3),FBAACPT=$P(Z(0),"^",1),N=$S($D(^DPT(J,0)):$P(^(0),"^",1),1:""),S=$S(N]"":$P(^DPT(J,0),"^",9),1:""),FBIN=A,CPTDESC=$P(Z(0),"^",2)
 S Y="",$P(Y,"^",2)=$P(Z(0),"^",4),$P(Y,"^",3)=$P(Z(0),"^",16),$P(Y,"^",12)=0,T=$P(Z(0),"^",8),T=$S(T="":"",$D(^FBAA(161.27,T,0)):^(0),1:""),$P(Y,"^",9)=$P(Z(0),"^",1),ZS=$P(Z(0),"^",20),FBPV=""
 ;
 S FBFPPSC=$P($G(^FBAA(162.1,A,0)),U,13)
 S FBFPPSL=$P($G(^FBAA(162.1,A,"RX",B2,3)),U)
 S FBX=$$ADJLRA^FBRXFA(B2_","_A_",")
 S FBADJLR=$P(FBX,U)
 S FBADJLA=$P(FBX,U,2)
 S TAMT=$FN($P(Z(0),"^",7),"",2)
 ;
 D FBCKP(A,B2)
 S FBIN(1)=$P($G(^FBAA(162.1,+A,0)),"^",2)
 G GO^FBAACCB
INVCNT ;set invoice count for cnh batch
 S FZ("CNT")=FZ("CNT")+1
 Q
FBCKI(FBI) ;set inpatient check variables
 ;fbi=DA
 I '$G(FBI) S (FBCKDT,FBCK,FBCANDT,FBCANR,FBCAN,FBDIS,FBCKINT)="" Q
 S FBCKIN=$G(^FBAAI(FBI,2))
 S U="^",FBCKDT=+FBCKIN,FBCK=$P(FBCKIN,U,4),FBCANDT=$P(FBCKIN,U,5),FBCANR=$P(FBCKIN,U,6),FBCAN=$P(FBCKIN,U,7),FBDIS=$P(FBCKIN,U,8),FBCKINT=$P(FBCKIN,U,9) K FBCKIN
 Q
FBCKP(J,K) ;set pharmacy check variables
 ;j,k required input variables to = da(1) and da respectively (162.1)
 I '$G(J)!('$G(K)) Q
 S FBCKIN=$G(^FBAA(162.1,J,"RX",K,2))
 S U="^",FBCKDT=$P(FBCKIN,U,8),FBCK=$P(FBCKIN,U,10),FBCANDT=$P(FBCKIN,U,11),FBCANR=$P(FBCKIN,U,12),FBCAN=$P(FBCKIN,U,13),FBDIS=$P(FBCKIN,U,14),FBCKINT=$P(FBCKIN,U,15) K FBCKIN
 Q
