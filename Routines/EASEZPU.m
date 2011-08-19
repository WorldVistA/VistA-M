EASEZPU ; ALB/SCK - Format VA10-10EZ print output utility ; 10/23/00
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;;Mar 15, 2001
 ;
 Q
 ;
PAGE1 ;  This function retrieves and formats the page 1 application data from the 1010EZ Holding File, #712,
 ;  for the printed version of the Vista 10-10EZ form.  If the hoding file entry has not been
 ;  accepted, and a vista entry is available, the vista entry is printed.
 ;  The ^TMP("EZTEMP") global is built in SETUP^EASEZPF and remains until the printed
 ; form is complete.
 ; Variables
 ;   ZDATA   - Variable which references the TMP global for the output data.
 ;   EZDATA  - Variable which references the available data from the 1010EZ holding file
 ;   EAX     - Temporary data variable
 ;   EASTR   - Temporary String data variable
 ;
 N ZDATA,EZDATA,EAX,EASTR,X
 ;
 S EZDATA="^TMP(""EZTEMP"",$J,""I"",1)"
 S ZDATA="^TMP(""EASEZ"",$J,1)"
 K @ZDATA
 ;
 S EASTR="" F EAX="1A.1","1A.2","1A.3","1A.4","1A.5" D
 . I $$PROCESS(EAX)="YES" S EASTR=EASTR_$$BENEFIT(EAX)_", "
 S @ZDATA@("1A")=EASTR
 ;
 S @ZDATA@("1B")=$$PROCESS("1B.")
 S @ZDATA@(2)=$$PROCESS(2.1)
 S @ZDATA@(3)=$E($$PROCESS("3."),1,35)
 S @ZDATA@(4)=$$PROCESS("4.")
 S @ZDATA@(5)=$$PROCESS("5.")
 S @ZDATA@(6)=$$PROCESS("6.")
 S @ZDATA@(7)=$$PROCESS("7.")
 S @ZDATA@(8)=$$PROCESS("8.")
 S @ZDATA@("9A")=$E($$PROCESS("9A."),1,35)
 S @ZDATA@("9B")=$E($$PROCESS("9B."),1,32)
 S @ZDATA@("9C")=$$PROCESS("9C.")
 S @ZDATA@("9D")=$$PROCESS("9D.")
 S @ZDATA@("9E")=$$PROCESS("9E.")
 S @ZDATA@(10)=$$PROCESS("10.1")
 S @ZDATA@(11)=$$PROCESS("11.1")
 S @ZDATA@(12)=$$PROCESS("12.")
 S @ZDATA@("13A")=$$PROCESS("13A.")
 S @ZDATA@("13B")=$$PROCESS("13B.")
 S @ZDATA@("13C")=$$PROCESS("13C.")
 S @ZDATA@("13D")=$$PROCESS("13D.")
 S @ZDATA@("13E")=$$PROCESS("13E.")
 ;
 K EAX
 F EAX="14A1","14A2","14B","14C","14D","14D1","14D2","14E","14F","14G","14H","14I","14J","14K","14L" D
 . S X=$$PROCESS(EAX_".")
 . S @ZDATA@(EAX)=$S(X="Y"!(X="YES"):"YES",X="N"!(X="NO"):"NO",X="UNKNOWN":"UNK",1:"")
 ;
 S @ZDATA@("14B1")=$$PROCESS("14B1.")
 S @ZDATA@("14K1")=$$PROCESS("14K1.")
 S @ZDATA@("14L1")=$$PROCESS("14L1.")
 S @ZDATA@("14M")=$$PROCESS("14M.")
 S @ZDATA@("14N")=$$PROCESS("14N.")
 S @ZDATA@("15A")=$$PROCESS("15A.1")_"^"_$$PROCESS("15A.2")
 ;
 K EAX
 S EAX=$E($$PROCESS("15B.1"),1,30)
 S EAX=EAX_"^"_$E($$PROCESS("15B.2"),1,30)_" "_$E($$PROCESS("15B.3"),1,30)_" "_$$PROCESS("15B.4")_" "_$E($$PROCESS("15B.5"),1,10)_"^"_$$PROCESS("15B.6")
 S @ZDATA@("15B")=EAX
 ;
 S @ZDATA@("16A")=$$PROCESS("16A.1")_U_$$PROCESS("16A.2")
 ;
 K EAX
 S EAX=$E($$PROCESS("16B.1"),1,30)
 S EAX=EAX_"^"_$E($$PROCESS("16B.2"),1,30)_" "_$E($$PROCESS("16B.3"),1,30)_" "_$$PROCESS("16B.4")_" "_$E($$PROCESS("16B.5"),1,10)_"^"_$$PROCESS("16B.6")
 S @ZDATA@("16B")=EAX
 ;
 S X=$$PROCESS("17.")
 S @ZDATA@(17)=$S(X="Y"!(X="YES"):"YES",X="N"!(X="NO"):"NO",X="UNKNOWN":"UNK",1:"")
 ;
 S @ZDATA@("17A")=$$PROCESS("17A.")
 S @ZDATA@("17B")=$E($$PROCESS("17B."),1,30)
 S @ZDATA@("17C")=$$PROCESS("17C.")
 S @ZDATA@("17D")=$$PROCESS("17D.")
 ;
 S X=$$PROCESS("18.")
 S @ZDATA@(18)=$S(X="Y"!(X="YES"):"YES",X="N"!(X="NO"):"NO",X="UNKNOWN":"UNK",1:"")
 ;
 S @ZDATA@("18A")=$$PROCESS("18A.")
 S @ZDATA@("18B")=$E($$PROCESS("18B."),1,30)
 S @ZDATA@("18C")=$$PROCESS("18C.")
 S @ZDATA@("18D")=$$PROCESS("18D.")
 ;
 S @ZDATA@("19A")=$$PROCESS("19A.1")_"^"_$E($$PROCESS("19A.3"),1,30)_", "_$E($$PROCESS("19A.4"),1,30)_" "_$$PROCESS("19A.5")_" "_$E($$PROCESS("19A.6"),1,10)_"^"_$$PROCESS("19A.7")
 S @ZDATA@("19B")=$$PROCESS("19B.1")
 S @ZDATA@("19C")=$$PROCESS("19C.1")
 ;
 S @ZDATA@("20A")=$$PROCESS("20A.1")_"^"_$E($$PROCESS("20A.3"),1,30)_", "_$E($$PROCESS("20A.4"),1,30)_" "_$$PROCESS("20A.5")_" "_$E($$PROCESS("20A.6"),1,10)_"^"_$$PROCESS("20A.7")
 S @ZDATA@("20B")=$$PROCESS("20B.1")
 S @ZDATA@("20C")=$$PROCESS("20C.1")
 ;
 S @ZDATA@("21")=$$PROCESS("21.")
 S X=$$PROCESS("22A.")
 S @ZDATA@("22A")=$S(X="Y"!(X="YES"):"YES",X="N"!(X="NO"):"NO",(X="UNKNOWN"):"UNK",1:"")
 ;
 S X=$$PROCESS("22B.")
 S @ZDATA@("22B")=$S(X="Y"!(X="YES"):"YES",X="N"!(X="NO"):"NO",(X="UNKNOWN"):"UNK",1:"")
 Q
 ;
