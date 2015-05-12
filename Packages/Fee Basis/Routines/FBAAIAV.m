FBAAIAV ;ALB/FA - VIEW AN IPAC AGREEMENT ;03 Dec 2013  2:11 PM
 ;;3.5;FEE BASIS;**123**;JAN 30, 1995;Build 51
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
 ;-----------------------------------------------------------------------------
 ;                           Entry Points
 ; ISEL     - Select and View a specified IPAC Vendor Agreement
 ;            NOTE: (actually called from first line of routine)
 ; VIEW1    - View the specified IPAC Vendor Agreement
 ;-----------------------------------------------------------------------------
 ;                         
ISEL ;EP
 ; Select and View a specified IPAC Vendor Agreement
 N XX,YY
 F  D  Q:XX=""
 . S XX=$$ISEL1()
 . Q:XX=""
 . R !,"Press any key to continue: ",YY:DTIME
 Q
 ;
ISEL1() ;
 ; Input:       None
 ; Returns:     1 - User timed out or typed '^' to exit, 0 otherwise
 ; Called From: ISEL
 N FLINE,STEXT,VAIEN
 S FLINE="The following IPAC Agreements are currently on file:"
 S STEXT="Please select the IPAC agreement to view/print"
 S VAIEN=$$SELVA^FBAAIAU(FLINE,STEXT,0,"")        ; Select an IPAC Agreement
 I VAIEN="" Q ""                                  ; User exit
 D VIEW(VAIEN)
 Q 0
 ;
VIEW(VAIEN) ; Select a display device and display the specified
 ; IPAC Vendor Agreement
 ; Input:   VAIEN       - IPAC Vendor Agreement IEN of agreement to be displayed
 ; Output:  IPAC Vendor Agreement displayed to the selected device
 D DEVSEL(VAIEN)                                ; Device Selection
 Q
 ;
DEVSEL(VAIEN) ; Device selection and queuing
 ; Input:       VAIEN       - IPAC Vendor Agreement IEN of agreement to be viewed
 ; Returns:     1 - Device selected, 
 ;              0 - No device selected or queued task
 N POP,ZTDESC,ZTRTN,ZTSAVE
 W !!,"This report is 80 characters wide.",!
 S ZTRTN="VIEW1^FBAAIAV"
 S ZTDESC="View/Print IPAC Vendor Agreement"
 S ZTSAVE("VAIEN")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"QM")
 Q
 ;
VIEW1 ;EP
 ; Displays the selected IPAC Vendor Agreement
 ; Input:   VAIEN       - IPAC Vendor Agreement IEN of agreement to be displayed
 ; Output:  IPAC Vendor Agreement displayed to screen or print device
 D VADISP^FBAAIAU(VAIEN,1)
 Q
