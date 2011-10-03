VSITPUT ;ISD/RJP - Verify/Set Fields and File Visit Record ;7/29/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**76**;Aug 12, 1996
 ; Patch PX*1*76 changes the 2nd line of all VSIT* routines to reflect
 ; the incorporation of the module into PCE.  For historical reference,
 ; the old (VISIT TRACKING) 2nd line is included below to reference VSIT
 ; patches.
 ;
 ;;2.0;VISIT TRACKING;;Aug 12, 1996;
 ;
 ; - verify/set visit record fields
 ; - called by ^VSIT
 ;
 N FLD,FLDINDX,VSITREC
 S FLDINDX=""
 F  S FLDINDX=$O(^TMP("VSITDD",$J,FLDINDX)) Q:FLDINDX=""  D
 . S FLD=^TMP("VSITDD",$J,FLDINDX)
 . S:$P(VSIT(FLDINDX),"^")]"" $P(VSITREC($P(FLD,";",3)),"^",$P(FLD,";",4))=$P(VSIT(FLDINDX),"^")
 ;
 Q:'$D(VSITREC(0))
 ;
 D ^VSITPUT1
 ;
QUIT ; - exit
 Q
ERR(ERR) ; - send error bulletin
 ;     sent at QUIT^VSIT
 ;     mail group = vsit create error
 ;
 D VAR^VSITBUL(ERR)
 Q
 ;
WRN(ERR) ; - send warning bulletin
 ;     sent at QUIT^VSIT
 ;     mail group = vsit create error
 D VAR^VSITBUL(ERR)
 Q
