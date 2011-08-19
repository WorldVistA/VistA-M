DGDEP5 ;ALB/CAW - Delete Duplicate Dependents ;12/15/94
 ;;5.3;Registration;**45**;Aug 13, 1993
EN ;
 N BEG,DATE
 I $G(DGMTI),$G(DGMTACT)="VEW" W !,"Cannot edit when viewing a means test." H 2 G ENQ
 I '$D(DGMTI),$G(DGRPV)=1 W !,"Not while viewing" H 2 G ENQ
 I '$D(^XUSEC("DG DEPDELETE",+DUZ)) W !!,"Access to this option requires a security key.",*7 H 2 G ENQ
 S BEG=2 D SEL^DGDEPU G ENQ:$G(DGERR)
 S DATE="" F  S DATE=$O(DGDEP(DGW,DATE)) Q:'DATE  I $P(DGDEP(DGW,DATE),U,3) W !!,"Dependent has been uploaded by IVM.  Cannot delete." H 2 G ENQ
 I '$$ASSOC(DFN,DGDEP(DGW)) D DEL(DFN,DGDEP(DGW),DGDEP(1),$G(DGMTI))
ENQ S VALMBCK="R"
 D INIT^DGDEP
 Q
 ;
DEL(DFN,DGDEP,DGVDEP,DGMTI) ;Delete Dependent
 ;
 N DGPRI,DGINC,DGINP,DGINR,DGMTP,DGMTA,DGMTACT,DGMTINF
 I $G(DGMTI) S DGMTACT="DDP",DGMTINF=1 D PRIOR^DGMTEVT
 S DGPRI=$P(DGDEP,U,20)
 S DGINP=+$P($G(^DGPR(408.12,+DGPRI,0)),U,3)
 S DGINC=0 F  S DGINC=$O(^DGMT(408.21,"C",DGPRI,DGINC)) Q:'DGINC  D  D DIK(DGINC,"^DGMT(408.21,")
 .S DGINR=0 F  S DGINR=$O(^DGMT(408.22,"AIND",DGINC,DGINR)) Q:'DGINR  D DIK(DGINR,"^DGMT(408.22,")
 D DIK(DGPRI,"^DGPR(408.12,")
 D DIK(DGINP,"^DGPR(408.13,")
 I $G(DGMTI) D
 .S DGVIRI=$P(DGVDEP,U,22) D DEP^DGMTSC1,AFTER^DGMTEVT
 .D SET^DGMTAUD
 W !,"...deleting ANNUAL INCOME..."
 W !,"...deleting INCOME RELATION..."
 W !,"...deleting PERSON..."
 W !,"...deleting INCOME PERSON..."
 K DA,DIK
Q Q
 ;
DIK(DA,DIK) ;Delete file entries
 ;
 D ^DIK
 Q
 ;
ASSOC(DFN,DGDEP) ; Find out if dependent is associated with any MT
 ;
 N DGPER,DGINCP,DGX,DGY,DGZ
 S (DGX,DGZ)=0
 F  S DGX=$O(^DGMT(408.31,"ADFN"_DFN,DGX)) Q:'DGX!(DGZ)  S MTIEN=$O(^DGMT(408.31,"ADFN"_DFN,DGX,"")) I MTIEN D
 .S DGY=0
 .F  S DGY=$O(^DGMT(408.22,"AMT",MTIEN,DFN,DGY)) Q:'DGY!(DGZ)  D
 ..S DGPER=$P($G(^DGMT(408.21,+DGY,0)),U,2)
 ..I DGPER=$P(DGDEP,U,20) D
 ...W !,"This dependent is associated with a means test.  You must remove the"
 ...W !,"dependent from ALL means/co-pay tests prior to deleting.  Use the 'RE' action." H 2 S DGZ=1 Q
ASSOCQ Q DGZ
