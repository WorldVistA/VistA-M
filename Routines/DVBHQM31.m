DVBHQM31 ;ISC-ALBANY/JLU-creates second column HINQ data ;9/28/88@0800
 ;;4.0;HINQ;**49**;03/25/92 
 ;
ADD G:'$D(DVBP(6)) P1
 I $P(DVBP(6),U,2)="Y" D SPAC S ^(0)=^TMP($J,DVBCTN,0)_Z_"VA Employee",DVBCTN=DVBCTN+1
 I $P(DVBP(6),U,4)="Y" D SPAC S ^(0)=^TMP($J,DVBCTN,0)_Z_"Vietnam Service",DVBCTN=DVBCTN+1
 I $P(DVBP(6),U,5)="Y" D SPAC S ^(0)=^TMP($J,DVBCTN,0)_Z_"Medal of Honor",DVBCTN=DVBCTN+1
 I $D(DVBFIDUC) D
 . I +$P($G(DVBP(6)),U,6)>1,(+$P($G(DVBP(6)),U,6)<5) S $P(DVBP(6),U,6)="Y"
 I $P(DVBP(6),U,6)="Y" D SPAC S ^(0)=^TMP($J,DVBCTN,0)_Z_"Guardianship",DVBCTN=DVBCTN+1
 I $P(DVBP(6),U,7)="Y" D SPAC S ^(0)=^TMP($J,DVBCTN,0)_Z_"Incompetent",DVBCTN=DVBCTN+1
 I $P(DVBP(6),U,8)="Y" D SPAC S ^(0)=^TMP($J,DVBCTN,0)_Z_"Verified Svc-Data",DVBCTN=DVBCTN+1
 I $P(DVBP(6),U,8)="N" D SPAC S ^(0)=^TMP($J,DVBCTN,0)_Z_"NOT verified Svc-Data",DVBCTN=DVBCTN+1
 I $P(DVBP(6),U,8)="U" D SPAC S ^(0)=^TMP($J,DVBCTN,0)_Z_"Unknown Svc-Data",DVBCTN=DVBCTN+1
 ;
P1 G:'$D(DVBP(1)) P5
 N DVBADAP
 S DVBADAP=$S($P(DVBP(1),U)="E":"Equip. only",$P(DVBP(1),U)="A":"Auto & Equip.",$P(DVBP(1),U)="N":"None",1:"")
 I $G(DVBADAP)]"" D SPAC S ^(0)=^TMP($J,DVBCTN,0)_Z_"Adaptive equipment = "_DVBADAP,DVBCTN=DVBCTN+1
 I $P(DVBP(1),U,2)=1!($P(DVBP(1),U,2)="A") D SPAC S ^(0)=^TMP($J,DVBCTN,0)_Z_"Auto allowance = paid.",DVBCTN=DVBCTN+1
 S T1=$P(DVBP(1),U,3) I T1?8N S M=$E(T1,5,6) D MM,SPAC S ^(0)=^TMP($J,DVBCTN,0)_Z_"Original Award = "_M_" "_$E(T1,7,8)_", "_$E(T1,1,4),DVBCTN=DVBCTN+1
 S T1=$P(DVBP(1),U,5) I T1?1.2N D SPAC S ^(0)=^TMP($J,DVBCTN,0)_Z_"Networth = "_$S(T1'="00":"$"_(T1-1*1000)_"-"_"$"_(T1*1000),T1="00":"Zero Networth"),DVBCTN=DVBCTN+1
 I $D(DVBBAS(1)) S T1=$P(DVBBAS(1),U,42) I T1?1.2N D SPAC S ^(0)=^TMP($J,DVBCTN,0)_Z_"(Cust/Spouse) = "_$S(T1'="00":"$"_(T1-1*1000)_"-"_"$"_(T1*1000),T1="00":"Zero Networth"),DVBCTN=DVBCTN+1
 ;Nursing Home Indicator no longer coming from VBA - DVB*4*49
 I $P(DVBP(1),U,7)=1 D SPAC S ^(0)=^TMP($J,DVBCTN,0)_Z_"Adaptive housing = PAID",DVBCTN=DVBCTN+1
 ;SSI, Combat Disability no longer coming from VBA - DVB*4*49
 ;
P5 Q:'$D(DVBP(5))  S T1=$P(DVBP(5),U) I T1 D SPAC S ^(0)=^TMP($J,DVBCTN,0)_Z_"PFOP Balance = "_" $"_+$E(T1,1,6)_"."_$E(T1,7,8),DVBCTN=DVBCTN+1
 Q
 ;
SPAC K Z I $L(^TMP($J,DVBCTN,0))<48 S $P(Z," ",48-$L(^TMP($J,DVBCTN,0)))=" " Q
 S DVBCTN=DVBCTN+1 G SPAC
 ;
MM S M=$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",M) Q
