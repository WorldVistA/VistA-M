RGADTP1 ;BIR/DLR-ADT PROCESSOR TO RETRIGGER A08 or A04 MESSAGES WITH AL/AL (COMMIT/APPLICATION) ACKNOWLEDGEMENTS - CONTINUED ;7/19/21  12:43
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**26,27,42,45,44,47,48,59,61,64,67,71,76**;30 Apr 99;Build 1
 ;
PIDP(MSG,ARRAY,HL) ;process PID segment
 N ID,IDS,PIDAA,PIDNTC
 ;Since PID can be over 245 characters loop through setting a PID ARRAY
 ;sequenced PID(1)="PID"... PID(4 or 5) can be over 245 characters so
 ;it will also loop and place it in PID(4,1...
 ;
 ; Input variables
 ;   assumes that MSG or MSG(I) will contain the PID segment
 ; Output ARRAY ARRAY will contain the following subscripts
 ;   SSN - patient SSN
 ;   ICN - patient ICN
 ;   DFN - sites local identifier
 ;   MPISSITE - authoritative source (station# of sending site)
 ;   SEX - patient's SEX
 ;   MPIDOB - Date of Birth
 ;   NAME,SURNAME,FIRST,MIDDLE,PREFIX,and SUFFIX - Patient Name
 ;   MMN - Mother's maiden name
 ;   POBCITY, POBSTATE - Place of birth city and state
 ;
 N PID,MPIJ,LNGTH,LNGTH1,PID1,SEQ,SEQ1,COMP,SUBCOMP,REP,HLECH,X,Y,CNT,NXT,ID,IDS,PIDAA,PIDNTC,NAME,LNGTH2,PIDSITE,PIDXDT,HLECH,HLFS
 S HLFS=HL("FS"),HLECH=HL("ECH")
 S ARRAY("DFN")="",ARRAY("ICN")="",ARRAY("CLAIMN")="",ARRAY("SSN")=""
 S COMP=$E(HL("ECH"),1),SUBCOMP=$E(HL("ECH"),4),REP=$E(HL("ECH"),2)
 S LNGTH=$L(MSG,HL("FS")) F SEQ=1:1:LNGTH S PID(SEQ)=$P(MSG,HL("FS"),SEQ)
 S SEQ1=1,X=0 F  S X=$O(MSG(X)) Q:'X  S LNGTH=$L(MSG(X),HL("FS")) D
 . F Y=1:1:LNGTH S:Y'=1 SEQ=SEQ+1,SEQ1=1 D  ;**61 MVI_2970 (dri)
 .. S NXT=$P(MSG(X),HL("FS"),Y) D
 ... I $L($G(PID(SEQ)))=245 D  Q
 .... I $L(NXT_$G(PID(SEQ,SEQ1)))>245 S LNGTH1=$L(PID(SEQ,SEQ1)) S LNGTH2=245-LNGTH1,PID(SEQ,SEQ1)=$G(PID(SEQ,SEQ1))_$E(NXT,1,LNGTH2),LNGTH2=LNGTH2+1,NXT=$E(NXT,LNGTH2,$L(NXT)),SEQ1=SEQ1+1
 .... I $L(NXT_$G(PID(SEQ,SEQ1)))'>245 S PID(SEQ,SEQ1)=$G(PID(SEQ,SEQ1))_NXT
 ... I $L(NXT_$G(PID(SEQ)))>245 S LNGTH1=$L($G(PID(SEQ))) S LNGTH2=245-LNGTH1,PID(SEQ)=$G(PID(SEQ))_$E(NXT,1,LNGTH2),LNGTH2=LNGTH2+1,NXT=$E(NXT,LNGTH2,$L(NXT)) S PID(SEQ,SEQ1)=NXT
 ... I $L(NXT_$G(PID(SEQ)))'>245 S PID(SEQ)=$G(PID(SEQ))_NXT Q
 ;
 ;get PID-3 Patient Identifier List (three ids should be returned ICN, SSN, and DFN)
 I $G(PID(4))'="" D  ;**61 MVI_2970 (dri) problem processing volume of name ids
 . N A,ACNT,CNT,ID,IDS,IDSWKD,LASTID,PIDAA,PIDNTC,PIDSITE,PIDXDT,X
 . S A="",IDSWKD=0,CNT=1,ACNT=1
 . S IDS=$G(PID(4)),LASTID=$L(IDS,REP) D IDSARR
 . F  S A=$O(PID(4,A)) Q:A=""  S IDS=$G(PID(4,A)),LASTID=$L(IDS,REP) D IDSARR
 ;
 ;get PID-4 alternate ID (ICN History)
 I $G(PID(5))'="" D
 . S CNT=1
 . F X=1:1:$L(PID(5),REP) S ARRAY("OID",CNT)=$P(PID(5),REP,X),CNT=CNT+1
 . S Y=0 F  S Y=$O(PID(5,Y)) Q:'Y  D
 .. S ARRAY("OID",CNT-1)=ARRAY("OID",CNT-1)_$P(PID(5,Y),REP)
 .. F X=2:1:$L(PID(5,Y),REP) S ARRAY("OID",CNT)=$P(PID(5,Y),REP,X),CNT=CNT+1
 . S X=0 F  S X=$O(ARRAY("OID",X)) Q:'X  D
 .. N ID,AA,AL S ID=$P(ARRAY("OID",X),COMP),AA=$P($P(ARRAY("OID",X),COMP,4),SUBCOMP,1),AL=$P($P(ARRAY("OID",X),COMP,6),SUBCOMP,2) S AL=$$IEN^XUAF4(AL)
 .. S ARRAY("OID",X)=ID_"^"_AA_"^"_AL
 ;
 ;get PID-5 Patient Name
 I $G(PID(6))'="" D  ;**61 MVI_2970 (dri) problem processing volume of aliases
 . N A,ALISWKD,IDCNT,LASTNAM,NAME,NAMES,X
 . S A="",ALISWKD=0,IDCNT=1
 . S NAMES=$G(PID(6)),LASTNAM=$L(NAMES,REP) D NAMARR
 . F  S A=$O(PID(6,A)) Q:A=""  S NAMES=$G(PID(6,A)),LASTNAM=$L(NAMES,REP) D NAMARR
 ;
 ;N KK,JJ,TMPJ,IDCNT2 S IDCNT=1
 ;I $G(PID(6))'="" F IDCNT2=1:1:$L(PID(6),REP) S NAME=$P(PID(6),REP,IDCNT2) D
 ;.I $P(NAME,COMP,7)="L" S ARRAY("SURNAME")=$P(NAME,COMP),ARRAY("FIRST")=$P(NAME,COMP,2),ARRAY("MIDDLE")=$P(NAME,COMP,3),ARRAY("PREFIX")=$P(NAME,COMP,4),ARRAY("SUFFIX")=$P(NAME,COMP,5),ARRAY("NAME")=$$FMNAME^HLFNC($P(NAME,COMP,1,6)) Q
 ;.I $P(NAME,COMP,7)="A" S $P(ARRAY("ALIAS",IDCNT),"^")=$$FMNAME^HLFNC($P(NAME,COMP,1,6)),IDCNT=IDCNT+1 Q  ;**48 ALIAS NAMES?
 ;.;**48 alias could send PID(6) to second subscript level
 ;.S KK=$O(PID(6,"")) I KK'="" S PID(6,KK)=$P(PID(6),REP,IDCNT2)_PID(6,KK)
 ;.S JJ=0 F  S JJ=$O(PID(6,JJ)) Q:'JJ  D
 ;..I JJ'=KK S PID(6,JJ)=$P(PID(6,$O(PID(6,JJ),-1)),REP,TMPJ)_PID(6,JJ)
 ;..F TMPJ=1:1:$L(PID(6,JJ),REP) S NAME=$P(PID(6,JJ),REP,TMPJ) D
 ;...I $P(NAME,COMP,7)="A" S $P(ARRAY("ALIAS",IDCNT),"^")=$$FMNAME^HLFNC($P(NAME,COMP,1,6)),IDCNT=IDCNT+1
 ;
 ;get PID-6 Mother's maiden name
 S ARRAY("MMN")=$P($G(PID(7)),COMP,1,5) D
 . I $P(ARRAY("MMN"),COMP)'=HL("Q") S HLECH=HL("ECH") S ARRAY("MMN")=$$FREE^RGRSPARS($$FMNAME^HLFNC(ARRAY("MMN"))) Q
 . I $P(ARRAY("MMN"),COMP)=HL("Q") S ARRAY("MMN")=$$FREE^RGRSPARS($P(ARRAY("MMN"),COMP))
 ;
 ;get PID-7 Date of Birth
 ;**47 taking HL("Q") into account
 I $G(PID(8))=HL("Q") S PID(8)="@",ARRAY("MPIDOB")="@"
 I $G(PID(8))'="@" S ARRAY("MPIDOB")=$$FMDATE^HLFNC($G(PID(8)))
 ;
 ;get PID-8 Sex
 ;**47 taking HL("Q") into account
 I $G(PID(9))=HL("Q") S PID(9)="@"
 S ARRAY("SEX")=$G(PID(9))
 ;
 ;get PID-11-3 ADDRESS BOTH "P"rimary and "N" Place of
 S CNT=1
 N ADRTYPE,ADDR
 F X=1:1:$L(PID(12),REP) D
 . S ADDR=$P(PID(12),REP,X),ADRTYPE=$P(ADDR,COMP,7)
 . I ADRTYPE="P" D
 .. S ADDR=$$FREE^RGRSPARS(ADDR)
 .. S ARRAY(.111)=$$FREE^RGRSPARS($P(ADDR,COMP,1))  ;addr [1]
 .. S ARRAY(.112)=$$FREE^RGRSPARS($P(ADDR,COMP,2))  ;addr [2]
 .. S ARRAY(.113)=$$FREE^RGRSPARS($P(ADDR,COMP,8))  ;addr [3]
 .. S ARRAY(.114)=$$FREE^RGRSPARS($P(ADDR,COMP,3))  ;city
 .. S ARRAY(.115)=$$STATE^RGRSPARS($P(ADDR,COMP,4))  ;state
 .. S ARRAY(.1112)=$$FREE^RGRSPARS($P(ADDR,COMP,5))  ;zip+4
 .. N CNTYCODE S CNTYCODE=PID(13)  ;county code
 .. S ARRAY(.117)=$$COUNTY^RGRSPARS(ARRAY(.115),CNTYCODE)
 .. S ARRAY(.131)=$$FREE^RGRSPARS(PID(14))
 .. S ARRAY(.132)=$$FREE^RGRSPARS(PID(15))
 . I ADRTYPE="N" D
 .. S ARRAY("POBCITY")=$$FREE^RGRSPARS($P(ADDR,COMP,3))  ;POB city
 .. S ARRAY("POBSTATE")=$$STATE^RGRSPARS($P(ADDR,COMP,4))  ;POB state
 ;
 ;marital status
 S ARRAY(.05)=$$MARITAL^RGRSPARS(PID(17))
 ;
 ;multiple birth indicator **47
 S ARRAY("MBI")=$G(PID(25)) I ARRAY("MBI")=HL("Q") S ARRAY("MBI")="@" ;**47 to get MBI and setup as yes/no field change to @ if HL("Q")
 ;
 ;;REMOVED FROM PATCH 45 DUE TO NEEDING DG707
 ;religious preference
 S ARRAY(.08)=$$RELIG^RGRSPARS(PID(18))
 ;
 ;address
 ;
 ;get PID-29 Date of Death
 S ARRAY("MPIDOD")=$$FREE^RGRSPARS($$FMDATE^HLFNC($G(PID(30)))),ARRAY(.351)=ARRAY("MPIDOD")
 Q
 ;
IDSARR ;parse ids ;**61 MVI_2970 (dri)
 F X=1:1:LASTID S ID=$P(IDS,REP,X) D
 . I IDSWKD=1 S IDSWKD=0 Q  ;first repetition of continuation message already worked
 . I X=LASTID,$D(PID(4,A+1)) S ID=ID_$P(PID(4,A+1),REP,1),IDSWKD=1 ;if last repetition check for an extension of message
 . ;get id, assigning authority, and name type code
 . S PIDAA=$P($P(ID,COMP,4),SUBCOMP),PIDNTC=$P(ID,COMP,5),PIDSITE=$P($P(ID,COMP,6),SUBCOMP,2),PIDXDT=$P(ID,COMP,8)
 . S ID=$P(ID,COMP)
 . ;Q:ID="" **48
 . ;check assigning authority(0363) AND name type code(0203)
 . I PIDAA="USVHA" D  Q
 .. I PIDNTC="NI" D
 ... I $G(PIDXDT)="" S ARRAY("ICN")=ID,ARRAY("MPISSITE")=PIDSITE,ARRAY(991.02)=$P(ID,"V",2)  ;National unique individual identifier
 ... I $G(PIDXDT)'="" S ARRAY("OID",CNT)=ID_"^"_PIDAA_"^"_PIDSITE_"^"_PIDXDT,CNT=CNT+1  ;Deprecated National unique individual identifier
 .. I PIDNTC="PI" S ARRAY("DFN")=ID,ARRAY("DFNLOC")=PIDSITE  ;Patient internal identifier
 . I PIDAA="USSSA" D  Q
 .. I PIDNTC="SS",PIDXDT="" S ARRAY("SSN")=ID I ID=HL("Q") S ARRAY("SSN")="@"  ;Social Security number **44 (new) look out for alias ssns
 .. I PIDNTC="SS",PIDXDT'="" S $P(ARRAY("ALIAS",ACNT),"^",2)=ID,ACNT=ACNT+1 ;**48 store alias ssn
 .. ;**47 includes HL("Q") check
 . I PIDAA="USVBA" D  Q
 .. I PIDNTC="PN" S ARRAY("CLAIMN")=ID  ;VBA CLAIM#
 . ;**59,MVI_880: Get TIN and FIN values
 . I PIDAA="USDOD" D  Q
 .. I PIDNTC="TIN" S ARRAY("TIN")=$S(ID=HL("Q"):"@",1:ID)
 .. I PIDNTC="FIN" S ARRAY("FIN")=$S(ID=HL("Q"):"@",1:ID)
 . ;**76, VAMPI-11120 (dri) Get ITIN value
 . I PIDAA="USIRS" D  Q
 .. I PIDNTC="NI" S ARRAY("ITIN")=$S(ID=HL("Q"):"@",1:ID)
 Q
 ;
NAMARR ;parse legal and alias names ;**61 MVI_2970 (dri)
 F X=1:1:LASTNAM S NAME=$P(NAMES,REP,X) D
 . I ALISWKD=1 S ALISWKD=0 Q  ;first repetition of continuation message already worked
 . I X=LASTNAM,$D(PID(6,A+1)) S NAME=NAME_$P($G(PID(6,A+1)),REP,1),ALISWKD=1 ;if last repetition check for an extension of message
 . I $P(NAME,COMP,7)="L" D  Q  ;legal
 .. ;**71,Story 841921 (mko): Take into account two quotes -- convert to null
 .. S ARRAY("SURNAME")=$$QTON($P(NAME,COMP))
 .. S ARRAY("FIRST")=$$QTON($P(NAME,COMP,2))
 .. S ARRAY("MIDDLE")=$$QTON($P(NAME,COMP,3))
 .. S ARRAY("PREFIX")=$$QTON($P(NAME,COMP,5))
 .. S ARRAY("SUFFIX")=$$QTON($P(NAME,COMP,4))
 .. S ARRAY("NAME")=$$FMNAME^HLFNC($P(NAME,COMP,1,4))
 .;**67 - Story 455458 (ckn) - Parse Preferred Name
 . I $P(NAME,COMP,7)="N" D
 ..N PNAME
 ..S PNAME=$P(NAME,COMP) S ARRAY("PREFERREDNAME")=$S(PNAME=HL("Q"):"@",1:PNAME)
 .;**71,Story 841921 (mko): Put the name components into ARRAY("ALIAS",n,"NC")
 . I $P(NAME,COMP,7)="A" D
 .. N ALIASNC,ALIASNM
 .. S ALIASNC="" F I=1:1:4 S ALIASNC=ALIASNC_$$QTON($P(NAME,COMP,I))_COMP
 .. S ALIASNC=$P(ALIASNC,COMP,1,4),ALIASNM=$$FMNAME^HLFNC(ALIASNC)
 .. I $L(ALIASNM)>30,'$$GETFLAG^MPIFNAMC D
 ... N ALIAS
 ... S ALIAS("SURNAME")=$P(ALIASNC,COMP)
 ... S ALIAS("FIRST")=$P(ALIASNC,COMP,2)
 ... S ALIAS("MIDDLE")=$P(ALIASNC,COMP,3)
 ... S ALIAS("SUFFIX")=$P(ALIASNC,COMP,4)
 ... S ALIASNM=$$FMTNAME^RGADTP3(.ALIAS,30)
 .. S $P(ARRAY("ALIAS",IDCNT),"^")=ALIASNM
 .. S ARRAY("ALIAS",IDCNT,"NC")=$TR(ALIASNC,COMP,"^")
 .. S IDCNT=IDCNT+1 ;**48 alias
 Q
 ;
QTON(X) ;**71,Story 841921 (mko): Convert two quotes to null
 Q $S(X="""""":"",1:X)
 ;
