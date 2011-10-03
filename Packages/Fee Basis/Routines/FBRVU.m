FBRVU ;;WOIFO/SS-RVU UTILITIES ;09-OCT-05
 ;;3.5;FEE BASIS;**93**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;/*
 ;Integration Agreement #4799
 ;The API to retrieve Work Relative Value Units (RVU)
 ;from FeeBasis file #162.97 by CPT code, CPT modifier and a date
 ;
 ;Input:
 ; FBCPT  (Required) CPT code, external value
 ; FBMOD  (Optional) CPT modifier. Can be a string of CPT code specific
 ;   modifiers delimited by commas.
 ; FBDATE (Optional) Exam date/time in FileMan format. If null then today's date
 ;   becomes the assumed date.
 ;
 ;Output:
 ; returns a string RETSTATUS^VALUE^MESSAGE
 ; where
 ;
 ; If the CPT/CPT+CPT modifier was found for the date or date/time specified then:
 ; RETSTATUS = 1,
 ; VALUE = (#.03) WORK RELATIVE VALUE UNIT of file #162.97,
 ; MESSAGE = null.
 ;
 ; If the CPT/CPT+CPT modifier was NOT found for the date or date/time specified then:
 ; RETSTATUS = 0,
 ; VALUE = null,
 ; MESSAGE = "CPT/MOD not found"
 ;
 ; If the date specified in FBDATE is invalid then:
 ; RETSTATUS = 0,
 ; VALUE = null,
 ; MESSAGE = "Valid date not specified"
 ; 
 ; If the CPT modifiers listed in FBMOD cannot be used together
 ; to determine correct RVU value then:
 ; RETSTATUS = 0, 
 ; VALUE = null,
 ; MESSAGE = "Wrong CPT modifiers combination"
 ;
 ; If the database is not available at the time of the request then:
 ; RETSTATUS = -1,
 ; VALUE = null,
 ; MESSAGE = "Database Unavailable"
 ; 
RVU(FBCPT,FBMOD,FBDATE) ;
 N FBYEAR,FBCPT0,FBCPTY0
 I '$D(^FB(162.97,0)) Q "-1^^Database Unavailable"
 I $$CHKMOD($G(FBMOD)) Q "0^^Wrong CPT modifiers combination"
 I $G(FBDATE)="" S FBDATE=DT
 S FBDATE=$G(FBDATE)\1
 I FBDATE'?7N Q "0^^Valid date not specified"
 S FBYEAR=$E(FBDATE,1,3)+1700
 D PROC^FBAAFSR(FBCPT,$G(FBMOD),FBYEAR,1)
 I $G(FBCPT0)="" Q "0^^CPT/MOD not found"
 Q "1^"_$P($G(FBCPTY0),U,3)_U
 ;
 ;check if FBMOD contains any combination of "TC",26 and 53
CHKMOD(FBMODLST) ;
 N FBM,FBCNT
 S FBCNT=0,FBMODLST=","_FBMODLST_","
 F FBM=",TC,",",26,",",53," S:FBMODLST[FBM FBCNT=FBCNT+1
 Q FBCNT>1
 ;
 ;FBRVU
