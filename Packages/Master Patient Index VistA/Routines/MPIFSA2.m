MPIFSA2 ;SF/CMC,CKN-STAND ALONE QUERY PART 2 ; 4/29/14 1:34pm
 ;;1.0;MASTER PATIENT INDEX VISTA;**28,29,35,38,43,52,55,57,59,66**;30 Apr 99;Build 2
 ;
 ;Integration Agreements: $$EN^HLCSAC - #3471
 ;
FIELD ;
 ;;@00108.1;LAST NAME;ST;30
 ;;@00122;SSN;ST;9
 ;;@00110;DOB;TS;8
 ;;@00756;PRIMARY CARE SITE;ST;6
 ;;@00105;ICN;ST;19
 ;;@00108.2;FIRST NAME;ST;30
 ;;@00169;TREATING FACILITY (MULTIPLE--FILE 985.5);ST;999
 ;;@00740;DATE OF DEATH;TS;8
 ;;@00108.3;MIDDLE;ST;16
 ;;@00111;SEX;ST;1
 ;;@00126.1;BIRTH PLACE CITY;ST;30
 ;;@00126.2;BIRTH PLACE STATE;ST;3
 ;;@00108.5;NAME PREFIX;ST;15
 ;;@00108.4;NAME SUFFIX;ST;10
 ;;@00109.1;MOTHER'S MAIDEN NAME;ST;20
 ;;@ZEL6;CLAIM NUMBER;ST;9
 ;;@CASE#;MPI DUP CASE#;ST;69
 ;;@POW;POW STATUS;ST;1
 ;;@00127;MULTIPLE BIRTH INDICATOR;ST;1
 ;;@00112.1;ALIAS LAST NAME;ST;30
 ;;@00112.2;ALIAS FIRST NAME;ST;25
 ;;@00112.3;ALIAS MIDDLE NAME;ST;25
 ;;@00112.5;ALIAS PREFIX;ST;10
 ;;@00112.4;ALIAS SUFFIX;ST;10
 ;;@00114.1;STREET ADDRESS LINE 1;ST;35
 ;;@00114.2;STREET ADDRESS LINE 2;ST;30
 ;;@00114.3;CITY;ST;28
 ;;@00114.8;STREET ADDRESS LINE 3;ST;30
 ;;@00116;PHONE NUMBER (RESIDENCE);ST;23
 ;;@SCORE;SCORE;ST;8
 ;;@ALTRSHLD;AUTOLINK THRESHOLD;ST;5
 ;;@TKTRSHLD;TASK THRESHOLD;ST;5
 ;;
