DGMTU2 ;ALB/RMO - Income Utilities ; 6/18/09 6:48pm
 ;;5.3;Registration;**33,688,805**;Aug 13, 1993;Build 4
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
 N DGINI,DGLY
 S DGLY=$$LYR^DGMTSCU1(DGDT)
 S DGINI=+$$IAI^DGMTU3(DGPRI,DGLY)
 I '$D(^DGMT(408.21,DGINI,0)) S DGINI=$$ADDIN(DFN,DGPRI,DGLY)
GETINQ Q $S(DGINI>0:DGINI,1:-1)
 ;
ADDIN(DFN,DGPRI,DGLY) ;Add a new individual annual income entry
 ;                 Input  -- DFN    Patient file IEN
 ;                           DGPRI  Patient Relation IEN
 ;                           DGLY   Last Year
 ;                 Output -- New Individual Annual Income IEN 
 N DA,DD,DGINI,DGNOW,DIC,DIK,DINUM,DLAYGO,DO,X,Y,%
 D NOW^%DTC S DGNOW=%
 S X=DGLY,(DIC,DIK)="^DGMT(408.21,",DIC(0)="L",DLAYGO=408.21
 S DIC("DR")=".02////"_DGPRI_";101////"_DUZ_";102////"_DGNOW
 D FILE^DICN S DGINI=+Y
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
 S DIC("DR")=".02////"_DGINI
 D FILE^DICN S DGIRI=+Y
ADDIRQ Q $S(DGIRI>0:DGIRI,1:-1)
 ;
 ; GTS - DG*5.3*688
