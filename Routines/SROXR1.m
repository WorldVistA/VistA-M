SROXR1 ;B'HAM ISC/MAM - CROSS REFERENCES (CONT) ;10/05/04
 ;;3.0; Surgery ;**34,72,79,100,134**;24 Jun 93
ATT ; ATT x-ref on surgeon to update attend surg
 N SRDIV,SREQ S SRDIV=$$SITE^SROUTL0(DA) Q:'SRDIV
 I $P(^SRO(133,SRDIV,0),"^",19)'=0 Q
 S SREQ(130,DA_",",.164)=X D FILE^DIE("","SREQ","^TMP(""SR"",$J)")
 Q
KATT ; kill logic for ATT x-ref
 Q
ATTP ; ATTP x-ref on provider to update attend provider
 N SRDIV,SREQ S SRDIV=$$SITE^SROUTL0(DA) Q:'SRDIV
 I $P(^SRO(133,SRDIV,0),"^",19)'=0 Q
 S SREQ(130,DA_",",124)=X D FILE^DIE("","SREQ","^TMP(""SR"",$J)")
 Q
KATTP ; kill logic for ATTP x-ref
 Q
AR ; 'AR' x-ref on the 'DATE OF OPERATION'
 ; field in the SURGERY file (130)
 Q:'$D(^SRF(DA,"REQ"))  I $P(^SRF(DA,"REQ"),"^")'=1 Q
 I $D(^SRF(DA,31)),$P(^(31),"^",4) Q
 S:$E(X,1,7)'<DT DFN=$P(^SRF(DA,0),"^"),^SRF("AR",$E(X,1,7),DFN,DA)=""
 Q
KAR ; 'KILL' logic of the 'AR' x-ref on the 'DATE OF
 ; OPERATION' field in the SURGERY file (130)
 S DFN=$P(^SRF(DA,0),"^") K ^SRF("AR",$E(X,1,7),DFN,DA)
 Q
SP ; set 'ASP' and 'AOR' x-refs when date is changed
 I $P(^SRF(DA,0),"^",4) S ^SRF("ASP",$P(^(0),"^",4),$E(X,1,7),DA)=DA
OR I $P(^SRF(DA,0),"^",2) S ^SRF("AOR",$P(^(0),"^",2),$E(X,1,7),DA)=""
 Q
KSP ; kill 'ASP' and 'AOR' x-refs when date is changed
 I $P(^SRF(DA,0),"^",4) K ^SRF("ASP",$P(^(0),"^",4),$E(X,1,7),DA)
KOR S DFN=$P(^SRF(DA,0),"^") I $P(^SRF(DA,0),"^",2) K ^SRF("AOR",$P(^(0),"^",2),$E(X,1,7),DA)
 Q
IV ; delete IV orders
 S SRT("X")=X D NOW^%DTC S X=SRT("X"),X1=$E(%,1,12) D MINS^SRSUTL2
 I X>1440 D OUT Q
 I X>60 D
 .D EN^DDIOL("A considerable amount of time has passed since the "_$S($P($G(^SRF(SRTN,"NON")),"^")="Y":"procedure",1:"operation")_" start",,"!!,?2")
 .D EN^DDIOL("time and the present time.",,"!,?2")
 D IV1
OUT S X=SRT("X") K SRT,X1,Y
 Q
IV1 K DIR W ! S DIR("?",1)="Enter 'YES' to cancel current IV orders. Enter 'NO' or '^' to continue",DIR("?")="without cancelling the patient's current IV orders.",DIR("B")=$S($P($G(^SRF(SRTN,"NON")),"^")="Y":"NO",1:"YES")
 S DIR("A")="Do you want to cancel all current IV orders for this patient (Y/N)",DIR(0)="Y" D ^DIR I $D(DTOUT)!(Y=0)!$D(DUOUT) Q
 S X="PSIVACT" X ^%ZOSF("TEST") Q:'$T
 S ZTDESC="Cancel IV Orders from Surgery",ZTDTH=$H,ZTIO="",ZTRTN="DCOR^SROXR1",ZTSAVE("PSIVRES")="SURGERY PACKAGE",ZTSAVE("DFN")=DFN N X,Y D ^%ZTLOAD
 Q
DCOR ; entry for tasked job to cancel IVs
 D DCOR^PSIVACT S ZTREQ="@"
 Q
END K DFN,I,S,SRSC1,SRSDAT,SRSOR
 Q
STAFF ; update STAFF/RESIDENT field
 S STAFF="R" I $D(^XUSEC("SR STAFF SURGEON",X)) S STAFF="S"
 S $P(^SRF(DA,.1),"^",3)=STAFF
 Q
KSTAFF ; update STAFF/RESIDENT when deleted
 S $P(^SRF(DA,.1),"^",3)=""
 Q
ANES ; update ANESTHETIST CATEGORY field
 N SRASITE,SRAML,SRACAT S SRASITE=$O(^SRO(133,0)) I SRASITE S SRAML=$P(^SRO(133,SRASITE,0),"^",4)
 S SRACAT=$S($D(^XUSEC("SR ANESTHESIOLOGIST",X)):"A",$D(^XUSEC("SR SURGEON",X)):"A",$D(^XUSEC("SR NURSE ANESTHETIST",X)):"N",1:"O")
 I SRACAT="A",SRAML'=$P($G(^VA(200,X,5)),"^",2) S SRACAT="O"
 S $P(^SRF(DA,.3),"^",8)=SRACAT K SRASITE,SRAML,SRACAT
 Q
KANES ; update ANESTHETIST CATEGORY when deleted
 S $P(^SRF(DA,.3),"^",8)=""
 Q
