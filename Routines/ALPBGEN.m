ALPBGEN ;SFVAMC/JC - Build HL7 PMU messages ;03/11/2004  15:54
 ;;3.0;BAR CODE MED ADMIN;**7,8**;March 2004
HL7(XUIEN,XUFLG,XUSR) ;GENERATE MESSAGE - For Subscriber to XUSER DATA REQUEST (BCBU PMU MESSAGE BUILDER)
 ;Build HL7 PMU~B01 or B02 message from array XUSR() and XUNAME()
 ;B01=Personnel Add/Create event type
 ;B02=Personnel Update event type
 ;
 ;CHECK IF BCBU IS ACTIVE AT PACKAGE LEVEL
 Q:+$$GET^XPAR("PKG.BAR CODE MED ADMIN","PSB BKUP ONLINE",1,"Q")'>0
 Q:'$D(XUSR)  ;Array of user data from Kernel
 Q:'$D(XUIEN)  ;Internal entry of user required
 ;
 ;SFVAMC/JC - 10/8/03 ADD CHECK FOR BCMA USER STATUS
 Q:+$$ISBCMA^ALPBGEN2(XUIEN)<1
 ;
 N ALPBEVN,MT,FS,EC,CS,RS,ESC,SS,N,ALERR,ALPBDIV,ALPBRCV,ECS,EEC,EFS,ERS,ESS,HLA,HLMTIENS,HLNEXT,HLNODE,HLQUIT,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S ALPBEVN=$S(XUFLG=1:"PSB BCBU PMU_B01 EVENT",1:"PSB BCBU PMU_B02 EVENT")
 S ALPBRCV=$S(XUFLG=1:"PSB BCBU PMU_B01 RECV",1:"PSB BCBU PMU_B02 RECV")
 K HL D INIT^HLFNC2(ALPBEVN,.HL)
 I +$G(HL) W !,HL Q   ;SETUP ERROR or no subscribers.
 S N=0
 S MT=$S(XUFLG=1:"B01",1:"B02")
 S FS=$G(HL("FS")) Q:FS=""  ;Field separator
 S EC=$G(HL("ECH")) Q:EC=""  ;Encoding Characters
 S CS=$E(EC) ;Component separator
 S RS=$E(EC,2) ;Repetition separator
 S ESC=$E(EC,3) ;Escape character
 S SS=$E(EC,4) ;Subcomponent separator
 S EEC=ESC_"E"_ESC ;escaped escape character
 S EFS=ESC_"F"_ESC ;escaped field separator
 S ECS=ESC_"S"_ESC ;escaped component separator
 S ERS=ESC_"R"_ESC ; escaped Repetition separator
 S ESS=ESC_"T"_ESC ;escaped subcomponent separator
EVN ;EVN segment
 S N=N+1
 S HLA("HLS",N)="EVN"_FS_MT_FS_$$FMTHL7^XLFDT($$NOW^XLFDT)
GSTF ;Generate Staff Detail Segment
 N ALPBSSN,STF S STF="STF"
 S $P(STF,FS,2)=XUIEN_CS_200_CS_"VISTA" ;Primary Key
 ;Staff ID Code
 ;SSN Incorrect variable reference before transmit to workstation
 ;also don't plus SSN
 ;S ALPBSSN=$TR($G(XUSR("ALPBSSN")),"-","") S:+ALPBSSN ALPBSSN=$$M10^HLFNC(ALPBSSN,EC) S:'+ALPBSSN ALPBSSN=ALPBSSN_CS_""_CS_"LOCAL"
 S ALPBSSN=$TR($G(XUSR("SSN")),"-","") Q:$L(ALPBSSN)'=9  S ALPBSSN=$$M10^HLFNC(ALPBSSN,EC)
 S $P(STF,FS,3)=ALPBSSN_CS_"USSSA"_CS_"SS"_RS_$$ESC($G(XUSR("ACCESS CODE")))_RS_$$ESC($G(XUSR("VERIFY CODE")))
