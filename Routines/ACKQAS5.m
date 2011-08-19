ACKQAS5 ;AUG/JLTP BIR/PTD HCIOFO/BH-New Clinic Visits ;  04/01/99 
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
 ;
EDIT ;  Edit Template.
 S ACKVISIT="EDIT",ACKVIEN=DA
 ;
 ;  Attempt to Lock file before editing
 L +^ACK(509850.6,ACKVIEN):2 E  W !!,"This record is locked by another process - Please try again later.",!! D VEXIT^ACKQAS Q
 ; If visit has PCE IEN check PCE and Qsr visit data for inconsistancies
 I $$GET1^DIQ(509850.6,ACKVIEN,"125","I")'="" I '$$DATACHK^ACKQASU3(ACKVIEN) D UNLOCK^ACKQAS,VEXIT^ACKQAS,HEADING^ACKQAS Q
 S ACKVTME=$P(^ACK(509850.6,ACKVIEN,5),U,8),ACKVTME=$P(ACKVTME,".",2)
ETPLATE S (DIE,DIC)="^ACK(509850.6,",DR="[ACKQAS VISIT ENTRY]" D ^DIE
 D UTLAUD^ACKQASU2
 S ACKQTST=$$POST^ACKQASU2(ACKVIEN) I 'ACKQTST S ACKDFN=DFN G ETPLATE
 ;  ACKQTST will equal 1 (Visit okay or user chose to continue) or
 ;  ACKQTST will equal 2 the visit has been deleted
 I ACKPCE,ACKQTST=1,$$EXPT^ACKQASU2(ACKVIEN) I '$$PCESEND^ACKQASU3(ACKVIEN) S ACKDFN=DFN G ETPLATE
 ;  If visit is okay and visit not to be sent to PCE but visit has a
 ;  value in the PCE IEN field - the EXCEPTION DATE from the visit is 
 ;  used check the Exception cross reference.  If an exception exists
 ;  display a warning message.
 I ACKQTST=1,'ACKPCE,$$GET1^DIQ(509850.6,ACKVIEN_",",125,"I")'="" D
 . Q:'$$EXPT^ACKQASU2(ACKVIEN)
 . D EXCEPT^ACKQASU1
 ;  Unlock,kill off used vars. re-display heading & return to start
 D UNLOCK^ACKQAS,VEXIT^ACKQAS,HEADING^ACKQAS
 Q
 ;
