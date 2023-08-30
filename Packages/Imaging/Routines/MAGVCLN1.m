MAGVCLN1 ;WOIFO/DAC - File 2005.6X Duplicate Removal Utility ; Feb 22, 2022@21:12:01
 ;;3.0;IMAGING;**278**;Mar 19, 2002;Build 138
 ;; Per VA Directive 6402, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
MSG(DELETE,MAGQ) ; Display intro message
 N DIR,DELOPT,IDOPT,Y
 S DELOPT="Resolve HDIG Problem Records [MAGV RESOLVE PROBLEMS]"
 S IDOPT="Search For HDIG Problem Records [MAGV SEARCH PROBLEMS]"
 W !!
 S DIR("A",1)="This option will "_$S($G(DELETE):"set as INACCESSIBLE",1:"identify")_" records from 2005.6x Imaging files that"
 S DIR("A",2)="meet either of the following conditions:"
 S DIR("A",3)=""
 S DIR("A",4)="  1) Duplicate records containing the same key field (.01) value."
 S DIR("A",5)="  2) Records with a missing or invalid pointer to its parent record."
 S DIR("A",6)=""
 S DIR("A",7)="The "_$S($G(DELETE):"records marked INACCESSIBLE",1:"identified records")_" will be displayed to the selected output device,"
 S DIR("A",8)="and also captured in the NEW IMAGING FILE CLEANUP LOG file (#2005.67)."
 S DIR("A",9)=""
 S DIR("A",10)="To "_$S($G(DELETE):"identify the records without modifying them, please use the option",1:"mark records INACCESSIBLE after they've been identified, please use option")
 S DIR("A",11)=$S($G(DELETE):IDOPT,1:DELOPT)_"."
 S DIR("A",12)=""
 S DIR("A")="Would you like to continue "_$S($G(DELETE):"marking the problem records INACCESSIBLE",1:"identifying the problem records")
 S DIR("B")="N",DIR(0)="Y" D ^DIR
 S MAGQ=$S($G(Y):0,1:1)
 Q
 ;
DEVICE(DELETE,MAGQUIT,MAGQUE,MAGSCR) ; Request Device Information
 N %ZIS,IOP,ZTSK,ZTRTN,ZTIO,ZTDESC,ZTSAVE,POP,RTN,VAR
 K IO("Q")
 S %ZIS="QM"
 S (MAGQUE,MAGQUIT)=0
 W ! D ^%ZIS
 I POP S MAGQUIT=1 Q
 S MAGSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 I $D(IO("Q")) D  S MAGQUE=1
 . S RTN=$P($T(+1)," ",1)
 . S ZTRTN="IDDEL^"_RTN_"(DELETE)"
 . S ZTIO=ION
 . S ZTSAVE("MAG**")=""
 . S ZTSAVE("DELETE")=""
 . S ZTDESC="IMAGING DATABASE CLEANUP"
 . D ^%ZTLOAD
 . W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 U IO
 Q
CONT ; Continue
 W ! K DIR("A") S DIR(0)="E" D ^DIR K DIR
 Q
 ;
GETP(FILE,IEN) ; Get Patient Reference from File entry
 N PTR1,PTR2
 I '$G(FILE)!'$G(IEN) Q ""
 I FILE=2005.6 Q $P($G(^MAGV(2005.6,+IEN,0)),"^")
 I FILE=2005.61 Q $$GETP61(IEN)
 I FILE=2005.62 Q $$GETP62(IEN)
 I FILE=2005.63 Q $$GETP63(IEN)
 I FILE=2005.64 Q $$GETP64(IEN)
 I FILE=2005.65 Q $$GETP65(IEN)
 Q ""
 ;
GETP61(IEN) ;  Get Patient Reference from file 2005.61
 N PTR6
 S PTR6=$P($G(^MAGV(2005.61,+$G(IEN),6)),"^")
 Q $P($G(^MAGV(2005.6,+PTR6,0)),"^")
 ;
