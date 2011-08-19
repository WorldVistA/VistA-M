IVMPBUL ;BAJ - HL7 Z07 CONSISTENCY CHECKER -- BULLETIN ; 10/20/05 11:48am
 ;;2.0;INCOME VERIFICATION MATCH;**105**;JUL 8,1996;Build 2
 ;
 ; this routine will send a bulletin for a specified condition
 ; 
EN ; entry point
 N DGB,DGTEXT,XMDUZ,XMSUB,DGSM,XMY,XMTEXT
 ;
 ; type          =       Type of Bulletin to send
 ; 
 D CC ; assemble arrays and variables for bulletin
 S DGB=6 D BUL  ; send bulletin and quit
 Q
 ;
CC ; Consistency check bulletin
 ; This bulletin will be sent for Z07 Consistency check process
 ; it indicates the number of records sent and the number not sent
 ; and instructions for further action
 ; 
 N DGSEND,DGSENX,DGTOT,DGC,I,J
 I '$D(^TMP($J,"CC")) Q
 S DGSEND=^TMP($J,"CC",1),DGSENX=^TMP($J,"CC",0),DGTOT=DGSEND+DGSENX
 S XMDUZ="IVM BACKGROUND JOB"
 S XMSUB="HEC INCONSISTENCY TRANSMISSIONS" F I=1:1 S J=$P($T(BT+I),";;",2) Q:J="QUIT"  S DGTEXT(I,0)=J,DGC=I
 S DGC=DGC+1,DGTEXT(DGC,0)=""
 S DGC=DGC+1,DGTEXT(DGC,0)="               Z07 MESSAGES SENT: "_$J(DGSEND,10)
 S DGC=DGC+1,DGTEXT(DGC,0)="           Z07 MESSAGES NOT SENT: "_$J(DGSENX,10)
 S DGC=DGC+1,DGTEXT(DGC,0)=""
 Q
 ;
BT ; ** Bulletin Text -- Line offset is called to assemble message ***
 ;;Following is a summary of the inconsistent data check performed during
 ;;the nightly process to transmit patient data to the HEC.  The number NOT
 ;;SENT, indicates the number of Z07 messages that were not transmitted due
 ;;to data inconsistencies.  These Z07 messages will not be sent until the
 ;;inconsistencies are corrected.  For details, run the Inconsistent Data
 ;;Elements Report in the ADT Outputs Menu.
 ;;
 ;;QUIT
BUL ; create and transmit bulletin
 ;
 N DIC,DIX,DIY,DO,DD
 I '$D(DGB),'$D(XMSUB) Q
 K:$D(DGTEXT) XMTEXT I '$D(DGTEXT)&('$D(XMTEXT)) Q
 S DGB=+$P($G(^DG(43,1,"NOT")),"^",DGB)
 I '$D(^XMB(3.8,DGB,0)) Q
 ;
 ;Protect Fileman from Mailman call
 N DICRREC,DIDATA,DIEFAR,DIEFCNOD,DIEFDAS,DIEFECNT,DIEFF,DIEFFLAG
 N DIEFFLD,DIEFFLST,DIEFFREF,DIEFFVAL,DIEFFXR,DIEFI,DIEFIEN,DIEFLEV
 N DIEFNODE,DIEFNVAL,DIEFOUT,DIEFOVAL,DIEFRFLD,DIEFRLST,DIEFSORK
 N DIEFSPOT,DIEFTMP,DIEFTREF,DIFLD,DIFM,DIQUIET,DISYS,D,D0,DA
 ;
 S XMY("G."_$P($G(^XMB(3.8,DGB,0)),"^",1))="" ; pass mailgroup
 Q:'$D(DUZ)  S:'$D(DGSM) DGSM=1
 S XMTEXT=$S('$D(XMTEXT):"DGTEXT(",1:XMTEXT)
 S:$D(DUZ)#2&(DGSM) XMY(DUZ)="" K:'$D(XMY) DGSM D ^XMD:$D(XMY)
 ;
