OOPSUTL6 ;WOIFO/LLH-Utilities Routines ;11/21/00
 ;;2.0;ASISTS;;Jun 03, 2002
 ;;
 Q
VERIFY(IEN) ; Verify Employee data has not been altered since thier signing
 ;
 ;  Input     IEN - Internal Record Number of Case
 ;  Code expects Employee, Supervisor, and WCP e-signatures
 ;
 N CALL,DOL,FORM,RECORD,SIG,STR,VALID,VER,X,X1,X2,WCP
 S VALID=1
 S FORM="CA"_$$GET1^DIQ(2260,IEN,52,"I")
 S RECORD=$G(^OOPS(2260,IEN,"CA"))
 S VER=$P(RECORD,U,9),X=$P(RECORD,U,7)
 I '$G(VER)&('$G(X)) Q 1        ; employee signed before patch, change??
 I VER'=1 Q ""
 I FORM="CA1" S X1=$$GET1^DIQ(2260,IEN,119,"I"),X2=$$CA1SUM^OOPSUTL6()
 I FORM="CA2" S X1=$$GET1^DIQ(2260,IEN,221,"I"),X2=$$CA2SUM^OOPSUTL6()
 D DE^XUSHSHP
 I $G(X1)="" Q ""
 S VALID=(X=$P($G(^VA(200,X1,20)),U,2))
 I 'VALID D
 . K XMY,XMB
 . S DOL=1
 . S WCP="" F  S WCP=$O(^OOPS(2260,"AW",WCP)) Q:WCP=""  I $D(^OOPS(2260,"AW",WCP,IEN)) K ^OOPS(2260,"AW",WCP,IEN)
 . S STR=$G(^OOPS(2260,IEN,FORM_"ES"))        ; send bulletins to
 . I $P(STR,U)=""!($P(STR,U,4)="") Q
 . S XMB="OOPS SIGNATURE SECURITY"
 . S XMB(2)=$P($G(^OOPS(2260,IEN,0)),U)       ; claim number
 . S XMY($P(STR,U))="",XMY($P(STR,U,4))=""    ; emp, supervisor, WCP
 . S XMY($P($G(^OOPS(2260,IEN,"WCES")),U))=""
 . D ^XMB K XMB,XMY,XMM,XMDT
 . F CALL="E","S","W" D CLRES^OOPSUTL1(IEN,CALL,FORM)
 Q VALID
CA1SUM() ; Calculate Checksum for CA1 for all employee fields on page 1
 N I,J,K,OOPS,STR,SUM,WITN,X
 S J=1
 S OOPS(0)=$G(^OOPS(2260,IEN,0))
 S OOPS("2162A")=$G(^OOPS(2260,IEN,"2162A"))
 S OOPS("CA1A")=$G(^OOPS(2260,IEN,"CA1A"))
 S OOPS("CA1B")=$P($G(^OOPS(2260,IEN,"CA1B")),U)
 S OOPS("CA1C")=$P($G(^OOPS(2260,IEN,"CA1C")),U)
 S OOPS("CA1N")=$G(^OOPS(2260,IEN,"CA1N"))
 S STR(J)=$P(OOPS(0),U,2),J=J+1
 F I=1,2,3,8,12,13,4,5,6,7 S STR(J)=$P(OOPS("2162A"),U,I),J=J+1
 F I=8,9,10 S STR(J)=$P(OOPS("CA1A"),U,I),J=J+1
 F I=1:1:3 S STR(J)=$P(OOPS("CA1N"),U,I),J=J+1
 S STR(J)=$P(OOPS(0),U,5),J=J+1
 F I=11,12 S STR(J)=$P(OOPS("CA1A"),U,I),J=J+1
 S STR(J)=OOPS("CA1B"),J=J+1
 S STR(J)=$P($G(^OOPS(2260,IEN,"CA")),U),J=J+1
 S STR(J)=OOPS("CA1C"),J=J+1
 S STR(J)=$P(OOPS("CA1A"),U,13),J=J+1
 S SUM=0 F K=1:1:J I $D(STR(K)) F I=1:1:$L(STR(K)) S SUM=$A(STR(K),I)*I+SUM
 Q SUM
