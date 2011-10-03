DVBAREN1 ;ALB/JLU;NEW 7131 REQ FOR NON-ADMIT VETS;9/20/94
 ;;2.7;AMIE;**14**;Apr 10, 1995
 ;this routine contains the logic to search for admissions, appointments, dispositions, and stop codes.
 ;
OLD ;this is the main entry point.
 S DVBANL=0
 I DVBCHK="A" D A1,COLADM
 I DVBCHK="N" D N1,COLAPT,COLLOG,COLSTP
 I DVBCHK="B" D B1,COLADM,COLAPT,COLLOG,COLSTP
 K DVBAWARN
 Q
A1 ;writes header statement for admission dates
 S VAR(1,0)="0,0,0,2:1,1^The following is a list of Admission dates for "_$P(DFN,U,2)
 D WR^DVBAUTL4("VAR")
 K VAR
 Q
 ;
N1 ;writes the header statement for activity dates
 S VAR(1,0)="0,0,0,2:1,1^The following is a list of activity dates for "_$P(DFN,U,2)
 D WR^DVBAUTL4("VAR")
 K VAR
 Q
 ;
B1 ;writes the header statement for both admission and activity dates
 S VAR(1,0)="0,0,0,2:1,1^The following is a list of Admission and Activity dates for "_$P(DFN,U,2)
 D WR^DVBAUTL4("VAR")
 K VAR
 Q
 ;
COLADM ;gathers the admission info. and stores in to the ^TMP global
 I DVBBDT=0 DO
 .N X,X1,X2
 .S X1=0
 .F X=1:1 S X1=$O(^DGPM("ATID1",+DFN,X1)) Q:'X1  D ADMSET(X1)
 .Q
 I DVBBDT>0 DO
 .N DVBBDT1,DVBEDT1,X,X1,X2
 .S DVBBDT1=9999999.9999999-(DVBBDT-.0000001)
 .S DVBEDT1=9999999.9999999-DVBEDT
 .S X1=DVBEDT1
 .F X=1:1 S X1=$O(^DGPM("ATID1",+DFN,X1)) Q:'X1!(X1>DVBBDT1)  D ADMSET(X1)
 .Q
 Q
 ;
ADMSET(A) ;starts the process of setting up the ^TMP global
 ;A is the internal entry number of the admission in the patient movement
 ;file.
 N X2,X3
 S X2=$O(^DGPM("ATID1",+DFN,A,0))
 S X3=$P(^DGPM(X2,0),U,4)
 Q:X3']""
 D SET(A,9999999.9999999-A,"ADMISSION",$P(^DG(405.1,X3,0),U,1),X2)
 S DVBANL=DVBANL+1
 Q
 ;
COLAPT ;gathers the appointment information
 I DVBBDT=0 DO
 .N X,X1,X2
 .S X1=0
 .F X=1:1 S X1=$O(^DPT(+DFN,"S",X1)) Q:'X1  D APTSET(X1)
 .Q
 I DVBBDT>0 DO
 .N X,X1
 .S X1=DVBBDT-.0000001
 .F X=1:1 S X1=$O(^DPT(+DFN,"S",X1)) Q:'X1!(X1>DVBEDT)  D APTSET(X1)
 .Q
 Q
 ;
APTSET(A) ;begins to set up the ^TMP global for appointments
 N X2
 S X2=$P(^DPT(+DFN,"S",A,0),U,1)
 S X2=$S($D(^SC(X2,0)):$P(^(0),U,1),1:"Unknown")
 D SET(9999999.9999999-X1,X1,"Appointment",X2)
 S DVBANL=DVBANL+1
 Q
 ;
COLSTP ;gathers the stop code information
 N DVBQUERY,DVBDFR,DVBDTO,DVBA,DVBA1,SDOE,SDOE0,DVBZERR
 S DVBDFR=$S(DVBBDT>0:DVBBDT,1:1),DVBDTO=$S(DVBBDT>0:DVBEDT\1+.99,1:9999999)
 ;
 D OPEN^SDQ(.DVBQUERY,"DVBZERR") Q:'$G(DVBQUERY)
 D INDEX^SDQ(.DVBQUERY,"PATIENT/DATE","SET","DVBZERR")
 D SCANCB^SDQ(.DVBQUERY,"I $P(SDOE0,U,3) S ^TMP(""DVBENC"",$J,+SDOE0)=$G(^TMP(""DVBENC"",$J,+SDOE0))+1","SET","DVBZERR")
 D PAT^SDQ(.DVBQUERY,+DFN,"SET","DVBZERR")
 D DATE^SDQ(.DVBQUERY,DVBDFR,DVBDTO,"SET","DVBZERR")
 D ACTIVE^SDQ(.DVBQUERY,"TRUE","SET","DVBZERR")
 K ^TMP("DVBENC",$J)
 D SCAN^SDQ(.DVBQUERY,"FORWARD","DVBZERR")
 D CLOSE^SDQ(.DVBQUERY)
 ;
 S DVBA=0 F  S DVBA=$O(^TMP("DVBENC",$J,DVBA)) Q:'DVBA  S DVBA1=^(DVBA) D
 . D SET(9999999.9999999-DVBA,DVBA,"Stop Code(s)",DVBA1_" Stops")
 . S DVBANL=DVBANL+1
 K ^TMP("DVBENC",$J)
 Q
 ;
COLLOG ;gathers the disposition information
 I DVBBDT>0 DO
 .N DVBBDT1,DVBEDT1,DVBA,DVBA1,DVBA2,DVBVAR
 .S DVBBDT1=9999999.9999999-(DVBBDT-.0000001)
 .S DVBEDT1=9999999.9999999-DVBEDT
 .S DVBA1=DVBEDT1
 .F DVBA=1:1 S DVBA1=$O(^DPT(+DFN,"DIS",DVBA1)) Q:'DVBA1!(DVBA1>DVBBDT1)  D DISSET(DVBA1)
 .Q
 I DVBBDT=0 DO
 .N DVBA,DVBA1,DVBA2
 .S DVBA1=0
 .F DVBA=1:1 S DVBA1=$O(^DPT(+DFN,"DIS",DVBA1)) Q:'DVBA1  D DISSET(DVBA1)
 .Q
 Q
 ;
DISSET(DVBA2) ;begins to set up the ^TMP with dispositions
 I '$D(^DPT(+DFN,"DIS",0)),'$D(DVBAWARN) DO
 .S VAR(1,0)="1,0,0,2:1,0^There is a problem with the Disposition Login information.  Contact IRM"
 .D WR^DVBAUTL4("VAR")
 .K VAR
 .D CONTMES^DVBCUTL4
 .S DVBAWARN=""
 I $D(^DPT(+DFN,"DIS",0)) DO  ;**Bullet Proof
 .K ^UTILITY("DIQ1",$J)
 .S DIC="^DPT(",DA=+DFN,DR=1000,DA(2.101)=DVBA2
 .S DR(2.101)=1,DIQ(0)="E"
 .D EN^DIQ1
 .K DIQ,DIC,DR,DA
 .D SET(DVBA2,9999999.9999999-DVBA2,"Disposition Login",^UTILITY("DIQ1",$J,2.101,DVBA2,1,"E"))
 .S DVBANL=DVBANL+1
 Q
 ;
SET(IDT,CDT,TYP,FTYP,X2) ;
 N VAR1
 S $P(VAR1," ",22)=""
 S Y=CDT
 D DD^%DT
 S ^TMP("DVBA",$J,IDT,TYP)=Y_$E(VAR1,1,23-$L(Y))_TYP_": "_FTYP_"^"_$S($D(X2):X2,1:"")
 Q
 ;
