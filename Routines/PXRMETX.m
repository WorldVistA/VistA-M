PXRMETX ; SLC/PJH - Run Extract for QUERI ;07/10/2007
 ;;2.0;CLINICAL REMINDERS;**4,6**;Feb 04, 2005;Build 123
 ;
AUTO(ID,PURGE) ;Called from option scheduling (#19.2)
 N IEN,LIST,LUVALUE,MODE,NEXT
 S LUVALUE(1)=ID
 D FIND^DIC(810.2,"","","U",.LUVALUE,"","","","","LIST")
 ;Get ien of extract parameter
 S IEN=$P(LIST("DILIST",2,1),U,1) Q:'IEN
 ;Get next extract period
 S NEXT=$P($G(^PXRM(810.2,IEN,0)),U,6) Q:NEXT=""
 ;Node is Extract and Transmit
 S MODE=$S($P($G(^PXRM(810.2,IEN,100)),U)="N":0,1:1)
 ;Run extract
 D RUN^PXRMETX(IEN,NEXT,MODE,PURGE)
 ;Purge Extract Summary
 D PRGES^PXRMETXU
 ;Purge Patient Lists
 D PRGPL^PXRMETXU
 Q
 ;
GETNAME(NAME,CLASS) ;Get the extract name.
 I '$D(^PXRMXT(810.3,"B",NAME)) Q NAME
 N CNT,NEW
 S (CNT,NEW)=0
 ;If name exists concatenate count
 F  D  Q:NEW
 .I '$D(^PXRMXT(810.3,"B",NAME)) S NEW=1 Q
 .S CNT=CNT+1,NAME=$P(NAME,"/")_"/"_$$RJ^XLFSTR(CNT,2,0)
 Q NAME
 ;
IHD ;Monthly IHD Extract, called from option PXRM EXTRACT VA-IHD QUERI.
 D AUTO("VA-IHD QUERI","Y")
 Q
 ;
MAIL(NAME,NEXT,MODE) ;Completion mail message
 N FREQ,TEXT
 S FREQ="year"
 I $E(NEXT)="M" S FREQ="month"
 I $E(NEXT)="Q" S FREQ="quarter"
 ;
 I MODE=0 S TEXT="Extract and Transmission"
 I MODE=1 S TEXT="Extract (No Transmission)"
 I MODE=2 S TEXT="Manual Extract and Transmission"
 I MODE=3 S TEXT="Manual Extract (No Transmission)"
 ;
 S TEXT=NAME_" "_TEXT_" completed for "_FREQ_" "_NEXT
 D MES^PXRMEUT(TEXT)
 Q
 ;
MH ;Monthly MH Extract, called from option PXRM EXTRACT VA-MH QUERI.
 D AUTO("VA-MH QUERI","Y")
 Q
 ;
RUN(IEN,NEXT,MODE,PURGE) ;Process extract parameter
 ; IEN is ien of Extract Parameter
 ; NEXT is period to extract
 ; MODE = 0 is extract and transmission
 ; MODE = 1 is extract only
 ; MODE = 2 is manual extract and transmission (doesn't update 810.2)
 ; MODE = 3 is manual extract only (doesn't update 810.2)
 ;
 N CLASS,FDA,FDAIEN,MSG
 N PXRMIDOD,PXRMLIST,PXRMNODE,PXRMRULE,PXRMSTRT,PXRMXIEN,PATCREAT,XNAME
 N ITER
 ;Initialise
 K ^TMP("PXRMETX",$J),^TMP("PXRMETX1",$J)
 ;Workfile node for ^TMP
 S PXRMNODE="PXRMRULE"
 ;Get details from parameter file
 N DATA,INDP,INTP,LIST,NAME,PARTYPE,PERIOD,SNAME,TEXT,YEAR
 ;Get class from extract parameter
 S CLASS=$P($G(^PXRM(810.2,IEN,100)),U)
 ;Otherwise default to local
 I $G(CLASS)="" S CLASS="L"
 ;
 S DATA=$G(^PXRM(810.2,IEN,0))
 ;Determine Extract Name and period
 S NAME=$P(DATA,U),PARTYPE=$P(DATA,U,2)
 S YEAR=$P(NEXT,"/",2),PERIOD=$P(NEXT,"/")
 ;Calculate report period start and end dates
 D CALC^PXRMEUT(NEXT,.PXRMSTRT,.PXRMSTOP)
 ;Determine output name for patient list and extract summary
 S XNAME=NAME_" "_YEAR_" "_PERIOD
 S NAME=$$GETNAME(XNAME)
 S ITER=$P(NAME,"/",2)
 ;Process (single) Denominator rule into patient list
 N SEQ,SUB
 S SEQ=""
 F  S SEQ=$O(^PXRM(810.2,IEN,10,"B",SEQ)) Q:'SEQ  D
 .S SUB=$O(^PXRM(810.2,IEN,10,"B",SEQ,"")) Q:'SUB
 .S DATA=$G(^PXRM(810.2,IEN,10,SUB,0)) Q:DATA=""
 .S PXRMRULE=$P(DATA,U,2) Q:'PXRMRULE
 .S LIST=$P(DATA,U,3) Q:LIST=""
 .I LIST["yyyy" S LIST=$P(LIST,"yyyy")_YEAR_$P(LIST,"yyyy",2)
 .I LIST["nn" S LIST=$P(LIST,"nn")_$E(PERIOD,2,10)_$P(LIST,"nn",2)
 .S INDP=+$P(DATA,U,4)
 .S INTP=+$P(DATA,U,5)
 .;Create new patient list
 .I ITER'="" S LIST=LIST_"/"_ITER
 .S PATCREAT="Y",PXRMLIST=$$CRLST^PXRMRUL1(LIST,CLASS) Q:'PXRMLIST
 .;
 .D START^PXRMRULE(PXRMRULE,PXRMLIST,PXRMNODE,PXRMSTRT,PXRMSTOP,IEN,YEAR,PERIOD,INDP,INTP,ITER)
 .;Clear ^TMP lists created for rule
 .D CLEAR^PXRMRULE(PXRMRULE,PXRMNODE)
 .;Process reminders and finding rules
 .;If include deceased patients is true then set the flag so reminders
 .;will be evaluated for deceased patients.
 .S PXRMIDOD=$S(INDP:1,1:0)
 .D REM^PXRMETXR(SUB,PXRMLIST,PXRMSTRT,PXRMSTOP,PARTYPE)
 ;
 ;Get the name
 ;S NAME=$$GETNAME(XNAME)
 ;Create extract summary entry
 S FDA(810.3,"+1,",.01)=NAME
 S FDA(810.3,"+1,",.02)=PXRMSTRT
 S FDA(810.3,"+1,",.03)=PXRMSTOP
 S FDA(810.3,"+1,",.06)=$$NOW^XLFDT
 S FDA(810.3,"+1,",1)=IEN
 S FDA(810.3,"+1,",2)=PARTYPE
 S FDA(810.3,"+1,",3)=$E(PERIOD,2,99)
 S FDA(810.3,"+1,",4)=YEAR
 S FDA(810.3,"+1,",5)=$S(MODE<2:"A",1:"M")
 S FDA(810.3,"+1,",7)=$E(PERIOD)
 I PURGE="Y" S FDA(810.3,"+1,",50)=1
 S FDA(810.3,"+1,",100)=CLASS
 D UPDATE^DIE("","FDA","FDAIEN","MSG")
 I $D(MSG) D AWRITE^PXRMUTIL("MSG") G EXIT
 ;
 ;Update extract summary from ^TMP
 D UPDEX(FDAIEN(1))
 ;
 ;Transmit results
 I (MODE=0)!(MODE=2) D TRANS(FDAIEN(1))
 ;
 ;Update extract parameters
 I MODE<2 D UPDPAR
 ;
 ;Mail message that extract completed
 D MAIL(NAME,NEXT,MODE)
 ;
EXIT ;Clear workfile
 K ^TMP("PXRMETX",$J),^TMP("PXRMETX1",$J)
 Q
 ;
TRANS(PXRMXIEN) ;Transmit HL7 messages
 N HL7ID,NAME,NEXT
 S HL7ID=""
 D HL7^PXRM7API(PXRMXIEN,1,.HL7ID)
 H 2
 ;Lock extract summary
 D LOCK(PXRMXIEN) Q:$D(DUOUT)
 ;Update run information
 S NAME=$P($G(^PXRMXT(810.3,PXRMXIEN,0)),U)
 S NEXT=$P($G(^PXRMXT(810.3,PXRMXIEN,4)),U,3)
 S FDA(810.3,"?1,",.01)=NAME
 S FDA(810.36,"?+2,?1,",.01)=HL7ID
 S FDA(810.36,"?+2,?1,",.02)=$$NOW^XLFDT
 D UPDATE^DIE("","FDA","","MSG")
 ;Unlock extract summary
 D UNLOCK(PXRMXIEN)
 Q
 ;
UPDEX(IEN) ;Update extract summary
 N DUOUT
 ;Lock extract summary
 D LOCK(IEN) Q:$D(DUOUT)
 ;
 ;Update totals section
 N APPL,CNT,DFN,DUE,DATA,ETYP,EVAL
 N FAPPL,FCNT,FDATA,FDUE,FEVAL,FGNAM,FGSTA,FIND,FNAPPL,FNDUE,FSEQ
 N GDATA,GSEQ,INST,NAPPL,NDUE,PCNT,PXRMLIST,RCNT,RIEN,RSEQ,SEQ,TEMP
 S SEQ="",CNT=1,RSEQ=0
 F  S SEQ=$O(^TMP("PXRMETX",$J,SEQ)) Q:SEQ=""  D
 .S INST=0
 .F  S INST=$O(^TMP("PXRMETX",$J,SEQ,INST)) Q:'INST  D
 ..S RCNT=""
 ..F  S RCNT=$O(^TMP("PXRMETX",$J,SEQ,INST,RCNT)) Q:RCNT=""  D
 ...S DATA=$G(^TMP("PXRMETX",$J,SEQ,INST,RCNT)) Q:'DATA
 ...S RIEN=$P(DATA,U,1),EVAL=$P(DATA,U,2),APPL=$P(DATA,U,3)
 ...S NAPPL=$P(DATA,U,4),DUE=$P(DATA,U,5),NDUE=$P(DATA,U,6)
 ...S PXRMLIST=$P(DATA,U,7)
 ...S CNT=CNT+1,RSEQ=RSEQ+1
 ...S TEMP=$$RJ^XLFSTR(RSEQ,3,0)_U_RIEN_U_INST_U_PXRMLIST_U_EVAL_U_APPL_U_NAPPL_U_DUE_U_NDUE
 ...S ^PXRMXT(810.3,IEN,3,RSEQ,0)=TEMP
 ...S ^PXRMXT(810.3,IEN,3,"B",$P(TEMP,U,1),RSEQ)=""
 ...;For each count type
 ...S GSEQ="",FCNT=0
 ...F  S GSEQ=$O(^TMP("PXRMETX1",$J,SEQ,RCNT,GSEQ)) Q:GSEQ=""  D
 ....S GDATA=$G(^TMP("PXRMETX1",$J,SEQ,RCNT,GSEQ))
 ....S FGNAM=$P(GDATA,U),ETYP=$P(GDATA,U,2),FGSTA=$P(GDATA,U,3)
 ....;For each term
 ....S FSEQ=0
 ....F  S FSEQ=$O(^TMP("PXRMETX1",$J,SEQ,RCNT,GSEQ,FSEQ)) Q:FSEQ=""  D
 .....;Get the term ien
 .....S FIND=$P($G(^TMP("PXRMETX1",$J,SEQ,RCNT,GSEQ,FSEQ)),U),FCNT=FCNT+1
 .....;Update finding totals
 .....S FDATA=$G(^TMP("PXRMETX",$J,SEQ,INST,RCNT,GSEQ,FSEQ))
 .....S FEVAL=$P(FDATA,U,2),FAPPL=$P(FDATA,U,3),FNAPPL=$P(FDATA,U,4)
 .....S FDUE=$P(FDATA,U,5),FNDUE=$P(FDATA,U,6)
 .....S TEMP=FSEQ_U_$P(FIND,";")_U_ETYP_U_FEVAL_U_FAPPL_U_FNAPPL_U_FDUE_U_FNDUE_U_FGNAM_U_FGSTA
 .....S ^PXRMXT(810.3,IEN,3,RSEQ,1,FCNT,0)=TEMP
 .....;
 .....;AGP REMOVE UNTIL A DECISION CAN BE MADE
 .....;S DFN=0,PCNT=0
 .....;F  S DFN=$O(^TMP("PXRMETX",$J,SEQ,INST,RCNT,GSEQ,FSEQ,DFN)) Q:DFN'>0  D
 .....;.S PCNT=PCNT+1,^PXRMXT(810.3,IEN,3,RSEQ,1,FCNT,1,PCNT,0)=DFN
 .....;I PCNT>0 S ^PXRMXT(810.3,IEN,3,RSEQ,1,FCNT,1,0)="^810.3316PA"_U_PCNT_U_PCNT
 ....I FCNT>0 S ^PXRMXT(810.3,IEN,3,RSEQ,1,0)="^810.331I"_U_FCNT_U_FCNT
 .I RSEQ>0 S ^PXRMXT(810.3,IEN,3,0)="^810.33I"_U_RSEQ_U_RSEQ
 ;Unlock extract summary
 D UNLOCK(IEN)
 Q
 ;
 ;File locking
LOCK(PXRMXIEN) L +^PXRMXT(810.3,PXRMXIEN):0
 I '$T W !!?5,"Another user is using this extract summary" S DUOUT=1
 Q
 ;
UNLOCK(PXRMXIEN) L -^PXRMXT(810.3,PXRMXIEN) Q
 ;
UPDPAR ;Update parameters when run complete
 N DATA,LAST,NEXT,PERIOD,TYPE,YEAR
 S DATA=$G(^PXRM(810.2,IEN,0)),NEXT=$P(DATA,U,6),TYPE=$P(DATA,U,3)
 ;Last run updated
 S LAST=NEXT
 ;Calculate next run
 I TYPE="Y" S NEXT=NEXT+1
 I "QM"[TYPE D
 .N NUM
 .S PERIOD=$P(NEXT,"/",1),YEAR=$P(NEXT,"/",2)
 .S NUM=$P(PERIOD,TYPE,2)+1
 .I TYPE="Q",NUM>4 S NUM=1,YEAR=YEAR+1
 .I TYPE="M",NUM>12 S NUM=1,YEAR=YEAR+1
 .S NEXT=TYPE_NUM_"/"_YEAR
 ;Update last and next run fields
 S $P(^PXRM(810.2,IEN,0),U,4,6)=LAST_U_$$NOW^XLFDT_U_NEXT
 Q
 ;
