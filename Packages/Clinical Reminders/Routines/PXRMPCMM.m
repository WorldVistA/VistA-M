PXRMPCMM ;SLC/PKR - Computed findings for PCMM. ;06/22/2011
 ;;2.0;CLINICAL REMINDERS;**18**;Feb 04, 2005;Build 152
 ;References to SCAPMC supported by DBIA #1916.
 ;======================================================
INSTPCTM(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;VA-PCMM PC TEAM
 ;INSTITUTION computed finding. Return the institution and team for
 ;the patient's primary care team as of the evaluation date. 
 N IND,EFFDATE,RESULT
 S EFFDATE=$$NOW^PXRMDATE
 S RESULT=$$INSTPCTM^SCAPMC(DFN,EFFDATE)
 I RESULT=0 S NFOUND=0 Q
 S NFOUND=1,DATE(1)=EFFDATE,TEST(1)=1
 S (DATA(1,"PCMM TEAM"),DATA(1,"VALUE"))=$P(RESULT,U,2)
 S DATA(1,"INSTITUTION")=$P(RESULT,U,4)
 S TEXT(1)="Primary care team is "_DATA(1,"PCMM TEAM")_", Institution is "_DATA(1,"INSTITUTION")_"."
 Q
 ;
 ;======================================================
PRPT(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;VA-PCMM PRACTITIONERS
 ;ASSIGNED TO A PATIENT computed finding. Return a list of
 ;practitioners assigned to a patient.
 N DATES,ERR,INCL,IND,LIST,RESULT
 S INCL=+$P(TEST,U,1)
 S DATES("BEGIN")=BDT,DATES("END")=EDT,DATES("INCL")=INCL
 S RESULT=$$PRPT^SCAPMC(DFN,"DATES","","","","","LIST","ERR")
 S NFOUND=+$G(LIST(0))
 I NFOUND=0 Q
 F IND=1:1:NFOUND D
 . S TEST(IND)=1
 . S DATA(IND,"PROVIDER IEN")=$P(LIST(IND),U,1)
 . S DATA(IND,"PROVIDER")=$P(LIST(IND),U,2)
 . S DATA(IND,"POSITION")=$P(LIST(IND),U,4)
 . S (DATA(IND,"ACTIVATION DATE"),DATE(IND))=$P(LIST(IND),U,9)
 . S TEXT(IND)="Provider: "_DATA(IND,"PROVIDER")_"; Position: "_DATA(IND,"POSITION")
 Q
 ;
 ;======================================================
PTPR(NGET,BDT,EDT,PLIST,PARAM) ;VA-PCMM PATIENTS ASSIGNED TO A PRACTITIONER.
 ;List type computed finding that returns a list of patients
 ;assigned to a list of practitioners within a time period.
 N DATES,ERR,INCL,IND,JND,LIST,NPAT,NPR,PRAC,PRACLIST,RESULT
 K ^TMP($J,PLIST)
 S PRACLIST=$P(PARAM,U,1)
 S INCL=+$P(PARAM,U,2)
 S NPR=$L(PRACLIST,";")
 S DATES("BEGIN")=BDT,DATES("END")=EDT,DATES("INCL")=INCL
 F IND=1:1:NPR D
 . S PRAC=$P(PRACLIST,";",IND)
 . S PRAC=$$FIND1^DIC(200,,"ABX",PRAC,,,"MSG")
 . I PRAC=0 Q
 . K LIST
 . S RESULT=$$PTPR^SCAPMC(PRAC,"DATES","","","LIST","ERR","")
 . S NPAT=+$G(LIST(0)) I NPAT=0 Q
 . F JND=1:1:NPAT D
 .. S DFN=$P(LIST(JND),U,1)
 .. S ^TMP($J,PLIST,DFN,1)=U_$P(LIST(JND),U,4)_U_DFN_U_$P(LIST(JND),U,2)
 .. S ^TMP($J,PLIST,DFN,1,"VALUE")=DFN
 Q
 ;
 ;======================================================
PTTM(NGET,BDT,EDT,PLIST,PARAM) ;VA-PCMM PATIENTS ASSIGNED TO A TEAM
 ;List type computed finding that returns a list of patients
 ;assigned to a team for a time period.
 N DATES,ERR,INCL,LIST,MSG,RESULT,TEAM
 S TEAM=$P(PARAM,U,1)
 S TEAM=$$FIND1^DIC(404.51,,"ABX",TEAM,,,"MSG")
 I TEAM=0 Q
 S INCL=+$P(PARAM,U,2)
 S DATES("BEGIN")=BDT,DATES("END")=EDT,DATES("INCL")=INCL
 ;Return list in ^TMP.
 S RESULT=$$PTTM^SCAPMC(TEAM,"DATES","LIST","MSG")
 K ^TMP($J,PLIST)
 S IND=0
 F  S IND=+$O(LIST(IND)) Q:IND=0  D
 . S DFN=$P(LIST(IND),U,1)
 . S ^TMP($J,PLIST,DFN,1)=U_$P(LIST(IND),U,4)_U_DFN_U_$P(LIST(IND),U,2)
 . S ^TMP($J,PLIST,DFN,1,"VALUE")=DFN
 Q
 ;
