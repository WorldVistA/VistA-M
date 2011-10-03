DGPMBSR3 ;ALB/LM - STORE NEW CENSUS NODES; 16 JAN 91
 ;;5.3;Registration;**34**;Aug 13, 1993
 ;
 ;  Storing in the Census File and accumulating data in ^Utility
A D Q
 S FY("B")=$S(+$E(RD,4,5)<10:+$E(RD,1,3)-1,1:$E(RD,1,3)_"0930") ; Place holder for FY
 S W=0 F I=0:0 S W=$O(^DIC(42,W)) Q:'W  D WSET,CMPD,AUTH,OOS,DGR
 ;
Q K I,I1,W,X,X1,X2,Z,Z1,Z2,Z3,%,RB,OSI Q
 ;
WSET F I1="DGAA","DGUA","DGPS","DGIP","DGVN","DGFR","DG6","DGC","DGCN","DGR","DGRN","DGOD","DGAS" S X(I1)=$S($D(^UTILITY(I1,$J,W)):^(W),1:0)
 F I1=5,6,8,12,13,14,15,16,17,18,19,20,21,22,23,24,26,27,28,29 S $P(X("DGC"),"^",I1)=$P(X("DGC"),"^",I1)+$P(X("DGCN"),"^",I1)
 S $P(X("DGC"),"^",7)=$P(X("DGC"),"^",5)+$P(X("DGC"),"^",2) ;  Cum Rem = Cum Disch + Patients Remaining
 S X=$S(REM:X("DGIP"),1:$P(X("DGC"),"^",2)+$P(X("DGCN"),"^",28)-$P(X("DGCN"),"^",24)) ;  Inpatient (BO)  OR  Patients Remaining + Gains-Total [Cum] - Cum Losses
 S $P(X("DGC"),"^",2)=+X ;  Patients Remaining
 S $P(X("DGC"),"^",3)=X+$P(X("DGC"),"^",3)+X("DGOD") ;  Cum Patient Days of Care = previous cum pat days of care + patients remaining + oneday admissions
 Q
 ;
CMPD ; $P(X("DGC"),"^",25) = Cum Monthly Pat Days  (0;25) in file #41.9)
 I +$E(X("DGC"),6,7)=1 S $P(X("DGC"),"^",25)=0 ; initializes monthly pt days of care
 ;          on first of month.
 S $P(X("DGC"),"^",25)=$P(X("DGC"),"^",25)+$P(X("DGC"),"^",2)+X("DGOD") ; monthly days of care cum.
 Q
 ;
AUTH ; -- how many auth beds
 S D0=+W,DGPMOS=RD D AUTH^DGPMDDCF S X("AB")=$S(X=-1:0,1:X)
 K D0,DGPMOS Q
 ;
OOS ; -- Is Ward OOS for Date?
 S D0=+W,DGPMOS=RD D WIN^DGPMDDCF I X=1 S X("OS")=X("AB") G OOSQ
 D BOS^DGPMDDCF S X("OS")=$S(X=-1:0,1:X)
OOSQ K D0,DGPMOS Q
 ;
DGR S $P(X("DGR"),"^",1)=+X("DGFR") ;  Female Patients Remaining
 S X("OB")=X("AB")-X("OS") ; Operating Beds
 S $P(X("DGR"),"^",2)=+X("OB") ;  Operating Beds
 S $P(X("DGR"),"^",3)=+X("DG6") ;  Bed Occ. 65 and Over
 S $P(X("DGR"),"^",4)=+X("DGVN") ;  Bed Occ. Vietnam Era
 S $P(X("DGR"),"^",5)=+X("DGPS") ;  AA<96
 S $P(X("DGR"),"^",6)=+X("DGAA") ;  AA
 S $P(X("DGR"),"^",7)=+X("DGUA") ;  UA
 S $P(X("DGR"),"^",8)=+X("DGAS") ;  ASIH
 S $P(X("DGR"),"^",9)=+X("OS") ;  Beds Out Of Service
 S $P(X("DGR"),"^",10)=+X("AB") ;  Authorized Beds
 S $P(X("DGR"),"^",11)=+X("DGOD") ;  Oneday admission/discharge
DGC S $P(X("DGC"),"^",4)=$P(X("DGC"),"^",4)+X("OB") ;  Cum Bed + Oper Beds
 S $P(X("DGC"),"^",9)=$P(X("DGC"),"^",9)+$P(X("DGR"),"^",5) ;  Cum Pass Days + AA<96
 S $P(X("DGC"),"^",10)=$P(X("DGC"),"^",10)+$P(X("DGR"),"^",6) ;  Cum ABO Days + AA
 S $P(X("DGC"),"^",11)=$P(X("DGC"),"^",11)+$P(X("DGR"),"^",7) ;  Cum UA Days + UA
 ;
CENSUS S:'$D(^DG(41.9,+W,0)) X=^DG(41.9,0),$P(X,"^",3)=+W,$P(X,"^",4)=$P(X,"^",4)+1,^DG(41.9,0)=X,^DG(41.9,"B",+W,+W)=""
 S:'$D(^DG(41.9,+W,"C",0)) ^(0)="^41.91DA^^"
 S:'$D(^DG(41.9,+W,"C",RD,0)) X=^DG(41.9,+W,"C",0),$P(X,"^",3)=RD,$P(X,"^",4)=$P(X,"^",4)+1,^DG(41.9,+W,"C",0)=X
 S ^DG(41.9,+W,"C",RD,0)=X("DGC"),^UTILITY("DGC",$J,+W)=X("DGC")
 S ^DG(41.9,+W,"C",RD,1)=X("DGR"),^UTILITY("DGR",$J,+W)=X("DGR")
 Q
