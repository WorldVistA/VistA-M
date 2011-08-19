EASEZRPU ;ALB/AMA - Print utility for 10-10EZR ; 8/1/08 1:28pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**57,70**;Mar 15, 2001;Build 26
 ;
 Q
 ;
PAGE1 ;This function retrieves and formats the page 1 application data from
 ;the 1010EZ Holding File, #712, for the printed version of the VistA
 ;10-10EZR form.  If the holding file entry has not been accepted, and
 ;a vista entry is available, the vista entry is printed.
 ;   Called from EN^EASEZRPF
 ;
 ;The ^TMP("EZRTEMP") global is built in SETUP^EASEZRPF and
 ;remains until the printed form is complete.
 ; Variables
 ;   ZDATA   - references TMP global for output data
 ;   EZDATA  - references available data from 1010EZ holding file
 ;   EASTR   - Temporary String data variable
 ;   EAX,EAY - Temporary data variables
 ;   EACT    - Temporary city variable
 ;
 ;THIS ROUTINE WAS COPIED FROM EASEZP6U, AND MODIFIED TO
 ;PROCESS JUST THE DATA ELEMENTS NEEDED FOR THE EZR FORM
 ;
 N ZDATA,EZDATA,EASTR,EAX,EAY,EACT
 ;
 S ZDATA=$NA(^TMP("EASEZR",$J,1))
 S EZDATA=$NA(^TMP("EZRTEMP",$J,"I",1))
 K @ZDATA
 ;
 S @ZDATA@(2)=$$PROCESS(2.1)                 ;Vet's name
 S @ZDATA@(3)=$E($$PROCESS("3."),1,35)       ;Other names used
 S @ZDATA@(4)=$$PROCESS("4.")                ;Gender
 ;
 S @ZDATA@(5)=$$PROCESS("5.")                ;SSN
 S @ZDATA@(7)=$$PROCESS("7.")                ;Date of birth
 S @ZDATA@("9A")=$E($$PROCESS("9A."),1,35)   ;Address
 S @ZDATA@("9B")=$E($$PROCESS("9B."),1,32)   ;City
 S @ZDATA@("9C")=$$PROCESS("9C.")            ;State
 S @ZDATA@("9D")=$$PROCESS("9D.")            ;Zip
 S @ZDATA@("9E")=$$PROCESS("9E.")            ;County
 S @ZDATA@("9F")=$$PROCESS("9F.")            ;Province    - EAS*1.0*70
 S @ZDATA@("9G")=$$PROCESS("9G.")            ;Postal Code - EAS*1.0*70
 S @ZDATA@("9H")=$$PROCESS("9H.")            ;Country     - EAS*1.0*70
 S @ZDATA@(10)=$$PROCESS("10.1")             ;Home phone
 S @ZDATA@("11A")=$$PROCESS("11A.")          ;E-mail
 S @ZDATA@("11G")=$$PROCESS("11A1.")         ;Cell phone number
 S @ZDATA@("11H")=$$PROCESS("11A3.")         ;Pager number
 S @ZDATA@(12)=$$PROCESS("12.")              ;Marital status
 ;
 K EAX
 F EAX="14J","14K","14L" D     ;Medicare eligible, Enrolled in Part A/B?
 . S EAY=$$PROCESS(EAX_".")
 . S @ZDATA@(EAX)=$S(EAY="Y"!(EAY="YES"):"YES",EAY="N"!(EAY="NO"):"NO",EAY="UNKNOWN":"UNKNOWN",1:"")
 ;
 S @ZDATA@("14K1")=$$PROCESS("14K1.")   ;Medicare Part A effective date
 S @ZDATA@("14L1")=$$PROCESS("14L1.")   ;Medicare Part B effective date
 S @ZDATA@("14M")=$$PROCESS("14M.")     ;Medicare claim number
 S @ZDATA@("14N")=$$PROCESS("14N.")     ;Name on Medicare card
 ;
 ;Vet's employment status^Date of retirement
 S @ZDATA@("15A")=$$PROCESS("15A.1")_U_$$PROCESS("15A.2")
 K EAX
 S EAX=$E($$PROCESS("15B.1"),1,30)            ;Company's name
 S EACT="",EACT=$E($$PROCESS("15B.3"),1,30)   ;Company's city
 I EACT]"" S EACT=EACT_", "   ;if there's a city, add comma & space
 ;Company's name^Street^City, State Zip^Phone
 S EAX=EAX_U_$E($$PROCESS("15B.2"),1,30)_U_EACT_$$PROCESS("15B.4")_" "_$E($$PROCESS("15B.5"),1,10)_U_$$PROCESS("15B.6")
 S @ZDATA@("15B")=EAX
 ;
 ;Spouse's employment status^Date of retirement
 S @ZDATA@("16A")=$$PROCESS("16A.1")_U_$$PROCESS("16A.2")
 ;
 K EAX
 S EAX=$E($$PROCESS("16B.1"),1,30)            ;Spouse's company's name
 S EACT="",EACT=$E($$PROCESS("16B.3"),1,30)   ;Spouse's company's city
 I EACT]"" S EACT=EACT_", "    ;if there's a city, add comma & space
 ;Spouse's company's name^Street^City, State Zip^Phone
 S EAX=EAX_U_$E($$PROCESS("16B.2"),1,30)_U_EACT_$$PROCESS("16B.4")_" "_$E($$PROCESS("16B.5"),1,10)_U_$$PROCESS("16B.6")
 S @ZDATA@("16B")=EAX
 ;
 S EAX=$$PROCESS("17.")   ;Covered by health insurance?
 S @ZDATA@(17)=$S(EAX="Y"!(EAX="YES"):"YES",EAX="N"!(EAX="NO"):"NO",EAX="UNKNOWN":"UNKNOWN",1:"")
 ;
 S @ZDATA@("17A")=$$PROCESS("17A.")           ;Insurance company's name
 S @ZDATA@("17B")=$E($$PROCESS("17B."),1,30)  ;Name of policy holder
 S @ZDATA@("17C")=$$PROCESS("17C.")           ;Policy number
 S @ZDATA@("17D")=$$PROCESS("17D.")           ;Group code
 ;
 S EACT="",EACT=$$PROCESS("17F.")             ;Insurance company's city
 I EACT]"" S EACT=EACT_", "    ;if there's a city, add comma & space
 ;Insurance company's street^city, state zip
 S @ZDATA@("17E")=$$PROCESS("17E.")_U_EACT_$$PROCESS("17G.")_" "_$$PROCESS("17H.")
 S @ZDATA@("17I")=$$PROCESS("17I.")           ;Insurance company's phone
 ;
 S EACT="",EACT=$E($$PROCESS("19A.4"),1,30)   ;Next-of-kin's city
 I EACT]"" S EACT=EACT_", "    ;if there's a city, add comma & space
 ;Next-of-kin's name^street^city, state zip^relationship
 S @ZDATA@("19A")=$$PROCESS("19A.1")_U_$E($$PROCESS("19A.3"),1,30)_U_EACT_$$PROCESS("19A.5")_" "_$E($$PROCESS("19A.6"),1,10)_U_$$PROCESS("19A.7")
 S @ZDATA@("19B")=$$PROCESS("19B.1")          ;Next-of-kin's home phone
 S @ZDATA@("19C")=$$PROCESS("19C.1")          ;Next-of-kin's work phone
 ;
 S EACT="",EACT=$E($$PROCESS("20A.4"),1,30)   ;Emergency contact's city
 I EACT]"" S EACT=EACT_", "    ;if there's a city, add comma & space
 ;Emergency contact's name^street^city, state zip^relationship
 S @ZDATA@("20A")=$$PROCESS("20A.1")_U_$E($$PROCESS("20A.3"),1,30)_U_EACT_$$PROCESS("20A.5")_" "_$E($$PROCESS("20A.6"),1,10)_U_$$PROCESS("20A.7")
 S @ZDATA@("20B")=$$PROCESS("20B.1")          ;EC's home phone
 S @ZDATA@("20C")=$$PROCESS("20C.1")          ;EC's work phone
 S @ZDATA@("21")=$$PROCESS("21.")             ;Who receives property?
 ;
 Q
 ;
