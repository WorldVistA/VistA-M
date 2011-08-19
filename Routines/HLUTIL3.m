HLUTIL3 ;ALB/MTC - VARIOUS HL7 UTILITIES ;11/19/2003  15:37
 ;;1.6;HEALTH LEVEL SEVEN;**2,41,109**;Oct 13, 1995
 ;
 Q
 ;
FNDSTAT(IEN) ;- This function will return the appropriate status based
 ; on the Accept Ack, Application Ack and version of the protocol
 ; being utilized.
 ;
 ; INPUT : IEN of the HL7 Message File (#772)
 ; OUTPUT: Pointer to HL7 Message Status File (#771.6) OR NULL if
 ;         Not valid IEN or No parent.
 ;
 N PROTOCOL,PARENTP,PARENT,PROT
 N CHILD,RESULT
 N HLCA,HLAA
 ;
 S RESULT=""
 G:'IEN EXIT
 ;--  Find Parent
 S CHILD=$G(^HL(772,IEN,0))
 I CHILD="" G EXIT
 S PARENTP=$P(CHILD,"^",8)
 I (PARENTP="") G EXIT
 S PARENT=$G(^HL(772,PARENTP,0))
 ;
 S PROT=$P(PARENT,"^",10)
 S PROTOCOL=$$TYPE^HLUTIL2(PROT)
 S HLCA=$P(PROTOCOL,U,7)
 S HLAA=$P(PROTOCOL,U,8)
 ;
 ;-- if this is a responce (ack) message set to "sucessful"
 I $P(PARENT,U,7) S RESULT=3 G EXIT
 ;-- HLCA and HLAA assume original ack rules set to "awaiting ack"
 I HLCA="",HLAA="" S RESULT=2 G EXIT
 ;-- if HLCA=NE and HLAA=NE set to "sucessful"
 I HLCA="NE",HLAA="NE" S RESULT=3 G EXIT
 ;-- else set to "awaiting ack"
 S RESULT=2
 ;
EXIT ;
 Q RESULT
 ;
DOMAIL(HLLINK) ; This function will determine if the MailMan LLP should
 ; be used to x-mit the outgoing message.
 ;  INPUT  - IEN of HL LOGICAL LINK (#870)
 ;  OUTPUT - 1=Yes, 0=N
 ;
 N X
 S X=$P($G(^HLCS(870,+HLLINK,0)),U,22)
 Q $S(X:1,1:0)
 ;
LINK(HLINST,HLI,HLFLG) ;Return Logical Link(s) from Institution or Domain
 ; INPUT - HLINST=Institution name or VISN name or ien
 ;                If HLFLG="I", institution number is passed
 ;                If HLFLG="D", HLINST=DOMAIN name or DOMAIN ien
 ; If HLFLG="", Institution name or ien is assumed
 ; OUTPUT - HLI(LINK IEN)=LINK NAME passed by reference
 S HLFLG=$G(HLFLG)
 Q:$G(HLINST)']""
 N HLP S HLI=0
 ;Domain passed
 I HLFLG="D" D DOM Q
 ;Institution name or number
 I HLFLG="I"!('HLINST) D
 . ;patch HL*1.6*109
 . N X ;to protect the variable from calling routine
 . S DIC=4,DIC(0)="MXZ",X=HLINST D ^DIC S HLINST=+Y
 . ;patch HL*1.6*109 end
 Q:HLINST<1
 ;pass institution ien
 D CHILDREN^XUAF4("HLP","`"_HLINST) I $D(HLP) D  Q
 .S HLINST=0 F  S HLINST=$O(HLP("C",HLINST)) Q:HLINST<1  D L1
L1 F  S HLI=$O(^HLCS(870,"C",HLINST,HLI)) Q:HLI<1  D
 .S HLI(HLI)=$P(^HLCS(870,HLI,0),"^")
 Q
DOM ;Domain
 ;patch HL*1.6*109 start
 ;to protect the variable from calling routine
 N X
 I 'HLINST S DIC=4.2,DIC(0)="MXZ",X=HLINST D ^DIC S HLINST=+Y
 ;patch HL*1.6*109 end
 ;
 Q:HLINST<1
 F  S HLI=$O(^HLCS(870,"D",HLINST,HLI)) Q:HLI<1  D
 .S HLI(HLI)=$P(^HLCS(870,HLI,0),"^")
 Q   ; patch HL*1.6*109: add "Q" to quit DOM