GETP62(IEN) ;  Get Patient Reference from file 2005.62
 N PTR6
 S PTR6=$P($G(^MAGV(2005.62,+$G(IEN),6)),"^",3)
 Q:PTR6=""!(PTR6'=+PTR6) ""
 Q $P($G(^MAGV(2005.6,PTR6,0)),"^")
 ;
GETP63(IEN) ; Get Patient Reference from file 2005.63
 N PTR62
 S PTR62=$P($G(^MAGV(2005.63,+$G(IEN),6)),"^")
 Q $$GETP62(PTR62)
 ;
GETP64(IEN) ; Get Patient Reference from file 2005.64
 N PTR63
 S PTR63=$P($G(^MAGV(2005.64,+$G(IEN),6)),"^")
 Q $$GETP63(PTR63)
 ;
GETP65(IEN) ; Get Patient Reference from file 2005.64
 N PTR64
 S PTR64=$P($G(^MAGV(2005.65,+$G(IEN),6)),"^")
 Q $$GETP64(PTR64)
 ;
TMPMSG(DELETE)  ; Send MailMan LOG REPORT
 N XMSUB,XMDUZ,MAGXMD,XMY
 S MAGXMD="MAGVCLN"
 S XMSUB=$S($G(DELETE):"Resolve",1:"Search")_" Imaging Problem Records "_$$FMTE^XLFDT(DT,"5DZ"),XMDUZ=$S($G(DUZ):DUZ,1:.5)
 S XMY(XMDUZ)="",XMY("G.MAG SERVER")=""
 N DIFROM S XMTEXT="^TMP("""_MAGXMD_""","_$J_"," D ^XMD K DIFROM
 K XMTEXT
 Q
 ;
MSGHDR(MAGLICNT,DELETE) ; Output header for Mailman - when run silently (as in post-install)
 S ^TMP("MAGVCLN",$J,+$G(MAGLICNT))="            MAGV "_$S($G(DELETE):"RESOLVE PROBLEM RECORDS",1:"SEARCH FOR PROBLEM RECORDS"),MAGLICNT=MAGLICNT+1
 S ^TMP("MAGVCLN",$J,MAGLICNT)="   Problem records in files 2005.6x "_$S($G(DELETE):"resolved ",1:"identified ")_"by the MAG*3.0*278",MAGLICNT=MAGLICNT+1
 S ^TMP("MAGVCLN",$J,MAGLICNT)="   post-installation process are displayed below.",MAGLICNT=MAGLICNT+1
 S ^TMP("MAGVCLN",$J,MAGLICNT)="",MAGLICNT=MAGLICNT+1
 S ^TMP("MAGVCLN",$J,MAGLICNT)="Non-Primary "
 Q
 ;
OUTPUT(TEXT,MAGBLF,MAGALF,MAGPOST) ; Output a line of TEXT
 ; TEXT= Line of text
 ; MAGBLF = Number of 'before' line feeds
 ; MAGALF = Number of 'after' line feeds
 ; MAGPOST = Called as post-install routine, output mailed to DUZ
 ;
 N MAGMAXLF,MAGDONE,MAGCNT
 S MAGDONE=0,MAGCNT=0
 S MAGMAXLF=10  ; Max number of line feeds
 I $G(MAGBLF)>0 D
 . F MAGCNT=1:1:MAGBLF Q:$G(MAGDONE)  D
 . . I MAGCNT>MAGMAXLF S MAGDONE=1 Q
 . . I '$G(MAGPOST) W !
 . . I $G(MAGPOST) S ^TMP("MAGVCLN",$J,+$G(MAGLICNT))="",MAGLICNT=$G(MAGLICNT)+1
 I '$G(MAGPOST) W !,TEXT
 I $G(MAGPOST) S ^TMP("MAGVCLN",$J,+$G(MAGLICNT))=TEXT,MAGLICNT=$G(MAGLICNT)+1
 S MAGDONE=0
 I $G(MAGALF)>0 D
 . F MAGCNT=1:1:MAGBLF Q:$G(MAGDONE)  D
 . . I MAGCNT>MAGMAXLF S MAGDONE=1 Q
 . . I '$G(MAGPOST) W !
 . . I $G(MAGPOST) S ^TMP("MAGVCLN",$J,+$G(MAGLICNT))="",MAGLICNT=$G(MAGLICNT)+1
 ;
 Q
AUDIT(KEY,FILE,IEN,ORIGIEN,REASON,ACTION,DELIEN,ORIGAOF,DUPEIEN) ; Audit File for Problem Records?
 N MAGFDA,MAGMSG,LOGIEN,LOGFIEN
 Q:KEY=""
 Q:IEN=""
 S ACTION=$S($G(ACTION)="MI":"MI",$G(ACTION)="MC":"MC",$G(ACTION):"SI",1:"I")
 ;
 K MAGFDA,MAGMSG
 S MAGFDA(2005.67,"+1,",.01)=IEN
 S MAGFDA(2005.67,"+1,",1)=FILE
 S MAGFDA(2005.67,"+1,",2)=$G(ORIGIEN)
 S MAGFDA(2005.67,"+1,",3)=REASON
 S MAGFDA(2005.67,"+1,",4)=ACTION
 S MAGFDA(2005.67,"+1,",5)=$$NOW^XLFDT
 S MAGFDA(2005.67,"+1,",6)=KEY
 I $L($G(DELIEN)) S MAGFDA(2005.67,"+1,",7)=$G(DELIEN)
 I $L($G(ORIGAOF)) S MAGFDA(2005.67,"+1,",8)=ORIGAOF
 I $L($G(ORIGAOF)) S MAGFDA(2005.67,"+1,",9)=DUPEIEN
 ;
 ; Reason Codes:
 ; 1 - Duplicate
 ; 2 - No Parent Record Pointer
 ; 3 - Invalid Parent Record Pointer
 ; 4 - No Patient Ref Pointer
 ; 5 - Invalid Patient Ref Pointer
 ; 6 - Duplicate Parent Reference
 ;
 D UPDATE^DIE("","MAGFDA","","MAGMSG")
 K MAGFDA
 Q
 ;
PATNAME(FILE,IEN) ; Get patient name from 2005.6x file
 N PATIEN,PATNAME,MAGPATID,MAGPATIEN
 I FILE'["2005.6" Q "UNKNOWN"
 S MAGPATID=$$GETP^MAGVCLN1(FILE,IEN)
 I 'MAGPATID Q "UNKNOWN"
 S MAGPATIEN=$O(^MAGV(2005.6,"B",MAGPATID,0))
 I 'MAGPATIEN Q "UNKNOWN"
 S PATNAME=$$GET1^DIQ(2005.6,MAGPATIEN_",",3)
 S:'$L(PATNAME) PATNAME="UNKNOWN"
 Q PATNAME
 ;
PATMAGID(FILE,IEN) ; Get ENTERPRISE PATIENT ID file (#2005.6) ID 
 N PATIEN,PATNAME,MAGPATID,MAGPATIEN
 I FILE'["2005.6" Q "UNKNOWN"
 S MAGPATID=$$GETP^MAGVCLN1(FILE,IEN)
 I 'MAGPATID Q "UNKNOWN"
 Q MAGPATID