VTQ(MPIVAR) ;
 N TIME,% D NOW^%DTC S TIME=%
 W !!,"Attempting to connect to the Master Patient Index in Austin...",!,"If DOB is inexact or if SSN is not passed or if common name,",!,"this could take some time - please be patient...."
 N HL,MPIQRYNM,MPIINM,MPIOUT,MPIIN,MPIMCNT,MPICNT,MPICS,HEADER,RDF,QUERY,TEST,SITE,MPIDC,MPINM,MPI1NM,MPI2NM,MPIESC,MPIHDOB,MPIRS,MPISCS,QUEDDOB,MPIFLDV
 S HLP("ACKTIME")=300,HL("ECH")="^~\&",HL("FS")="|",MPIIN="",MPICNT=1,MPICS=$E(HL("ECH"),1)
 ;**43 CHANGING QUERY NAME FROM VTQ_PID_ICN_NO_LOAD TO VTQ_DISPLAY_ONLY_QUERY to enable the returning of potential matches and not just exact matches
 S MPIQRYNM="VTQ_DISPLAY_ONLY_QUERY"
 I '$D(MPIVAR("DFN")) S MPIVAR("DFN")=""
 S MPIMCNT=MPIVAR("DFN")
 ;SETUP VTQ
 S MPICS=$E(HL("ECH"),1),MPIRS=$E(HL("ECH"),2),MPISCS=$E(HL("ECH"),4),MPIESC=$E(HL("ECH"),3)
 D BLDRDF(.MPIOUT,3,MPIRS,MPICS)
 ; ^ fields to be returned in query response
 S QUERY="VTQ"_HL("FS")_$G(MPIVAR("DFN"))_HL("FS")_"T"_HL("FS")_MPIQRYNM_HL("FS")_"ICN"_HL("FS")
 S MPI2NM=$P($G(MPIVAR("NM")),",",1),QUERY=QUERY_"@00108.1"_MPICS_"EQ"_MPICS_MPI2NM ; ^ sending last name
 I MPIVAR("SSN")'="" S QUERY=QUERY_MPICS_"AND"_MPIRS_"@00122"_MPICS_"EQ"_MPICS_$G(MPIVAR("SSN")) ; ^ sending SSN
 S MPI1NM=$P($G(MPIVAR("NM")),",",2),MPI1NM=$P(MPI1NM," ",1) I MPI1NM'="" S QUERY=QUERY_MPICS_"AND"_MPIRS_"@00108.2"_MPICS_"EQ"_MPICS_MPI1NM
 ; ^ sending first name
 I $G(MPIVAR("DOB"))>0 D
 .S MPIHDOB=$$HLDATE^HLFNC(MPIVAR("DOB")) ; send date of birth (convert to hl7 date format)
 .S QUEDDOB=MPICS_"AND"_MPIRS_"@00110"_MPICS_"EQ"_MPICS_MPIHDOB,QUERY=QUERY_QUEDDOB ; ^ sending date of birth
 S MPI1NM=$P($G(MPIVAR("NM")),",",2),MPIMID=$P(MPI1NM," ",2) I MPIMID'="" S QUERY=QUERY_MPICS_"AND"_MPIRS_"@00108.3"_MPICS_"EQ"_MPICS_MPIMID ; sending middle name
 S MPISUF=$P(MPI1NM," ",3) I MPISUF'="" S QUERY=QUERY_MPICS_"AND"_MPIRS_"@00108.4"_MPICS_"EQ"_MPICS_MPISUF ; sending suffix
 S MPIPRE=$P(MPI1NM," ",4) I MPIPRE'="" S QUERY=QUERY_MPICS_"AND"_MPIRS_"@00108.5"_MPICS_"EQ"_MPICS_MPIPRE ; sending prefix
 I $G(MPIVAR("SEX"))'="" S QUERY=QUERY_MPICS_"AND"_MPIRS_"@00111"_MPICS_"EQ"_MPICS_$G(MPIVAR("SEX")) ;sending sex
 I $G(MPIVAR("ADDR1"))'="" S QUERY=QUERY_MPICS_"AND"_MPIRS_"@00114.1"_MPICS_"EQ"_MPICS_$G(MPIVAR("ADDR1")) ;sending Address 1
 I $G(MPIVAR("ADDR2"))'="" S QUERY=QUERY_MPICS_"AND"_MPIRS_"@00114.2"_MPICS_"EQ"_MPICS_$G(MPIVAR("ADDR2")) ;sending Address 2
 I $G(MPIVAR("CITY"))'="" S QUERY=QUERY_MPICS_"AND"_MPIRS_"@00114.3"_MPICS_"EQ"_MPICS_$G(MPIVAR("CITY")) ;sending City
 I $G(MPIVAR("ADDR3"))'="" S QUERY=QUERY_MPICS_"AND"_MPIRS_"@00114.8"_MPICS_"EQ"_MPICS_$G(MPIVAR("ADDR3")) ;sending Address 3
 I $G(MPIVAR("PHONE"))'="" S QUERY=QUERY_MPICS_"AND"_MPIRS_"@00116"_MPICS_"EQ"_MPICS_$G(MPIVAR("PHONE")) ;sending Residence Phone
 ;keep following traits for future use
 ;I $G(MPIVAR("MMN"))'="" S QUERY=QUERY_MPICS_"AND"_MPIRS_"@00109.1"_MPICS_"EQ"_MPICS_$G(MPIVAR("MMN")) ;sending Mother's maiden name
 ;I $G(MPIVAR("CLAIM"))'="" S QUERY=QUERY_MPICS_"AND"_MPIRS_"@ZEL6"_MPICS_"EQ"_MPICS_$G(MPIVAR("CLAIM")) ;sending Claim #
 ;I $G(MPIVAR("POBCITY"))'="" S QUERY=QUERY_MPICS_"AND"_MPIRS_"@00126.1"_MPICS_"EQ"_MPICS_$G(MPIVAR("POBCITY")) ;sending POB city
 ;I $G(MPIVAR("POBSTATE"))'="" S QUERY=QUERY_MPICS_"AND"_MPIRS_"@00126.2"_MPICS_"EQ"_MPICS_$G(MPIVAR("POBSTATE")) ;sending POB State
 S SITE=$$SITE^VASITE,SITE=$P(SITE,"^",3) ;**29
 S HEADER="MSH"_HL("FS")_HL("ECH")_HL("FS")_"MPI_LOAD"_HL("FS")_SITE_HL("FS")_"MPI-ICN"_HL("FS")_HL("FS")_HL("FS")_HL("FS")_"VQQ"_MPICS_"Q02"_HL("FS")_MPIMCNT_"-"_MPICNT_HL("FS") ;create msh **38 changed VTQ to VQQ
 S MPIOUT(1)=HEADER K MPIOUT(0) S MPIOUT(2)=QUERY
 ;Attempt to connect to MPI and send message,receive message. Message is returned in MPIDC array
 S TEST=$$EN^HLCSAC("MPIVA DIR","MPIOUT","MPIDC")
 K HLP("ACKTIME") ;Clean up the ack timeout HLP array variable
 I +TEST<0 W !!,"Could not connect to MPI or Time-out occured, try again later." G EXIT
 K ^TMP("MPIFVQQ",$J),^TMP("MPIDOQ",$J)
