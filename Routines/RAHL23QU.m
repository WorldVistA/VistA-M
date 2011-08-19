RAHL23QU ;HINES OIFO/GJC query message/event type utilities
 ;;5.0;Radiology/Nuclear Medicine;**78**;Mar 16, 1998;Build 5
 ;
 ;Integration Agreements
 ;----------------------
 ;$$STARTMSG^HLOPRS(4718), XMD(10070)
 ;
INIT ;initialize variables
 ;RADTE, RAY3 defined in RAHL23Q
 S RAZDAYCS=$E(RADTE,4,7)_$E(RADTE,2,3)_"-"_+RAY3,RAZPRC=+$P(RAY3,U,2)
 S RAZPIMG=+$P($G(^RAMIS(71,RAZPRC,0)),U,12),RAZPIMG=$P($G(^RA(79.2,RAZPIMG,0)),U)
 S RAZPRC(0)=$G(^RAMIS(71,+RAZPRC,0)),RAZCPT=+$P(RAZPRC(0),U,9)
 S RAZCPT(0)=$$NAMCODE^RACPTMSC(RAZCPT,DT)
 Q
 ;
GETFLD(SEG,FLD) ;get the data from a particular HL7 segment.
 ;Input : SEG - Array with the segment header and first field separator included.
 ;              SEG is either the lead segment or in the case that the segment is
 ;              over 245 characters in length, all of the sibling segments.
 ;      : FLD - Get data from a HL7 specific field
 ;Output: XDX - Return data from a specific HL7 field
 ;HLFS=fld separator is required
 Q:FLD'>0 ""
 N SUB,XDX S SUB=$O(SEG(0))
 I SUB D
 .;since the header in included in the string the true piece on the string 
 .;to be returned is offset by one. Take this into account by adding one to
 .;FLD (FLD=FLD+1)  
 .N HDR,LEN,X S FLD=FLD+1
 .S X=$G(SEG(SUB)),HDR=$E(X,1,3),LEN=$L(X,HLFS)
 .I FLD<LEN S XDX=$P(X,HLFS,FLD) Q
 .I FLD=LEN S XDX=$P(X,HLFS,FLD) D  Q
 ..;is there a sibling segment? If so the 1st piece
 ..;of that segment is part of the data.
 ..N SUB2 S SUB2=$O(SEG(SUB,0)) Q:'SUB2
 ..S XDX=XDX_$P(SEG(SUB,SUB2),HLFS)
 ..Q
 .;
 .E  D  ;the field requested is on a sibling segment.
 .;The initial segment has 'LEN' pieces. Check the sibling
 .;segments. Remember that each sibling segment might not
 .;break cleanly on a field separator.
 .N SUB2,X S SUB2=0 F  S SUB2=$O(SEG(SUB,SUB2)) Q:'SUB2  D  Q:$D(XDX)#2
 ..;
 ..;define X - we need to strip off any partial field data that would
 ..;throw off our # of fields count.
 ..;
 ..;if X=data1_FS_data2_FS... set X=data2_FS...
 ..;if X=FS_data1_FS_data2_FS... set X=data1_FS_data2_FS...
 ..;
 ..S X=$G(SEG(SUB,SUB2)),X=$E(X,$F(X,HLFS),$L(X)) ;discard all char left
 ..;of the field separator including the field separator.
 ..;
 ..;with each sibling segment we add to the total number of fields
 ..;(LEN+NEWLEN) checked. The result of the HL7 field we require data
 ..;from subtracted from the total number of fields checked indicates
 ..;the piece (Y) on the current string that we're after. 
 ..S NEWLEN=$L(X,HLFS),Y=FLD-LEN
 ..I Y'>NEWLEN D
 ...S XDX=$P(X,HLFS,Y) Q:Y<NEWLEN
 ...;do we want the last piece of the current segment
 ...;(Y=NEWLEN)? is there another sibling segment?
 ...;If so the 1st piece of that segment is part of the data.
 ...N SUB3 S SUB3=$O(SEG(SUB,SUB2)) Q:'SUB3
 ...S XDX=XDX_$P(SEG(SUB,SUB3),HLFS)
 ...Q
 ..S LEN=LEN+NEWLEN
 ..Q
 .Q
 Q $S($D(XDX)#2:XDX,1:"")
 ;
ACCEPT ;Come here when a accept ack is received from the vendor.
 ;Send an email message to the local HL7 mail group if the response
 ;from the receiving system is not a Accept Acknowledgment ("CA").
 ;
 ;Note: The mail group must be populated and Postmaster must be
 ;a member of the mail group in order for messages to flow.
 ;
 ;Input : HLMSGIEN & HLMSTATE are defined globally
 ;Output: RASEG ($$NEXTSEG^HLOPRS) is the HL7 segment broken out
 ;        by field components
 ;  
 N RAERR,RAFS,RAMSA,RAMSH,RASEG
 ;
 ;RAERR is the error flag. Two parts: first piece is the error indicator which is Boolean.
 ;One for an error; zero for no error. If error; error text can be found in the second piece
 ;RAERR. RAERR has a default value that indicates an error is present.
 S RAERR=1
 ;
 I '$$STARTMSG^HLOPRS(.HLMSTATE,HLMSGIEN,.RAMSH) D  D CAERR QUIT
 .S $P(RAERR,U,2)="The commit acknowledgment message cannot be evaluated." Q
 ;
 ;where RAFS  = HLMSTATE("HDR","FIELD SEPARATOR")=field_separator (usually the "|" or "^")
 ;where RAMSA = HLMSTATE("STATUS","ACCEPT ACK MSA")=MSA|CA|message_id
 ;
 S RAFS=$G(HLMSTATE("HDR","FIELD SEPARATOR")),RAMSA=$G(HLMSTATE("STATUS","ACCEPT ACK MSA"))
 ;
 S:$P(RAMSA,RAFS,2)="CA" RAERR=0
 Q:RAERR=0
 ;
 ;We're missing the "CA"; set RAERR to the correct error text and email the users.
 ;
 S $P(RAERR,U,2)="The inbound HL7 message is not a successful commit acknowledgment."
 ;
CAERR ;Come here on an error (+RAERR>0). This function will send an email
 ;to a local MailMan group if MSA-1 didn't exist or was not set to "CA".
 ;
 N DIFROM,RATXT S XMSUB="VistA teleradiology (RA) HL7 error",XMDUZ=.5
 S RATXT(1)="VistA Radiology NTP HL7 message notification event."
 S RATXT(2)=" "
 S RATXT(3)="HL7 Message ID: "_$G(RAMSH("MESSAGE CONTROL ID"),"Unknown")
 S RATXT(4)="VistA global root w/IEN = ^HLB("_$G(HLMSGIEN,"Unknown")
 S RATXT(5)=" "
 S RATXT(6)="Error: "_$P($G(RAERR),U,2)
 S XMY("G.RAD HL7 MESSAGES")="",XMTEXT="RATXT("
 D ^XMD K XMSUB,XMY,XMTEXT,XMZ,XMDUZ QUIT
 ;
