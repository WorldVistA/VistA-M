DGPFLMT5 ;ALB/RBS - PRF TRANSMIT REJECT MESSAGE PROCESSING ; 7/12/06 09:30am
 ;;5.3;Registration;**650**;Aug 13, 1993;Build 3
 ;
 ;no direct entry
 QUIT
 ;
 ;
EN(DGVALMY) ;Entry point to retransmit rejected messages
 ;This function will retransmit all user selected "RJ" Rejected status
 ;entries of the PRF HL7 TRANSMISSION LOG (#26.17) file to the
 ;Treating Facility that rejected it.
 ;
 ;   Input:
 ;       DGVALMY - VALMY array of user selections, pass by reference
 ;
 ;  Output:
 ;       Function value - 1 on success, 0 on failure
 ;
 ;- Use the 0 node sort file for all retransmission processing:
 ;  ^TMP("DGPFSORT",$J,0,<assignment ien>,<site ien>,<HL7 log ien>)=""
 ;  Each patient's PRF Assignment record is grouped with all of the
 ;  Treating Facilities that logged a rejected HL7 transmission entry.
 ;
 N DGAIEN   ;assignment ien
 N DGFAC    ;destination station number
 N DGHLIEN  ;loop var
 N DGNODE   ;"IDX" data string
 N DGRSLT   ;function value
 N DGSEL    ;user selection
 N DGSITE   ;site transmitted to ien
 ;
 ;set screen to full scroll region
 D FULL^VALM1
 W !
 ;
 ;- Use the "IDX" selection entry to get the assignment info
 ;  <assignment ien>^<site ien>^<HL7 log ien>^<patient dfn>^<patient name>^<site name>
 ;
 S DGRSLT=0
 I $O(DGVALMY(""))'="" D
 . S DGSEL=0
 . F  S DGSEL=$O(DGVALMY(DGSEL)) Q:'DGSEL  D
 . . S DGNODE=$G(^TMP("DGPFLMT",$J,"IDX",DGSEL,DGSEL))
 . . Q:'DGNODE
 . . S DGAIEN=$P(DGNODE,U,1)
 . . Q:'DGAIEN
 . . S DGSITE=$P(DGNODE,U,2)
 . . Q:'DGSITE
 . . ;
 . . ;- retransmit assignment -
 . . ;  display patient name and site transmitted to failure & success
 . . ;
 . . I '$$XMIT(DGAIEN,DGSITE) D  Q
 . . . W !,">>>",?5,DGSEL,". ",$P(DGNODE,U,5),"...failed to retransmit to...",$P(DGNODE,U,6)
 . . E  W !?5,DGSEL,". ",$P(DGNODE,U,5),"...was retransmitted to...",$P(DGNODE,U,6)
 . . ;
 . . ;- Now set all of the Assignment's HL7 transmission log entry's
 . . ;  to "RT" RE-TRANSMITTED status.
 . . ;- loop ^TMP("DGPFSORT",$J,0,DGAIEN,DGSITE,n) nodes
 . . S DGHLIEN=0
 . . F  S DGHLIEN=$O(^TMP("DGPFSORT",$J,0,DGAIEN,DGSITE,DGHLIEN)) Q:'DGHLIEN  D
 . . . ;- update HL7 transmission log entry status
 . . . ;
 . . . D STOSTAT^DGPFHLL(26.17,DGHLIEN,"RT")
 . . ;
 . . S DGRSLT=1
 ;
 Q DGRSLT
 ;
XMIT(DGAIEN,DGSITE) ;call out to retransmit
 ;This function is used to call the PRF (ORU~R01) function to transmit
 ;a patient's Assignment record and all History records to a single
 ;Treating Facility.
 ;
 ;  Supported DBIA #2171:  $$STA^XUAF4
 ;    This supported DBIA is used to access the Kernel API to convert
 ;    a station number to an INSTITUTION (#4) file IEN.
 ;
 ;   Input: (required)
 ;       DGAIEN - assignment ien
 ;       DGSITE - site transmitted to ien
 ;
 ;  Output:
 ;       Function value - 1 on success, 0 on failure
 ;
 N DGFAC    ;destination station number array
 N DGHIENS  ;array of assignment history ien's
 N DGRSLT   ;function value
 S DGRSLT=0
 ;
 I +$G(DGAIEN)>0 D
 . K DGFAC,DGHIENS
 . ;
 . ;convert institution# to station#
 . S DGFAC(1)=$$STA^XUAF4(DGSITE)
 . Q:'DGFAC(1)
 . ;
 . ;get all assignment history ien's
 . Q:'$$GETALLDT^DGPFAAH(DGAIEN,.DGHIENS)
 . ;
 . ;build and transmit the new message
 . Q:'$$SNDORU^DGPFHLS(DGAIEN,.DGHIENS,.DGFAC)
 . ;
 . S DGRSLT=1
 ;
 Q DGRSLT
