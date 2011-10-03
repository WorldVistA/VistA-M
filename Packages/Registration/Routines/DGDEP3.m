DGDEP3 ;ALB/CAW,BAJ,ERC - Dependents display ; 11/22/2005
 ;;5.3;Registration;**45,624,653,688**;Aug 13, 1993;Build 29
 ;
SELF(INCPER,NAME,RELATE,ACT,DGMTI,CNT) ; Display information concerning veteran
 ;
 S DGX="",DGX=$$SETSTR^VALM1(CNT,DGX,3,3)
 I $G(DGMTI),INCPER,($P($G(^DGMT(408.22,+INCPER,"MT")),U)=DGMTI) S DGX=$$SETSTR^VALM1("*",DGX,5,1)
 S DGX=$$SETSTR^VALM1(NAME,DGX,9,22)
 S DGX=$$SETSTR^VALM1($P($G(^DG(408.11,RELATE,0)),U),DGX,32,30)
 S DGX=$$SETSTR^VALM1($S($P(ACT,U,2)=1:"*",1:""),DGX,65,1)
 S:RELATE=2 DGX=$$SETSTR^VALM1($S(+$$ADDCHK(INCPER)=1:"*",1:""),DGX,73,1)
 D SET^DGDEP(DGX)
 ;
 ; Display spouse SSN and SSN Verification status DG*5.3*688 BAJ 11/22/2005
 I RELATE=2 D
 . S DGX="",DGX=$$SETSTR^VALM1($P(DGDEP,"^",5),DGX,9,14)
 . S DGX=$$SETSTR^VALM1($P(DGDEP,"^",9),DGX,23,10)
 . ;if a Pseudo SSN need Pseudo SSN Reason - DG*5.3*653, ERC
 . I $P(DGDEP,U,5)["P" D
 . . S DGX=$$SETSTR^VALM1("PSSN Reason: ",DGX,32,15)
 . . S DGX=$$SETSTR^VALM1($P(DGDEP,U,10),DGX,45,30)
 . . ;D SET^DGDEP(DGX)
 . D SET^DGDEP(DGX)
 ;
 Q:RELATE=2
 S INCPER=^DGMT(408.22,INCPER,0)
 S DGX="",DGX=$$SETSTR^VALM1("Married Last Year: ",DGX,18,19)
 S DGX=$$SETSTR^VALM1($S($P(INCPER,U,5):"Yes",$P(INCPER,U,5)="":"Unanswered",1:"No"),DGX,38,10)
 D SET^DGDEP(DGX)
 ;
 Q:'$G(DGMTI)
 I $P(INCPER,U,5)=1 D
 . S DGX="",DGX=$$SETSTR^VALM1("Lived with Spouse: ",DGX,18,19)
 . S DGX=$$SETSTR^VALM1($S($P(INCPER,U,6):"Yes",$P(INCPER,U,6)="":"Unanswered",1:"No"),DGX,38,10)
 . D SET^DGDEP(DGX)
 ;
 I $P(INCPER,U,6)=0 D
 . S DGX="",DGX=$$SETSTR^VALM1("Amount Contributed: ",DGX,17,19)
 . S DGX=$$SETSTR^VALM1($S($P(INCPER,U,7)]"":$P(INCPER,U,7),1:"Unanswered"),DGX,38,10)
 . D SET^DGDEP(DGX)
 Q
 ;
