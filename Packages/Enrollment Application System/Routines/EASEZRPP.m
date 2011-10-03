EASEZRPP ;ALB/AMA - Print utility for 10-10EZR, Part 2
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**57**;Mar 15, 2001
 ;
 Q
 ;
PAGE2 ;Retrieve page 2 data and format for output on 10-10EZR form
 ;   Called from EN^EASEZRPF
 ;
 ;Variables
 ;   ZDATA         - references TMP global for output data
 ;   EZDATA        - references available data from 1010EZ holding file
 ;   EACT          - Temporary city variable
 ;   EAX, EAY      - temporary storage variables
 ;   EAV, EAS, EAC - temp storage for vet, spouse, and child variables
 ;
 N ZDATA,EZDATA,EACT,EAX,EAY,EAV,EAS,EAC
 ;
 S ZDATA=$NA(^TMP("EASEZR",$J,2))
 K @ZDATA
 ;
 ; Process Section IIA - Dependent Info
 S EZDATA=$NA(^TMP("EZRTEMP",$J,"IIA",1))
 ;
 ;Spouse's name^maiden name
 S @ZDATA@(1)=$$PROCESS(1.1)_U_$$PROCESS(1.5)
 S @ZDATA@(2)=$$PROCESS(2.1)        ;Child 1's name
 S @ZDATA@(3)=$$PROCESS("3.")       ;Spouse's SSN
 S @ZDATA@(4)=$$PROCESS("4.")       ;Spouse's date of birth
 S @ZDATA@(5)=$$PROCESS("5.")       ;Child 1's date of birth
 S EACT="",EACT=$$PROCESS(6.2)      ;Spouse's city
 I EACT]"" S EACT=EACT_", "   ;if there's a city, add comma & space
 ;Spouse's street^city, state zip
 S @ZDATA@(6)=$$PROCESS(6.1)_U_EACT_$$PROCESS(6.3)_" "_$$PROCESS(6.4)
 ;
 S @ZDATA@(7)=$$PROCESS("7.")       ;Child 1's SSN
 S @ZDATA@(8)=$$PROCESS(8.1)        ;Spouse's phone
 S @ZDATA@(9)=$$PROCESS("9.")       ;Child 1's relationship
 S @ZDATA@(10)=$$PROCESS("10.")     ;Date of marriage to spouse
 S @ZDATA@(11)=$$PROCESS("11.")     ;Date Child 1 became dependent
 ;
 S EAX=$$PROCESS(12.1)              ;Amount contributed to spouse
 S EAY=$$PROCESS(12.2)              ;Amount contributed to Child 1
 S @ZDATA@(12)=$S(EAX="":"",1:$J(EAX,0,2))_U_$S(EAY="":"",1:$J(EAY,0,2))
 ;
 S @ZDATA@(13)=$$PROCESS("13.")     ;Educational expenses for Child 1
 S @ZDATA@(13)=$S(@ZDATA@(13)="":"",1:$J(@ZDATA@(13),0,2))
 ;
 S EAX=$$PROCESS("14.")             ;Child 1 disabled?
 I (EAX=""),(@ZDATA@(2)]"") S EAX="UNKNOWN"
 I @ZDATA@(2)']"" S EAX=""
 S @ZDATA@(14)=$S(EAX="Y"!(EAX="YES"):"YES",EAX="N"!(EAX="NO"):"NO",EAX="UNKNOWN":"UNKNOWN",1:"")
 S EAX=$$PROCESS("15.")             ;Child 1 attend school last year?
 I (EAX=""),(@ZDATA@(2)]"") S EAX="UNKNOWN"
        I @ZDATA@(2)']"" S EAX=""
 S @ZDATA@(15)=$S(EAX="Y"!(EAX="YES"):"YES",EAX="N"!(EAX="NO"):"NO",EAX="UNKNOWN":"UNKNOWN",1:"")
 ;
 ; Process Section IIC - Previous Calendar Year Gross Annual Income
 S EZDATA=$NA(^TMP("EZRTEMP",$J,"IIC",1))
 S EAV=$$PROCESS(1.4),EAS=$$PROCESS(1.5)     ;Vet & spouse gross income
 S @ZDATA@("2C1")=$S(EAV="":"",1:$J(EAV,0,2))_U_$S(EAS="":"",1:$J(EAS,0,2))
 S EAV=$$PROCESS(2.1),EAS=$$PROCESS(2.2)     ;Vet & spouse other income
 S @ZDATA@("2C2")=$S(EAV="":"",1:$J(EAV,0,2))_U_$S(EAS="":"",1:$J(EAS,0,2))
 S EAV=$$PROCESS(3.1),EAS=$$PROCESS(3.2)     ;Vet & spouse net income
 S @ZDATA@("2C3")=$S(EAV="":"",1:$J(EAV,0,2))_U_$S(EAS="":"",1:$J(EAS,0,2))
 ;
 S @ZDATA@(999)=$$PROCESS(999)               ;Vet income year
 I $D(@EZDATA@(998)) D
 . S @ZDATA@(998)=$$PROCESS(998)             ;Vet Declines To Give Info
 ;
 ;Since Child amounts in Section IIC are for ALL dependents,
 ;get just Child 1 amounts from Section IIF - Dependent Gross Incomes
 S EZDATA=$NA(^TMP("EZRTEMP",$J,"IIF",1))
 S EAC=$$PROCESS(7.1)                            ;Child 1 gross income
 S @ZDATA@("2C1")=@ZDATA@("2C1")_U_$S(EAC="":"",1:$J(EAC,0,2))
 S EAC=$$PROCESS(7.2)                            ;Child 1 net income
 S @ZDATA@("2C3")=@ZDATA@("2C3")_U_$S(EAC="":"",1:$J(EAC,0,2))
 S EAC=$$PROCESS(7.3)                            ;Child 1 other income
 S @ZDATA@("2C2")=@ZDATA@("2C2")_U_$S(EAC="":"",1:$J(EAC,0,2))
 ;
 ; Process Section IID - Previous Calendar Year Expenses
 S EZDATA=$NA(^TMP("EZRTEMP",$J,"IID",1))
 ;Medical expenses
 S EAX=$$PROCESS("1."),@ZDATA@("2D1")=$S(EAX="":"",1:$J(EAX,0,2))
 ;Funeral expenses
 S EAX=$$PROCESS("2."),@ZDATA@("2D2")=$S(EAX="":"",1:$J(EAX,0,2))
 ;Educational expenses
 S EAX=$$PROCESS("3."),@ZDATA@("2D3")=$S(EAX="":"",1:$J(EAX,0,2))
 ;
 ; Process Section IIE - Previous Calendar Year Net Worth
 S EZDATA=$NA(^TMP("EZRTEMP",$J,"IIE",1))
 S EAV=$$PROCESS("1."),EAS=$$PROCESS(1.2)  ;Vet & spouse cash
 S @ZDATA@("2E1")=$S(EAV="":"",1:$J(EAV,0,2))_U_$S(EAS="":"",1:$J(EAS,0,2))
 S EAV=$$PROCESS("2."),EAS=$$PROCESS(2.2)  ;Vet & spouse land value
 S @ZDATA@("2E2")=$S(EAV="":"",1:$J(EAV,0,2))_U_$S(EAS="":"",1:$J(EAS,0,2))
 S EAV=$$PROCESS("3."),EAS=$$PROCESS(3.2)  ;Vet & spouse other property
 S @ZDATA@("2E3")=$S(EAV="":"",1:$J(EAV,0,2))_U_$S(EAS="":"",1:$J(EAS,0,2))
 ;
 ;Since Child amounts in Section IIE are for ALL dependents,
 ;get just Child 1 amounts from Section IIG - Dependent Net Worths
 S EZDATA=$NA(^TMP("EZRTEMP",$J,"IIG",1))
 S EAC=$$PROCESS(9.1)                           ;Child 1 cash
 S @ZDATA@("2E1")=@ZDATA@("2E1")_U_$S(EAC="":"",1:$J(EAC,0,2))
 S EAC=$$PROCESS(9.2)                           ;Child 1 land value
 S @ZDATA@("2E2")=@ZDATA@("2E2")_U_$S(EAC="":"",1:$J(EAC,0,2))
 S EAC=$$PROCESS(9.3)                           ;Child 1 other property
 S @ZDATA@("2E3")=@ZDATA@("2E3")_U_$S(EAC="":"",1:$J(EAC,0,2))
 ;
 Q
 ;
