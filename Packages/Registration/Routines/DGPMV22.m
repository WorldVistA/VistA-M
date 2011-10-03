DGPMV22 ;ALB/MIR - SCHEDULED ADMISSION? ; 23 NOV 90
 ;;5.3;Registration;**40**;Aug 13, 1993
SCHDADM ;is this a scheduled admission...DGPMSA=1 for yes, 0 for no
 ;must be within 7 days of actual scheduled admission entry
 S X1=DGPMY,X2=-7 D C^%DTC S DGPMSD=$P(X,".")-.1
 S X1=DGPMY,X2=7 D C^%DTC S DGPMED=$P(X,".")+.9
 S DGCT=0 F DGI=0:0 S DGI=$O(^DGS(41.1,"B",DFN,DGI)) Q:'DGI  S J=$S($D(^DGS(41.1,DGI,0)):^(0),1:"") I J,($P(J,"^",2)>DGPMSD),($P(J,"^",2)<DGPMED) I '$P(J,"^",13),'$P(J,"^",17) S DGCT=DGCT+1 D WR
 I 'DGCT S DGPMSA=0 G SCHDQ
 ;
ASK W !,"Is this ",$S(DGCT=1:"the",1:"one of the")," scheduled admission",$S(DGCT>1:"s",1:"")," listed above" S %=1 D YN^DICN I %Y["?" W !?5,"Answer yes if this is a scheduled admission, otherwise no." G ASK
 S DGPMSA=$S(%<0:0,1:'(%-1)) I 'DGPMSA G SCHDQ
 I DGCT=1 S DGPMSA=^UTILITY("DGPMSA",$J,1) G SCHDQ
WHICH W !,"Which scheduled admission is it?  " R X:DTIME I '$T S DGPMER="" D SCHDQ K DGPMY Q
 I X["?" W !,"Choose a number 1-",DGCT G WHICH
 W ! I X["^"!'X!(X<1)!(X>DGCT) G ASK
 S DGPMSA=^UTILITY("DGPMSA",$J,X)
SCHDQ K X,X1,X2,DGCT,DGPMED,DGPMSD,^UTILITY("DGPMSA",$J),DGI,J Q
 ;
WR S Y=$P(J,"^",2) X ^DD("DD")
 I DGCT=1 W !!,"Scheduled admissions:"
 W !?2,DGCT,".  ",Y,?25,$S($P(J,"^",10)="W":"WARD: "_$S($D(^DIC(42,+$P(J,"^",8),0)):$P(^(0),"^",1),1:""),$P(J,"^",10)="T":"FACILITY TREATING SPECIALTY: "_$S($D(^DIC(45.7,+$P(J,"^",9),0)):$P(^(0),"^",1),1:""),1:"")
 S ^UTILITY("DGPMSA",$J,DGCT)=DGI
 Q
 ;
 ;
PTF(DFN,DGPMDA,DGPME,DGPMCA) ;ptf check
 ;
 ; prevent editing of a movement if related to admission w/closed PTF
 ;    (either same admission or ASIH-related admission)
 ;
 ;  Input: DFN = ien of patient file
 ;         DGPMDA = ien of patient movement file
 ;         DGPME = error flag if ptf closed out <by reference>
 ;         DGPMCA = ien of admission movement from pt mvmnt file
 ;
 ; Output: DGPME = "" if no error; otherwise error message
 ;
 I $S('+$G(DFN):1,'+$G(DGPMDA):1,'+$G(DGPMCA):1,1:0) Q
 ;
 N MVTYPE,NODE,TRANS,X
 S NODE=$G(^DGPM(DGPMDA,0)),TRANS=$P(NODE,U,2),TYPE=$P(NODE,U,18)
 ;
 ; check PTF of current admission for all movements
 D PTFC($P(NODE,"^",14),.DGPME) I $G(DGPME)]"" G PTFQ
 ;
 ; check related nhcu/dom admission if current admission = TO ASIH
 I TRANS=1 D:$P(NODE,"^",21)  G PTFQ
 . S X=$G(^DGPM($P(NODE,"^",21),0))
 . D PTFC($P(X,"^",14),.DGPME)
 ;
 ; check related ASIH admission if nhcu/dom transfer movement
 I TRANS=2 D  G PTFQ
 . I "^13^14^44^45^"'[("^"_TYPE_"^") Q  ; not ASIH mvt...quit
 . I "^13^44^"[("^"_TYPE_"^") D PTFC($P(NODE,"^",15),.DGPME) Q  ; to asih or resume asih xfr...check hospital PTF & quit
 . S X=$O(^DGPM("APMV",DFN,DGPMCA,(9999999.9999999-+NODE))),X=$O(^DGPM("APMV",DFN,DGPMCA,+X,0)) ; prior mvt ien
 . S X=$G(^DGPM(+X,0)) ; prior mvt node
 . I $P(X,"^",15) D PTFC($P(X,"^",15),.DGPME) ; if prior mvt associated with hospital admission, check hospital ptf
 ;
 ; check related nhcu/dom admission if asih discharge
 I TRANS=3,("^41^46^"[("^"_TYPE_"^")) D
 . S X=$G(^DGPM(+$P(NODE,"^",14),0)),X=$G(^DGPM(+$P(X,"^",21),0)) ; x=associated nhcu/dom transfer node
 . I X]"" D PTFC($P(X,"^",14),.DGPME)
PTFQ Q
 ;
 ;
PTFC(ADMIT,DGPME) ;check if ptf in close out file/ set error flag if true
 ;
 ;  Input:  ADMIT = ien of admission record
 ;          DGPME = ptf closed flag <by reference>
 ; Output:  DGPME = set if ptf closed out
 ;
 Q:'+$G(ADMIT)
 N PTF
 S PTF=$P($G(^DGPM(ADMIT,0)),"^",16)
 I PTF,$D(^DGP(45.84,+PTF)) S DGPME="Associated PTF (#"_PTF_") is not open.  Cannot edit this movement."
 Q
