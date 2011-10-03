VSITCK ;ISD/RJP - Visit Field Check ;6/20/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**76**;Aug 12, 1996
 ; Patch PX*1*76 changes the 2nd line of all VSIT* routines to reflect
 ; the incorporation of the module into PCE.  For historical reference,
 ; the old (VISIT TRACKING) 2nd line is included below to reference VSIT
 ; patches.
 ;
 ;;2.0;VISIT TRACKING;;Aug 12, 1996;
 ;
 Q  ; - not an entry point
 ;
ERRCHK(NODE,VALUE,DATEFMT) ;Checks the value to see if it is valid
 ;Returns:
 ;   value if it is valid
 ;   null in the first piece if it is not valid
 ;     and the error message form VSITFLD if there is one
 ;
 S NODE=$G(NODE)
 S VALUE=$G(VALUE)
 N ERR
 I $P($G(^TMP("VSITDD",$J,NODE)),";",5)]"" S ERR="^"_$P(^TMP("VSITDD",$J,NODE),";",1)_"^"_VALUE_"^"_$P(^TMP("VSITDD",$J,NODE),";",5)
 E  S ERR=""
 S VALUE=$G(VALUE)
 S:VALUE]"" VALUE=$$GET^VSITVAR(NODE,VALUE,"",$G(DATEFMT))
 S:VALUE']"" VALUE=ERR
 Q VALUE
 ;
SETALL ;Do $GET on all of the nodes of the VSIT array
 N FLDINDX
 S FLDINDX=""
 F  S FLDINDX=$O(^TMP("VSITDD",$J,FLDINDX)) Q:FLDINDX=""  D
 . S VSIT(FLDINDX)=$G(VSIT(FLDINDX))
 S VSIT(0)=$G(VSIT(0))
 Q
 ;
