HLCSHDR3 ;SFIRMFO/LJA - Reset MSH Segment Fields ;03/24/04 11:19
 ;;1.6;HEALTH LEVEL SEVEN;**93,108**;Oct 13, 1995
 ;
 ; Reset RECEIVING APPLICATION and RECEIVING SITE of MSH segment - HL*1.6*93
 ;
RESET ; Called from HEADER^HLCSHDR1 & BHSHDR^HLCSHDR1, which is called by
 ; GENERATE^HLMA & GENACK^HLMA1.
 N MTIEN
 ;
 ; Even if set already, set 772 IEN again...
 S MTIEN=+$G(^HLMA(+$G(IEN),0)) QUIT:$G(^HL(772,+MTIEN,0))']""  ;->
 ;
 ; Different variables used for Event Protocol
 D MSHCHG($G(HLEID),$S($G(EIDS)>0:+EIDS,1:+$G(HLEIDS)),$G(MTIEN),$G(IEN),.SERAPP,.SERFAC,.CLNTAPP,.CLNTFAC,.HLP)
 ;
 QUIT
 ;
MSHCHG(HLEID,EIDS,MTIEN,IEN,SERAPP,SERFAC,CLNTAPP,CLNTFAC,HLPARR) ; The parameters
 ; are the required input variables.  Call here "by reference".  
 ;
 ;  HLEID=Event driver protocol IEN
 ;   EIDS=Subscriber protocol IEN
 ;  MTIEN=772 IEN
 ;    IEN=773 IEN
 ; SERAPP=Sending App text
 ; SERFAC=Sending Fac text
 ;CLNTAPP=Rec (client) app text
 ;CLNTFAC=Rec (client) fac text
 ;   HLP()=HLP("SUBSCRIBER") array
 ;
 ; The MSH segment is built (usually) in HLCSHDR1.  Immediately before
 ; using the existing local variables to concatenate them together into
 ; the MSH segment, HLCSHDR1 calls here to see if some of the local
 ; variables should be reset.
 ;
 ; Resetting the local variables used in creating the MSH segment
 ; gives those creating HL7 messages control over the local variables
 ; that can be changed below.
 ;
 ; There are rules that govern what the creator of the MSH segment
 ; can change:
 ;
 ; Rule #1: The SENDING APPLICATION can be changed.   Var=HLMSHSAN
 ; Rule #2: The SENDING FACILITY can be changed.      Var=HLMSHSFN
 ; Rule #3: The RECEIVING APPLICATION can be changed. Var=HLMSHRAN
 ; Rule #4: The RECEIVING FACILITY can be changed.    Var=HLMSHRFN
 ; Rule #5: No other fields in the MSH segment can be changed.
 ;
 ; If the passed in HLP() array entry used to reset the above four
 ; fields holds the text used, the variables above will be reset.
 ; If M code is used, the M code itself is responsible for setting
 ; these specific local variables.
 ;
 ; The following local variables are created and made available for
 ; use by M code:
 ;
 ; Protocol, Event:                  HLMSHPRE  (IEN^NAME)
 ; Protocol, Subscriber:             HLMSHPRS  (IEN^NAME)
 ;
 ; HL Message Text file (#772) IEN:  HLMSH772  (IEN)
 ; HL Message Admin file (#773) IEN: HLMSH773  (IEN)
 ; 
 ; Sending Application, Original:    HLMSHSAO  (SERAPP)
 ; Sending Application, New:         HLMSHSAN
 ; Sending Facility, Original:       HLMSHSFO  (SERFAC)
 ; Sending Facility, New:            HLMSHSFN
 ; Receiving Application, Original:  HLMSHRAO  (CLNTAPP)
 ; Receiving Application, New:       HLMSHRAN
 ; Receiving Facility, Original:     HLMSHRFO  (CLNTFAC)
 ; Receiving Facility, New:          HLMSHRFN
 ;
 ; M Code SUBROUTINE:                HLMSHTAG
 ; M Code ROUTINE:                   HLMSHRTN
 ;
 ; See the documentation in patch HL*1.6*93 in the Forum patch module
 ; for additional information.
 ;
 ; CLIENT -- req
 ;
 ; HLMSH-namespaced variables created below
 N HLDEBUG,HLMSH101,HLMSH31,HLMSH31C,HLMSH32,HLMSH32C
 N HLMSH33,HLMSH33C,HLMSH34,HLMSH34C,HLMSH772,HLMSH773,HLMSH91
 N HLMSHAN,HLMSHFN,HLMSHPRE,HLMSHPRS
 N HLMSHRTN,HLMSHRAN,HLMSHRAO,HLMSHRFN
 N HLMSHRFO,HLMSHSAN,HLMSHSAO,HLMSHSFN,HLMSHSFO
 N HLMSHPRO,HLMSHREF,HLMSHSUB,HLMSHTAG
 ;
 ; Non-HLMSH-namespaced variables created below
 N HLPWAY,HLRAN,HLRFN,HLSAN,HLSFN,HLTYPE
 ;
 ;
 ; Set up variables pass #1...
 S (HLMSH31,HLMSH32,HLMSH33,HLMSH34)=""
 S (HLMSH31C,HLMSH32C,HLMSH33C,HLMSH34C)=""
 S HLMSHPRE=$G(HLEID)_U_$P($G(^ORD(101,+$G(HLEID),0)),U) ; Event 101
 S HLMSHPRS=$G(EIDS)_U_$P($G(^ORD(101,+$G(EIDS),0)),U) ; Sub 101
 S HLMSH772=$G(MTIEN)
 S HLMSH773=$G(IEN) QUIT:'$D(^HLMA(+HLMSH773,0))  ;->
 ;
 ; Get passed-in-by-reference HLP("SUBSCRIBER") data into variable...
 S HLMSHPRO=$$HLMSHPRO QUIT:HLMSHPRO']""  ;->
 ;
 ; Should DEBUG data be stored? (This can be overwritten in $$HLMSHPRO)
 I $G(HLDEBUG)']"" S HLDEBUG=$P($P(HLMSHPRO,"~",2),U,8)
 ;                   HLDEBUG might be already set in $$HLMSHPRO
 S HLDEBUG=$TR(HLDEBUG,"- /",U) ; Change delimiters to ^
 ;
 ; HLDEBUG (#1-#2-#3) Explanation...
 ; -- #1 can be 0 (NO) or 1 (YES) for whether ^HLMA(#,90) data stored
 ; -- #2 can be 0 or 1 for whether ^HLMA(#,91) data should be stored
 ; -- #3 can be 0 or 1 or 2 for what type of ^XTMP data should be stored
 ;    -- Data is stored in ^XTMP("HLCSHDR3 "_IEN773)
 ;    -- 0 = No XTMP data should be stored
 ;    -- 1 = Store only SOME of the data
 ;    -- 2 = Store ALL variable data
 ;       
 ; Store HLP("SUBSCRIBER"[,#]) in ^HLMA(#,90)
 I $P(HLDEBUG,U)=1 D
 .  S X=$P(HLMSHPRO,"~",2) I X]"" S ^HLMA(+HLMSH773,90)=X
 ;
 ; Found by general HLP("SUBSCRIBER") or specific HLP("SUBSCRIBER",#) entry?
 ; patch HL*1.6*108 start
 S HLPWAY=$P(HLMSHPRO,"~"),X=$L(HLMSHPRO,"~"),HLMSHREF=$P(HLMSHPRO,"~",+X),HLMSHPRO=$P(HLMSHPRO,"~",+2,+X-1)
 ; Above line modified by LJA - 3/18/04  Original line shown below.
 ; S HLPWAY=$P(HLMSHPRO,"~"),HLMSHREF=$P(HLMSHPRO,"~",3),HLMSHPRO=$P(HLMSHPRO,"~",2)
 ; patch HL*1.6*108 end
 ;
 ; Set up variables pass #2...
 S HLMSHSAO=$G(SERAPP),(HLSAN,HLMSHSAN)=$P(HLMSHPRO,U,2) ;  Send App
 S HLMSHSFO=$G(SERFAC),(HLSFN,HLMSHSFN)=$P(HLMSHPRO,U,3) ;  Send Fac
 S HLMSHRAO=$G(CLNTAPP),(HLRAN,HLMSHRAN)=$P(HLMSHPRO,U,4) ; Rec App
 S HLMSHRFO=$G(CLNTFAC),(HLRFN,HLMSHRFN)=$P(HLMSHPRO,U,5) ; Rec Fac
 ;
 ; If there's an Xecution routine, do now...
 S HLMSHTAG=$P(HLMSHPRO,U,6),HLMSHRTN=$P(HLMSHPRO,U,7)
 I HLMSHTAG]"",HLMSHRTN]"" D @HLMSHTAG^@HLMSHRTN
 I HLMSHTAG']"",HLMSHRTN]"" D ^@HLMSHRTN
 ;
 ; Start work for ^HLMA(#,91) node...
 S HLMSH91="" ; HLMSH91 is the data that will be stored in ^(91)
 I SERAPP'=HLMSHSAN D SET91M(1,SERAPP,HLSAN,HLMSHSAN) ; Reset by M code?
 I SERFAC'=HLMSHSFN D SET91M(3,SERFAC,HLSFN,HLMSHSFN)
 I CLNTAPP'=HLMSHRAN D SET91M(5,CLNTAPP,HLRAN,HLMSHRAN)
 I CLNTFAC'=HLMSHRFN D SET91M(7,CLNTFAC,HLRFN,HLMSHRFN)
 ;
 ; The real resetting of MSH segment variables work is done here...
 D SET^HLCSHDR4(HLMSHSAN,"SERAPP",1) ; Update SERAPP if different, and DATA too...
 D SET^HLCSHDR4(HLMSHSFN,"SERFAC",3) ; Etc
 D SET^HLCSHDR4(HLMSHRAN,"CLNTAPP",5) ; Etc
 D SET^HLCSHDR4(HLMSHRFN,"CLNTFAC",7) ; Etc
 ;
 ; Set ^HLMA(#,91) node if overwrites occurred...
 I HLMSH91]"" S ^HLMA(+HLMSH773,91)=HLMSH91
 ;
 ; If debugging, record pre variable view...
 D DEBUG^HLCSHDR4($P(HLDEBUG,U,3))
 ;
 QUIT
 ;
SET91M(PCE,MSH,PREM,POSTM) ; If M code re/set the MSH field, record...
 QUIT:PREM=POSTM  ;-> M code did not change anything...
 S $P(HLMSH91,U,PCE)=MSH ;  original (pre-overwrite) value
 S $P(HLMSH91,U,PCE+1)="M" ; Overwrite source (A/M)
 QUIT
 ;
HLMSHPRO() ; Determines whether to use the generic HLP("SUBSCRIBER") data,
 ; or instead - if existent - the HLP("SUBSCRIBER",#)=SUB PROTOCOL^... data
 ;CLIENT -- req
 N HLD,HLFIND,HLI,HLMSHREF,HLMSHSUB,HLX
 ;
 ; Get the default information...
 S HLMSHSUB=$G(HLP("SUBSCRIBER")),HLMSHREF=999
 ;
 ; Overwrite HLMSHSUB if found...
 S HLI=0,HLFIND=""
 F  S HLI=$O(HLP("SUBSCRIBER",HLI)) Q:HLI'>0!(HLFIND]"")  D
 .  S HLD=$G(HLP("SUBSCRIBER",+HLI)) QUIT:HLD']""  ;->
 .  S HLD=$P(HLD,U) QUIT:HLD']""  ;->
 .  ; If passed name..
 .  I HLD'=+HLD S HLD=$$FIND101(HLD)
 .  ; Must have IEN by now...
 .  QUIT:+HLD'=+HLMSHPRS  ;-> Not for right subscriber protocol
 .  S HLFIND=HLP("SUBSCRIBER",+HLI),HLMSHREF=+HLI
 ;
 ; Backdoor overwrite of HLDEBUG value...
 ; - This is a very important back door!!  Even if applications
 ; - aren't logging debug data, it can be turned on by setting
 ; - ^XTMP("HLCSHDR3 DEBUG","DEBUG") or ^XTMP("HLCSHDR3 DEBUG","DEBUG",SUB-101)
 ; If the GENERAL entry exists, set HLDEBUG.  Might be written next line though
 S HLX=$G(^XTMP("HLCSHDR3 DEBUG","DEBUG")) I HLX]"" S HLDEBUG=HLX
 ; If a SPECIFIC entry found, reset HLDEBUG to it...
 S HLX=$G(^XTMP("HLCSHDR3 DEBUG","DEBUG",+HLFIND)) I HLX]"" S HLDEBUG=HLX
 ;
 QUIT $S(HLFIND]"":"S~"_HLFIND_"~"_HLMSHREF,HLMSHSUB]"":"G~"_HLMSHSUB_"~"_HLMSHREF,1:"")
 ;
FIND101(PROTNM) ; Find 101 entry...
 N D,DIC,X,Y
 S DIC="^ORD(101,",DIC(0)="MQ",D="B",X=PROTNM
 D MIX^DIC1
 QUIT $S(Y>0:+Y,1:"")
 ;
SHOW773(IEN773) ; Show reset info from 773 entry...
 QUIT
 ;
EOR ;HLCSHDR3 - Reset MSH Segment Fields ;9/12/02 11:50
