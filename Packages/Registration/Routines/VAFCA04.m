VAFCA04 ;ALB/RJS-Creates the Registration Message ; 26 Mar 2003  3:13 PM
 ;;5.3;Registration;**91,209,149,261,298,415,484,508**;Aug 13, 1993
 ;
 ;07/07/00 ACS - Added sequence 21 (physical treating specialty - ward
 ;location) and sequence 39 (facility+suffix) to the inpatient string
 ;of fields.  Added sequence 39 to the outpatient string of fields.
 ;
EN(DFN,VAFCDATE,USER,PIVOTPTR) ;
 Q:($G(DFN)="")!($G(VAFCDATE)="") "-1^Missing required parameter(s)"
 N ERR,VCCI,SITE,FS,VAFCDT,VAFHPIV,REP,DGREL,DGINC,DGINR,DGDEP,VAFSTR
 N ICN,CHKSUM,SETICN,SETLOC,HLA,HLRST,PV1,LIN
 ;
 ;check HL7 V2.3 messaging flag
 N SEND S SEND=$P($$SEND^VAFHUTL(),"^",2)
 Q:SEND=0 "-1^Stop HL7 V2.3 messaging flag is set"
 ;
 S USER=+$G(USER)
 I 'USER,$D(DUZ) S USER=DUZ
 I 'USER,'$D(DUZ) S USER=0
 S PIVOTPTR=+$G(PIVOTPTR)
 I 'PIVOTPTR D
 .S VAFHPIV=+$$PIVNW^VAFHPIVT(DFN,VAFCDATE,3,DFN_";DPT(")
 .Q:+VAFHPIV<0
 .S PIVOTPTR=+$O(^VAT(391.71,"D",VAFHPIV,0))
 ;
 Q:+$G(VAFHPIV)<0 "-1^Could Not Create ADT/HL7 Pivot file entry"
 K ERR
 ;log edited field(s) in the ADT/HL7
 I $D(VAFCFLDS) D
 . S VAFCFLDS=$$PROCESS^VAFCDD01()
 . Q:VAFCFLDS'=-1
 . D REGEDIT^VAFCDD01(PIVOTPTR,VAFCFLDS)
 ;Messaging flag set to SUSPEND - flag entry in ADT/HL7 Pivot file
 ; for transmission and quit
 I SEND=2 D TRANSMIT^VAFCDD01(PIVOTPTR) Q 1
 K VAFCFLDS
 D INIT^HLFNC2("VAFC ADT-A04 SERVER",.HL)
 Q:$G(HL)]"" "-1^VAFC A04 SERVER NOT DEFINED PROPERLY"
 S FS=HL("FS"),REP=$E(HL("ECH"))
 ;
 S VAFCDT=$$HLDATE^HLFNC(VAFCDATE,"TS")
 S HLA("HLS",1)="EVN"_HLFS_"A04"_HLFS_VAFCDT_HLFS_HLFS_HLFS_USER_REP
 S DIC="^VA(200,",DIC(0)="MZO",X="`"_USER D ^DIC K DIC
 N DGNAME S DGNAME("FILE")=200,DGNAME("IENS")=USER,DGNAME("FIELD")=.01
 I USER'=0 S HLA("HLS",1)=HLA("HLS",1)_$$HLNAME^XLFNAME(.DGNAME,"",$E($G(HLECH)))
 ; ^ possible to not have a user defined
 S LIN=1
 K Y S VAFSTR=$$COMMANUM^VAFCADT2(1,9)_",10B,11PC,"_$$COMMANUM^VAFCADT2(13,21)_",22B,"_$$COMMANUM^VAFCADT2(23,30)
 S HLA("HLS",$$ADD(.LIN,1))=$$EN^VAFCPID(DFN,VAFSTR)
 ;CHECK IF PATIENT HAS AN ICN
 I $P(HLA("HLS",LIN),HLFS,3)=HLQ D
 . N X S X="MPIF001" X ^%ZOSF("TEST") Q:'$T
 . ; if patient does not have an ICN still pass HLQ
 . S ICN=$$GETICN^MPIF001(DFN)
 . I +ICN>0 S $P(HLA("HLS",LIN),HLFS,3)=ICN
 MERGE HLA("HLS",LIN)=VAFPID K VAFPID
 S VAFSTR=$$COMMANUM^VAFCADT2(1,12)
 S HLA("HLS",$$ADD(.LIN,1))=$$EN^VAFHLPD1(DFN,VAFSTR)
 S VAFHPIV=$P($G(^VAT(391.71,PIVOTPTR,0)),"^",2)
 Q:VAFHPIV'>0 "-1^COULDN'T FIND PIVOT ENTRY"
 I $G(^DPT(DFN,.1))]"" D
 . S PV1=$$EN^VAFHAPV1(DFN,VAFCDATE,",2,3,7,8,10,18,21,39,44,45,50")
 . S HLA("HLS",$$ADD(.LIN,1))=PV1
 . S VAFSTR=$$COMMANUM^VAFCADT2(1,4)
 . N HLAROL
 . D BLDROL^VAFCROL("HLAROL",DFN,VAFCDATE,VAFSTR,VAFHPIV)
 . N I,J,K
 . S I=""
 . F K=1:1 S I=+$O(HLAROL(I)) Q:('I)  D
 . . S J=""
 . . F  S J=$O(HLAROL(I,J)) Q:(J="")  D
 . . . S:('J) HLA("HLS",LIN+K)=HLAROL(I,J)
 . . . S:(J) HLA("HLS",LIN+K,J)=HLAROL(I,J)
 . S LIN=LIN+K-1
 E  D
 . S PV1=$$OPV1^VAFHCPV(DFN,+VAFHPIV,VAFCDATE,DFN_";DPT(",",2,3,7,18,39,45,50",1)
 . S HLA("HLS",$$ADD(.LIN,1))=PV1
 S HLA("HLS",$$ADD(.LIN,1))=$$EN^VAFHLOBX(DFN)
 S VAFSTR=$$COMMANUM^VAFCADT2(1,21)
 S HLA("HLS",$$ADD(.LIN,1))=$$EN^VAFHLZPD(DFN,VAFSTR)
 S VAFSTR=$$COMMANUM^VAFCADT2(1,5)
 S HLA("HLS",$$ADD(.LIN,1))=$$EN^VAFHLZSP(DFN)
 S VAFSTR=$$COMMANUM^VAFCADT2(1,22)
 S HLA("HLS",$$ADD(.LIN,1))=$$EN^VAFHLZEL(DFN,VAFSTR)
 S HLA("HLS",$$ADD(.LIN,1))=$$EN^VAFHLZCT(DFN,"1,2,3,4,5,6,7,8,9")
 S HLA("HLS",$$ADD(.LIN,1))=$$EN^VAFHLZEM(DFN,"1,2,3,4,5,6,7,8")
 S HLA("HLS",$$ADD(.LIN,1))="ZFF"_HL("FS")_2_HL("FS")_$P($G(^VAT(391.71,+$G(PIVOTPTR),2)),U)
 D ALL^DGMTU21(DFN,"V",VAFCDATE,"R")
 S VAFSTR=$$COMMANUM^VAFCADT2(1,13)
 S HLA("HLS",$$ADD(.LIN,1))=$$EN^VAFHLZIR(+$G(DGINR("V")),VAFSTR,1)
 S VAFSTR=$$COMMANUM^VAFCADT2(1,10)
 S HLA("HLS",$$ADD(.LIN,1))=$$EN^VAFHLZEN(DFN,VAFSTR,1,HL("Q"),HL("FS"))
 D GENERATE^HLMA("VAFC ADT-A04 SERVER","LM",1,.HLRST,"",.HL)
 ;Store result in pivot file
 S HLRST=$S(+HLRST:HLRST,1:$P(HLRST,U,3))
 I +HLRST>0 D MESSAGE^VAFCDD01(PIVOTPTR,+HLRST)
 D FILERM^VAFCUTL($O(^VAT(391.71,"D",+VAFHPIV,0)),HLRST)
 ;
EX ; 
 Q 1
 ;
ADD(LINE,COUNTER) ;Increments Line = Line + Counter
 ;Input    :  LINE   - Line number
 ;            COUNTER - Increment number
 ;Output   :  Updated LINE value
 ;
 S LINE=$G(LINE),COUNTER=$G(COUNTER)
 S LINE=LINE+COUNTER
 Q LINE
 ;
HL7A04(PIVOTNUM,IEN) ;
 ;A new Registration was created capture the key demographic data.
 ;Create an HL7 V2.3 entry in the ADT/HL PIVOT file so that the 
 ;demographic data can be broadcasted.
 ; VAFCFLDS is set in routine VAFCDD01. It contains the
 ; fields that were edited.
