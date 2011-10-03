SPNJRPCP ;BP/JAS - Returns most recent Vitals Pain Rating ;Jan 10, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; Reference to API EN6^GMRVUTL supported by IA #1120
 ; API $$FLIP^SPNRPCIC is part of Spinal Cord Version 3.0
 ;
 ; Parm values:
 ;     RETURN is the most recent Vitals Pain Rating for patient
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN,ICN) ;
 ;***************************
 K RETURN
 Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 ;***************************
 ;JAS - 01/10/2008 - Defect 766 DBIA Changes 
 ;Section of code below commented out and replaced due to DBIA changes
 ;Q:'$D(^GMR(120.5,"C",DFN))
 ;S VDA="",FOUND=0
 ;F  S VDA=$O(^GMR(120.5,"C",DFN,VDA),-1) Q:VDA=""!(FOUND)  D
 ;. Q:'$D(^GMR(120.5,VDA,0))
 ;. Q:$P($G(^GMR(120.5,VDA,2)),"^",1)=1
 ;. S VTYPE=$P(^GMR(120.5,VDA,0),"^",3)
 ;. Q:'$D(^GMRD(120.51,VTYPE))
 ;. Q:$P($G(^GMRD(120.51,VTYPE,0)),"^",1)'="PAIN"
 ;. S FOUND=1
 ;. S PRAT=$P(^GMR(120.5,VDA,0),"^",8)
 ;. S RETURN($J)=PRAT_"^EOL999"
 ;. Q
 ;K DFN,FOUND,PRAT,VDA,VTYPE
 S GMRVSTR="PN"
 D EN6^GMRVUTL
 S PRAT=$P(X,U,8)
 Q:PRAT=""
 S RETURN($J)=PRAT_"^EOL999"
 K DFN,GMRVSTR,PRAT,X
 Q
