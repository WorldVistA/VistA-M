LRAPF ;DALOI/STAFF - CY/EM/SP RPT ;11/14/11  13:04
 ;;5.2;LAB SERVICE;**173,201,248,259,350**;Sep 27, 1994;Build 230
 ;
 ; 23-MAR-01;WTY;Trimmed down DX in line tag F per SAM-0301-22193
 ;
 ; From LRSPRPT,LRSPRPT1, LRSPRPT2, LRSPRPTM
 I $D(LR("F")),IOST?1"C".E D  Q:LR("Q")
 . K DIR S DIR(0)="E"
 . D ^DIR W !
 . S:$D(DTOUT)!(X[U) LR("Q")=1
 ;
 W:($D(LR("F"))) @IOF
 S LRQ=LRQ+1
 ;
 ; Print printing and reporting facility
 I LRQ=1,$$GET^XPAR("DIV^PKG","LR REPORTS FACILITY PRINT",1,"Q")>1 D
 . N A
 . D PFAC^LRRP1(DUZ(2),0,1,.A)
 . S A=0
 . F  S A=$O(A(A)) Q:'A  W !,A(A)
 ;
 I LRQ=1,$$GET^XPAR("DIV^PKG","LR REPORTS FACILITY PRINT",1,"Q")#2 D
 . N B,LRX
 . S LRX=+$G(^LR(LRDFN,LRSS,LRI,"RF"))
 . I LRX<1 Q
 . D RL^LRRP1(LRX,1,.B)
 . W ! S B=0
 . F  S B=$O(B(B)) Q:'B  W !,B(B)
 ;
 D W
 W !?5,"MEDICAL RECORD |",?40,LRAA(1),?73,"Pg ",LRQ
 D:LRQ>1 P
 D W
 Q
 ;
 ;
F ; from LRSPRPT,LRSPRPT1, LRSPRPT2, LRSPRPTM
 Q:LR("Q")
 I IOSL'>66 F  Q:$Y>(IOSL-11)  W !
 D W W !,$S('$D(LR("W")):"",1:"See signed copy in chart")
 W ?57,"(",$S($D(LRO):"End of report",1:"See next page"),")"
 W !,$G(LRPMD),?52,LRW(9),?55,"| Date ",$G(LRRC)
 D W
 W !,LRP,?50,$S('$D(LR("W")):"STANDARD FORM 515",1:"WORK COPY ONLY !!")
 W !,"ID:",SSN,?16,"SEX:",SEX," DOB:",DOB
 I AGE W $S($G(VADM(6))'="":" AGE AT DEATH: ",1:" AGE: "),AGE
 W " LOC:",$E(LRLLOC,1,20)
 W ! W:LRADM'="" "ADM:",$P(LRADM,"@")
 W:LRADX'="" ?17,"DX:",$E(LRADX,1,26)
 W ?46,"PCP: "
 W:LRPRAC ?51,$E(LRPRAC(1),1,28)
 Q
 ;
 ;
P ;
 ; Handle printing footer after printing prior cases on end of report and LRI now null.
 I $G(LRI)<1 N LRI S LRI=+$P($G(LRAP),"^",2)
 ;
 D:LRQ>1 W
 ;
 S ADESC="Accession No. "_$S(LRQ(8)]"":LRQ(8)_LRW(1)_" "_LRAC,1:LRAC)
 S LENG1=$L(LRQ(1)),LENG2=$L(ADESC),LNSPCE=IOM-LENG2-14
 S:LENG1>LNSPCE LRQ(1)=$E(LRQ(1),1,LNSPCE)
 ;
 W !?30,"PATHOLOGY REPORT",!
 ;
 I '$G(^LR(LRDFN,LRSS,+LRI,"RF")) W "Laboratory: ",LRQ(1)
 W ?(IOM-LENG2-1),ADESC
 ;
 K ADESC,LENG1,LENG2,LNSPCE
 Q
 ;
 ;
W ;
 W !,LR("%")
 Q
