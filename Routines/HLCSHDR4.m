HLCSHDR4 ;SFIRMFO/LJA - Reset MSH Segment Fields ;10/09/2007 15:05
 ;;1.6;HEALTH LEVEL SEVEN;**93,108,122**;Oct 13, 1995;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified
 ;
DEBUG(STORE) ; If HLP set up for debugging, capture VIEW...
 ; HLMSH773 -- req
 ;
 N NOW,NUM,VAR,VARS,X,XTMP
 ;
 ; 1=some, 2=all
 S STORE=$S(STORE=1:1,STORE=2:2,1:0) QUIT:'STORE  ;->
 ;
 S NOW=$$NOW^XLFDT
 ;
 S XTMP="HLCSHDR3 "_HLMSH773
 S:'$D(^XTMP(XTMP,0)) ^XTMP(XTMP,0)=$$FMADD^XLFDT(NOW,0,4)_U_NOW_U_"Debug data created by DEBUG~HLCSHDR4"
 ;
 S NUM=$O(^XTMP(XTMP,":"),-1)+1
 ;
 ; Grab only critical (some) variables?
 I STORE=1 D
 .
 .  ; Sending information...
 .  S ^XTMP(XTMP,NUM,"SA")=HLMSHSAO_U_HLSAN_U_HLMSHSAN
 .  S ^XTMP(XTMP,NUM,"SF")=HLMSHSFO_U_HLSFN_U_HLMSHSFN
 .
 .  ; Receiving information...
 .  S ^XTMP(XTMP,NUM,"RA")=HLMSHRAO_U_HLRAN_U_HLMSHRAN
 .  S ^XTMP(XTMP,NUM,"RF")=HLMSHRFO_U_HLRFN_U_HLMSHRFN
 .
 .  ; Other information...    (HLMSHPRE and HLMSHPRS hold 2 pieces!)
 .  S ^XTMP(XTMP,NUM,0)=NOW_U_HLMSH772_U_HLMSHPRE_U_HLMSHPRS
 .  S ^XTMP(XTMP,NUM,1)=HLMSHPRO
 ;
 ; Grab all variables?
 I STORE=2 D
 .  S X="^XTMP("""_XTMP_""","_NUM_","
 .  D DOLRO^%ZOSV
 ;
 QUIT
 ;
SHOW N I773
 F  R !!,"Enter 773 IEN: ",I773:60 Q:I773'>0  D
 .  D SHOW773(I773)
 QUIT
 ;
SHOW773(I773) ; Show Dynamic Routing MSH Field Reset Details
 N DIV,MSH,N90,N91
 ;
 S N90=$G(^HLMA(+I773,90)),N91=$G(^HLMA(+I773,91))
 I (N90_N91)']"" D  QUIT  ;->
 .  W "  no debug data found..."
 ;
 S MSH=$G(^HLMA(+I773,"MSH",1,0)) QUIT:MSH']""  ;->
 S DIV=$E(MSH,4)
 ;
 W !!,$$CJ^XLFSTR(" 773 # "_I773_" ",IOM,"=")
 ;
 D HDR(90,N90)
 ;
 W !
 D HDR(91,N91)
 ;
 W !!,$E(MSH,1,IOM)
 ;
 S C1=10,C2=30,C3=50
 W !!,?C1,"Original (91)",?2,"Array (90)",?3,"MSH-Segment"
 W !,$$REPEAT^XLFSTR("-",IOM)
 D LINE("snd app",1,2,3)
 D LINE("snd fac",3,3,4)
 D LINE("rec app",5,4,5)
 D LINE("rec fac",7,5,6)
 ;
 QUIT
 ;
LINE(HDR,PCE1,PCE2,PCE3) ; Print one comparison line...
 N P1,P2,P3,P4
 S P1=$P(N91,U,PCE1),P2=$P(N90,U,PCE2),P3=$P(MSH,DIV,PCE3),P4=$P(N91,U,PCE1+1)
 W !,HDR,":",?C1,P1,?2,P2,?3,P3,$S(P4]"":" ["_P4_"]",1:"")
 QUIT
 ;
HDR(NUM,DATA) N TXT
 S TXT=$S(NUM=90:"Array (90)",NUM=91:"Original (91)",1:"")
 W !,$$CJ^XLFSTR("---------- "_TXT_" ----------",IOM)
 W $$CJ^XLFSTR(DATA,IOM)
 QUIT
 ;
SET(NEW,VAR,PCE) ; This subroutine performs these actions:
 ; (1) Resets variables used in MSH segment
 ; (2) Resets SERAPP and CLNTAPP in ^HLMA(#,0)
 ; (3) Sets HLMSH91 nodes if overwrite occurs by ARRAY value.
 ;     If overwrite occurs by M code, the overwrite has already
 ;     been recorded in HLMSH91.  (An overwrite produced by M code
 ;     is never overwritten by ARRAY data.)
 ;
 N IEN771N,IEN771O,HLTCP
 ;
 ; VAR is the name of the variable, and not it's value...
 S PRE=@VAR ; PRE is now the value of the VAR (pre-overwrite) variable...
 ;
 ; Tests whether anything was changed...
 QUIT:NEW']""  ;-> No new value exists to change to...
 QUIT:NEW=PRE  ;-> New value = Original value.  Nothing changed...
 ;
 ; THIS IS THE EPICENTER!!  This is where the variables used in
 ; the MSH segment is overwritten.
 S @VAR=NEW
 ;
 ; If PRE exists at this point, it was done by M code...
 QUIT:$P(HLMSH91,U,PCE)]""  ;->
 ;
 ; Change was made, but not by M code.  Must be by array...
 S $P(HLMSH91,U,PCE)=PRE,$P(HLMSH91,U,PCE+1)="A"
 ;
 ; patch HL*1.6*122: for "^" as component separater
 S $P(HLMSH91,U,PCE+2,999)=""
 ;
 ; Upgrade ^HLMA(#,0)...
 QUIT:PCE'=1&(PCE'=5)  ;->
 ;
 ; patch HL*1.6*108 start
 ;S IEN771O=$O(^HL(771,"B",PRE,0)) QUIT:IEN771O'>0  ;-> Orig IEN
 ;S IEN771N=$O(^HL(771,"B",NEW,0)) QUIT:IEN771N'>0  ;-> New IEN
 S IEN771O=$O(^HL(771,"B",$E(PRE,1,30),0)) QUIT:IEN771O'>0  ;-> Orig IEN
 S IEN771N=$O(^HL(771,"B",$E(NEW,1,30),0)) QUIT:IEN771N'>0  ;-> New IEN
 ; patch HL*1.6*108 end
 ;
 QUIT:'IEN771O!('IEN771N)!(IEN771O=IEN771N)  ;->
 S HLTCP=1 ; So 773 is updated...
 I PCE=1 D UPDATE^HLTF0(MTIENS,"","O","","",IEN771N)
 I PCE=5 D UPDATE^HLTF0(MTIENS,"","O","",IEN771N)
 ;
 QUIT
 ;
FIELDS ; Display the Protocol file fields used by the VistA HL7 package,
 ; when messages are received, to find the event and subscriber
 ; protocols.
 N BY,DIC,DIOEND,L
 ;
 D HD
 ;
 W !
 ;
 S L="",DIC="^ORD(101,",BY="[HL PROTOCOL MESSAGING FIELDS]"
 S DIOEND="D EXPL^HLCSHDR4"
 D EN1^DIP
 ;
 Q
 ;
HD W @IOF,$$CJ^XLFSTR("HL7 Protocol Messaging Fields",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 W !,"This 'HL7 Protocol Messaging Fields' report holds information that will help"
 W !,"you determine the effects from changes to routing-related fields in the MSH"
 W !,"segment when messages are sent between or within VistA HL7 systems."
 W !,"Additional explanation is included at the bottom of the report."
 Q
 ;
EXPL N I,T QUIT:'$$EXPL1("Press RETURN for 'printout help', or '^' to exit... ")  X "F I=1:1 S T=$T(EXPL+I) QUIT:T'["";;""  W !,$P(T,"";;"",2,99)" S I=$$EXPL1("Press RETURN to exit... ",1)
 ;;
 ;;When messages are received, their SENDING APPLICATION (MSH-3), MESSAGE
 ;;TYPE (MSH-9), EVENT TYPE (MSH-9), and HL7 VERSION (MSH-12) fields are used to
 ;;find the event driver protocol to be used in processing the just-received
 ;;message. After the event protocol is found, that protocol's subscriber
 ;;protocols are evaluated.  The subscriber protocol with a RECEIVING 
 ;;APPLICATION value that matches the RECEIVING APPLICATION field in the MSH
 ;;segment (MSH-5) is used.
 ;;
 ;;The first line for every "section" in the printout is the event driver
 ;;protocol. Lines preceded by dashes, are related subscriber protocols.  An
 ;;example is shown below.
 ;;
 ;;Snd/Rec App's    mTYP   eTYP   Ver        Protocol                     Link
 ;;------------------------------------------------------------------------------
 ;;AC-VOICERAD      ORU    R01    2.3    |   AC ORU SERVER
 ;;-AC-RADIOLOGY    ORU    R01    2.3    |   AC ORU CLIENT                NC  TCP
 ;;
 ;;In this example, the 'AC-VOICERAD' line holds information for the 'AC ORU
 ;;SERVER' event protocol.  And, the '-AC-RADIOLOGY' line holds information for
 ;;the 'AC ORU CLIENT' subscriber protocol.
 Q
 ;
EXPL1(PMT,FF) ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 QUIT:$E($G(IOST),1,2)'="C-" 1 ;->
 F X=1:1:$G(FF) W !
 S DIR(0)="EA",DIR("A")=PMT
 D ^DIR
 QUIT $S(Y=1:1,1:"")
 ;
M ; Covered by Integration Agreement #3988
 ; Application developers may call here when creating new messages,
 ; when experimenting with M code to evaluate and conditionally change
 ; routing-related fields. 
 ;
 ; This API is called immediately before the MSH segment is created.
 N IOINHI,IOINORM,MSHOLD,MSHNEW,MSHPRE,X
 ;
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 ;
 S MSHOLD=$$MSHBUILD(0),MSHPRE=$$MSHBUILD(1)
 W !!,"The original MSH segment is...",!!,IOINHI,MSHOLD,IOINORM
 I MSHPRE'=MSHOLD D
 .  W !!,"The MSH segment, after modification by passed-in data, is..."
 .  W !!,IOINHI,MSHPRE,IOINORM
 ;
 D MVAR("SENDING APPLICATION","HLMSHSAN","SERAPP")
 D MVAR("SENDING FACILITY","HLMSHSFN","SERFAC")
 D MVAR("RECEIVING APPLICATION","HLMSHRAN","CLNTAPP")
 D MVAR("RECEIVING FACILITY","HLMSHRFN","CLNTFAC")
 ;
 S MSHNEW=$$MSHBUILD
 I MSHNEW'=MSHPRE D
 .  W !!,"Before your changes above, the modified MSH segment was..."
 .  W !!,IOINHI,MSHPRE,IOINORM
 .  W !!,"After your changes, the MSH segment is..."
 .  W !!,IOINHI,MSHNEW,IOINORM
 W !!,$$REPEAT^XLFSTR("-",IOM)
 W !!,"Message being sent..."
 W !
 ;
 Q
 ;
MVAR(FLD,VAR,VARO) ; Generic resetting of variable...
 ;IOINHI,IOINORM -- req
 N ANS
 W !!,?4,"Protocol-derived value of ",FLD,": "
 W IOINHI,@VARO,IOINORM
 W !,"Passed-in value of ",FLD," (",VAR,"): "
 W IOINHI,@VAR,IOINORM
 W !,?10,"Enter new value for ",FLD,": "
 R ANS:60 Q:'$T  ;->
 I ANS[U!(ANS']"") D
 .  W !!,?10,"No changes will be made..."
 I ANS'[U&(ANS]"") D
 .  S @VAR=ANS
 .  W !!,?10,"The variable ",IOINHI,VAR,IOINORM
 .  W " will be changed to '",IOINHI,ANS,IOINORM,"'."
 .  W !,?10,"This value will be stored in the ",FLD
 .  W !,?10,"field in the MSH segment..."
 .  W !!,$$REPEAT^XLFSTR("-",IOM)
 Q
 ;
MSHBUILD(TYPE) ; Build MSH using current variables...
 N MSH,PCE,RAN,RFN,SAN,SFN
 S MSH="MSH"_FS_EC
 I $G(TYPE)=0 F PCE=SERAPP,SERFAC,CLNTAPP,CLNTFAC,HLDATE,SECURITY,MSGTYPE,HLID,HLPID,$P(PROT,U,9),"",$G(^HL(772,TXTP,1)),ACCACK,APPACK,CNTRY D
 .  S MSH=MSH_FS_PCE
 I $G(TYPE)'=0 D
 .  S SAN=HLMSHSAN,SAN=$S(SAN]"":SAN,1:SERAPP)
 .  S SFN=HLMSHSFN,SFN=$S(SFN]"":SFN,1:SERFAC)
 .  S RAN=HLMSHRAN,RAN=$S(RAN]"":RAN,1:CLNTAPP)
 .  S RFN=HLMSHRFN,RFN=$S(RFN]"":RFN,1:CLNTFAC)
 .  F PCE=SAN,SFN,RAN,RFN,HLDATE,SECURITY,MSGTYPE,HLID,HLPID,$P(PROT,U,9),"",$G(^HL(772,TXTP,1)),ACCACK,APPACK,CNTRY D
 .  .  S MSH=MSH_FS_PCE
 QUIT MSH
 ;
EOR ;HLCSHDR4 - Reset MSH Segment Fields ;9/12/02 11:50
