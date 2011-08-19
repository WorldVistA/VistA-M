DGSRVICE ;SLC/PKR - Routines for setting service indexes. ;01/13/2006
 ;;5.3;Registration;**690**;Aug 13, 1993
 ;===============================================================
CSERVDI(DFN,EDATE,SEPDATE,TYPE) ;
 I EDATE="",SEPDATE="" Q
 I EDATE="" S EDATE="U"_DFN
 I SEPDATE="" S SEPDATE="U"_DFN
 I '$D(^DPT("ASERVICE",SEPDATE,EDATE,DFN,TYPE)) S ^TMP($J,"ASERVICE",DFN,TYPE)=EDATE_U_SEPDATE
 Q
 ;
 ;===============================================================
CSERVDG(DFN,EDATE,SEPDATE,TYPE) ;
 N NOMATCH,TEMP
 S TEMP=$G(^DPT(DFN,.32))
 S NOMATCH=0
 I EDATE["U" S EDATE=""
 I SEPDATE["U" S SEPDATE=""
 I TYPE="LAST" S NOMATCH=$S(EDATE'=$P(TEMP,U,6):1,SEPDATE'=$P(TEMP,U,7):1,1:0)
 I TYPE="NTL" S NOMATCH=$S(EDATE'=$P(TEMP,U,11):1,SEPDATE'=$P(TEMP,U,12):1,1:0)
 I TYPE="NNTL" S NOMATCH=$S(EDATE'=$P(TEMP,U,16):1,SEPDATE'=$P(TEMP,U,17):1,1:0)
 I NOMATCH S ^TMP($J,"ASERVICE",DFN,TYPE)=EDATE_U_SEPDATE
 Q
 ;
 ;===============================================================
KSERV(X,DA,TYPE) ;Delete index for service data.
 I X(1)="",X(2)="" Q
 N ENTRY,SEP
 S ENTRY=$S(X(1)'="":X(1),1:"U"_DA)
 S SEP=$S(X(2)'="":X(2),1:"U"_DA)
 K ^DPT("ASERVICE",SEP,ENTRY,DA,TYPE)
 Q
 ;
 ;===============================================================
PPTYPEM ;Print the patient type index mismatches
 N DFN,PTYPE
 S DFN=0
 F  S DFN=$O(^TMP($J,"PTYPE",DFN)) Q:DFN=""  D
 . S PTYPE=^TMP($J,"PTYPE",DFN)
 . W !,"DFN=",DFN," PATIENT TYPE=",PTYPE
 Q
 ;
 ;===============================================================
PSERVM ;Print the service date index mismatches
 N DFN,TEMP,TYPE
 S DFN=0
 F  S DFN=$O(^TMP($J,"ASERVICE",DFN)) Q:DFN=""  D
 . S TYPE=""
 . F  S TYPE=$O(^TMP($J,"ASERVICE",DFN,TYPE)) Q:TYPE=""  D
 .. S TEMP=^TMP($J,"ASERVICE",DFN,TYPE)
 .. W !,"DFN=",DFN," TYPE=",TYPE," Entry date=",$P(TEMP,U,1)," Separation date=",$P(TEMP,U,2)
 Q
 ;
 ;===============================================================
SSERV(X,DA,TYPE) ;Set index for service data.
 ;X(1)=SERVICE ENTRY DATE
 ;X(2)=SERVICE SEPARATION DATE
 I X(1)="",X(2)="" Q
 N ENTRY,SEP
 S ENTRY=$S(X(1)'="":X(1),1:"U"_DA)
 S SEP=$S(X(2)'="":X(2),1:"U"_DA)
 S ^DPT("ASERVICE",SEP,ENTRY,DA,TYPE)=""
 Q
 ;
 ;===============================================================
VERIFY ;Check to make sure the indexes and global are in agreement.
 N DFN,EDATE,NOPROB,PTYPE,SEPDATE,TEMP,TYPE
 W !,$$FMTE^XLFDT($$NOW^XLFDT,"5Z")," Starting index verification.",!
 S NOPROB=1
 K ^TMP($J,"ASERVICE"),^TMP($J,"PTYPE")
 ;Go through the global.
 S DFN=0
 F  S DFN=+$O(^DPT(DFN)) Q:DFN=0  D
 . S PTYPE=$G(^DPT(DFN,"TYPE"))
 . I PTYPE'="",'$D(^DPT("APTYPE",PTYPE,DFN)) S ^TMP($J,"PTYPE",DFN)=PTYPE
 . S TEMP=$G(^DPT(DFN,.32))
 . I TEMP="" Q
 . S EDATE=$P(TEMP,U,6),SEPDATE=$P(TEMP,U,7) D CSERVDI(DFN,EDATE,SEPDATE,"LAST")
 . S EDATE=$P(TEMP,U,11),SEPDATE=$P(TEMP,U,12) D CSERVDI(DFN,EDATE,SEPDATE,"NTL")
 . S EDATE=$P(TEMP,U,16),SEPDATE=$P(TEMP,U,17) D CSERVDI(DFN,EDATE,SEPDATE,"NNTL")
 I $D(^TMP($J,"ASERVICE")) D
 . S NOPROB=0
 . W !,"The following global entries do not have a matching service date index entry:"
 . D PSERVM
 ;Go through the index.
 K ^TMP($J,"ASERVICE")
 S SEPDATE=0
 F  S SEPDATE=$O(^DPT("ASERVICE",SEPDATE)) Q:SEPDATE=""  D
 . S EDATE=0
 . F  S EDATE=$O(^DPT("ASERVICE",SEPDATE,EDATE)) Q:EDATE=""  D
 .. S DFN=0
 .. F  S DFN=$O(^DPT("ASERVICE",SEPDATE,EDATE,DFN)) Q:DFN=""  D
 ... S TYPE=""
 ... F  S TYPE=$O(^DPT("ASERVICE",SEPDATE,EDATE,DFN,TYPE)) Q:TYPE=""  D
 .... D CSERVDG(DFN,EDATE,SEPDATE,TYPE)
 I $D(^TMP($J,"ASERVICE")) D
 . S NOPROB=0
 . W !!,"The following service date index entries do not have a corresponding global entry:"
 . D PSERVM
 K ^TMP($J,"ASERVICE")
 I NOPROB W !,"No problems were found with the service dates index."
 ;
 ;Check the patient type index.
 S NOPROB=1
 I $D(^TMP($J,"PTYPE")) D
 . S NOPROB=0
 . W !!,"The following global entries do not have a matching patient type index entry:"
 . D PPTYPEM
 K ^TMP($J,"PTYPE")
 ;Go through the patient type index.
 S TYPE=""
 F  S TYPE=$O(^DPT("APTYPE",TYPE)) Q:TYPE=""  D
 . S DFN=0
 . F  S DFN=$O(^DPT("APTYPE",TYPE,DFN)) Q:DFN=""  D
 .. I TYPE'=$G(^DPT(DFN,"TYPE")) S ^TMP($J,"PTYPE",DFN)=TYPE
 I $D(^TMP($J,"PTYPE")) D
 . S NOPROB=0
 . W !!,"The following patient type index entries do not have a corresponding"
 . W !,"global entry:"
 . D PPTYPEM
 K ^TMP($J,"PTYPE")
 I NOPROB W !,"No problems were found with the patient type index."
 W !!,$$FMTE^XLFDT($$NOW^XLFDT,"5Z")," Index verification complete."
 Q
 ;
