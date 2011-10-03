BPSOSR2 ;BHAM ISC/FCS/DRS/FLS - Show submit queue ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ; SHOWQ subroutine - continuation of BPSOSRX
SHOWQ ;EP - BPSOSRX
 N ROOT S ROOT="^XTMP(""BPS-PROC"")"
 N COUNT S COUNT=0
 N TYPE,RXI,RXR
 F TYPE="CLAIM","UNCLAIM" D
 . W TYPE
 . I '$D(@ROOT@(TYPE)) W " - none",! Q
 . W ":",!
 . S RXI="" F  S RXI=$O(@ROOT@(TYPE,RXI)) Q:RXI=""  D
 . . S RXR="" F  S RXR=$O(@ROOT@(TYPE,RXI,RXR)) Q:RXR=""  D
 . . . W RXI,",",RXR
 . . . ; details like patient, drug could go here
 . . . W !
 . . . S COUNT=COUNT+1
 . W "Total ",COUNT," ",TYPE W:COUNT'=1 "s"
 . W !
 Q
