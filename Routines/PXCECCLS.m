PXCECCLS ;WASH/BDB - UPDATE ENCOUNTER SC/EI FROM DX SC/EI ;5/18/05 1:31pm
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**124,174,168**;Feb 12, 2004;Build 14
 Q
 ;
VST(PXVIEN) ;
 ;  VISITIEN  Pointer to the Visit (#9000010)
 ;  Loop over the diagnoses SC/EI, auto-populate the encounter level
 ;   SC/EI based on the following rule:
 ;   
 ;   If the SC/EI for at least one ICD-9 is "Yes"the Encounter Level
 ;    SC/EI will automatically be set to "Yes" regardless if the
 ;     Encounter Level SC (or EI) was previously populated ("Yes", "No" or Null).
 ;            Note: This presumes that a single ICD-9 with SC/EI determination of "Yes"
 ;        makes the Encounter SC/EI determination "Yes"
 ;        
 ;       If the SC/EI for all ICD-9s are "No" the Encounter Level SC/EI will
 ;       automatically be set to "No" regardless if the Encounter Level SC/EI
 ;       was previously populated ("Yes", "No" or Null).
 ;            Note: This presumes that an Encounter SC/EI can not be "Yes" if all
 ;        ICD-9s have an SC/EI determination of "No".
 ;        
 ;       If at least one ICD-9 is missing SC/EI determination and none of the
 ;       other ICD-9s SC/EI determination is "Yes" do not change the SC/EI
 ;       determination of the Encounter level.
 ;                 Note: This presumes that if one or more ICD-9s do not have an SC/EI
 ;       determination then no inference can be made upon the Encounter Level SC
 ;       determination.  In addition if another package populates SC/EI
 ;       directly do not overwrite that value in the case of incomplete
 ;       data.  In other words do not set the Encounter Level to Null.
 ;       
 ;       VARIABLE LIST TO AUTO POPULATE THE ENCOUNTER LEVEL SC/EI
 ;       For each SC/EI in the PXSCEINW string:
 ;                =1  SC/EI Classification determined by the DX's is found to be "Yes"
 ;                =0  SC/EI Classification determined by the DX's is found to be "NO"
 ;                =-1 SC/EI can not be determined by the DX's
 ;                ="" Do not ask the SC/EI questions
 ;       
 ;       Edit flag for SC: SCEF, AO: AOEF, IR: IREF, EC:ECEF, MST: MSTEF, HNC: HNCEF
 ;           , CV: CVEF, SHAD:SHADEF  - Used in Visit File Filing - See ^VSITFLD
 ;           example below          
 ;       VIST("SCEF")=1  SC/EI Classification determined by the DX's - do not ask SC/EI
 ;       VIST("SCEF")=0  SC/EI Classification undetermined by the DX's - ask SC/EI
 ;       etc.
 ;             
 N PX0,PXDFN,PXDT,PXCL,PXPOV,VSIT,PXDFN,PXSCEINW,PXSCEI,PXPOV800
 S PXSCEINW="^^^^^^"
 ; Set encounter data in ^TMP
 D ENCEVENT^PXKENC(PXVIEN)
 ; Get classifications
 S PXDFN=$P($G(^TMP("PXKENC",$J,PXVIEN,"VST",PXVIEN,0)),U,5)
 Q:'PXDFN
 ;Loop over DX's
 S PXPOV="" F  S PXPOV=$O(^TMP("PXKENC",$J,PXVIEN,"POV",PXPOV)) Q:'PXPOV  D
 .S PXPOV800=$G(^(PXPOV,800))
 .I '($P(PXSCEINW,U,1)="1")  S:$P(PXPOV800,U,1)="1" $P(PXSCEINW,U,1)="1" I '($P(PXSCEINW,U,1)<0)  S:$P(PXPOV800,U,1)="" $P(PXSCEINW,U,1)="-1" S:$P(PXPOV800,U,1)="0" $P(PXSCEINW,U,1)="0"
 .I '($P(PXSCEINW,U,2)="1")  S:$P(PXPOV800,U,2)="1" $P(PXSCEINW,U,2)="1" I '($P(PXSCEINW,U,2)<0)  S:$P(PXPOV800,U,2)="" $P(PXSCEINW,U,2)="-1" S:$P(PXPOV800,U,2)="0" $P(PXSCEINW,U,2)="0"
 .I '($P(PXSCEINW,U,3)="1")  S:$P(PXPOV800,U,3)="1" $P(PXSCEINW,U,3)="1" I '($P(PXSCEINW,U,3)<0)  S:$P(PXPOV800,U,3)="" $P(PXSCEINW,U,3)="-1" S:$P(PXPOV800,U,3)="0" $P(PXSCEINW,U,3)="0"
 .I '($P(PXSCEINW,U,4)="1")  S:$P(PXPOV800,U,4)="1" $P(PXSCEINW,U,4)="1" I '($P(PXSCEINW,U,4)<0)  S:$P(PXPOV800,U,4)="" $P(PXSCEINW,U,4)="-1" S:$P(PXPOV800,U,4)="0" $P(PXSCEINW,U,4)="0"
 .I '($P(PXSCEINW,U,5)="1")  S:$P(PXPOV800,U,5)="1" $P(PXSCEINW,U,5)="1" I '($P(PXSCEINW,U,5)<0)  S:$P(PXPOV800,U,5)="" $P(PXSCEINW,U,5)="-1" S:$P(PXPOV800,U,5)="0" $P(PXSCEINW,U,5)="0"
 .I '($P(PXSCEINW,U,6)="1")  S:$P(PXPOV800,U,6)="1" $P(PXSCEINW,U,6)="1" I '($P(PXSCEINW,U,6)<0)  S:$P(PXPOV800,U,6)="" $P(PXSCEINW,U,6)="-1" S:$P(PXPOV800,U,6)="0" $P(PXSCEINW,U,6)="0"
 .I '($P(PXSCEINW,U,7)="1")  S:$P(PXPOV800,U,7)="1" $P(PXSCEINW,U,7)="1" I '($P(PXSCEINW,U,7)<0)  S:$P(PXPOV800,U,7)="" $P(PXSCEINW,U,7)="-1" S:$P(PXPOV800,U,7)="0" $P(PXSCEINW,U,7)="0"
 .I '($P(PXSCEINW,U,8)="1")  S:$P(PXPOV800,U,8)="1" $P(PXSCEINW,U,8)="1" I '($P(PXSCEINW,U,8)<0)  S:$P(PXPOV800,U,8)="" $P(PXSCEINW,U,8)="-1" S:$P(PXPOV800,U,8)="0" $P(PXSCEINW,U,8)="0"
 S VSIT("IEN")=PXVIEN
 S VSIT("SCEF")=0,VSIT("AOEF")=0,VSIT("IREF")=0,VSIT("ECEF")=0,VSIT("MSTEF")=0,VSIT("HNCEF")=0,VSIT("CVEF")=0,VSIT("SHADEF")=0
 S:$P(PXSCEINW,U,1)="0"!($P(PXSCEINW,U,1)="1") VSIT("SC")=$P(PXSCEINW,U,1),VSIT("SCEF")=1
 S:$P(PXSCEINW,U,2)="0"!($P(PXSCEINW,U,2)="1") VSIT("AO")=$P(PXSCEINW,U,2),VSIT("AOEF")=1 S:$G(VSIT("SC"))=1 VSIT("AO")="@"
 S:$P(PXSCEINW,U,3)="0"!($P(PXSCEINW,U,3)="1") VSIT("IR")=$P(PXSCEINW,U,3),VSIT("IREF")=1 S:$G(VSIT("SC"))=1 VSIT("IR")="@"
 S:$P(PXSCEINW,U,4)="0"!($P(PXSCEINW,U,4)="1") VSIT("EC")=$P(PXSCEINW,U,4),VSIT("ECEF")=1 S:$G(VSIT("SC"))=1 VSIT("EC")="@"
 S:$P(PXSCEINW,U,5)="0"!($P(PXSCEINW,U,5)="1") VSIT("MST")=$P(PXSCEINW,U,5),VSIT("MSTEF")=1
 S:$P(PXSCEINW,U,6)="0"!($P(PXSCEINW,U,6)="1") VSIT("HNC")=$P(PXSCEINW,U,6),VSIT("HNCEF")=1
 S:$P(PXSCEINW,U,7)="0"!($P(PXSCEINW,U,7)="1") VSIT("CV")=$P(PXSCEINW,U,7),VSIT("CVEF")=1
 S:$P(PXSCEINW,U,8)="0"!($P(PXSCEINW,U,8)="1") VSIT("SHAD")=$P(PXSCEINW,U,8),VSIT("SHADEF")=1
 D UPD^VSIT
 K ^TMP("PXKENC",$J)
 Q