PAGE2 ;  Retrieve page 2 data and format for output on 10-10EZ form
 ;
 ; Variables
 ;   ZDATA, EZDATA, EAX - See above
 ;   EAV, EAS, EAC, X12A, X12B  - temporary storage variables
 ;
 N ZDATA,EZDATA,X,EAX,EAV,EAS,EAC,X12A,X12B
 ;
 S ZDATA="^TMP(""EASEZ"",$J,2)"
 K @ZDATA
 ;
 ; Process Section IIA
 S EZDATA="^TMP(""EZTEMP"",$J,""IIA"",1)"
 ;
 S @ZDATA@(1)=$$PROCESS(1.1)
 S @ZDATA@(2)=$$PROCESS(2.1)
 S @ZDATA@(3)=$$PROCESS("3.")
 S @ZDATA@(4)=$$PROCESS("4.")
 S @ZDATA@(5)=$$PROCESS("5.")
 S @ZDATA@(6)=$$PROCESS(6.1)_"^"_$$PROCESS(6.2)_" "_$$PROCESS(6.3)_" "_$$PROCESS(6.4)
 ;
 S @ZDATA@(7)=$$PROCESS("7.")
 S @ZDATA@(8)=$$PROCESS(8.1)
 S @ZDATA@(9)=$$PROCESS("9.")
 S @ZDATA@(10)=$$PROCESS("10.")
 S @ZDATA@(11)=$$PROCESS("11.")
 ;
 S X12A=$$PROCESS(12.1)
 S X12B=$$PROCESS(12.2)
 S @ZDATA@(12)=X12A_"^"_X12B
 ;
 S @ZDATA@(13)=$$PROCESS("13.")
 ;
 S X=$$PROCESS("14.")
 S @ZDATA@(14)=$S(X="Y"!(X="YES"):"YES",X="N"!(X="NO"):"NO",X="UNKNOWN":"UNK",1:"")
 S X=$$PROCESS("15.")
 S @ZDATA@(15)=$S(X="Y"!(X="YES"):"YES",X="N"!(X="NO"):"NO",X="UNKNOWN":"UNK",1:"")
 ;
 ; Process Section IIC
 S EZDATA="^TMP(""EZTEMP"",$J,""IIC"",1)"
 ;
 S EAV=$$PROCESS(1.1),EAS=$$PROCESS(1.2),EAC=$$PROCESS(1.3)
 S @ZDATA@("2C1")=EAV_"^"_EAS_"^"_EAC
 ;
 K EAV,EAS,EAC
 S EAV=$$PROCESS(2.1),EAS=$$PROCESS(2.2),EAC=$$PROCESS(2.3)
 S @ZDATA@("2C2")=EAV_"^"_EAS_"^"_EAC
 S X=$$PROCESS("3.")
 S @ZDATA@("2C3")=$S(X="Y"!(X="YES"):"YES",X="N"!(X="NO"):"NO",X="UNKNOWN":"UNK",1:"")
 ;
 ; Process Section IID
 S EZDATA="^TMP(""EZTEMP"",$J,""IID"",1)"
 ;
 S X=$$PROCESS("1."),@ZDATA@("2D1")=X
 S X=$$PROCESS("2."),@ZDATA@("2D2")=X
 S X=$$PROCESS("3."),@ZDATA@("2D3")=X
 ;
 ; Process Section IIE
 S EZDATA="^TMP(""EZTEMP"",$J,""IIE"",1)"
 ;
 K EAV,EAS
 S EAV=$$PROCESS(1.1),EAS=$$PROCESS(1.2)
 S @ZDATA@("2E1")=EAV_"^"_EAS
 ;
 K EAV,EAS
 S EAV=$$PROCESS(2.1),EAS=$$PROCESS(2.2)
 S @ZDATA@("2E2")=EAV_"^"_EAS
 ;
 K EAV,EAS
 S EAV=$$PROCESS(3.1),EAS=$$PROCESS(3.2)
 S @ZDATA@("2E3")=EAV_"^"_EAS
 ;
 Q
 ;
