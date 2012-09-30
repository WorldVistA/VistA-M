NUPABCL2  ;PHOENIX/KLD; 2/23/09; ADMISSION ASSESSMENT/CAREPLAN BROKER CALLS; 1/13/12  3:55 PM
 ;;1.0;NUPA;;;Build 105
ST Q
 ;
APO(R,DFN)  ;Active/pending orders.
 N A,C,HR24,I,II,ORD,X,X1,X2,YEST K ^TMP($J)
 S HR24=$P(DFN,U,2),DFN=+DFN,A=DFN_";DPT(",C=0
 S YEST="" I HR24 S X1=DT,X2=-1 D C^%DTC S YEST=9999999-X
 F I=0:0 S I=$O(^OR(100,"AC",A,I)) Q:'HR24&('I)  Q:HR24&(I>YEST)  Q:'I  D
 .F ORD=1:0 S ORD=$O(^OR(100,"AC",A,I,ORD)) Q:'ORD  D
 ..S X=$$GET1^DIQ(100,ORD,1),X("PROV")=$S(X]"":X,1:"UNKNOWN")
 ..S X=$$GET1^DIQ(100,ORD,21),X("SD")=$S(X]"":X,1:"UNKNOWN")
 ..S X=$$GET1^DIQ(100,ORD,5) Q:X'="ACTIVE"&(X'="PENDING")  ;Get only Active & Pending orders
 ..S X=$$GET1^DIQ(100,ORD,2) Q:X["ALLERGY ENTER/EDIT"
 ..;next IF is for text orders with no orderable items
 ..;IA 3800 allows direct global reads of ^OR(100,D0,.1
 ..D:'$D(^OR(100,ORD,.1)) TEXTORD
 ..F II=0:0 S II=$O(^OR(100,ORD,.1,II)) Q:'II  D
 ...S X(101.43)=$G(^ORD(101.43,+^OR(100,ORD,.1,II,0),0)),X=$P(X(101.43),U,5)
 ...S X("DG")=$S(X:$P(^ORD(100.98,X,0),U),1:"UNKNOWN")  ;Display group
 ...S X("ITEM")=$P(X(101.43),U) D SET
 S:'$D(^TMP($J)) ^TMP($J,0)="NONE FOUND" S R=$NA(^TMP($J)) Q
TEXTORD N I,II,III,TO S X("DG")="Text Order",X("ITEM")=""
 F I=0:0 S I=$O(^OR(100,ORD,8,I)) Q:'I  D
 .F II=0:0 S II=$O(^OR(100,ORD,8,I,.1,II)) Q:'II  D
 ..S X("ITEM")=X("ITEM")_" "_^OR(100,ORD,8,I,.1,II,0)
 D:X("ITEM")]"" SET Q
 ;
IM(R,DFN)  ;Inpatient med list
 N DAYS,FLAG S DAYS=$P(DFN,U,2),DFN=+DFN,FLAG=0 D AM^NUPAOBJ1(DAYS)
 K ^TMP($J) F I=0:0 S I=$O(^TMP("NUPA",$J,I)) Q:'I  D
 .S:^TMP("NUPA",$J,I,0)["IV Meds" FLAG=1 S:FLAG ^TMP($J,I)=^TMP("NUPA",$J,I,0)
 K ^TMP("NUPA",$J) S R=$NA(^TMP($J)) Q
 ;
CPH(R,DA)  ;History of the whole care plan
 K ^TMP($J) N C,I,II,REC,X S C=0 S REC=$G(^NUPA(1927.4,DA,0))
 D SET1("Plan entered on "_$$D($P(REC,U)))
 D SET1("By: "_$S($P(REC,U,3):$$GET1^DIQ(200,$P(REC,U,3),.01),1:"UNKNOWN"))
 I '$D(^NUPA(1927.5,"B",DA)) D SET1(""),SET1("No changes for this plan of care")
 F I=9E9:0 S I=$O(^NUPA(1927.5,"B",DA,I),-1) Q:'I  D
 .S X=$G(^NUPA(1927.5,I,0)) D SET1("")
 .D SET1("Field "_$S($P(X,U,2):$P(^DD(1927.4,$P(X,U,2),0),U),1:"Unknown")_" was changed on")
 .D SET1($$D($P(X,U,3))_" by "_$S($P(X,U,4):$$GET1^DIQ(200,$P(X,U,4),.01),1:"UNKNOWN"))
 .S X="  Old value: " S:$P($G(^NUPA(1927.5,I,1,0)),U,3)=1 X=X_^NUPA(1927.5,I,1,1,0)
 .D SET1(X) D:$P($G(^NUPA(1927.5,I,1,0)),U,3)>1
 ..F II=0:0 S II=$O(^NUPA(1927.5,I,1,II)) Q:'II  D SET1("    "_^NUPA(1927.5,I,1,II,0))
 .S X="  New value: " S:$P($G(^NUPA(1927.5,I,2,0)),U,3)=1 X=X_^NUPA(1927.5,I,2,1,0)
 .D SET1(X) D:$P($G(^NUPA(1927.5,I,2,0)),U,3)>1
 ..F II=0:0 S II=$O(^NUPA(1927.5,I,2,II)) Q:'II  D SET1("    "_^NUPA(1927.5,I,2,II,0))
 S R=$NA(^TMP($J)) Q
 ;
DPH(R,DA,FLAG) ;Discharge planning comments
 ;FLAG=1: All comments.  FLAG=2: Latest comment.
 N CNT,I,II,PROB K ^TMP($J) S CNT=1,^TMP($J,"LIST",1)="*** Prior comments ***"
 S ^TMP($J,"LIST",2)="  NONE"
 F I=9E9:0 S I=$O(^NUPA(1927.6,"B",DA,I),-1) Q:'I  D
 .S PROB=$P($G(^NUPA(1927.6,I,0)),U,2),PROB("D")=$P(^NUPA(1927.6,I,0),U,4) Q:'PROB
 .I FLAG=1 D DPHS(I) Q
 .Q:$D(^TMP($J,"SORT",PROB))  S ^TMP($J,"SORT",PROB)=I
 I FLAG=2 F PROB=0:0 S PROB=$O(^TMP($J,"SORT",PROB)) Q:'PROB  D DPHS(^TMP($J,"SORT",PROB))
 K ^TMP($J,"SORT") S R=$NA(^TMP($J,"LIST")) Q
DPHS(N) N II S CNT=CNT+1,^TMP($J,"LIST",CNT)="Discharge planning issue: "_$P($$GET1^DIQ(1927.41,PROB,.01),"*")
 F II=0:0 S II=$O(^NUPA(1927.6,N,1,II)) Q:'II  D
 .S CNT=CNT+1,^TMP($J,"LIST",CNT)=^NUPA(1927.6,N,1,II,0)
 S CNT=CNT+1,^TMP($J,"LIST",CNT)="Comment added by "_$$GET1^DIQ(200,$P($G(^NUPA(1927.6,N,0)),U,3),.01)_" ("_$$GET1^DIQ(200,$P($G(^NUPA(1927.6,N,0)),U,3),8)_") on "_$$D1(PROB("D"))
 S CNT=CNT+1,^TMP($J,"LIST",CNT)="" Q
 ;
UL(R,DA)  ;List of pressure ulcers & other skin alterations for this care plan
 N C,NUPA,X S C=0 K ^TMP($J)
 F NUPA("I")=0:0 S NUPA("I")=$O(^NUPA(1927.401,"B",DA,NUPA("I"))) Q:'NUPA("I")  S X=NUPA("I") D
 .Q:$$GET1^DIQ(1927.401,NUPA("I"),1)=""  ;No location
 .F NUPA("II")=1:1:7 S:NUPA("II")'=4 X=X_U_$$GET1^DIQ(1927.401,NUPA("I"),NUPA("II"))
 .D SET1(X)
 S R=$NA(^TMP($J)) Q
 ;
SL(R,NUPADAT)  ;Set pressure ulcers & other skin alterations for this care plan
 ;X(n)="A" or "P" ^ Care plan DA ^ Data 1 ^ Data 2 ^ Data 3 ^ # of lines of comments ^ Comments ^ Healed (1 or 0)
 N DA,DIC,DIE,DR,NUPA,NUPAALTS S (DIC,DIE)="^NUPA(1927.401,",DIC(0)="L"
 F NUPA("I")=-1:0 S NUPA("I")=$O(NUPADAT(NUPA("I"))) Q:NUPA("I")=""  D
 .S DA=-1
 .F NUPA("II")=0:0 S NUPA("II")=$O(^NUPA(1927.401,"B",$P(NUPADAT(NUPA("I")),U,2),NUPA("II"))) Q:'NUPA("II")!(DA>0)  D
 ..S:$P(NUPADAT(NUPA("I")),U)="A"&($$GET1^DIQ(1927.401,NUPA("II"),5)=$P(NUPADAT(NUPA("I")),U,3))&($$GET1^DIQ(1927.401,NUPA("II"),1)=$P(NUPADAT(NUPA("I")),U,4)) DA=NUPA("II") ;Type, Location check
 ..S:$P(NUPADAT(NUPA("I")),U)="P"&($$GET1^DIQ(1927.401,NUPA("II"),5)="Pressure Ulcer")&($$GET1^DIQ(1927.401,NUPA("II"),1)=$P(NUPADAT(NUPA("I")),U,3)) DA=NUPA("II")
 .S DR=""
 .I DA=-1 K DD,DO S X=$P(NUPADAT(NUPA("I")),U,2) D FILE^DICN S DA=+Y S:$P(NUPADAT(NUPA("I")),U)="P" DR="5///Pressure Ulcer;"
 .S DR=DR_"1///"_$P(NUPADAT(NUPA("I")),U,$S($P(NUPADAT(NUPA("I")),U)="A":4,1:3))
 .I $P(NUPADAT(NUPA("I")),U)="A" D
 ..S DR=DR_";5///"_$P(NUPADAT(NUPA("I")),U,3)_";6///"_$P(NUPADAT(NUPA("I")),U,5)
 ..S:$P(NUPADAT(NUPA("I")),U,8) DR=DR_";7///1" ;Healed
 .S:$P(NUPADAT(NUPA("I")),U)="P" DR=DR_";2///"_$P(NUPADAT(NUPA("I")),U,4)_";3///"_$P(NUPADAT(NUPA("I")),U,5)
 .D ^DIE
 .F NUPA("III")=1:1:$P(NUPADAT(NUPA("I")),U,6) D  ;Comments
 ..D WPSET^NUPABCL(.R,"^NUPA(1927.401,"_DA_",1",NUPA("III"),$P($P(NUPADAT(NUPA("I")),U,7),"***",NUPA("III")))
 S R=1 Q
 ;
IV(R,DA)  ;List of IVs for this care plan
 N C,I,II,NUPADC S C=0,NUPADC=$P(DA,U,2),DA=+DA K ^TMP($J)
 F I=0:0 S I=$O(^NUPA(1927.402,"B",DA,I)) Q:'I  S X=I D
 .Q:$$GET1^DIQ(1927.402,I,1)=""  ;No location
 .;I 'NUPADC Q:$$GET1^DIQ(1927.402,I,6)]""  ;D/Ced IVs
 .F II=1:1:8,10:1:13 S X=X_U_$$GET1^DIQ(1927.402,I,II)
 .D SET1(X)
 S R=$NA(^TMP($J)) Q
 ;
GC(R) ;Get component information
 K ^TMP($J) N CNT,I,II,X S CNT=0
 F I=0:0 S I=$O(^NUPA(1927.41,I)) Q:'I  D
 .F II=0:0 S II=$O(^NUPA(1927.41,I,1,II)) Q:'II  S X=^NUPA(1927.41,I,1,II,0) D:$P(X,U,3)
 ..S CNT=CNT+1,^TMP($J,CNT)=^NUPA(1927.41,I,0)_U_I_U_$P(X,U,1,2)
 S R=$NA(^TMP($J)) Q
 ;
GI(R,DA)  ;List of GI/GU devices for this care plan
 N C,I,II,X S C=0 K ^TMP($J)
 F I=0:0 S I=$O(^NUPA(1927.403,"B",DA,I)) Q:'I  S X=I D
 .Q:$P(^NUPA(1927.403,I,0),U,4)  ;Removed
 .F II=1,2,3,5 S X=X_U_$$GET1^DIQ(1927.403,I,II)
 .D SET1(X)
 S R=$NA(^TMP($J)) Q
 ;
RAOK(R,DFN)  ;Check if it's OK to show the update reassessment radiobuttons
 ;Must be at least one reassessment note since admission
 ;Note must be in last 24 hours
 N %DT,ADM,DA,H1,H2,NUPANOTX,NUPATIME,RANOTE,X,Y
 S ADM=$P($$LADM^NUPAOBJ(2),U) I ADM=0 S R="0^NOT ADMITTED" Q
 S NUPANOTX="",RANOTE=$$LN^NUPAOBJ("RN REASSESSMENT","1D")
 S RANOTE=$G(^TMP("NUPA",$J,1,0))
 I RANOTE["#0" S R="0^None in last 24 hours" Q  ;None found
 S DA=$P($P(RANOTE,"#",2),")"),NUPATIME=$$GET1^DIQ(8925,DA,1201)
 S RANOTE=$P($P(RANOTE,": ",2),"  ("),RANOTE=$P(RANOTE,":",1,2)
 S %DT="R",X=RANOTE D ^%DT
 S H1=$$FMTH^XLFDT(Y),X=$$HDIFF^XLFDT($H,H1,3)
 S R=$S($E(X):0,+$P(X," ",2)>23:0,1:1)_U_NUPATIME Q
 ;
HF(R) ;Get ONS Health Factors
 N C,DIC,NUPA,X,Y S C=0 K ^TMP($J),^TMP("DILIST",$J)
 D FIND^DIC(9999999.64,"",.01,"P","ONS",9999)
 F NUPA("I")=0:0 S NUPA("I")=$O(^TMP("DILIST",$J,NUPA("I"))) Q:'NUPA("I")  D
 .S X=^TMP("DILIST",$J,NUPA("I"),0)
 .D:X["ONS AA"!(X["ONS RA")!(X["ONS TOBACCO") SET1($P(X,U,2)_U_$P(X,U))
 ;S DIC="^AUTTHF(",DIC(0)="M"
 ;S X="LIFETIME NON-USER OF TOBACCO" D ^DIC D SET1($P(Y,U,2)_U_+Y)
 ;S X="FORMER TOBACCO USER" D ^DIC D SET1($P(Y,U,2)_U_+Y)
 ;S X="CURRENT TOBACCO USER" D ^DIC D SET1($P(Y,U,2)_U_+Y)
 K ^TMP($J,"SORT") S R=$NA(^TMP($J)) Q
 ;
ALG(R,DFN) ;Get allergies
 N NUPA,GMRAL S NUPA("CNT")=0
 D EN1^GMRADPT ;IA 10099
 F NUPA("I")=0:0 S NUPA("I")=$O(GMRAL(NUPA("I"))) Q:'NUPA("I")  D
 .S NUPA("CNT")=NUPA("CNT")+1,R(NUPA("CNT"))=$P(GMRAL(NUPA("I")),U,2)_U_NUPA("I")
 Q
APPTS(R,DFN)  ;Get future appointments
 N NUPA,X,X1,X2 S $P(NUPA("SP")," ",20)="",X1=DT,X2=365 D C^%DTC
 S NUPA(1)=DT_";"_X,NUPA(4)=DFN,NUPA("FLDS")="2;3;9",NUPA("SORT")="P"
 S NUPA("CNT")=0,CNT=$$SDAPI^SDAMA301(.NUPA) ;IA 4433
 ;S ^TMP("NUPA",$J,1)="DATE                CLINIC",^TMP("NUPA",$J,2)=""
 F NUPA("I")=0:0 S NUPA("I")=$O(^TMP($J,"SDAMA301",DFN,NUPA("I"))) Q:'NUPA("I")  D
 .Q:$P($P(^TMP($J,"SDAMA301",DFN,NUPA("I")),U,3),";")["C"  ;Cancelled
 .S NUPA("CNT")=NUPA("CNT")+1,^TMP("NUPA",$J,NUPA("CNT"))=$E($$D(NUPA("I"))_NUPA("SP"),1,20)_$P($P(^TMP($J,"SDAMA301",DFN,NUPA("I")),U,2),";",2)
 S:NUPA("CNT")=0 ^TMP("NUPA",$J,1)="NONE"
 S R=$NA(^TMP("NUPA",$J)) Q
 ;
ACNOTE(R,DFN,NUPASTR)   ;Create Audit C note text based on last administration
 N NUPA,NUPATEXT,X S NUPA("VIS")="",NUPA("NEVER")=0
 S NUPA("DA")=$O(^YTT(601.84,"C",DFN,9E9),-1)
 I 'NUPA("DA") S R(1)="No instrument administration on file" Q
 S NUPA("LOC")=$$GET1^DIQ(601.84,NUPA("DA"),13,"I")
 S NUPATEXT(1)="Alcohol Use Disorders Identification Test Consumption (AUDC)"
 S NUPATEXT(2)=""
 S NUPATEXT(3)="Date Given: "_$P($$GET1^DIQ(601.84,NUPA("DA"),3),"@")
 S NUPATEXT(4)="Clinician: "_$$GET1^DIQ(601.84,NUPA("DA"),6)
 S NUPATEXT(5)="Location: "_NUPA("LOC")
 S NUPATEXT(6)=""
 S NUPATEXT(7)="Veteran: "_$$GET1^DIQ(601.84,NUPA("DA"),1)
 S NUPATEXT(8)="SSN: "_"xxx-xx-"_$E($$GET1^DIQ(2,DFN,.09),6,9)
 S NUPATEXT(9)="DOB: "_$$GET1^DIQ(2,DFN,.03)_" ("_$$GET1^DIQ(2,DFN,.033)_")"
 S NUPATEXT(10)="Gender: "_$$GET1^DIQ(2,DFN,.02)
 S NUPATEXT(11)=""
 S NUPATEXT(12)=""
 S NUPATEXT(13)="   AUDC Score: "_$P($P(NUPASTR,U,4),"~",2)_" points"
 S NUPATEXT(14)=""
 S NUPATEXT(15)="In men, a score of 4 or more is considered positive; in women, a score of 3 or "
 S NUPATEXT(16)="more is considered positive."
 S NUPATEXT(17)=""
 S NUPATEXT(18)="  Questions and Answers"
 S NUPATEXT(19)="",NUPA("CNT")=19,NUPASTR=$P(NUPASTR,U,5)
 F NUPA("I")=2:1 Q:$P(NUPASTR,"*",NUPA("I"))=""  D
 .S:NUPA("I")=2&($P($P(NUPASTR,"*",NUPA("I")),"~",2)["Never") NUPA("NEVER")=1
 .S NUPA("CNT")=NUPA("CNT")+1,NUPATEXT(NUPA("CNT"))=$P($P(NUPASTR,"*",NUPA("I")),"~")
 .S NUPA("CNT")=NUPA("CNT")+1,NUPATEXT(NUPA("CNT"))="     "_$P($P(NUPASTR,"*",NUPA("I")),"~",2)
 .S:NUPA("I")>2&(NUPA("NEVER")) NUPATEXT(NUPA("CNT"))="     Not asked (patient reports no drinking in past year)"
 S NUPA("CNT")=NUPA("CNT")+1,NUPATEXT(NUPA("CNT"))=""
 S NUPA("CNT")=NUPA("CNT")+1,NUPATEXT(NUPA("CNT"))="Information contained in this note is based on a self report assessment and is"
 S NUPA("CNT")=NUPA("CNT")+1,NUPATEXT(NUPA("CNT"))="not sufficient to use alone for diagnostic purposes. Assessment results should"
 S NUPA("CNT")=NUPA("CNT")+1,NUPATEXT(NUPA("CNT"))="be verified for accuracy and used in conjunction with other diagnostic activities."
 M R=NUPATEXT Q
NOTENM() Q "1781^MENTAL HEALTH DIAGNOSTIC STUDY NOTE"  ;IEN & name of Note Title
 ;
SET S C=C+1,^TMP($J,X("DG"),X("SD"),ORD,C)=X("DG")_U_X("ITEM")_U_X("SD")_U_X("PROV") Q
SET1(X) S C=C+1,^TMP($J,C)=X Q
D(Y) D DD^%DT Q Y
D1(Y) D DD^%DT Q $P(Y,"@")_" on "_$P(Y,"@",2)
