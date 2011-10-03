SPNHL2 ;WDE/SAN-DIEGO;Build the hl7 segment for file data 154.1;DEC 03,2009
 ;;2.0;Spinal Cord Dysfunction;**10,11,12,14,19,20,26**;01/02/97;Build 7
EN(SPNFD0) ;
 ;
 ;Reference to API $$KSP^XUPARAM supported by IA# 2541
 ;
 ;11/04/09 - JAS - This was originally a SPN 2.0 routine that needed updated
 ;           to fix a long-existing issue. Remedy #354716      
 ;
 ;this routine is called from spnhl71 spnhl71 is called from the
 ;edit screen
 ; spndd is the field name located in the dd
 ; x is the field number from file 154.1
 ;  this routine is used to build the ORU segment in chapter 7 of
 ;  hl7 manual 2.3  (page 7-14)
 ;-------------------------------------------------------------------
 ;build the msh and pid segment
 S SPNFDFN=$$GET1^DIQ(154.1,SPNFD0_",",.01,"I")
 Q:SPNFDFN=""
 ;build the msh & pid segments
 S SPNOBR="OBR",$P(SPNOBR,"|",7)="|"
 S $P(SPNOBR,"|",2)=1
 S $P(SPNOBR,"|",5)="FUNCTIONAL STATUS OBR"
 S SPNRDT=$$GET1^DIQ(154.1,SPNFD0_",",.04,"I")
 Q:SPNRDT=""  S SPNRDT=$$HLDATE^HLFNC(SPNRDT,"TS")
 S $P(SPNOBR,"|",8)=SPNRDT K SPNRDT
 S SPLINE="",SPLINE=$O(SPMSG(SPLINE),-1)+1
 S SPMSG(SPLINE)=SPNOBR S SPLINE=SPLINE+1
 K SPNOBR
 S OBXCNT=1
 ;11/04/09 - JAS - Remedy 354716 (Add unique identifier to Outcomes Message)
 S LOCDA=$$GET1^DIQ(154.1,SPNFD0_",",.023)
 I LOCDA="" S LOCDA=$$KSP^XUPARAM("INST")
 S SPDATA=LOCDA_"_"_SPNFD0 K LOCDA
 S SPNDD="UNIQUE OUTCOMES IDENTIFIER"
 S SPMSG(SPLINE)="OBX|"_OBXCNT_"|ST|"_""_"^"_SPNDD_"||"_SPDATA
 S SPLINE=SPLINE+1,OBXCNT=OBXCNT+1,SPNDD="",SPDATA=""
 ;check for date of death if so get it
 S SPDATA=$$GET1^DIQ(2,SPNFDFN_",",.351,"I") I $G(SPDATA)'="" D
 . S SPDATA=$$HLDATE^HLFNC(SPDATA,"TS")
 . S SPMSG(SPLINE)="OBX|"_OBXCNT_"|TS|"_".351"_"^"_"DATE OF DEATH"_"||"_SPDATA
 . S SPLINE=SPLINE+1,OBXCNT=OBXCNT+1,SPNDD="",SPDATA=""
 ;
 ;build obx from STRING  values
 F X=.05,.06,.07,.08,.09,.1,.11,.12,.13,.14,.15,.16,.161,.17,.18,.181,.19,.191,.2,.21,.22,2.01,2.02,2.03,2.04,2.05,2.06,2.07,2.08,999.03,999.04,999.05,999.06,999.08 D
 . S SPDATA=$$GET1^DIQ(154.1,SPNFD0_",",X) I SPDATA'="" D
 .. S SPNDD=$G(^DD(154.1,X,0)),SPNDD=$P(SPNDD,U,1) S:SPNDD="" SPNDD="ERROR"
 .. S SPMSG(SPLINE)="OBX|"_OBXCNT_"|ST|"_X_"^"_SPNDD_"||"_SPDATA S SPLINE=SPLINE+1,OBXCNT=OBXCNT+1,SPNDD=""
 ;
 ;build the ASIA data values  (new for patch 12)
 F X=.021,.023,.024,7.01,7.02,7.03,7.04,7.05,7.06,7.07,7.08,7.09,7.1,7.11,7.12,7.13,7.14 D
 . S SPDATA=$$GET1^DIQ(154.1,SPNFD0_",",X) I SPDATA'="" D
 .. S SPNDD=$G(^DD(154.1,X,0)),SPNDD=$P(SPNDD,U,1) S:SPNDD="" SPNDD="ERROR"
 .. S SPMSG(SPLINE)="OBX|"_OBXCNT_"|ST|"_X_"^"_SPNDD_"||"_SPDATA S SPLINE=SPLINE+1,OBXCNT=OBXCNT+1,SPNDD=""
 ;
 F X=1001,1002 D
 . S SPDATA=$$GET1^DIQ(154.1,SPNFD0_",",X,"I") I SPDATA'="" D
 .. S SPDATA=$$HLDATE^HLFNC(SPDATA,"TS")
 .. S SPNDD=$G(^DD(154.1,X,0)),SPNDD=$P(SPNDD,U,1) S:SPNDD="" SPNDD="ERROR"
 .. S SPMSG(SPLINE)="OBX|"_OBXCNT_"|TS|"_X_"^"_SPNDD_"||"_SPDATA
 .. S SPLINE=SPLINE+1,OBXCNT=OBXCNT+1,SPNDD="",SPDATA=""
 ; get ms data only the numbers
 F X=3.1,3.2,3.3,3.4,3.5,3.6,3.7,3.8,3.9  D
 . S SPDATA=$$GET1^DIQ(154.1,SPNFD0_",",X,"I") I SPDATA'="" D
 .. S SPDATA=$$GET1^DIQ(154.2,SPDATA_",",.01)
 .. S SPNDD=$G(^DD(154.1,X,0)),SPNDD=$P(SPNDD,U,1) S:SPNDD="" SPNDD="ERROR"
 .. S SPMSG(SPLINE)="OBX|"_OBXCNT_"|NU|"_X_"^"_SPNDD_"||"_SPDATA S SPLINE=SPLINE+1,OBXCNT=OBXCNT+1,SPNDD="",SPDATA=""
 ;
 ;
 F X=4.1,4.2,4.3,4.4,4.5,4.6,6.01,6.02,2.09,2.13 D
 . S SPDATA=$$GET1^DIQ(154.1,SPNFD0_",",X) I SPDATA'="" D
 .. S SPNDD=$G(^DD(154.1,X,0)),SPNDD=$P(SPNDD,U,1) S:SPNDD="" SPNDD="ERROR"
 .. S SPMSG(SPLINE)="OBX|"_OBXCNT_"|NU|"_X_"^"_SPNDD_"||"_SPDATA
 .. S SPLINE=SPLINE+1,OBXCNT=OBXCNT+1,SPNDD=""
 ;
 ;
 F X=5.01,5.02,5.03,5.04,5.05,5.06,5.07,5.08,5.09,5.1,5.11,5.12 D
 . S SPDATA=$$GET1^DIQ(154.1,SPNFD0_",",X,"I") I SPDATA'="" D
 .. S SPDATA=$$GET1^DIQ(154.11,SPDATA_",",.02)
 .. S SPNDD=$G(^DD(154.1,X,0)),SPNDD=$P(SPNDD,U,1) S:SPNDD="" SPNDD="ERROR"
 .. S SPMSG(SPLINE)="OBX|"_OBXCNT_"|ST|"_X_"^"_SPNDD_"||"_SPDATA
 .. S SPLINE=SPLINE+1,OBXCNT=OBXCNT+1,SPNDD=""
 F X=.02,.03,1003 D
 . S SPDATA=$$GET1^DIQ(154.1,SPNFD0_",",X) I SPDATA'="" D
 .. S SPNTBL=$S(X=.02:"^VA501",X=.03:"^VA502",1:"")
 .. S SPNDD=$G(^DD(154.1,X,0)),SPNDD=$P(SPNDD,U,1) S:SPNDD="" SPNDD="ERROR"
 .. S SPMSG(SPLINE)="OBX|"_OBXCNT_"|ST|"_X_"^"_SPNDD_SPNTBL_"||"_SPDATA
 .. S SPLINE=SPLINE+1,OBXCNT=OBXCNT+1,SPNDD="",SPDATA=""
 ;get the clinician its a multiple but we will only record the first one 
 ;
 S SPNTMP=""
 D GETS^DIQ(154.1,SPNFD0_",","1.01*","","SPNTMP")
 S SPNDD=$G(^DD(154.1,1.01,0)),SPNDD=$P(SPNDD,U,1)  ;Get dd field name
 S SPNET=0,SPNET=$O(SPNTMP(154.101,SPNET))
 I SPNET'="" S CL=0,CL=$O(SPNTMP(154.101,SPNET,CL)) S SPNDOC=$G(SPNTMP(154.101,SPNET,CL))
 I SPNET'="" I SPNDOC'="" S SPMSG(SPLINE)="OBX|"_OBXCNT_"|ST|154.101^"_SPNDD_"||"_$G(SPNDOC)
 K SPNET,CL,SPNDOC,SPNDD,SPDATA,SPNTBL
