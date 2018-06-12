RABUL ;HISC/FPT,GJC AISC/DMK-Generate 'RAD/NUC MED REQUEST CANCELLED' or 'RAD/NUC MED REQUEST HELD' Bulletin ;16 Jun 2017 2:27 PM
 ;;5.0;Radiology/Nuclear Medicine;**2,15,75,135**;Mar 16, 1998;Build 7
 ; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ; The variables DA and RAOSTS must be defined.
 ; The variable DA must be greater than 0, and RAOSTS must
 ; equal 1 (cancelled) or 3 (held) for the RAD/NUC MED REQUEST CANCELLED
 ; or the  RAD/NUC MED REQUEST HELD bulletin to execute.
 ; Called from: ^DD(75.1,5,0) fifth piece
 ; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ;                     ***** Variable List *****
 ; 'RADFN' -> IEN of the patient in the PATIENT file (2)
 ; 'RAFN1' -> internal format of a FM date/time data element
 ; 'RAFN2' -> FM data definition for RAFN1, used in XTERNAL^RAUTL5
 ; 'Z'     -> Zero node of the RADIOLOGY/NUCLEAR MEDICINE ORDERS
 ;            file (75.1)
 ; Format: Data to be fired;local var name;XMB array representation
 ; Patient ; RANAME ; XMB(1)      <---> Req. Physician ; RARPHY ; XMB(5)
 ; Patient SSN ; RASSN ; XMB(2)   <---> Req. Location ; RARLOC ; XMB(6)
 ; Procedure ; RAPNAM ; XMB(3)    <---> Reason ; RARCR ; XMB(7)
 ; Date Desired ; RADTDS ; XMB(4) <---> Current User ; RAUSER ; XMB(8)
 ;
EN(RAX) ; Pass in the request status (RAX)
 ; also called during request status edit.
 Q:+$G(DA)'>0  Q:$G(RA135TIME)=1  ;RA5P135
 Q:+$G(RAOSTS)'=1&(+$G(RAOSTS)'=3)
 N RADFN,RADTDS,RAFN1,RAFN2,RASSN,RAUSER,RAXMB,Z
 S RAXMB="RAD/NUC MED REQUEST",Z=$G(^RAO(75.1,DA,0))
 S (RADFN,RANAME)=+$P(Z,U)
 S RANAME=$S($D(^DPT(RANAME,0)):$P(^(0),U),1:"Unknown")
 S RASSN=$$SSN^RAUTL(),RAPNAM=+$P(Z,U,2)
 S RAPNAM=$S($D(^RAMIS(71,RAPNAM,0)):$P(^(0),U),1:"Unknown")
 S RARLOC=+$P(Z,U,22)
 S RARLOC=$S($D(^SC(RARLOC,0)):$P(^(0),U),1:"Unknown")
 S RAFN1=$P(Z,U,21),RAFN2=$P($G(^DD(75.1,21,0)),U,2)
 S RADTDS=$$XTERNAL^RAUTL5(RAFN1,RAFN2)
 S:RADTDS']"" RADTDS="Unknown" S RARPHY=+$P(Z,U,14)
 S RARPHY=$S($D(^VA(200,RARPHY,0)):$P(^(0),U),1:"Unknown")
 S RARCR=+$P(Z,U,10)
 S RARCR=$S($D(^RA(75.2,RARCR,0)):$P(^(0),U),1:"Unknown")
 S:RARCR="Unknown" RARCR=$S($P(Z,U,27)]"":$P(Z,U,27),1:"Unknown")
 S RAUSER=$S($D(^VA(200,DUZ,0)):$P(^(0),U),1:"Unknown")
 ; --- P75 define the REASON FOR STUDY ---
 S RASTYREA=$P($G(^RAO(75.1,DA,.1)),U)
 S:RASTYREA="" RASTYREA="Unknown" ;req'd if missing error
 ;
 S XMB(1)=RANAME,XMB(2)=RASSN,XMB(3)=RAPNAM,XMB(4)=RASTYREA,XMB(5)=RADTDS
 S XMB(6)=RARPHY,XMB(7)=RARLOC,XMB(8)=RARCR,XMB(9)=RAUSER
 S XMB=RAXMB_$S(RAX=1:" CANCELLED",1:" HELD")
 D ^XMB:$D(^XMB(3.6,"B",XMB))
 K RANAME,RAPNAM,RARLOC,RARPHY,RARCR,RASTYREA,XMB,XMB0,XMC0,XMDT,XMM,XMMG
 Q
OE3(DA) ; Trigger the Rad/Nuc Med Request Cancelled bulletin when
 ; the order is discontinued through CPRS (frontdoor).
 ; Input: DA-ien of the Rad/Nuc Med order record
 S RAOSTS=$P($G(^RAO(75.1,DA,0)),"^",5)
 I RAOSTS'=1 K RAOSTS Q  ; status must be discontinued
 D EN(RAOSTS) K RAOSTS
 Q
