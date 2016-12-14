ORY423 ;ISP/WAT post-init for OR*3.0*423; ;07/12/16  07:44
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**423**;Dec 17, 1997;Build 19
 Q
POST ;post-init
 N ORD,ORPOST,ORSTNUM,XPDIDTOT
 D LAB
 S ORPOST=1,ORSTNUM=1,XPDIDTOT=3
 S ORD("GMRCOR CONSULT")=""
 D EN^ORYDLG(423,.ORD),UPDATE^XPDID(ORSTNUM) S ORSTNUM=ORSTNUM+1
 D ^ORY423ES,UPDATE^XPDID(ORSTNUM) S ORSTNUM=ORSTNUM+1
 D QUEUE("File #100 index correction","MAIN^ORY423(""?"")","OE/RR FILE #100 CORRECT C & D INDEX",.ORSTNUM)
 D UPDATE^XPDID(ORSTNUM)
 S ORSTNUM=ORSTNUM+1
 D BMES^XPDUTL("Moving supply quick orders...")
 I $$SQOCONV^ORY423A D BMES^XPDUTL("DONE")
 D UPDATE^XPDID(ORSTNUM)
 Q
 ;
SENDDLG(ANAME) ; Return true if the current order dialog should be sent
 I ANAME="GMRCOR CONSULT" Q 1
 Q 0
 ;
QUEUE(ORMSG,ZTRTN,ZTDESC,ORCURITM) ;CREATE A SPECIFIED TASK
 ;PARAMETERS: ORMSG    => STRING CONTAINING THE TEXT TO OUTPUT TO THE SCREEN
 ;            ZTRTN    => STRING CONTAINING THE ROUTINE TASKMAN SHOULD EXECUTE
 ;            ZTDESC   => STRING CONTAINING THE TASK'S DESCRIPTION
 ;            ORCURITM => REFERENCE TO THE VARIABLE STORING THE NUMBER OF THE CURRENT ITEM
 N ZTDTH,ZTIO,ZTSK
 D BMES^XPDUTL("Queueing "_ORMSG_"...")
 S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,0,0,0,10)
 S ZTIO=""
 D ^%ZTLOAD
 I +$G(ZTSK)=0 D
 .I $G(ORPOST) D BMES^XPDUTL("Unable to queue the "_ORMSG_"; file a help desk ticket for assistance.")
 .E  W "ERROR",!,"Unable to queue the "_ORMSG_"; file a help desk ticket for assistance.",!
 E  D
 .I $G(ORPOST) D
 ..D BMES^XPDUTL("DONE - Task #"_ZTSK)
 ..D UPDATE^XPDID(ORCURITM)
 ..S ORCURITM=ORCURITM+1
 .E  W "DONE",!,"Task #"_ZTSK,!
 Q
 ;
MAIN(ORIRDT) ;drive
 N ORINSDT,ORSTAT,ORREP,ORRECP S ORINSDT=$$INSDT()
 I $G(ORINSDT)'>0 D  Q
 . S ORREP(1)="The file #100 index correction in OR*3.0*423 did not run."
 . S ORREP(2)="The install date for OR*3.0*389 was NOT found."
 . S ORREP(3)="Please log a help desk ticket for assistance."
 . S ORRECP(DUZ)=""
 . S ORSTAT=$$MAIL^ORUTL("ORREP(","PATCH OR*3.0*423 ORDER INDEX CORRECTION STATUS",.ORRECP)
 . S ZTREQ="@"
 ;use date as starting point for C/D index set
 ;if date is passed in, use that date
 I $G(ORIRDT)'["?" S ORINSDT=ORIRDT
 D REBUILD(ORINSDT)
 Q
 ;
INSDT() ;get install dates for 389
 N ORDATES S ORDATES=0
 S ORDATES=$$INSTALDT^XPDUTL("OR*3.0*389",.ORSLT)
 I ORDATES>0 S ORDATES=$O(ORSLT(""))
 K ORSLT
 Q ORDATES
 ;
