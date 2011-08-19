XLFNSLK ;ISF/RWF - Calling a DNS server for name lookup ;5/21/07  14:47
 ;;8.0;KERNEL;**142,151,425**;Jul 10, 1995;Build 18
 ;
TEST ;Test entry
 N XLF,XL1,XL3,Y,I S (XLF,XL3)=""
 R !,"Enter a IP address to lookup: www.va.gov//",XL1:DTIME S:XL1="" XL1="www.va.gov" Q:XL1["^"
 W !,"Looking up ",XL1 D NS(.XLF,XL1,"A",.XL3)
 S XL1="XL3" F  S XL1=$Q(@XL1) Q:XL1=""  W !,XL1," = ",@XL1
 S Y="" F  S Y=$O(XLF("B",Y)) Q:Y=""  W !,?5,Y," > ",XLF("B",Y)
 Q
 ;
ADDRESS(N,T) ;Get a IP address from a name
 N XLF,Y,I S XLF="",T=$G(T,"A")
 I ^%ZOSF("OS")["OpenM",T="A" D  Q $P(Y,",")
 . X "S Y=$ZU(54,13,N)"
 D NS(.XLF,N,T)
 S Y="" F I=1:1:XLF("ANCOUNT") S:$D(XLF("AN"_I_"DATA")) Y=Y_XLF("AN"_I_"DATA")_","
 Q $E(Y,1,$L(Y)-1)
 ;
MAIL(RET,N) ;Get the MX address for a domain
 ;RET is the return array
 N XLF,Y,I,T S XLF="",T="MX"
 D NS(.XLF,N,T)
 S RET=0,I=0 F  S I=$O(XLF("P",I)) Q:I'>0  D
 . S N=XLF("P",I),RET(I)=N_"^"_$G(XLF("B",N)),RET=RET+1
 Q
 ;
NS(XL,NAME,QTYPE,XLFLOG) ;NAME LOOKUP
 ;XL is the return array, NAME is the name to lookup,
 ;QTYPE is type of lookup, XLFLOG is a debug array returned.
 N RI,DNS,CNT,POP N:'$D(XLFLOG) XLFLOG S XL("ANCOUNT")=0,CNT=1
 D SAVEDEV
NS2 S DNS=$$GETDNS(CNT) I DNS="" G EXIT
 D LOG("Call server: "_DNS)
 D CALL^%ZISTCP(DNS,53) I POP S CNT=CNT+1 G NS2
 D LOG("Got connection, Send message")
 D BUILD(NAME,$G(QTYPE,"A")),LOG("Wait for reply")
 ;Close part of READ
 D READ,DECODE
 D RESDEV,LOG("Returned question: "_$G(XL("QD1NAME")))
 Q
EXIT D RESDEV
 Q
 ;
BUILD(Y,T) ;BUILD A QUEARY
 ; ID,PARAM,#of?, #ofA, #of Auth, #of add,
 N X,%,MSG,I
 S X=" M"_$C(1,0)_$C(0,1)_$C(0,0)_$C(0,0)_$C(0,0) ;Header
 I $E(Y,$L(Y))'="." S:$E(Y,$L(Y))'="." Y=Y_"."
 F I=1:1:$L(Y,".") S %=$P(Y,".",I) S:$L(%) X=X_$C($L(%))_% ;Address
 S X=X_$C(0) ;End of address
 ;Type A=1, NS=2, CNAME=5, MX=15
 S MSG=X_$C(0,$$TYPECODE(T))_$C(0,1) ;type and class
 D LOG("msg: "_MSG)
 U IO S %=$L(MSG) W $C(%\256,%#256)_MSG,!
 Q
READ ;
 N L1,L2,X,$ET S $ET="G RDERR" K RI S RI=0
 U IO R L1#2:20 I '$T D LOG("Time-out") G RDERR
 S RI=$A(L1,1)*256+$A(L1,2) ;get msg length
 F I=1:1:6 R L2#2:20 Q:'$T  S XL($P("ID^CODE^QDCOUNT^ANCOUNT^NSCOUNT^ARCOUNT","^",I))=$S(I>2:$$WBN(L2),I=2:$$BIN16(L2),1:L2)
 I '$T D LOG("Time-out") G RDERR
 D LOG("Return msg length: "_RI)
 F I=13:1:RI U IO R *X:20 Q:'$T  S RI(I)=X ;or use X#1 and $A(X)
RDERR ;End of read
 D CLOSE^%ZISTCP
 Q
DECODE ;
 N I,IX,X,Y,Z,NN,NN2 Q:RI'>7
 I $G(XL("ID"))'=" M" S XL("ERR")="Bad Response" D LOG(XL("ERR")) Q
 ;Decode the header
 S Z=XL("CODE"),XL("QR")=$E(Z,1),XL("Opcode")=$E(Z,2,5),XL("AA")=$E(Z,6),XL("TC")=$E(Z,7),XL("RD")=$E(Z,8),XL("RA")=$E(Z,9),XL("RCODE")=$E(Z,13,16)
 ;The Question section
 S IX=13
 F NN2=1:1:XL("QDCOUNT") D QD("QD"_NN2)
 F NN="AN","NS","AR" I $G(XL(NN_"COUNT")) F NN2=1:1:XL(NN_"COUNT") D RR(NN_NN2)
 Q
 ;
QD(NSP) ;Decode the Question section
 N Y
 S Y="",IX=IX+$$NAME(IX,.Y,1),XL(NSP_"NAME")=Y
 S XL(NSP_"TYPE")=$$BN(RI(IX),RI(IX+1)),IX=IX+2
 S XL(NSP_"CLASS")=$$BN(RI(IX),RI(IX+1)),IX=IX+2
 Q
RR(NSP) ;
 N Y,NA
 S Y="",IX=IX+$$NAME(IX,.Y,1),XL(NSP_"NAME")=Y,NA=Y
 S XL(NSP_"TYPE")=$$BN(RI(IX),RI(IX+1)),IX=IX+2
 S XL(NSP_"CLASS")=$$BN(RI(IX),RI(IX+1)),IX=IX+2
 S Y=RI(IX)*256+RI(IX+1),Y=Y*256+RI(IX+2),Y=Y*256+RI(IX+3)
 S XL(NSP_"TTL")=Y,IX=IX+4
 S (X,XL(NSP_"LENGTH"))=$$BN(RI(IX),RI(IX+1)),IX=IX+2 Q:X=0
 I XL(NSP_"TYPE")=1 S XL(NSP_"DATA")=RI(IX)_"."_RI(IX+1)_"."_RI(IX+2)_"."_RI(IX+3),XL("B",NA)=XL(NSP_"DATA")
 I XL(NSP_"TYPE")=15 D MX(IX)
 S IX=IX+XL(NSP_"LENGTH")
 Q
NAME(I,NM,F) ;Decode a NAME section
 N P,T,Y,X S NM=$G(NM) S:F T=0
 F  S X=RI(I) S:(X=0)&F T=T+1 Q:X=0  D  Q:X=0  ;Use X as flag to escape recursion.
 . I (X\64)=3 S X=$$NAME((X#64)*256+RI(I+1)+1,.NM,0),X=0 S:F T=T+2 Q
 . S NM=NM_$$PART(I+1,X),I=I+X+1 S:F T=T+X+1
 Q $G(T)
 ;
MX(IX) ;Hide IX changes
 N Y S Y=$$BN(RI(IX),RI(IX+1))
 F  Q:'$D(XL("P",Y))  S Y=Y+1
 S XL(NSP_"PREF")=Y,IX=IX+2
 S Y="",IX=IX+$$NAME(IX,.Y,1),XL(NSP_"NAME")=Y,XL("P",XL(NSP_"PREF"))=Y
 Q
 ;
BN(Z1,Z2) ;Convert two binary char 16 bit number into ASCII number
 Q Z1*256+Z2
 ;
WBN(Z1) ;Convert two byte string to a ASCII number
 Q $A(Z1,1)*256+$A(Z1,2)
 ;
H2(Z2) ;Convert 2 byte string to HEX
 N B S B=$A(Z2,1)*256+$A(Z2,2)
 Q $$H(B)
 ;
H(Z1) Q $$BASE^XLFUTL(Z1,10,16)
 ;
BIN16(S) ;Convert two byte string to 16 bit binary
 N K,Y S S=$A(S,1)*256+$A(S,2),Y=""
 F K=0:1:15 S Y=(S\(2**K)#2)_Y
 Q Y
 ;
PART(S,L) ;
 N R,A S R="" F A=S:1:S+L-1 S R=R_$C(RI(A))
 Q R_"."
 ;
TYPECODE(T) ;
 ;1=A:address,2=NS:nameserver,5=CNAME,15=MX:mail exchange
 I +T Q $S(T=1:"A",T=2:"NS",T=5:"CNAME",T=15:"MX",1:"ZZ")
 Q $S(T="A":1,T="NS":2,T="CNAME":5,T="MX":15,1:1)
 ;
CLASS(T) ;
 Q $S(T=1:"IN",1:"ZZ")
 ;
GETDNS(I) ;Get the address of our DNS
 N L S L=$G(^XTV(8989.3,1,"DNS"))
 Q $P(L,",",I)
 ;
SHOW ;LIST RI AND XL
 S O1=RI\3+1,O2=O1*2
 F I=1:1:O1 D SW(0,"RI("_I_")=",$G(RI(I))),SW(30,"RI("_(I+O1)_")=",$G(RI(I+O1))),SW(60,"RI("_(I+O2)_")=",$G(RI(I+O2))) W !
 Q
SW(T,H,V) ;
 W ?T,$J(H,8),V
 Q
SAVEDEV ;Save calling device
 D:'$D(IO(0)) HOME^%ZIS D SAVDEV^%ZISUTL("XLFNSLK")
 Q
RESDEV ;Restore calling device
 D USE^%ZISUTL("XLFNSLK"),RMDEV^%ZISUTL("XLFNSLK")
 K IO("CLOSE")
 Q
LOG(M) ;Log Debug messages
 S XLFLOG=$G(XLFLOG)+1,XLFLOG(XLFLOG)=M
 Q
 ;
POST ;Stuff a DNS address during install POST init.
 N DIC,DR,DIQ,XLF,DIE
 S XLF=$P($$PARAM^HLCS2,U,3)
 I XLF="T" D BMES^XPDUTL("Test Account DNS address not installed.") Q
 S DIC=8989.3,DR=51,DA=1,DIQ="XLF(" D EN^DIQ1 I $L(XLF(8989.3,1,51)) Q
 S DR="51///10.3.21.192",DIE="^XTV(8989.3,",DA=1 D ^DIE
 D BMES^XPDUTL("DNS address installed.")
 Q
