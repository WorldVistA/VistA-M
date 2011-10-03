RAPCE2 ;HIRMFO/GJC-Interface with PCE APIs for wrkload, visits ;11/15/96  08:58
 ;;5.0;Radiology/Nuclear Medicine;**10,17,21**;Mar 16, 1998
 Q
FAILBUL(RADFN,RADTI,RACNI,RADUZ) ; 'Rad/Nuc Med Credit Failure' bulletin
 K XMB,XMB0,XMC0,XMDT,XMM,XMMG
 N RA407,RA44,RA7002,RA7003,RA71,RA791,RA81,RACPT,RACSE,RAIMGLOC
 N RAINTPTR,RAPAT,RAPCSTOP,RAPRC,RASSN,RATEXT,RAUSER,RAXAMDT,RAWHO
 N RAXSET,Y
 S RAWHO=$S($D(RAWHOERR):"Data rejected by PCE.",1:"")
 S RAUSER=$P(^VA(200,RADUZ,0),"^"),RAPAT=$P($G(^DPT(RADFN,0)),"^")
 S RASSN=$$SSN^RAUTL(),RA7002=$G(^RADPT(RADFN,"DT",RADTI,0))
 S RA7003=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 S RAXSET=$S(+$P(RA7002,"^",5):"This case is part of an exam set.",1:"")
 S RA791(0)=$G(^RA(79.1,+$P(RA7002,"^",4),0))
 S RAIMGLOC=+$P(RA791(0),"^")
 S RAXAMDT=$$FMTE^XLFDT($P(RA7002,"^"),"1P"),RACSE=$P(RA7003,"^")
 S RA71=$G(^RAMIS(71,+$P(RA7003,"^",2),0)),RAPRC=$E($P(RA71,"^"),1,45)
 ; cpt string (#.01 and #2 flds)
 S RA81=$$NAMCODE^RACPTMSC(+$P(RA71,"^",9),DT)
 ; cpt code and active status
 S RACPT=$P(RA81,"^")_$S($$ACTCODE^RACPTMSC(+$P(RA71,"^",9),$P(RA7002,"^")):"",1:" (inactive)")
 S RAIMGLOC=$$GET1^DIQ(44,RAIMGLOC_",",.01)
 S RAIMGLOC=$S(RAIMGLOC]"":RAIMGLOC,1:"Unknown")
 S RA407=+$P(RA791(0),"^",22)
 S RA407(0)=$G(^DIC(40.7,RA407,0)),RAPCSTOP=$P(RA407(0),"^")
 S:RAPCSTOP]"" RAPCSTOP=$P(RA407(0),"^",2)_" "_RAPCSTOP
 S:RAPCSTOP']"" RAPCSTOP="Unknown"
 I $P(RA7003,"^",15) S RAINTPTR=$P($G(^VA(200,+$P(RA7003,"^",15),0)),"^")
 I '$D(RAINTPTR),($P(RA7003,"^",12)) D  ; grab Pri. Int Res
 . S RAINTPTR=$P($G(^VA(200,+$P(RA7003,"^",12),0)),"^")
 . Q
 I '$D(RAINTPTR) S RAINTPTR="Unknown"
 D:$D(@(RAEARRY)) XMTXT
 ;
 ; XMB(1) -> Patient Name         XMB(2) -> Patient SSN
 ; XMB(3) -> Exam D/t             XMB(4) -> Case Number
 ; XMB(5) -> Procedure            XMB(6) -> Proc. CPT
 ; XMB(7) -> CPT Modifiers        XMB(8) -> Imag'g Loc Stop Code
 ; XMB(9) -> Interpreter          XMB(10)-> Imag'g Location
 ; XMB(11)-> part of an exam set? XMB(12)-> Did PCE pass back an error?
 ; XMB(13)-> Rad/Nuc Med User     XMB(14)-> 1 line text comment
 ;
 S XMB(1)=RAPAT,XMB(2)=RASSN,XMB(3)=RAXAMDT,XMB(4)=RACSE,XMB(5)=RAPRC
 S XMB(6)=RACPT
 S XMB(8)=RAPCSTOP,XMB(9)=RAINTPTR,XMB(10)=RAIMGLOC
 S XMB(11)=RAXSET,XMB(12)=RAWHO,XMB(13)=RAUSER,XMB(14)=""
 I $G(RALCKFAL) D
 . S:$G(RALCKFAL)<3 XMB(14)="Crediting for this exam failed due to lock failure while completing an exam"_$S($G(RALCKFAL)=2:" for duplicate procedures",1:"")_"."
 . S:$G(RALCKFAL)=3 XMB(14)="Credit cannot be deleted for this exam due to lock failure for this exam date."
 D MODS^RAUTL2 S XMB(7)=Y(1)
 ;
 S XMB="RAD/NUC MED CREDIT FAILURE"
 D ^XMB:$D(^XMB(3.6,"B",XMB))
 K XMB,XMB0,XMC0,XMDT,XMM,XMMG
 Q
XMTXT ; Set XMTEXT to local array which captures error text from the
 ; 'Local variable name'($J).  XMTEXT will only be set
 ; conditionally and will only be set in this subroutine!
 N RACNT,RADTYP,RAETYP,RAPROB,RASUB1,RASUB2,RATXT S RACNT=1,RASUB1=0
 F  S RASUB1=$O(@RAEARRY@($J,RASUB1)) Q:RASUB1'>0  D
 . S RAPROB="" F  S RAPROB=$O(@RAEARRY@($J,RASUB1,RAPROB)) Q:RAPROB=""  D
 .. S RAETYP=""
 .. F  S RAETYP=$O(@RAEARRY@($J,RASUB1,RAPROB,RAETYP)) Q:RAETYP=""  D
 ... S RADTYP=""
 ... F  S RADTYP=$O(@RAEARRY@($J,RASUB1,RAPROB,RAETYP,RADTYP)) Q:RADTYP=""  D
 .... S RASUB2=0
 .... F  S RASUB2=$O(@RAEARRY@($J,RASUB1,RAPROB,RAETYP,RADTYP,RASUB2)) Q:RASUB2'>0  D
 ..... S RATXT=$G(@RAEARRY@($J,RASUB1,RAPROB,RAETYP,RADTYP,RASUB2))
 ..... S:RATXT]"" RATEXT(RACNT)=RATXT,RACNT=RACNT+1
 ..... Q
 .... Q
 ... Q
 .. Q
 . Q
 S:$D(RATEXT) XMTEXT="RATEXT("
 Q
