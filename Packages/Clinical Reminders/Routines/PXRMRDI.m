PXRMRDI ; SLC/PKR - Routines to support RDI list building. ;11/02/2009
 ;;2.0;CLINICAL REMINDERS;**4,17**;Feb 04, 2005;Build 102
 ;=========================================================
APPERR(TYPE) ;Handle errors getting appointment data.
 N ECODE,MGIEN,MGROUP,NL,TIME,TO,USER
 S USER=$S($D(ZTQUEUED):DBDUZ,1:DUZ)
 S TIME=$$NOW^XLFDT
 S TIME=$$FMTE^XLFDT(TIME)
 K ^TMP("PXRMXMZ",$J)
 S ^TMP("PXRMXMZ",$J,1,0)="The "_TYPE_" requested by "_$$GET1^DIQ(200,USER,.01)_" on "
 S ^TMP("PXRMXMZ",$J,2,0)=TIME_" requires appointment data which could not be obtained"
 S ^TMP("PXRMXMZ",$J,3,0)="from the Scheduling database due to the following error(s):"
 S ECODE=0,NL=3
 F  S ECODE=$O(^TMP($J,"SDAMA301",ECODE)) Q:ECODE=""  D
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" "_^TMP($J,"SDAMA301",ECODE)
 S TO(USER)=""
 S MGIEN=$G(^PXRM(800,1,"MGFE"))
 I MGIEN'="" D
 . S MGROUP="G."_$$GET1^DIQ(3.8,MGIEN,.01)
 . S TO(MGROUP)=""
 D SEND^PXRMMSG("PXRMXMZ","Scheduling database error(s)",.TO)
 K ^TMP($J,"SDAMA301")
 Q
 ;
 ;=========================================================
APPL(NGET,BDT,EDT,PLIST,PARAM) ;List type computed finding that returns
 ;a list of patients with appointments in the date range BDT to EDT.
 N FILTER,FLDS,RESULT
 K ^TMP($J,PLIST),^TMP($J,"SDAMA301")
 I BDT<2000000 S BDT=2000101
 S FILTER(1)=BDT_";"_EDT
 S FILTER("SORT")="P"
 ;Set the rest of the filter nodes.
 D SFILTER(PARAM,.FILTER,.FLDS)
 ;DBIA #4433
 S RESULT=$$SDAPI^SDAMA301(.FILTER)
 I RESULT=-1 D APPERR("Patient List build") Q
 N COUNT,DATE,DFN,DONE,ITEM
 S DFN=""
 F  S DFN=$O(^TMP($J,"SDAMA301",DFN)) Q:DFN=""  D
 . S (COUNT,DONE)=0,DATE=""
 . F  S DATE=$O(^TMP($J,"SDAMA301",DFN,DATE),-1) Q:(DONE)!(DATE="")  D
 .. S COUNT=COUNT+1
 .. S ITEM=$P(^TMP($J,"SDAMA301",DFN,DATE),U,2)
 .. S ^TMP($J,PLIST,DFN,COUNT)=U_DATE_U_44_U_$P(ITEM,";",1)_U_$P(ITEM,";",2)
 .. I COUNT=NGET S DONE=1
 K ^TMP($J,"SDAMA301"),^TMP($J,"HLOCL")
 Q
 ;
 ;=========================================================
PAPPL(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,VALUE,TEXT) ;Multiple type computed
 ;finding that returns a list appointments for a patient.
 N FILTER,FLDS,PARAM,RESULT
 K ^TMP($J,"SDAMA301")
 S PARAM=TEST K TEST
 S NFOUND=0
 I BDT<2000000 S BDT=2000101
 S FILTER(1)=BDT_";"_EDT
 S FILTER(4)=DFN
 S FILTER("SORT")="P"
 ;Set the rest of the filter nodes.
 D SFILTER(PARAM,.FILTER,.FLDS)
 ;DBIA #4433
 S RESULT=$$SDAPI^SDAMA301(.FILTER)
 I RESULT=-1 D APPERR("Computed finding evaluation") Q
 N APPDATE,IND,DONE,IND,ITEM
 S APPDATE="",DONE=0
 F  S APPDATE=$O(^TMP($J,"SDAMA301",DFN,APPDATE),-1) Q:(DONE)!(APPDATE="")  D
 . S NFOUND=NFOUND+1
 . S TEST(NFOUND)=1,DATE(NFOUND)=APPDATE
 . S VALUE(NFOUND,"VALUE")=^TMP($J,"SDAMA301",DFN,APPDATE)
 . I NFOUND=NGET S DONE=1
 K ^TMP($J,"SDAMA301"),^TMP($J,"HLOCL")
 Q
 ;
 ;=========================================================
SFILTER(PARAM,FILTER,FLDS) ;Parse the PARMETER and set the appropriate
 ;fields.
 N IND,LL,P1,P2,STATUS,TEMP
 S (FLDS,LL,STATUS)=""
 F IND=1:1:$L(PARAM,U) D
 . S TEMP=$P(PARAM,U,IND)
 . S P1=$P(TEMP,":",1),P2=$P(TEMP,":",2)
 . I P1="FLDS" S FLDS=$TR(P2,",",";") Q
 . I P1="LL" S LL=P2 Q
 . I P1="STATUS" S STATUS=$TR(P2,",",";") Q
 S FILTER("FLDS")=$S(FLDS="":"1;2",1:FLDS)
 S FILTER(3)=$S(STATUS="":"I;R",1:STATUS)
 I LL="" Q
 S LL=$O(^PXRMD(810.9,"B",LL,""))
 D LOCLIST^PXRMLOCF(LL,"HLOCL")
 S FILTER(2)="^TMP($J,""HLOCL"","
 Q
 ;
 ;=========================================================
TFL(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,VALUE,TEXT) ;Multiple type computed
 ;finding for a patient's treating facility list.
 N DONE,IND,NOW,SDIR,TDATE,TFL,TFLD
 S NFOUND=0
 ;DBIA #2990
 D TFL^VAFCTFU1(.TFL,DFN)
 I +TFL(1)=-1 Q
 S NOW=$$NOW^PXRMDATE
 S (DONE,IND)=0
 F  S IND=$O(TFL(IND)) Q:(DONE)!(IND="")  D
 . S NFOUND=NFOUND+1
 . S TEST(NFOUND)=1,DATE(NFOUND)=NOW
 . S VALUE(NFOUND,"VALUE")=TFL(IND)
 . I NFOUND=NGET S DONE=1 Q
 F IND=1:1:NFOUND S VALUE(IND,"NUM FACILITIES")=NFOUND
 Q
 ;
