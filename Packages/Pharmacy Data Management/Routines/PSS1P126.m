PSS1P126 ;SMT - PSS*1*126 POST INSTALL ; 8/21/07 10:48am
 ;;1.0; PHARMACY DATA MANAGEMENT;**126**; 4/26/07;Build 11
 ;
 ;This routine will send mail to anyone holding the "PSNMGR" key
 ; as well as the installing user, a list of drugs whos DEA code
 ; is subject to change as the result of PSS*1*126 and PSO*7*206
 ; DEA code changes.
 ;
EN N XMDUZ,XMSUB,XMTEXT,DIFROM,XMY,X,CNT,OP,SPC,Y,VAR
 S X=0,CNT=8
 F  S X=$O(^PSDRUG(X)) Q:'X  I $G(^PSDRUG(X,0))]"",($P(^PSDRUG(X,0),"^",3)["3A")!($P(^PSDRUG(X,0),"^",3)["4A")!($P(^PSDRUG(X,0),"^",3)["5A") D  S CNT=CNT+1
 .S SPC(0)=X,SPC(10)=$P(^PSDRUG(X,0),"^")
 .S (Y,VAR)="" F  S Y=$O(SPC(Y)) Q:Y=""  F  Q:$L($G(VAR))>Y  S:$L($G(VAR))<Y VAR=VAR_" " S:$L(VAR)=Y VAR=VAR_SPC(Y)
 .S OP(CNT)=VAR
 S OP(1)="This is an alert containing drugs with DEA schedules that are going to change."
 S OP(2)="The following drugs should be reviewed by pharmacy and verified "
 S OP(3)="that they contain the correct scheduling after the changes. Please "
 S OP(4)="see the patch description for a corresponding table and decide what "
 S OP(5)="the new codes should be."
 S OP(6)="There are a total of "_(CNT-8)_" drug(s) that have changed."
 S OP(7)="IEN       NAME"
 S XMDUZ="POSTMASTER",XMSUB="DEA CODES SUBJECT TO CHANGE PLEASE REVIEW",XMTEXT="OP("
 S XMY(DUZ)=""
 S X="" F  S X=$O(^XUSEC("PSNMGR",X)) Q:'X  S XMY(X)=""
 D ^XMD
 Q
