DPTLK5 ;BAY/JAT,EG - Patient lookup APIs for patient safety issues ; 11 Aug 2005 8:20 AM
 ;;5.3;Registration;**265,276,277,485,675,788**;Aug 13, 1993;Build 18
 Q
BS5(DPTDFN) ;function checks if other patients on "BS5" xref
 ; with same last name
 ; returns 1 if other patients exist
 ; input: ien of Patient file
 I '$G(DPTDFN) Q 0
 I '$D(^DPT(DPTDFN,0)) Q 0
 N DPT0,DPTNME,DPTSSN,DPTBS5,DPTLAST,DPTIEN,DPTFLAG
 S DPT0=^DPT(DPTDFN,0)
 S DPTNME=$E(DPT0,1),DPTSSN=$E($P(DPT0,U,9),6,9)
 S DPTBS5=DPTNME_DPTSSN
 S DPTLAST=$P($P(DPT0,U),",")
 S (DPTIEN,DPTFLAG)=0
 F  S DPTIEN=$O(^DPT("BS5",DPTBS5,DPTIEN)) Q:'DPTIEN!(DPTFLAG=1)  D
 .Q:DPTDFN=DPTIEN
 .S DPTNME=$P($P($G(^DPT(DPTIEN,0)),U),",")
 .I DPTNME=DPTLAST S DPTFLAG=1
 Q DPTFLAG
 ;
DMT(DPTDFN,DPTUSER) ; function checks if the 'Display Means Test Required'
 ; message is to be displayed for this Division
 ; returns Division ien if message is to be displayed
 ; input:  a) ien of Patient file 
 ;         b) user's Institution for current session (DUZ(2))
 ;             DD(200.02,.01)<==>DD(4,DINUM)<==>DD(40.8,.07)
 I '$G(DPTDFN)!('$G(DPTUSER)) Q 0
 N Y,DFN,DGREQF,DGMTLST,DPTDIV
 ; verifies that Means Test required for this patient
 ;
 S DFN=DPTDFN
 S DGMTLST=$$CMTS^DGMTU(DFN)
 ;only display division message if means test is required
 I '$$MFLG^DGMTU(DGMTLST) Q 0
 S DPTDIV=0
 S DPTDIV=$O(^DG(40.8,"AD",DPTUSER,DPTDIV))
 I DPTDIV,$P($G(^DG(40.8,DPTDIV,"MT")),U)="Y" Q DPTDIV
 Q 0
 ;
FFP ; This function checks if the 'Display Fugitive Felon Message'
 ; message is to be displayed.  Message displays only for DG and SD
 ; menu options
 ;
 Q:'$D(XQY0)
 Q:$E(XQY0,1,2)'="SD"&($E(XQY0,1,2)'="DG")
 ;
 N X,Y,IORVON,IORVOFF,DIR,DIRUT
 S X="IORVON;IORVOFF"
 D ENDR^%ZISS
 W !?17,$CHAR(7) W:$D(IORVON) IORVON W "*** WARNING - FFP FLAG ACTIVE ***" W:$D(IORVOFF) IORVOFF
 W !?19,$CHAR(7) W:$D(IORVON) IORVON W "PLEASE NOTIFY YOUR SUPERVISOR" W:$D(IORVOFF) IORVOFF
 W !
 I '$D(DGCLIST) D
 . S DIR(0)="FAO",DIR("A")="Enter <RETURN> to continue."
 . D ^DIR K DIR
 Q
