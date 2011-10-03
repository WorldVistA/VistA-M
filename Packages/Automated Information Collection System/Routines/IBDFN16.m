IBDFN16 ;ALB/DHH - ENCOUNTER FORM - (entry points for gaf project) ;3/20/2001
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**37**;APR 24, 1997
 ;
GAFPROV ;Enter GAF Score Provider
 ;
 ; -- @IBARY should be defined
 ;
 N DIC,Y,DIROUT,DIRUT,DTOUT,DUOUT
 S DIC=200,DIC(0)="AEQM"
 S DIC("S")="I $$OKPROV^IBDFDE23(Y)"
 S DIC("A")="Provider determining GAF Score: " D ^DIC K DIC
 I $D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)) Q
 I Y<0 Q
 S @IBARY=Y
 Q
 ;
OKPROV(IEN) ; Screen for provider lookup using person class
 ; provider for gaf must have the sd gaf score security key
 ;
 Q ($D(^XUSEC("SD GAF SCORE",IEN)))
 ;
GAFRET ;Previous GAF information returned from Mental Health
 ;
 ; -- this is to be used by PREVIOUS GAF SCORE package interface
 ;
 N GAFDAT,Y,GAFPROV,X,X1,X2,IBX
 S IBX=$$RET^YSGAF($G(DFN))
 I +IBX=-1 S @IBARY="" Q
 S GAFDAT=$P(IBX,"^",2)
 S Y=GAFDAT K %DT D DD^%DT S $P(IBX,"^",2)=$P(Y,"@")
 S GAFPROV=$P($G(^VA(200,+$P(IBX,"^",3),0)),"^")
 S $P(IBX,"^",3)=GAFPROV
 S $P(IBX,"^",4)=$$RULE(GAFDAT)
 S @IBARY=IBX
 Q
RULE(GAFDAT) ;check for greater than 90 days
 ;
 ; -- gafdat is the internal date of the last gaf score
 ;
 N RULE
 S RULE="NO"
 S X1=DT,X2=GAFDAT D ^%DTC
 S:X>90 RULE="YES"
 Q RULE
