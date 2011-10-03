DGPFPARM ;ALB/RPM - PRF PARAMETER FILE EDIT ; 5/5/05 12:27pm
 ;;5.3;Registration;**425,554**;Aug 13, 1993
 ;
 Q  ;no direct entry
 ;
EN ;
 N DA,DD,DO,DIC,DIE,DINUM,DR,X,Y
 ;
 W !!,"Patient Record Flag Parameter Enter/Edit"
 I '$D(^DGPF(26.18,1,0)) D
 .W !,"You do not have an entry in your parameter file!!"
 .W !,"Creating a new entry in the PRF PARAMETER (#26.18) file... ",!
 .S DIC="^DGPF(26.18,",DIC(0)="",X=1,DINUM=1
 .K DD,DO D FILE^DICN W " done."
 .K %,DA,DIC,DIE,X,Y
 ;
 S DIE="^DGPF(26.18,",DA=1,DR="2;3" D ^DIE
 K DIE,DR,DA
 Q
 ;
ON() ;Used to determine if the PRF software is 'active'.
 ;
 ; Input: None
 ;
 ;Output:
 ;  Function Value - 1 = 'Active', 0 = 'Not Active'
 ;
 ; - init variables
 N DGACT,RESULT
 S RESULT=0
 ;
 ;- get software activation date from PRF PARAMETERS (#26.18) file
 S DGACT=+$P($G(^DGPF(26.18,1,0)),U,2)
 ;
 ; - check if activation is past current date
 D
 .Q:('DGACT)!(DT<DGACT)
 .S RESULT=1
 ;
 Q RESULT
 ;
ORUON() ;Used to determine if ORU~R01 HL7 interface is 'enabled'.
 ;
 ;This function verifies that the PRF software is active and  then
 ;returns the state of the Unsolicited Observation Update HL7 inteface
 ;in the PRF PARAMETERS (#26.18) file.
 ;
 ;  Input:
 ;    none
 ;
 ;  Output:
 ;    Function value - 1 if interface is enabled, 0 if interface is
 ;                     disabled
 ;
 Q:'$$ON() 0
 Q +$P($G(^DGPF(26.18,1,0)),U,3)
 ;
QRYON() ;Used to determine if QRY~R02 HL7 interface is 'enabled'.
 ;
 ;This function verifies that the PRF software is active and then
 ;returns the state of the QRY HL7 inteface in the PRF PARAMETERS
 ;(#26.18) file.
 ;
 ;  Input:
 ;    none
 ;
 ;  Output:
 ;   Function value - 0 if interface is disabled, 1 if interface is
 ;                    enabled in 'direct' mode, 2 if interface is 
 ;                    enabled in 'deferred' mode.
 ;
 Q:'$$ON() 0
 Q +$P($G(^DGPF(26.18,1,0)),U,4)
 ;
P2ON() ;Used to determine if the PRF Phase 2 software is 'active'.
 ;
 ; Supported References:
 ;   DBIA #4440 KERNEL SYSTEM PARAMETERS (PROD^XUPROD())
 ;
 ;  Input: None
 ;
 ;  Output:
 ;   Function Value - 1 = 'Active', 0 = 'Not Active'
 ;
 N DGACT   ;activation date
 N DGRESULT  ;function value
 ;
 S DGRESULT=0
 ;
 ;- get software activation date from PRF PARAMETERS (#26.18) file
 S DGACT=+$P($G(^DGPF(26.18,1,0)),U,7)
 ;
 ;- check if activation is past current date in production
 I $$PROD^XUPROD() D     ;production account
 . Q:('DGACT)!(DT<DGACT)
 . S DGRESULT=1
 E  S DGRESULT=1           ;test account: always 'active'
 ;
 Q DGRESULT
