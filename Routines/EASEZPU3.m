EASEZPU3 ;ALB/AMA - Print utility for 10-10EZ, Version 6 or greater; 10/23/00
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**57**;Mar 15, 2001
 ;
 Q
 ;Split from EASEZP6U
 ;
PAGE1 ;This function retrieves and formats the page 1 application data from
 ;the 1010EZ Holding File, #712, for the printed version of the VistA
 ;10-10EZ form.  If the holding file entry has not been accepted, and
 ;a vista entry is available, the vista entry is printed.
 ;   Called from EN^EASEZP6F
 ;
 ;The ^TMP("EZTEMP") global is built in SETUP^EASEZP6F and
 ;remains until the printed form is complete.
 ; Variables
 ;   ZDATA   - references TMP global for output data
 ;   EZDATA  - references available data from 1010EZ holding file
 ;   EAX     - Temporary data variables
 ;   EACT    - Temporary city variable
 ;
 N ZDATA,EZDATA,EAX,EACT
 ;
 S ZDATA=$NA(^TMP("EASEZ",$J,1))
 S EZDATA=$NA(^TMP("EZTEMP",$J,"I",1))
 ;
 S EAX=$$PROCESS("17.")   ;Covered by health insurance?
 ;EAS*1.0*57 - print full word "UNKNOWN"
 S @ZDATA@(17)=$S(EAX="Y"!(EAX="YES"):"YES",EAX="N"!(EAX="NO"):"NO",EAX="UNKNOWN":"UNKNOWN",1:"")
 ;
 S @ZDATA@("17A")=$$PROCESS("17A.")           ;Insurance company's name
 S @ZDATA@("17B")=$E($$PROCESS("17B."),1,30)  ;Name of policy holder
 S @ZDATA@("17C")=$$PROCESS("17C.")           ;Policy number
 S @ZDATA@("17D")=$$PROCESS("17D.")           ;Group code
 ;
 S EACT="",EACT=$$PROCESS("17F.")             ;Insurance company's city
 I EACT]"" S EACT=EACT_", "   ;if there's a city, add comma & space
 ;Insurance company's street^city, state zip
 S @ZDATA@("17E")=$$PROCESS("17E.")_U_EACT_$$PROCESS("17G.")_" "_$$PROCESS("17H.")
 S @ZDATA@("17I")=$$PROCESS("17I.")           ;Insurance company's phone
 ;
 S EACT="",EACT=$E($$PROCESS("19A.4"),1,30)   ;Next-of-kin's city
 I EACT]"" S EACT=EACT_", "   ;if there's a city, add comma & space
 ;Next-of-kin's name^street^city, state zip^relationship
 S @ZDATA@("19A")=$$PROCESS("19A.1")_U_$E($$PROCESS("19A.3"),1,30)_U_EACT_$$PROCESS("19A.5")_" "_$E($$PROCESS("19A.6"),1,10)_U_$$PROCESS("19A.7")
 S @ZDATA@("19B")=$$PROCESS("19B.1")          ;Next-of-kin's home phone
 S @ZDATA@("19C")=$$PROCESS("19C.1")          ;Next-of-kin's work phone
 ;
 S EACT="",EACT=$E($$PROCESS("20A.4"),1,30)   ;Emergency contact's city
 I EACT]"" S EACT=EACT_", "   ;if there's a city, add comma & space
 ;Emergency contact's name^street^city, state zip^relationship
 S @ZDATA@("20A")=$$PROCESS("20A.1")_U_$E($$PROCESS("20A.3"),1,30)_U_EACT_$$PROCESS("20A.5")_" "_$E($$PROCESS("20A.6"),1,10)_U_$$PROCESS("20A.7")
 S @ZDATA@("20B")=$$PROCESS("20B.1")          ;EC's home phone
 S @ZDATA@("20C")=$$PROCESS("20C.1")          ;EC's work phone
 ;
 S @ZDATA@("21")=$$PROCESS("21.")             ;Who receives property?
 S EAX=$$PROCESS("22A.")                      ;On-the-job injury?
 ;EAS*1.0*57 - print full word "UNKNOWN"
 S @ZDATA@("22A")=$S(EAX="Y"!(EAX="YES"):"YES",EAX="N"!(EAX="NO"):"NO",(EAX="UNKNOWN"):"UNKNOWN",1:"")
 ;
 S EAX=$$PROCESS("22B.")                      ;Accident?
 ;EAS*1.0*57 - print full word "UNKNOWN"
 S @ZDATA@("22B")=$S(EAX="Y"!(EAX="YES"):"YES",EAX="N"!(EAX="NO"):"NO",(EAX="UNKNOWN"):"UNKNOWN",1:"")
 Q
 ;
