DGPMBSR4 ;ALB/LM - STORE NEW TREATING SPECIALITY NODES; 16 JAN 91
 ;;5.3;Registration;**85**;Aug 13, 1993
 ;
 ;  Storing in the Medical Center Division File, Treating Specialty Census Data
 Q:RD<TSRI  ; Quit if report date is less than TSR Initialization date
 ;
 I TSRI>RD Q  ; If TSR Initialization date is after report date quit
A D Q
 S DV=0 F I=0:0 S DV=$O(^DG(40.8,DV)) Q:'DV  S T=0 F I1=0:0 S T=$O(^DG(40.8,DV,"TS",T)) Q:'T  D TSET
 ;
Q K DV,I2,X Q
 ;
TSET F I2="DGTP","DGTI","DGTU","DGTA","DGTV","DGT6","DGTF","DGS","DGSN","DGS1","DGSN1","DGTOD","DGTAS" S X(I2)=$S($D(^UTILITY(I2,$J,DV,T)):^(T),1:0)
 S:'X("DGS") $P(X("DGS"),U,1)=RD
 F I2=5,6,8,12,13,14,15,16,17,18,19,20,21,22,23,24,26,27,28,29 S $P(X("DGS"),"^",I2)=$P(X("DGS"),"^",I2)+$P(X("DGSN"),"^",I2)
 S $P(X("DGS"),"^",7)=$P(X("DGS"),"^",5)+$P(X("DGS"),"^",2) ;  Patients Remaining [Cum] = Discharge-Total [Cum] + Patients Remaining
 S X=$S(REM:+X("DGTI"),1:$P(X("DGS"),"^",2)+$P(X("DGSN"),"^",28)-$P(X("DGSN"),"^",24)) ;  TS Inpatients  OR  Patients Remaining + Gains-Total [Cum] - Losses-Total [Cum]
 S $P(X("DGS"),"^",2)=+X ;  Patients Remaining
 S $P(X("DGS"),"^",3)=$P(X("DGS"),"^",3)+X ;  Patient Days of Care [Cum]
 S $P(X("DGS"),"^",3)=$P(X("DGS"),"^",3)+X("DGTOD") ;  Cum Patient Days of Care to include oneday admissions
 S $P(X("DGS1"),"^",1)=+X("DGTF") ;  Females Remaining
 S $P(X("DGS1"),"^",3)=+X("DGT6") ;  65 and Over Remaining
 S $P(X("DGS1"),"^",4)=+X("DGTV") ;  Vietnam Era Remaining
 S $P(X("DGS1"),"^",5)=+X("DGTP") ;  Pass Patients Remaining
 S $P(X("DGS1"),"^",6)=+X("DGTA") ;  AA Remaining
 S $P(X("DGS1"),"^",7)=+X("DGTU") ;  UA Remaining
 S $P(X("DGS1"),"^",8)=+X("DGTAS") ;  ASIH Remaining
 S $P(X("DGS1"),"^",11)=$P(X("DGS1"),"^",11)+X("DGTOD") ; One Day Discharges
 S $P(X("DGS"),"^",9)=$P(X("DGS"),"^",9)+$P(X("DGS1"),"^",5) ;  Pass Days [Cum] + AA<96
 S $P(X("DGS"),"^",10)=$P(X("DGS"),"^",10)+$P(X("DGS1"),"^",6) ;  AA Days [Cum] + AA
 S $P(X("DGS"),"^",11)=$P(X("DGS"),"^",11)+$P(X("DGS1"),"^",7) ;  UA Days [Cum] + UA
 S:'$D(^DG(40.8,DV,"TS",0)) ^(0)="^40.806P^^"
 S:'$D(^DG(40.8,DV,"TS",T,0)) X=^DG(40.8,DV,"TS",0),$P(X,"^",3)=T,$P(X,"^",4)=$P(X,"^",4)+1,^DG(40.8,DV,"TS",0)=X,^DG(40.8,DV,"TS","B",T,T)=""
 S:'$D(^DG(40.8,DV,"TS",T,"C",0)) ^(0)="^40.807D^^"
 S:'$D(^DG(40.8,DV,"TS",T,"C",RD,0)) X=^DG(40.8,DV,"TS",T,"C",0),$P(X,"^",3)=RD,$P(X,"^",4)=$P(X,"^",4)+1,^DG(40.8,DV,"TS",T,"C",0)=X
 S ^DG(40.8,DV,"TS",T,"C",RD,0)=X("DGS")
 S ^DG(40.8,DV,"TS",T,"C",RD,1)=X("DGS1")
 Q
