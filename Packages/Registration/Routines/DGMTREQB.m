DGMTREQB ;ALB/CAW Send mail bulletin if means test required ; 06/16/2004
 ;;5.3;Registration;**3,608**;Aug 13, 1993
 ;
 ;
EN ;
 I '$D(SDATA) G ENQ
 S (DGMTYPT,DGMSGF)=1,DFN=$P(SDATA,U,2)
 S DGMT=$$LST^DGMTU($P(SDATA,U,2))
 I $P($G(^DGMT(408.31,+DGMT,"BUL")),U)'=DT D MAIL
ENQ K DGMT,DGBUL,DGLN,VA,VAERR Q
MAIL ;
 N XMDUZ,XMSUB,XMTEXT,SDATA1,SDATA2,SDWHAT
 ; use site specified mg and bull is only sent if mg defined
 Q:"^1^4^5^"'[(U_SDAMEVT_U)!($P($G(^TMP("SDAMEVT",$J,"AFTER","DPT")),U,16)'=9)  D ^DGMTR S DGMT=$$LST^DGMTU($P(SDATA,U,2))
 I $P(DGMT,U,4)="R",$P($G(^DG(43,1,"NOT")),U,13) D
 .S SDATA1=$G(^SC($P(SDATA,U,4),"S",$P(SDATA,U,3),1,+SDATA,0)),DFN=$P(SDATA,U,2) D PID^VADPT6
 .I 'SDATA1,SDAMEVT=2 S SDATA2=$G(^TMP("SDAMEVT",$J,"AFTER","DPT")),SDATA1="^^^^^"_$P(SDATA2,U,12)_U_$P(SDATA2,U,14)
 .D XMY^DGMTUTL(+$P(^DG(43,1,"NOT"),U,13),0,1)
 .S XMSUB="Means Test Required ("_$E($P($G(^DPT($P(SDATA,U,2),0)),U),1)_VA("BID")_")",XMTEXT="DGBUL(" D
 ..D SET("Action was taken on the following appointment out and the patient 'REQUIRES' a means test.")
 ..D SET("")
 ..D SET("Date of Birth:  "_$$FTIME^DGMTUTL($P(^DPT(DFN,0),U,3)))
 ..D SET("  Appointment:  "_$$FTIME^DGMTUTL($P(SDATA,U,3)))
 ..D SET("       Action:  "_$P(SDATA("AFTER","STATUS"),U,2))
 ..D SET("       Clinic:  "_$P($G(^SC($P(SDATA,U,4),0)),U))
 ..D SET("   Entered By:  "_$P($G(^VA(200,+$P(SDATA1,U,6),0)),U))
 ..D SET("   Entered On:  "_$$FTIME^DGMTUTL($P(SDATA1,U,7)))
 .D ^XMD
 .S ^DGMT(408.31,+DGMT,"BUL")=DT
MAILQ Q
 ;
SET(X) ; -- set text into array
 S DGLN=$G(DGLN)+1,DGBUL(DGLN,0)=X Q
