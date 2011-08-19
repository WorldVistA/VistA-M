PXBUTL2 ;ISL/DCM - PCE Utilities ;5/21/96  12:15
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**121**;Aug 12, 1996
 ;
 ;
 ;
 ;
PRV(CLINIC) ;Get default provider and all providers associated with a clinic
 ;CLINIC - ifn of clinic in file 44
 ;External references:  ^SC(DA(1),"PR",DA)
 ;                      ^VA(200,DA,0)
 Q:'$G(CLINIC)  Q:'$O(^SC(CLINIC,"PR",0))
 K PXBPMT N IFN,X,NAME
 S IFN=0 F  S IFN=$O(^SC(CLINIC,"PR",IFN)) Q:IFN<1  S X=^(IFN,0) D
 . S NAME=$P($G(^VA(200,+X,0)),"^") I $L(NAME) S PXBPMT("PRV",NAME,+X)="" S:$P(X,"^",2) PXBPMT("DEF",NAME,+X)=""
 Q
POV(CLINIC,CODE) ;Get default diagnosis and all diagnosis associated with clinic
 ;CLINIC - ifn of clinic in file 44
 ;CODE - 1 (default) code, 2 diagnosis, 3 both
 ;External references:  ^SC(DA(1),"DX",DA)
 ;                      ^ICD9(DA,0)
 Q:'$G(CLINIC)  Q:'$O(^SC(CLINIC,"DX",0))
 K PXBPMT N IFN,X,NAME
 S:'$D(CODE) CODE=1
 S IFN=0 F  S IFN=$O(^SC(CLINIC,"DX",IFN)) Q:IFN<1  S X=^(IFN,0) D
 . ;S NAME=$P($G(^ICD9(+X,0)),"^",1,3)
 . S NAME=$P($$ICDDX^ICDCODE(+X,IDATE),"^",2,4)
 . ;jvs 7/22/96 allow selection of v codes
 . I $L(NAME) S NAME=$S(CODE=2:$S($L($P(NAME,"^",3)):$P(NAME,"^",3),1:$P(NAME,"^")),CODE=3:$P(NAME,"^")_"--"_$P(NAME,"^",3),1:$P(NAME,"^")),PXBPMT("POV",NAME,+X)="" S:$P(X,"^",2) PXBPMT("DEF",NAME,+X)=""
 Q
TSTPRV ;Test provider lookup
 S DIC=44,DIC(0)="AEQLM" D ^DIC Q:Y<1  D PRV(+Y)
 K DIC
 Q
TSTPOV ;Test diagnosis lookup
 S DIC=44,DIC(0)="AEQLM" D ^DIC Q:Y<1  D POV(+Y,3)
 K DIC
 Q