GSTNM ;Staff Name
 N SN S SN=""
 I $D(XUSR("HL7NAME")) D
 . S XUSR("HL7NAME")=$TR(XUSR("HL7NAME"),"~",CS)
 . S SN=XUSR("HL7NAME")
 I '$D(XUSR("HL7NAME")),$D(XUSR("NAME")) D
 . S SN=$TR(XUSR("NAME"),",",CS)
 S $P(STF,FS,4)=SN
 ;Active/Inactive (Disuser=1 or 0 or null)
 S $P(STF,FS,8)=$S(XUSR("DISUSER")=1:"I",1:"A")
 ;Termination Date
 I XUSR("TERMINATION DATE")]"" S $P(STF,FS,14)=$$FMTHL7^XLFDT(XUSR("TERMINATION DATE"))
 ;Add to HL7 array
 S N=N+1,HLA("HLS",N)=STF
 ;Send the message
 Q:'$D(HLA)
 ;Check user's divisions
SEND K HLL S ALPBDIV="" F  S ALPBDIV=$O(XUSR("DIV",ALPBDIV)) Q:ALPBDIV=""  D
 . K DIC,D,X,Y
 . S DIC="^DG(40.8,",D="AD",X=ALPBDIV,DIC(0)="XN"
 . D IX^DIC
 . Q:+Y'>0
 . S ALPBDIV1=+Y
 . K DIC,D,X,Y,ALPHLL
 . D GET^ALPBPARM(.ALPHLL,ALPBDIV1)
 . I $D(ALPHLL) S I=0 F  S I=$O(ALPHLL("LINKS",I)) Q:I<1  D
 . . S $P(ALPHLL("LINKS",I),"^",1)=ALPBRCV
 . . S HLL("LINKS",($O(HLL("LINKS",999999),-1)+1))=ALPHLL("LINKS",I)
 K ALPHLL
 ;. K DIC,D,X,Y
 ;. D GET^ALPBPARM(.HLL,ALPBDIV1)
 ;. I $D(HLL) S I=0 F  S I=$O(HLL("LINKS",I)) Q:I<1  S $P(HLL("LINKS",I),"^",1)=ALPBRCV
 ;If no division assoc. use defaults
 I $O(XUSR("DIV",0))=""!('$D(HLL)) D GET^ALPBPARM(.HLL,"","",ALPBRCV)
 K MYRESULT
 I '$D(HLL) S MYRESULT="1-No subscribers" Q
 D GENERATE^HLMA(ALPBEVN,"LM",1,.MYRESULT)
 I $P(MYRESULT,U,2)]"" S ALERR=MYRESULT D SERR
 Q
 ;
ESC(ST,PR) ;Translate reserved characters to escape sequences in Access/Verify
 ;ST=String to translate
 ;PR=Event Protocol to set up HL array variables (optional)
 ;First, do the escape character
 I $G(ST)']"" Q ""
 S PR=$G(PR) I PR]"" D INIT^HLFNC2(PR,.HL)
 I '$D(HL) D
 . S HL("FS")="^"
 . S HL("ECH")="~|\&"
 S FS=$G(HL("FS")) I FS="" Q "" ;Field separator
 S EC=$G(HL("ECH")) I EC="" Q ""  ;Encoding Charaters
 S CS=$E(EC) ;Component separator
 S RS=$E(EC,2) ;Repitition separator
 S ESC=$E(EC,3) ;Escape character
 S SS=$E(EC,4) ;Subcomponent separator
 S EEC=ESC_"E"_ESC ;escaped escape character
 S EFS=ESC_"F"_ESC ;escaped field sep
 S ECS=ESC_"S"_ESC ;escaped component sep
 S ERS=ESC_"R"_ESC ; escaped repitition sep
 S ESS=ESC_"T"_ESC ;escaped subcomponent separator
 F I=1:1:$L(ST) S J=$E(ST,I),^TMP($J,I)=J D
 . S:J=ESC ^TMP($J,I)=EEC
 . S:J=FS ^TMP($J,I)=EFS
 . S:J=CS ^TMP($J,I)=ECS
 . S:J=RS ^TMP($J,I)=ERS
 . S:J=SS ^TMP($J,I)=ESS
 S I=0,ST="" F  S I=$O(^TMP($J,I)) Q:I<1  S ST=ST_^TMP($J,I)
 K ^TMP($J)
 Q ST
