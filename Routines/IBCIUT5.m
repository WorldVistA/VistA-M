IBCIUT5 ;DSI/ESG - UTILITIES FOR CLAIMSMANAGER INTERFACE ;9-MAR-2001
 ;;2.0;INTEGRATED BILLING;**161,210**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Can't call from the top
 Q
 ;
OPENUSE() ;
 ; Function to open and use an available tcp/ip port on the
 ; ClaimsManager server.  This function returns 1 if a port was 
 ; successfully locked, opened, and is being used.  Otherwise, this
 ; function returns 0.  No variables need to be set up before the
 ; call.  Variable IBCISOCK is returned if a port has been opened.
 ; IBCISOCK will not be returned if this utility fails.  IBCISOCK 
 ; is the port number that is being used.
 ;
 ; IO* variables are also returned from the Kernel utility.
 ;
 NEW IBCIIP,POP,PORTLOOK,PORTS,Y
 ;
 ; Get the IP address of the ClaimsManager server.
 ; IP address stored in variable IBCIIP.
 ; IB SITE PARAMETERS file (#350.9), field# 50.05
 ; 
 S IBCIIP=$P($G(^IBE(350.9,1,50)),U,5) I IBCIIP="" S Y=0 G OUXIT
 ;
 ; Build an array of valid and available tcp/ip port numbers
 ; Array name:  PORTS
 ;
 M PORTS=^IBE(350.9,1,50.06,"B") I '$D(PORTS) S Y=0 G OUXIT
 ;
 S PORTLOOK=0,POP=1   ; POP=1 ==> failure | POP=0 ==> success!
AGAIN ;
 S IBCISOCK=""
 F  S IBCISOCK=$O(PORTS(IBCISOCK)) Q:IBCISOCK=""  D  Q:'POP
 . L +^IBCITCP(IBCISOCK):0 E  S POP=1 Q
 . D CALL^%ZISTCP(IBCIIP,IBCISOCK,1) I POP L -^IBCITCP(IBCISOCK) Q
 . Q
 I 'POP S Y=1 G OUXIT
 S PORTLOOK=PORTLOOK+1 I PORTLOOK<6 HANG .5 G AGAIN
 S Y=0 KILL IBCISOCK
OUXIT ;
 Q Y
 ;
 ;
CODER(IBIFN) ; Returns the inpatient/outpatient coder of this bill
 ;
 ;   Input into this function
 ;         IBIFN - ien of the bill/claims file (#399)
 ;
 ;   Output from this function
 ;         A string with the following 3 pieces:
 ;             [1] "O" or "I"  (outpatient/inpatient indicator)
 ;             [2] coder's ien in the new person file (#200)
 ;             [3] coder's name
 ;
 NEW Y,IBD0,OIFLG,PTF,PTF0,CDIEN,CDNM,D1
 NEW DFN,IBDU,BEGDATE,ENDDATE,ENCDT,LSTEDT,IEN,SCE
 ;
 S Y="",IBIFN=+$G(IBIFN)
 S IBD0=$G(^DGCR(399,IBIFN,0))
 I IBD0="" G CODERX
 S OIFLG="O"                                 ; default outpatient
 I $$INPAT^IBCEF(IBIFN) S OIFLG="I"          ; check for inpatient
 S $P(Y,U,1)=OIFLG                           ; at least return the flag
 ;
 ; *** Inpatient Bill Processing ***
 ;     Use the PTF file (#45)
 ;
 I OIFLG="I" D  G CODERX
 . S PTF=+$P(IBD0,U,8)                       ; PTF entry number
 . S PTF0=$G(^DGPT(PTF,0)) Q:PTF0=""         ; check for valid pointer
 . S CDIEN=+$P(PTF0,U,7)                     ; closed out by field
 . S CDNM=$P($G(^VA(200,CDIEN,0)),U,1)       ; try to get the name
 . I CDNM="" D
 .. S D1=$O(^DGPT(PTF,1,99999999),-1) Q:'D1
 .. S CDIEN=+$P($G(^DGPT(PTF,1,D1,0)),U,1)   ; coding clerk field
 .. S CDNM=$P($G(^VA(200,CDIEN,0)),U,1)      ; try to get the name
 .. Q
 . S $P(Y,U,2,3)=CDIEN_U_CDNM                ; save the data
 . Q
 ;
 ; *** Outpatient Bill Processing ***
 ;     Use the Outpatient Encounter file (#409.68)
 ;
 S DFN=$P(IBD0,U,2)                          ; patient ien
 S IBDU=$G(^DGCR(399,IBIFN,"U"))             ; "U" node
 S BEGDATE=$P(IBDU,U,1)                      ; statement covers from
 S ENDDATE=$P(IBDU,U,2)                      ; statement covers to
 ;
 ; If there's a problem with either of these dates, use the event date
 I 'BEGDATE!'ENDDATE S (BEGDATE,ENDDATE)=$P(IBD0,U,3)
 KILL ^TMP($J,"IBCICODER")                   ; kill scratch global
 S ENCDT=$O(^SCE("ADFN",DFN,BEGDATE),-1)     ; get the starting date
 F  S ENCDT=$O(^SCE("ADFN",DFN,ENCDT)) Q:'ENCDT!($P(ENCDT,".",1)>ENDDATE)  D
 . S IEN=0
 . F  S IEN=$O(^SCE("ADFN",DFN,ENCDT,IEN)) Q:'IEN  D
 .. S SCE=$G(^SCE(IEN,"USER"))
 .. I '$P(SCE,U,1) Q                         ; edited last by
 .. I '$P(SCE,U,2) Q                         ; date/time last edited
 .. S ^TMP($J,"IBCICODER",$P(SCE,U,2),IEN)=$P(SCE,U,1)
 .. Q
 . Q
 ;
 I '$D(^TMP($J,"IBCICODER")) G CODERX          ; get out if no hits
 S LSTEDT=$O(^TMP($J,"IBCICODER",""),-1)       ; most recent date
 S IEN=$O(^TMP($J,"IBCICODER",LSTEDT,""),-1)   ; most recent ien
 S CDIEN=^TMP($J,"IBCICODER",LSTEDT,IEN)       ; edited last by field
 S CDNM=$P($G(^VA(200,CDIEN,0)),U,1)           ; try to get the name
 KILL ^TMP($J,"IBCICODER")                     ; clean up scratch global
 S $P(Y,U,2,3)=CDIEN_U_CDNM                    ; save the data
CODERX ;
 Q Y
 ;
 ;
BILLER(IBIFN) ; Returns the entered/edited by person for this bill
 ;
 ;   Input into this function
 ;         IBIFN - ien of the bill/claims file (#399)
 ;
 ;   Output from this function
 ;         A string with the following 2 pieces:
 ;             [1] biller's ien in the new person file (#200)
 ;             [2] biller's name
 ;
 NEW Y
 S IBIFN=+$G(IBIFN)
 S Y=+$P($G(^DGCR(399,IBIFN,"S")),U,2)
 ;
 ; if the POSTMASTER is identified as the biller, then try in file 351.9
 I Y=.5 D
 . S Y=+$P($G(^IBA(351.9,IBIFN,0)),U,5)          ; last sent to CM by
 . I 'Y S Y=+$P($G(^IBA(351.9,IBIFN,0)),U,9)     ; last edited by
 . I 'Y S Y=.5                                   ; postmaster default
 . Q
 ;
 S $P(Y,U,2)=$P($G(^VA(200,Y,0)),U,1)
BILLERX ;
 Q Y
 ;
CMTINFO(IBIFN) ; Comment Information; Username, date/time stamp display
 ;
 ; Returns a line of text in the following format
 ;    "Comment entered by [username] on [date/time]"
 ;
 ; Returns "" if no comments or no pointers
 ;
 NEW Y,IB0,WHEN,USER
 S Y="",IBIFN=+$G(IBIFN)
 I '$D(^IBA(351.9,IBIFN,2)) G CMTINX
 S IB0=$G(^IBA(351.9,IBIFN,0))
 S WHEN=$$EXTERNAL^DILFD(351.9,.13,"",$P(IB0,U,13))
 S USER=$$EXTERNAL^DILFD(351.9,.14,"",$P(IB0,U,14))
 I WHEN="",USER="" G CMTINX
 S Y="Comments last edited by "_USER_" on "_WHEN
CMTINX ;
 Q Y
 ;
TD(IBIFN) ; Terminal digit
 ;
 ;   Input = IBIFN
 ;  Output = A pieced string
 ;           [1] terminal digit of SSN
 ;           [2] SSN
 ;
 NEW Y,DFN,SSN,TD
 S IBIFN=+$G(IBIFN)
 S DFN=+$P($G(^DGCR(399,IBIFN,0)),U,2)
 S SSN=$P($G(^DPT(DFN,0)),U,9)
 S TD="999999999"
 I $L(SSN)'<9 S TD=$E(SSN,8,9)_$E(SSN,6,7)_$E(SSN,4,5)_$E(SSN,1,3)
 S Y=TD_U_SSN
TDX ;
 Q Y
 ;
GETMOD(Z) ; Build a comma delimited string of modifier codes
 ;
 ;   Input: a comma delimited string of modifier ien's
 ;  Output: a comma delimited string of external modifiers
 ;
 NEW IBMOD,I,IEN,MOD
 S IBMOD=""
 I Z="" G GETMODX
 F I=1:1:$L(Z,",") S IEN=$P(Z,",",I) D
 . I IEN="" Q
 . S MOD=$$MOD^ICPTMOD(IEN,"I")
 . I MOD<1 Q
 . I IBMOD="" S IBMOD=$P(MOD,U,2)
 . E  S IBMOD=IBMOD_","_$P(MOD,U,2)
 . Q
GETMODX ;
 Q IBMOD
 ;
DASN(IBIFN) ; Delete the assigned to person field in 351.9
 NEW DIE,DA,DR,%,D,D0,DI,DIC,DQ,X
 S DIE="^IBA(351.9,",DA=IBIFN,DR=".12///@"
 D ^DIE
DASNX ;
 Q
 ;
 ;
ENV() ; This function will return either a "T" for test claim or a "L" for
 ; live claim.  This is the message type of the claim in the Ingenix
 ; interface specs.  This value will be determined based on the value
 ; of IBCISNT and also which VistA environment we are currently in.
 ;
 NEW MSGTYP,MNETNAME,TNM
 S TNM=".TEST.MIR.TST.MIRROR.TRAIN."     ; various test names
 S MSGTYP="T"                            ; assume Test claim
 I $G(IBCISNT)=3 G ENVX                  ; test send to CM
 ;
 ; Check the node name and make sure it exists and is not a test name
 S MNETNAME=$G(^XMB("NETNAME"))
 I MNETNAME="" G ENVX
 I $F(TNM,"."_$P(MNETNAME,".",1)_".") G ENVX
 ;
 S MSGTYP="L"                            ; Otherwise it's a Live claim
ENVX ;
 Q MSGTYP
 ;