CA2SUM() ; Calculate Checksum for CA2
 N I,J,K,OPFLD,OOPS,STR,SUM,X
 S J=1
 S OOPS(0)=$G(^OOPS(2260,IEN,0))
 S OOPS("2162A")=$G(^OOPS(2260,IEN,"2162A"))
 S OOPS("CA2A")=$G(^OOPS(2260,IEN,"CA2A"))
 S OOPS("CA2B")=$G(^OOPS(2260,IEN,"CA2B"))
 S STR(J)=$P(OOPS(0),U,2),J=J+1
 F I=1,2,3,8,12,13,4,5,6,7 S STR(J)=$P(OOPS("2162A"),U,I),J=J+1
 F I=8,9 S STR(J)=$P(OOPS("CA2A"),U,I),J=J+1
 F I=1:1:7 S STR(J)=$P(OOPS("CA2B"),U,I),J=J+1
 S STR(J)=$P($G(^OOPS(2260,IEN,"CA")),U),J=J+1
 F OPFLD=216,217,218,219,220 D WP
 S SUM=0 F K=1:1:J I $D(STR(K)) F I=1:1:$L(STR(K)) S SUM=$A(STR(K),I)*I+SUM
 Q SUM
VALEMP() ; check to make sure claim is ok to send to DOL if pay plan = "OT"
 ; this subroutine assumes that the variable FORM will be defined
 N IEN450,LP,NA,SAL,VALID
 S VALID=1,LP=0
 S NA=$$GET1^DIQ(2260,IEN,1)
 S SAL=$$GET1^DIQ(2260,IEN,166)
 I $$GET1^DIQ(2260,IEN,60,"I")'=3 S VALID=0
 I $$GET1^DIQ(2260,IEN,16,"I")'="00" S VALID=0
 I $$GET1^DIQ(2260,IEN,17,"I")'="N" S VALID=0
 I (FORM="CA1")&(('SAL)!(SAL>999.99)) S VALID=0
 D FIND^DIC(450,,"@;8","MPS",NA,100)
 I $G(DIERR) D CLEAN^DILF S VALID=0 Q VALID
 F  S LP=$O(^TMP("DILIST",$J,LP)) Q:LP=""  D
 .I $$GET1^DIQ(2260,IEN,5)=$P(^TMP("DILIST",$J,LP,0),U,2) D
 ..S IEN450=$P(^TMP("DILIST",$J,LP,0),U)
 ..I '$G(IEN450) S VALID=0 Q
 ..I $$GET1^DIQ(450,IEN450,20,"I")'="F" S VALID=0
 Q VALID
 ;
WP ;Process Word Processing Fields
 N DIWL,DIWR,DIWF,OPGLB,OPI,OPNODE,OPT,OPC,X
 K ^UTILITY($J,"W")
 S DIWL=1,DIWR="",DIWF="|C132"
 S OPNODE=$P($$GET1^DID(2260,OPFLD,"","GLOBAL SUBSCRIPT LOCATION"),";")
 S OPGLB="^OOPS(2260,IEN,OPNODE,OPI)"
 S OPI=0 F  S OPI=$O(@OPGLB) Q:'OPI  S X=$G(^(OPI,0)) D
 . I $TR(X," ","")="" Q
 . I X]"" D ^DIWP
 S OPT=$G(^UTILITY($J,"W",1))+0
 I OPT S OPI=0 F OPC=1:1 S OPI=$O(^UTILITY($J,"W",1,OPI)) Q:'OPI  D
 . S STR(J)=^UTILITY($J,"W",1,OPI,0),J=J+1
 K ^UTILITY($J,"W")
 Q