INIPARS ;
 N SEG,INDEX,SKIP,CHECK,AL,TTF2,TFLL,TF,TF2,MPIREP,MPICOMP
 S INDEX=0 K CHECK
LOOP1 ;
 ;process in ADT type messages
 N MPIX S MPIX=0 N REP,SG,MSG,MPIQUIT,MPINODE
 S MPIQUIT=0
 F MPIX=0:1 X "D LOOP2" D  K MPINODE,MSG Q:MPIQUIT'>0
 . I $D(MPINODE(1)) S SG=$E(MPINODE(1),1,3) S MSG(1)=MPINODE(1) D
 ..  S MPIJ=1 F  S MPIJ=$O(MPINODE(MPIJ)) Q:'MPIJ  S MSG(MPIJ)=MPINODE(MPIJ)
 .. D:SG?2A1(1A,1N) @SG
 I '$D(^TMP("MPIFVQQ",$J)) W !!,"Patient was not found in the MPI." G EXIT
 I INDEX>9 W !!,"More Identity Traits Required to Make a Match." G EXIT
DISPLAY ; display data found
 I INDEX>1 W !!,"Found potential matches"
 I INDEX=1 W !!,"Found One Match"
 N CNT1,CNT2,STOP,CNTR2,TTF,CNT3,DIR,X,Y,DATA,PREFIX,ANAME,APRE,ALN,AFN,NAME,SSN,BIRTHDAY,CMOR,TF,ICN,POBC,POBS,PAST,XXX,AMID,ASUF
 N MNAME,SUFFIX,SEX,IEN,CMOR2,TF2,CLAIM,CASE,NOIS,CUSER,TFN,CMOR3,POW,MBIRTH,TIEN,MIDDLE,SCORE,ALTRSHLD,TKTRSHLD,I
 S (CNT1)=0
 F  S CNT1=$O(^TMP("MPIFVQQ",$J,CNT1)) Q:CNT1'>0!($D(STOP))  D
 . S DATA=$G(^TMP("MPIFVQQ",$J,CNT1,"DATA"))
 . Q:DATA=""
 . K CHECK S NAME=$P(DATA,"^"),SSN=$P(DATA,"^",3),BIRTHDAY=$P(DATA,"^",4),ICN=$P(DATA,"^",6)
 . S SEX=$P(DATA,"^",11),SCORE=$P(DATA,"^",21),ALTRSHLD=$P(DATA,"^",22),TKTRSHLD=$P(DATA,"^",23)
 . I $G(SCORE)="" W !!,"IdM System uavailable, try again later!" S STOP=1 Q  ;Quit if no score is returned.
 . ;**55 MPIC_2218  Commented the following two lines, added the third
 . ;I SCORE>=ALTRSHLD S M="E"
 . ;I SCORE<ALTRSHLD,(SCORE>=TKTRSHLD) S M="P"
 . S M=$S(SCORE>=ALTRSHLD:"E",1:"P")
 . ;Rearranging array for sectional view display
 . ;S FULLICN=ICN   ;**57 - MVI_2350 (cml)
 . ;**59 - MVI_3785 (ckn) - Storing full ICN in TMP global so it
 . ;display full ICN correctly. Removing + sign in front of ICN
 . ;in below lines.
 . S ^TMP("MPIDOQ",$J,M,SCORE,ICN)=NAME_"^"_SSN_"^"_BIRTHDAY_"^"_SEX
 . M ^TMP("MPIDOQ",$J,M,SCORE,ICN,"TF")=^TMP("MPIFVQQ",$J,CNT1,"TF")
 I $D(STOP) Q  ;Quit if no score is returned
