FBNHEP1 ;AISC/GRR-PAYMENT PROCESS CONTINUED ;7/8/2003
 ;;3.5;FEE BASIS;**12,61**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 N FBADJ,FBRRMK,FBX,FBFPPSC,FBFPPSL
 K FBAAID,FBAAVID D GETNXI^FBAAUTL W !!,"Invoice # ",FBAAIN," assigned to this invoice"
 S DIC="^FBAAI(",X=FBAAIN,DIC(0)="L",DLAYGO=162.5 D ^DIC S DA=+Y K DLAYGO
RID D GETINDT^FBAACO1 G DEL:$G(FBAAOUT)
 S DIE=DIC,FBNL=""
 S FBI7078=FB7078_";FB7078("
 S DR="1////^S X=FBAAID;46////^S X=FBAAVID;47////^S X=1;2////^S X=IFN;3////^S X=DFN;20////^S X=FBBAT;55"
 S DR(1,162.5,1)="S FBFPPSC=$$FPPSC^FBUTL5();S:FBFPPSC=-1 Y=0;S:FBFPPSC="""" Y=""@20"";56///^S X=FBFPPSC;S FBFPPSL=$$FPPSL^FBUTL5(,1);S:FBFPPSL=-1 Y=0;57///^S X=FBFPPSL;@20;54//^S X=$G(FBTRDYS)"
 S DR(1,162.5,2)="7;S FBNHAC=X;5////^S X=$S(FBPAYDT>FBAABDT:(FBPAYDT+1),1:FBAABDT);6////^S X=FBENDDT;8//^S X=$S(FBNHAC>FBDEFP:FBDEFP,1:FBNHAC);S FBAMTP=X"
 S DR(1,162.5,3)="S FBX=$$ADJ^FBUTL2(FBNHAC-FBAMTP,.FBADJ,1);S:FBX=0 Y=0"
 S DR(1,162.5,4)="S FBX=$$RR^FBUTL4(.FBRRMK,2);S:FBX=0 Y=0"
 S DR(1,162.5,5)="11////^S X=7;12////^S X=FBAAPTC;23////^S X=FBPSA;4////^S X=FBI7078;21////^S X=FBPOV;22////^S X=FBPT;S FBTST=1"
 D ^DIE I '$G(FBTST) W !,*7,"Entering an '^' will delete this payment" S DIR(0)="Y",DIR("A")="Shall I delete",DIR("B")="No" D ^DIR G DEL:$D(DIRUT)!(Y),RID
 ; file adjustment reasons
 D FILEADJ^FBCHFA(DA_",",.FBADJ)
 ; file remittance remarks
 D FILERR^FBCHFR(DA_",",.FBRRMK)
 K FBTST G GETVET^FBNHEP
DEL S DIK="^FBAAI(" W !!,"Deleting Invoice !" D ^DIK K DIK G GETVET^FBNHEP
 Q
PROB W !,*7,"The patient was not in this vendor's facility for the month and year selected!",!,"Use the Display Episode of Care option to review this veteran's activity!" S FBERR=1
 Q
 ;
TRUB W !!,*7,"Check Contract data for Community Nursing Home: ",$P(^FBAAV(IFN,0),"^",1),!,"It is not complete",!! S FBERR=1 Q
 ;
DAYS(X) ;CALCULATES THE NUMBER OF DAYS IN MONTH
 N X1
 S X1=X,X=+$E(X,4,5),X=$S("^1^3^5^7^8^10^12^"[("^"_X_"^"):31,X=2:28,1:30)
 I X=28 D
 . N YEAR
 . S YEAR=$E(X1,1,3)+1700
 . I $S(YEAR#400=0:1,YEAR#4=0&'(YEAR#100=0):1,1:0) S X=29
 Q X