VRCHKUP(DGMTYPT,TYPE,DGOLDDT,DGNWDT) ;Check the version and convert IAI records, as needed
 ; Input  -- DGMTYPT  : Type of test being processed
 ;           TYPE     : Optional - used when called from COPYRX^DGMTR1
 ;                                  to indicate existing MT or LTC
 ;           DGOLDDT  : Optional - Date of Test for Old MT/CP test
 ;           DGNWDT   : Optional - Date of Test for New MT/CP test
 ; Output -- CONVRTD  : 1 - IAI Records converted
 ;                    : 0 - IAI Records not converted
 ;
 N CONVRTD,DGMTLST,DGOTHIEN,DGSAMEYR,DGDEC31D,DGERR,DGMTRT,DGMTRT2
 S CONVRTD=0
 S DGSAMEYR=0
 ;
 I +$G(DGOLDDT)=0 S DGOLDDT=DT ;When DGOLDDT is not defined, default today's date
 I +$G(DGNWDT)'=0 S:($E(DGOLDDT,1,3)=$E(DGNWDT,1,3)) DGSAMEYR=1 ;If have New and Old test dates, check for same yr
 S DGDEC31D=$E(DGOLDDT,1,3)_"1231" ;Set search date of Dec 31 of Old Test year
 ;
 ; Check type of test being added or edited and then check for another test in the current year
 ; If Same year, get new test
 I DGSAMEYR DO
 .; NOTE: MT can not be created from a LTC CP Exempt test
 .I DGMTYPT=1 DO
 . . S DGMTLST=$$LST^DGMTU(DFN,DGNWDT,2) ;Find existing CP test - MT required
 . . S:($E($P(DGMTLST,"^",2),1,3)'=$E(DGOLDDT,1,3)) DGMTLST=$$LSTNP^DGMTU21(DFN,DGNWDT,2) ; Last primary test is previous YR
 . ; When updating CP test find either MT or LTC CP Exemption test
 .I DGMTYPT=2 DO
 . . IF '$D(TYPE) S DGMTLST=$$LST^DGMTU(DFN,DGNWDT,1) ;Find existing MT test - CP required
 . . IF $D(TYPE) S DGMTLST=$$LST^DGMTU(DFN,DGNWDT,TYPE) ;Find existing MT or LTC - CP Exempt
 .I DGMTYPT=4 DO
 . . IF '$D(TYPE) S DGMTLST=$$LST^DGMTU(DFN,DGNWDT,1) ;Find existing MT test - CP required
 . . IF $D(TYPE) S DGMTLST=$$LST^DGMTU(DFN,DGNWDT,TYPE) ;Find existing MT - CP req.
 . . ; If Last primary test is previous YR, look for last [may not be primary] (to check current year)
 . . I $E($P(DGMTLST,"^",2),1,3)'=$E(DGOLDDT,1,3) DO
 . . . S:'$D(TYPE) DGMTLST=$$LSTNP^DGMTU21(DFN,DGNWDT,1)
 . . . S:$D(TYPE) DGMTLST=$$LSTNP^DGMTU21(DFN,DGNWDT,TYPE)
 ;If not same year, search for new test in old test year
 I 'DGSAMEYR DO
 .; NOTE: MT can not be created from a LTC CP Exempt test
 .I DGMTYPT=1 DO
 . . S DGMTLST=$$LST^DGMTU(DFN,DGDEC31D,2) ;Find existing CP test - MT required
 .; When updating CP test find either MT or LTC CP Exemption test
 .I DGMTYPT=2 DO
 . . IF '$D(TYPE) S DGMTLST=$$LST^DGMTU(DFN,DGDEC31D,1) ;Find existing MT test - CP required
 . . IF $D(TYPE) S DGMTLST=$$LST^DGMTU(DFN,DGDEC31D,TYPE) ;Find existing MT or LTC - CP Exempt
 .I DGMTYPT=4 DO
 . . IF '$D(TYPE) S DGMTLST=$$LST^DGMTU(DFN,DGDEC31D,1) ;Find existing MT test - CP required
 . . IF $D(TYPE) S DGMTLST=$$LST^DGMTU(DFN,DGDEC31D,TYPE) ;Find existing MT test - CP req.
 . . ; If Last primary test is previous YR, look for last [may not be primary] (to check current year)
 . . I $E($P(DGMTLST,"^",2),1,3)'=$E(DGOLDDT,1,3) DO
 . . . S:'$D(TYPE) DGMTLST=$$LSTNP^DGMTU21(DFN,DGDEC31D,1)
 . . . S:$D(TYPE) DGMTLST=$$LSTNP^DGMTU21(DFN,DGDEC31D,TYPE)
 ;
 ; LTC4 test does not require a record in 408.31, 408.21 records can exist without MT/CP records
 ; If 408.31 entry is not found and LTC4 is being added
 I (+$G(DGMTLST)'>0),(+DGMTYPT=4) DO
 . N DGINC2,DGREL2,DGINR2,DGDEP2
 . M:$D(DGINC) DGINC2=DGINC
 . M:$D(DGREL) DGREL2=DGREL
 . M:$D(DGINR) DGINR2=DGINR
 . M:$D(DGDEP) DGDEP2=DGDEP
 . ; Search IAI records in 408.21; If found convert to 1, as necessary
 . D ALL^DGMTU21(DFN,"VSD",DT,"IPR")
 . I $D(DGINC) DO
 . . N OTHRTST
 . . D ISCNVRT^DGMTUTL(.DGINC)
 . . S OTHRTST=$$UPDTTSTS^DGMTU21(DFN,$E($P(DGMTLST,"^",2),1,3))
 . . S CONVRTD=1
 . ; Restore DGINC, DGREL, DGINR, and DGDEP
 . K DGINC,DGREL,DGINR,DGDEP
 . M:$D(DGINC2) DGINC=DGINC2
 . M:$D(DGREL2) DGREL=DGREL2
 . M:$D(DGINR2) DGINR=DGINR2
 . M:$D(DGDEP2) DGDEP=DGDEP2
 ;
 ; If another test is found
 I $D(DGMTLST),(+DGMTLST>0) DO
 . ; if the year of the test that have = year of test with IAI records to analyze
 . I ($E($P(DGMTLST,"^",2),1,3)=$E(DGOLDDT,1,3)) DO
 . . S DGOTHIEN=+DGMTLST
 . . ;
 . . ; If the other test was not entered in Version 1 format
 . . I +$P($G(^DGMT(408.31,DGOTHIEN,2)),"^",11)'=1 DO
 . . . ; Save values of DGINC, DGREL, DGINR, and DGDEP
 . . . N DGINC2,DGREL2,DGINR2,DGDEP2
 . . . M:$D(DGINC) DGINC2=DGINC
 . . . M:$D(DGREL) DGREL2=DGREL
 . . . M:$D(DGINR) DGINR2=DGINR
 . . . M:$D(DGDEP) DGDEP2=DGDEP
 . . . ;
 . . . ; Get IAI records from 408.21 and convert them from version 0 to 1
 . . . D:(+$P(DGMTLST,"^",2)>0) ALL^DGMTU21(DFN,"VSD",+$P(DGMTLST,"^",2),"IPR")
 . . . D:(+$P(DGMTLST,"^",2)'>0) ALL^DGMTU21(DFN,"VSD",DT,"IPR")
 . . . D ISCNVRT^DGMTUTL(.DGINC)
 . . . ;
 . . . ; Update 2.11 in all (1, 2 and 4 type) 408.31 records for DFN and IY
 . . . N OTHRTST
 . . . S OTHRTST=$$UPDTTSTS^DGMTU21(DFN,$E($P(DGMTLST,"^",2),1,3))
 . . . ;
 . . . ; Restore DGINC, DGREL, DGINR, and DGDEP
 . . . K DGINC,DGREL,DGINR,DGDEP
 . . . M:$D(DGINC2) DGINC=DGINC2
 . . . M:$D(DGREL2) DGREL=DGREL2
 . . . M:$D(DGINR2) DGINR=DGINR2
 . . . M:$D(DGDEP2) DGDEP=DGDEP2
 . . . S CONVRTD=1
VRCHKQ Q CONVRTD
