DGMTU1 ;ALB/RMO/MIR/CKN - Patient Relation Utilities ; 11/8/05 2:21pm
 ;;5.3;Registration;**166,653**;Aug 13, 1993;Build 2
 ;
 ;
 ;=======================================================================
 ; The first set of utilities will display data from the PATIENT
 ; RELATION file
 ;=======================================================================
 ;
 ;
DEM(DGPRI) ;Demographics of Patient Relation
 ;         Input  -- DGPRI  Patient Relation IEN
 ;         Output -- Patient or Income Person 0th node
 N DGVPI,DGVP0
 S DGVPI=$P($G(^DGPR(408.12,DGPRI,0)),"^",3)
 I DGVPI]"" S DGVP0=$G(@("^"_$P(DGVPI,";",2)_+DGVPI_",0)"))
 Q $S($G(DGVP0)]"":DGVP0,1:"")
 ;
DEM1(DGPRI) ;Demographics of Patient Relation node 1
 ;         Input  -- DGPRI Patient Relation IEN
 ;         Output -- Patient or Income Person node 1
 N DGVPI,DGVP1
 S DGVPI=$P($G(^DGPR(408.12,DGPRI,0)),"^",3)
 I DGVPI]"" S DGVP1=$G(@("^"_$P(DGVPI,";",2)_+DGVPI_",1)"))
 Q $S($G(DGVP1)]"":DGVP1,1:"")
 ;
NODE(DGPRI) ;Send back the name, sex, dob, and SSN in external format
 ;         Input  -- DGPRI  Patient Relation IEN
 ;         Output -- External format of name, sex, dob, and SSN
 ;                   in pieces 1,2,3, and 9 respectively
 ;
 ;                   NOTE:  date is in mm/dd/yyyy format
 ;
 N NODE,X,Y
 S NODE=$$DEM(DGPRI)
 S X=$P(NODE,"^",2) I X]"" S $P(NODE,"^",2)=$S(X="M":"MALE",X="F":"FEMALE",1:"") ; sex
 S X=$P(NODE,"^",3) I X]"" S X=$$FMTE^XLFDT(X,"5DF") S $P(NODE,"^",3)=$TR(X," ","0")
 S X=$P(NODE,"^",9) I X]"" S $P(NODE,"^",9)=$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,10)
 S $P(NODE,"^",4,8)="^^^^",$P(NODE,"^",10,99)=""
 Q NODE
 ;
NAME(DGPRI) ;Name of Patient Relation
 ;         Input  -- DGPRI  Patient Relation IEN
 ;         Output -- Patient or Income Person Name
 N DGNM
 S DGNM=$P($$DEM(DGPRI),"^")
 Q $G(DGNM)
 ;
SEX(DGPRI) ;Sex of Patient Relation
 ;         Input  -- DGPRI  Patient Relation IEN
 ;         Output -- Patient or Income Person Sex
 N DGSEX,Y
 S Y=$P($$DEM(DGPRI),"^",2) S DGSEX=$S(Y="M":"MALE",Y="F":"FEMALE",1:"")
 Q $G(DGSEX)
 ;
DOB(DGPRI) ;Date of Birth of Patient Relation
 ;         Input  -- DGPRI  Patient Relation IEN
 ;         Output -- Patient or Income Person Date of Birth
 N DGDOB,Y
 S Y=$P($$DEM(DGPRI),"^",3) X ^DD("DD") S DGDOB=Y
 Q $G(DGDOB)
 ;
SSN(DGPRI) ;Social Security Number of Patient Relation
 ;         Input  -- DGPRI  Patient Relation IEN
 ;         Output -- Patient or Income Person Social Security Number
 N DGSSN,Y
 S Y=$P($$DEM(DGPRI),"^",9) S DGSSN=$S(Y]"":$E(Y,1,3)_"-"_$E(Y,4,5)_"-"_$E(Y,6,10),1:"")
 Q $G(DGSSN)
 ;
REL(DGPRI) ;Relationship of Patient Relation
 ;         Input  -- DGPRI  Patient Relation IEN
 ;         Output -- Relationship of Patient Relation
 N DGREL
 S DGREL=$P($G(^DG(408.11,+$P($G(^DGPR(408.12,DGPRI,0)),U,2),0)),U)
 Q $G(DGREL)
