IVMCMB ;ALB/SEK,BRM,TDM - SEND INCOME TEST TRANSMISSION BULLETIN ; 4/2/09 1:19pm
 ;;2.0;INCOME VERIFICATION MATCH;**17,49,140**;21-OCT-94;Build 2
 ;
 ;  Input array required:
 ;    ^TMP($J,"IVMBULL"  --  contains lists of tests which were uploaded
 ;     dfn^type of test^dt of test^category^action
 ;
BULL ; Send mail message notifying site of uploaded income tests.
 ;
 G BULLQ        ; This bulletin has been disabled.  IVM*2*140
 ;
 K IVMTEXT
 I '$D(^TMP($J,"IVMBULL")) G BULLQ
 S XMSUB="HEC INCOME TEST UPLOAD"
 S IVMTEXT(1)="Income tests were uploaded from the Health Eligibility Center"
 S IVMTEXT(2)="for the following patients:"
 S IVMTEXT(3)=" "
 S IVMTEXT(4)="    Name         PID          Type        TestDate   Old->New  Action"
 S IVMTEXT(5)="                                                       Code"
 S IVMBCTR=$G(^TMP($J,"IVMBULL",0))
 F IVMBDA=1:1:IVMBCTR D
 .S IVMBULLM=$G(^TMP($J,"IVMBULL",IVMBDA)) Q:'IVMBULLM
 .S IVMPAT=$$PT^IVMUFNC4($P(IVMBULLM,"^"))
 .S $E(IVMTEXT(IVMBDA+5),1,30)=$E($P(IVMPAT,"^"),1,18)_" "_$P(IVMPAT,"^",2)
 .S $E(IVMTEXT(IVMBDA+5),31,41)=$S($P(IVMBULLM,"^",2)=1:"Means Test",$P(IVMBULLM,"^",2)=2:"Copay Test",$P(IVMBULLM,"^",2)=4:"LTC Test",1:"")
 .S Y=$P(IVMBULLM,"^",3) X ^DD("DD") ;test date
 .S $E(IVMTEXT(IVMBDA+5),43,53)=Y
 .S $E(IVMTEXT(IVMBDA+5),56,56)=$P(IVMBULLM,"^",4) ;status before
 .S $E(IVMTEXT(IVMBDA+5),57,58)="->"
 .S $E(IVMTEXT(IVMBDA+5),59)=$P(IVMBULLM,"^",5) ;status after
 .S $E(IVMTEXT(IVMBDA+5),64,78)=$P(IVMBULLM,"^",6) ;action
 ;
 D MAIL^IVMUFNC("DGMT MT/CT UPLOAD ALERTS")
BULLQ K IVMBCTR,IVMBDA,IVMBULLM,^TMP($J,"IVMBULL"),IVMPAT,Y
 Q
 ;
BULL1(DFN,WDATE,SITE) ; 
 ;Send message notifying site of hardship determination
 ;
 N IVMTEXT,IVMPAT
 S IVMPAT=$$PT^IVMUFNC4(DFN)
 S XMSUB="HEC NOTIFICATION OF HARDSHIP"
 S IVMTEXT(1)="A hardship determination was uploaded from the Health Eligibility Center"
 S IVMTEXT(2)="for the following patient:"
 S IVMTEXT(3)=" "
 S IVMTEXT(4)="                  Name: "_$P(IVMPAT,"^")
 S IVMTEXT(5)="                   PID: "_$P(IVMPAT,"^",2)
 S IVMTEXT(6)="        Effective Date: "_$S(WDATE:$$FMTE^XLFDT(WDATE),1:"UNKNOWN")
 S IVMTEXT(7)="Site Granting Hardship: "_$S($L(SITE):SITE,1:"UNKNOWN")
 ;
 D MAIL^IVMUFNC("DGMT MT/CT UPLOAD ALERTS")
 Q
 ;
BULL2(DFN,WDATE,SITE) ; 
 ;Send message notifying site of deletion of hardship determination
 ;
 N IVMTEXT,IVMPAT
 S IVMPAT=$$PT^IVMUFNC4(DFN)
 S XMSUB="HEC NOTIFICATION OF HARDSHIP"
 S IVMTEXT(1)="Notification has been received from the Health Eligibility Center "
 S IVMTEXT(2)="that the hardship determination was deleted for the following patient:"
 S IVMTEXT(3)=" "
 S IVMTEXT(4)="                             Name: "_$P(IVMPAT,"^")
 S IVMTEXT(5)="                              PID: "_$P(IVMPAT,"^",2)
 S IVMTEXT(6)=" Effective Date Prior to Deletion: "_$S(WDATE:$$FMTE^XLFDT(WDATE),1:"UNKNOWN")
 S IVMTEXT(7)="Site Originally Granting Hardship: "_$S($L(SITE):SITE,1:"UNKNOWN")
 ;
 D MAIL^IVMUFNC("DGMT MT/CT UPLOAD ALERTS")
 Q
 ;
BULL3(DFN) ; 
 ;Send message notifying site to discontinue net-worth adjudication
 ;
 Q:('$G(DFN))
 ;
 N IVMTEXT,IVMPAT
 S IVMPAT=$$PT^IVMUFNC4(DFN)
 S XMSUB="HEC Authority Over Networth-Adjudication"
 S IVMTEXT(1)="Please discontinue development of net-worth for the following patient:"
 S IVMTEXT(2)=" "
 S IVMTEXT(3)=" "
 S IVMTEXT(4)="                  Name: "_$P(IVMPAT,"^")
 S IVMTEXT(5)="                   PID: "_$P(IVMPAT,"^",2)
 ;
 D MAIL^IVMUFNC("DGMT MT/CT UPLOAD ALERTS")
 Q
 ;
ADD(DFN,TYPETEST,ACTION,TESTDATE,STATUS1,STATUS2) ;
 ;Adds to the notification list
 ;
 N COUNT
 S COUNT=$G(^TMP($J,"IVMBULL",0))+1
 S ^TMP($J,"IVMBULL",COUNT)=DFN_U_$G(TYPETEST)_U_$G(TESTDATE)_U_$G(STATUS1)_U_$G(STATUS2)_U_$G(ACTION)
 S ^TMP($J,"IVMBULL",0)=COUNT
 Q
