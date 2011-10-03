ACKQDWL ;AUG/JLTP BIR/PTD HCIOFO/BH-Compile A&SP Capitation Data ; [ 05/21/96 11:15 ]
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
OPTN ;  Introduce option.
 W @IOF,!,"This option compiles the data for the A&SP Capitation Report.",!
DIV ; select Division (user may select one/many/ALL)
 S ACKDIV=$$DIV^ACKQUTL2(3,.ACKDIV,"IA") G:'ACKDIV EXIT
 ;  get month to be compiled
 D GETDT G:$D(DIRUT) EXIT
 ;  initialise other variables
 D INIT S ACKMAN=1,ACKDUZ=DUZ
 ;
 ;  Check the status of the workload file
 S ACKWLMSG=$$WLSTATUS^ACKQDWLU(ACKDA,.ACKDIV,.ACKWLMSG)
 ;  If status does not allow us to run, then exit
 S ACKSTAT=$$STAQES1^ACKQDWLU(ACKDA,.ACKDIV,.ACKWLMSG)
 ;
 I 'ACKSTAT!(ACKSTAT="^") D EXIT G DIV
 ;                      
BKG ;  Queue process to run in the background.
 W !!,"QUASAR - Compile A&SP Capitation Data ",!
 ;
 S ZTRTN="DQ^ACKQDWL",ZTIO="",ZTSAVE("ACK*")=""
 S ZTDESC="QUASAR - Compile A&SP Capitation Data" D ^%ZTLOAD
 W:$D(ZTSK) !,"Data generation queued to run in the background."
 G EXIT
 ;
DQ ;  Entry point when queued.
 N CPT,ICD
 S:'$D(ACKM) ACKM=$$LM(DT) D:'$D(ACKDA) INIT
 S ACKWLMSG=$$WLSTATUS^ACKQDWLU(ACKDA,.ACKDIV,.ACKWLMSG)
 S ACKSTAT=$$STAQES^ACKQDWLU(ACKWLMSG) I 'ACKSTAT D:'$D(ACKMAN) ABORT^ACKQDWB(ACKWLMSG) G EXIT
 I ACKSTAT=2 D CREATE^ACKQDWLU(ACKDA,ACKM,.ACKDIV) G:$D(DIRUT) EXIT
 D BEGIN
 D ^ACKQDWL1
 D END
 ;
 ;
EXIT ;  ALWAYS EXIT HERE
 K ACKBFY,ACKCP,ACKCPP,ACKCPT,ACKD,ACKDA,ACKDUZ,ACKEM,ACKICP,ACKICD,ACKM,ACKMAN,ACKMO,ACKNU,ACKNV,ACKST,ACKSTOP,ACKV,ACKXFT,ACKXST,ACKZIP
 K %X,%Y,D0,DA,DFN,DIE,DIRUT,DTOUT,DUOUT,DR,I,VAERR,VAPA,X,XMZ,Y,ZTSK
 K ^TMP("ACKQWL",$J),ACKXSDTE,ACKXEDTE,ACKDIV
 K ACKSTAT,ACKST,ACKK1,ACKN,ACKDEF,ACKVDVN,ACKX,DIVIEN,DIVARR
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
GETDT ;  Select month for report.
 N DIR,X,Y
GDT1 S DIR(0)="D^::APE",DIR("A")="Select Month & Year"
 S DIR("B")=$$XDAT^ACKQUTL($$LM(DT)),DIR("?")="^D HELP^%DTC"
 S DIR("??")="^D DATHLP^ACKQDWL"
 D ^DIR Q:$D(DIRUT)
 S ACKM=$E(Y,1,5)_"00"
 I ACKM>DT W !,$C(7),"Can't run capitation report for future months!" G GDT1
 Q
 ;
INIT ;  Initialize important variables.
 N MON
 S MON=$E(ACKM,1,5),ACKEM=MON_"99",ACKDA=+$$SITE^VASITE()_MON
 S ACKBFY=$$BFY^ACKQUTL(ACKM)
 Q
 ;
LM(X) ;  Find month previous to X.
 N M,D,Y S M=$E(X,4,5),D=$E(X,6,7),Y=$E(X,1,3),M=M-1
 S:M<1 M=12,Y=Y-1 S:M<10 M="0"_M
 Q Y_M_"00"
 ;
DATHLP ;  Extended help - select month for capitation report. (ACKQWL)
 W !?5,"Enter a date, in the past, for which you wish to",!?5,"compile data for the A&SP Capitation Report."
 Q
 ;
END ;  Set END date field into header for Division and Date  
 N ACKARR
 D NOW^%DTC
 S DIVNUM=""
 F  S DIVNUM=$O(ACKDIV(DIVNUM)) Q:DIVNUM=""  D
 . S DIVIEN=$P(ACKDIV(DIVNUM),U,1)
 . S ACKARR(509850.75,DIVIEN_","_ACKDA_",",5.04)=%
 D FILE^DIE("K","ACKARR")
 D NOW^%DTC
 S Y=X D DD^%DT S ACKXEDTE=Y
 S ACKXFT=$$HTIM^ACKQUTL(),ACKMO=$$XDAT^ACKQUTL(ACKM) D BUILD^ACKQDWB
 K ACKDIV
 Q
 ;
BEGIN ;  Set START date and Job # into header record for Division and date
 N ACKARR
 D NOW^%DTC
 S Y=X D DD^%DT S ACKXSDTE=Y
 S ACKXST=$$HTIM^ACKQUTL
 S DIVNUM=""
 F  S DIVNUM=$O(ACKDIV(DIVNUM)) Q:DIVNUM=""  D
 . S DIVIEN=$P(ACKDIV(DIVNUM),U,1)
 . S ACKARR(509850.75,DIVIEN_","_ACKDA_",",5.02)=%
 . S ACKARR(509850.75,DIVIEN_","_ACKDA_",",5.03)=$J
 D FILE^DIE("K","ACKARR")
 Q
 ;
 ;
