SROESNR0 ;BIR/ADM - NURSE REPORT E-SIG UTILITY ;11/01/2011
 ;;3.0;Surgery;**100,129,147,153,175,176,182**;24 Jun 93;Build 49
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure. Local modifications to this routine
 ;**         are prohibited.
 ;
 ; Reference to ^TMP("CSLSUR1" supported by DBIA #3498
 ;
VIEW N SRJ,SRCAT,SRFIELD,SRFLD,SRFILE,SRLN,SRNP,SRN,SRP,SRSUB,SRW,X,Y
 F SRJ=1:1 S SRFLD=$P($T(FIELD+SRJ),";;",2) Q:SRFLD=""  D
 .S SRNP=$P(SRFLD,"^",3),SRN=$P(SRNP,";"),SRP=$P(SRNP,";",2)
 .S (SRSUB,X)=$P(SRFLD,"^",2),Y=$P(X,"-",2),SRFILE=$P(Y,","),SRFIELD=$P(Y,",",2)
 .I SRFIELD=27 Q:'$P($G(^SRF(SRTN,"TIU")),"^",6)
 .I SRFIELD=66 Q:'$P($G(^SRF(SRTN,"TIU")),"^",7)
 .S SRCAT=$P(SRFLD,"^") S SRCAT=$S(SRCAT="":SRFILE,1:SRCAT)
 .S SRW=$S($P(Y,";",2)["W":1,1:0) I SRW D  Q
 ..S ^TMP("SRNRAD"_SRS,$J,SRTN,SRCAT,SRSUB,0)=$G(^SRF(SRTN,SRN,0))
 ..I SRS=1 S ^TMP("SRNSAVE",$J,SRTN,SRCAT,SRSUB,0)=$G(^SRF(SRTN,SRN,0))
 ..S SRLN=0 F  S SRLN=$O(^SRF(SRTN,SRN,SRLN)) Q:'SRLN  S ^TMP("SRNRAD"_SRS,$J,SRTN,SRCAT,SRSUB,SRLN)=$G(^SRF(SRTN,SRN,SRLN,0)) I SRS=1 S ^TMP("SRNSAVE",$J,SRTN,SRCAT,SRSUB,SRLN)=$G(^SRF(SRTN,SRN,SRLN,0))
 .S ^TMP("SRNRAD"_SRS,$J,SRTN,SRCAT,SRSUB)=$P($G(^SRF(SRTN,SRN)),"^",SRP)
 .I SRS=1 S ^TMP("SRNSAVE",$J,SRTN,SRCAT,SRSUB)=$P($G(^SRF(SRTN,SRN)),"^",SRP)
 Q
REVRS ; restore before-edit data
 N I,SRCAT,SRCNT,SRE,SRE1,SRFF,SRFIELD,SRFILE,SRFLD,SRI,SRIEN,SRJ,SRK,SRL,SRLN,SRN,SRNP,SRP,SRSUB,SRVAL,SRW,X,Y
 F SRJ=1:1 S SRFLD=$P($T(FIELD+SRJ),";;",2) Q:SRFLD=""  D
 .S SRNP=$P(SRFLD,"^",3),SRN=$P(SRNP,";"),SRP=$P(SRNP,";",2)
 .S (SRSUB,X)=$P(SRFLD,"^",2),Y=$P(X,"-",2),SRFILE=$P(Y,","),SRFIELD=$P(Y,",",2)
 .S SRCAT=$P(SRFLD,"^") S SRCAT=$S(SRCAT="":SRFILE,1:SRCAT)
 .Q:'$D(^TMP("SRNRAD1",$J,SRTN,130,SRSUB))
 .S SRW=$S($P(Y,";",2)["W":1,1:0) I SRW D  Q
 ..K ^SRF(SRTN,SRN) S ^SRF(SRTN,SRN,0)=$G(^TMP("SRNSAVE",$J,SRTN,130,SRSUB,0))
 ..S SRLN=0 F  S SRLN=$O(^TMP("SRNSAVE",$J,SRTN,130,SRSUB,SRLN)) Q:'SRLN  S ^SRF(SRTN,SRN,SRLN,0)=$G(^TMP("SRNSAVE",$J,SRTN,130,SRSUB,SRLN))
 .S SRVAL=$G(^TMP("SRNSAVE",$J,SRTN,130,SRSUB)) I SRFIELD=27 D  Q
 ..S $P(^SRF(SRTN,"OP"),"^",2)=SRVAL K DA,DIK S DA=SRTN,DIK="^SRF(",DIK(1)="27" D EN^DIK K DA,DIK
 ..;Set ^TMP("CSLSUR1",$J) in order to send an update trans. via Surgery/CoreFLS interface
 ..S ^TMP("CSLSUR1",$J)=""
 .I SRVAL="" S SRVAL="@"
 .K DA,DIE,DR S DA=SRTN,DIE=130,DR=SRFIELD_"////^S X=SRVAL" D ^DIE K DA,DIE,DR
 D REVRS^SROESNRA
 Q
TR S SRP=SRI,SRP=$TR(SRP,"1234567890.,","ABCDEFGHIJPK")
 Q
FIELD ; list of fields (^field name on report-file,field^node;piece)
KPJB ;;^Operating Room Procedure Performed-130,.02^0;2
KPJCE ;;^Surgical Priority-130,.035^0;10
KPBJC ;;^Time Patient Arrived in Holding Area-130,.203^.2;15
KPBJE ;;^Time Patient In the O.R.-130,.205^.2;10
KPBB ;;^Time the Operation Began-130,.22^.2;2
KPBC ;;^Time the Operation Ends-130,.23^.2;3
KPBJF ;;^Surgeon Present Time-130,.206^.2;9
KPBCB ;;^Time Patient Out of the O.R.-130,.232^.2;12
KPAD ;;^Primary Surgeon-130,.14^.1;4
KPAE ;;^First Assistant-130,.15^.1;5
KPAFD ;;^Attending Surgeon-130,.164^.1;13
KPAF ;;^Second Assistant-130,.16^.1;6
KPCA ;;^Principal Anesthetist-130,.31^.3;1
KPCC ;;^Assistant Anesthetist-130,.33^.3;3
KPAI ;;^Preoperative Mood-130,.19^.1;9
KPAIF ;;^Preoperative Consciousness-130,.196^.1;15
KPJG ;;^Preoperative Skin Integrity-130,.07^0;7
KPAIE ;;^Preoperative Conversation-130,.195^.1;14
KFJJ ;;^Confirm Correct Patient Identity-130,600^VER;7
KFJA ;;^Confirm Procedure To Be Performed-130,601^VER;8
KFJB ;;^Confirm Site of Procedure, Including Laterality-130,602^VER;9
KFJC ;;^Confirm Valid Consent Form-130,603^VER;10
KFJD ;;^Confirm Patient Position-130,604^VER;11
KFJE ;;^Confirm Proc. Site has been Marked Appropriately and the Site of the Mark is Visible After Prep-130,605^VER;12
KFJF ;;^Pertinent Medical Images Have Been Confirmed-130,606^VER;13
KFJG ;;^Correct Medical Implant(s) is Available-130,607^VER;14
KFJH ;;^Appropriate Antibiotic Prophylaxis-130,608^VER;15
KFJI ;;^Appropriate Deep Vein Thrombosis Prophylaxis-130,609^VER;16
KFAJ ;;^Blood Availability-130,610^VER;17
KFAA ;;^Availability of Special Equipment-130,611^VER;18
KHE ;;^Checklist Comment-130,85;W^51;0
KPFI ;;^Time Out Document Completed By-130,.69^.6;9
KPF ;;^Time Out Completed-130,74^.6;12
KPAH ;;^Skin Prepped By-130,.18^.1;8
KPAGE ;;^Skin Preparation Agent-130,.175^.1;7
KD ;;^Skin Prepped By (2)-130,4^.1;12
KH ;;^Second Skin Preparation Agent-130,8^31;2
KPAB ;;^Preop Hair Removal by-130,.12^.1;2
KEJF ;;^Hair Removal Method-130,506^VER;6
KEJH ;;^Hair Removal Comments-130,508;W^49;0
KPGE ;;^Electrocautery Unit-130,.75^.7;5
KPEE ;;^Electroground Placement-130,.55^.5;4
KF ;;^Electroground Position (2)-130,6^.5;13
KEG ;;^ESU Coagulation Range-130,57^.7;1
KEGC ;;^ESU Cutting Range-130,58^.7;2
KBF ;;^Principal Procedure-130,26^OP;1
KBG ;;^Principal CPT Code-130,27^OP;2
KFF ;;^Principal Diagnosis Code-130,66^34;2
KBB ;;^Tubes and Drains-130,22^3;1
KDD ;;^Sponge Final Count Correct-130,44^25;1
KDE ;;^Sharps Final Count Correct-130,45^25;2
KDF ;;^Instrument Final Count Correct-130,46^25;3
KFCJ ;;^Possible Item Retention-130,630^25;6
KFCC ;;^Wound Sweep-130,633^25;7
KFCF ;;^Intraoperative XRay-130,636^25;8
KAPAC ;;^ASA Class-130,1.13^1.1;3
KDG ;;^Person Responsible for Final Counts-130,47^25;4
KDH ;;^Count Verifier-130,48^25;5
KDA ;;^Dressing(s)-130,41^35;1
KPHGE ;;^Packing Type-130,.875^.8;11
KPBE ;;^Intraoperative Blood Loss (ml)-130,.25^.2;5
KPBEE ;;^Total Urine Output (ml)-130,.255^.2;16
KPHA ;;^Postoperative Mood-130,.81^.8;1
KPHBA ;;^Postoperative Consciousness-130,.821^.8;10
KPGF ;;^Postoperative Skin Integrity-130,.76^.7;6
KPGG ;;^Postoperative Skin Color-130,.77^.7;7
KABH ;;^Type of Laser-130,128^.7;8
KABG ;;^Sequential Compression Device (Y/N)-130,127^.7;3
KAPJI ;;^Wound Classification-130,1.09^1.0;8
KPDF ;;^Postoperative Disposition-130,.46^.4;6
KBE ;;^Patient Discharged Via-130,25^.7;4
KACA ;;^Device(s)-130,131^46;1
KDI ;;^Specimens-130,49;W^9;0
KFD ;;^Cultures-130,64;W^41;0
KPBI ;;^Nursing Care Comments-130,.29;W^7;0
KFAI ;;^Immed Use Steril Contamination-130,619^52;1
KFBJ ;;^Immed Use Steril SPS Processing/OR Management Issues-130,620^52;2
KFBA ;;^Immed Use Steril Emergency Case-130,621^52;3
KFBB ;;^Immed Use Steril No Better Option-130,622^52;4
KFBC ;;^Immed Use Steril Loaner or Short Notice Instrument-130,623^52;5
KFBD ;;^Immed Use Steril Decontamination of Instruments Contaminated During the Case-130,624^52;6