PAGEN(EADEP) ;  Additional dependent pages.  Prints Child data only on page 2 format.
 ;
 N ZDATA,EZDATA,EAX,X
 ;
 S ZDATA="^TMP(""EASEZ"",$J,2)"
 K @ZDATA
 ;
 ; Process Section IIA
 S EZDATA="^TMP(""EZTEMP"",$J,""IIB"",EADEP)"
 ;
 S @ZDATA@(1)=""
 S @ZDATA@(2)=$$PROCESS(1.1)
 S @ZDATA@(3)=""
 S @ZDATA@(4)=""
 S @ZDATA@(5)=$$PROCESS("3.")
 S @ZDATA@(6)=""
 S @ZDATA@(7)=$$PROCESS("2.")
 S @ZDATA@(8)=""
 S @ZDATA@(9)=$$PROCESS("4.")
 S @ZDATA@(10)=""
 S @ZDATA@(11)=$$PROCESS("5.")
 S X=$$PROCESS("6."),@ZDATA@(12)="^"_X
 S X=$$PROCESS("7."),@ZDATA@(13)=X
 ;
 S X=$$PROCESS("8.")
 S @ZDATA@(14)=$S(X="Y"!(X="YES"):"YES",X="N"!(X="NO"):"NO",X="UNKNOWN":"UNK",1:"")
 S X=$$PROCESS("9.")
 S @ZDATA@(15)=$S(X="Y"!(X="YES"):"YES",X="N"!(X="NO"):"NO",X="UNKNOWN":"UNK",1:"")
 ;
 ; Process Section IIB
 S @ZDATA@("2B")=-1
 ;
 F EAX="2C1","2C2","2C3","2D1","2D2","2D3","2E1","2E2","2E3" S @ZDATA@(EAX)=""
 Q
 ;
PROCESS(KEY) ; Process data value form EXTEMP array, take #712 value if it's accepted,
 ; otherwise take the Patient File value
 ;
 N EAV,RSLT
 ;
 I '$D(@EZDATA@(KEY)) G PQ
 S EAV=@EZDATA@(KEY)
 S RSLT=$S(+$P(EAV,U,3):$P(EAV,U,2),1:$P(EAV,U,5))
 ;S RSLT=$P(EAV,U,2)
PQ Q $G(RSLT)
 ;
BENEFIT(X) ; Return External format of benefit applied for for printing on the VA 1010EZ form.
 ;
 Q $S(X="1A.1":"HEALTH SERVICES",X="1A.2":"NURSING HOME",X="1A.3":"DOMICILIARY",X="1A.4":"DENTAL",X="1A.5":"ENROLLMENT",1:"")
