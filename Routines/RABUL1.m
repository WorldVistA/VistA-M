RABUL1 ;HISC/FPT,GJC-'RAD/NUC MED EXAM DELETED' Bulletin ;10/24/94  15:22
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ; The DA array and RABULL must be defined.
 ; The elements of the DA array must be greater than 0, and RABULL must
 ; exist for the RAD/NUC MED EXAM DELETED bulletin to execute.
 ; Note: This routine is closely related to the code at: ASKDEL^RAEDCN
 ; Called from: ^DD(70.03,.01,1,2,0-"DT") xref nodes
 ; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ;                     ***** Variable List *****
 ; 'DIFQ'   -> Variable used check if we are installing the Radiology
 ;             Package.  If we are, do not fire the bulletins.
 ; 'RABULL' -> Flag to send bulletin, defined in ASKDEL^RAEDCN
 ; 'RADFN'  -> IEN of the patient in the PATIENT file (2)
 ; 'RAFN1'  -> internal format of a FM date/time data element
 ;             { internal format pointer value }
 ; 'RAFN2'  -> FM data definition for RAFN1, used in XTERNAL^RAUTL5
 ; 'A'      -> Zero node of the RADIOLOGY/NUCLEAR MEDICINE PATIENT
 ;             file (70) { node: ^RADPT(DA(2),"DT",DA(1),"P",DA,0) }
 ; 'B'      -> Zero node of the RADIOLOGY/NUCLEAR MEDICINE PATIENT
 ;             file (70) { node: ^RADPT(DA(2),"DT",DA(1),0) }
 ; 'C'      -> Zero node of the RADIOLOGY PATIENT/NUCLEAR MEDICINE
 ;             file (70) { node: ^RADPT(DA(2),0) }
 ;
 ; Format: Data to be fired;local var name;XMB array representation
 ; Patient ; RANAME ; XMB(1)     <---> Req. Date ; RARDT ; XMB(5)
 ; Patient SSN ; RASSN ; XMB(2)  <---> Rad. Location ; RARLOC ; XMB(6)
 ; Case Number ; RACASE ; XMB(3) <---> Rad. Procedure ; RARPROC ; XMB(7)
 ; Exam Date ; RAXDT ; XMB(4)
 ;
 Q:$D(DIFQ)  ; Quit if installing the software
 Q:'$D(RABULL)!(+$G(DA(2))'>0)!(+$G(DA(1))'>0)!(+$G(DA)'>0)
 N A,B,C,RACASE,RADFN,RAFN1,RAFN2,RANAME,RARDT,RARLOC,RARPROC,RASSN
 N RAXDT,X,Y
 S A=$G(^RADPT(DA(2),"DT",DA(1),"P",DA,0))
 S B=$G(^RADPT(DA(2),"DT",DA(1),0))
 S C=$G(^RADPT(DA(2),0))
 S (RADFN,RANAME)=+$P(C,U)
 S RANAME=$S($D(^DPT(RANAME,0)):$P(^(0),U),1:"Unknown")
 S RASSN=$$SSN^RAUTL()
 S RACASE=$S($P(A,U)]"":$P(A,U),1:"Unknown")
 S RAFN1=$P(B,U),RAFN2=$P($G(^DD(70.02,.01,0)),U,2)
 S RAXDT=$$XTERNAL^RAUTL5(RAFN1,RAFN2)
 S RAXDT=$S(RAXDT]"":RAXDT,1:"Unknown")
 S RAFN1=$P(A,U,21),RAFN2=$P($G(^DD(70.03,21,0)),U,2)
 S RARDT=$$XTERNAL^RAUTL5(RAFN1,RAFN2)
 S RARDT=$S(RARDT]"":RARDT,1:"Unknown")
 S RAFN1=$P(B,U,4),RAFN2=$P($G(^DD(70.02,4,0)),U,2)
 S RARLOC=$$XTERNAL^RAUTL5(RAFN1,RAFN2)
 S RARLOC=$S(RARLOC]"":RARLOC,1:"Unknown")
 S RAFN1=$P(A,U,2),RAFN2=$P($G(^DD(70.03,2,0)),U,2)
 S RARPROC=$$XTERNAL^RAUTL5(RAFN1,RAFN2)
 S RARPROC=$S(RARPROC]"":RARPROC,1:"Unknown")
 S XMB(1)=RANAME,XMB(2)=RASSN,XMB(3)=RACASE,XMB(4)=RAXDT
 S XMB(5)=RARDT,XMB(6)=RARLOC,XMB(7)=RARPROC
 S XMB="RAD/NUC MED EXAM DELETED"
 D ^XMB:$D(^XMB(3.6,"B",XMB))
 K XMB,XMB0,XMC0,XMDT,XMM,XMMG
 Q