REBUILD(ORDT) ;set missing index entries
 Q:$G(ORDT)'>0
 ;set ORDT one day back to ensure no orders are skipped
 S ORDT=$$FMADD^XLFDT(ORDT,-1)
 N ORDTM,ORIFN,ORNODE,ORDLG,ORCNT,ORSTAT,ORREP,ORRECP S ORDTM=ORDT,ORIFN=0,ORCNT=0
 F  S ORDTM=$O(^OR(100,"AF",ORDTM)) H:'(ORCNT#10000) 1  Q:ORDTM=""!($G(ZTSTOP)=1)  D
 .F  S ORIFN=$O(^OR(100,"AF",ORDTM,ORIFN)) Q:$G(ORIFN)'>0  D  ;have to loop here; can have mult orders w/same time stamp
 ..;check for and add C and D x-refs
 ..I $D(^OR(100,ORIFN,0))'=0 D
 ...S ORNODE=^OR(100,ORIFN,0)
 ...S ORDLG=$P(ORNODE,U,5) Q:$G(ORDLG)=""
 ...;$D for index and set if missing
 ...Q:$D(^OR(100,"C",ORDLG,ORIFN))=1
 ...S ^OR(100,"C",$E(ORDLG,1,30),ORIFN)=""
 ..I $D(^OR(100,ORIFN,3))'=0 D
 ...S ORNODE=^OR(100,ORIFN,3),ORDLG=""
 ...S ORDLG=$P(ORNODE,U,4) Q:$G(ORDLG)=""
 ...;$D for index and set if missing
 ...Q:$D(^OR(100,"D",ORDLG,ORIFN))=1
 ...S ^OR(100,"D",$E(ORDLG,1,30),ORIFN)=""
 .S ORCNT=ORCNT+1
 .I ORCNT#1000=0,($$S^%ZTLOAD) N X S ZTSTOP=1,X=$$S^%ZTLOAD("File 100 C/D Index Correction")
 ;SEND STATUS EMAIL
 I +$G(ZTSTOP)=0 D
 .S ORREP(1)="The file #100 index correction from OR*3.0*423 was successfully completed."
 E  D
 .K ORREP
 .S ORREP(1)="The file #100 index correction in OR*3.0*423 has unexpectedly stopped."
 .S ORREP(2)="If you or the system manager did not stop the process, please check the"
 .S ORREP(3)="error log and file a help desk ticket for assistance."
 .S ORREP(4)=""
 .S ORREP(5)="To requeue the cleanup/conversion process, run RESTART^ORY423 from the"
 .S ORREP(6)="programmer prompt and when asked for the starting order date, enter"
 .S ORREP(7)=ORDTM
 S ORRECP(DUZ)=""
 S ORSTAT=$$MAIL^ORUTL("ORREP(","PATCH OR*3.0*423 ORDER INDEX CORRECTION STATUS",.ORRECP)
 I +ORSTAT,($G(ZTSTOP)=1) D
 .S ^XTMP("ORY423",0)=$$FMADD^XLFDT($$NOW^XLFDT,7,0,0,0)_U_$$NOW^XLFDT_U_"OR*3*423 POST-INSTALL DATA"
 .S ^XTMP("ORY423","ORDER")=(ORDTM)
 S ZTREQ="@"
 Q
 ;
RESTART ;index redux
 N DIC,Y,X,DTOUT,DUOUT
 S DIC="^OR(100,",DIC(0)="AEQX",DIC("A")="ENTER THE STARTING ORDER DATE FROM THE STATUS EMAIL: "
 D ^DIC
 Q:+Y<1
 W !,"Queueing re-index..."
 D QUEUE("File #100 index correction","MAIN^ORY423("_+Y_")","OE/RR FILE #100 CORRECT C & D INDEX")
 Q
 ;
LAB ;
 N I,X,DAT,ENT,RTN,R
 S DAT="ORRPW LAB OVERVIEW^ORRPW LAB ORDERS ALL^ORRPL LAB ORDERS ALL^ORRPL LAB ORDERS PEND^ORRPL LAB OVERVIEW"
 S ENT="OV^ALL^ALL^PEND^OV",RTN="ORDV02D"
 F I=1:1:5 S R=$P(DAT,"^",I) I $O(^ORD(101.24,"B",R,0)) S IFN=$O(^(0)) I $D(^ORD(101.24,IFN,0)),$D(^(2)) D
 . ;W !,$P(DAT,"^",I),?25,$P(^(2),"^",8)_"^"_$P(^(2),"^",9)_"="_$P(ENT,"^",I)_"^"_RTN
 . S $P(^ORD(101.24,IFN,2),"^",8,9)=$P(ENT,"^",I)_"^"_RTN
 Q
