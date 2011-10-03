PRCHDR ;WISC/RHD-DISPLAY REQUEST ;2/12/98  2:43 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN ; DISPLAY 2237
 S PRCH0=$G(^PRCS(410,D0,0))
 S PRCHTC=$P(PRCH0,"^",2),PRCHTP="" I PRCHTC'="" S X=$P(^DD(410,1,0),U,3) F I=1:1 S Y=$P(X,";",I) Q:Y=""  I $P(Y,":",1)=PRCHTC S PRCHTP=$P(Y,":",2) Q
 W !,"Transaction Number: ",$P(PRCH0,U,1),?41,"Transaction Type: ",PRCHTP K ^UTILITY($J,"W")
 I $O(^PRCS(410,D0,"RM",0)) S DIWL=3,DIWR=75,DIWF="" F PRCHI=0:0 S PRCHI=$O(^PRCS(410,D0,"RM",PRCHI)) Q:'PRCHI  S X=^(PRCHI,0) D DIWP^PRCUTL($G(DA))
 I $D(^UTILITY($J,"W",3)) F I=0:0 S I=$O(^UTILITY($J,"W",3,I)) Q:'I  W !?3,^(I,0)
 G:PRCHTC="CA" Q
O S X="" D STATUS^PRCSES W !,"Supply Status: ",X G:'$D(^PRC(443,D0,0)) W1 S PRCHR0=^(0)
 W !,"Accountable Officer: " S X=$P(PRCHR0,U,2) D US W ?45,"Date: " S Y=$P(PRCHR0,U,4) D DT
 W !,"Purchasing Agent: " S X=$P(PRCHR0,U,5) D US W ?45,"Date: " S Y=$P(PRCHR0,U,6) D DT
 I $P($G(^PRCS(410,D0,0)),"^",2)["O",$D(^PRCS(410,D0,"CO",0)) W !,"Comments: " N COM S COM=0 F  S COM=$O(^PRCS(410,D0,"CO",COM)) Q:'COM  W !,$G(^(COM,0))
W1 W ! S %A="Would you like to print this request now",%B="",%=2 D ^PRCFYN I %=1 S DA=D0,PRCSF=1,ZTDESC="QUE^PRCSP12" D PRF1^PRCSP1 K X,PRCSF
Q K A,B,C,DA,PRCHI,PRCH0,PRCHTC,PRCHTP,Y,^UTILITY($J,"W")
 Q
US ;S X=$S($D(^VA(200,+X,0)):$P(^(0),U,1),1:"") W $P(X,",",2)," ",$P(X,",",1) Q
 S X=$P($G(^VA(200,+X,0)),U,1) W $P(X,",",2)," ",$P(X,",",1)
 Q
DT W:Y Y\100#100,"/",Y#100\1,"/",Y\10000+1700
 Q