DISP2 ;
 S COUNT=0
 W @IOF
 F I="E","P" D
 . I $D(^TMP("MPIDOQ",$J,I)) D HDR($S(I="E":"",I="P":" POTENTIAL",1:""))
 . S SCORE=9999999 F  S SCORE=$O(^TMP("MPIDOQ",$J,I,SCORE),-1) Q:SCORE=""  D
 . . S ICN=0 F  S ICN=$O(^TMP("MPIDOQ",$J,I,SCORE,ICN)) Q:ICN=""  D
 . . . S ICNARR(ICN)="",COUNT=COUNT+1
 . . . S DATA=$G(^TMP("MPIDOQ",$J,I,SCORE,ICN))
 . . . D HDR1
 . . . ;**59 - MVI_3785 (ckn) - replacing FULLICN with ICN
 . . . W !,COUNT_") ",?4,ICN,?22,$P(DATA,"^"),?54,$P(DATA,"^",2),?65,$P(DATA,"^",3),?76,$P(DATA,"^",4)  ;**57 - MVI_2350 (cml)
 . . . W ! N TMP S XXX=0 F  S XXX=$O(^TMP("MPIDOQ",$J,I,SCORE,ICN,"TF",XXX)) Q:XXX=""  S TMP=$G(^TMP("MPIDOQ",$J,I,SCORE,ICN,"TF",XXX)) Q:TMP=""  D
 . . . . S TMP=$P(TMP,"^",1) W !,?10,"Treating Facility: ",$P($$NS^XUAF4($$LKUP^XUAF4(TMP)),"^")," (",TMP,")"
 . . . W !
 S ENOUGH=0
 W !
 D ASK I ENOUGH G EXIT
 ;**59 - MVI_3785 (ckn) - send short ICN in ENRPC tag.
 I TMPICN'="" W !,"Please wait..." D ENRPC(+TMPICN)
 W !!
 K DIR,DA S DIR(0)="Y",DIR("B")="NO",DIR("A")="Would you like to see another record" D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S ENOUGH=1 G EXIT
 I Y G DISP2
EXIT K DA,X,Y,^TMP("MPIDOQ",$J) W !! Q
HDR(HDL) ;Header
 W !,"--- All ICNs Below meet the"_HDL_" Match criteria ---"
 Q
HDR1 ;Repeating header
 ; Story 603957 (elz) change Sex to Birth Sex
 W !,?74,"BIRTH"
 W !,?4,"ICN",?22,"NAME",?54,"SSN",?65,"DOB",?75,"SEX"  ;**57 - MVI_2350 (cml)
 Q
ASK ;
 N DIR,DA,DR,ND,SC,CNTR,BC,EC,ICN
 S EC=0,BC=1
 S TMP=0 F  S TMP=$O(ICNARR(TMP)) Q:TMP=""  S EC=EC+1
 K DIR,X,Y S DIR(0)="NA^"_BC_":"_EC,DIR("A")="Enter the Number to display the details: ",DIR("?")="Enter the number from range of "_BC_" to "_EC D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S ENOUGH=1 Q
 S QFLG=0,CNTR=0
 F I="E","P" D
 . S SC=10000 F  S SC=$O(^TMP("MPIDOQ",$J,I,SC),-1) Q:SC=""!(QFLG)  D
 ..S ICN=0 F  S ICN=$O(^TMP("MPIDOQ",$J,I,SC,ICN)) Q:ICN=""!(QFLG)  D
 ...S CNTR=CNTR+1 I CNTR=+Y S QFLG=1,TMPICN=ICN
 Q
