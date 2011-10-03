IBDF18B ;ALB/AAS - ENCOUNTER FORM - utilities for PCE ;04-OCT-94
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
GETPRO(CLINIC,ARY) ; -- returns list of providers specified for a clinic
 ; -- input  CLINIC = pointer to hospital location file for clinic
 ;              ARY = name of array to return list in
 ;
 ; -- output  The format of the returned array is as follows
 ;         @ARY@(0) = count of array element (0 of nothing found)
 ;         @ARY@(1) = pointer to 200^provider name from 200 (default provider if indicated)
 ;         @ARY@(2) = pointer to 200^provider name from 200
 ;
 N I,J,X,Y,IBX,IBQUIT,COUNT,IBC,ERR,CT
 S (CT,COUNT,IBQUIT)=0
 ;
 S @ARY@(0)=""
 I $G(CLINIC)="" G GETPROQ
 I $G(^SC(CLINIC,0))="" G GETPROQ
 S ERR="IBDERR"
 ;
 ; -- don't use PCMM providers checked
 I $P($G(^SD(409.95,+$O(^SD(409.95,"B",CLINIC,0)),0)),"^",10) G CLIN
 ;
 ; -- get providers from PCMM teams, if available
 I $L($T(PRCL^SCAPMC)) S X=$$PRCL^SCAPMC(.CLINIC,"","","","",ARY,ERR) I @ARY@(0)>0 D
 .K @ARY@("SCPR")
 .F I=1:1:@ARY@(0) I '$$SCREEN^IBDFDE10(+@ARY@(I)) K @ARY@(I) S CT=CT+1
 .S @ARY@(0)=@ARY@(0)-CT
 I @ARY@(0)>0 G GETPROQ
 ;
CLIN I $O(^SC(CLINIC,"PR",0))="" G GETPROQ
 ;
 ; -- default provider should always be listed first
 S IBX=$O(^SC("ADPR",CLINIC,0)) I IBX D
 .S X=$G(^SC(CLINIC,"PR",IBX,0))
 .D INCPR(+X)
 ;
 ; -- get rest of list of providers
 S IBX=0 F  S IBX=$O(^SC(CLINIC,"PR",IBX)) Q:'IBX  I IBX D
 .S X=$G(^SC(CLINIC,"PR",IBX,0))
 .D INCPR(+X)
 S @ARY@(0)=COUNT
 ;
GETPROQ Q
 ;
INCPR(X) ; -- increment counter and set provider array
 Q:'X!($G(^VA(200,+X,0))="")
 Q:$D(IBX(+X))  ; -- already set
 S COUNT=COUNT+1,@ARY@(COUNT)=+X_"^"_$P(^VA(200,+X,0),"^")
 S IBX(+X)=""
 Q
 ;
TEST K ALAN D GETPRO(25,"ALAN")
 X "ZW ALAN"
 Q