PAGEI(EAINS) ;  Additional Insurance pages
 ; Called from EN^EASEZRPF
 N ZDATA,EZDATA,EACT
 ;
 S ZDATA=$NA(^TMP("EASEZR",$J,"I",EAINS))
 K @ZDATA
 ;
 ; Process Section IA
 S EZDATA=$NA(^TMP("EZRTEMP",$J,"IA",EAINS))
 ;
 S @ZDATA@("17A")=$$PROCESS("17A.")           ;Insurance company's name
 S @ZDATA@("17B")=$E($$PROCESS("17B."),1,30)  ;Name of policy holder
 S @ZDATA@("17C")=$$PROCESS("17C.")           ;Policy number
 S @ZDATA@("17D")=$$PROCESS("17D.")           ;Group code
 S EACT="",EACT=$$PROCESS("17F.")             ;Insurance company's city
 I EACT]"" S EACT=EACT_", "    ;if there's a street, add comma & space
 ;Health insurance company's street^city, state zip
 S @ZDATA@("17E")=$$PROCESS("17E.")_U_EACT_$$PROCESS("17G.")_" "_$$PROCESS("17H.")
 S @ZDATA@("17I")=$$PROCESS("17I.")           ;Insurance company's phone
 ;
 Q
 ;
PAGEN(EADEP) ;  Additional dependent page(s)
 ; Called from EN^EASEZRPF
 N ZDATA,EZDATA,EAX
 ;
 S ZDATA=$NA(^TMP("EASEZR",$J,"D",EADEP))
 K @ZDATA
 ;
 ; Process Section IIB
 S EZDATA=$NA(^TMP("EZRTEMP",$J,"IIB",EADEP))
 ;
 S @ZDATA@(2)=$$PROCESS(1.1)                      ;Child's name
 S @ZDATA@(5)=$$PROCESS("3.")                     ;Date of birth
 S @ZDATA@(7)=$$PROCESS("2.")                     ;SSN
 S @ZDATA@(9)=$$PROCESS("4.")                     ;Relationship
 S @ZDATA@(11)=$$PROCESS("5.")                    ;Date of dependency
 S EAX=$$PROCESS("6.")                            ;Amount contributed
 S @ZDATA@(12)=U_$S(EAX="":"",1:$J(EAX,0,2))
 S EAX=$$PROCESS("7.")                            ;Education expenses
 S @ZDATA@(13)=$S(EAX="":"",1:$J(EAX,0,2))
 ;
 S EAX=$$PROCESS("8.")                            ;Permanently disabled?
 S @ZDATA@(14)=$S(EAX="Y"!(EAX="YES"):"YES",EAX="N"!(EAX="NO"):"NO",EAX="UNKNOWN":"UNKNOWN",1:"")
 S EAX=$$PROCESS("9.")                            ;School last year?
 S @ZDATA@(15)=$S(EAX="Y"!(EAX="YES"):"YES",EAX="N"!(EAX="NO"):"NO",EAX="UNKNOWN":"UNKNOWN",1:"")
 ;
 Q
 ;
PROCESS(KEY) ; Process data value from EZRTEMP array, take #712 value
 ; if it's accepted, otherwise take the Patient File value
 ;
 N EAV,RSLT
 ;
 I '$D(@EZDATA@(KEY)) G PQ
 S EAV=@EZDATA@(KEY)
 S RSLT=$S(+$P(EAV,U,3):$P(EAV,U,2),1:$P(EAV,U,5))
PQ Q $G(RSLT)
