EASECU21 ;ALB/LBD - Income Utilities Cont. ;14 AUG 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5**;Mar 15, 2001
 ;
 ; This routine was modified from DGMTU21 for LTC Co-pay
 ;
ALL(DFN,DGTYPE,DGDT,DGRTY,DGMT) ;Select patient relation, individual annual
 ;                        income and income relation arrays of internal
 ;                        entry numbers
 ;                         Input  -- DFN     Patient file IEN
 ;                                   DGTYPE  Type of Relation which can
 ;                                           contain:
 ;                                           V for veteran
 ;                                           S for spouse
 ;                                           C for dependent children
 ;                                                 or
 ;                                           D for all dependents
 ;                                   DGDT    Date/Time
 ;                                   DGRTY   Type of Array to Return
 ;                                           which can contain:
 ;                                           I for Ind Annual Income
 ;                                           P for Patient Relation
 ;                                           R for Income Relation
 ;                                           (Optional - default IPR)
 ;                                   DGMT    IFN of Means Test (optional)
 ;                 Output -- DGREL   Patient Relation IEN Array
 ;                           DGINC   Individual Annual Income IEN Array
 ;                           DGINR   Income Relation IEN Array
 ;                           DGDEP   Number of Dependents
 K DGINC,DGINR,DGREL
 N DGCNT,DGLY,DGPRTY
 ; for LTC co-pay DGLY is set to current year
 S:'$D(DGRTY) DGRTY="IPR" S DGLY=$E(DGDT,1,3)_"0000"
 D GETREL^DGMTU11(DFN,DGTYPE,DGLY,$G(DGMT))
 S DGPRTY="" F  S DGPRTY=$O(DGREL(DGPRTY)) Q:DGPRTY=""  D SET
 I DGRTY'["P" K DGREL
ALLQ Q
 ;
SET ;Set individual annual income and income relation arrays
 N DGCNT,DGPRI,DGINI,DGIRI
 I "CD"[DGPRTY S DGCNT=0 F  S DGCNT=$O(DGREL(DGPRTY,DGCNT)) Q:'DGCNT  D
 .S DGPRI=+DGREL(DGPRTY,DGCNT) D GET
 .I DGINI,DGRTY["I" S DGINC(DGPRTY,DGCNT)=DGINI
 .I DGIRI,DGRTY["R" S DGINR(DGPRTY,DGCNT)=DGIRI
 I "SV"[DGPRTY D
 .S DGPRI=+DGREL(DGPRTY) D GET
 .I DGINI,DGRTY["I" S DGINC(DGPRTY)=DGINI
 .I DGIRI,DGRTY["R" S DGINR(DGPRTY)=DGIRI
 Q
 ;
GET ;Look-up individual annual income and income relation IEN
 S DGINI=+$$IAI^DGMTU3(DGPRI,DGLY,$S($G(DGMT):$P($G(^DGMT(408.31,DGMT,0)),"^",19),1:1))
 S DGIRI=+$O(^DGMT(408.22,"AIND",DGINI,0))
 Q
