EASEZP6U ;ALB/AMA - Print utility for 10-10EZ, Version 6 or greater; 10/23/00
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**51,60,57,70**;Mar 15, 2001;Build 26
 ;
 Q
 ;Parts of this routine were copied from EASEZPU (the other parts are
 ;in EASEZPU2); if the version # of the 1010EZ application is 6.0 or
 ;greater, then this routine will be executed.
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
 ;   EASTR   - Temporary String data variable
 ;   EAX,EAY - Temporary data variables
 ;   EACT    - Temporary city variable
 ;
 N ZDATA,EZDATA,EASTR,EAX,EAY,EACT
 ;
 S ZDATA=$NA(^TMP("EASEZ",$J,1))
 S EZDATA=$NA(^TMP("EZTEMP",$J,"I",1))
 K @ZDATA
 ;
 ;Type Of Benefits Applied For
 S EASTR="" F EAX="1A.1","1A.2","1A.3","1A.4","1A.5" D
 . I $$PROCESS(EAX)="UNKNOWN" S EASTR="UNKNOWN, ",EAX="1A.5" Q
 . I $$PROCESS(EAX)="YES" S EASTR=EASTR_$$BENEFIT(EAX)_", "
 S @ZDATA@("1A")=$E(EASTR,1,($L(EASTR)-2))   ;remove last comma & space
 ;
 S @ZDATA@("1B")=$$PROCESS("1B.")            ;Which facility?
 S @ZDATA@(2)=$$PROCESS(2.1)                 ;Vet's name
 S @ZDATA@(3)=$E($$PROCESS("3."),1,35)       ;Other names used
 S EAX=$E($$PROCESS("3A."),1,35)             ;Mother's maiden name
 I $E(EAX,$L(EAX))="," S EAX=$E(EAX,1,$L(EAX)-1)
 S @ZDATA@("3A")=EAX
 S @ZDATA@(4)=$$PROCESS("4.")                ;Gender
 ;
 S EAX=$$PROCESS("4A.")   ;Are You Spanish, Hispanic, or Latino?
 ;EAS*1.0*57 - print full word "UNKNOWN"
 S @ZDATA@("4A")=$S($E(EAX)="Y"!($E(EAX,1,3)="YES"):"YES",$E(EAX)="N"!($E(EAX,1,3)="NO"):"NO",$E(EAX,1,7)="UNKNOWN":"UNKNOWN",1:"")
 ;
 F EAX="4B","4C","4D","4E","4F","4G" D       ;Race
 . I $E($$PROCESS(EAX_"."),1,3)="YES" S @ZDATA@(EAX)=" X " I 1
 . E  S @ZDATA@(EAX)="___"
 ;
 S @ZDATA@(5)=$$PROCESS("5.")                ;SSN
 S @ZDATA@(6)=$$PROCESS("6.")                ;Claim number
 S @ZDATA@(7)=$$PROCESS("7.")                ;Date of birth
 S @ZDATA@(8)=$$PROCESS("8.")                ;Religion
 S EAX=$$PROCESS("8A."),EAY=$$PROCESS("8B.") ;Birth place city & state
 I (EAX]""),(EAY]"") S @ZDATA@("8A")=EAX_", "_EAY
 E  S @ZDATA@("8A")=$S(EAX]"":EAX,EAY]"":EAY,1:"")
 S @ZDATA@("9A")=$E($$PROCESS("9A."),1,35)   ;Address
 S @ZDATA@("9B")=$E($$PROCESS("9B."),1,32)   ;City
 S @ZDATA@("9C")=$$PROCESS("9C.")            ;State
 S @ZDATA@("9D")=$$PROCESS("9D.")            ;Zip
 S @ZDATA@("9E")=$$PROCESS("9E.")            ;County
 S @ZDATA@("9F")=$$PROCESS("9F.")            ;Province    - EAS*1.0*70
 S @ZDATA@("9G")=$$PROCESS("9G.")            ;Postal Code - EAS*1.0*70
 S @ZDATA@("9H")=$$PROCESS("9H.")            ;Country     - EAS*1.0*70
 S @ZDATA@(10)=$$PROCESS("10.1")             ;Home phone
 S @ZDATA@(11)=$$PROCESS("11.1")             ;Work phone
 S @ZDATA@("11A")=$$PROCESS("11A.")          ;E-mail
 S @ZDATA@("11B")=$$PROCESS("11B.")          ;Want an appt?
 S @ZDATA@("11C")=$$PROCESS("11C.")          ;Been seen before?
 S @ZDATA@("11D")=$$PROCESS("11D.")          ;Location seen before
 ;
 ;EAS*1.0*60 -- add cell phone and pager
 S @ZDATA@("11G")=$$PROCESS("11A1.")         ;Cell phone number
 S @ZDATA@("11H")=$$PROCESS("11A3.")         ;Pager number
 ;
 S @ZDATA@(12)=$$PROCESS("12.")              ;Marital status
 S @ZDATA@("13A")=$$PROCESS("13A.")          ;Last branch of service
 S @ZDATA@("13B")=$$PROCESS("13B.")          ;Last entry date
 S @ZDATA@("13C")=$$PROCESS("13C.")          ;Last discharge date
 S @ZDATA@("13D")=$$PROCESS("13D.")          ;Discharge type
 S @ZDATA@("13E")=$$PROCESS("13E.")          ;Military service number
 ;
 F EAX="14A1","14A2","14B","14B2","14D3","14D4","14E","14F","14G","14G1","14I","14J","14K","14L" D
 . S EAY=$$PROCESS(EAX_".")
 . ;EAS*1.0*57 - no room on form here to print full word "UNKNOWN"
 . S @ZDATA@(EAX)=$S(EAY="Y"!(EAY="YES"):"YES",EAY="N"!(EAY="NO"):"NO",EAY="UNKNOWN":"UNK",1:"")
 ;
 S @ZDATA@("14B1")=$$PROCESS("14B1.")   ;Rated percentage
 S @ZDATA@("14K1")=$$PROCESS("14K1.")   ;Medicare Part A effective date
 S @ZDATA@("14L1")=$$PROCESS("14L1.")   ;Medicare Part B effective date
 S @ZDATA@("14M")=$$PROCESS("14M.")     ;Medicare claim number
 S @ZDATA@("14N")=$$PROCESS("14N.")     ;Name on Medicare card
 ;Vet's employment status^Date of retirement
 S @ZDATA@("15A")=$$PROCESS("15A.1")_U_$$PROCESS("15A.2")
 ;
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
 S EAX=$E($$PROCESS("16B.1"),1,30)            ;Spouse's company's name
 S EACT="",EACT=$E($$PROCESS("16B.3"),1,30)   ;Spouse's company's city
 I EACT]"" S EACT=EACT_", "   ;if there's a city, add comma & space
 ;Spouse's company's name^Street^City, State Zip^Phone
 S EAX=EAX_U_$E($$PROCESS("16B.2"),1,30)_U_EACT_$$PROCESS("16B.4")_" "_$E($$PROCESS("16B.5"),1,10)_U_$$PROCESS("16B.6")
 S @ZDATA@("16B")=EAX
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
 ;
BENEFIT(X) ; Return External format of benefit applied for
 ;
 Q $S(X="1A.1":"HEALTH SERVICES",X="1A.2":"NURSING HOME",X="1A.3":"DOMICILIARY",X="1A.4":"DENTAL",X="1A.5":"ENROLLMENT",1:"")