CHILD(INCPER,NAME,RELATE,ACT,DGMTI,DGMTACT,CNT) ; Display information concerning dependents
 ;
 ;** DG*5.3*688 - GTS Get MT Version
 N MTVER
 S:(+$G(DGMTI)>0) MTVER=$P($G(^DGMT(408.31,DGMTI,2)),"^",11)
 I (+$G(DGMTI)'>0) DO
 . N DGINC,DGREL,DGINR,DGDEP
 . D ALL^DGMTU21(DFN,"VSD",DT,"I")
 . S MTVER=$$VER^DGMTUTL3(.DGINC)
 S DGX="",DGX=$$SETSTR^VALM1(CNT,DGX,3,3)
 I $G(DGMTI),INCPER,($P($G(^DGMT(408.22,+INCPER,"MT")),U)=DGMTI) S DGX=$$SETSTR^VALM1("*",DGX,5,1)
 S DGX=$$SETSTR^VALM1(NAME,DGX,9,22)
 S DGX=$$SETSTR^VALM1($P($G(^DG(408.11,RELATE,0)),U),DGX,32,30)
 S DGX=$$SETSTR^VALM1($S($P(ACT,U,2)=1:"*",1:""),DGX,65,1)
 S DGX=$$SETSTR^VALM1($S(+$$ADDCHK(INCPER)=1:"*",1:""),DGX,73,1)
 D SET^DGDEP(DGX)
 ;
 ;display dependent SSN and SSN Verification status DG*5.3*688 BAJ 11/22/2005
 S DGX="",DGX=$$SETSTR^VALM1($P(DGDEP,"^",5),DGX,9,14)
 S DGX=$$SETSTR^VALM1($P(DGDEP,"^",9),DGX,23,10)
 I $P(DGDEP,U,5)["P" D
 . S DGX=$$SETSTR^VALM1("PSSN Reason: ",DGX,32,15)
 . S DGX=$$SETSTR^VALM1($P(DGDEP,U,10),DGX,45,30)
 D SET^DGDEP(DGX)
 ;
 Q:'$G(DGMTI)!('$P($G(^DG(408.11,RELATE,0)),U,4))
 S INCPER=^DGMT(408.22,INCPER,0)
 S DGX="",DGX=$$SETSTR^VALM1("Incapable of Self-support: ",DGX,10,27)
 S DGX=$$SETSTR^VALM1($S($P(INCPER,U,9):"Yes",$P(INCPER,U,9)="":"Unanswered",1:"No"),DGX,38,10)
 D SET^DGDEP(DGX)
 ;
 ;* DG*5.3*624
 S DGX="",DGX=$$SETSTR^VALM1("Child 18 to 23. Attended School: ",DGX,4,33)
 S DGX=$$SETSTR^VALM1($S($P(INCPER,U,18):"Yes",$P(INCPER,U,18)="":"Unanswered",1:"No"),DGX,38,10)
 D SET^DGDEP(DGX)
 ;
 S DGX="",DGX=$$SETSTR^VALM1("Child lived with you: ",DGX,15,22)
 S DGX=$$SETSTR^VALM1($S($P(INCPER,U,6):"Yes",$P(INCPER,U,6)="":"Unanswered",1:"No"),DGX,38,10)
 D SET^DGDEP(DGX)
 ;
 S DGX="",DGX=$$SETSTR^VALM1("Child Support: ",DGX,22,15)
 S DGX=$$SETSTR^VALM1($S($P(INCPER,U,6)=1:"N/A",$P(INCPER,U,10)=1:"Yes",$P(INCPER,U,10)="":"Unanswered",1:"No"),DGX,38,10)
 D SET^DGDEP(DGX)
 ;
 ;* DG*5.3*624
 S DGX="",DGX=$$SETSTR^VALM1("Amount contributed: ",DGX,17,20)
 S DGX=$$SETSTR^VALM1($S($P(INCPER,U,10)'=1:"N/A",($P(INCPER,U,19)'="0")&($P(INCPER,U,19)'=""):$P(INCPER,U,19),$P(INCPER,U,19)="":"Unanswered",1:"0"),DGX,38,10)
 D SET^DGDEP(DGX)
 ;
 ;** DG*5.3*688 - GTS Chk MT Version and output correct data
 S DGX=""
 S:(+MTVER<1) DGX=$$SETSTR^VALM1("Child Has Income: ",DGX,19,18)
 S:(+MTVER=1) DGX=$$SETSTR^VALM1("Child Has Income/Net Worth: ",DGX,9,28)
 S DGX=$$SETSTR^VALM1($S($P(INCPER,U,11)=1:"Yes",$P(INCPER,U,11)="":"Unanswered",1:"No"),DGX,38,10)
 D SET^DGDEP(DGX)
 ;
 ;** DG*5.3*688 - GTS Chk MT Version and output correct data
 S DGX=""
 S:(+MTVER<1) DGX=$$SETSTR^VALM1("Income Available: ",DGX,19,18)
 S:(+MTVER=1) DGX=$$SETSTR^VALM1("Income/Net Worth Available: ",DGX,9,28)
 S DGX=$$SETSTR^VALM1($S($P(INCPER,U,11)=0:"N/A",$P(INCPER,U,12)=1:"Yes",$P(INCPER,U,12)="":"Unanswered",1:"No"),DGX,38,10)
 D SET^DGDEP(DGX)
CHILDQ Q
 ;
ADDCHK(INCPER) ; Indicates existence of any dependent address
 ; Input:
 ;      INCPER - Pointer to dep. entry in Income Relation file (408.22)
 ;
 ; Output: 
 ;   both address and phone^address^phone
 ;      KEY:
 ;        0 - No data exists for the dependent in 408.13
 ;        1 - Data exists for the dependent in 408.13
 ;
 ;    1^1^1 - Address and Phone data exist for dependent
 ;    0^1^0 - Address only exists for dependent
 ;    0^0^1 - Phone only exists for dependent
 ;    0^0^0 - Neither Phone nor Address data exists for dependent
 ;
 N ADDCKVAL,INDAIIEN,PRIEN,IPIEN
 S ADDCKVAL="0^0^0"
 S INDAIIEN=$P($G(^DGMT(408.22,INCPER,0)),"^",2)
 S PRIEN=$P($G(^DGMT(408.21,INDAIIEN,0)),"^",2)
 S IPIEN=$P($G(^DGPR(408.12,PRIEN,0)),"^",3)
 I IPIEN["DGPR(408.13" DO
 . S IPIEN=$P(IPIEN,";",1)
 . I $P($G(^DGPR(408.13,IPIEN,1)),"^",2)]"" S $P(ADDCKVAL,U,1,2)="1^1"
 . I $P($G(^DGPR(408.13,IPIEN,1)),"^",3)]"" S $P(ADDCKVAL,U,1,2)="1^1"
 . I $P($G(^DGPR(408.13,IPIEN,1)),"^",4)]"" S $P(ADDCKVAL,U,1,2)="1^1"
 . I $P($G(^DGPR(408.13,IPIEN,1)),"^",5)]"" S $P(ADDCKVAL,U,1,2)="1^1"
 . I $P($G(^DGPR(408.13,IPIEN,1)),"^",6)]"" S $P(ADDCKVAL,U,1,2)="1^1"
 . I $P($G(^DGPR(408.13,IPIEN,1)),"^",7)]"" S $P(ADDCKVAL,U,1,2)="1^1"
 . I $P($G(^DGPR(408.13,IPIEN,1)),"^",8)]"" S $P(ADDCKVAL,U,3)="1"
 Q ADDCKVAL
