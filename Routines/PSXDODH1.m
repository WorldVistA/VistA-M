PSXDODH1 ;BIR/HTW-HL7 Message Conversion ;01/15/02 13:10:52
 ;;2.0;CMOP;**38,45**;11 Apr 97
 ;  Convert CMOP transmission messages from HL7 V 2.3.1 to V 2.1
TESTBT ;test the sequence of the messages in the batch
 ; stored in ^tmp($j,"PSXDOD","MSG0",I)
 S PSXERR="",LSEG="",PTCNT=0,ORDCNT=0
 F LNNUM=1:1 S LN=$G(@G@(LNNUM)) Q:LN=""  S SEG=$P(LN,"|") S:SEG="NTE" SEG=$P(LN,"|",1,2) D
 . Q:SEG="FTS"
 . I LNNUM=1,SEG="FHS" S LSEG=SEG,FHS=LN Q
 . I '$D(SEGSEQ(LSEG,SEG)) S PSXERR=PSXERR_$S($L(PSXERR):"~",1:"")_"SEQ^"_LSEG_U_SEG S LSEG=SEG Q
 . S LSEG=SEG
 . I "BHS,MSH,ORC,RXE,ZR1,PID,BTS"[SEG D CHECK
 Q
CHECK ;patient safety check
 I SEG="BHS" S BATIDB=$P(LN,"|",11),BHS=LN Q
 I SEG="MSH" S BATIDM=$P(LN,"|",10),ORDSEQ=$P(BATIDM,"-",3),BATIDM=$P(BATIDM,"-",1,2) I BATIDM'=BATIDB S PSXERR=PSXERR_$S($L(PSXERR):"~",1:"")_"22^"_ORDSEQ D  Q
 . I $E(IOST)="C" W !,"Order Sequence ",PSXERR,!,BATIDM,?40,BATIDB
 I SEG="ORC",LNNUM'=3 S RXIDC=$P(LN,"|",3),RXSEQ=$$GETELM(LN,"5,2","|,^") Q
 I SEG="RXE" S RXIDE=$P(LN,"|",16),ORDCNT=ORDCNT+1 I RXIDE'=RXIDC S PSXERR=PSXERR_$S($L(PSXERR):"~",1:"")_"41^"_ORDSEQ_U_RXSEQ D  Q
 . I $E(IOST)="C" W !,"Prescription Number ",PSXERR,!,RXIDE,?40,RXIDC
 I SEG="ZR1" S RXID1=$P(LN,"|",2) I RXID1'=RXIDC S PSXERR=PSXERR_$S($L(PSXERR):"~",1:"")_"44^"_ORDSEQ_U_RXSEQ D  Q
 . I $E(IOST)="C" W !,"RX Number ",PSXERR,!,RXID1,?40,RXIDC
 I SEG="PID" S PTCNT=PTCNT+1 Q
 I SEG="BTS" S PTCNTB=$P(LN,"|",2),ORDCNTB=$P(LN,"|",4),BTS=LN D
 . I PTCNTB'=PTCNT S PSXERR=PSXERR_$S($L(PSXERR):"~",1:"")_"56^" D
 .. I $E(IOST)="C" W !,"Batch Orders ",PSXERR,!,PTCNTB,?40,PTCNT
 . I ORDCNTB'=ORDCNT S PSXERR=PSXERR_$S($L(PSXERR):"~",1:"")_"58^" D
 .. I $E(IOST)="C" W !,"Batch Totals ",PSXERR,!,ORDCNTB,?40,ORDCNT
 Q
HEADER ; read FHS,BHS,ORC assemble $$XMIT,NTE|1   called from PSXDODH
 ;FHS|^~\&|CHCS|BALBOA||CMOP LEAVENWORTH|20020403115125|0124_020931151.TRN
 ;BHS|^~\&|CHCS||VistA||20020403115100||RAR^RAR||0124-020931151
 ;ORC|NW||||||||||||||||||||^^^^^^^0124&BALBOA&0124|500 PARK ST^^SAN DIEGO^CA^92130|(858)826-4923
 ;
 ;$$XMIT^020931151^BALBOA^CMOP LEAVENWORTH^0124^3020403.115125^DOD Facility^1^8^BALBOA^0124
 ; NTE|1||673BS\S\CBC-BARTOW\S\673\F\13000 BRUCE B DOWNS BLVD\S\\S\TAMPA\S\FL\S\33612\F\(888) 903-546
 ; Use document for the mapping of segments & elements between HL7 2.3.1 & CMOP 2.1
 ; CMOP DOD to Vista Message Mapping 3_24.xls
 K XM,NTE1
 S FHS=@G@(1),BHS=@G@(2),ORC=@G@(3)
 F YY="BATNM^11","FACNM^4","CMOP^6","TRANDTS^7" D PIECE(FHS,"|",YY)
 S BATNM=$$GETELM(BHS,"11,2","|,-") ; FHS SEGMENT is file name with "_"
 S TRANDTS=$$FMDATE^HLFNC(TRANDTS)
 S START=1,END=PTCNTB
 S ORC=$P(ORC,"ORC|",2)
 S DIVISION=$$GETELM(ORC,"21,8","|,^")
 F YY="DIVNUM^1","DIVNM^2","FACNUM^3" D PIECE(DIVISION,"&",YY)
 F YY="ADDRESS^22","PHONE^23" D PIECE(ORC,"|",YY)
 F YY="ADD1^1","ADD2^2","CITY^3","STATE^4","ZIP^5" D PIECE(ADDRESS,"^",YY)
 S DIVNUM="1"_DIVNUM,FACNUM="1"_FACNUM ;****Institution file change
 ; assemble XM - $$XMIT
 S XM="$$XMIT"
 F YY="BATNM^2","FACNM^3","CMOP^4","FACNUM^5","TRANDTS^6","START^8","END^9","DIVNM^10","DIVNUM^11" D PUT(.XM,"^",YY)
 S $P(XM,"^",7)="DOD Facility"
 ; change site number for testing to acceptable site number 693
 ;S XM=$$SETELM(XM,5,"^",693) ;****TESTING
 ;S XM=$$SETELM(XM,11,"^",693) ;****TESTING
 ; assemble NTE1(4)
 S NTE1DIV="" F YY="DIVNUM^1","DIVNM^2","FACNUM^3" D PUT(.NTE1DIV,"\S\",YY)
 S NTE1ADD="" F YY="ADD1^1","ADD2^2","CITY^3","STATE^4","ZIP^5" D PUT(.NTE1ADD,"\S\",YY)
 S NTE1LOC="" F YY="NTE1DIV^1","NTE1ADD^2","PHONE^3" D PUT(.NTE1LOC,"\F\",YY)
 ; assemble NTE1
 S NTE1="NTE|1||"_NTE1LOC
 ; change NTE1 site number to 693 for testing
 ;S NTE1=$$SETELM(NTE1,"4,1,1","|,\F\,\S\",693) ;****TESTING
 ;S NTE1=$$SETELM(NTE1,"4,1,3","|,\F\,\S\",693) ;****TESTING
 ; store $$XMIT,NTE1
 Q
BLDSEQ ;build check sequence of SEGMENTS
 K SEGSEQ
 F I=1:1 S LINE=$P($T(SEGBLD+I),";;",2,99) Q:LINE["$$END"  D
 . S LSEG=$P(LINE,";;")
 . F J=2:1 S SEG=$P(LINE,";;",J) Q:SEG=""  S SEGSEQ(LSEG,SEG)="" ;W !,LSEG,?10,SEG
 Q
SEGBLD ; data for checking sequence of segments. ZR1 needs special handling.
 ;;FHS;;BHS
 ;;BHS;;ORC
 ;;ORC;;NTE|2;;NTE|3;;NTE|4;;MSH
 ;;NTE|2;;NTE|2;;NTE|3;;NTE|4;;MSH
 ;;NTE|3;;NTE|3;;NTE|4;;MSH
 ;;NTE|4;;NTE|4;;MSH
 ;;MSH;;PID
 ;;PID;;NTE|8;;ORC
 ;;NTE|8;;ORC;;NTE|8;;ZML;;ZSL
 ;;ZML;;ZML;;ZSL
 ;;ZSL;;ZSL;;ORC
 ;;ORC;;RXE
 ;;RXE;;ZR1;;NTE|7
 ;;NTE|7;;NTE|7;;ZR1
 ;;ZR1;;ORC;;BTS;;MSH;;PID
 ;;BTS;;FTS
 ;;$$END
PIECE(REC,DLM,XX) ;
 ; Set VAR = piece I of REC using delimiter DLM
 N Y,I S Y=$P(XX,U),I=$P(XX,U,2),@Y=$P(REC,DLM,I)
 Q
PUT(REC,DLM,XX) ;
 ; Set VAR into piece I of REC using delimiter DLM
 N Y,I S Y=$P(XX,U),I=$P(XX,U,2)
 S $P(REC,DLM,I)=$G(@Y)
 Q
GETELM(STR,PIECES,SEPS) ;
 ; uses STRing and
 ; returns value of the element located by path of pieces and seperators
 ; ex: PIECES "3,2,1"  SEPS "|,^,&"
 N P,S,PI,V S V=STR
 F I=1:1 S PI=$P(PIECES,",",I) Q:PI=""  S P=I,P(I)=PI,S(I)=$P(SEPS,",",I)
 F I=1:1:P S V=$P(V,S(I),P(I))
 Q V
SETELM(STR,PIECES,SEPS,VALUE)      ;
 ; gets STRing and
 ; inserts value into element located by path of pieces and separators
 ; ex: PIECES "3,2,1"  SEPS "|,^,&"
 N P,S,PI,V
 S (V,V(0))=STR
 F I=1:1 S PI=$P(PIECES,",",I) Q:PI=""  S P=I,P(I)=PI,S(I)=$P(SEPS,",",I)
 F I=1:1:P S (V,V(I))=$P(V,S(I),P(I)) ; unpack
 S V(I)=VALUE ; insert value
 F I=P:-1:1 S $P(V(I-1),S(I),P(I))=V(I) ; repack
 Q V(0)
 ;
STRBLD(STR0,SEPS) ;
 ; default separators for all segments, fields, components are | ^ &  
 ; other separators can be passed in SEPS ex: "|,^,&" or "|,\F\,\S\"
 ; or placed within the field and segment nodes STR0( , , ..,"S")= separator
 ; ex: for NTE|1 of HL7 2.1 
 ;               segment NTE|1                   STR0("S")="|"
 ;               facility field          STR0(4,"S")="\F\"
 ;               address component       STR0(4,2,"S")="\S\" 
 N P1,P2,P3,S1,S2,S3,STR
 S:'$L($G(SEPS)) SEPS="|,^,&"
 M STR=STR0
L1 S P1=0,STR=""
 I '$D(STR("S")) S STR("S")=$P(SEPS,",",1)
 S S1=STR("S")
 F  S P1=$O(STR(P1)) Q:P1'>0  D
 . I +$O(STR(P1,0)) D L2
 . S $P(STR,S1,P1)=STR(P1)
 Q STR
L2 S P2=0 ; S STR(P1)=""
 I '$D(STR(P1,"S")) S STR(P1,"S")=$P(SEPS,",",2)
 S S2=STR(P1,"S")
 F  S P2=$O(STR(P1,P2)) Q:P2'>0  D
 . I +$O(STR(P1,P2,0)) D L3
 . S $P(STR(P1),S2,P2)=STR(P1,P2)
 I STR(P1)'[S2 S STR(P1)=STR(P1)_S2
 Q
L3 S P3=0 ; S STR(P1,P2)=""
 I '$D(STR(P1,P2,"S")) S STR(P1,P2,"S")=$P(SEPS,",",3)
 S S3=STR(P1,P2,"S")
 F  S P3=$O(STR(P1,P2,P3)) Q:P3'>0  D
 . S $P(STR(P1,P2),S3,P3)=STR(P1,P2,P3)
 I STR(P1,P2)'[S3 S STR(P1,P2)=STR(P1,P2)_S3
 Q
