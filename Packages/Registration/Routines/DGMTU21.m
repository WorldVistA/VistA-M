DGMTU21 ;ALB/RMO - Income Utilities Cont. ;6 MAR 1992 8:40 am
 ;;5.3;Registration;**33,45,182,688**;Aug 13, 1993;Build 29
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
 S:'$D(DGRTY) DGRTY="IPR" S DGLY=$$LYR^DGMTSCU1(DGDT)
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
 ;
 ; GTS - DG*5.3*688
UPDTTSTS(DFN,IY) ;Update all tests for IY of converted IAI rec's
 ; INPUT: DFN - Patient file IEN
 ;        IY  - Income Year FM format (ex: 306 for 2006)
 ;        
 ; OUTPUT: RESULT
 ;               1 - Converted records
 ;               0 - Did not convert records
 ;               
 N RESULT,TYPE,TESTDT,IRIEN,DGMT2
 S RESULT=0
 F TYPE=1,2,4 DO
 . S TESTDT=""
 . S IRIEN=""
 . I $D(^DGMT(408.31,"AID",TYPE)) DO
 . . F  Q:('$D(^DGMT(408.31,"AID",TYPE,DFN)))  S TESTDT=$O(^DGMT(408.31,"AID",TYPE,DFN,TESTDT)) Q:(+TESTDT=0)  DO
 . . . I $E(TESTDT,2,4)=IY DO
 . . . . S IRIEN=$O(^DGMT(408.31,"AID",TYPE,DFN,TESTDT,""))
 . . . . ; Update 2.11 in 408.31 rec
 . . . . S DGMT2(408.31,+IRIEN_",",2.11)=1
 . . . . S DGERR=""
 . . . . D FILE^DIE("","DGMT2",DGERR)
 . . . . S RESULT=1
 Q RESULT
 ;
 ; GTS - DG*5.3*688
LSTNP(DFN,DGDT,DGMTYPT) ;Last MT/CP/LTC4 test for a patient regardless of Primary status
 ;         Input  -- DFN   Patient IEN
 ;                   DGDT  Date/Time  (Optional- default today@2359)
 ;                DGMTYPT  Type of Test (Optional - if not defined 
 ;                                       Means Test will be assumed)
 ;         Output -- Annual Means Test IEN^Date of Test
 ;                   ^Status Name^Status Code^Source of Test
 N DGIDT,DGMTFL1,DGMTI,DGNOD,Y I '$D(DGMTYPT) S DGMTYPT=1
 S DGIDT=$S($G(DGDT)>0:-DGDT,1:-DT) S:'$P(DGIDT,".",2) DGIDT=DGIDT_.2359
 F  S DGIDT=+$O(^DGMT(408.31,"AID",DGMTYPT,DFN,DGIDT)) Q:'DGIDT!$G(DGMTFL1)  D
 .F DGMTI=0:0 S DGMTI=+$O(^DGMT(408.31,"AID",DGMTYPT,DFN,DGIDT,DGMTI)) Q:'DGMTI!$G(DGMTFL1)  D
 ..S DGNOD=$G(^DGMT(408.31,DGMTI,0)) I DGNOD!(DGMTYPT=4) S DGMTFL1=1,Y=DGMTI_"^"_$P(^(0),"^")_"^"_$$MTS^DGMTU(DFN,+$P(^(0),"^",3))_"^"_$P(DGNOD,"^",23)
 Q $G(Y)
