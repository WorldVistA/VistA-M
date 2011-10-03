SCDXFU11 ;ALB/JRP - ACRP TRANSMISSION MANAGEMENT FILE UTILS;02-JUL-97 ; 1/10/02 4:33pm
 ;;5.3;Scheduling;**128,247**;AUG 13, 1993
 ;
EZN4XMIT(XMITPTR) ;Return zero node of encounter associated to entry
 ; in Transmitted Outpatient Encounter file (#409.73)
 ;
 ;Input  : XMITPTR - Pointer to entry in Transmitted Outpatient
 ;                   Encounter file
 ;Output : Zero node of associated encounter
 ;         Null ("") - Error/bad input
 ;
 ;Check input
 S XMITPTR=+$G(XMITPTR)
 Q:('$D(^SD(409.73,XMITPTR,0))) ""
 ;Declare variables
 N NODE,ENCPTR,DELPTR
 ;Determine if entry in xmit file is for a deleted or existing encounter
 S NODE=$G(^SD(409.73,XMITPTR,0))
 S ENCPTR=+$P(NODE,"^",2)
 S DELPTR=+$P(NODE,"^",3)
 ;Get zero node
 S NODE=""
 ;Existing encounter
 I (ENCPTR) D
 .;Grab zero node of Outpatient Encounter file (#409.68)
 .S NODE=$G(^SCE(ENCPTR,0))
 ;Deleted encounter
 I (DELPTR) D
 .;Original zero node in Deleted Outpatient Encounter file (#409.74)
 .S NODE=$G(^SD(409.74,DELPTR,1))
 ;Done
 Q NODE
 ;
EDT4XMIT(XMITPTR) ;Return date/time of encounter associated to entry
 ; in Transmitted Outpatient Encounter file (#409.73)
 ;
 ;Input  : XMITPTR - Pointer to entry in Transmitted Outpatient
 ;                   Encounter file
 ;Output : FM ^ Ext - Date/time of associated encounter
 ;                  FM = Date/time in FileMan format
 ;                  Ext = Date/time in external format
 ;                        (MMM DD, YYYY@hh:mm:ss)
 ;         0 - Error/bad input
 ;
 ;Check input
 S XMITPTR=+$G(XMITPTR)
 Q:('$D(^SD(409.73,XMITPTR,0))) 0
 ;Declare variables
 N NODE,FMDT,EXTDT
 ;Get zero node of encounter
 S NODE=$$EZN4XMIT(XMITPTR)
 Q:(NODE="") 0
 ;Get date/time of encounter
 S FMDT=+NODE
 Q:('FMDT) 0
 ;Convert to external format
 S EXTDT=$$FMTE^XLFDT(FMDT)
 ;Done
 Q FMDT_"^"_EXTDT
 ;
LOC4XMIT(XMITPTR) ;Return clinic associated to entry in Transmitted
 ; Outpatient Encounter file (#409.73)
 ;
 ;Input  : XMITPTR - Pointer to entry in Transmitted Outpatient
 ;                   Encounter file
 ;Output : Ptr ^ Name - Clinic associated to entry
 ;                    Ptr = Pointer to Hospital Location file (#44)
 ;                    Name = Name of clinic
 ;         0 - Error/bad input
 ;
 ;Check input
 S XMITPTR=+$G(XMITPTR)
 Q:('$D(^SD(409.73,XMITPTR,0))) 0
 ;Declare variables
 N NODE,PTRLOC,CLINIC
 ;Get zero node of encounter
 S NODE=$$EZN4XMIT(XMITPTR)
 Q:(NODE="") 0
 ;Get pointer to location
 S PTRLOC=+$P(NODE,"^",4)
 Q:('PTRLOC) 0
 ;Get clinic name
 S CLINIC=$P($G(^SC(PTRLOC,0)),"^",1)
 Q:(CLINIC="") 0
 ;Done
 Q PTRLOC_"^"_CLINIC
 ;
DIV4XMIT(XMITPTR) ;Return division associated to entry in Transmitted
 ; Outpatient Encounter file (#409.73)
 ;
 ;Input  : XMITPTR - Pointer to entry in Transmitted Outpatient
 ;                   Encounter file
 ;Output : Ptr ^ Name - Division associated to entry
 ;                    Ptr = Pointer to Medical Ctr Division file (#40.8)
 ;                    Name = Division name
 ;         0 - Error/bad input
 ;
 ;Check input
 S XMITPTR=+$G(XMITPTR)
 Q:('$D(^SD(409.73,XMITPTR,0))) 0
 ;Declare variables
 N NODE,PTRDIV,DIVISION
 ;Get zero node of encounter
 S NODE=$$EZN4XMIT(XMITPTR)
 Q:(NODE="") 0
 ;Get pointer to division
 S PTRDIV=+$P(NODE,"^",11)
 Q:('PTRDIV) 0
 ;Get division name
 S DIVISION=$P($G(^DG(40.8,PTRDIV,0)),"^",1)
 Q:(DIVISION="") 0
 ;Done
 Q PTRDIV_"^"_DIVISION
 ;
VID4XMIT(XMITPTR) ;Return Visit ID of encounter associated to entry in
 ; Transmitted Outpatient Encounter file (#409.73)
 ;
 ;Input  : XMITPTR - Pointer to entry in Transmitted Outpatient
 ;                   Encounter file
 ;Output : Unique Visit ID
 ;         Null ("") - Error/bad input
 ;
 ;Check input
 S XMITPTR=+$G(XMITPTR)
 Q:('$D(^SD(409.73,XMITPTR,0))) ""
 ;Declare variables
 N NODE,VSITID
 ;Get zero node of encounter
 S NODE=$$EZN4XMIT(XMITPTR)
 Q:(NODE="") ""
 ;Get Unique Visit ID
 S VSITID=$P(NODE,"^",20)
 ;Done
 Q VSITID
 ;
LATE(HISTPTR) ;Determine if entry in ACRP Transmission History file (#409.77)
 ; was transmitted after NPCD was closed for workload credit
 ;
 ;Input  : HISTPTR - Pointer to entry in ACRP Transmission History file
 ;Output : Int ^ Ext - Whether xmit was late for workload credit
 ;           0 ^ NO  - Transmission occurred before close-out
 ;           1 ^ YES - Transmission occurred after close-out
 ;          -1 ^ ERROR - Unable to calculate / bad input
 ;Notes  : Determination is based on current workload close-out dates,
 ;         which may have changed since date of transmission
 ;
 ;Check input
 S HISTPTR=+$G(HISTPTR)
 Q:('$D(^SD(409.77,HISTPTR,0))) "-1^ERROR"
 ;Declare variables
 N NODE,ENCDATE,XMITDATE,CREDIT
 ;Get zero node of entry
 S NODE=$G(^SD(409.77,HISTPTR,0))
 ;Get date/time of encounter
 S ENCDATE=+$P(NODE,"^",2)
 ;No encounter date/time (error)
 Q:('ENCDATE) "-1^ERROR"
 ;Get node with xmit info
 S NODE=$G(^SD(409.77,HISTPTR,1))
 ;Get date/time of transmission
 S XMITDATE=+NODE
 ;No xmit date/time (error)
 Q:('XMITDATE) "-1^ERROR"
 ;Determine if encounter was transmitted before close-out
 S CREDIT=$$OKTOXMIT^SCDXFU04(ENCDATE,XMITDATE)
 ;only CREDIT<2 and '<0 indicates acceptance for monthly credit ; SD*5.3*247
 ;S CREDIT=+$P(CREDIT,"^",2) ;SD*5.3*247
 ;Error
 Q:(CREDIT=-1) "-1^ERROR"
 ;Not late - transmitted before close-out
 Q:(CREDIT<2) "0^NO"
 ;Late - transmitted after close-out
 Q "1^YES"
 ;
XMIT4DEL(XMITPTR) ;Return whether or not an entry in the Transmitted
 ; Outpatient Encounter file (#409.73) is for a deleted encounter
 ;
 ;Input  : XMITPTR - Pointer to entry in Transmitted Outpatient
 ;                   Encounter file
 ;Output : 0 ^ NO  - Entry is not for a deleted encounter
 ;        -1 ^ ERROR - Unable to determine / bad input
 ;         Ptr ^ YES - Entry is for a deleted encounter
 ;                     Ptr = Pointer to entry in Deleted Outpatient
 ;                           Encounter file (#409.74)
 ;
 ;Check input
 S XMITPTR=+$G(XMITPTR)
 Q:('$D(^SD(409.73,XMITPTR,0))) "-1^ERROR"
 ;Declare variables
 N NODE,DELPTR
 ;Grab zero node
 S NODE=$G(^SD(409.73,XMITPTR,0))
 ;Get pointer to Deleted Outpatient Encounter file (#409.74)
 S DELPTR=+$P(NODE,"^",3)
 ;No pointer found - entry points to Outpatient Encounter file (#409.68)
 Q:('DELPTR) "0^NO"
 ;Points to deleted encounter
 Q DELPTR_"^YES"
 ;
HIST4DEL(HISTPTR) ;Return whether or not an entry in the ACRP Transmission
 ; History file (#409.77) is for a deleted encounter
 ;
 ;Input  : HISTPTR - Pointer to entry in ACRP Transmission History file
 ;Output : 0 ^ NO  - Entry is not for a deleted encounter
 ;        -1 ^ ERROR - Unable to determine / bad input
 ;         Ptr ^ YES - Entry is for a deleted encounter
 ;                     Ptr = Pointer to entry in Deleted Outpatient
 ;                           Encounter file (#409.74)
 ;
 ;Check input
 S HISTPTR=+$G(HISTPTR)
 Q:('$D(^SD(409.77,HISTPTR,0))) "-1^ERROR"
 ;Declare variables
 N XMITPTR
 ;Get pointer to Transmitted Outpatient Encounter file (#409.73)
 S XMITPTR=+$G(^SD(409.77,HISTPTR,0))
 ;Return whether or not it's for a deleted encounter
 Q $$XMIT4DEL(XMITPTR)
