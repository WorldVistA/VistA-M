PRCAMDS ;ALB/WCJ - Server interface to AR from Austin ;04/11/2011
 ;;4.5;Accounts Receivable;**275**;Mar 20, 1995;Build 72
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; patterned off RCDPESRV
 ;
SERVER ; Entry point for server option to process MDA msgs received from Austin
 ; Mail messages to the MDA mail group should trigger server option PRCA MDA SERVER
 ;
 N PRCAEFLG,PRCAERR,XMER,PRCAXMZ,PRCAFROM
 ;
 ; save the message number into an AR variable
 S PRCAXMZ=$G(XMZ)
 ;
 ; Test to determine if the email came from AUSTIN for production systems(DBIA 1143).
 S PRCAFROM=$P($$NET^XMRENT(PRCAXMZ),U,3)
 I $$PROD^XUPROD,PRCAFROM'["AUSTIN.domain.ext" Q
 ;
 ; get the message and process it
 S PRCAEFLG=$$MSG(PRCAXMZ,.PRCAERR)
 ;
 ; Need to determine if there is anything that needs to be done on errors
 ; initial consensus is no ; below is an example of error handling if we choose to go that route
 ; D:$G(PRCAEFLG) PERROR^RCDPESR1(.RCERR,"G.RCDPE PAYMENTS EXCEPTIONS",RCXMZ)
 ;
 ; Delete server mail msg from postmaster mailbox
 D ZAPSERV^XMXAPI("S.PRCA MDA SERVER",PRCAXMZ)   ;IA#2729
 ;
 Q
 ;
MSG(PRCAXMZ,PRCAERR) ; Read/Store message lines
 ; PRCAXMZ = the # of the Mailman message containing this message
 ; PRCAERR = array of errors
 ; 
 ; OUTPUT:
 ;  Function returns flag ... 0 = no errors    1 = errors
 ;     and the standard Mailman error variable contents of XMER
 ;
 ;  Read the file and process and MDA records and ignore the rest
 ;
 F  X XMREC Q:XMER<0  I $E(XMRG,1,3)="MDA" D PROCESS(XMRG,.PRCAERR)
 ;
MSGQ Q 0
 ;
PROCESS(MDAREC,PRCAERR) ; Process the MDA record.
 ;
 Q:$P(MDAREC,U)'="MDA"
 ;
 N X,DIC,Y,DIE,DR,D0,DA
 N PRCAPTR,PRCADIV,PRCAIEN,PRCADT
 ;
 ; See if we can find the bill number
 ; If so grab some info about the claim.
 S X=$P(MDAREC,U,5)
 Q:X=""
 ;
 S (PRCAPTR,PRCADIV)=""
 S DIC="^PRCA(430,"
 S DIC(0)="BX"
 D ^DIC I Y<1 S Y=""
 I +Y D
 . S PRCAPTR=+Y
 . ;Using ptr since by definition file 399 and 430 are DINUMed
 . S PRCADIV=$P($G(^DGCR(399,PRCAPTR,0)),U,22)   ; DBIA#3820 for accessing division. 
 ;
 ; Get a new IEN by appending quotes to the account number.
 ; Every entry we get will be put in the file.
 ;
 K DIC,X,Y
 S X=""""_$P(MDAREC,U,5)_""""   ; forces a new entry by putting quotes around it (an old Fileman trick)
 ;
 S DIC(0)="LBX"
 S DLAYGO=436.1
 S DIC="^PRCA(436.1,"
 D ^DIC
 S PRCAIEN=+Y
 ;
 ; File the data as best you can
 ; If it's not in the correct format, then skip it.
 K DIC,X,Y
 I $P(MDAREC,U,2)="A" S DR=".02///A"
 S DR=DR_";.03///"_$E($P(MDAREC,U,3),1,19)  ; Subscriber ID
 S DR=DR_";.04///"_$E(($P(MDAREC,U,4)_"    "),1,4)   ; Claim Year
 S DR=DR_";.05///"_$E($P(MDAREC,U,6),1,25)  ; DCN
 S DR=DR_";.06///"_$E((1000000+$P(MDAREC,U,7)),2,7)   ; amount DDDDDCC
 S DR=DR_";.07///"_$E((1000000+$P(MDAREC,U,8)),2,7)   ; amount DDDDDCC
 S PRCADT=$E($P(MDAREC,U,9),5,8)_$E($P(MDAREC,U,9),1,4)
 S DR=DR_";.08///"_PRCADT ; date CCYYMMDD
 S PRCADT=$E($P(MDAREC,U,10),5,8)_$E($P(MDAREC,U,10),1,4)
 S DR=DR_";.09///"_PRCADT ; date CCYYMMDD
 S PRCADT=$E($P(MDAREC,U,11),5,8)_$E($P(MDAREC,U,11),1,4)
 S DR=DR_";.1///"_PRCADT  ; date CCYYMMDD
 I PRCAPTR S DR=DR_";1.01////"_PRCAPTR  ; pointer to 430 if one was found.  Stuff in the ptr to 430.
 S DR=DR_";1.02///0"      ; set status to unreviewed
 I PRCADIV S DR=DR_";1.03///"_PRCADIV  ; pointer to 40.8 if one was found.
 S DA=PRCAIEN
 S DIE="^PRCA(436.1,"
 D ^DIE
 ;
 Q
 ;
