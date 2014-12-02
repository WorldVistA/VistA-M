ORY348 ;SLC/TC - Post-install for patch OR*3*348 ;05/07/12  07:35
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**348**;Dec 17, 1997;Build 14
 ;
 ;   ICR #2053   UPDATE^DIE
 ;   ICR #2263   EN^XPAR
 ;   ICR #10013  ^DIK
 ;   ICR #10141  MES^XPDUTL
 ;
POST ; Initiate post-init processes
 ;
 D ADDNOT
 D NOTPARAM
 Q
 ;
ADDNOT ; Add Suicide Attempted/Completed Notification to OE/RR Notifications File
 N DA,DIK,ORFDA,ORIEN,ORMSG
 S DIK="^ORD(100.9,",DA=77 D ^DIK
 S ORFDA(1,100.9,"+1,",.01)="SUICIDE ATTEMPTED/COMPLETED"
 S ORFDA(1,100.9,"+1,",.02)="OR"
 S ORFDA(1,100.9,"+1,",.03)="Suicide Attempted/Completed."
 S ORFDA(1,100.9,"+1,",.04)="PKG"
 S ORFDA(1,100.9,"+1,",.05)="R"
 S ORFDA(1,100.9,"+1,",.06)="INFODEL"
 S ORFDA(1,100.9,"+1,",.07)="ORB3FUP2"
 S ORFDA(1,100.9,"+1,",1.5)="PXRM"
 S ORFDA(1,100.9,"+1,",4)="Triggered by Clinical Reminders when a MH SUICIDE ATTEMPTED or MH SUICIDE COMPLETED health factor has been documented in PCE. Recipients include MHTC and Teams. Deletion occurs for individual recipient."
 S ORIEN(1)=77
 D UPDATE^DIE("","ORFDA(1)","ORIEN","ORMSG")
 I $D(ORMSG)>0 D ERRMSG("ORMSG")
 Q
 ;
ERRMSG(REF) ; Output and display any error messages as a result of new record entry
 ;Write all the descendants of the array reference.
 ;REF is the starting array reference, for example A or ^TMP("ORERRMSG",$J).
 ;copied from GMTSPI98 & PXRMUTIL
 N DONE,IND,LEN,LN,PROOT,ROOT,START,TEMP,TEXT
 I REF="" Q
 S LN=0
 S PROOT=$P(REF,")",1)
 ;Build the root so we can tell when we are done.
 S TEMP=$NA(@REF)
 S ROOT=$P(TEMP,")",1)
 S REF=$Q(@REF)
 I REF'[ROOT Q
 S DONE=0
 F  Q:(REF="")!(DONE)  D
 . S START=$F(REF,ROOT)
 . S LEN=$L(REF)
 . S IND=$E(REF,START,LEN)
 . S LN=LN+1,TEXT(LN)=PROOT_IND_"="_@REF
 . S REF=$Q(@REF)
 . I REF'[ROOT S DONE=1
 D MES^XPDUTL(.TEXT)
 Q
 ;
NOTPARAM ; parameter transport routine
 K ^TMP($J,"XPARRSTR")
 N ENT,IDX,ROOT,REF,VAL,I
 S ROOT=$NAME(^TMP($J,"XPARRSTR")),ROOT=$E(ROOT,1,$L(ROOT)-1)_","
 D LOAD
XX2 S IDX=0,ENT="PKG."_"ORDER ENTRY/RESULTS REPORTING"
 F  S IDX=$O(^TMP($J,"XPARRSTR",IDX)) Q:'IDX  D
 . N PAR,INST,ORVAL,ORERR K ORVAL
 . S PAR=$P(^TMP($J,"XPARRSTR",IDX,"KEY"),U),INST=$P(^("KEY"),U,2)
 . M ORVAL=^TMP($J,"XPARRSTR",IDX,"VAL")
 . D EN^XPAR(ENT,PAR,INST,.ORVAL,.ORERR)
 K ^TMP($J,"XPARRSTR")
 Q
LOAD ; load data into ^TMP (expects ROOT to be defined)
 S I=1 F  S REF=$T(DATA+I) Q:REF=""  S VAL=$T(DATA+I+1) D
 . S I=I+2,REF=$P(REF,";",3,999),VAL=$P(VAL,";",3,999)
 . S @(ROOT_REF)=VAL
 Q
DATA ; parameter data
 ;;8000,"KEY")
 ;;ORB ARCHIVE PERIOD^SUICIDE ATTEMPTED/COMPLETED
 ;;8000,"VAL")
 ;;30
 ;;8001,"KEY")
 ;;ORB DELETE MECHANISM^SUICIDE ATTEMPTED/COMPLETED
 ;;8001,"VAL")
 ;;Individual Recipient
 ;;8002,"KEY")
 ;;ORB FORWARD BACKUP REVIEWER^SUICIDE ATTEMPTED/COMPLETED
 ;;8002,"VAL")
 ;;0
 ;;8003,"KEY")
 ;;ORB FORWARD SUPERVISOR^SUICIDE ATTEMPTED/COMPLETED
 ;;8003,"VAL")
 ;;0
 ;;8004,"KEY")
 ;;ORB FORWARD SURROGATES^SUICIDE ATTEMPTED/COMPLETED
 ;;8004,"VAL")
 ;;0
 ;;8005,"KEY")
 ;;ORB PROCESSING FLAG^SUICIDE ATTEMPTED/COMPLETED
 ;;8005,"VAL")
 ;;Disabled
 ;;8006,"KEY")
 ;;ORB PROVIDER RECIPIENTS^SUICIDE ATTEMPTED/COMPLETED
 ;;8006,"VAL")
 ;;CM
 ;;8007,"KEY")
 ;;ORB URGENCY^SUICIDE ATTEMPTED/COMPLETED
 ;;8007,"VAL")
 ;;High
