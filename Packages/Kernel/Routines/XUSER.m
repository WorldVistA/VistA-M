XUSER ;ISP/RFR - A common set of user functions ;06/09/15  10:51
 ;;8.0;KERNEL;**75,97,99,150,226,267,288,330,370,373,580,609,642**;Jul 10, 1995;Build 6
 ;Per VA Directive 6402, this routine should not be modified.
 ;Covered under DBIA #2343
 Q
LOOKUP(XUF) ;Do a user lookup
 ;Parameter, "Q" to NOT ask OK.
 ;Parameter, "A" Don't select current users who have a termination
 ;               date prior to today's date
 N DIC,XUDA,DIR,Y
LK1 S DIC="^VA(200,",DIC(0)="AEMQZ" D ^DIC S XUDA=Y G:Y'>0 LKX
 S Y=$P(Y(0),"^",11) I Y>0,Y<DT W !?15,"This user was terminated on ",$$FMTE^XLFDT(Y) I $G(XUF)["A" S XUDA=-1 G LK1
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
DEA(FG,IEN) ;sr. ef. Return users DEA # or Facility DEA_"-"_user VA# or null
 ;ICR #2343
 ;If FG is 1: DEA# or VA#
 ;Fee Basis, C&A providers only return DEA# or null - p609/REM
 ;Add XDT=DEA expiration date. If XDT unpopulated, its expired. - p609/REM
 N DEA,FB,IN,INN,N,N1,XDT,VA
 S IEN=$G(IEN,DUZ),INN=+DUZ(2)
 S N=$G(^VA(200,IEN,"PS")),N1=$G(^VA(200,IEN,"QAR"))
 S DEA=$P(N,U,2),VA=$P(N,U,3),XDT=$P(N1,U,9)
 I $P(N,U,6)=4!($P(N,U,6)=3) S FB=1 ;Fee Basis or C&A  provider -p609
 ;I $L(DEA),$S('$L($P(N1,U,9)):1,1:$P(N1,U,9)>DT) Q DEA
 I $L(DEA),$L(XDT),XDT'<DT Q DEA ;p609
 I $G(FB) Q "" ;p609
 I $G(FG) Q VA
 S IN=$P($G(^DIC(4,INN,"DEA")),U) ;Check signed-in Inst.
 I '$L(IN) D
 . N XU1 D PARENT^XUAF4("XU1","`"_INN,"PARENT FACILITY")
 . S INN=$O(XU1("P","")) I INN S IN=$P($G(^DIC(4,INN,"DEA")),U)
 . Q
 N XUEXDT I INN S XUEXDT=$P($G(^DIC(4,INN,"DEA")),U,2) ;check DEA EXPIRATION DATE
 S XUEXDT=$G(XUEXDT)
 I $L(VA),$L(IN),$L(XUEXDT),XUEXDT'<DT Q IN_"-"_VA ;check DEA EXPIRATION DATE
 ;I $L(VA),$L(IN) Q IN_"-"_VA
 Q ""
 ;
DETOX(IEN) ;Return the Detox/Maintenance ID in file 200 - p580/REM
 ;ICR #2343
 ;Return Detox# - valid detox# and DEA Xdate is valid
 ;Return null - if no detox or the DEA Xdate is unpopulated
 ;Return DEA Expiration Date - valid detox# but expired DEA Xdate
 ;IEN is used to lookup user in file #200
 N DET,XDT,N,N1
 S N=$G(^VA(200,IEN,"PS")),N1=$G(^VA(200,IEN,"QAR"))
 S DET=$P(N,U,11),XDT=$P(N1,U,9)
 I $L(DET),$L(XDT),XDT'<DT Q DET
 I $L(DET),$L(XDT),XDT<DT Q XDT
 ;I $L(DET),$S('$L($P(N1,U,9)):1,1:$P(N1,U,9)>DT) Q DTX
 Q ""
 ;
SDEA(FG,IEN,PSDEA) ;validation for new DEA regulations p580-JC(CPRS)
 ;ICR #2343
 ;Returns: DEA#, Facility DEA_"-"_user VA#, 1, 2, or 4^expiration date
 ;If FG is 1: DEA# or VA# - similar to $$DEA
 ;IEN is used to lookup user in file #200
 ;PSDEA is the DEA schedule
 N DEA,N3,I,A,NALL,E,DA,XD,N,N1,Y
 S FG=$G(FG),IEN=$G(IEN),PSDEA=$G(PSDEA)
 S DEA=$$DEA(FG,IEN) I DEA="" D  Q E
 . S E=1
 . S N=$G(^VA(200,IEN,"PS")),N1=$G(^VA(200,IEN,"QAR"))
 . S DA=$P(N,U,2),XD=$P(N1,U,9)
 . I $L(DA),$L(XD),XD<DT S Y=XD X ^DD("DD") S E=4_"^"_Y
 I $G(PSDEA)="" Q 1
 I '$D(^VA(200,IEN,"PS3")) Q DEA
 S N3=^VA(200,IEN,"PS3")
 S NALL=1 F I=1:1:6 S A(I)=$P(N3,"^",I) I A(I) S NALL=0
 I NALL D  Q 2
 . I $G(^VA(200,IEN,"PS"))="" Q
 . S $P(^("PS"),"^",2)="",$P(^("PS"),"^",3)=""
 I PSDEA=2 Q $S('A(1):2,1:DEA)
 I PSDEA="2n" Q $S('A(2):2,1:DEA)
 I PSDEA=3 Q $S('A(3):2,1:DEA)
 I PSDEA="3n" Q $S('A(4):2,1:DEA)
 I PSDEA=4 Q $S('A(5):2,1:DEA)
 I PSDEA=5 Q $S('A(6):2,1:DEA)
 Q DEA
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
 S RETVAL=1,STATUS=$$ACTIVE(IEN)
 I STATUS="" S RETURN("User account does not exist.")="",RETVAL=0
 I STATUS=0 S RETURN("User cannot sign on.")="",RETVAL=0
 I +STATUS=0,($P(STATUS,U,2)'="") S RETURN("User account status: "_$P(STATUS,U,2))="",RETVAL=0
 Q:STATUS="" RETVAL
 I '$D(^XUSEC("ORES",IEN)) D
 . S RETURN("Does not hold the ORES security key.")="",RETVAL=0
 I +$P($G(^VA(200,IEN,"PS")),U,1)'=1 D
 . S RETURN("Is not authorized to write medication orders.")="",RETVAL=0
 I $P($G(^VA(200,IEN,"PS")),U,2)'="" D
 . N DATE
 . S DATE=+$P($G(^VA(200,IEN,"QAR")),U,9)
 . I DATE=0 S RETURN("Has a DEA number with no expiration date.")="",RETVAL=0,NODEA=1
 . I DATE>0,(DATE<=DT) S RETURN("Has an expired DEA number.")="",RETVAL=0,NODEA=1
 I $P($G(^VA(200,IEN,"PS")),U,2)="" D
 . S NODEA=1
 . I $P($G(^VA(200,IEN,"PS")),U,3)="" D
 . . S RETURN("Has neither a DEA number nor a VA number.")="",RETVAL=0
 I +$G(NODEA),($P($G(^VA(200,IEN,"PS")),U,3)'="") S RETVAL=1
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
 I '$D(^VA(200,IEN,"PS3")) S RETURN("Is permitted to prescribe all schedules due to grandfathering.")=""
 Q RETVAL
 ;
DIV4(XUROOT,XUDUZ) ;Return the Divisions that this user is assigned to.
 ;Returns 0 - no institution for user, 1 - institution for user
 ;XUROOT is passed by reference.
 N %,%1 S:$G(XUDUZ)="" XUDUZ=DUZ S (%,%1)=0
 F  S %=$O(^VA(200,XUDUZ,2,%)) Q:%'>0  S XUROOT(%)=$P($G(^(%,0)),U,2),%1=1
 Q %1
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
