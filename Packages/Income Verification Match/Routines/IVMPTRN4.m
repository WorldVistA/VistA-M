IVMPTRN4 ;ALB/SEK,TDM - SEND RE-TRANSMISSIONS TO THE IVM CENTER ; 8/15/08 10:29am
 ;;2.0;INCOME VERIFICATION MATCH;**9,11,17,34,66,81,86,115**; 21-OCT-94;Build 28
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine checks STATUS field of IVM TRANSMISSION LOG file (301.6)
 ; to see if acknowledgment of the transmission has been received from
 ; the IVM Center.  If transmission is waiting at the site, a message is
 ; sent to the recipients of the IVM MESSAGES mail group.  Else the
 ; message is re-transmitted to the IVM Center.
 ;
 ;
ENTRY ; Check if message transmission has not been acknowledged for the 
 ; following date range (IVMDMT3 through  IVM14) where:
 ;     IVMDMT3 - First Date Checked
 ;     IVM14   - Last Date Checked
 ;
 S IVMDTM3=$$FMADD^XLFDT(DT,-14),IVM14=$$FMADD^XLFDT(DT,-14)
 S IVMDTMST=+$P($G(^IVM(301.9,1,0)),"^",6)
 S:IVMDTMST<IVM14 IVMDTMST=IVM14
 ;
 ; INITIALIZE HL7 VARIABLES
 N HL,HLEID
 S HLEID="VAMC "_$P($$SITE^VASITE,"^",3)_" ORU-Z07 SERVER"
 S HLEID=$O(^ORD(101,"B",HLEID,0))
 D INIT^IVMUFNC(HLEID,.HL) S HLMTN="ORU" ; Initialize variables for HL7/IVM
 ;
 ; check Transmission Date/Time in AB x-ref
 ; Note 2 oddities about this loop:
 ;   1) Only checks back 2 weeks, if somehow retransmission not done within this window then it won't be done.
 ;   2) Assumes IVMDAT will map to exactly one msgid for HL7 message - assumption made in $$MSGN^IVMPTRN4.
 ;
 S IVMDAT=IVMDTMST F  S IVMDAT=$O(^IVM(301.6,"AB",IVMDAT)) Q:'IVMDAT!($P(IVMDAT,".")>IVMDTM3)  D MAILMSGN
 ;
 ;
 ;transmit remaining records
 D
 .N IVMEVENT
 .; event code for Full Data Transmission
 .S IVMEVENT="Z07"
 .D FILE^IVMPTRN3
 ;
 ;clean-up
 D END^IVMPTRN
 ;
ENTRYQ K IVMDAT,IVMMAILF,IVMDTM3,IVMDTMST,IVM14
 Q
 ;
 ;
MAILMSGN ; Get Mailman message number related to this transmission
 S IVMMAILN=$$MSGN(IVMDAT)  ;returns #773 IEN for v1.6
 ;
 Q:'IVMMAILN                                   ; if no #773 IEN found
 ;
 ; find if awaiting initial transmission
 N SLLN
 S SLLN=+$P($G(^HLMA(IVMMAILN,0)),"^",7)       ; sending logical link
 I SLLN,$D(^HLMA("AC","O",SLLN,IVMMAILN)) D  Q
 .Q:$G(IVMMAILF)  ; already sent message once
 .S XMSUB="MESSAGES 'AWAITING TRANSMISSION'"
 .S IVMTEXT(1)="HL7 message number "_IVMMAILN_" is awaiting transmission."
 .S IVMTEXT(2)="Please call the IVM Center (Atlanta, GA) to ensure the HL7 logical links and filers are running "
 .S IVMTEXT(3)="if the HL7 logical link and filers are running at your station."
 .S IVMTEXT(4)=" "
 .S IVMTEXT(5)="Please note that you may have other messages that are awaiting transmission"
 .S IVMTEXT(6)="to the IVM Center."
 .D MAIL^IVMUFNC()
 .S IVMMAILF=1
 ;
 ; Transmission has left site - get individual patient and re-transmit
 K IVMQUERY("LTD"),IVMQUERY("OVIS") ;Variables needed to open/close last visit date and outpt visit QUERIES
 F IVMDA=0:0 S IVMDA=$O(^IVM(301.6,"AB",IVMDAT,IVMDA)) Q:'IVMDA  D
 .;
 .N IVMTLOG,EVENTS
 .;
 .Q:'$$GET^IVMTLOG(IVMDA,.IVMTLOG)
 .S IVM3015P=IVMTLOG("PAT") Q:'IVM3015P
 .S IVMNODE=$G(^IVM(301.5,+IVM3015P,0)),(IVMDT,IVMIY)=+$P(IVMNODE,"^",2),DFN=+IVMNODE
 .I 'DFN!'IVMDT Q
 .S IVMMTDT=($E(IVMDT,1,3)+1)_"1231.9999"
 .I $E(IVMMTDT,1,3)'=($E(IVMDT,1,3)+1) S IVMMTDT=$E(IVMDT,1,3)+1_"0101"
 .;
 .M EVENTS=IVMTLOG("EVENTS")
 .;
 .; Prepare FULL transmission
 .D FULL^IVMPTRN7(DFN,IVMMTDT,.EVENTS,.IVMCT,.IVMGTOT,,,,.IVMQUERY)
 .;
 .;change status to retransmitted
 .I $$SETSTAT^IVMTLOG(IVMDA,2)
 F Z="LTD","OVIS" I $G(IVMQUERY(Z)) D CLOSE^SDQ(IVMQUERY(Z)) K IVMQUERY(Z)
 Q
 ;
MSGN(IVMDT) ; Find the mailman message number for an HL7 message
 ; Input:   IVMDT  --  The date/time (301.6;.02) the msg was sent
 ; Output:  Pointer to the message in file #773, or zero if not found
 N IVMMSG,X S IVMMSG=0
 S X=+$O(^IVM(301.6,"AB",IVMDT,0)),X=$G(^IVM(301.6,X,0))
 I X S IVMMSG=$$MMN(+$P($P(X,"^",5),"-"))
MSGNQ Q IVMMSG
 ;
MMN(Y) ; Do look-up on file #772 and find mail message number.
 ;  Input:   Y  --  Message Control ID
 ;  Output:  Mail Message Number
 N Z S Z=0
 S Y=$O(^HL(772,"C",Y,0))
 I Y S Z=+$O(^HLMA("B",Y,0))  ;Y=#772 IEN, Z=#773 IEN
MMNQ Q Z
