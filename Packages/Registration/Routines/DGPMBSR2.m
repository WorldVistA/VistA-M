DGPMBSR2 ;ALB/LM - COLLECT REMAINING TOTALS FOR BED STATUS; 16 JAN 91
 ;;5.3;Registration;;Aug 13, 1993
 ;
A I $S('$D(RD):1,'RD:1,1:0) Q
 S VAPRT=$S('$D(VAPRT):0,1:VAPRT),VACN=$S($D(VACN):VACN,1:0),X1=RD,X2=1 D C^%DTC S VATD=9999999.999999-X
 D PR,FR,O65,VN
 ;
Q K CN,D,DB,DGSF,DGVT,DV,M,MW,MW1,MW2,MW2,P,PR,PR1,PRC,PRT,R,T,W,X,X1,X2,XX,XX1,XX2,XX3 D KVAR^VADPT30 Q
 ;
PR ;  Patient's Remaining [Required]
 I REM S DV=+DIV,VAPRC=1,DFN=0 F PR=0:0 S DFN=$O(^DGPM("C",DFN)) Q:'DFN  S VABO=0 D VAR^VADPT30,BOS:VABO
 Q
 ;
FR ;  Females Remaining [Required]
 S (VAPRC,DFN)=0
 F PR=0:0 S DFN=$O(^DPT("ASX","F",DFN)) Q:'DFN  I $O(^DGPM("ATID1",DFN,9999998-RD)) D VAR^VADPT30 D FR1
 Q
FR1 I VAWD S DV=+DIV D DV:'DV
 S:VAWD ^(+VAWD)=$S($D(^UTILITY("DGFR",$J,+VAWD)):^(+VAWD),1:0)+1
 S:VATS ^(+VATS)=$S($D(^UTILITY("DGTF",$J,DV,+VATS)):^(+VATS),1:0)+1
 Q
 ;
O65 ;  Over 65 years old Remaining [Optional]
 Q:'SF
 S DGSF=RD\1-650000,(VAPRC,DB)=0
 F PR=0:0 S DB=$O(^DPT("ADOB",DB)),DFN=0 Q:'DB!(DB>(DT-650000))  F PR1=0:0 S DFN=$O(^DPT("ADOB",DB,DFN)) Q:'DFN  I $O(^DGPM("ATID1",DFN,9999998-RD)) D VAR^VADPT30 D O651
 Q
O651 I VAWD S DV=+DIV D DV:'DV
 S:VAWD ^(+VAWD)=$S($D(^UTILITY("DG6",$J,+VAWD)):^(+VAWD),1:0)+1
 S:VATS ^(+VATS)=$S($D(^UTILITY("DGT6",$J,DV,+VATS)):^(+VATS),1:0)+1
 Q
 ;
VN ;  Vietnam Veteran's Remaining [Optional]
 Q:'VN
 S DGVT=$O(^DIC(21,"D",7,0)) Q:'DGVT
 S (VAPRC,DFN)=0
 F PR=0:0 S DFN=$O(^DPT("APOS",DGVT,DFN)) Q:'DFN  I $O(^DGPM("ATID1",DFN,9999998-RD)) D VAR^VADPT30 D VN1
 Q
 ;
VN1 I VAWD S DV=+DIV D DV:'DV
 S:VAWD ^(+VAWD)=$S($D(^UTILITY("DGVN",$J,+VAWD)):^(+VAWD),1:0)+1
 S:VATS ^(+VATS)=$S($D(^UTILITY("DGTV",$J,DV,+VATS)):^(+VATS),1:0)+1
 Q
 ;
BOS ;  Bed Occupant Status
 S:$D(DGPMBO(VABO)) ^DIBT(+DGPMY,1,VAMV)=""
 Q:VAPRT
 S DV=+DIV D DV:'DV
 S:VAWD X="DG"_$S(VABO=1:"PS",VABO=2:"AA",VABO=3:"UA",1:"IP")
 S:VAWD ^(+VAWD)=$S($D(^UTILITY(X,$J,+VAWD)):^(+VAWD),1:0)+1
 S:VATS X1="DGT"_$S(VABO=1:"O",VABO=2:"A",VABO=3:"U",1:"I")
 S:VATS ^(+VATS)=$S($D(^UTILITY(X1,$J,DV,+VATS)):^(+VATS),1:0)+1
 Q:VABO'=1
 S:VAWD ^(+VAWD)=$S($D(^UTILITY("DGIP",$J,+VAWD)):^(+VAWD),1:0)+1
 S:VATS ^(+VATS)=$S($D(^UTILITY("DGTI",$J,+DV,+VATS)):^(+VATS),1:0)+1
 Q
 ;
DV S DV=$S($D(^DIC(42,+VAWD,0)):+$P(^(0),"^",11),1:0) S:'DV DV=+DIV Q
 ;
UTIL ;  Utility Nodes
 ;  DGAA=Authorized Absence  ;
 ;  DGUA=Unauthorized Absence  ;
 ;  DGPS=Pass  ;
 ;  DGIP=Inpatient (BO)  ;
 ;  DGVN=Vietnam  ;
 ;  DGFR=Female Remaining  ;
 ;  DG6=Over 65  ;
 ;  DGTP=Treating Speciality Pass  ;
 ;  DGTI=Treating Speciality Inpatient  ;
 ;  DGTU=Treating Speciality UA  ;
 ;  DGTA=Treating Speciality AA  ;
 ;  DGTV=Treating Speciality Vietnam  ;
 ;  DGT6=Treating Speciality +65  ;
 ;  DGTF=Treating Speciality Female  ;
