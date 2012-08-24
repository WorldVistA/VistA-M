MAGQBUT4 ;WOIFO/RMP - BP Utilities ; 18 Jan 2011 5:17 PM
 ;;3.0;IMAGING;**7,8,48,20,81,39,121**;Mar 19, 2002;Build 2340;Oct 20, 2011
 ;; Per VHA Directive 2004-038, this routine should not be modified.
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
 ;
 Q
CONV(ARR,ICT) ;Convert any single node array to FM Style multiple
 ;  The node subscripts of ARR are ignored, and not retained
 ; i.e.  ARR(34)=8
 ;       ARR("BLUE")=9
 ;       ARR("D")=10
 ; converts to
 ;      ARR(1,0)=8
 ;      ARR(2,0)=9
 ;      ARR(3,0)=10
 N I,ARO
 S ICT=0,I=""
 F  S I=$O(ARR(I)) Q:(I="")  D
 . S ICT=ICT+1
 . S ARO(ICT,0)=ARR(I)
 K ARR
 M ARR=ARO
 Q
MRGMULT(ARR,RT,RTDSC,CT) ;Merge the FM formatted array into a FM File
 ;   multiple field.
 ;   This isn't for general consumption.
 ; RT = FILE ROOT, RECORD NUMBER, NODE
 ; i.e.  "^MAG(2006.034,44,1,"   -> 44 is the IEN of MAG(2006.34
 ; RTDSC is the 2nd piece of the 0 node of the multiple field.
 S RT=$E(RT,1,$L(RT)-1)_")"
 S @RT@(0)=U_RTDSC_U_CT_U_CT ;  i.e.    ^2006.341A^13^13
 M @RT=ARR
 Q
DDLF(RESULTS,FILE,FIELD,FLAGS,ATTR) ;[MAG FLD ATT]
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 K X
 N I
 D FIELD^DID(FILE,FIELD,FLAGS,ATTR,"RESULTS","RESULTS")
 S I=0 F  S I=I+1 Q:'$D(RESULTS(ATTR,I))  M RESULTS(I)=RESULTS(ATTR,I)
 Q
DDFA(RESULTS) ;[MAG ATT LST]
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 K X
 D FIELDLST^DID(RESULTS)
 Q
DVAL(RESULTS,FILE,IENS,FIELD,FLAGS,VALUE) ;[MAG FIELD VALIDATE]
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 K X
 I FLAGS']"" S FLAGS="EHU"
 D VAL^DIE(FILE,IENS,FIELD,FLAGS,VALUE,.RESULT,"","MSG")
 I RESULT=U S RESULTS="-1^"_$G(MSG("DIERR","1","TEXT","1"))
 E  S RESULTS=1_U_RESULT_U_$G(RESULT(0))
 Q
KVAL(RESULTS,FLAGS,FDA) ;[MAG KEY VALIDATE]
 N TMP,DDRFDA
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 K X
 D FDASET(.FDA,.DDRFDA)
 S TMP=$$KEYVAL^DIE(FLAGS,"DDRFDA","MSG")
 S RESULTS=$S(TMP=1:1,1:"-1^"_$G(MSG("DIERR","1","TEXT","1")))
 K DDRFDA,MSG
 Q
FDASET(DDRROOT,DDRFDA) ;
 N DDRFILE,DDRIEN,DDRFIELD,DDRVAL,DDRERR,I
 S I=0
 F  S I=$O(DDRROOT(I)) Q:'I  S X=DDRROOT(I) D
 . S DDRFILE=$P(X,U)
 . S DDRFIELD=$P(X,U,2)
 . S DDRIEN=$P(X,U,3)
 . S DDRVAL=$P(X,U,4,99)
 . D FDA^DILF(DDRFILE,DDRIEN_$S($E(DDRIEN,$L(DDRIEN))'=",":",",1:""),DDRFIELD,"",DDRVAL,"DDRFDA","DDRERR")
 Q
DHRPC(RESULTS,FNAME,FLOC) ;[MAG DIRHASH]
 N TMP
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 K X
 S TMP=$$DIRHASH^MAGFILEB(FNAME,FLOC)
 S RESULTS=$S(TMP="":U,1:TMP)
 Q
GPACHX(PV) ; Get Package File Install History of Imaging
 N I,LCNT,MSG,PKG
 S LCNT=0
 S PV(0)="Version^Install Date"
 F PKG="IMAGING" D
 . N J,K,L,VERS,DATE,X,Y
 . S J=$O(^DIC(9.4,"B",PKG,"")) Q:'J
 . S VERS="" F  S VERS=$O(^DIC(9.4,J,22,"B",VERS)) Q:VERS=""  D
 . . N MSG,TAR
 . . S K=$O(^DIC(9.4,J,22,"B",VERS,""))
 . . D LIST^DIC(9.4901,","_K_","_J_",","@;.01;.02;.03","","","","","","","","TAR","MSG")
 . . Q:$D(MSG("DIERR"))
 . . S L=0 F  S L=$O(TAR("DILIST","ID",L)) Q:'L  D
 . . . S LCNT=LCNT+1
 . . . S PV(LCNT)=VERS_"P"_$P(TAR("DILIST","ID",L,".01"),"^",1)
 . . . S X=$P($P(TAR("DILIST","ID",L,".02"),"^",1),"@",1)
 . . . S PV(LCNT)=PV(LCNT)_"^"_$S(X["-1":"",1:X)
 . . . Q
 . . Q
 . Q
 Q
 ;
VOKR(RESULT,VER) ; RPC for VOK [MAGQ VOK]
 N CVERS,PNUM,SLINE
 S VER="3.0P"_($$TRIM($P(VER,"P",2)))
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 S SLINE=$T(+2)
 S PNUM=$$TRIM($P(SLINE,"**",2)),PNUM=$$TRIM($P(PNUM,",",$L(PNUM,",")))
 S CVERS=$$TRIM($P(SLINE,";",3))_"P"_PNUM
 S RESULT=$S(CVERS=VER:1,1:0)_U_CVERS
 Q
 ;
TRIM(X) ; remove both leading and trailing blanks
 N I,J
 F I=1:1:$L(X) Q:$E(X,I)'=" "
 F J=$L(X):-1:I Q:$E(X,J)'=" "
 Q $S($E(X,I,J)=" ":"",1:$E(X,I,J))
 ;
QCNT(RESULT,PLC,QUE) ; [MAGQ QCNT] Called from MagQueManSet.pas and MagSiteParameters.pas
 N CNT,DA,CQ,IA,X
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 ;CQ=Current Queue Pointer(#2006.03) 
 ;QP=Queue file pointer(#2006.031)
 ;CNT=Queue type total, IA=Not failed total
 S IA="",RESULT=0
 S (CNT,IA)=0,DA=""
 S QP=$S($D(^MAGQUEUE(2006.031,"C",PLC,QUE)):$O(^MAGQUEUE(2006.031,"C",PLC,QUE,"")),1:"")
 S CQ=$S('QP:0,1:$P($G(^MAGQUEUE(2006.031,QP,0)),U,2))
 F  S DA=$O(^MAGQUEUE(2006.03,"C",PLC,QUE,DA)) Q:'DA  D
 . I '$D(^MAGQUEUE(2006.03,DA,0)) K ^MAGQUEUE(2006.03,"C",PLC,QUE,DA) Q 
 . S CNT=CNT+1
 . I CQ<DA S IA=IA+1
 . Q
 D QPUP(PLC,QUE,CNT,CQ,IA,QP) Q
 Q
 ;
QPUP(PLC,QUE,CNT,CQ,IA,QP) ;
 N IEN,DIC,VAL
 K VAL
 S VAL(1)=PLC,VAL(2)=QUE
 S QP=$S(QP:QP,1:$$FIND1^DIC(2006.031,"","QX",.VAL,"C","",""))
 ;I IEN>0 D  Q:IEN
 ;. S $P(^MAGQUEUE(2006.031,IEN,0),U,5)=CNT Q
 I 'QP D  Q
 . K DIE,FDA
 . S FDA(2006.031,"+1,",.01)=QUE
 . S FDA(2006.031,"+1,",.04)=PLC
 . S FDA(2006.031,"+1,",1)=CQ
 . S FDA(2006.031,"+1,",2)=IA
 . S FDA(2006.031,"+1,",3)=CNT
 . D UPDATE^DIE("U","FDA","","MAGQUP")
 . K DIE,FDA
 E  D
 . K DIE,FDA
 . S FDA(2006.031,QP_",",.01)=QUE
 . S FDA(2006.031,QP_",",.04)=PLC
 . S FDA(2006.031,QP_",",1)=CQ
 . S FDA(2006.031,QP_",",2)=IA
 . S FDA(2006.031,QP_",",3)=CNT
 . D FILE^DIE("","FDA","MAGERR")
 . K DIE,FDA
 Q
 ;
CPUD ;
 N PLC,INS,QUE
 S (INS,PLC)=""
 F  S INS=$O(^MAG(2006.1,"B",INS)) Q:INS=""  D
 . S PLC=$O(^MAG(2006.1,"B",INS,""))
 . S QUE="" F  S QUE=$O(^MAGQUEUE(2006.031,"C",PLC,QUE)) Q:QUE=""  D
 . . D QCNT^MAGQBUT4("",PLC,QUE)
 . . Q
 . Q
 Q
CNL(GL,IEN,NLC) ;  Check Network Location
 N MAGREF,MAG0,MAG1,PLC
 S NLC=NLC+1
 I '$G(IEN) Q ""
 S MAG0=$G(@(GL_IEN_",0)"))
 S MAGREF=+$P(MAG0,"^",3)            ; get file from raid
 I MAGREF=0 S MAGREF=+$P(MAG0,"^",5) ; get file from jukebox
 I 'MAGREF Q ""
 I '$D(^MAG(2005.2,MAGREF,0)) Q ""
 S PLC=$P($G(^MAG(2005.2,MAGREF,0)),U,10)
 Q:'PLC ""
 S PLC=$P($G(^MAG(2006.1,PLC,0)),U)
 Q $S('PLC:"",1:PLC)
CNSP(GL,IEN,NMSP,NSC) ;  Check NameSPace
 N NMSPC,MAG0,FNAM,INSTIEN
 S NSC=NSC+1
 S MAG0=$G(@(GL_IEN_",0)"))
 S FNAM=$P(MAG0,U,2)
 S NMSPC=$TR($P(FNAM,"."),"0123456789","")
 Q:NMSPC="" ""
 S INSTIEN=$S($D(NMSP(NMSPC)):$O(NMSP(NMSPC,"")),1:"")
 Q INSTIEN
NMSP(TMPA) ;
 N IEN,INS,TMP,I,J
 S INS="" F  S INS=$O(^MAG(2006.1,"B",INS)) Q:INS=""  S IEN="" D
 . S IEN=$O(^MAG(2006.1,"B",INS,IEN)) Q:IEN=""  D  Q
 . . S TMP=","_$$UPPER^MAGQE4($$INIS^MAGQBPG2(IEN))_"," D  Q
 . . . F I=2:1 S J=$P(TMP,",",I) Q:J=""  S TMPA(J,INS)=""
 . . . Q
 S J="" F  S J=$O(TMPA(J)) Q:J=""  S INS=$O(TMPA(J,"")) K:($O(TMPA(J,INS))]"") TMPA(J)
 Q
CLRQ ; Clears the Queue file and Queue Pointer files
 N DA,DIK,FILE,IEN
 F FILE=2006.03,2006.031 D
 . S IEN=0 F  S IEN=$O(^MAGQUEUE(FILE,IEN)) Q:'IEN  D
 . . S DIK="^MAGQUEUE("_FILE_","
 . . S DA=IEN,DA(1)=FILE D ^DIK
 K DIK,DA
 Q
 ; We add RPC to MAG WINDOWS Option this way instead of sending Option : MAG WINDOWS
 ; If we send MAG WINDOWS Option, the last one installed will overwrite others.
 ; ADDRPC copied from Patch 51, added the call "D MES^XPDUTL(" instead of "W !"
ADDRPC(RPCNAME,OPTNAME) ;
 N DA,DIC
 S DIC="^DIC(19,",DIC(0)="",X=OPTNAME D ^DIC
 I Y<0 D  Q
 . D MES^XPDUTL("Cannot add RPC: """_RPCNAME_""" to Option: """_OPTNAME_""".")
 . D MES^XPDUTL("Cannot find Option: """_OPTNAME_""".")
 . Q
 I '$D(^XWB(8994,"B",RPCNAME)) D  Q
 . D MES^XPDUTL("Cannot add RPC: """_RPCNAME_""" to Option: """_OPTNAME_""".")
 . D MES^XPDUTL("Cannot find RPC: """_RPCNAME_""".")
 . Q
 S DA(1)=+Y
 I $D(^DIC(19,+Y,"RPC","B",$O(^XWB(8994,"B",RPCNAME,"")))) D  Q
 . D MES^XPDUTL("Cannot add RPC: """_RPCNAME_""" to Option: """_OPTNAME_""".")
 . D MES^XPDUTL("RPC: """_RPCNAME_""" is already a member of """_OPTNAME_""".")
 . Q
 S DIC=DIC_DA(1)_",""RPC"","
 S DIC(0)="L",DLAYGO="19" ; LAYGO should be allowed here
 S X=RPCNAME
 D ^DIC
 K DIC,D0,DLAYGO
 I Y<0 D  Q
 . D MES^XPDUTL("Cannot add RPC: """_RPCNAME_""" to Option: """_OPTNAME_""".")
 . D MES^XPDUTL("Cannot find RPC: """_RPCNAME_""".")
 . Q
 Q
INS(XP,DUZ,DATE,IDA) ;
 N CT,CNT,COM,D,D0,D1,D2,DDATE,DG,DIC,DICR,DIW,MAGMSG,ST,XMID,XMY,PLACE,XMSUB,XMZ
 S PLACE=$O(^MAG(2006.1,"B",$$KSP^XUPARAM("INST"),""))
 D GETENV^%ZOSV
 S CNT=0
 S CNT=CNT+1,MAGMSG(CNT)="PACKAGE INSTALL"
 S CNT=CNT+1,MAGMSG(CNT)="SITE: "_$$KSP^XUPARAM("WHERE")
 S CNT=CNT+1,MAGMSG(CNT)=" Production Account: "_$$PROD^XUPROD("1")
 S CNT=CNT+1,MAGMSG(CNT)="PACKAGE: "_XP
 S CNT=CNT+1,MAGMSG(CNT)="Version: "_$$VER^XPDUTL(XP)
 S ST=$$GET1^DIQ(9.7,IDA,11,"I")
 S CNT=CNT+1,MAGMSG(CNT)="Start time: "_$$FMTE^XLFDT(ST)
 S CT=$$GET1^DIQ(9.7,IDA,17,"I") S:+CT'=CT CT=$$NOW^XLFDT
 S CNT=CNT+1,MAGMSG(CNT)="Completion time: "_$$FMTE^XLFDT(CT)
 S CNT=CNT+1,MAGMSG(CNT)="Run time: "_$$FMDIFF^XLFDT(CT,ST,3)
 S CNT=CNT+1,MAGMSG(CNT)="Environment: "_Y
 S COM=$$GET1^DIQ(9.7,IDA,6,"I")
 S CNT=CNT+1,MAGMSG(CNT)="FILE COMMENT: "_COM
 S CNT=CNT+1,MAGMSG(CNT)="DATE: "_DATE
 S CNT=CNT+1,MAGMSG(CNT)="Installed by: "_$$GET1^DIQ(9.7,IDA,9,"E")
 S CNT=CNT+1,MAGMSG(CNT)="Install Name: "_$$GET1^DIQ(9.7,IDA,.01,"E")
 S DDATE=$$GET1^DIQ(9.7,IDA,51,"I")
 S CNT=CNT+1,MAGMSG(CNT)="Distribution Date: "_$$FMTE^XLFDT(DDATE)
 S XMSUB=XP_" INSTALLATION"
 S XMID=$G(DUZ) S:'XMID XMID=.5
 S XMY(XMID)=""
 S:$G(MAGDUZ) XMY(MAGDUZ)=""
 S XMSUB=$E(XMSUB,1,63)
 D:$$PROD^XUPROD("1") ADDMG^MAGQBUT5(XMSUB,.XMY,PLACE)
 D SENDMSG^XMXAPI(XMID,XMSUB,"MAGMSG",.XMY,,.XMZ,)
 I $G(XMERR) M XMERR=^TMP("XMERR",$J) K XMERR
 K MAGMSG
 Q
TEST ;
 N FDA
 S FDA(4)="2006.8^.01^+1,^BP1"
 S FDA(1)="2006.8^.04^+1,^1"
 S FDA(3)="2006.8^50^+1,^ISW-PRICER"
 S FDA(2)="2006.8^11^+1,^1"
 D KVAL(.RESULTS,"Q",.FDA)
 W !,"RESULTS: "_RESULTS
 Q
 ;
