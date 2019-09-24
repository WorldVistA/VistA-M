SDCCRGAP ;CCRA/LB,PB - Appointment retrieval API;APR 4, 2019
 ;;5.3;Scheduling;**707**;APR 4, 2019;Build 57
 ;;Per VA directive 6402, this routine should not be modified.
 Q
GETAPPT(PATIEN,APPTDT,APPTARY) ;Gets the appointment details form the database and returns it in an array.
 ;  See parameter descriptions for details of the available nodes.
 ;   PATIEN(I,REQ) - The patient IEN
 ;   APPTDT(I,REQ)  - the appointment date/time in vista format.
 ;                    Found in the ^DPT(<IEN>,"S",<APPTDT> node.
 ;   APPTARY(O,REQ) - Array  of appointment data.
 ;
 ;         APPTARY("PATIENT IEN") - IEN
 ;         APPTARY("APPTDT")  = date/time of the appointment in VistA format
 ;         APPTARY("APPTTYPE") - appointment type
 ;         APPTARY("CANCEL REASON") - Cancellation reason (discrete)
 ;         APPTARY("CANCEL REMARK") - Cancellation remark (freetext)
 ;         APPTARY("CHECKIN DT") - date/time of the check in action
 ;         APPTARY("CHECKIN USER") - check in user
 ;         APPTARY("CHECKOUT DT") - date/time of the check out action
 ;         APPTARY("CHECKOUT USER") - check out user
 ;         APPTARY("CLINIC")  = the clinic of this appointment
 ;         APPTARY("CLINIC NAME") = Clinic name
 ;         APPTARY("CLINIC PROVIDER",0) - number of providers on the clinic
 ;         APPTARY("CLINIC PROVIDER",n,"IEN") - Provider IEN
 ;         APPTARY("CLINIC PROVIDER",n,"NAME") - Name of provider
 ;         APPTARY("CLINIC PURGED") - Flag to say the clinic has reached its
 ;                                    purge days so the data is no longer available.
 ;         APPTARY("CLINIC GROUP")  - This is heavily covering our specialties.
 ;         APPTARY("COMMENT") - Appointment comment.
 ;         APPTARY("CONSULT") - linked consult ID
 ;         APPTARY("COV") - The COV. Looking into what this is.
 ;         APPTARY("DURATION") - appointment duration
 ;         APPTARY("ENCOUNTER IEN") - Encounter ID
 ;         APPTARY("ELIGIBILITY")  - Appointment eligibility if different than primary
 ;         APPTARY("Next Available") - If the appt was scheduled as next available
 ;         APPTARY("PAT INDICATED DATE")  - Date the start of search was performed on.
 ;         APPTARY("STATUS") - APPT status calculated to current state
 ;                            (SCHEDULED/CHECKED IN/CHECKED OUT/CANCELLED/NO-SHOW)
 ;         APPTARY("USER") - Scheduling user
 ;
 N DELIM,CLNODE0,SNODE0,CLINIC,PROVARY,CLNODEC,CLNODECN
 K APPTARY   ;Force output only parameter
 ;
 I $G(PATIEN)="" Q
 I $G(APPTDT)="" Q
 ;
 S DELIM="^"
 S SNODE0=$$APPTNODE(PATIEN,APPTDT,0)
 I $G(SNODE0)="" Q    ;no appointment found
 ;
 ; Get clinic
 S CLINIC=$P(SNODE0,DELIM,1)
 S CLNODE0=$$CLINNODE(PATIEN,APPTDT,CLINIC,0)
 S CLNODEC=$$CLINNODE(PATIEN,APPTDT,CLINIC,"C")
 S CLNODECN=$$CLINNODE(PATIEN,APPTDT,CLINIC,"CONS")
 ;
 ; Get providers off of clinic
 I $G(CLINIC)'="" D CLINPROV(CLINIC,.PROVARY)
 ;
 ; Build Array of patient information from the known nodes
 S APPTARY("PATIENT IEN")=PATIEN  ;IEN
 S APPTARY("APPTDT")=APPTDT   ;date/time of the appointment in VistA format
 S APPTARY("APPTTYPE")=$P(SNODE0,DELIM,16)  ;appointment type
 S APPTARY("CLINIC")=$G(CLINIC)    ;the clinic of this appointment  ;
 I $G(CLNODE0)="" S APPTARY("CLINIC PURGED")=1
 I $D(PROVARY) M APPTARY("CLINIC PROVIDER")=PROVARY
 S APPTARY("CLINIC NAME")=$$GET1^DIQ(44,$G(CLINIC),.01)
 S APPTARY("CLINIC GROUP")=$$CLINGRP($G(CLINIC))
 S APPTARY("CLINIC GROUP NAME")=$$GET1^DIQ(409.67,$G(APPTARY("CLINIC GROUP")),.01)
 S APPTARY("CHECKIN DT")=$P($G(CLNODEC),DELIM,1)
 S APPTARY("CHECKIN USER")=$P($G(CLNODEC),DELIM,2)
 S APPTARY("CHECKOUT DT")=$P($G(CLNODEC),DELIM,3)
 S APPTARY("CHECKOUT USER")=$P($G(CLNODEC),DELIM,4)
 S APPTARY("COMMENT")=$P(CLNODE0,DELIM,4)
 S APPTARY("CONSULT")=$$CLINNODE(PATIEN,APPTDT,CLINIC,"CONS")   ;consult ID
 S APPTARY("COV")=$P(SNODE0,DELIM,7)    ;The COV if c&P/Scheduled/or walked in
 S APPTARY("DURATION")=$P(CLNODE0,DELIM,2)
 s APPTARY("ELIGIBILITY")=$P(CLNODE0,DELIM,10)
 S APPTARY("PAT INDICATED DATE")=$$APTNODEP(PATIEN,APPTDT,1,1)
 ; APPT status - Computed and translated
 S APPTARY("STATUS")=$$APTSTAT(PATIEN,APPTDT,0)
 S APPTARY("STATUS PIECE")=$P(SNODE0,DELIM,2)      ;Status from the status node
 S APPTARY("USER")=$P(SNODE0,DELIM,18)      ;Scheduling user
 S APPTARY("CANCEL REASON")=$P(SNODE0,DELIM,15)
 S APPTARY("CANCEL REMARK")=$$APTNODEP(PATIEN,APPTDT,"R",1)
 S APPTARY("ENCOUNTER IEN")=$P(SNODE0,DELIM,20)
 Q
APPTNODE(PATIEN,APPTDT,NODE) ;For a given patient we will return their appointment node in the ^DPT file.
 ;   PATIEN(I,REQ) - The patient IEN
 ;   APPTDT(I,REQ)  - the appointment date/time in vista format. Found in the ^DPT(<IEN>,"S",<APPTDT> node.
 ;   NODE(I,REQ)  - node number to pull
 ;
 I ($G(APPTDT)="")!($G(PATIEN)="")!($G(NODE)="") Q
 Q $G(^DPT(PATIEN,"S",APPTDT,NODE))
APTNODEP(PATIEN,APPTDT,NODE,PIECE) ;For a given patient we will return a piece of their appointment node in the ^DPT file.
 ;   PATIEN(I,REQ) - The patient IEN
 ;   APPTDT(I,REQ)  - the appointment date/time in vista format. Found in the ^DPT(<IEN>,"S",<APPTDT> node.
 ;   NODE(I,REQ)  - node number to pull
 ;   PIECE(I,REQ)  - piece in the node to return
 ;   DATA(I,OPT) - data node may be passed in to bypass extracting.
 N DATA
 S DATA=$$APPTNODE($G(PATIEN),$G(APPTDT),$G(NODE))
 Q $P($G(DATA),"^",$G(PIECE))
CLINNODE(PATIEN,APPTDT,CLINICIEN,NODE,COUNT) ;For a given patient we will find their clinic node in the ^SC file.
 ;   May need to loop through the overbooks on that time.
 ;   PATIEN(I,REQ) - The patient IEN
 ;   APPTDT(I,REQ)  - the appointment date/time in vista format. Found in the ^DPT(<IEN>,"S",<APPTDT> node.
 ;   CLINICIEN(I,REQ)  - clinic record IEN to search through
 ;   NODE(I,REQ) - last node for the clinic. 0 node has appointment info. "C" node has check in/out info.
 ;   COUNT(O,OPT) - subscript # of appointment
 N RET
 ; Loop through the possibly multiple appointments scheduled into this clinic slot
 S COUNT=$$FIND^SDAM2($G(PATIEN),$G(APPTDT),$G(CLINICIEN))
 I $G(COUNT)'="" S RET=$G(^SC($G(CLINICIEN),"S",$G(APPTDT),1,COUNT,$G(NODE)))    ;Get the node from the SC global
 Q $G(RET)
CLINPROV(CLINIC,ARRAY) ;Sets an array filled with clinic provider data
 ;  CLINIC (I,REQ) - The Clinic IEN (first piece of DPT 0 node)
 ;  ARRAY  (O,REQ) - APPTARY("CLINIC PROVIDER",0) - number of providers on the clinic
 ;                   APPTARY("CLINIC PROVIDER",N,"IEN") - Provider IEN
 ;                   APPTARY("CLINIC PROVIDER",N,"NAME") - Name of provider
 N NUM
 K ARRAY
 I $G(CLINIC)="" Q
 S NUM=0
 S ARRAY(0)=0
 F  S NUM=$O(^SC(CLINIC,"PR",NUM)) Q:'NUM  D
 . S ARRAY(NUM,"IEN")=$$PROVIEN(CLINIC,NUM) ;-Provider IEN  File 200
 . I ARRAY(NUM,"IEN")="" Q
 . S ARRAY(NUM,"NAME")=$$GET1^DIQ(200,(ARRAY(NUM,"IEN")),.01) ;- Name of provider File 200
 . S ARRAY(0)=ARRAY(0)+1
 Q
PROVIEN(CLINIC,NODE) ;Returns the Nth provider ID for a Clinic
 ;  CLINIC (I,REQ) - The Clinic IEN (first piece of DPT 0 node)
 ;  NODE (I,REQ)      - The count of the node being examined
 Q $P(^SC($G(CLINIC),"PR",$G(NODE),0),"^",1)
CLINGRP(CLINIC) ;Returns the ID of a Clinic's group
 ;  CLINIC (I,REQ) - The Clinic IEN (first piece of DPT 0 node)
 Q $P(^SC($G(CLINIC),0),"^",31)
 ;---------
 ; DESCRIPTION:
 ; PARAMETERS:
 ;
 ;
 ;---------
APTSTAT(PATIEN,APPTDT,FULLSTAT) ;Returns current computed appointment status which
 ;  includes checked in/out which the "S"0;2 node does not.
 ;   PATIEN (I,REQ)- Patient ID as in DPT(PATIEN,"S",APPTDAT
 ;   APPTDT (I,REQ) - Appointment date
 ;   FULLSTAT (I,OPT,DEFAULT:"") - Set to 1 return full STATUS string
 ; OUTPUT: Appointment current Status values:
 ;               SCHEDULED (Default)
 ;               CHECKED IN
 ;               CHECKED OUT
 ;               CANCELLED
 ;               NO-SHOW
 ;               "" if the appointment does not exist.\
 ;
 N RET,DPT0,CLINICID
 I $G(PATIEN)="" Q ""
 I $G(APPTDT)="" Q ""
 ;
 ;
 S DPT0=$$APPTNODE(PATIEN,APPTDT,0)
 I $G(DPT0)="" Q ""
 ;
 ;CLINIC ID IS FIRST PART OF DPT "S" 0 NODE
 S CLINICID=+$G(DPT0)
 I $G(CLINICID)="" Q ""
 ;
 S RET=$$STATUS^SDAM1(PATIEN,APPTDT,CLINICID,DPT0)
 I '$G(FULLSTAT) D
 . S RET=$P(RET,";",3)     ;PRINT STATUS- NOTE THAT THESE HAVE THE POSSIBILITY OF RETURNING MULTIPLE STATUSES
 . S RET=$S(RET["CANCELLED":"CANCELLED",RET["NO-SHOW":"NO SHOW",RET["CHECKED OUT":"CHECKED OUT",RET["CHECKED IN":"CHECKED IN",1:"SCHEDULED")
 Q RET
 ;
