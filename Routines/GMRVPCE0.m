GMRVPCE0 ;HIOFO/RM,FT-Data Event Driver for Vitals ;3/7/05  10:34
 ;;5.0;GEN. MED. REC. - VITALS;**8**;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; <None>
 ;
VALIDATE(GMRVDAT) ; Given the array GMRVDAT passed in by PCE Device
 ; Interface (by reference, i.e., D VALIDATE^GMRVPCE0(.ARRAY)), whose
 ; format is described in the PCE Device Interface documentation, this
 ; procedure will validate the Vitals data.  If the data is invalid,
 ; the procedure will return GMRVDAT("ERROR") as described in the PCE
 ; Device Interface documentation.
 ;
 Q:$D(GMRVDAT("ERROR"))
 D PCE^GMRVPCE1(0)
 Q
STORE(GMRVDAT) ; Given vitals data passed in the GMRVDAT array, this
 ; procedure will store that data in the GMRV Patient Measurements
 ; (120.5) file.
 ;
 Q:$D(GMRVDAT("ERROR"))
 D PCE^GMRVPCE1(1)
 Q
HELP(GMRVTYP,GMRVARRY) ; This procedure will return help for a particular
 ; measurement type in an array.
 ;   Input
 ;   Variables:  GMRVTYP=Type of measurement (abbreviation
 ;               (req.)  from PCE Device Interface Specification).
 ;               GMRVARR=Closed array reference of array to return
 ;               (opt.)  help in.  If this variable is not specified,
 ;                       help is returned in ^TMP($J,"GMRVHELP").
 ;
 Q:'$$VMTYPES(GMRVTYP)
 I $G(GMRVARRY)="" S GMRVARRY="^TMP($J,""GMRVHELP"")"
 D HELP^GMRVPCE2(GMRVTYP,GMRVARRY)
 Q
RATECHK(GMRVTYP,GMRVRATE,GMRVUNIT) ; Extrinsic function to validate the
 ; rate for a particular measurement
 ;   Input
 ;   Variables:  GMRVTYP=Type of measurement (abbreviation
 ;               (req.)  from PCE Device Interface Specification).
 ;               GMRVRATE=Measurement rate to be validated.
 ;               (req.)
 ;               GMRVUNIT=Unit of measurement for rate, if specified.
 ;               (opt.)
 ;   Function value:  1 if rate is valid.
 ;                    0 if rate is invalid.
 ;
 N GMRVFXN S GMRVFXN=0
 I $$VMTYPES(GMRVTYP),$G(GMRVRATE)]"" D
 .  I $G(GMRVUNIT)]"" S GMRVRATE=$$UNITRATE^GMRVPCE3(GMRVTYP,GMRVRATE,GMRVUNIT)
 .  I $G(GMRVRATE)]"" S GMRVFXN=$$VALID^GMRVPCE3(GMRVTYP,GMRVRATE)
 .  Q
 Q GMRVFXN
VMTYPES(TYPE) ; This function returns one if TYPE is a valid selection.
 ; from the PCE Device Interface Specification.
 Q "^AUD^BP^HT^TMP^WT^FT^FH^HE^PU^RS^TON^VC^VU^PN^"[(U_TYPE_U)
 ;
