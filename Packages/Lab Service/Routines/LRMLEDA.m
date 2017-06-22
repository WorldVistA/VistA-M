LRMLEDA ;BPFO/DTG - NTRT MESSAGE PROCESS AND EDITS UPDATE ;02/10/2016
 ;;5.2;LAB SERVICE;**468**;FEB 10 2016;Build 64
 ;
 ; This section is for sending the XML message to ISAAC via HTTP/HTTPS
 ;
 ; first we save to ^XTMP
 Q
EN ; XTMP save
 N LRXTMPNM,LRXTMPNUM,CNT,LRNTRTSAV
 S CNT=0
ENA S LRXTMPNM="LRNTRTSAV"
 L +^XTMP(LRXTMPNM):30 I '$T H 10 S CNT=CNT+1 G ENA:CNT<11,ENO
 S ^XTMP(LRXTMPNM,0)=$$FMADD^XLFDT(DT,365)_U_$$NOW^XLFDT()_U_"Lab New Term to NTRT STS XML"
 S LRXTMPNUM=$G(^XTMP(LRXTMPNM,"CTRL")),LRXTMPNUM=LRXTMPNUM+1,^XTMP(LRXTMPNM,"CTRL")=LRXTMPNUM
 L -^XTMP(LRXTMPNM)
 S CNT=0
 ; LRTEXT is the built XML send array
 ; LR60IEN is the file 60 test IEN
 ; LRS is the Specimen IEN from the 60 specimen multiple (60.01)
 ; LRDUZ is the DUZ of the person saving the test/specimen item
ENL L +^XTMP(LRXTMPNM,"SEND",LRXTMPNUM):20 I '$T H 2 S CNT=CNT+1 G ENL:CNT<11,ENO
 M ^XTMP(LRXTMPNM,"SEND",LRXTMPNUM,"I")=LRTEXT
 S ^XTMP(LRXTMPNM,"SEND",LRXTMPNUM,"DUZ")=LRDUZ
 S ^XTMP(LRXTMPNM,"SEND",LRXTMPNUM,"LR60IEN")=LR60IEN
 S ^XTMP(LRXTMPNM,"SEND",LRXTMPNUM,"LRS")=LRS
 S ^XTMP(LRXTMPNM,"SEND",LRXTMPNUM,"ERROR")=0
 L -^XTMP(LRXTMPNM,"SEND",LRXTMPNUM)
ENSL L +^XTMP(LRXTMPNM,"O"):5 I '$T G ENO
 N ZTDTH,ZTRTN,ZTSAVE,ZTIO,ZTSK,ZTDESC
 S LRNTRTSAV="LRNTRTSAV"
 S ZTDTH=$$NOW^XLFDT,ZTDESC="LAB Send NTRT message to ISAAC"
 S ZTSAVE("LRXTMPNM")=""
 S ZTRTN="XMLSND^LRMLEDA",ZTIO=""
 D ^%ZTLOAD
 L -^XTMP(LRXTMPNM,"O")
 K ZTDTH,ZTRTN,ZTSAVE,ZTIO,ZTSK,ZTDESC
ENO K LRXTMPNM,LRXTMPNUM,CNT,LRNTRTSAV
 Q
 ;
 ; entry to send messages to ISAAC
 ;
XMLSND ;
 N CNT,A,B,C,LRT,LRDUZ,LRG,LRS,LR60IEN,LRA,LRTEXT,LRRDAT,LRSDAT,LRRHD,LRSHD,LRFLG,LRMETH,URL,LRXTVER
 N LSITE,LRNT,LRNTI,AR,LRNMAIL,LRGMAIL,LRIS,LRPRT,LRIPATH,LXA,LXB,LRNOS1,LRNOS2,LRERR,LRDUZ,LRXTMPNM
 N AB,CC,DA,DIC,DIQ,DR,E,LACT,LRNOS3,LRSITEN,LXC,STATUS,XMDUZ,XMY,XMSUB,XMTEXT
 S CNT=0,LRXTMPNM="LRNTRTSAV"
