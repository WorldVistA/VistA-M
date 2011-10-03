PSXDODB ;BIR/HTW-HL7 Message Conversion ;25 Jul 2002  10:02 PM
 ;;2.0;CMOP;**38,45**;11 Apr 97
 ; This routine loads a Businessware-converted 2.1 message into a mailman message
EN(PATH,FNAME) ; needs directory & file name
 ; force an error in the next line
 I $L(PATH),$L(FNAME) I 1
 E  S PSXERR="0^BAD PATH OR FILENAME" G ERRMSG
 K ^TMP($J,"PSXDOD")
 S GBL="^TMP("_$J_",""PSXDOD"",1)"
 S Y=$$FTG^%ZISH(PATH,FNAME,GBL,3)
 I Y'>0 S PSXERR="9^"_PATH_U_FNAME_U_" DID NOT LOAD" G ERRMSG
 I $D(^TMP($J,"PSXDOD"))'>1 S PSXERR="9^"_PATH_U_FNAME_U_" DID NOT LOAD" G ERRMSG
EN1 ;
 S PSXERR=""
 D EN^PSXDODB1 ;returns PSXERR="" if file is OK ; otherwise it sends negative ack, mail message, copies to pending
 G:PSXERR'="" EXIT
 S GL="^TMP($J,""PSXDOD"")" ; for global indirection
 ; Work through translated 2.1 file and add 1 prefix to site ids
 ; correct Patient name. provider name, remove BTS segment
 F Z=0:0 S Z=$O(^TMP($J,"PSXDOD",Z)) Q:$G(Z)'>0  S G="^TMP($J,""PSXDOD"""_","_Z_")" D
 .I $G(@G)["BTS|" S @G=^TMP($J,"PSXDOD",Z+1) K ^TMP($J,"PSXDOD",Z+1) ;remove BTS segment if found
 .I $G(@G)["$END" S $P(@G,"^",3)=("1"_$P(@G,"^",3)) Q 
 .I $G(@G)["$XMIT" S SITE="1"_$P(@G,"^",5),$P(@G,"^",5)=SITE,$P(@G,"^",11)=SITE,BATNM=$P(@G,"^",2),FACNM=$P(@G,"^",3),BATID=SITE_BATNM,XX=$P(@G,U,6),$P(@G,U,6)=$$FMDATE^HLFNC(XX),XM=$G(@G)
 .;I $G(@G)["NTE|1" S $P(@G,"|",4)=1_$P(@G,"|",4),$P(@G,"\S\",3)=SITE,NTE1=$G(@G)
 .I $G(@G)["NTE|1" S $P(@G,"|",4)=1_$P(@G,"|",4),F1=$P(@G,"\F\",1),$P(F1,"\S\",3)=SITE,$P(@G,"\F\",1)=F1,NTE1=$G(@G)
 .I $G(@G)["RX1" S $P(@G,"|",2)=1_$P(@G,"|",2)
 .;I $G(@G)["ZX1" S $P(@G,"|",3)=SITE
 .I $G(@G)["ZX1|" S $P(@G,"|",3)=1_$P(@G,"|",3) D
 ..S PRVNM=$P(@G,"|",7) Q:PRVNM'[" ,"
 ..S PRVNML=$P(PRVNM," ,"),PRVNMF=$P(PRVNM," ,",2),PRVNM=PRVNML_", "_PRVNMF
 ..S $P(@G,"|",7)=PRVNM
 ..K PRVNM,PRVNML,PRVNMF
 .;remore 2nd and following "^" in patient name
 .I $G(@G)["PID|" D
 .. S PTNM=$P(@G,"|",6),PTNML=$P(PTNM,"^"),PTNMF=$P(PTNM,"^",2,99),PTNMF=$TR(PTNMF,"^"," ")
 .. S PTNM=PTNML_"^"_PTNMF,$P(@G,"|",6)=PTNM
 .. K PTNM,PTNML,PTNMF
 ;
EN2 ;entry for processing file into Vista Messages
 S (LNCNT,MCNT,LMSGLOC,ORDCNT)=0 ;line count, message line count, last $$MSG location, order count
 ; 
 ;D HEADER^PSXDODH1 ; build $$XMIT & NTE|1 and set into Message    
 S XMSUB="DOD CMOP "_SITE_"-"_BATNM_" from "_FACNM,XMDUZ=.5
XMZ D XMZ^XMA2 G:XMZ'>0 XMZ
 S M="^XMB(3.9,XMZ,2)" ; variable reference to MailMan message for construction
 S @M@(1,0)=XM
 S @M@(2,0)=NTE1,MCNT=2
 S LNNUM=3 F  S LNNUM=$O(@GL@(LNNUM)) Q:LNNUM'>0  S LN=@GL@(LNNUM),@M@(MCNT,0)=LN,MCNT=MCNT+1
 S ^XMB(3.9,XMZ,2,0)="^^"_MCNT_U_MCNT_U_DT
 S XMY("S.PSXX CMOP SERVER")="" ;****testing comment out
 ;S XMY(DUZ)="" H 1 ;****TESTING S.PSXX
 D ENT1^XMD
 D EXIT
 Q
PIECE(REC,DLM,XX) ;
 ; Set variable V = piece P of REC using delimiter DLM
 N V,P S V=$P(XX,U),P=$P(XX,U,2),@V=$P(REC,DLM,P)
 Q
PUT(REC,DLM,XX) ;
 ; Set Variable V into piece P of REC using delimiter DLM
 N V,P S V=$P(XX,U),P=$P(XX,U,2)
 S $P(REC,DLM,P)=$G(@V)
 Q
GETELM(STR,PIECES,SEPS) ;
 ; uses STRing and
 ; returns value of the element located by path of pieces and separators
 ; ex: 1st address line = $$getelm(ORC,"22,1","|,^")
 ; or                   = $$getelm(XMIT,"4,2,1","|,\F\,\S|")
 N P,S,PI,V,I S V=STR
 F I=1:1 S PI=$P(PIECES,",",I) Q:PI=""  S P=I,P(I)=PI,S(I)=$P(SEPS,",",I)
 F I=1:1:P S V=$P(V,S(I),P(I))
 Q V
ERRMSG ;
MSGSEQER ;send error message to folks & DOD
 ;W !,"error ",PSXERR
 S DIRHOLD=$$GET1^DIQ(554,1,23)
 S Y=$$GTF^%ZISH($NA(^TMP($J,"PSXDOD",1)),3,DIRHOLD,FNAME)
 S XMSUB="DOD CMOP Safty "_FNAME
 ;S XMY(DUZ)="" ;****TESTING
 S XMY("G.PSXX CMOP MANAGERS")=""
 S XMTEXT="PSXTXT("
 S PSXTXT(1,0)="DOD CMOP HL7 Conversion to  VA CMOP HL7 experienced an error"
 S PSXTXT(2,0)=$G(PSXERR)
 S PSXTXT(3,0)="FILE: "_FNAME
 S PSXTXT(4,0)="A copy of the file has been placed in the hold directory "_DIRHOLD
 D ^XMD
 I $E(IOST)="C" W ! F I=1:1:4 W !,PSXTXT(I,0) I I=4 H 3
 K PSXTXT,DIRHOLD
 Q
EXIT ;
 K BATIDB,BATIDM,BHS,BTS,DLM,DODORD,END,FHS,FNAME,G,GBL,I,J,JJ,LL,LINE,LMSGLOC
 K LN,LNCNT,LNNUM,LSEG,M,MCNT,MSH,NTE1,NTE2,NTE3,NTE4,NTE7,ORC,ORDCNT,ORDCNTB
 K P,P1,P2,P3,PATH,PI,PID,PNAME,PSXERR,PSXTXT,PTCNT,PTCNTB,REC,RX1,RXE,RXID1,RXIDC,RXIDE
 K S,S1,S2,S3,SEG,SEGSEQ,SEPS,STR,STR0,V,VALUE,XM,XX,Y,YY,ZR1,ZX1
 K ADDRESS,BATDTM,BATID,BATIDB,BATIDM,BATNM,DIVISION,DIVNM,DIVNUM,EXPDT,FACNM,FNAME2,FNAME3,ISSDT
 K LSTRFLDT,MAILID,NTE1ADD,NTE1DIV,NTE1LOC,PID0,PIECE,PRVPHY,PSXF,RFLDT,RXCNT,RXDATES,RXNUM,RXZNUM
 K SIG,SITEID,START,TRANDTS,XMZ
 K ^TMP($J,"PSXDOD"),PSXTXT
 Q
LOADTMP ; load data into ^TMP
 K ^TMP($J,"PSXDOD")
 F I=1:1 S X=$G(^XMB(3.9,125829,2,I,0)) Q:X=""  S ^TMP($J,"PSXDOD",I)=X
 Q
CLEARFLS(XX,EXT) ;
LOOP K PSXF,PSXL
 S PATH=$$GET1^DIQ(554,1,XX),PSXF(EXT)=""
 S Y=$$LIST^%ZISH(PATH,"PSXF","PSXL")
 W !,"path ",PATH,!,"files ",EXT
 Q:$D(PSXL)'>1
 S FILE="" F I=0:0 S FILE=$O(PSXL(FILE)) Q:FILE=""  W !,FILE S I=I+1
 Q:I'>0
 K DIR S DIR(0)="Y",DIR("A")="DELETE FILES ?? ",DIR("B")="N" D ^DIR K DIR Q:Y'>0
 W $$DEL^%ZISH(PATH,"PSXL")
 G LOOP
 Q
