RABUL3 ;HISC/FPT,GJC-'RAD/NUC MED REPORT DELETION' Bulletin ;3/21/95  13:56
 ;;5.0;Radiology/Nuclear Medicine;**56**;Mar 16, 1998;Build 3
 ;Supported IA #10035 ^DPT(
 ; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ; The variables DA must be defined.  The value of DA must be greater
 ; than 0.  These conditions must exist for the RAD/NUC MED REPORT
 ; DELETION bulletin to execute.
 ; Called from: 
 ;   ^DD(74,.01,1,2,0-"DT") xref nodes if deletion via Fileman
 ;   routine RARTE7, if deletion via Rad pkg (RA*5*56)
 ; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ;                     ***** Variable List *****
 ; 'DIFQ'     -> Variable used to check if we are installing the
 ;               Radiology Package.  If we are, do not fire off
 ;               bulletins.
 ; 'RADFN'    -> IEN of the patient in the PATIENT file (2)
 ; 'RAEXAM'   -> IEN of a record in the Examinations multiple
 ;               of the Radiology/Nuclear Medicine Patient file. (70)
 ; 'RAEXAM(0)'-> Zero node of a record in the Examinations multiple
 ;               of the Radiology/Nuclear Medicine Patient file. (70)
 ; 'RARXAM(0)'-> Zero node of a record in the Registered Exam multiple
 ;               of the Radiology/Nuclear Medicine Patient file. (70)
 ; 'RAFN1'    -> internal format of a FM date/time data element
 ;               { internal format pointer value }
 ; 'RAFN2'    -> FM data definition for RAFN1, used in XTERNAL^RAUTL5
 ; 'A'        -> Zero node of the RADIOLOGY/NUCLEAR MEDICINE REPORTS
 ;               file (74) { node: ^RARPT(DA,0) }
 ;
 ; Format: Data to be fired;local var name;XMB array representation
 ; Patient ; RANAME ; XMB(1)     <---> Exam Date ; RAXDT ; XMB(4)
 ; Patient SSN ; RASSN ; XMB(2)  <---> Desired Date ; RADDT ; XMB(5)
 ; Case Number ; RACASE ; XMB(3) <---> Report Status ; RASTAT ; XMB(6)
 ; Imaging Loc ; RAILOC ; XMB(7)
 ;
EN1 Q:$D(DIFQ)!(+$G(DA)'>0)  ; Quit if installing software or invalid IEN
 N A,RACASE,RACN,RADDT,RADTI,RADFN,RAEXAM,RAFN1,RAFN2,RAILOC,RANAME
 N RARXAM,RASSN,RASTAT,RAXDT,X,Y
 S A=$G(^RARPT(DA,0))
 S Y=DA D RASET^RAUTL2 ; Derive case/exam data from file 70
 S RADFN(0)=RADFN
 S (RADFN,RANAME)=+$P(A,U,2)
 S RANAME=$S($D(^DPT(RANAME,0)):$P(^(0),U),1:"Unknown")
 S RASSN=$$SSN^RAUTL() S RADFN=RADFN(0)
 S RACASE=$S($P(A,U)]"":$P(A,U),1:"Unknown")
 S RAFN1=$P(A,U,3),RAFN2=$P($G(^DD(74,3,0)),U,2)
 S RAXDT=$$XTERNAL^RAUTL5(RAFN1,RAFN2)
 S RAXDT=$S(RAXDT]"":RAXDT,1:"Unknown")
 S RARXAM(0)=$G(^RADPT(+$G(RADFN),"DT",+$G(RADTI),0))
 S RAEXAM=$O(^RADPT(+$G(RADFN),"DT",+$G(RADTI),"P","B",+$G(RACN),0))
 S RAEXAM(0)=$G(^RADPT(+$G(RADFN),"DT",+$G(RADTI),"P",+$G(RAEXAM),0))
 S RAFN1=$P(RAEXAM(0),U,21),RAFN2=$P($G(^DD(70.03,21,0)),U,2)
 S RADDT=$$XTERNAL^RAUTL5(RAFN1,RAFN2)
 S RADDT=$S(RADDT]"":RADDT,1:"Unknown")
 S RAFN1=$S($D(RACLOAK)#2:RACLOAK,1:$P(A,U,5)),RAFN2=$P($G(^DD(74,5,0)),U,2)
 S RASTAT=$$XTERNAL^RAUTL5(RAFN1,RAFN2)
 S RASTAT=$S(RASTAT]"":RASTAT,1:"Unknown")
 S RAFN1=$P(RARXAM(0),U,4),RAFN2=$P($G(^DD(70.02,4,0)),U,2)
 S RAILOC=$$XTERNAL^RAUTL5(RAFN1,RAFN2)
 S RAILOC=$S(RAILOC]"":RAILOC,1:"Unknown")
 S XMB(1)=RANAME,XMB(2)=RASSN,XMB(3)=RACASE
 S XMB(4)=RAXDT,XMB(5)=RADDT,XMB(6)=RASTAT
 S XMB(7)=RAILOC,XMB="RAD/NUC MED REPORT DELETION"
 D ^XMB:$D(^XMB(3.6,"B",XMB))
 K XMB,XMB0,XMC0,XMDT,XMM,XMMG
 Q
CLOAK ;called from RARTE7 right after report is deleted but cloaked
 Q:'$D(RAIEN)#2  ;report ien
 Q:'$D(RAIEN2)#2  ;activity log sub ien
 S DA=RAIEN
 S RACLOAK=$P(^RARPT(DA,"L",RAIEN2,0),U,4) ;previous rpt status
 G EN1
