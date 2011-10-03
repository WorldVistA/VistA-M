XUSER ;SFISC/RWF - A common set of user functions ;6:26 AM  25 Jan 2005
 ;;8.0;KERNEL;**75,97,99,150,226,267,288,330,370,373**;Jul 10, 1995
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
 ;If FG is 1: DEA# or VA#
 N DEA,VA,IN,N,N1,INN
 S IEN=$G(IEN,DUZ),INN=+DUZ(2)
 S N=$G(^VA(200,IEN,"PS")),N1=$G(^VA(200,IEN,"QAR"))
 S DEA=$P(N,U,2),VA=$P(N,U,3)
 I $L(DEA),$S('$L($P(N1,U,9)):1,1:$P(N1,U,9)>DT) Q DEA
 I $G(FG) Q VA
 S IN=$P($G(^DIC(4,INN,"DEA")),U) ;Check signed-in Inst.
 I '$L(IN) D
 . N XU1 D PARENT^XUAF4("XU1","`"_INN,"PARENT FACILITY")
 . S INN=$O(XU1("P","")) I INN S IN=$P($G(^DIC(4,INN,"DEA")),U)
 . Q
 I $L(VA),$L(IN) Q IN_"-"_VA
 Q ""
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
 ;
 ; Test for Security Key & Length=9 & All numeric
 I $G(DUZ),$D(^XUSEC("XUSHOWSSN",DUZ)),$L(X)=9,X?9N Q 1
 ;
 ; Test to see if FileMan can "talk" to the user, IA# 4577
 I $G(DIC(0))'["E" Q 1
 ;
 ; Test to see if index being searched is SSN, IA# 4578
 I $G(DINDEX)'="SSN" Q 1
 ;
 ; Default - None of the above is TRUE
 Q 0
