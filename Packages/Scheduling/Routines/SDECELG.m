SDECELG ;SPFO/DMR SCHEDULING ENHANCEMENTS VSE API
 ;;5.3;Scheduling;**669**;Aug 13 1993;Build 16
 ;
 ;This API gets the all patient eligibility
 ;
 Q
START(RRN,DFN) ;
 S (NM,NM2,MECN,VET,VET1,ELGN,REO,RRN)=""
 ;
 S ELGN=0 F  S ELGN=$O(^DPT(DFN,"E",ELGN)) Q:ELGN="B"!(ELGN="")  D
 .S NM="" S NM=$P(^DIC(8,ELGN,0),"^",1)
 .Q:NM=""  S MECN="" S MECN=$P($G(^DIC(8,ELGN,0)),"^",9)
 .Q:'$G(MECN)  S NM2="" S NM2=$P(^DIC(8.1,MECN,0),"^",1)
 .Q:'$D(NM2)  S (VET,VET1)="" S VET=$P(^DIC(8.1,MECN,0),"^",5)
 .Q:'$D(VET)  S VET1=$S(VET="N":"NON-VETERAN",VET="Y":"VETERAN")
 .S REO=":"_ELGN_"^"_NM_"^"_NM2_"^"_VET1
 .S RRN=RRN_REO
 .Q
 K NM,NM2,MECN,VET,VET1,ELGN,REO
 Q
