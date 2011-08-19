GMRYUT12 ;HIRMFO/YH-ROOM SEARCH AND OTHER UTILITIES ;11/6/96
 ;;4.0;Intake/Output;;Apr 25, 1997
ROOMSEL ;CALLED FROM GMRYRP5 - SELECT ROOMS ON A GIVEN WARD
 W ! W:$G(GMRMSL($G(I(1))))'="" I(1),". ",?6,$G(GMRMSL(I(1))) W:$G(GMRMSL($G(I(2))))'="" ?16,I(2),".  ",$G(GMRMSL(I(2))) W:$G(GMRMSL($G(I(3))))'="" ?33,I(3),".  ",$G(GMRMSL(I(3)))
 W:$G(GMRMSL($G(I(4))))'="" ?49,I(4),".  ",$G(GMRMSL(I(4))) W:$G(GMRMSL($G(I(5))))'="" ?65,I(5),".  ",$G(GMRMSL(I(5)))
 S I(1)=(I(1)+1),I(2)=(I(2)+1),I(3)=(I(3)+1),I(4)=(I(4)+1),I(5)=(I(5)+1)
 Q
SEARCH(DFN) ;SELECT PATIENT
 N GMYX S GMYX=0
 I '$D(^GMR(126,0)) S ^GMR(126,0)="PATIENT I/O FILE^126P^0^0"
 I DFN'>0 D PATDAT^GMRYUT0 Q:DFN'>0 GMYX
 S X=DFN,DIC(0)="Z",DIC="^GMR(126,",D="B" D MIX^DIC1 S:Y>0 GMYX=+Y G:+Y>0 NEXT K DD S (DINUM,X)=DFN,DIC(0)="L",DLAYGO=126 D FILE^DICN S GMYX=$S(+Y>0:+Y,1:0)
NEXT K DIC,D,DLAYGO,DO,DD
 Q GMYX
ADM(GOUT,GDA,GDT) ;SCREEN PATIENT'S ADMISSION STATUS FOR THE INTAKE/OUTPUT DATE/TIME
 ;CHECK FOR ABSENCE & PASS
 N DFN S DFN=GDA,VAIP("D")=GDT D IN5^VADPT,DEM^VADPT K VAIP("D")
 I VADM(6)>0 W !!,$P(VADM(1),"^")_" died on "_$P(VADM(6),"^",2) S GOUT(1)=2 G Q
 I $G(VAIP(10))=0 W !!,VADM(1)_" on "_$P($G(VAIP(4)),"^",2)_"  started on "_$P($G(VAIP(3)),"^",2),! S GOUT(1)=1
Q Q GOUT(1)
CONTNU(OK,MSSG) ;
 S %=2 W !,"Do you want to "_MSSG D YN^DICN
 I %'=1 S OK=1
 Q OK
OSITE ;ENTER OTHER NAME OF IV INFUSION SITE
 W !!,"Please SPECIFY the name of the infusion site",!,?2,"(maximum 30 characters): " S X="" R X:DTIME I '$T!(X["^") S GMROUT=1 Q
 I X=""!(X["?")!($L(X)>30) W !,"Enter the name of this infusion site or ^ to quit",! G OSITE
YN ;
 S X=$$RW^GMRYDIR(X,30),$P(Y(0),"^")=X Q