PAGEI(EAINS) ;  Additional Insurance pages
 ; Called from EN^EASEZP6F
 N ZDATA,EZDATA,EACT
 ;
 S ZDATA=$NA(^TMP("EASEZ",$J,"I",EAINS))
 K @ZDATA
 ;
 ; Process Section IA
 S EZDATA=$NA(^TMP("EZTEMP",$J,"IA",EAINS))
 ;
 S @ZDATA@("17A")=$$PROCESS("17A.")           ;Insurance company's name
 S @ZDATA@("17B")=$E($$PROCESS("17B."),1,30)  ;Name of policy holder
 S @ZDATA@("17C")=$$PROCESS("17C.")           ;Policy number
 S @ZDATA@("17D")=$$PROCESS("17D.")           ;Group code
 S EACT="",EACT=$$PROCESS("17F.")             ;Insurance company's city
 I EACT]"" S EACT=EACT_", "   ;if there's a street, add comma & space
 ;Health insurance company's street^city, state zip
 S @ZDATA@("17E")=$$PROCESS("17E.")_U_EACT_$$PROCESS("17G.")_" "_$$PROCESS("17H.")
 S @ZDATA@("17I")=$$PROCESS("17I.")           ;Insurance company's phone
 ;
 Q
 ;
PAGEN(EADEP) ;  Additional dependent page(s)
 ; Called from EN^EASEZP6F
 N ZDATA,EZDATA,EAX
 ;
 S ZDATA=$NA(^TMP("EASEZ",$J,"D",EADEP))
 K @ZDATA
 ;
 ; Process Section IIB
 S EZDATA=$NA(^TMP("EZTEMP",$J,"IIB",EADEP))
 ;
 S @ZDATA@(2)=$$PROCESS(1.1)                      ;Child's name
 S @ZDATA@(5)=$$PROCESS("3.")                     ;Date of birth
 S @ZDATA@(7)=$$PROCESS("2.")                     ;SSN
 S @ZDATA@(9)=$$PROCESS("4.")                     ;Relationship
 S @ZDATA@(11)=$$PROCESS("5.")                    ;Date of dependency
 ;Amount contributed
 S EAX=$$PROCESS("6."),@ZDATA@(12)=U_$S(EAX="":"",1:$J(EAX,0,2))
 ;Education expenses
 S EAX=$$PROCESS("7."),@ZDATA@(13)=$S(EAX="":"",1:$J(EAX,0,2))
 ;
 S EAX=$$PROCESS("8.")                            ;Permanently disabled?
 ;EAS*1.0*57 - print full word "UNKNOWN"
 S @ZDATA@(14)=$S(EAX="Y"!(EAX="YES"):"YES",EAX="N"!(EAX="NO"):"NO",EAX="UNKNOWN":"UNKNOWN",1:"")
 S EAX=$$PROCESS("9.")                            ;School last year?
 ;EAS*1.0*57 - print full word "UNKNOWN"
 S @ZDATA@(15)=$S(EAX="Y"!(EAX="YES"):"YES",EAX="N"!(EAX="NO"):"NO",EAX="UNKNOWN":"UNKNOWN",1:"")
 ;
 Q
 ;
PROCESS(KEY) ; Process data value from ^TMP("EZTEMP" array
 ;format = IEN ^ EAS DATA ^ ACCEPT VALUE ^ 712 SUBIEN ^ VISTA DATA
 ;Take #712 value from 2nd piece, if it's accepted;
 ;otherwise, take the Patient File value from the 5th piece
 ;
 N EAV,RSLT
 ;
 I '$D(@EZDATA@(KEY)) G PQ
 S EAV=@EZDATA@(KEY)
 S RSLT=$S(+$P(EAV,U,3):$P(EAV,U,2),1:$P(EAV,U,5))
PQ Q $G(RSLT)
