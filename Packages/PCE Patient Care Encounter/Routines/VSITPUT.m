VSITPUT ;ISD/RJP - Verify/Set Fields and File Visit Record ;Aug 04, 2025@08:53:48
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**76,244**;Aug 12, 1996;Build 37
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
 I +$D(^TMP("PXK",$J,"VST",1,900,"AFTER")) D
 . N IND S IND=0
 . F  S IND=+$O(^TMP("PXK",$J,"VST",1,900,"AFTER",IND)) Q:IND=0  D
 .. S VSITREC(900,IND,0)=^TMP("PXK",$J,"VST",1,900,"AFTER",IND,0)
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
