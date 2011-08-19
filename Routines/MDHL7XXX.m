MDHL7XXX ; HOIFO/DP - Loopback device for CP ;4/10/09  09:20
 ;;1.0;CLINICAL PROCEDURES;**21**;Apr 01, 2004;Build 30
 ; IA#  2263 [Supported] XPAR Call
 ;      2693 [Subscription] TIU Extractions.
 ;      2980 [Subscription] Calls to GMRCGUIB.
 ;      3160 [Subscription] GMRCMED Call
 ;      3067 [Private] Read fields in Consult file (#123) w/FM
 ;      3468 [Subscription] GMRCCP API.
 ;      3535 [Subscription] Calls to TIUSRVP.
 ;      4508 [Subscription] Call to TIUSRVPT.
 ;     10060 [Supported] New Person File (#200) Read w/FM.
 ;     10103 [Supported] Calls to XLFDT
 ;
EN ; [Procedure] Main entry point
 ; wait 10 seconds and then produce some results in the CP RESULTS file
 ; Variables STUDY and INST passed in via taskman
 H 10 ; Wait for the study to update
 N MDFDA,MDIEN,MDERR K ^TMP($J)
 L +(^MDD(703.1,"B")):15 E  Q
 F  D  Q:'$D(^MDD(703.1,"B",X))
 .S X="127001_"_(+$H)_$E($P($H,",",2)_"00000",1,5)
 S MDFDA(703.1,"+1,",.01)=X
 D UPDATE^DIE("","MDFDA","MDIEN","MDERR")
 L -(^MDD(703.1,"B"))
 S MDIEN=+$G(MDIEN(1),-1)_"," Q:+MDIEN<0
 ; Proceed to build the report here using MDIEN in file 703.1
 S MDFDA(703.1,MDIEN,.02)=$P(^MDD(702,STUDY,0),U,1)
 S MDFDA(703.1,MDIEN,.03)=$$NOW^XLFDT()
 S MDFDA(703.1,MDIEN,.04)=INST
 D:+$$GET1^DIQ(702.09,INST_",",.13,"I")  ; Bi-Directional?
 .S MDFDA(703.1,MDIEN,.05)=STUDY
 ;
 ;; New Loopback Method -- BEGIN
 S MDFDA(703.1,MDIEN,.09)="P"
 S MDFDA(703.11,"+2,"_MDIEN,.01)="3"
 S MDFDA(703.11,"+2,"_MDIEN,.1)="\\vhaishmul14\uploads\body-box-study_19960228_000.pdf"
 D UPDATE^DIE("","MDFDA","MDIEN","MDERR")
 ;; New Loopback Method -- END
 ;
 ; New High Volume Procedure code begin
 N MDSR S MDSR=$$NTIU^MDRPCW1(+STUDY,+MDIEN)
 ; New High Volume Procedure end 
 ;; Original Loopback Method -- BEGIN
 ;S MDFDA(703.11,"+2,"_MDIEN,.01)="1"
 ;D UPDATE^DIE("","MDFDA","MDIEN","MDERR")
 ;S MDIEN=+MDIEN(2)_","_MDIEN
 ;S MDFDA(703.11,MDIEN,.2)=$NA(MDFDA(703.11,MDIEN,.2))
 ;D GETS^DIQ(702,STUDY_",",".01;.011;.02;.03;.04;.05;.06;.07;.08;.09;.091;.1;.11;.12;.991","ENR",$NA(^TMP($J)))
 ;S X="" F  S X=$O(^TMP($J,702,STUDY_",",X)) Q:X=""  D
 ;.S Y=$O(MDFDA(703.11,MDIEN,.2,""),-1)+1
 ;.S MDFDA(703.11,MDIEN,.2,Y)=X_": "_$G(^TMP($J,702,STUDY_",",X,"E"))
 ;S MDFDA(703.1,$P(MDIEN,",",2,3),.09)="P"
 ;D UPDATE^DIE("","MDFDA","MDIEN","MDERR")
 ;; Original Loopback Method -- END
 ;
 K ^TMP($J)
 Q
 ;
TEST ; Queue up the study creator
 N DIC
 S DIC=702,DIC(0)="AEQM",DIC("A")="Select Study to create a report for: "
 D ^DIC Q:+Y<1
 S STUDY=+Y,INST=+$P(^MDD(702,+Y,0),U,11)
 D LOOPBACK(STUDY,INST)
 Q
 ;
LOOPBACK(STUDY,INST) ; Queue up the Loopback process
 N ZTSAVE,ZTRTN,ZTIO,ZTDESC,ZTDTH,ZTSK
 S ZTSAVE("STUDY")=STUDY,ZTSAVE("INST")=INST
 S ZTRTN="EN^MDHL7XXX"
 S ZTIO=""
 S ZTDESC="CP Loopback test"
 S ZTDTH=$$NOW^XLFDT()
 D ^%ZTLOAD
 Q
PROCESS ; Process Device Results
 N MDADD,MDADAR,MDARAD,MDWA,MDALRT,MDAPU,MDCONRS,MDCST,MDCX,MDFD,MDFDA,MDL,MDL1,MDHR,MDHVL,MDKK,MDMAXD,MDMG,MDRR,MDSTU,MDSTAT,MDTIUER,MDX,MDX4
 S MDMAXD=DT+.24,(MDRR,MDARAD,MDTIUER)="" K ^TMP("MDTIUST",$J)
 D GETLST^XPAR(.MDHVL,"SYS","MD GET HIGH VOLUME")
 S MDAPU="CLINICAL,DEVICE PROXY SERVICE"
 S MDFD=$$FIND1^DIC(200,,"X",MDAPU,"B")
 F MDKK=0:0 S MDKK=$O(MDHVL(MDKK)) Q:MDKK<1  S:+$P($G(MDHVL(MDKK)),"^") MDHR(+$P($G(MDHVL(MDKK)),"^"))=$P($G(MDHVL(MDKK)),"^",2)
 S MDL=$$FMADD^XLFDT(DT,-5,0,0)  F  S MDL=$O(^MDD(702,"ASD",MDL)) Q:MDL<1!(MDL>MDMAXD)  F MDL1=0:0 S MDL1=$O(^MDD(702,"ASD",MDL,MDL1)) Q:MDL1<1  S MDX=$G(^MDD(702,MDL1,0)) D
 .Q:$G(MDHR(+$P(MDX,"^",4)))=""  S MDCX=$G(MDHR(+$P(MDX,"^",4)))
 .Q:$P($G(^MDS(702.01,+$P(MDX,U,4),0)),U,6)=2
 .S MDCST=$P(MDX,"^",5) Q:'+MDCST
 .Q:'+$P(MDX,"^",6)
 .K ^TMP("MDTIUST",$J),MDWA
 .S MDWA(1202)=MDFD,MDWA(1204)=MDFD,MDWA(1302)=MDFD
 .S MDWA("TEXT",1,0)="** DOCUMENT IN VISTA IMAGING **"
 .S MDWA("TEXT",2,0)="SEE FULL REPORT IN VISTA IMAGING",MDWA("TEXT",3,0)=""
 .D EXTRACT^TIULQ($P(MDX,U,6),"^TMP(""MDTIUST"",$J)",MDTIUER,".01;.05","E")
 .I $G(^TMP("MDTIUST",$J,$P(MDX,U,6),.05,"E"))'="COMPLETED"&('+$P(MDCX,";",2)) D  Q
 ..Q:$P(MDX,"^",9)'=3
 ..I +$P(MDCX,";",1) S MDCONRS=$$CPDOC^GMRCCP(+MDCST,+$P(MDX,"^",6),2) Q
 ..I '+$P(MDCX,";",1) D UPDATE^TIUSRVP(.MDRR,+$P(MDX,"^",6),.MDWA,1) D:+MDRR'<1 ADMNCLOS^TIUSRVPT(.MDARAD,+$P(MDX,"^",6),"M",MDFD) K MDWA D MEDCOMP^GMRCMED(+MDCST,$P(MDX,"^",6)_";TIU(8925,",DT,MDFD,$P(MDX,"^",3))
 ..Q
 .S MDSTU=MDL1 K MDWA
 .S MDSTAT=$$GET1^DIQ(123,+MDCST_",",8,"E") I MDSTAT="COMPLETE" Q:$P(MDX,"^",9)=3  K MDFDA S MDFDA(702,MDSTU_",",.09)=3 D FILE^DIE("","MDFDA") K MDFDA Q
 .I +$P(MDCX,";",2) D  Q
 ..D GID(MDSTU,.MDADAR)
 ..Q:$G(MDADAR(1))=""
 ..S MDADD=$$SFILE^GMRCGUIB(+MDCST,4,"Y",MDFD,MDFD,.MDADAR,"N","",$G(^MDD(702,+MDSTU,3)))
 ..S MDCONRS=$$CPDOC^GMRCCP(+MDCST,+$P(MDX,"^",6),2) Q
 .S MDGET=$O(^MDD(703.1,"ASTUDYID",MDL1,""),-1) Q:'MDGET  S MDDAT=$P($G(^MDD(703.1,MDGET,0)),"^",3)
 .D MEDCOMP^GMRCMED(+MDCST,$P(MDX,"^",6)_";TIU(8925,",MDDAT,MDFD,$P(MDX,"^",3))
 .K ^TMP("MDTIUST",$J)
 .I $P(MDX,"^",9)'=3 K MDFDA S MDFDA(702,MDSTU_",",.09)=3 D FILE^DIE("","MDFDA") K MDFDA
 Q
GID(STU,MDARY) ; Get the text array
 N LOOP,MDRID,NODE S MDRID=0,LOOP=""
 F  S LOOP=$O(^MDD(703.1,"ASTUDYID",STU,LOOP),-1) Q:LOOP<1!(+MDRID)  I +$P($G(^MDD(703.1,+LOOP,.4,0)),"^",3) S MDRID=+LOOP,NODE=$$GET1^DIQ(703.1,MDRID_",",.4,"","MDARY")
 I +MDRID K MDFDA S MDFDA(703.1,MDRID_",",.4)="@" D FILE^DIE("","MDFDA") K MDFDA
 Q
