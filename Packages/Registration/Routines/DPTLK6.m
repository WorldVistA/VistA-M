DPTLK6 ;BAY/JAT,EG - Patient lookup RPCs for patient safety issue ; 11 Aug 2005 8:33 AM
 ;;5.3;Registration;**265,276,277,675**;Aug 13, 1993
GUIBS5(GUIDATA,DFN) ; RPC checks if other patients on "BS5" xref
 ; with same last name
 ; returns:  1 or 0 (or -1 if bad dfn or no zero node)
 ;           if 1, returns text to be displayed
 ; return type:  array
 ; parameter:  ien of Patient file
 K GUIDATA
 I '$G(DFN) S GUIDATA(1)=-1 Q
 I '$D(^DPT(DFN,0)) S GUIDATA(1)=-1 Q
 I '$$BS5^DPTLK5(DFN) S GUIDATA(1)=0 Q
 S GUIDATA(1)=1
 N DPT0,DPTNME,DPTSSN
 S DPT0=$G(^DPT(DFN,0))
 S DPTNME=$P($P(DPT0,U),",")
 S DPTSSN=$E($P(DPT0,U,9),6,9)
 S GUIDATA(2)="There is more than one patient whose last name is "_DPTNME
 S GUIDATA(3)="and whose social security number ends with "_DPTSSN
 S GUIDATA(4)="Are you sure you wish to continue?"
 Q
 ;
GUIBS5A(GUIDATA,DFN) ; RPC checks if other patients on "BS5" xref
 ; with same last name
 ; returns 1 or 0 in 1st string (or -1 if bad DFN or no zero node)
 ; if 1 returns array nodes where
 ; text is preceeded by 0 (0^<text>) 
 ; and patient data is preceeded by 1 (1^DFN^patient name^DOB^SSN)
 ; return type:  global array
 ; parameter:  ien of Patient file
 K GUIDATA
 I '$G(DFN) S GUIDATA(1)=-1 Q
 I '$D(^DPT(DFN,0)) S GUIDATA(1)=-1 Q
 I '$$BS5^DPTLK5(DFN) S GUIDATA(1)=0 Q
 K ^TMP("DPTLK6",$J)
 S ^TMP("DPTLK6",$J,1)=1
 N DPT0,DPTNME,DPTSSN,DPTBS5,DPTLAST,DPTIEN,DPTCNT,DPTDOB,DPTSSN1
 S DPT0=^DPT(DFN,0)
 S DPTNME=$E(DPT0,1),DPTSSN=$E($P(DPT0,U,9),6,9)
 S DPTBS5=DPTNME_DPTSSN
 S DPTLAST=$P($P(DPT0,U),",")
 S ^TMP("DPTLK6",$J,2)="0^There is more than one patient whose last name is "_DPTLAST
 S ^TMP("DPTLK6",$J,3)="0^and whose social security number ends with "_DPTSSN
 S DPTCNT=3
 S DPTIEN=0
 F  S DPTIEN=$O(^DPT("BS5",DPTBS5,DPTIEN)) Q:'DPTIEN  D
 .S DPT0=$G(^DPT(DPTIEN,0)),DPTNME=$P($P(DPT0,U),",")
 .Q:DPTNME'=DPTLAST
 .S DPTNME=$P(DPT0,U)
 .I $T(DOB^DPTLK1)'="" S DPTDOB=$$DOB^DPTLK1(DPTIEN,2),DPTSSN1=$$SSN^DPTLK1(DPTIEN)
 .E  S DPTDOB=$P(DPT0,U,3),DPTSSN1=$P(DPT0,U,9)
 .S DPTCNT=DPTCNT+1
 .S ^TMP("DPTLK6",$J,DPTCNT)="1"_U_DPTIEN_U_DPTNME_U_DPTDOB_U_DPTSSN1
 S DPTCNT=DPTCNT+1
 S ^TMP("DPTLK6",$J,DPTCNT)="0^Are you sure you wish to continue?"
 M GUIDATA=^TMP("DPTLK6",$J)
 K ^TMP("DPTLK6",$J)
 Q
 ;
GUIDMT(GUIDATA,DUZ2) ; RPC checks if the 'Display Means Test Required'
 ; message is to be displayed for the Division user is in
 ; returns 1 or 0 in 1st string (or -1 if bad DUZ(2))
 ; if 1, returns text to be displayed in 2nd and 3rd string (if any)
 ; return type:  array
 ; parameter:  Institution file pointer for user (optional)
 K GUIDATA
 I '$G(DUZ2) S DUZ2=DUZ(2)
 I '$G(DUZ2) S GUIDATA(1)=-1 Q
 N DPTDIV,DPTDIVMT S DPTDIV=0
 S DPTDIV=$O(^DG(40.8,"AD",DUZ2,DPTDIV))
 I '$G(DPTDIV) S GUIDATA(1)=-1 Q
 S GUIDATA(1)=0
 S DPTDIVMT=$G(^DG(40.8,DPTDIV,"MT"))
 I $P(DPTDIVMT,U,3)="Y" S GUIDATA(1)=1,GUIDATA(2)="MEANS TEST REQUIRED",GUIDATA(3)=$P(DPTDIVMT,U,2)
 Q
 ;
GUIMT(GUIDATA,DFN) ; RPC checks if Means Test is required for this patient
 ; returns 1 or 0 (or -1 if bad DFN)
 ; return type:  single value
 ; parameter:  ien of Patient file
 K GUIDATA
 I '$G(DFN) S GUIDATA=-1 Q
 N Y,DGREQF,DGMTLST
 S GUIDATA=0
 S DGMTLST=$$CMTS^DGMTU(DFN)
 I $P(DGMTLST,U,4)'="R" Q
 S GUIDATA=1
 Q
 ;
GUIMTD(GUIDATA,DFN,DUZ2) ; RPC checks if Means Test is required for this
 ; patient and if 'Means Test Required' message is to be
 ; displayed for the Division user is in
 ; returns 1 or 0 in 1st string (or -1 if bad parameters)
 ; if 1, returns text to be displayed in 2nd and 3rd string (if any)
 ; return type:  array
 ; parameters:  ien of Patient file, Institution file pointer for user
 ;                                   (optional)
 K GUIDATA
 I '$G(DUZ2) S DUZ2=DUZ(2)
 I '$G(DFN)!('$G(DUZ2)) S GUIDATA(1)=-1 Q
 N DPTDIV,DPTDIVMT S DPTDIV=0
 S DPTDIV=$O(^DG(40.8,"AD",DUZ2,DPTDIV))
 I '$G(DPTDIV) S GUIDATA(1)=-1 Q
 N Y,DGREQF,DGMTLST
 S GUIDATA(1)=0
 S DGMTLST=$$CMTS^DGMTU(DFN)
 ;only display division message if means test is required
 I '$$MFLG^DGMTU(DGMTLST) Q
 S DPTDIVMT=$G(^DG(40.8,DPTDIV,"MT"))
 I $P(DPTDIVMT,U,3)="Y" S GUIDATA(1)=1,GUIDATA(2)="MEANS TEST REQUIRED",GUIDATA(3)=$P(DPTDIVMT,U,2)
 Q
 ;
