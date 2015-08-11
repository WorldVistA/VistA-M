VPSPRINT ;SLOIFO/BT - Common APIs used for VPS Printing;07/18/14 15:08
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**4**;Jul 18,2014;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External Reference DBIA#
 ; ------------------------
 ; #2171  - $$LKUP^XUAF4       - Supported
 ; #3771  - DEVICE^XUDHGUI     - Supported
 ; #2701  - MPIF001 call       - Supported
 ; #5888  - RPCVIC^DPTLK       - Controlled Sub
 ; #10114 - DEVICE file ^%ZIS(1)     (Supported)
 QUIT
 ;
GETDFN(VPSTYP,VPSNUM) ;Return DFN given Patient ID Type and Value
 ;INPUT
 ;   VPSTYP   Patients ID Type - SSN or DFN OR ICN OR VIC/CAC (REQUIRED) 
 ;   VPSNUM   Parameter Value - patient SSN OR DFN OR ICN OR VIC/CAC (REQUIRED)
 ;RETURN
 ;   DFN        (successful)  OR
 ;   "-1^ERROR" (error/not found)
 ;
 N CM S CM=","
 ;
 QUIT:$G(VPSTYP)="" "-1^TYPE IS REQUIRED (VALID TYPE: SSN, DFN, ICN OR VIC/CAC)"
 QUIT:'$F(",SSN,DFN,ICN,VIC/CAC,",CM_VPSTYP_CM) "-1^INVALID TYPE (VALID TYPE: SSN, DFN, ICN OR VIC/CAC)"
 QUIT:$G(VPSNUM)="" "-1^SSN, DFN, ICN OR VIC/CAC IS REQUIRED"
 ;
 N DFN
 ;
 I VPSTYP="SSN" D 
 . S DFN=$O(^DPT("SSN",VPSNUM,0))
 . I +DFN'>0 S DFN="-1"_U_"NO PATIENT FOUND WITH SSN: "_VPSNUM
 I VPSTYP="DFN" D
 . S DFN=VPSNUM
 . I '$D(^DPT(DFN)) S DFN="-1"_U_"NO PATIENT FOUND WITH DFN: "_VPSNUM
 I VPSTYP="VIC/CAC" D
 . D RPCVIC^DPTLK(.DFN,VPSNUM) ; get DFN given VIC/CAC number - IA 5888
 . S:DFN=-1 DFN="-1^NO DFN FOR VIC/CAC NUMBER"
 I VPSTYP="ICN" D
 . S DFN=$$GETDFN^MPIF001(VPSNUM) ; get DFN given ICN in the Patient file  - IA 2701
 ;
 QUIT DFN
 ;
DEVICE(VPSDEV,FROM,DIR) ; RPC: VPS GET PRINTERS
 ; -- Return up to 20 entries from the Device file based on Input criteria
 ; INPUT
 ;   FROM   : List all printers start from (text to $O from)
 ;            B (all device with name start *WITH* B)
 ;            B* (all device with name start *FROM* B)
 ;   DIR    : Ascending order (1) or Descending order (-1) ($O direction)
 ; OUTPUT
 ;   VPSDEV : By reference local array contains VistA printers based on input criteria
 ;   SYNTAX
 ;            Found     : VPSDEV(0) = 1
 ;                        VPSDEV(1..n)=IEN^Name^DisplayName^Location^RMar^PLen
 ;
 ;            Not Found : VPSDEV(0) = -1^No printers on file
 ;
 K VPSDEV
 S FROM=$G(FROM)
 S DIR=$G(DIR,1)
 D DEVICE^XUDHGUI(.VPSDEV,FROM,DIR)
 I $D(VPSDEV) S VPSDEV(0)=1 ; At least there is one device in the list
 I '$D(VPSDEV) S VPSDEV(0)="-1^No printers on file"
 QUIT
 ;
DEVEXIST(DEVNAME) ;check if DEVNAME exists on file
 ; Returns 1 if found, otherwise returns -1^err message
 QUIT:$G(DEVNAME)="" "-1^NO DEVICE SENT"
 N DIC S DIC="^%ZIS(1,"
 N X S X=DEVNAME
 N Y D ^DIC
 QUIT:$P(Y,U,2)'=DEVNAME "-1"_U_"DEVICE "_DEVNAME_" NOT FOUND"
 QUIT 1
