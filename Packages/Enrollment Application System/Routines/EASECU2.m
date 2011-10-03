EASECU2 ;ALB/LBD - Income Utilities ;14 AUG 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5**;Mar 15, 2001
 ;
GETIENS(DFN,DGPRI,DGDT) ;Look-up individual annual income and income relation
 ;                 Input  -- DFN    Patient file IEN
 ;                           DGPRI  Patient Relation IEN
 ;                           DGDT   Date/Time
 ;                 Output -- DGINI  Individual Annual Income IEN
 ;                           DGIRI  Income Relation IEN
 ;                           DGERR  1=ERROR and 0=NO ERROR
 S DGERR=0
 S DGINI=$$GETIN(DFN,DGPRI,DGDT) S:DGINI<0 DGERR=1
 I 'DGERR S DGIRI=$$GETIR(DFN,DGINI) S:DGIRI<0 DGERR=1
 Q
 ;
GETIN(DFN,DGPRI,DGDT) ;Look-up individual annual income
 ;                Add a new entry if one is not found
 ;                 Input  -- DFN    Patient file IEN
 ;                           DGPRI  Patient Relation IEN
 ;                           DGDT   Date/Time
 ;                 Output -- Individual Annual Income IEN 
 N DGINI,DGYR
 S DGYR=$E(DGDT,1,3)_"0000"
 ; get IEN of individual annual income for LTC co-pay (test type 3)
 S DGINI=+$$IAI^DGMTU3(DGPRI,DGYR,3)
 I '$D(^DGMT(408.21,DGINI,0)) S DGINI=$$ADDIN(DFN,DGPRI,DGYR)
GETINQ Q $S(DGINI>0:DGINI,1:-1)
 ;
ADDIN(DFN,DGPRI,DGYR) ;Add a new individual annual income entry
 ;                 Input  -- DFN    Patient file IEN
 ;                           DGPRI  Patient Relation IEN
 ;                           DGYR   Test Year
 ;                 Output -- New Individual Annual Income IEN 
 N DA,DD,DGINI,DGNOW,DIC,DIK,DINUM,DLAYGO,DO,X,Y,%
 D NOW^%DTC S DGNOW=%
 S X=DGYR,(DIC,DIK)="^DGMT(408.21,",DIC(0)="L",DLAYGO=408.21
 D FILE^DICN S DGINI=+Y
 I DGINI>0 D
 .L +^DGMT(408.21,DGINI)
 .S $P(^DGMT(408.21,DGINI,0),"^",2)=DGPRI,^("USR")=DUZ_"^"_DGNOW
 .I $G(DGMTI) S ^DGMT(408.21,DGINI,"MT")=DGMTI
 .S DA=DGINI D IX1^DIK L -^DGMT(408.21,DGINI)
ADDINQ Q $S(DGINI>0:DGINI,1:-1)
 ;
GETIR(DFN,DGINI) ;Look-up income relation
 ;                Add a new entry if one is not found
 ;                 Input  -- DFN    Patient file IEN
 ;                           DGINI  Individual Annual Income IEN
 ;                 Output -- Income Relation IEN
 N DGIRI
 S DGIRI=+$O(^DGMT(408.22,"AIND",DGINI,0))
 I '$D(^DGMT(408.22,DGIRI,0)) S DGIRI=$$ADDIR(DFN,DGINI)
GETIRQ Q $S(DGIRI>0:DGIRI,1:-1)
 ;
ADDIR(DFN,DGINI) ;Add a new income relation entry
 ;                 Input  -- DFN    Patient file IEN
 ;                           DGINI  Individual Annual Income IEN
 ;                 Output -- New Income Relation IEN
 N DA,DD,DGIRI,DIC,DIK,DINUM,DLAYGO,DO,X,Y
 S X=DFN,(DIC,DIK)="^DGMT(408.22,",DIC(0)="L",DLAYGO=408.22
 D FILE^DICN S DGIRI=+Y
 I DGIRI>0 L +^DGMT(408.22,DGIRI) S $P(^DGMT(408.22,DGIRI,0),"^",2)=DGINI,DA=DGIRI D IX1^DIK L -^DGMT(408.22,DGIRI)
ADDIRQ Q $S(DGIRI>0:DGIRI,1:-1)
