EASECDP3 ;ALB/LBD - Dependents display ; 20 AUG 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5,40**;Mar 15, 2001
 ;NOTE: This routine was modified from DGDEP3 for LTC co-pay
 ;
SELF(INCPER,NAME,RELATE,ACT,DGMTI,CNT) ; Display information concerning veteran
 ;
 S DGX="",DGX=$$SETSTR^VALM1(CNT,DGX,3,3)
 I $G(DGMTI),INCPER,($P($G(^DGMT(408.22,+INCPER,"MT")),U)=DGMTI) S DGX=$$SETSTR^VALM1("*",DGX,5,1)
 S DGX=$$SETSTR^VALM1(NAME,DGX,9,22)
 S DGX=$$SETSTR^VALM1($P($G(^DG(408.11,RELATE,0)),U),DGX,32,30)
 S DGX=$$SETSTR^VALM1($S($P(ACT,U,2)=1:"*",1:""),DGX,65,1)
 D SET^EASECDEP(DGX)
 ;
 Q:RELATE=2
 S INCPER=^DGMT(408.22,INCPER,0)
 S DGX="",DGX=$$SETSTR^VALM1("Married This Year: ",DGX,18,19)
 S DGX=$$SETSTR^VALM1($S($P(INCPER,U,14):"Yes",$P(INCPER,U,14)="":"Unanswered",1:"No"),DGX,38,10)
 D SET^EASECDEP(DGX)
 ;
 Q:'$G(DGMTI)
 I $P(INCPER,U,14)=1 D
 . ;If this is the new 10-10EC format display Legally Separated field
 . ;Added for LTC Phase IV (EAS*1*40)
 .I $G(DGFORM) D  Q:$P(INCPER,U,17)=1
 ..S DGX="",DGX=$$SETSTR^VALM1("Legally Separated: ",DGX,18,19)
 ..S DGX=$$SETSTR^VALM1($S($P(INCPER,U,17):"Yes",$P(INCPER,U,17)="":"Unanswered",1:"No"),DGX,38,10)
 ..D SET^EASECDEP(DGX)
 .S DGX="",DGX=$$SETSTR^VALM1("Spouse Residing in Community: ",DGX,7,30)
 .S DGX=$$SETSTR^VALM1($S($P(INCPER,U,16):"Yes",$P(INCPER,U,16)="":"Unanswered",1:"No"),DGX,38,10)
 .D SET^EASECDEP(DGX)
 .Q:$P(INCPER,U,16)=0!($G(DGFORM))
 .S DGX="",DGX=$$SETSTR^VALM1("Living with Spouse: ",DGX,17,20)
 .S DGX=$$SETSTR^VALM1($S($P(INCPER,U,15):"Yes",$P(INCPER,U,15)="":"Unanswered",1:"No"),DGX,38,10)
 .D SET^EASECDEP(DGX)
 ;
 Q
 ;
CHILD(INCPER,NAME,RELATE,ACT,DGMTI,DGMTACT,CNT) ; Display information concerning dependents
 ;
 S DGX="",DGX=$$SETSTR^VALM1(CNT,DGX,3,3)
 I $G(DGMTI),INCPER,($P($G(^DGMT(408.22,+INCPER,"MT")),U)=DGMTI) S DGX=$$SETSTR^VALM1("*",DGX,5,1)
 S DGX=$$SETSTR^VALM1(NAME,DGX,9,22)
 S DGX=$$SETSTR^VALM1($P($G(^DG(408.11,RELATE,0)),U),DGX,32,30)
 S DGX=$$SETSTR^VALM1($S($P(ACT,U,2)=1:"*",1:""),DGX,65,1)
 D SET^EASECDEP(DGX)
 ;
 Q:'$G(DGMTI)!('$P($G(^DG(408.11,RELATE,0)),U,4))
 S INCPER=^DGMT(408.22,INCPER,0)
 S DGX="",DGX=$$SETSTR^VALM1("Dependent Residing in Community: ",DGX,4,33)
 S DGX=$$SETSTR^VALM1($S($P(INCPER,U,16):"Yes",$P(INCPER,U,16)="":"Unanswered",1:"No"),DGX,38,10)
 D SET^EASECDEP(DGX)
 G:$P(INCPER,U,16)=0 CHILDQ
 S DGX="",DGX=$$SETSTR^VALM1("Dependent Living with You: ",DGX,10,27)
 S DGX=$$SETSTR^VALM1($S($P(INCPER,U,15):"Yes",$P(INCPER,U,15)="":"Unanswered",1:"No"),DGX,38,10)
 D SET^EASECDEP(DGX)
CHILDQ Q
