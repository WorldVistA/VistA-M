DGMTSCU4 ;ALB/CMF - Means Test Maximum Annual Pension Rate Utilities ;4 OCT 2004 3:33 pm
 ;;5.3;Registration;**624**;Aug 13, 1993
 ;
 Q
MEDEXP(DGGRS,DGADJ,DGYR,DGDEP) ;
 ; in:   DGGRS = gross medical expense, default is 0
 ;       DGADJ = adjusted medical expense, default is 0
 ;       DGYR  = rate table year
 ;       DGDEP = # of dependents
 ; out:  if gross >0, adjusted medical expense
 ;       if adjusted > 0, gross medical expense (back-compute)
 ;       else 0
 N DGRTN,DGMAP,DGPER,DGADD
 ; initialize variables, quit if inappropriate
 S DGRTN=0
 S DGGRS=$S(+$G(DGGRS)>0:DGGRS,1:0)
 S DGADJ=$S(+DGGRS:0,+$G(DGADJ)>0:DGADJ,1:0)
 Q:(DGGRS=0)&(DGADJ=0) DGRTN
 S DGYR=$S(+$G(DGYR):DGYR,1:-1)
 Q:DGYR=-1 DGRTN
 S DGDEP=$S(+$G(DGDEP):+DGDEP,1:0)
 ;
 ; get global % rate
 S DGPER=$$GET^XPAR("PKG","DGMT MAPR GLOBAL RATE",DGYR)
 Q:DGPER="" DGRTN
 ;
 ; get max annual value
 I DGDEP=0 S DGMAP=$$GET^XPAR("PKG","DGMT MAPR 0 DEPENDENTS",DGYR)
 I DGDEP>0 S DGMAP=$$GET^XPAR("PKG","DGMT MAPR 1 DEPENDENTS",DGYR)
 S DGADD=0
 D:DGDEP>1
 .S DGADD=$$GET^XPAR("PKG","DGMT MAPR N DEPENDENTS",DGYR)
 .S DGADD=DGADD*(DGDEP-1)
 .Q
 ;
 S DGRTN=(DGMAP+DGADD)*DGPER/100
 D:DGGRS>0
 .S DGRTN=DGGRS-DGRTN
 .S DGRTN=$S(DGRTN>0:DGRTN,1:0)
 .Q
 ;
 D:DGADJ>0
 .S DGRTN=DGADJ+DGRTN
 .S DGRTN=$S(DGRTN>0:DGRTN,1:0)
 .Q
 ;
 Q DGRTN
 ;
ND(DGP1,DGP2,DGP3) ;return # of deps for a test
 ; in:   dgp1:DFN = patient ien
 ;       dgp2:DGMTDT = means test date
 ;       dgp3:DGVIRI = veteran income relation ien
 ; out:  DGND = # of dependents for a test 
 N DGDC,DGNC,DGND,DGSP,DGVIR0,DFN,DGMTDT,DGVIRI
 S DFN=+$G(DGP1)
 S DGMTDT=+$G(DGP2)
 S DGVIRI=+$G(DGP3)
 Q:(DFN=0)!(DGMTDT=0)!(DGVIRI=0) 0
 D DEP^DGMTSCU2
 Q $S(DGND<0:0,DGND<21:DGND,1:20)
 ;
GRSADJ(DGP1,DGP2,DGP3,DGP4) ;write adjusted medical expense
 ;called from [DGMT ENTER/EDIT EXPENSES] edit template
 ; in:   see $$ADJUST
 ; out:  text string with adjusted medical expense
 N DGADJ
 S DGADJ=$$ADJUST(DGP1,DGP2,DGP3,DGP4)
 S DGADJ=$$AMT^DGMTSCU1(DGADJ)
 Q "ADJUSTED MEDICAL EXPENSES: "_DGADJ_"//"
 ;
ADJUST(DGP1,DGP2,DGP3,DGP4) ;derive adjust med exp from gross med exp
 ; in:   dgp1:DGVINI = veteran income test ien
 ;       dgp2:DGDFN = patient ien
 ;       dgp3:DGMTDT = means test date
 ;       dgp4:DGVIRI = veteran income relation ien
 ; out:  adjusted medical expense or -1 if not set
 N DGND,DGYR,DGGRS,DGADJ,DGVINI,DGDFN,DGMTDT,DGVIRI
 S DGVINI=+$G(DGP1)
 S DGDFN=+$G(DGP2)
 S DGMTDT=+$G(DGP3)
 S DGVIRI=+$G(DGP4)
 Q:(DGVINI=0)!(DGDFN=0)!(DGMTDT=0)!(DGVIRI=0) -1
 Q:'$D(^DGMT(408.21,DGVINI,1)) 0
 S DGND=$$ND(DGDFN,DGMTDT,DGVIRI)
 S DGYR=$$YEAR(DGMTDT)
 S DGGRS=$P(^DGMT(408.21,DGVINI,1),U,12)
 S DGADJ=$$MEDEXP(DGGRS,,DGYR,DGND)
 S $P(^DGMT(408.21,DGVINI,1),U)=DGADJ
 Q DGADJ
 ;
GROSS(DGP1,DGP2,DGP3,DGP4) ;derive gross med exp from adj med exp
 ; in:   dgp1:DGVINI = veteran income test ien
 ;       dgp2:DGDFN = patient ien
 ;       dgp3:DGMTDT = means test date
 ;       dgp4:DGVIRI = veteran income relation ien
 ; out:  gross medical expense reset if necessary
 N DGND,DGYR,DGGRS,DGADJ,DGVINI,DGDFN,DGMTDT,DGVIRI
 S DGVINI=+$G(DGP1)
 S DGDFN=+$G(DGP2)
 S DGMTDT=+$G(DGP3)
 S DGVIRI=+$G(DGP4)
 Q:(DGVINI=0)!(DGDFN=0)!(DGMTDT=0)!(DGVIRI=0)
 Q:'$D(^DGMT(408.21,DGVINI,1))
 S DGGRS=+$P(^DGMT(408.21,DGVINI,1),U,12)
 S DGADJ=+$P(^DGMT(408.21,DGVINI,1),U,1)
 Q:DGGRS+DGADJ=0
 Q:DGADJ=0
 S DGND=$$ND(DGDFN,DGMTDT,DGVIRI)
 S DGYR=$$YEAR(DGMTDT)
 Q:DGADJ=$$MEDEXP(DGGRS,,DGYR,DGND)
 S DGGRS=$$MEDEXP(,DGADJ,DGYR,DGND)
 S $P(^DGMT(408.21,DGVINI,1),U,12)=DGGRS
 Q
 ;
YEAR(DGMTDT) ;get MAPR year from means test date
 Q $$FMTE^XLFDT($E(DGMTDT,1,3)_"0000",1)-2
 ;
AGME101(DGP1) ;force recalculate gross upon FM change to adjusted
 ; in:   dgp1:~DGVINI = veteran income test ien
 ; out:  queued task
 ; called from AGME101 x-ref of 408.21/1.01
 N DGVINI
 S DGVINI=+$G(DGP1)
 Q:'DGVINI
 Q:'$D(^DGMT(408.21,DGVINI,1))
 S $P(^DGMT(408.21,DGVINI,1),U,12)=0
 Q
 ;
