VAFCADT2 ;ALB/RJS - HL7 ADT MESSAGE BUILDING ROUTINE ; 3/6/06 8:24am
 ;;5.3;Registration;**91,179,209,415,494,484,508,692**;Aug 13, 1993
 ;hl7v1.6
 ;
 ;This routine builds ADT HL7 messages: A01 = Admission
 ;                                      A02 = Transfer
 ;                                      A03 = Discharge
 ;                                      A08 = Treating Specialty Update
 ;                                      A11 = Cancel Admission
 ;                                      A12 = Cancel Transfer
 ;                                      A13 = Cancel Discharge
 ;
 ;It is called by VAFCADT1, which is itself is called by the
 ;DGPM patient movement event driver.
 ;
 ;
BLDMSG(DFN,EVENT,VAFHDT,EVCODE,IEN,PIVOT,PV1) ;
 ;Required Variables are:   DFN = IEN of Patient File
 ;                        EVENT = HL7 Event, A01, A02, A03, etc.
 ;                       VAFHDT = Date/Time of Admission, Transfer, etc
 ;
 ;Optional Variables are: Event Code = (EVCODE):A string literal which is
 ;                                     inserted in the Event Reason
 ;                                     Code Field of the EVN segment
 ;                                     of the message. This serves to
 ;                                     indicate that the message might
 ;                                     need to be processed in a special
 ;                                     way. PIMS ADT software uses the
 ;                                     Event Code to indicate whether
 ;                                     the message is the most recent
 ;                                     "Snapshot" of the data "05" or
 ;                                     a "Snapshot" of data that is
 ;                                     followed by more recent data "04"
 ;
 ;                         
 ;                               IEN = The IEN of the Patient Movement
 ;                                     that the HL7 message is being
 ;                                     built from. This is especially
 ;                                     useful for Discharge Movements
 ;                                     where date/time (VAFHDT) is not
 ;                                     enough information to retrieve
 ;                                     the movement
 ;
 ;                             PIVOT = The PIMS Pivot number that
 ;                                     uniquely identifies the ADMISSION
 ;
 ;                               PV1 = In the case of a "Deleted
 ;                                     Admission" the record in the 
 ;                                     Patient Movement File has already
 ;                                     been deleted. But, a PV1 segment
 ;                                     can be built from the DGPMP
 ;                                     variable that has been saved off
 ;                                     by the DGPM Event Driver. This
 ;                                     PV1 segment is passed a string
 ;                                     literal that is built by a call
 ;                                     to DGBUILD^VAFHAPV1 previous to 
 ;                                     calling this software.
 ;
 K HLA N VAFDIAG,LIN,VAFSTR,DGREL,DGINC,DGINR,DGDEP,VAFZEL
 ;Q:($G(EVCODE)'="05")
 ;
 K HL
 I EVENT="A08" D INIT^HLFNC2("VAFC ADT-A08-TSP SERVER",.HL)
 I EVENT'="A08" D INIT^HLFNC2("VAFC ADT-"_EVENT_" SERVER",.HL)
 I $D(HL)#2 G EXIT
 S LIN=1
 S VAFSTR=$$COMMANUM^VAFCADT2(2,9)_",10B,11PC,"_$$COMMANUM^VAFCADT2(13,21)_",22B,"_$$COMMANUM^VAFCADT2(23,30)
 S HLA("HLS",$$ADD(.LIN,1))=$$EN^VAFCPID(DFN,VAFSTR)
 I +HLA("HLS",LIN)=-1 K HLA("HLS",2) G EXIT
 ;I $G(VAFPID(1))]"" S HLA("HLS",LIN,1)=VAFPID(1)
 ;I $G(VAFPID(2))]"" S HLA("HLS",LIN,2)=VAFPID(2)
 MERGE HLA("HLS",LIN)=VAFPID K VAFPID
 S $P(HLA("HLS",LIN),HLFS,2)=1 ;SET ID
 S VAFSTR=$$COMMANUM(1,12)
 S HLA("HLS",$$ADD(.LIN,1))=$$EN^VAFHLPD1(DFN,VAFSTR)
 S VAFSTR=$$COMMANUM(1,21)
 S HLA("HLS",$$ADD(.LIN,1))=$$EN^VAFHLZPD(DFN,VAFSTR)
 S $P(HLA("HLS",LIN),HLFS,2)=1 ;SET ID
 I EVENT="A11" D  G NEXT
 . S HLA("HLS",$$ADD(.LIN,1))=PV1
 . S $P(HLA("HLS",LIN),HLFS,51)=$G(PIVOT) ;              VISIT&SET ID'S
 I EVENT="A01"!(EVENT="A03")!(EVENT="A08")!(EVENT="A12")!(EVENT="A13") D  G NEXT
 . S VAFSTR=$$COMMANUM(2,5)_","_$$COMMANUM(7,45)
 . S HLA("HLS",$$ADD(.LIN,1))=$$IN^VAFHLPV1(DFN,VAFHDT,VAFSTR,$G(IEN),PIVOT,"",.VAFDIAG)
 I EVENT="A02" D  G NEXT
 . S VAFSTR=$$COMMANUM(2,45)
 . S HLA("HLS",$$ADD(.LIN,1))=$$IN^VAFHLPV1(DFN,VAFHDT,VAFSTR,$G(IEN),PIVOT,"",.VAFDIAG)
 G EXIT
