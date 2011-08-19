RABUL2 ;HISC/FPT,GJC-'RAD/NUC MED REPORT UNVERIFIED' Bulletin ;11/10/97  11:01
 ;;5.0;Radiology/Nuclear Medicine;**8**;Mar 16, 1998
 ; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ; The variables DA and RAX must be defined.  RAX must be equal to 'V',
 ; and the value of DA (IEN of the record in file 74) must be greater
 ; than 0.  These conditions must exist for the RAD/NUC MED REPORT
 ; UNVERIFIED bulletin to execute.
 ; Called From: ^DD(74,5,1,1,0-"DT") xref nodes
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
 ; Patient ; RANAME ; XMB(1)    <---> Desired Date ; RADDT ; XMB(5)
 ; Patient SSN ; RASSN ; XMB(2) <---> Report Status ; RASTAT ; XMB(6)
 ; Case Number ; RACASE ; XMB(3)<---> Req. Physician ; RARPHY ; XMB(7) 
 ; Exam Date ; RAXDT ; XMB(4)   <---> Rad. Procedure ; RAPROC ; XMB(8)
 ; Imag. Loc. ; RAILOC ; XMB(9) <---> Pri. Int'g Staff ; RASTF ; XMB(10)
 ; Pri. Int'g Resident ; RARES ; XMB(11)
 ;
 ; Quit if we are installing the software, current report status is
 ; verified, or if we are deleting the report.
 ; 'RADELRPT' is defined in the entry action of the RA DELETERPT option.
 Q:$D(DIFQ)!($D(RADELRPT))
 N RAX S RAX=X
 Q:RAX'="V"!(+$G(DA)'>0)
 N A,RACASE,RACN,RADDT,RADTI,RADFN,RAEXAM,RAFN1,RAFN2,RAILOC,RANAME
 N RAPROC,RARES,RARPHY,RARXAM,RASSN,RASTAT,RASTF,RAXDT,X,Y
 S A=$G(^RARPT(DA,0)) Q:$P(A,"^",5)="V"  ; quit if the rpt is v'fied
 S Y=DA D RASET^RAUTL2 ; Derive case/exam data from file 70
 S RADFN(0)=RADFN
 S (RADFN,RANAME)=+$P(A,U,2)
 S RANAME=$S($D(^DPT(RANAME,0)):$P(^(0),U),1:"Unknown")
 S RASSN=$$SSN^RAUTL() S RADFN=RADFN(0)
 S RACASE=$$RPTCSE(A,DA)
 S RAFN1=$P(A,U,3),RAFN2=$P($G(^DD(74,3,0)),U,2)
 S RAXDT=$$XTERNAL^RAUTL5(RAFN1,RAFN2)
 S RAXDT=$S(RAXDT]"":RAXDT,1:"Unknown")
 S RARXAM(0)=$G(^RADPT(+$G(RADFN),"DT",+$G(RADTI),0))
 S RAEXAM=$O(^RADPT(+$G(RADFN),"DT",+$G(RADTI),"P","B",+$G(RACN),0))
 S RAEXAM(0)=$G(^RADPT(+$G(RADFN),"DT",+$G(RADTI),"P",+$G(RAEXAM),0))
 S RAFN1=$P(RAEXAM(0),U,21),RAFN2=$P($G(^DD(70.03,21,0)),U,2)
 S RADDT=$$XTERNAL^RAUTL5(RAFN1,RAFN2)
 S RADDT=$S(RADDT]"":RADDT,1:"Unknown")
 S RAFN1=$P(RAEXAM(0),U,14),RAFN2=$P($G(^DD(70.03,14,0)),U,2)
 S RARPHY=$$XTERNAL^RAUTL5(RAFN1,RAFN2)
 S RARPHY=$S(RARPHY]"":RARPHY,1:"Unknown")
 S RAFN1=$P(RAEXAM(0),U,2),RAFN2=$P($G(^DD(70.03,2,0)),U,2)
 S RAPROC=$$XTERNAL^RAUTL5(RAFN1,RAFN2)
 S RAPROC=$E($S(RAPROC]"":RAPROC,1:"Unknown"),1,37)
 S RAFN1=$P(A,"^",5),RAFN2=$P($G(^DD(74,5,0)),U,2)
 S RASTAT=$S(RAFN1']"":"Unknown",1:$$XTERNAL^RAUTL5(RAFN1,RAFN2))
 S RASTAT=$S(RASTAT]"":RASTAT,1:"Unknown")
 S RAFN1=$P(RARXAM(0),U,4),RAFN2=$P($G(^DD(70.02,4,0)),U,2)
 S RAILOC=$S(RAFN1']"":"Unknown",1:$$XTERNAL^RAUTL5(RAFN1,RAFN2))
 S RAFN1=$P(RAEXAM(0),U,15),RAFN2=$P($G(^DD(70.03,15,0)),U,2)
 S RASTF=$S(RAFN1']"":"Unknown",1:$$XTERNAL^RAUTL5(RAFN1,RAFN2))
 S RAFN1=$P(RAEXAM(0),U,12),RAFN2=$P($G(^DD(70.03,12,0)),U,2)
 S RARES=$S(RAFN1']"":"Unknown",1:$$XTERNAL^RAUTL5(RAFN1,RAFN2))
 S XMB(1)=RANAME,XMB(2)=RASSN,XMB(3)=RACASE,XMB(4)=RAXDT
 S XMB(5)=RADDT,XMB(6)=RASTAT,XMB(7)=RARPHY,XMB(8)=RAPROC
 S XMB(9)=RAILOC,XMB(10)=RASTF,XMB(11)=RARES
 S XMB="RAD/NUC MED REPORT UNVERIFIED"
 ; if called from RAHLO1, then use remote user's duz as sender
 ; var RATRANSC is only defined in RAHL* routines
 S:$D(RATRANSC) XMDUZ=$S($G(RAVERF):RAVERF,$G(RATRANSC):RATRANSC,1:DUZ)
 D ^XMB:$D(^XMB(3.6,"B",XMB))
 K XMB,XMB0,XMC0,XMDT,XMM,XMMG
 Q
RPTCSE(RAA,RADA) ; Determine the case number for this report.
 ; There may be more than one case associated with a given report.
 ; If this is the case, all associated case numbers will be returned.
 ; Input Variables: 'RAA' - zero node of the Rad/Nuc Reports data global
 ;                  'RADA'- ien of the entry in the Rad/Nuc Reports file
 ; Returns: a single case number or numerous case numbers
 Q:'+$O(^RARPT(RADA,1,0)) $S($P(RAA,U)]"":$P(RAA,U),1:"Unknown") ;single
 N I,J,RASTR S RASTR=$S($P(RAA,U)]"":$P(RAA,U),1:"Unknown"),I=0
 F  S I=$O(^RARPT(RADA,1,I)) Q:I'>0  D
 . S J=$G(^RARPT(RADA,1,I,0))
 . S RASTR=RASTR_","_$S($P(J,U)]"":$P(J,U),1:"Unknown")
 . Q
 Q RASTR
