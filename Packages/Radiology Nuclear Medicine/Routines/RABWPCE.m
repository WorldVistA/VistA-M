RABWPCE ;HISC/MM - Billing Awareness Project: PCE API ; 3/23/04 10:17am
 ;;5.0;Radiology/Nuclear Medicine;**41,70**; Mar 16, 1998;Build 7
 Q
 ;
DX(RAO) ; Create ^TMP("RAPXAPI",$J,"DX/PL" for PCE API:  Ordering ICD Dx.
 ; Called from LON+n^RAPCE.
 ; ^RAO(75.1,RAO,"BAx",0) = ICD Diagnosis^SC^AO^IR^EC^SHAD^MST^HNC
 ; NOTE: "EC" now represents "SWAC" but this internal value is not being changed.  only
 ; external display text is being modified.  This instance of "EC" is passed to PCE and 
 ; PCE will handle converting it to any external value on their end. 
 ; Set an Order" node for Billing Replacement
 S ^TMP("RAPXAPI",$J,"PROCEDURE",1,"ORD REFERENCE")=$P(^RAO(75.1,RAO,0),U,7)
 I '$D(^RAO(75.1,RAO,"BA")) Q
 N RA1,RA2,RA3,RACNT,RADXTYP,RAIND
 ;
 ; Create Temp. Array of the Clinical Indicators.
 S RAIND(1)="SC",RAIND(2)="AO",RAIND(3)="IR"
 S RAIND(4)="EC",RAIND(5)="MST",RAIND(6)="HNC",RAIND(7)="CV",RAIND(8)="SHAD"
 ;
 S RACNT=0
 S RA2=^RAO(75.1,RAO,"BA") D DXPL ; Primary Ordering ICD Dx.
 S RA1=0
 F  S RA1=$O(^RAO(75.1,RAO,"BAS",RA1)) Q:+RA1<1  S RA2=^(RA1,0) D DXPL
 Q
 ;
DXPL ; Create "DX/PL" Node.
 S RACNT=RACNT+1
 S RADXTYP=$S(RACNT=1:"P",1:"S")
 S ^TMP("RAPXAPI",$J,"DX/PL",RACNT,"DIAGNOSIS")=$P(RA2,U)
 S ^TMP("RAPXAPI",$J,"DX/PL",RACNT,"PRIMARY")=RADXTYP
 ;F RA3=2:1:8 I $P(RA2,U,RA3)'="" D
 F RA3=2:1:9 D
 .S ^TMP("RAPXAPI",$J,"DX/PL",RACNT,"PL "_RAIND(RA3-1))=$P(RA2,U,RA3)
 Q
 ;
PROCDX(X) ; Called from PROC^RAPCE.
 ; Add Ordering ICD Dx to Procedure for Billing Purposes.
 N I
 F I=1:1:9 Q:'$D(^TMP("RAPXAPI",$J,"DX/PL",I,"DIAGNOSIS"))  D
 .I I=1 S ^TMP("RAPXAPI",$J,"PROCEDURE",X,"DIAGNOSIS")=^("DIAGNOSIS") Q
 .S ^TMP("RAPXAPI",$J,"PROCEDURE",X,"DIAGNOSIS "_I)=^("DIAGNOSIS")
 Q