NEXT ;
 S $P(HLA("HLS",LIN),HLFS,2)=1 ;PV1 SET ID
 S HLA("HLS",1)="EVN"_HLFS_EVENT_HLFS_$$HLDATE^HLFNC(VAFHDT,"TS")_HLFS
 S HLA("HLS",1)=HLA("HLS",1)_HLFS_$G(EVCODE) ;,1
 ;Get patient directory call center parameter
 N VAFCCON
 S VAFCCON=$$GET^XPAR("SYS","DG PT DIRECTORY CALL CENTER")
 I VAFCCON S HLA("HLS",$$ADD(.LIN,1))=$$EN^VAFHLPV2(DFN,IEN,",22,")
 S VAFSTR=$$COMMANUM(1,4)
 N HLAROL
 D BLDROL^VAFCROL("HLAROL",DFN,VAFHDT,VAFSTR,$G(PIVOT),$G(IEN))
 N I,J,K
 S I=""
 F K=1:1 S I=+$O(HLAROL(I)) Q:('I)  D
 . S J=""
 . F  S J=$O(HLAROL(I,J)) Q:(J="")  D
 . . S:('J) HLA("HLS",LIN+K)=HLAROL(I,J)
 . . S:(J) HLA("HLS",LIN+K,J)=HLAROL(I,J)
 S LIN=LIN+K-1
 I (EVENT="A01")!(EVENT="A08")!(EVENT="A11")!(EVENT="A12")!(EVENT="A13") DO
 . S HLA("HLS",$$ADD(.LIN,1))="DG1"_HLFS_1_HLFS_HLFS_HLFS_$$HLQ^VAFHUTL($G(VAFDIAG))
 S VAFSTR=$$COMMANUM(1,5)
 S HLA("HLS",$$ADD(.LIN,1))=$$EN^VAFHLZSP(DFN,1,1)
 S VAFSTR=$$COMMANUM(1,22)
 S HLA("HLS",$$ADD(.LIN,1))=$$EN^VAFHLZEL(DFN,VAFSTR,2)
 S VAFSTR=$$COMMANUM(1,9)
 S HLA("HLS",$$ADD(.LIN,1))=$$EN^VAFHLZCT(DFN,VAFSTR,1)
 S VAFSTR=$$COMMANUM(1,8)
 S HLA("HLS",$$ADD(.LIN,1))=$$EN^VAFHLZEM(DFN,VAFSTR,1,1)
 D ALL^DGMTU21(DFN,"V",VAFHDT,"R")
 S VAFSTR=$$COMMANUM(1,13)
 S HLA("HLS",$$ADD(.LIN,1))=$$EN^VAFHLZIR(+$G(DGINR("V")),VAFSTR,1)
 S VAFSTR=$$COMMANUM(1,10)
 S HLA("HLS",$$ADD(.LIN,1))=$$EN^VAFHLZEN(DFN,VAFSTR,1,HL("Q"),HL("FS"))
 D:$D(VATRACE) LOOP
 ;
 S COUNTER=""
 F  S COUNTER=$O(HLA("HLS",COUNTER)) Q:COUNTER'>0  D
 .; I +(HLA("HLS",COUNTER))=-1 S HLERR="Bad "_COUNTER_" Segment"
 .  I +(HLA("HLS",COUNTER))=-1 S HL="Bad "_COUNTER_" Segment"
 .
 ;
EXIT ;
 ;I $D(HL)=1 DO
 ;.  S HLERR(1)=HL
 ;.  D EBULL^VAFHUTL2(DFN,VAFHDT,PIVOT,"HLERR(")
 I $D(HL)>1,$D(HLA("HLS")) DO
 . I EVENT="A08" DO
 .  . D GENERATE^HLMA("VAFC ADT-A08-TSP SERVER","LM",1,.HLRST,"")
 . E  D GENERATE^HLMA("VAFC ADT-"_EVENT_" SERVER","LM",1,.HLRST,"")
 .
 D KVAR^VADPT,KVAR^VAFHLPV1 K HLA,HLERR
 Q
LOOP ;
 ;
 ;
 W !!
 N XX S XX=0
 F  S XX=$O(HLA("HLS",XX)) Q:XX=""  W !,HLA("HLS",XX)
 Q
 ;
COMMANUM(FROM,TO) ;Build comma separated list of numbers
 ;Input  : FROM - Starting number (default = 1)
 ;         TO - Ending number (default = FROM)
 ;Output : Comma separated list of numbers between FROM and TO
 ;         (Ex: 1,2,3)
 ;Notes  : Call assumes FROM <= TO
 ;
 S FROM=$G(FROM) S:(FROM="") FROM=1
 S TO=$G(TO) S:(TO="") TO=FROM
 N OUTPUT,X
 S OUTPUT=FROM
 F X=(FROM+1):1:TO S OUTPUT=(OUTPUT_","_X)
 Q OUTPUT
 ;
ADD(LINE,COUNTER) ;Increments Line = Line + Counter
 ;Input      :  LINE      - Line number
 ;              COUNTER   - Increment number
 ;Output     :  Updated LINE value
 ;
 S LINE=$G(LINE),COUNTER=$G(COUNTER)
 S LINE=LINE+COUNTER
 Q LINE
