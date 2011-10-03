IVMCUF1 ;ALB/KCL - GENERIC DCD FUNCTIONS ; 24-JUL-95
 ;;2.0;INCOME VERIFICATION MATCH;**17**;21-OCT-94
 ;
 ; This routine contains generic functions which are used throughout
 ; the DCD/IVM module.
 ;
 ;
PAUSE ; Function to check if primary elig. is on file:
 ;        - If primary elig. is on file --> quit
 ;        - Check if primary elig. on file every 30 sec. for 1/2 hour
 ; 
 ; Input: DFN -- Pointer to the patient in file (#2)
 ;
 N IVMTRY
 I '$G(DFN) G PAUSEQ
 F IVMTRY=1:1:60 D
 .Q:$$ELIG(DFN)
 .H 30
PAUSEQ Q
 ;
 ;
ELIG(DFN) ; Check if patient has Primary Eligibility on file
 ;
 ;  Input:  DFN -- pointer to patient in file (#2)
 ;
 ; Output:  1 --> if patient has primary eligibillity on file in Patient
 ;                (#2) file
 ;          0 --> if patient does not have primary eligibillity on file
 ;                in Patient (#2) file
 ; 
 N IVMELIG
 I '$G(DFN) G ELIGQ
 ; - check if PRIMARY ELIGIBILITY CODE (#.361) field on file
 S IVMELIG=$S($P($G(^DPT(+DFN,.36)),"^"):1,1:0)
ELIGQ Q $G(IVMELIG)