ENRPC(ICN) ;RPC Call
 N LOC,HNDL,RETURN,I,ND
 S LOC="200M"
 D EN1^XWB2HL7(.RETURN,LOC,"MPIF EDAT REMOTE",1,ICN)
 S HNDL=$G(RETURN(0))
 ;**57,MVI_1414: Check whether EN^XWB2HL7 call succeeded
 I HNDL="" W:+$G(RETURN(1))=-1 !,$P(RETURN(1),"^",2) Q
 I +HNDL=-1 W !,$P(HNDL,"^",2) Q
 F I=1:1:20 K RETURN D RPCCHK^XWB2HL7(.RETURN,HNDL) Q:+RETURN(0)=1  Q:+RETURN(0)=-1  W "." H 5
 I +RETURN(0)=-1 W !,$P(RETURN(0),"^",2) Q
 I +RETURN(0)'=1 W !,"MPI system is unavailable to display the record, Try again later." Q
 ;S DONE=0
 ;F I=1:1:20 D  Q:DONE
 ;. H 5 W "."
 ;. D RTNDATA^XWBDRPC(.RETURN,HNDL)
 ;. Q:$P(RETURN(0),"^")=0
 ;. I $P(RETURN(0),"^")=-1 D  Q
 ;. . I RETURN(0)["Not DONE" Q
 ;. S DONE=1
 ;I 'DONE W !,"MPI system is unavailable to display the record, Try again later." Q
 ;I DONE,$G(^XTMP(HNDL,"D",1))'="" D
 I $G(^XTMP(HNDL,"D",1))'="" D
 . W @IOF S $Y=1
 . S ND=0 F  S ND=$O(^XTMP(HNDL,"D",ND)) Q:ND=""  D
 ..W !,^XTMP(HNDL,"D",ND)
 K ^XTMP(HNDL),RETURN
 Q
LOOP2 ;
 N MPIDONE,MPII,MPIJ
 S MPII=0,MPIDONE=0
 F  S MPIQUIT=$O(MPIDC(MPIQUIT)) Q:'MPIQUIT  D  Q:MPIDONE
 . I MPIDC(MPIQUIT)="" S MPIDONE=1 Q
 . S MPII=MPII+1,MPINODE(MPII)=$G(MPIDC(MPIQUIT)) Q
 Q
MSH ;
 S MPIREP=$E(HL("ECH"),2),MPICOMP=$E(HL("ECH"),1)
 Q
MSA ;
 Q
RDF ;
 Q
QAK ;
 Q
RDT ;
 S INDEX=$G(INDEX)+1
 D RDT^MPIFSA3(.INDEX,.HL,.MSG)
 Q
BLDRDF(MPIOUT,MPICNT,MPIRS,MPICS) ;
 S MPIOUT(MPICNT)="RDF"_HL("FS")_32_HL("FS") N T,I F I=1:1 S T=$T(FIELD+I) Q:$P(T,";",3)=""  D
 . I I=1 S MPIFLDV=$P(T,";",3)_MPICS_$P(T,";",5)_MPICS_$P(T,";",6)
 . I I'=1 S MPIFLDV=MPIRS_$P(T,";",3)_MPICS_$P(T,";",5)_MPICS_$P(T,";",6)
 .N XLEN,TOTLEN
 . S TOTLEN=$L($G(MPIOUT(MPICNT)))+$L(MPIFLDV)
 . I TOTLEN'>245 S MPIOUT(MPICNT)=$G(MPIOUT(MPICNT))_MPIFLDV Q
 . I TOTLEN>245 D
 .. S XLEN=245-$L($G(MPIOUT(MPICNT)))
 .. S MPIOUT(MPICNT)=$G(MPIOUT(MPICNT))_$E(MPIFLDV,1,XLEN),MPICNT=MPICNT+1
 .. S MPIOUT(MPICNT)=$E(MPIFLDV,XLEN+1,245)
 Q
