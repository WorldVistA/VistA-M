RA148PST ;ABV/MKN - Post Install;10/5/2018 11:28 AM
 ;;5.0;Radiology/Nuclear Medicine;**148**;Mar 16, 1998;Build 59
 ;
 Q
 ;
EN ;
 ;First change the name of the seven -AUTO consult services (files #123.5 and #101.43),
 ;if they exist, to move the hyphen
 ;  Example:  "COMMUNITY CARE IMAGING-CT-AUTO"  to  "COMMUNITY CARE-IMAGING CT-AUTO"
 ;
 N DA,DIE,DR,ORN,RAFROM,RAI,RATO,X
 F RAI=1:1 S X=$T(LIST+RAI) Q:X=" ;//"  S RAFROM=$P(X,";",2),RATO=$P(X,";",3) D
 .S DA=$O(^GMR(123.5,"B",RAFROM,"")) D:DA
 ..S DIE="^GMR(123.5,",DR=".01///"_RATO D ^DIE
 .S DA=$O(^ORD(101.43,"B",$E(RAFROM,1,30),"")) D:DA
 ..S X=$$GET1^DIQ(101.43,DA_",",.01)
 ..I X=RAFROM S DIE="^ORD(101.43,",DR=".01///"_RATO_";1.1///"_RATO D ^DIE
 ;
 D QUEUE
 ;
 Q
 ;
LIST ;
 ;COMMUNITY CARE IMAGING-CT-AUTO;COMMUNITY CARE-IMAGING CT-AUTO
 ;COMMUNITY CARE IMAGING-MAMMOGRAPHY DIAGNOSTIC-AUTO;COMMUNITY CARE-IMAGING MAMMOGRAPHY DIAGNOSTIC-AUTO
 ;COMMUNITY CARE IMAGING-MAMMOGRAPHY SCREEN-AUTO;COMMUNITY CARE-IMAGING MAMMOGRAPHY SCREEN-AUTO
 ;COMMUNITY CARE IMAGING-MAGNETIC RESONANCE IMAGING-AUTO;COMMUNITY CARE-IMAGING MAGNETIC RESONANCE IMAGING-AUTO
 ;COMMUNITY CARE IMAGING-NUCLEAR MEDICINE-AUTO;COMMUNITY CARE-IMAGING NUCLEAR MEDICINE-AUTO
 ;COMMUNITY CARE IMAGING-GENERAL RADIOLOGY-AUTO;COMMUNITY CARE-IMAGING GENERAL RADIOLOGY-AUTO
 ;COMMUNITY CARE IMAGING-ULTRASOUND-AUTO;COMMUNITY CARE-IMAGING ULTRASOUND-AUTO
 ;//
QUEUE ;
 N ZTRTN,ZTDESC,ZTREQ,ZTIO,ZTDTH,ZTSK
 D BMES^XPDUTL("Calling TaskMan to create background job to change service name where needed in")
 D BMES^XPDUTL("  Order Actions multiple of file #100")
 S ZTRTN="CHGORAC^RA148PST",ZTDESC="Change service name where needed in Order Actions multiple of file #100",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD I '$G(ZTSK) D BMES^XPDUTL("Unable to create TaskMan job - run CHGORAC^RA148PST after install finishes") Q 
 D BMES^XPDUTL("Post-install queued as task #"_$G(ZTSK))
 Q
 ;
CHGORAC ;
 ;Find orders where the name of the consult might need to be changed in the ORDER ACTIONS multiple
 ;  Example:  "COMMUNITY CARE IMAGING-CT-AUTO"  to  "COMMUNITY CARE-IMAGING CT-AUTO"
 ;
 N CT,CTXTMP,CTXTMPPP,DA,IEN,ORACT,ORDATE,ORN,X,X1,X2,XTMP,XTMPPP
 S DA=$$NOW^XLFDT,X1=DA,X2=90 D C^%DTC
 S XTMP=$NA(^XTMP("RA148PST "_$$FMTE^XLFDT(DA,"5PZ")_" "_$J)),(CT,CTXTMP,CTXTMPPP)=0
 K @XTMP S @XTMP@(0)=X_U_DA_U_"List of ORDER ACTION records in file #100 where the name of the consult service was changed"
 S XTMPPP=$NA(^XTMP("RA148PST-PP "_$$FMTE^XLFDT(DA,"5PZ")_" "_$J))
 K @XTMPPP S @XTMPPP@(0)=X_U_DA_U_"Records Pre and Post"
 S ORDATE="3180101" F  S ORDATE=$O(^OR(100,"AF",ORDATE)) Q:'ORDATE  S IEN=0 D
 .F  S IEN=$O(^OR(100,"AF",ORDATE,IEN)) Q:'IEN  D
 ..S ORACT=0 F  S ORACT=$O(^OR(100,"AF",ORDATE,IEN,ORACT)) Q:'ORACT  D
 ...S ORN=0 F  S ORN=$O(^OR(100,IEN,8,ORACT,.1,ORN)) Q:'ORN  S X=^(ORN,0) D CHKORDAC(X)
 S CTXTMP=CTXTMP+1
 I 'CT S @XTMP@(CTXTMP)="No records found that needed changing"
 E  S @XTMP@(CTXTMP)="End of run: "_CT_" record"_$S(CT>1:"s",1:"")_" found and changed"
 S ZTREQ="@"
 K X S X(1)="RA*5.0*148 - the background job has finished changing the consult records."
 I CT=0 S X(2)="No records were changed."
 E  S X(2)=CT_" record"_$S(CT>1:"s were",1:" was")_" changed"
 D MSG(.X)
 Q
 ;
CHKORDAC(IN) ;
 N FROM,I,OR0,ORPNA,TO,Y,Z
 F I=1:1 S X=$T(LIST+I) Q:X=" ;//"  S FROM=$P(X,";",2),TO=$P(X,";",3) D
 .S Y=$F(IN,FROM) Q:'Y
 .S Z=$E(IN,1,(Y-$L(FROM))-1)_TO_$E(IN,Y,$L(IN))
 .S OR0=$G(^OR(100,IEN,0))
 .I OR0="" S ORPNA="Not Known"
 .E  S ORPNA=$$GET1^DIQ(100,IEN_",",.02,"E")
 .S CT=CT+1,CTXTMP=CTXTMP+1,@XTMP@(CTXTMP)=CT_". "_ORPNA_" Order IEN:"_IEN_" Consult to Service/Specialty changed:"
 .S CTXTMP=CTXTMP+1,@XTMP@(CTXTMP)="  from "_FROM_" to "_TO
 .S CTXTMPPP=CTXTMPPP+1,@XTMPPP@(CTXTMPPP)="^OR(100,"_IEN_",8,"_ORACT_",.1,"_ORN_",0)"
 .S @XTMPPP@(CTXTMPPP,1)=^OR(100,IEN,8,ORACT,.1,ORN,0)
 .S @XTMPPP@(CTXTMPPP,2)=Z
 .S ^OR(100,IEN,8,ORACT,.1,ORN,0)=Z
 Q
 ;
MSG(SUB) ;create and send message
 N XMDUZ,XMSUB,XMZ,XMTEXT,XMY
 N IEN,A,B,C,LNCNT S (IEN,A,B,C)=0,LNCNT=1
 S XMY(DUZ)=""
 S XMDUZ=DUZ
 S XMSUB="RA*5.0*148 Post-install"
 D XMZ^XMA2 ; call Create Message Module
 S XMTEXT="XMTEXT"
 M XMTEXT=SUB
 D ENL^XMD
 D ENT1^XMD
 Q
 ;
