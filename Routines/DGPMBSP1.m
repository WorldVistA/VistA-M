DGPMBSP1 ;ALB/LM - BSR PRINT, CONT.; 17 OCT 90
 ;;5.3;Registration;**96,170**;Aug 13, 1993
 ;
A D DATE
 S (AT,PL,W)=0
 ;  GL (Ward) Order
 F W1=0:0 S W=$O(^DIC(42,W)) Q:W'>0  I $D(^DIC(42,W,0)) S BD("W")=^(0),ORDER=$S($D(^DIC(42,W,"ORDER")):+^("ORDER"),1:0) D:+ORDER WARD,TOTAL,^DGPMBSP2
 K TC,TL,TB,C,I,W1,W2,OOS,T,T1,W,X1,X2,FY("B"),FY("L"),ORDER,BD,X,FY("M")
Q Q
 ;
DATE N XX K ^UTILITY("DGWOR",$J),^UTILITY("DGWON",$J),^UTILITY("DGWOS",$J),^UTILITY("DGWTOR",$J),^UTILITY("DGWNN",$J)
 S FY("B")=$S(+$E(RD,4,5)<10:+$E(RD,1,3)-1,1:$E(RD,1,3))_"0930" ; Place holder for FY
 S X1=RD,X2=FY("B") D ^%DTC
 S FY("D")=+X ;  Total Elapsed Fiscal Days
 S XX=1700+$E(RD,1,3),X=365 S:((XX#4=0)&(XX#100'=0))!((XX#100=0)&(XX#400=0)) X=366 S XX=X ;  Number of days in (report date) year
 S BD("M")=12/X ;  Turnover rate multiplier
 S FY("L")=$S(RD'["0229":RD-10000,1:$E(RD,1,3)-1_"0228") ;  Last year
 S FY("Y")=$E(FY("B"),1,3)+1,FY("Y")=$E(FY("Y"),2,3) ;  Fiscal Year - used in Cum Totals section
 S X=$S($E(RD,4,5)'="01":$E(RD,4,5)-1,1:12) ;  Month prior
 S X1=$S(X'=12:$E(RD,1,3),1:$E(RD,1,3)-1) ;  Year of month prior
 S X2=$P("31^28^31^30^31^30^31^31^30^31^30^31","^",X) ;  Number of days in month prior
 I X2=28,XX=366 S X2=29 ;  if leap year
 S FY("EOM")=X1_$S(X?2N:X,1:"0"_X)_X2 ;  YY_MM_DD format of last day for prior month
 S X1=RD
 S X2=FY("EOM")
 D ^%DTC
 S FY("DIM")=X ;  Total Elapsed Month Days
 Q
 ;
WARD S BD("CB")=$S($D(^DG(41.9,+W,"C",RD,0)):+$P(^(0),"^",4),1:0) ;  Cum Beds
 S (BD("S"),BD("D"))=1
 S BD("N")=$S($P(BD("W"),"^")]"":$E($P(BD("W"),"^"),1,7),1:"UNKNOWN")_"^"_$P(BD("W"),"^",2)_"^" ;  Name of ward_^_Bed Section
 S BD("PL")=$S($P(BD("W"),"^",15)]"":$P(BD("W"),"^",15),1:"UNKNOWN") ; Primary Location
 S BD("DV")=+$P(BD("W"),"^",11) ;  Division
 S BD("ADC")=$S($P(BD("W"),"^",3)="NH":2,$P(BD("W"),"^",3)="D":3,1:1) ;  Service Type
 S:'$D(ADC(BD("DV"),BD("ADC"))) ADC(BD("DV"),BD("ADC"))=0,AT=AT+1
 I '$D(^UTILITY("DGWPL",$J,BD("PL"))) S ^(BD("PL"))=0,^UTILITY("DGWPLT",$J,BD("PL"))=0,PL=PL+1
 ;
 S (BD("OSD"),BD("OS"))=0 ; OSD=total OOS Days on ward, OS=total OOS beds on ward
 ; From the beginning of the FY to RD, if there is data in the Bed OOS field of the Census file count the # of days OOS and count the # of beds OOS
 F %=FY("B"):0 S %=$O(^DG(41.9,+W,"C",%)) Q:'%!(%>RD)  I $D(^DG(41.9,+W,"C",%,1)) S X=^(1) D:$P(X,U,9)=$P(X,U,10)  S BD("OS")=BD("OS")+$P(X,"^",9)
 .; Check OOS status
 .N OOS1,OOS2,OOS3,OOS4
 .S OOS4=%
 .S OOS1=$O(^DIC(42,+W,"OOS","B",OOS4+1),-1) Q:'OOS1  S OOS2=$O(^(OOS1,0)),OOS3=$P(^DIC(42,+W,"OOS",OOS2,0),U,4)
 .I OOS3,OOS3<OOS4 Q  ;if return-to-service date < date being calculated, Q
 .S BD("OSD")=BD("OSD")+1
 ;  if OOS date not greater than Report Date & Include Stats
 I $O(^DIC(42,+W,"OOS","AINV",0))>0 F %=0:0 S %=$O(^DIC(42,+W,"OOS","AINV",%)) Q:'%  S I=$O(^DIC(42,+W,"OOS","AINV",%,0)) I I,$D(^DIC(42,+W,"OOS",I,0)) S OOS=^(0) I +OOS'>RD,BD("S") D OOS
 Q
 ;
OOS Q
 I +OOS'>FY("B"),'$P(OOS,"^",4) S BD("S")=0 Q  ; if OOS date is not greater than beginning of FY and there is no return to service date ;  4th=Return to Service Date ; Bed out last FY and is still out
 S:'$P(OOS,"^",8) BD("D")=0 ;  8th=Show on Bed Status Report
 I 'BD("D"),'$P(OOS,"^",9) S BD("S")=0 ;  9th=Include stat's on Bed Status
 I $S('$P(OOS,"^",7):1,$P(OOS,"^",5)>RD:1,1:0) Q  ;  7th=Display OOS on GL  5th=OOS Display End Date
 S ^UTILITY("DGWOS",$J,+W)=$P(^DIC(42,+W,0),"^")_" - "_$S($D(^DG(405.4,+$P(OOS,"^",2),0)):$P(^(0),"^"),1:"NO REASON DESIGNATED")_$S($P(OOS,"^",3)]"":(", "_$P(OOS,"^",3)),1:"")_"." ;  2th=Reason  ; 3rd=Comment
 Q
 ;
TOTAL ;  Total Levels
 S X=$O(^DIC(42,+W,1,0)) Q:'X
 S T=0
 F T1=0:0 S T=$O(^DIC(42,+W,1,T)) Q:T'>0  I $D(^DIC(42,+W,1,T,0)) S X=^(0),^UTILITY("DGWTOR",$J,ORDER,T)=$P(X,"^")_"^"_+$P(X,"^",4) ; 1=Totals Name  4=Print in Cumulative Totals
 K X,T,T1
 Q
