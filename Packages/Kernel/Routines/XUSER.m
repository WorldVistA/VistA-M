XUSER ;ISP/RFR - A common set of user functions ;06/09/15  10:51
 ;;8.0;KERNEL;**75,97,99,150,226,267,288,330,370,373,580,609,642,739,751,689**;Jul 10, 1995;Build 113
 ;Per VA Directive 6402, this routine should not be modified.
 ;Covered under DBIA #2343
 Q
LOOKUP(XUF) ;Do a user lookup
 ;Parameter, "Q" to NOT ask OK.
 ;Parameter, "A" Don't select current users who have a termination
 ;               date prior to today's date
 N DIC,XUDA,DIR,Y
LK1 S DIC="^VA(200,",DIC(0)="AEMQZ" D ^DIC S XUDA=Y G:Y'>0 LKX
 S Y=$P(Y(0),U,11) I Y>0,Y<DT W !?15,"This user was terminated on ",$$FMTE^XLFDT(Y) I $G(XUF)["A" S XUDA=-1 G LK1
 G:$G(XUF)["Q" LKX
 S DIR(0)="Y",DIR("A")=" Is "_$P(XUDA,U,2)_" the one you want",DIR("B")="YES" D ^DIR
 I Y'=1 S XUDA=-1 G:'$D(DIRUT) LK1
 ;
LKX Q XUDA
 ;
ACTIVE(XUDA) ;Get if a user is active.
 N %,X1,X2
 S X1=$G(^VA(200,+$G(XUDA),0)),X2=$S(X1="":"",1:0)
 I $L($P(X1,U,3)) S X2="1^"_$S($L($P($G(^VA(200,XUDA,.1)),U,2)):"ACTIVE",1:"NEW")
 S:$P(X1,U,7)=1 X2="0^DISUSER"
 S:X2["ACTIVE" $P(X2,U,3)=$P($G(^VA(200,XUDA,1.1)),U) ;Return last sign-on
 S %=$P(X1,U,11) I %>0,%'>DT S X2="0^TERMINATED^"_%
 Q X2
 ;
BULL ;Called from bulletin in DD of file #200 for 'Sub Alt Name' fld.
 ;This will find users with PSDMGR keys and setup the XMY array for
 ;bulletin recipients. p580 REM
 ; ZEXCEPT: XMY - Kernel exemption
 N PSD,I
 S PSD=$$FIND1^DIC(19.1,"","MX","PSDMGR","","","PSDERR") Q:PSD'>0
 S I=0 F  S I=$O(^VA(200,"AB",PSD,I)) Q:I'>0  S XMY(I)=""
 Q
 ;
PROVIDER(XUDA,XUF) ;See if user qualifies as a CPRS provider
 ;XUDA = IEN of Record in New Person File
 ;XUF = Flag to control processing
 ;      0 or not passed, do not include Visitors
 ;      1 include Visitors
 N %,X1,X2,XUORES
 ;Test to see if XUDA Passed:
 I '$D(XUDA) Q ""
 ;
 ;Test for valid IEN:
 S X1=$G(^VA(200,+$G(XUDA),0)),X2=$S(X1="":"",1:1) Q:X2="" ""
 ;
 ;See if user has XUORES Security Key:
 S XUORES=$D(^XUSEC("XUORES",XUDA))
 ;
 ;Test for Access Code:
 I $P(X1,U,3)]"" Q 1
 ;
 ;Test for a Termination Date not in the Future
 ;AND Not owner of XUORES Security Key:
 S %=$P(X1,U,11) I %>0,%'>DT,'XUORES Q "0^TERMINATED^"_%
 ;
 ;Test if user has XUORES Security key:
 I XUORES Q 1
 ;
 ;Tests for Visitors:
 I +$G(XUF),$D(^VA(200,"BB","VISITOR",XUDA)) Q 1
 I $D(^VA(200,"BB","VISITOR",XUDA)) Q "0^VISITOR"
 ;
 ;Default:
 Q "0^NOT A PROVIDER"
 ;
DEA(FG,IEN,DATE,RXDEA) ;sr. ef. Return users DEA # or Facility DEA_"-"_user VA# or null
 ;ICR #2343
 ;If FG is 1: DEA# or VA#
 ;Fee Basis, C&A providers only return DEA# or null - p609/REM
 ;Non-VA prescriber only return DEA# or null - p545
 ;Add XDT=DEA expiration date. If XDT unpopulated, its expired. - p609/REM
 ;DATE is the date to be checked against the DEA# Expiration Date (Default: Today)-p739 
 ;If a DEA# is passed in RXDEA, check if that # has all the credentials.
 N DEA,FB,IN,INN,N,N1,XDT,VA,FAIL,I,J,K,RET,ALTRET,NVA
 S IEN=$G(IEN,DUZ),INN=+DUZ(2) S:'$G(FG) FG="" S:'$D(RXDEA) RXDEA=""
 S:'$G(DATE) DATE=DT ;p739
 S N=$G(^VA(200,IEN,"PS"))
 S NVA=$G(^VA(200,IEN,"TPB")) ;p545
 S VA=$P(N,U,3)
 I $P(N,U,6)=4!($P(N,U,6)=3)!($P(NVA,U,1)=1) S FB=1  ;Fee Basis or C&A  provider -p609 or NON-VA prescriber
 S RET="",ALTRET=""
 I $L(RXDEA)>1 D  Q:RET]"" RXDEA  Q ""
 . S I=$O(^VA(200,IEN,"PS4","B",$P(RXDEA,"-"),0)) D:I
 .. S J=$P($G(^VA(200,IEN,"PS4",I,0)),U,3) D:J
 ... S XDT=$P($G(^XTV(8991.9,J,0)),U,4) Q:'XDT
 ... I XDT'<DATE S RET=RXDEA
 S J=0 F  S J=$O(^VA(200,IEN,"PS4",J)) Q:'J  D
 . S NP=1,K=$P($G(^VA(200,IEN,"PS4",J,0)),U,3) D:K
 .. I $P($G(^XTV(8991.9,K,0)),U,6)=1 D
 ... S XDT=$P($G(^XTV(8991.9,K,0)),U,4)
 ... I 'XDT S RET="Q" Q
 ... I RET'="Q" D
 .... I XDT'<DATE S RET=$P(^VA(200,IEN,"PS4",J,0),U)
 .... I XDT<DATE S RET="E"
 .. ; Alternate return (ALTRET) value when FB=1 (non-va provider), no valid individual DEA's, use institutional DEA
 .. I '($L(RET)>6),'$L(ALTRET),($P($G(^XTV(8991.9,K,0)),U,7)=1) D
 ... S XDT=$P($G(^XTV(8991.9,K,0)),U,4)
 ... Q:'XDT  Q:XDT<DATE
 ... N SUF S ALTRET=$P(^VA(200,IEN,"PS4",J,0),U),SUF=$P(^VA(200,IEN,"PS4",J,0),U,2)
 ... I $L(SUF) S ALTRET=ALTRET_"-"_SUF
 .. ; If there's an individual DEA, use it as the preferred alternate, regardless of 'use for inpatient' flag
 .. I '($L(RET)>6),($P($G(^XTV(8991.9,K,0)),U,7)=2) I '$L(ALTRET)!(ALTRET["-") D
 ... S XDT=$P($G(^XTV(8991.9,K,0)),U,4)
 ... Q:'XDT  Q:XDT<DATE
 ... S ALTRET=$P(^VA(200,IEN,"PS4",J,0),U)
 I '($L(RET)>6),$L(ALTRET) Q ALTRET
 Q:RET="Q" ""
 Q:$L(RET)>6 RET
 Q:$G(FB) ""
 Q:$G(FG) VA
 ;*689 - prevent failover
 S FAIL=$$GET^XPAR("SYS","PSOEPCS EXPIRED DEA FAILOVER",1,"I")
 I FAIL=0,RET="E" Q ""
 S IN=$P($G(^DIC(4,INN,"DEA")),U) ;Check signed-in Inst.
 I '$L(IN) D
 . N XU1 D PARENT^XUAF4("XU1","`"_INN,"PARENT FACILITY")
 . S INN=$O(XU1("P","")) I INN S IN=$P($G(^DIC(4,INN,"DEA")),U)
 . Q
 N XUEXDT I INN S XUEXDT=$P($G(^DIC(4,INN,"DEA")),U,2) ;check DEA EXPIRATION DATE
 S XUEXDT=$G(XUEXDT)
 I $L(VA),$L(IN),$L(XUEXDT),XUEXDT'<DATE Q IN_"-"_VA ;check DEA EXPIRATION DATE
 Q ""
 ;
DETOX(IEN,DATE) ;*689 - Returns the Detox # from file 8991.9/200 - p580/REM
 ;ICR #2343
 ;Return Detox# - valid detox# and DEA Xdate is valid
 ;Return null - if no detox or the DEA Xdate is unpopulated
 ;Return DEA Expiration Date - valid detox# but expired DEA Xdate
 ;IEN is used to lookup user in file #200
 ;DATE is the date to be checked against the Detox# Expiration Date (Default: Today)-p739
 Q:'IEN ""
 N DET,XDT,N,N1,I,NP,J,AR1,AR2,AR3,AR4,VDEA S (N,NP,VDEA)=0,DET=""
 S:'$G(DATE) DATE=DT ;p739
 S I=0 F  S I=$O(^VA(200,IEN,"PS4",I)) Q:'I  D
 .S NP=1,J=$$GET1^DIQ(200.5321,I_","_IEN,.03,"I") Q:'J  D
 .. Q:$$GET1^DIQ(8991.9,J,.07,"I")=1 
 .. S XDT=$$GET1^DIQ(8991.9,J,.04,"I") Q:'XDT
 .. S DET=$$GET1^DIQ(8991.9,J,.03)
 .. S N=N+1
 .. I XDT<DATE,$L(DET) S:N=1 AR4(XDT)="" S AR3(9999999-XDT,DET)="" Q
 .. S:XDT'<DATE VDEA=1
 .. Q:'$L(DET)
 .. I $$GET1^DIQ(8991.9,J,.06,"I")=1 S AR1(9999999-XDT,DET)=""
 .. E  S AR2(9999999-XDT,DET)=""
 S I="",I=$O(AR1(I)) Q:I $O(AR1(I,""))
 S I="",I=$O(AR2(I)) Q:I $O(AR2(I,""))
 ;I VDEA,N S I="",I=$O(AR3(I)) Q:I $O(AR3(I,""))
 S I="",I=$O(AR3(I)) Q:I $O(AR3(I,""))
 S I="",I=$O(AR4(I)) Q:I I
 Q:NP ""
 S N=$G(^VA(200,IEN,"PS")),N1=$G(^VA(200,IEN,"QAR"))
 S DET=$P(N,U,11),XDT=$P(N1,U,9)
 I $L(DET),$L(XDT),XDT'<DATE Q DET ;p739
 I $L(DET),$L(XDT),XDT<DATE Q XDT ;p739
 Q ""
 ;
SDEA(FG,IEN,PSDEA,DATE,IDEA,INIEN) ;validation for new DEA regulations p580-JC(CPRS)
 ;ICR #2343
 ;Returns: DEA#, Facility DEA_"-"_user VA#, 1, 2, or 4^expiration date
 ;No longer used - Retained for backward compatibility
 ;IEN is used to lookup user in file #200
 ;PSDEA is the DEA schedule
 ;DATE is the date to be checked against the DEA# Expiration Date (Default: Today); p739
 ;IDEA is the DEA# or an "I" for Inpatient use to check for schedule
 ;*689
 N DEA,N,N3,I,J,K,A,E,FOVR,XDT,Y,VA,FB,DEATYP,NVA,SMATCHNP,SMATCHIP,SMATCH,SMATCHVA,DEARR
 S:'$G(DATE) DATE=DT ;p739
 S:'$G(INIEN) INIEN=""
 S SMATCH="",SMATCHNP="",SMATCHIP="",E="",DEARR=""
 S N=$G(^VA(200,IEN,"PS")),VA=$P(N,U,3),(DEA,N3,E,FB)=""
 S NVA=$G(^VA(200,IEN,"TPB")) ;p545
 I $P(N,U,6)=4!($P(N,U,6)=3)!($P(NVA,U,1)=1) S FB=1  ;Fee Basis or C&A  provider -p609 or NON-VA prescriber
 S IDEA=$G(IDEA),FG=$G(FG),IEN=$G(IEN),PSDEA=$G(PSDEA)
 I $G(PSDEA)="" Q 1
 S FOVR=$$GET^XPAR("SYS","PSOEPCS EXPIRED DEA FAILOVER",1,"I")
 I $L(IDEA),$L(IDEA,"-")=2,$P(IDEA,"-",2)=VA G CVA
 I ($L(IDEA)<2),'$O(^VA(200,IEN,"PS4",0)) G CVA
 I $L(IDEA)<2 D  Q:E E Q SMATCH
 . S J=0 F  S J=$O(^VA(200,IEN,"PS4",J)) Q:'J  D  Q:$L(SMATCH)
 .. S K=$P($G(^VA(200,IEN,"PS4",J,0)),U,3) D:K
 ... S DEATYP=$P($G(^XTV(8991.9,K,0)),U,7)
 ... S N=$G(^XTV(8991.9,K,0))
 ... S XDT=$P(N,U,4) Q:'XDT
 ... I $P(N,U,6)=1 S DEA=$P(N,U) D  ; 'Use for Inpatient' DEA is preferred
 .... I XDT<DATE S SMATCHIP=1 S Y=XDT X ^DD("DD") S DEARR=4_U_Y
 .... I XDT'<DATE S N3=$S(DEATYP=2:$G(^XTV(8991.9,K,2)),1:$G(^VA(200,IEN,"PS3"))) D  Q
 ..... S SMATCHIP=$$SCHK(DEA,PSDEA,N3)
 .... I 'FOVR,XDT<DATE S Y=XDT X ^DD("DD") S E=DEARR Q
 .... I FB!'$L(VA) S E=DEARR Q
 .... D GVA(INIEN) S:DEA["-" N3=$G(^VA(200,IEN,"PS3")) S SMATCHVA=$$SCHK(DEA,PSDEA,N3)
 .... S E=$S($L(SMATCHVA)>1:"",1:2)
 ... I '$P(N,U,6),(IDEA'="I"),'$L(SMATCHNP) S DEA=$P(N,U) D  ; Not Inpatient DEA - ignore if IDEA="I"
 .... I XDT'<DATE S N3=$S(DEATYP=2:$G(^XTV(8991.9,K,2)),1:$G(^VA(200,IEN,"PS3"))) D
 ..... S SMATCHNP=$$SCHK(DEA,PSDEA,N3)
 . I $L(SMATCHIP)>1 S SMATCH=SMATCHIP S E=""                                           ; 'Use for Inpatient' DEA
 . I ($L(SMATCHIP)<2)&($L(SMATCHNP)>1) S SMATCH=SMATCHNP S E=""                 ; Non-Inpatient DEA
 . I $L(SMATCH)<2 S SMATCH=$S($L($G(SMATCHVA))&'E:$G(SMATCHVA),$G(SMATCHIP)=2:2,1:1)             ; Failover - Facility DEA
 I $L(IDEA)>1 S DEA=$P(IDEA,"-")
 Q:$G(DEA)="" 1
 S N=$O(^XTV(8991.9,"B",DEA,0))
 Q:'N 1
 S XDT=$P($G(^XTV(8991.9,N,0)),U,4) I 'XDT!(XDT<$$FMADD^XLFDT(DATE,1)) Q 4_"^"_XDT
 I XDT'<DATE D  Q $$SCHK(DEA,$G(PSDEA),$G(N3))
 . N DEATYP S DEATYP=$P($G(^XTV(8991.9,N,0)),U,7)
 . S N3=$S(DEATYP=1:$G(^VA(200,IEN,"PS3")),1:$G(^XTV(8991.9,N,2)))
 I 'FOVR,(XDT<DATE) S Y=XDT X ^DD("DD") Q 4_U_Y
CVA ; VA number
 S INIEN=+$G(INIEN)
 Q:FB 1
 Q:'$L(VA) 1
 D GVA(INIEN) S:DEA["-" N3=$G(^VA(200,IEN,"PS3"))
 Q:$G(DEA)="" 1
 S SMATCH=$$SCHK(DEA,PSDEA,N3)
 Q SMATCH
SCHK(DEA,PSDEA,N3) ;
 I $G(N3)=""!(N3'[1) Q 2
 I $G(PSDEA)="" Q 2
 I $L(N3,"^")'=6 Q 2
 F I=1:1:6 S A(I)=$P(N3,U,I)
 I PSDEA=2 Q $S('A(1):2,1:DEA)
 I PSDEA="2n" Q $S('A(2):2,1:DEA)
 I PSDEA=3 Q $S('A(3):2,1:DEA)
 I PSDEA="3n" Q $S('A(4):2,1:DEA)
 I PSDEA=4 Q $S('A(5):2,1:DEA)
 I PSDEA=5 Q $S('A(6):2,1:DEA)
 Q DEA
 ;
GVA(INIEN) ; Find Facility DEA and VA #
 ; INN - Pointer to INSTITUTION file (#4)
 N IN,INN,ININN
 S INN=$S($G(INIEN):INIEN,1:+DUZ(2))
 S IN=$P($G(^DIC(4,INN,"DEA")),U) ;Check signed-in Inst.
 I '$L(IN) D
 . N XU1 D PARENT^XUAF4("XU1","`"_INN,"PARENT FACILITY")
 . S INN=$O(XU1("P","")) I INN S IN=$P($G(^DIC(4,INN,"DEA")),U)
 . Q
 N XUEXDT I INN S XUEXDT=$P($G(^DIC(4,INN,"DEA")),U,2) ;check DEA EXPIRATION DATE
 S XUEXDT=$G(XUEXDT)
 I $L(VA),$L(IN),$L(XUEXDT),(XUEXDT'<DATE) S DEA=IN_"-"_VA ;check DEA EXPIRATION DATE
 Q
 ;
VDEA(RETURN,IEN)  ;ISP/RFR - Verify a provider is properly configured for ePCS
 ;PARAMETERS: IEN - Internal Entry Number in the NEW PERSON file (#200)
 ;            RETURN - Reference to an array in which text explaining
 ;                     deficiencies and listing prescribable schedules
 ;                     is placed, with each deficiency and the list of
 ;                     schedules on a separate node
 ;RETURN: 1 - Provider is properly configured for ePCS
 ;        0 - Provider is not properly configured for ePCS
 N STATUS,DEA,RETVAL,DATE,NODEA
 ; p499 - Use new DEA NUMBERS file (#8991.9)
 I $O(^VA(200,IEN,"PS4",0)) S STATUS=$$VDEADNM^XUSER3(.RETURN,IEN) Q STATUS
 ;
 S RETVAL=1,STATUS=$$ACTIVE(IEN)
 I STATUS="" S RETURN("User account does not exist.")="",RETVAL=0
 I STATUS=0 S RETURN("User cannot sign on.")="",RETVAL=0
 I +STATUS=0,($P(STATUS,U,2)'="") S RETURN("User account status: "_$P(STATUS,U,2))="",RETVAL=0
 Q:STATUS="" RETVAL
 I '$D(^XUSEC("ORES",IEN)) D
 . S RETURN("Does not hold the ORES security key.")="",RETVAL=0
 I +$P($G(^VA(200,IEN,"PS")),U,1)'=1 D
 . S RETURN("Is not authorized to write medication orders.")="",RETVAL=0
 S NODEA=1
 I $P($G(^VA(200,IEN,"PS")),U,3)="" D
 . S RETURN("Has neither a DEA number nor a VA number.")="",RETVAL=0
 ;I +$G(NODEA),($P($G(^VA(200,IEN,"PS")),U,3)'="") S RETVAL=1
 S DATE=+$P($G(^VA(200,IEN,"PS")),U,4)
 I DATE>0,(DATE<=DT) D
 . S RETURN("Is no longer able to write medication orders (inactive date).")="",RETVAL=0
 I $D(^VA(200,IEN,"PS3")) D
 . N NODE
 . S NODE=$$STRIP^XLFSTR(^VA(200,IEN,"PS3"),U),NODE=$$STRIP^XLFSTR(NODE,0)
 . I $G(NODE)="" S RETURN("Is not permitted to prescribe any schedules.")="",RETVAL=0 Q
 . I $G(NODE)'="" D
 . . N PIECE,SCHED,SPEC,ASCHED
 . . S SPEC("SCHEDULE ")=""
 . . S ASCHED=1
 . . F PIECE=1:1:6 D
 . . . I +$P(^VA(200,IEN,"PS3"),U,PIECE)>0 D
 . . . . N LABEL,ERROR
 . . . . S LABEL=$$REPLACE^XLFSTR($$GET1^DID(200,"55."_PIECE,,"LABEL",,"ERROR"),.SPEC)
 . . . . S:$G(LABEL)="" LABEL="Unknown field #55."_PIECE
 . . . . S SCHED=$S($G(SCHED)'="":SCHED_U,1:"")_LABEL
 . . . I +$P(^VA(200,IEN,"PS3"),U,PIECE)=0 S ASCHED=0
 . . I ASCHED=1 S RETURN("Is permitted to prescribe all schedules.")=""
 . . I ASCHED=0 D
 . . . N DELIMIT,INDEX,TEXT
 . . . S DELIMIT=", "
 . . . F INDEX=1:1:$L(SCHED,U) D
 . . . . S:INDEX=$L(SCHED,U) DELIMIT=" and "
 . . . . S TEXT=$S($G(TEXT)'="":TEXT_DELIMIT,1:"")_$P(SCHED,U,INDEX)
 . . . S RETURN("Is permitted to prescribe schedule"_$S($L(SCHED,U)>1:"s",1:"")_" "_TEXT_".")=""
 ;*689
 I '$D(^VA(200,IEN,"PS3")) S RETURN("Is not permitted to prescribe any schedules.")="",RETVAL=0
 Q RETVAL
 ;
DIV4(XUROOT,XUDUZ) ;Return the Divisions that this user is assigned to.
 ;Returns 0 - no institution for user, 1 - institution for user
 ;XUROOT is passed by reference.
 N %,%1 S:$G(XUDUZ)="" XUDUZ=DUZ S (%,%1)=0
 F  S %=$O(^VA(200,XUDUZ,2,%)) Q:%'>0  S XUROOT(%)=$P($G(^(%,0)),U,2),%1=1
 Q %1
 ;
VDEADNA(RETURN,NPIEN,DNDEAIEN)  ; -- ENTRY POINT for a single DEA Number
 Q $$VDEADNA^XUSER3(.RETURN,NPIEN,DNDEAIEN)
 ;
VDEADNM(RETURN,NPIEN)  ;ISP/RFR - Verify a provider is properly configured for ePCS
 Q $$VDEADNM^XUSER3(.RETURN,NPIEN)
 ;
NAME(IEN,FL) ;Return the full name from Name Components file
 N NA S NA("FILE")=200,NA("FIELD")=.01,NA("IENS")=IEN
 S FL=$G(FL,"G") ;Valid are Famly or Given
 S:"FG"'[FL FL="G"
 Q $$NAMEFMT^XLFNAME(.NA,FL,"CMDP")
 ;
HL7(IEN) ;Return a HL7 name from the components file
 N NA S NA("FILE")=200,NA("FIELD")=.01,NA("IENS")=IEN
 Q $$HLNAME^XLFNAME(.NA,"","~")
 ;
SCR200() ;Whole File Screen logic for file 200
 ; ZEXCEPT: DIC,DINDEX - Kernel exemption
 ;
 ; Test to see if FileMan can "talk" to the user, IA# 4577
 I $G(DIC(0))'["E" Q 1
 ;
 ; Test to see if index being searched is SSN, IA# 4578
 I $G(DINDEX)'="SSN" Q 1
 ;
 ; Test for Security Key
 I $G(DUZ),$D(^XUSEC("XUSHOWSSN",DUZ)) Q 1
 ;
 ; Default - None of the above is TRUE
 Q 0
 ;
PRDEA(IEN) ; 689 - Return Prescriber's active DEA
 ; IEN-Prescriber DUZ from file 200
 Q $$PRDEA^XUPSPRA(IEN)
 ;
PRXDT(IEN) ; 689 - Return Prescriber's default DEA Expiration Date
 ; IEN-Prescriber DUZ from file 200
 Q $$PRXDT^XUPSPRA(IEN)
 ;
PRSCH(IEN) ; 689 - Return Prescriber's default DEA schedules
 ; IEN-Prescriber DUZ from file 200
 Q $$PRSCH^XUPSPRA(IEN)
 ;
DEAXDT(DEA) ; 689 - Return Expiration Date for DEA
 ; DEA-DEA Number. Example: AH1966007
 Q $$DEAXDT^XUPSPRA(DEA)
 ;
DEASCH(DEA) ; 689 - Return DEA Schedules for DEA number
 ; DEA-DEA Number. Example: AH1966007
 Q $$DEASCH^XUPSPRA(DEA)
