SPNLRF ;ISC-SF/GB-SCD PATIENT HEALTH SUMMARY ;9/25/95  11:13
 ;;2.0;Spinal Cord Dysfunction;**20**;01/02/1997
ASK(QLIST,ABORT) ; Report-specific questions
 N DIC,Y,DTOUT,DUOUT
 ; Which patient?
 S DIC="^SPNL(154,"
 ;S DIC("S")="I $P(^(0),U,3)=1" ; Select only from active patients
 S DIC(0)="AEQM"
 S DIC("A")="Select PATIENT: "
 ;S DIC("?")="Select the patient for whom you want the Health Summary"
 D ^DIC I $D(DTOUT)!($D(DUOUT))!(Y<0) S ABORT=1 Q
 S QLIST("DFN")=+Y ; IEN's are DINUM'd to the ^DPT
 K DIC
 ; Which Health Summary Type?
 I $$VFILE^DILFD(142)'>0 D  Q
 . W !!?5,"*** HEALTH SUMMARY TYPE file (#142) not found ***",$C(7)
 . S ABORT=1
 . Q
 S DIC="^GMT(142,"
 S DIC(0)="AEQM"
 S DIC("A")="Select Health Summary Type Name:  "
 ;S DIC("?")="Choose one, if you aren't sure, experiment!"
 D ^DIC I $D(DTOUT)!($D(DUOUT))!(Y<0) S ABORT=1 Q
 S QLIST("TYPE")=+Y
 Q
GATHER(DFN,FDATE,TDATE,HIUSERS,QLIST) ; No need to gather
 Q
PRINT(QLIST) ;
 D ENX^GMTSDVR(QLIST("DFN"),QLIST("TYPE"))
 Q
