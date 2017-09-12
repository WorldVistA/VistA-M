MAGIPT20 ;Post init routine to queue site activity at install.
 ;;3.0;IMAGING;**20**;Apr 12, 2006
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed             |
 ;; | in any way.  Modifications to this software may result in an  |
 ;; | adulterated medical device under 21CFR820, the use of which   |
 ;; | is considered to be a violation of US Federal Statutes.       |
 ;; +---------------------------------------------------------------+
 ;;
POST ;
 N INDEX,INSTIEN,CON,AI,I
 S INSTIEN=$$KSP^XUPARAM("INST")
 I '$P($G(^MAG(2006.1,$O(^MAG(2006.1," "),-1),0)),U) D
 . S CON=0
 . D BMES^XPDUTL("Non-consolidated conversion, Queue file Clearing: "_$$FMTE^XLFDT($$NOW^XLFDT))
 . D CLRQ^MAGQBUT4
 . D BMES^XPDUTL("Non-consolidated conversion, PLACE setting: "_$$FMTE^XLFDT($$NOW^XLFDT))
 . D SETPL
 . D BMES^XPDUTL("Non-consolidated conversion, SITEID PROCESS: "_$$FMTE^XLFDT($$NOW^XLFDT))
 . D SITEID
 . Q
 E  S CON=1
 S INDEX=0 F  S INDEX=$O(^MAG(2006.1,INDEX)) Q:'INDEX  D  ;set Import security ON by default
 . I $P($G(^MAG(2006.1,INDEX,3)),U,12)'?1N S $P(^MAG(2006.1,INDEX,3),U,12)="1"
 D BMES^XPDUTL("Queue Pointer Update: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D CPUD^MAGQBUT4
 D BMES^XPDUTL("Workstation Session Place Indexing: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D WSUP(6)
 D REMTASK^MAGQE4
 D STTASK^MAGQE4
 D POSTI^MAGQBUT
 D BMES^XPDUTL("Site Parameter PLACE Indexing: "_$$FMTE^XLFDT($$NOW^XLFDT))
 S ^MAG(2006.1,"CONSOLIDATED")="YES"
 S INDEX="A" K ^MAG(2006.1,INDEX)
 F  S INDEX=$O(^MAG(2006.1,INDEX)) Q:($E(INDEX,1)'="A")  I INDEX'="AC",INDEX'="AD" K ^MAG(2006.1,INDEX)
 D BMES^XPDUTL("Updating MAG WINDOWS: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D ADDRPC^MAGQBUT4("MAGQ COQ","MAG WINDOWS")
 D ADDRPC^MAGQBUT4("MAGQ QCNT","MAG WINDOWS")
 D ADDRPC^MAGQBUT4("XUS GET TOKEN","MAG WINDOWS")
 D ADDRPC^MAGQBUT4("XWB GET VARIABLE VALUE","MAG WINDOWS")
 D BMES^XPDUTL("Image and Queue file Indexing: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INDEX
 D BMES^XPDUTL("Medical Division Evaluation: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D AI^MAGQBUT5(.AI)
 S I="" F  S I=$O(AI(I)) Q:I=""  D BMES^XPDUTL(AI(I))
 D BMES^XPDUTL("If there are Medical Divisions that have no Imaging Site parameter")
 D BMES^XPDUTL("affiliations you will want to setup Associated Institutions using the")
 D BMES^XPDUTL("site parameter window on the Background Processor.")
 K AI
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 D BMES^XPDUTL("Install complete: "_$$FMTE^XLFDT($$NOW^XLFDT))
 Q
INDEX ; Re-index actually (2006.03 & 2006.031 Are rebuilt during the conversion)
 N IEN,FILE,CNT,IENA,TMPACQ,TINSTIEN,ERRCNT,I,IEN,INSTDA,SAVE,SITEARAY,SITEDA
 N STATION,GIC,NLC,NSC,MESSAGE,GL,NMSP,GRPOBJ,VALUE,DIC,X,Y,LIMIT,CHANGE,TMP,FNUM
 S (ERRCNT,IEN,CNT,GIC,NLC,NSC,CHANGE)=0,NMSP=""
 S DIC=4.3,X=^XMB("NETNAME")
 D ^DIC K DIC
 S:+Y LIMIT=+$$GET1^DIQ(4.3,+Y,16.1,"","RP","")
 S LIMIT=$S(LIMIT:LIMIT,1:2000)
 D STATION
 D NMSP^MAGQBUT4(.NMSP)
 S GL=""
 F  D SCAN^MAGQBPG1(.IEN,"F",.GL) D  Q:'IEN
 . Q:'IEN
 . S CNT=CNT+1
 . S FNUM=$S(GL[2005.1:2005.1,GL[2005:2005,1:"")
 . S GRPOBJ=0
 . I (CNT#1000)=0 W "."
 . I (CNT#80000)=0 W !
 . S TMPACQ=$P($G(^MAG(FNUM,IEN,100)),U,3)
 . I (TMPACQ'=""),$D(SITEARAY(TMPACQ)) S TINSTIEN=TMPACQ
 . E  S TINSTIEN=$S('CON:INSTIEN,TMPACQ=INSTIEN:TMPACQ,1:$$GI(TMPACQ,INSTIEN,GL,IEN,FNUM))
 . I TINSTIEN="" D
 . . D DFNIQ^MAGQBPG1("","Invalid Acquisition Site for image: "_IEN_" the value in question is: "_TMPACQ,0)
 . . S ERRCNT=ERRCNT+1
 . . I (ERRCNT+1)>LIMIT D 
 . . . D DFNIQ^MAGQBPG1("Post Install error in Acquisition Site Validation","",1)
 . . . S ERRCNT=0 Q
 . E  D
 . . I TMPACQ'=TINSTIEN S $P(^MAG(FNUM,IEN,100),U,3)=TINSTIEN
 . . S:(FNUM=2005) ^MAG(2005,"D",TINSTIEN,IEN)=""
 . . Q
 . I CON,TINSTIEN'="",TMPACQ'=TINSTIEN S ^TMP($J,"CHANGE_IEN",CHANGE+1)=TMPACQ_U_TINSTIEN_U_IEN,CHANGE=CHANGE+1
 . S FILE=$P($G(^MAG(FNUM,IEN,0)),U,2) Q:'$D(FILE)  Q:$L(FILE)<9
 . S FILE=$P(FILE,".")
 . K ^MAG(FNUM,"F",$E(FILE,1,30),IEN),^MAG(FNUM,"f",$E(FILE,1,30),IEN)
 . S ^MAG(FNUM,"F",$E(FILE,1,30),IEN)=""
 . Q
 I ERRCNT>0 D DFNIQ^MAGQBPG1("Post Install error in Acquisition Site Validation","",1)
 I CHANGE>0 D ACQUD^MAGQBUT4(LIMIT)
 K NMSP,SITEARAY,STATION
 K ^MAG(2005.2,"B"),^MAG(2005.2,"C"),^MAG(2005.2,"D"),^MAG(2005.2,"E"),^MAG(2005.2,"F")
 K ^MAG(2005.2,"AC")
 S DIK="^MAG(2005.2," D IXALL^DIK
 K ^MAG(2006.1,"B"),^MAG(2006.1,"AC"),^MAG(2006.1,"AD")
 S DIK="^MAG(2006.1," D IXALL^DIK
 K ^MAG(2006.8,"C"),^MAG(2006.8,"D"),^MAG(2006.8,"B"),^MAG(2006.8,"E")
 S DIK="^MAG(2006.8," D IXALL^DIK
 K ^MAGQUEUE(2006.03,"B"),^MAGQUEUE(2006.03,"C"),^MAGQUEUE(2006.03,"D"),^MAGQUEUE(2006.03,"E"),^MAGQUEUE(2006.03,"F")
 S DIK="^MAGQUEUE(2006.03," D IXALL^DIK
 K ^MAGQUEUE(2006.031,"B"),^MAGQUEUE(2006.031,"C")
 S DIK="^MAGQUEUE(2006.031," D IXALL^DIK
 K ^MAGQUEUE(2006.032,"B"),^MAGQUEUE(2006.032,"C")
 S DIK="^MAGQUEUE(2006.032," D IXALL^DIK
 K DIK
 I GIC>1 D
 . S MESSAGE="It was necessary to attempt to recover the Acquisition site for this install"
 . D BMES^XPDUTL(MESSAGE)
 . S MESSAGE="using the following methods: "
 . D BMES^XPDUTL(MESSAGE)
 . S MESSAGE="$$GI: "_GIC_", this is the 'get institution' method, "
 . D BMES^XPDUTL(MESSAGE)
 . S MESSAGE="using the Institution file 'D' cross-reference."
 . D BMES^XPDUTL(MESSAGE)
 . S MESSAGE="$$CNL: "_NLC_", this is the 'network location file lookup method' for this image."
 . D BMES^XPDUTL(MESSAGE)
 . S MESSAGE="$$CNSP: "_NSC_", this is the 'image file namespace' method."
 . D BMES^XPDUTL(MESSAGE)
 . Q
 Q
GI(TMPACQ,INSTIEN,GL,IEN,FNUM) ;      Get institution
 N TMPI
 S VALUE=""
 S GIC=GIC+1
 I TMPACQ'="",$D(STATION("PROBLEM",TMPACQ)) S TMPACQ=""
 I TMPACQ'="" D  Q:VALUE VALUE
 . S TMPI=$O(STATION("STATION",TMPACQ,""))
 . S VALUE=$S(TMPI="":"",$D(SITEARAY(TMPI)):TMPI,1:"")
 . Q
 I GRPOBJ=0&($D(^MAG(FNUM,IEN,1,0))) D  Q VALUE
 . NEW IENX,IENY
 . S IENX=$O(^MAG(FNUM,IEN,1,0))
 . I IENX="" Q
 . S GRPOBJ=1
 . S IENY=$P(^MAG(FNUM,IEN,1,IENX,0),U)
 . S TMPACQ=$P($G(^MAG(FNUM,IENY,100)),U,3)
 . I (TMPACQ'=""),$D(SITEARAY(TMPACQ)) S VALUE=TMPACQ
 . E  S VALUE=$S('CON:INSTIEN,TMPACQ=INSTIEN:TMPACQ,1:$$GI(TMPACQ,INSTIEN,GL,IENY))
 . Q
 S VALUE=$$CNL^MAGQBUT4(GL,IEN,.NLC)
 Q:VALUE VALUE
 S VALUE=$$CNSP^MAGQBUT4(GL,IEN,.NMSP,.NSC)
 Q VALUE
SETPL ;
 N IEN,NAME,DR,DA,DIE,X,Y,PLACE,FILE
 S PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2)))
 F FILE=2005.2,2006.8 D
 . S (NAME,IEN)="" F  S NAME=$O(^MAG(FILE,"B",NAME)) Q:NAME=""  D
 . . S IEN=$O(^MAG(FILE,"B",NAME,""))
 . . S DR=".04///^S X=PLACE",DA=IEN,DIE=FILE D ^DIE
 . . Q
 S FILE=2006.032,(NAME,IEN)=""
 F  S NAME=$O(^MAGQUEUE(FILE,"B",NAME)) Q:NAME=""  D
 . S IEN=$O(^MAGQUEUE(FILE,"B",NAME,""))
 . S DR=".04///^S X=PLACE",DA=IEN,DIE=FILE D ^DIE
 . Q
 Q
WSUP(MONTHS) ;
 N EDATE,PLACE,SDATE,IEN,DEFP,CNT,ZNODE,DAYS
 S DAYS=MONTHS*(365/12)
 S DEFP=$$KSP^XUPARAM("INST")
 S EDATE=$$FMADD^XLFDT($$NOW^XLFDT,-DAYS,"","","")
 S IEN=$O(^MAG(2006.82," "),-1),CNT=0
 F  S IEN=$O(^MAG(2006.82,IEN),-1) Q:'IEN  S SDATE=$P($G(^MAG(2006.82,IEN,0)),U,3) Q:SDATE<EDATE  D
 . S CNT=CNT+1
 . W:(CNT#1000)=0 "."
 . W:(CNT#80000)=0 !
 . S PLACE=$P($G(^MAG(2006.82,IEN,1)),U,4)
 . S PLACE=$S(PLACE:PLACE,1:DEFP)
 . S ^MAG(2006.82,"APL",PLACE,SDATE,IEN)=""
 Q
SITEID ;
 N FDA,MSG,IEN
 S IEN=$O(^MAG(2006.1,"A"),-1)_","
 S FDA(2006.1,IEN,.01)=$$KSP^XUPARAM("INST")
 D FILE^DIE("E","FDA","MSG")
 Q
STATION ;  make Imaging Site Parameters (2006.1) file a local array
 ;      find problems in the "D" cross reference of the Institution file
 N I,IEN,INSTDA,SAVE,SITEDA
 S INSTDA="" F  S INSTDA=$O(^MAG(2006.1,"B",INSTDA)) Q:INSTDA=""  S SITEDA="" D
 . S SITEDA=$O(^MAG(2006.1,"B",INSTDA,SITEDA)) Q:SITEDA=""  D
 . . S SITEARAY(INSTDA,SITEDA)=""
 . . Q
 . Q
 K ^TMP($J,"MAG_STATION")
 S STATION=""
 F  S STATION=$O(^DIC(4,"D",STATION)) Q:STATION=""  S IEN="" D
 . F I=1:1 S IEN=$O(^DIC(4,"D",STATION,IEN)) Q:IEN=""  D
 . . S ^TMP($J,"MAG_STATION",STATION)=I
 . . S ^TMP($J,"MAG_STATION",STATION,IEN)=""
 . . Q
 . Q
 S STATION=""
 F  S STATION=$O(^TMP($J,"MAG_STATION",STATION)) Q:STATION=""  D
 . S SAVE=""
 . S STATION("STATION",STATION)=^TMP($J,"MAG_STATION",STATION)
 . I ^TMP($J,"MAG_STATION",STATION)>1 S STATION("PROBLEM",STATION)=""
 . S IEN=""
 . F  S IEN=$O(^TMP($J,"MAG_STATION",STATION,IEN)) Q:IEN=""  D
 . . S STATION("STATION",STATION,IEN)=""
 . . I $D(^DIC(4,STATION))&(STATION'=IEN) S STATION("PROBLEM",STATION)=""
 . . I $D(SITEARAY(IEN)) S SAVE=1
 . . Q
 . I SAVE=1 Q
 . K STATION("STATION",STATION)
 . Q
 K ^TMP($J,"MAG_STATION")
 Q
 ;
