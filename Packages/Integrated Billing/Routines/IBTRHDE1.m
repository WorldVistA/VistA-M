IBTRHDE1 ;ALB/JWS - HCSR Auto Trigger of 278x215 Inquiry ;15-OCT-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
TRIG278 ; Perform 278x215 Inquiry Trigger for Appointments and Admissions
 ; loop through ^IBT(356.22,"AC") index, from today minus (-) HCSR100[1] and [2]
 ; check for only previous requests and/or inquiries that have received a 'pending' response
 ; added field .19 to 356.22 file to indicate that a 215 had been generated for the request/inquiry in order to
 ; prevent duplicates
 ; once entry found, perform copy of request data into new 356.22 entry (use version of IBTRH5C)
 ; need to suppress output of any error results during copy
 ; perform  D EN^IBTRHLO(ien#, 1) to transmit 278x215
 ; 
 N APPTDATE,ADMDATE,IEN,DATA0,IBTRIEN,TDATE,IBFDA
 I $P(HCSR,"^",10) D DT^DILF("","T-"_$P(HCSR,"^",10),.APPTDATE)
 I $P(HCSR,"^",11) D DT^DILF("","T-"_$P(HCSR,"^",11),.ADMDATE)
 I '$G(APPTDATE),'$G(ADMDATE) Q
 I $G(APPTDATE),'$G(ADMDATE) S TDATE=APPTDATE G 1
 I $G(ADMDATE),'$G(APPTDATE) S TDATE=ADMDATE G 1
 S TDATE=$S(APPTDATE<ADMDATE:APPTDATE,1:ADMDATE)
1 ;begin SEARCH and copy and transmit 215 version of 278 authorization message
 S TDATE=TDATE_".999999"
 F  S TDATE=$O(^IBT(356.22,"AC",TDATE),-1) Q:TDATE=""  D
 . S IEN="" F  S IEN=$O(^IBT(356.22,"AC",TDATE,IEN)) Q:IEN=""  S DATA0=$G(^IBT(356.22,IEN,0)) I '$P(DATA0,"^",19) D
 .. I $P(DATA0,"^",13) Q  ;THIS IS A RESPONSE MESSAGE ENTRY
 .. I '$P(DATA0,"^",14) Q  ;NO RESPONSE RECEIVED YET FOR THIS REQUEST/INQUIRY
 .. I $P(DATA0,"^",8)'="07" Q  ;ONLY AUTO-GENERATE 215 FOR PENDING ENTRIES
 .. I $P(DATA0,"^",4)="O",+TDATE>APPTDATE Q
 .. I $P(DATA0,"^",4)="I",+TDATE>ADMDATE Q   ; Perform Inquiry Trigger for Admissions
 .. S IBTRIEN=$$CRTENTRY^IBTRH5C(IEN,$P(DATA0,"^",14),$P(DATA0,"^",3),"",0,"",1) ; create new 356.22 entry for 215 inquiry
 .. I 'IBTRIEN Q  ;COPY FAILED
 .. S IBFDA(356.22,IBTRIEN_",",.2)=1
 .. D FILE^DIE("I","IBFDA","ERROR")
 .. S IBFDA(356.22,IEN_",",.19)=1  ;flag request/inquiry that we have generated a 215
 .. D FILE^DIE("I","IBFDA","ERROR")
 .. D EN^IBTRHLO(IBTRIEN,1)  ;transmit 215
 . Q
 Q
