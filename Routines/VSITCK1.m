VSITCK1 ;ISD/RJP - Visit Field Check (continued) ;6/20/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**76**;Aug 12, 1996
 ; Patch PX*1*76 changes the 2nd line of all VSIT* routines to reflect
 ; the incorporation of the module into PCE.  For historical reference,
 ; the old (VISIT TRACKING) 2nd line is included below to reference VSIT
 ; patches.
 ;
 ;;2.0;VISIT TRACKING;;Aug 12, 1996;
 ;
 Q  ; - not an entry point
 ;
IP(VDT,PAT) ; - check inpatient status
 ;
 ; - rtns <ien of patient movement>
 ;
 N VADMVT,VAINDT,VAERR
 N IPM,DFN
 S VDT=$G(VDT),PAT=$G(PAT)
 S VAINDT=VDT,DFN=+$G(PAT) D ADM^VADPT2
 S IPM=$S(+VADMVT>0:+VADMVT,1:"")
 ; - dom pt is not an inpatient (from ^SDAM2)
 I $P(^DG(43,1,0),"^",21),$P($G(^DIC(42,+$P($G(^DGPM(+VADMVT,0)),"^",6),0)),"^",3)="D" S IPM=""
 Q IPM
 ;
INS4LOC(LOC)       ; - Get Institution for a given Location
 ;
 N INS S LOC=$G(LOC),INS=""
 D:+LOC
 . S INS=$P(^SC(LOC,0),"^",15)
 . S:+INS INS=$P($G(^DG(40.8,INS,0)),"^",7)
 . S INS=$S(+INS&$D(^DIC(4,+INS,0)):INS,1:"")
 Q INS
 ;
DSS4LOC(LOC)       ; - Get Clinic Stop Code for a given Location
 ;
 N DSS S LOC=$G(LOC),DSS=""
 D:+LOC
 . S DSS=$P($G(^SC(LOC,0)),"^",7) S:DSS'=+DSS DSS=""
 Q DSS
 ;
