DGPMBSR1 ;ALB/LM - BED STATUS REPORT RECALCULATION CONT.; 16 JAN 91
 ;;5.3;Registration;**85**;Aug 13, 1993
 ;
A S DIE="^DG(43,",DA=1,DR="53///"_RD D ^DIE K DA,DIE,DR ;  Date when recalc up to
 S W=0 F I=0:0 S W=$O(^DIC(42,W)) Q:'W  D SET
 S D=0 F I=0:0 S D=$O(^DG(40.8,D)) Q:'D  S ^UTILITY("DGD",$J,D)=$S($D(^DG(40.8,D,"CEN",PD,0)):$P(^(0),"^",12),1:0),^UTILITY("DGDN",$J,D)="" S T=0 F I1=0:0 S T=$O(^DG(40.8,D,"TS",T)) Q:'T  D TSET
 K I,I1,T,W,D
 D ^DGPMGLG
 Q
 ;
SET S X=$S($D(^DG(41.9,W,"C",PD,0)):^(0),1:""),X=RD_"^"_$P(X,"^",2,99)
 S:$E(PD,4,7)="0930" X=$P(X,"^",1,2) ;  New fiscal year
 S ^UTILITY("DGC",$J,W)=X ;  Census
 S ^UTILITY("DGCN",$J,W)="" ;  New census
 S ^UTILITY("DGOD",$J,+W)=0 ; One Day Admissions
 S X1=$S($D(^DG(41.9,W,"C",PD,1)):$P(^(1),"^",1,10),1:"")
 S ^UTILITY("DGR",$J,W)=X1 ;  Remaining
 S ^UTILITY("DGRN",$J,W)="" ;  New remaining (one node)
 S ^UTILITY("DGFR",$J,+W)=0 ;  Female Patients Remaining
 S ^UTILITY("DG6",$J,+W)=0 ;  Bed Occupants 65 & Over
 S ^UTILITY("DGVN",$J,+W)=0 ;  Bed Occupants VN
 S ^UTILITY("DGPS",$J,+W)=$S('REM:+$P(X1,"^",5),1:0) ;  Pass
 S ^UTILITY("DGAA",$J,+W)=$S('REM:+$P(X1,"^",6),1:0) ;  Auth absense
 S ^UTILITY("DGUA",$J,+W)=$S('REM:+$P(X1,"^",7),1:0) ;  Unauth absense
 S:'REM ^UTILITY("DGAS",$J,+W)=+$P(X1,"^",8) ;  ASIH
 S:REM ^UTILITY("DGIP",$J,+W)=0 ; if count pt. remaining
CEN S ^DG(41.9,W,"C",RD,0)=RD_"^"_$P(^UTILITY("DGC",$J,W),"^",2,99)
 S:'$D(^DG(41.9,W,0))#2 ^(0)=W,^DG(41.9,"B",W,W)="",$P(^(0),"^",4)=$P(^DG(41.9,0),"^",4)+1,$P(^(0),"^",3)=RD
 S:'$D(^DG(41.9,W,"C",0))#2 ^(0)="^41.91DA^^"
 Q
 ;
TSET I TSRI>RD Q  ; If TSR Initialization date is greater than report date quit
 S X=$S($D(^DG(40.8,D,"TS",T,"C",PD,0)):^(0),1:""),X=RD_"^"_$P(X,"^",2,99)
 I RD=TSRI,$P(X,U,2)']"" S X=RD_"^"_$P(^DG(40.8,D,"TS",T,0),"^",3)
 S:$E(PD,4,7)="0930" X=$P(X,"^",1,2)
 S ^UTILITY("DGS",$J,+D,+T)=X ;  Treating Specialty census
 S ^UTILITY("DGSN",$J,+D,+T)="" ;  Treating Specialty new census
 S ^UTILITY("DGTOD",$J,+D,+T)=0 ; One Day Admissions
 S X1=$S($D(^DG(40.8,D,"TS",T,"C",PD,1)):$P(^(1),"^",1,10),1:"")
 S ^UTILITY("DGS1",$J,+D,+T)=X1 ;  Treating Specialty remaining
 S ^UTILITY("DGSN1",$J,+D,+T)="" ;  Treating Specialty new remaining (one node)
 S ^UTILITY("DGTF",$J,+D,+T)=0 ;  Female Patients Remaining
 S ^UTILITY("DGT6",$J,+D,+T)=0 ;  Bed Occupants 65 & Over
 S ^UTILITY("DGTV",$J,+D,+T)=0 ;  Bed Occupants VN
 S ^UTILITY("DGTP",$J,+D,+T)=$S('REM:+$P(X1,"^",5),1:0) ;  Treating Specialty Pass
 S ^UTILITY("DGTA",$J,+D,+T)=$S('REM:+$P(X1,"^",6),1:0) ;  Treating Specialty Auth absense
 S ^UTILITY("DGTU",$J,+D,+T)=$S('REM:+$P(X1,"^",7),1:0) ;  Treating Specialty Unauth absense
 S:'REM ^UTILITY("DGTAS",$J,+D,+T)=+$P(X1,"^",8) ;  Treating Specialty ASIH
 S:REM ^UTILITY("DGTI",$J,+D,+T)=0 ; if count pt. remaining
TCEN S ^DG(40.8,D,"TS",T,"C",RD,0)=RD_"^"_$P(^UTILITY("DGS",$J,D,T),"^",2,99),^DG(40.8,D,"TS",T,"C","B",RD,RD)=""
 S:'$D(^DG(40.8,D,"TS",T,0))#2 ^(0)=T,^DG(40.8,D,"TS","B",T,T)=""
 S:'$D(^DG(40.8,D,"TS",T,"C",0))#2 ^(0)="^40.807D^^",^DG(40.8,D,"TS",T,"C","B",T,T)=""
 Q
 ;
UTIL ;  Utility Nodes
 ;  DGD=Monthly Planned Dom. (yesterday)  ;
 ;  DGDN=Monthly Planned Dom. (new)  ;
 ;  DGC=Zero Node Census file (yesterday)  ;
 ;  DGCN=Zero Node Census file (new)  ;
 ;  DGR=One Node Census file (yesterday)  ;
 ;  DGRN=One Node Census file (new)  ;
 ;  DGS=Treating Specialty (yesterday)  ;
 ;  DGSN=Treating Specialty (new)  ;
 ;  DGS1=Treating Specialty One Node (yesterday)  ;
 ;  DGSN1=Treating Specialty One Node (new)  ;
 ;
VAR ;  RC=ReCalc from date  ;  YD=YesterDay  ;  RD=Report Date  ;
 ;  BS=Bed Status  ;  GL=G&L  ;  REM=Recalc patient days  ;
 ;  PD=Previous Day  ;  W=Ward  ;  D=Division  ;  T=Treating Specialty
