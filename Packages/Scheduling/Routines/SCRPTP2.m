SCRPTP2 ;ALB/CMM - List of Team's Patients ; 29 Jun 99  04:11PM
 ;;5.3;Scheduling;**41,53,52,174,177,231,526,520**;AUG 13, 1993;Build 26
 ;
 ;List of Team's Patients Report
 ;
TFORMAT(INST,INAME,TIEN,TNAME,PHONE,PC) ; Format team information
 ;INST - institution ien
 ;INAME - institution name
 ;TIEN - team ien
 ;TNAME - team name
 ;PHONE - team phone
 ;PC - primary care team (yes/no)
 ;
 I INAME="" S INAME="[BAD DATA]"
 I TNAME="" S TNAME="[BAD DATA]"
 S @STORE@("I",INAME,INST)=""
 S @STORE@("T",INST,TNAME,TIEN)=""
 S @STORE@(INST)="Division: "_INAME
 S @STORE@(INST,TIEN)="Team: "_TNAME
 S $E(@STORE@(INST,TIEN),45)="Team Phone: "_PHONE
 S @STORE@(INST,TIEN,1)="Primary Care Team: "_PC
 Q
 ;
PRINTIT(STORE,TITL) ;
 N INST,INAME,TNAME,TIEN
 S (NEW,PAGE)=1,STOP=0 W:$E(IOST)="C" @IOF
 D TITLE^SCRPU3(.PAGE,TITL,132) ;write title
 D SETH
 ;
 S INAME=""
 F  S INAME=$O(@STORE@("I",INAME)) Q:INAME=""!(STOP)  D
 .S INST=$O(@STORE@("I",INAME,""))
 .Q:INST=""
 .I ('NEW)&(IOST'?1"C-".E) D NEWP1^SCRPU3(.PAGE,TITL,132)
 .I ('NEW)&(IOST?1"C-".E) D HOLD^SCRPU3(.PAGE,TITL,132)
 .Q:STOP
 .W !,$G(@STORE@(INST)) ;write institution
 .S TNAME=""
 .F  S TNAME=$O(@STORE@("T",INST,TNAME)) Q:TNAME=""!(STOP)  D
 ..S TIEN=$O(@STORE@("T",INST,TNAME,""))
 ..Q:TIEN=""
 ..D TPRINT(INST,TIEN) ;writes team info
 ..Q:STOP
 ..;
 ..I (IOST'?1"C-".E)&($Y>(IOSL-4)) D NEWP1^SCRPU3(.PAGE,TITL,132)
 ..I (IOST?1"C-".E)&($Y>(IOSL-4)) D HOLD^SCRPU3(.PAGE,TITL,132)
 ..Q:STOP
 ..D HEADER
 ..I (SORT=3)!(SORT=4) D PRACT(INST,TIEN,.NEW)
 ..I (SORT=1)!(SORT=2) D PTP(INST,TIEN,.NEW)
 K NEW,PAGE
 I 'STOP,$E(IOST)="C" N DIR S DIR(0)="E" W ! D ^DIR
 Q
 ;
PRACT(INST,TIEN,NEW) ;Print by practitioner/patient
 N PNAME,PIEN,SEC2,ST1,TRD,TRDI
 S PNAME="",PIEN=""
 F  S PNAME=$O(@STORE@("P",INST,TIEN,PNAME)) Q:PNAME=""!(STOP)  D
 . F  S PIEN=$O(@STORE@("P",INST,TIEN,PNAME,PIEN)) Q:PIEN=""!(STOP)  D
 . . I (SORT=1)!(SORT=3) S SEC2="""PT""" ;sort by patient name
 . . I (SORT=2)!(SORT=4) S SEC2="""PID""" ;sort by last 4 PID
 . . S ST1=$E(STORE,1,$L(STORE)-1)_","_SEC2_")"
 . . I (IOST'?1"C-".E)&($Y>(IOSL-4)) D NEWP1^SCRPU3(.PAGE,TITL,132) D:'STOP HEADER
 . . Q:STOP
 . . I (IOST?1"C-".E)&($Y>(IOSL-4)) D HOLD^SCRPU3(.PAGE,TITL,132) D:'STOP HEADER
 . . Q:STOP
 . . S (TRDI,TRD)=""
 . . F  S TRD=$O(@ST1@(INST,TIEN,TRD)) Q:TRD=""!(STOP)  D
 . . . F  S TRDI=$O(@ST1@(INST,TIEN,TRD,TRDI)) Q:TRDI=""!(STOP)  D
 . . . . I (IOST'?1"C-".E)&($Y>(IOSL-4)) D NEWP1^SCRPU3(.PAGE,TITL,132) D:'STOP HEADER
 . . . . Q:STOP
 . . . . I (IOST?1"C-".E)&($Y>(IOSL-4)) D HOLD^SCRPU3(.PAGE,TITL,132) D:'STOP HEADER
 . . . . Q:STOP
 . . . . I $D(@STORE@(INST,TIEN,PIEN,TRDI)) W !,$G(@STORE@(INST,TIEN,PIEN,TRDI)) ;write column data
 . . . . N SCACL
 . . . . S SCACL="" F  S SCACL=$O(@STORE@(INST,TIEN,PIEN,TRDI,SCACL)) Q:SCACL=""  D
 . . . . . W !,$G(@STORE@(INST,TIEN,PIEN,TRDI,SCACL))
 . S NEW=0
 Q
 ;
PTP(INST,TIEN,NEW) ;Print by patient/practitioner
 N SEC2,ST1,TRDI,TRD,PNAME,PIEN
 I (SORT=1)!(SORT=3) S SEC2="""PT""" ;sort by patient name
 I (SORT=2)!(SORT=4) S SEC2="""PID""" ;sort by last 4 PID
 S ST1=$E(STORE,1,$L(STORE)-1)_","_SEC2_")"
 I (IOST'?1"C-".E)&($Y>(IOSL-4)) D NEWP1^SCRPU3(.PAGE,TITL,132)
 I (IOST?1"C-".E)&($Y>(IOSL-4)) D HOLD^SCRPU3(.PAGE,TITL,132)
 Q:STOP
 S (TRDI,TRD)=""
 F  S TRD=$O(@ST1@(INST,TIEN,TRD)) Q:TRD=""!(STOP)  D
 . F  S TRDI=$O(@ST1@(INST,TIEN,TRD,TRDI)) Q:TRDI=""!(STOP)  D
 . . I (IOST'?1"C-".E)&($Y>(IOSL-4)) D NEWP1^SCRPU3(.PAGE,TITL,132) D:'STOP HEADER
 . . Q:STOP
 . . I (IOST?1"C-".E)&($Y>(IOSL-4)) D HOLD^SCRPU3(.PAGE,TITL,132) D:'STOP HEADER
 . . Q:STOP
 . . S PNAME="",PIEN=""
 . . F  S PNAME=$O(@STORE@("P",INST,TIEN,PNAME)) Q:PNAME=""!(STOP)!(PIEN=0)  D
 . . . F  S PIEN=$O(@STORE@("P",INST,TIEN,PNAME,PIEN)) Q:PIEN=""!(STOP)  D
 . . . . I (IOST'?1"C-".E)&($Y>(IOSL-4)) D NEWP1^SCRPU3(.PAGE,TITL,132) D:'STOP HEADER
 . . . . Q:STOP
 . . . . I (IOST?1"C-".E)&($Y>(IOSL-4)) D HOLD^SCRPU3(.PAGE,TITL,132) D:'STOP HEADER
 . . . . Q:STOP
 . . . . I $D(@STORE@(INST,TIEN,TRDI,PIEN)) W !,$G(@STORE@(INST,TIEN,TRDI,PIEN)) ;write column data
 . . . . N SCACL
 . . . . S SCACL="" F  S SCACL=$O(@STORE@(INST,TIEN,TRDI,PIEN,SCACL)) Q:SCACL=""  D
 . . . . . W !,$G(@STORE@(INST,TIEN,TRDI,PIEN,SCACL))
 . S NEW=0
 Q
 ;
TPRINT(INST,TIEN) ;
 ;prints team data
 N NXT
 I (IOST'?1"C-".E)&($Y>(IOSL-13)) D NEWP1^SCRPU3(.PAGE,TITL,132) W:'STOP !,$G(@STORE@(INST))
 I (IOST?1"C-".E)&($Y>(IOSL-13)) D HOLD^SCRPU3(.PAGE,TITL,132) W:'STOP !,$G(@STORE@(INST))
 Q:STOP
 W !!,$G(@STORE@(INST,TIEN))
 S NXT=0
 W !,$G(@STORE@(INST,TIEN,1)) ;write team info
 Q:'$D(@STORE@(INST,TIEN,"D"))  W !
 S NXT=""
 ;write team description
 F  S NXT=$O(@STORE@(INST,TIEN,"D",NXT)) Q:NXT=""!(STOP)  D
 .I (IOST'?1"C-".E)&$Y>(IOSL-13) D NEWP1^SCRPU3(.PAGE,TITL,132) W:'STOP !,$G(@STORE@(INST))
 .I (IOST?1"C-".E)&$Y>(IOSL-13) D HOLD^SCRPU3(.PAGE,TITL,132) W:'STOP !,$G(@STORE@(INST))
 .Q:STOP
 .W !,$G(@STORE@(INST,TIEN,"D",NXT))
 W !!,"[Not Assigned] = Patient assigned to Team but not to a position/provider"
 W !,"[Inactive Position] = Patient assigned to Team & Position but has no active provider"
 Q
 ;
HEADER ;prints column headings
 N NXT
 F NXT="H1","H2","H3" D
 .W !,$G(@STORE@(NXT))
 Q
 ;
SETH ;sets column headings
 S @STORE@("H2")="Patient Name"
 S $E(@STORE@("H2"),18)="Pt ID"
 S $E(@STORE@("H2"),32)="Practitioner"
 S $E(@STORE@("H2"),56)="Role"
 S $E(@STORE@("H2"),80)="PC?"
 S $E(@STORE@("H1"),85)="Last"
 S $E(@STORE@("H2"),85)="Appt."
 S $E(@STORE@("H1"),97)="Next"
 S $E(@STORE@("H2"),97)="Appt."
 S $E(@STORE@("H2"),109)="Associated Clinic"
 S $P(@STORE@("H3"),"=",133)=""
 Q