X1 L +^XTMP(LRXTMPNM,"O"):20 I '$T S CNT=CNT+1 G X1:CNT<11,XMLOUT
 I $G(DT)="" S DT=$$DT^XLFDT
 ; get file 66.4 current info
 S LSITE=$$SITE^VASITE,LSITE=$P(LSITE,U,1)
 S LRNT=$O(^LAB(66.4,"B",LSITE,0))
 D GETS^DIQ(66.4,LRNT_",","**","IE","AR")
 M LRNTI=AR("66.4",LRNT_",") K AR
 ;site number and name
 S LRSITE=$G(LRNTI(.01,"I")),LRSITEN=$G(LRNTI(.01,"E"))
 ;ntrt mail group
 S LRNMAIL=$G(LRNTI(1,"I"))
 ;lab send mail group
 S LRGMAIL=$G(LRNTI(2,"I"))
 ;how to send mail
 S LACT=$G(LRNTI(.02,"E"))
 ; Isaac web address
 S LRIS=$G(LRNTI(4,"I"))
 S AA=$$XUP(LRIS) S:$E(AA,1,4)="HTTP" LRIS=$P(LRIS,"//",2,999) S:$E(LRIS,($L(LRIS)))="/" LRIS=$E(LRIS,1,($L(LRIS)-1))
 ; Isaac port number
 S LRPRT=$G(LRNTI(5,"I"))
 ; Isaac path
 S LRIPATH=$G(LRNTI(6,"I")) I LRIPATH'="" D  ;<
 . S LRIPATH=$TR(LRIPATH,"~","/")
 . S:$E(LRIPATH,1)'="/" LRIPATH="/"_LRIPATH
 S URL=LRIS_":"_LRPRT_LRIPATH
 ; if web address or port number are nill do not send
 S LRNOS3=0 I $G(LRNTI(4,"I"))=""!($G(LRNTI(5,"I"))="") S LRNOS3=1
 ;if no send method
 S LRNOS1=0 I LACT=""!(LACT="N")!($G(LRNTI(.05,"I"))="N")!($G(LRNTI(.1,"I"))'=1) S LRNOS1=1
 S AA=$$XUP(LRGMAIL)
 ; if not production or not VA
 S LRNOS2=0 I '$$PROD^XUPROD()!(AA'["DOMAIN.EXT") S LRNOS2=1
 ;
 S LRA=0,LRXTVER=1+($$PATCH^XPDUTL("XT*7.3*138"))
 S LRFLG=10
X2 S LRA=$O(^XTMP(LRXTMPNM,"SEND",LRA)) I 'LRA L -^XTMP(LRXTMPNM,"O") G XMLOUT
 S CNT=0
X2A L +^XTMP(LRXTMPNM,"SEND",LRA):5 I '$T S CNT=CNT+1 G X2A:CNT<11,XMLOUT
 K LRT,LRRHD,LRRHD,LRSDAT,LRSHD,REDIR
 S (LRRHD,LRSHD,LRRDAT)=""
 S REDIR=0,LRSHD("CONTENT-TYPE")="application/xml",STATUS=""
 M LRT=^XTMP(LRXTMPNM,"SEND",LRA,"I")
 S LRDUZ=^XTMP(LRXTMPNM,"SEND",LRA,"DUZ"),LR60IEN=^XTMP(LRXTMPNM,"SEND",LRA,"LR60IEN")
 S LRS=^XTMP(LRXTMPNM,"SEND",LRA,"LRS"),LRERR=^XTMP(LRXTMPNM,"SEND",LRA,"ERROR")
 ; File 60 test info
 ; .01 test name, 4 subscript (CH), 5 data name, 13 field (DD of 5), 64.1 result nlt code
 S DA=+LR60IEN
 S DIQ="LXB",DIQ(0)="IE",DIC=60,DR=".01;4;64.1;5;13;132;133" K ^UTILITY("DIQ1",$J) D EN^DIQ1 K ^UTILITY("DIQ1",$J)
 K LXA M LXA=LXB(60,DA) K LXB
 ; get file 60 Test/Specimen info
 S DIQ="LXB",DIQ(0)="IE",DIC=60,DR=100,DA=+LR60IEN K LXB,^UTILITY("DIQ1",$J)
 S DR(60.01)=".01;6;1;2;9.2;9.3;13;30;32;33;34;35",DA(60.01)=LRS
 D EN^DIQ1 K ^UTILITY("DIQ1",$J)
 K LXC M LXC=LXB("60.01",LRS) K LXB
 ; do not try if failed 10 times
 I LRERR>9 D XMERR G X2
 ;
 ; check if ok to send a message
 I LRNOS1=1!(LRNOS2=1)!(LRNOS3=1) D NOTVALID G X2
 ;
 S STATUS=$$GETURL^XTHC10(URL,LRFLG,"LRRDAT",.LRRHD,"LRT",.LRSHD,$G(REDIR)+1)
 S A=$TR(STATUS,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I A["OK"!(A["ACCEPTED") D  G X2
 .; send message to order and group that message was sent to ISAAC NTRT
 . K XMY,LRTEXT
 . S XMSUB="NEW NTRT REQUEST FOR LABORATORY HAS BEEN SENT"
 . S XMY(LRDUZ)=""
 . S XMDUZ("AUTO ISAAC NTRT PROCESS")="" I LRGMAIL'="" S XMY($P(LRGMAIL,"@",1))=""
 . S LRTEXT(1)="A new Laboratory Test has been entered at: "_LRSITEN_" / "_LRSITE
 . S LRTEXT(2)=""
 . S LRTEXT(3)="Laboratory Test Name / Specimen name: "_$G(LXA(.01,"I"))_" / "_$G(LXC(.01,"E"))
 . S LRTEXT(4)=""
 . S LRTEXT(5)="Send Status: "_STATUS
 . S LRTEXT(6)=""
 . S A=0,B="",I=6 F  S A=$O(LRRDAT(A)) Q:'A  S B=$G(LRRDAT(A)) S:B'="" I=I+1,LRTEXT(I)="ISAAC Reference Information: "_B
 . S LRTEXT(I+1)=""
 . S XMTEXT="LRTEXT(" D ^XMD
 . ;put exception flag in 60 file
 . ; since making exception flag uneditable must do physical set
 . N A,B,LRO,LRN,I S A=$G(^LAB(60,LR60IEN,1,LRS,5)),B=A,$P(B,U,3)="Y",^LAB(60,LR60IEN,1,LRS,5)=B
 . ; need to build array for saving in audit section
 . F I=1,2,4 S LRO(I)="",LRN(I)=""
 . S LRO(3)=$P(A,U,3),LRN(3)=$P(B,U,3) D  ;<
 . . N ZTDTH,ZTRTN,ZTSAVE,ZTIO,ZTSK,ZTDESC
 . . S ZTDTH=$$NOW^XLFDT,ZTDESC="LAB Edit Save of Deployed Flag"
 . . S ZTRTN="SEDA^LRMLED("_LRS_","_LR60IEN_")",ZTSAVE("LR60IEN")="",ZTSAVE("LRS")=""
 . . S ZTSAVE("LRN(")="",ZTSAVE("LRO(")=""
 . . S ZTIO=""
 . . D ^%ZTLOAD
 . ; remove item from send
 . S ^XTMP(LRXTMPNM,"DONE",LRA)=LR60IEN_U_LRS_$$NOW^XLFDT_U_LRDUZ
 . K ^XTMP(LRXTMPNM,"SEND",LRA)
 . L -^XTMP(LRXTMPNM,"SEND",LRA)
 . ;
 S LRERR=LRERR+1,^XTMP(LRXTMPNM,"SEND",LRA,"ERROR")=LRERR,^XTMP(LRXTMPNM,"SEND",LRA,"ERROR",LRERR)=STATUS
 L -^XTMP(LRXTMPNM,"SEND",LRA)
 G X2
 ;
XMLOUT K CNT,A,B,C,LRT,LRDUZ,LRG,LRS,LR60IEN,LRA,LRTEXT,LRRDAT,LRSDAT,LRRHD,LRSHD,LRFLG,LRMETH,URL,LRXTVER
 K LSITE,LRNT,LRNTI,AR,LRNMAIL,LRGMAIL,LRIS,LRPRT,LRIPATH,LXA,LXB,LRNOS1,LRNOS2,LRERR,LRDUZ,AA,LRXTMPNM
 K AB,CC,DA,DIC,DIQ,DR,E,LACT,LRNOS3,LRSITEN,LXC,STATUS,XMDUZ,XMY,XMSUB,XMTEXT
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
XUP(UP) ;change to upper case
 I UP="" Q ""
 N A
 S A=$TR(UP,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q A
 ;
XMERR ; If error count is above 9 send message to LIM that request did not go out and include request in message
 ;
 K XMY,LRTEXT
 S XMSUB="NOT ABLE TO SEND NEW NTRT REQUEST FOR LABORATORY"
 S XMY(LRDUZ)=""
 S XMDUZ("AUTO ISAAC NTRT PROCESS")="" I LRGMAIL'="" S XMY($P(LRGMAIL,"@",1))=""
 S LRTEXT(1)="A new Laboratory Test has been entered at: "_LRSITEN_" / "_LRSITE
 S LRTEXT(2)=""
 S LRTEXT(3)="Laboratory Test Name / Specimen name: "_$G(LXA(.01,"I"))_" / "_$G(LXC(.01,"E"))
 S LRTEXT(4)=""
 ; the error statuses
 S A=0,C=5 F  S A=$O(^XTMP(LRXTMPNM,"SEND",LRA,"ERROR",A)) Q:'A  S B=^XTMP(LRXTMPNM,"SEND",LRA,"ERROR",A) D  ;<
 . S LRTEXT(C)="Error number: "_A_" Error Reason: "_B,LRTEXT(C+1)=""
 . S C=C+2
 S LRTEXT(C)="Original Message Contents:",LRTEXT(C+1)="",C=C+2
 S A=0 F  S A=$O(LRT(A)) Q:'A  S B=LRT(A),LRTEXT(C)=B,C=C+1
 S LRTEXT(C)=""
 S XMTEXT="LRTEXT(" D ^XMD
 M ^XTMP(LRXTMPNM,"NOTSENT",LRA)=^XTMP(LRXTMPNM,"SEND",LRA)
 K ^XTMP(LRXTMPNM,"SEND",LRA)
 L -^XTMP(LRXTMPNM,"SEND",LRA)
 Q
 ;
NOTVALID ; if not valid to send to ISAAC then only send MAILMAN message to 
 K XMY,LRTEXT
 S XMSUB="NOT ABLE TO SEND NEW NTRT REQUEST FOR LABORATORY"
 S XMY(LRDUZ)=""
 S XMDUZ("AUTO ISAAC NTRT PROCESS")="" I LRGMAIL'="" S XMY($P(LRGMAIL,"@",1))=""
 S LRTEXT(1)="A new Laboratory Test has been entered at: "_LRSITEN_" / "_LRSITE
 S LRTEXT(2)=""
 S LRTEXT(3)="Laboratory Test Name / Specimen name: "_$G(LXA(.01,"I"))_" / "_$G(LXC(.01,"E"))
 S LRTEXT(4)=""
 S LRTEXT(5)=" ** This message was not sent to ISAAC due to one of the following reasons: **"
 S C=5
 S A="",B="",CC="",D="",E="" S:LRNOS1=1 A="No Send Location" S:'$$PROD^XUPROD() B="Not a Production System" S:AA'["DOMAIN.EXT" CC="Not a VA System"
 I LRNOS3=1 S:$G(LRNTI(4,"I"))="" D="Missing ISAAC Web Address" S:$G(LRNTI(5,"I"))="" E="Missing ISAAC Port Number"
 I B'=""!(C'="") D  ;<
 . F I="A","B","CC","D","E" S AB=$G(@I) I AA'="" S C=C+1,LRTEXT(C)=AB
 . ; I B'="" S:A'="" A=A_" , " S A=A_B
 . ; I CC'="" S:A'="" A=A_" , " S A=A_CC
 . ; I D'="" S:A'="" A=A_" , " S A=A_D
 . ; I E'="" S:A'="" A=A_" , " S A=A_E
 ; S LRTEXT(6)=A,LRTEXT(7)="",C=8
 S C=C+1,LRTEXT(C)="",C=C+1
 S LRTEXT(C)="Original Message Contents:",LRTEXT(C+1)="",C=C+2
 S A=0 F  S A=$O(LRT(A)) Q:'A  S B=LRT(A),LRTEXT(C)=B,C=C+1
 S LRTEXT(C)=""
 S XMTEXT="LRTEXT(" D ^XMD
 K ^XTMP(LRXTMPNM,"SEND",LRA)
 L -^XTMP(LRXTMPNM,"SEND",LRA)
 Q
 ;
CHKACT(FILIEN) ; check if 66.3 item is active
 ;
 N A,B,C,D
 I 'FILIEN Q "0"
 S (A,B,C)=""
 S A=$O(^LRMLTF(FILIEN,"TERMSTATUS",9999999),-1) I 'A Q "0"
 S B=$G(^LRMLTF(FILIEN,"TERMSTATUS",A,0))
 I $P(B,U,2)=1 Q "1"
 Q "0"
 ;
XML ;send xml to NTRT
 ; moved here from LRMLED
 S ALI=0 K LRTEXT
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=$$XMLHDR^MXMLUTL()
 ; get the schemea name and the schema path
 S LRSCHNM=$G(LRNTI(7,"I")),LRSCHPA=$G(LRNTI(8,"I"))
 S A=$TR(LRSCHNM,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I LRSCHNM'=""&($E(A,($L(A)-4),$L(A))'[".XSD") S LRSCHNM=LRSCHNM_".XSD"
 I LRSCHPA'="" D  ;<
 . S LRSCHPA=$TR(LRSCHPA,"~","/")
 . I $E(LRSCHPA,1,2)'="//" S LRSCHPA="//"_LRSCHPA
 . I $E(LRSCHPA,$L(LRSCHPA))'="/" S LRSCHPA=LRSCHPA_"/"
 S A="uri:"_LRSCHPA_LRSCHNM
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="<DATAEXTRACTS xmlns="""_A_""" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"""
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=">"
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="<LAB_NTRT>"
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="<Facility_Name/Number>"_LRSITEN_" / "_LRSITE_"</Facility_Name/Number>"
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="<Facility_Group_e-mail>"_LRGMAIL_"</Facility_Group_e-mail>"
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="<New_Laboratory_Test_Name>"_$G(LXA(.01,"I"))_"</New_Laboratory_Test_Name>"
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="<New Laboratory_Test_LOCAL_IEN>"_(+LR60IEN)_"</New Laboratory_Test_LOCAL_IEN>"
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="<Laboratory_Test_Site/Specimen_Number_(IEN)>"_$G(LXC(.01,"I"))_"/<Laboratory_Test_Site/Specimen_Number_(IEN)>"
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="<Laboratory_Test_Site/Specimen_Name>"_$G(LXC(.01,"E"))_"</Laboratory_Test_Site/Specimen_Name>"
 S B="",A=$G(LXC(.01,"I")) I A S A=$G(^LAB(61,A,0)),B=$P(A,U,10) I +B>0 S B=$P($G(^LAB(64.061,B,0)),U,1)
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="<Spec>"_$P(A,U,1)_"</Spec>"
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="<Time_Aspect>"_B_"</Time_Aspect>"
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="<Units>"_$G(LXC(6,"I"))_"</Units>"
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="<NLT>"_LRNLT_"</NLT>"
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="<Lab_Section>"_LRSEC_"</Lab_Section>"
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="<Subscript>"_$G(LXA(4,"I"))_"</Subscript>"
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="<Data_Name>"_LRDTNM_"</Data_Name>"
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="<Data_Comment>"_LRCOM_"</Data_Comment>"
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="<Data_Type>"_LRCTY_"</Data_Type>"
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="<Reference_Low>"_$G(LXC(1,"I"))_"</Reference_Low>"
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="<Reference_High>"_$G(LXC(2,"I"))_"</Reference_High>"
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="<Therapeutic_Low>"_$G(LXC(9.2,"I"))_"</Therapeutic_Low>"
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="<Therapeutic_High>"_$G(LXC(9.3,"I"))_"</Therapeutic_High>"
 ;get synonyms
 K B S A=0 F I=0:1 S A=$O(^LAB(60,DA,5,A)) Q:'A  S B(I)=$P(^LAB(60,DA,5,A,0),U,1)
 I I>0 S B=I-1 F I=0:1:B S LXG=B(I) S:LXG'="" ALI=$$LRTP(ALI),LRTEXT(ALI)="<Test_Synonyms>"_LXG_"</Test_Synonyms>"
 ; specimen interpretation
 S E=0 F I=1:1 S E=$O(LXE(E)) Q:'E  S G=LXE(E),ALI=$$LRTP(ALI),LRTEXT(ALI)="<Specimen_Interpretation>"_G_"</Specimen_Interpretation>"
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="</LAB_NTRT>"
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="</DATAEXTRACTS>"
 G EN
 Q
 ;
LRTP(AA) ;update text counter
 S AA=AA+1
 Q AA
 ;
