SCMCPM ;ALB/REW - Inpatient Activity MailMan Message ; 7 Mar 1996
 ;;5.3;Scheduling;**41,87,100,130**;AUG 13, 1993
 ;
MAIL ;do Inpatient MailMan Message
 N SCPMXM,SCPTNM,SCPMDT,SCPCPR,SCPCTM,SCPCAT,SCTRANS,XMDUZ,SCLNCNT,XMY,XMSUB,XMTEXT,VA,VAERR,SCTRANNM,XMZ,Y,SCORIGA,SCNODE,SCPHYND
 S SCORIGA=$G(^DGPM(+$P(DGPMA,U,14),0))
 S SCPMDT("BEGIN")=+DGPMA
 S SCPMDT("END")=DT
 S SCPMDT("INCL")=0
 ;set xmy array for practitioners in positions receiving inpt notices
 G:'$$PCMMXMY^SCAPMC25(2,DFN,,"SCPMDT",0) END
 S SCTRANS=+$P(DGPMA,U,2),SCTRANNM=$P($G(^DG(405.3,SCTRANS,0)),U,1)
 G:("^1^2^3^")'[(U_SCTRANS_U) END  ;must be admit,transfer or discharge
 D:'$G(DGQUIET) EN^DDIOL("Sending INPATIENT "_SCTRANNM_" Message")
 D PID^VADPT6
 S SCPTNM=$P(^DPT(DFN,0),U,1)
 S XMSUB="INPATIENT "_SCTRANNM_" for Patient ("_$E(SCPTNM,1)_VA("BID")_")",XMTEXT="SCPMXM(",SCLNCNT=0
 D SETLN("Patient:                 "_SCPTNM_"("_VA("PID")_")")
 D SETLN("Transaction:             "_SCTRANNM)
 S Y=+DGPMA X ^DD("DD") D SETLN("Date/Time:               "_Y)
 ;if movement is not original movement
 IF DGPMA'=SCORIGA D
 .S Y=+SCORIGA X ^DD("DD") D SETLN("Admission Date/Time:     "_Y)
 D SETLN("Type of Movement:        "_$P($G(^DG(405.1,+$P(DGPMA,U,4),0)),U,1))
 S SCNODE=$S(SCTRANS=3:DGPMP,1:DGPMA)
 S VAIP("E")=$S($G(DGPMDA):+DGPMDA,1:$P(SCORIGA,U,14)) D IN5^VADPT
 S SCPHYND=$S(SCTRANS=3:$G(VAIP(17,5)),1:$G(VAIP(14,5)))
 D SETLN(" ")
 D SETLN("Ward Location:           "_$S(SCTRANS=3:$P($G(VAIP(17,4)),U,2),1:$P($G(VAIP(14,4)),U,2)))
 D SETLN("Room-Bed:                "_$S($L($P($G(^DPT(DFN,.101)),U,1)):$P(^(.101),U,1),1:$P($G(^DG(405.4,+$P(SCNODE,U,7),0)),U,1)))
 D SETLN("Inpatient Provider:      "_$P(SCPHYND,U,2))
 D SETLN("Admitting DX:            "_$P(SCORIGA,U,10))
 S SCLNCNT=$$PCMAIL^SCMCMM(DFN,"SCPMXM",DT) ;standard pc info into mail
 S XMDUZ=$G(DUZ,.5)
 S XMY(XMDUZ)=""
 D ^XMD
 D KVAR^VADPT
END ;
 Q
 ;
SETLN(TEXT) ;
 ; increments SCLNCNT, adds text to scpmxm(sclncnt)
 S SCLNCNT=SCLNCNT+1
 S SCPMXM(SCLNCNT)=TEXT
 Q
