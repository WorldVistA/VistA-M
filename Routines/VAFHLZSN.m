VAFHLZSN ;ALB/CM,JLU-PATIENT SENSITIVITY SEGMENT ;12/31/97
 ;;5.3;Registration;**149**;Aug 13, 1993
EN(DFN) ;Returns ZSN segment
 ;
 ;Input: Required Variable
 ;
 ; DFN - IEN in the PATIENT file (#2)
 ;
 ;Output:
 ; if DFN is not passed 
 ;  First piece  - -1
 ;  Second piece - "NO DFN"
 ; if no patient for DFN
 ;  First piece  - -1
 ;  Second piece - "PATIENT NOT IN DATABASE"
 ; if Patient is known
 ;  First piece  - "ZSN"
 ;  Second piece - Field #2 of File #38.1 (Internal value)
 ;  Third piece  - Field #3 of File #38.1 (External value)
 ;  Forth piece  - Field #4 of File #38.1 (HL7 format)
 ;
 ; **Assumes all HL7 variables are defined***
 ;
 N VAFLOCAL,FS,DIC,DR,DA,DIQ,SECURITY,LOCUSER,LOCDATE,RETURN
 S FS=HL("FS")
 I $G(DFN)="" Q "-1^NO DFN"
 I $G(^DPT(DFN,0))="" Q "-1^PATIENT NOT IN DATABASE"
 S DIC=38.1,DR="2;3;4",DA=DFN,DIQ="VAFLOCAL",DIQ(0)="IE"
 D EN^DIQ1
 S SECURITY=$$HLQ^VAFHUTL($G(VAFLOCAL(38.1,DFN,2,"I")))
 S LOCUSER=$$HLQ^VAFHUTL($G(VAFLOCAL(38.1,DFN,3,"I")))
 S LOCDATE=$G(VAFLOCAL(38.1,DFN,4,"I"))
 I LOCDATE]"" S LOCDATE=$$HLDATE^HLFNC(LOCDATE,"TS")
 E  S LOCDATE=$$HLQ^VAFHUTL(LOCDATE)
 S RETURN="ZSN"_FS_SECURITY_FS_LOCUSER_FS_LOCDATE
 Q RETURN
