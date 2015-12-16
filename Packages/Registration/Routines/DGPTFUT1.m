DGPTFUT1 ;ALBOI/KCL - PTF UTILITIES CONTINUED;10/14/14
 ;;5.3;Registration;**884**;Aug 13, 1993;Build 31
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;direct entry not allowed
 QUIT
 ;
POA501(DGX,DGDA1,DGDA,DGNODE,DGPIECE) ;called from input transforms of POA fields in 501 (#45.02) sub-file
 ;This function will check to see if the 501 Movement ICD/Dx field associated with POA being
 ;entered is populated.  If it is not, the user will not be allowed to enter the POA indicator.
 ;
 ;  Input:
 ;       DGX - (required) user input for field
 ;     DGDA1 - (required) ien of record in PTF (#45) file
 ;      DGDA - (required) ien of record in 501 (#45.02) sub-file
 ;    DGNODE - (required) node of 501 Movement ICD/Dx field associated with POA field
 ;   DGPIECE - (required) piece of 501 Movement ICD/Dx field associated with POA field
 ;
 ; Output:
 ;    DGRSLT - (function value) 
 ;             1 if user input permitted 
 ;             0 if user input not permitted and output from EN^DDIOL
 ;
 N DGMSG
 N DGRSLT
 ;
 S DGRSLT=0
 ;
 ;check for required input
 Q:'$D(DGX) DGRSLT
 Q:'$G(DGDA1) DGRSLT
 Q:'$G(DGDA) DGRSLT
 Q:$G(DGNODE)']"" DGRSLT
 Q:'$G(DGPIECE) DGRSLT
 ;
 S DGRSLT=1
 ;
 ;check for 501 Movement ICD/Diagnosis field associated with POA indicator
 I $P($G(^DGPT(DGDA1,"M",DGDA,DGNODE)),U,DGPIECE)="" D
 . S DGRSLT=0
 . S DGMSG(1)=" "
 . S DGMSG(2)="Please enter the ICD for this POA first!"
 . S DGMSG(2,"F")="!?3"
 . S DGMSG(3)=" "
 . D EN^DDIOL(.DGMSG)
 ;
 Q DGRSLT
 ;
 ;
POA701(DGX,DGDA,DGNODE,DGPIECE) ;called from input transforms of POA fields in 701 Primary/Secondary Dx fields
 ;This function will check to see if the 701 Primary/Secondary Dx field associated with POA being
 ;entered is populated.  If it is not, the user will not be allowed to enter the POA indicator.
 ;
 ;  Input:
 ;       DGX - (required) user input for field
 ;      DGDA - (required) ien of record in PTF (#45) file
 ;    DGNODE - (required) node of 701 Primary/Secondary Dx field associated with POA field
 ;   DGPIECE - (required) piece of 701 Primary/Secondary Dx field associated with POA field
 ;
 ; Output:
 ;    DGRSLT - (function value) 
 ;             1 if user input permitted 
 ;             0 if user input not permitted and output from EN^DDIOL
 ;
 N DGMSG
 N DGRSLT
 ;
 S DGRSLT=0
 ;
 ;check for required input
 Q:'$D(DGX) DGRSLT
 Q:'$G(DGDA) DGRSLT
 Q:$G(DGNODE)']"" DGRSLT
 Q:'$G(DGPIECE) DGRSLT
 ;
 S DGRSLT=1
 ;
 ;check for 701 Primary/Secondary Dx field associated with POA indicator
 I $P($G(^DGPT(DGDA,DGNODE)),U,DGPIECE)="" D
 . S DGRSLT=0
 . S DGMSG(1)=" "
 . S DGMSG(2)="Please enter the Diagnosis for this POA first!"
 . S DGMSG(2,"F")="!?3"
 . S DGMSG(3)=" "
 . D EN^DDIOL(.DGMSG)
 ;
 Q DGRSLT