PAGEDFF(EADEP) ;  Additional dependent financial page(s) for Section IIF
 ; Called from EN^EASEZRPF
 N ZDATA,EZDATA,EANAME,EAGROSS,EANET,EAOTHER
 ;
 S ZDATA=$NA(^TMP("EASEZR",$J,"DFF",EADEP))
 K @ZDATA
 ;
 ; Process Section IIF
 S EZDATA=$NA(^TMP("EZRTEMP",$J,"IIF",EADEP))
 ;
 S EANAME=$$PROCESS("7.")   ;Child number (2 through 19)
 S EAGROSS=$$PROCESS(7.1),EANET=$$PROCESS(7.2),EAOTHER=$$PROCESS(7.3)
 ;Child #^gross income^net income^other income
 S @ZDATA@(7)=EANAME_U_$S(EAGROSS="":"",1:$J(EAGROSS,0,2))_U_$S(EANET="":"",1:$J(EANET,0,2))_U_$S(EAOTHER="":"",1:$J(EAOTHER,0,2))
 ;
 Q
 ;
PAGEDFG(EADEP)  ; Additional dependent financial page(s) for Section IIG
 ; Called from EN^EASEZRPF
 N ZDATA,EZDATA,EANAME,EACASH,EAREAL,EAOTHER
 ;
 S ZDATA=$NA(^TMP("EASEZR",$J,"DFG",EADEP))
 K @ZDATA
 ;
 ; Process Section IIG
 S EZDATA=$NA(^TMP("EZRTEMP",$J,"IIG",EADEP))
 ;
 S EANAME=$$PROCESS("9.")   ;Child number (2 through 19)
 S EACASH=$$PROCESS(9.1),EAREAL=$$PROCESS(9.2),EAOTHER=$$PROCESS(9.3)
 ;Child #^cash^land value^other property
 S @ZDATA@(9)=EANAME_U_$S(EACASH="":"",1:$J(EACASH,0,2))_U_$S(EAREAL="":"",1:$J(EAREAL,0,2))_U_$S(EAOTHER="":"",1:$J(EAOTHER,0,2))
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