UNESC(ST,PR) ;Unescape string from message
 ;ST=String to translate
 ;PR=Event Protocol to set up HL array variables (optional)
 ;First, do the escape character
 I $G(ST)="" Q ""
 S PR=$G(PR) I PR]"" D INIT^HLFNC2(PR,.HL)
 I '$D(HL) D
 . S HL("FS")="^"
 . S HL("ECH")="~|\&"
 S FS=$G(HL("FS")) I FS="" Q "" ;Field separator
 S EC=$G(HL("ECH")) I EC="" Q ""  ;Encoding Charaters
 S CS=$E(EC) ;Component separator
 S RS=$E(EC,2) ;Repitition separator
 S ESC=$E(EC,3) ;Escape character
 S SS=$E(EC,4) ;Subcomponent separator
 S EEC=ESC_"E"_ESC ;escaped escape character
 S EFS=ESC_"F"_ESC ;escaped field sep
 S ECS=ESC_"S"_ESC ;escaped component sep
 S ERS=ESC_"R"_ESC ; escaped repitition sep
 S ESS=ESC_"T"_ESC ;escaped subcomponent separator
 K I,J,K,L,X F  S X=$F(ST,EEC) S:X I=$G(I)+1,K(I)=$E(ST,1,X-1),ST=$E(ST,X,999) S:'X K($G(I)+1)=ST Q:'X
 S I=0 F  S I=$O(K(I)) Q:I<1  S:K(I)[EEC K(I)=$P(K(I),EEC)_ESC S L=$G(L)_K(I)
 I $G(L)]"" S ST=L
 ;
 K I,J,K,L,X F  S X=$F(ST,EFS) S:X I=$G(I)+1,K(I)=$E(ST,1,X-1),ST=$E(ST,X,999) S:'X K($G(I)+1)=ST Q:'X
 S I=0 F  S I=$O(K(I)) Q:I<1  S:K(I)[EFS K(I)=$P(K(I),EFS)_FS S L=$G(L)_K(I)
 I $G(L)]"" S ST=L
 ;
 K I,J,K,L,X S I=0 F  S X=$F(ST,ECS) S:X I=$G(I)+1,K(I)=$E(ST,1,X-1),ST=$E(ST,X,999) S:'X K(I+1)=ST Q:'X
 S I=0 F  S I=$O(K(I)) Q:I<1  S:K(I)[ECS K(I)=$P(K(I),ECS)_CS S L=$G(L)_K(I)
 I $G(L)]"" S ST=L
 ;
 K I,J,K,L,X S I=0 F  S X=$F(ST,ERS) S:X I=$G(I)+1,K(I)=$E(ST,1,X-1),ST=$E(ST,X,999) S:'X K(I+1)=ST Q:'X
 S I=0 F  S I=$O(K(I)) Q:I<1  S:K(I)[ERS K(I)=$P(K(I),ERS)_RS S L=$G(L)_K(I)
 I $G(L)]"" S ST=L
 ;
 K I,J,K,L,X S I=0 F  S X=$F(ST,ESS) S:X I=$G(I)+1,K(I)=$E(ST,1,X-1),ST=$E(ST,X,999) S:'X K(I+1)=ST Q:'X
 S I=0 F  S I=$O(K(I)) Q:I<1  S:K(I)[ESS K(I)=$P(K(I),ESS)_SS S L=$G(L)_K(I)
 I $G(L)]"" S ST=L
 K I,J,K,L,X
 Q ST
 ;
SERR ;SEND ERRORS
 K XQA,XQAMSG,XQAOPT,XQAROU,XQAID,XQADATA,XQAFLAG
 S XQA("G.PSB BCBU ERRORS")=""
 S XQAMSG="Error sending HL7 message "_$G(HL("MID"))_". Header in HLMA("_$G(HLMTIENS)_"Error: "_ALERR
 D SETUP^XQALERT
 Q
