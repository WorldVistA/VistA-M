LRSRVR9B ;BPFO/DTG - UPDATE DATA FOR 61, 61.2, AND 62 FOR SNOMED AND INACTIVE ;07/7/2017
 ;;5.2;LAB SERVICE;**495**;Sep 27, 1994;Build 6
 ;
 Q
 ;
SERVER ; entry for message processing
 N I,D,LRCNT,LREND,LRL,LRMSUBJ,LRTXT,LRX,LRY,FIL,CR,XMZ,XMPOS,XMER,XMRG,XMCHAN,LRCRLF
 N ZTQUEUED,DR,DIE,DTOUT,DROUT,II,LRTEXT,LRVRD4,LRVRD5,LRVRD6,LRSTR,CR,FIL
 N A,B,C,E,G,L,LRINSTR,DN,LRGOOD
 ;
 S CR=$C(13),FIL=$P(LRSUB," ",2,999),FIL=$$UP^XLFSTR(FIL),U="^",LRCRLF=$C(13,10),D=""
 K ^TMP($J,"LRDATA")
 ; header of message text
 ;Station #-File #-IEN|Entry Name|SNOMED I|SNOMED CT|STS_EXCEPTION|STS_EXCEPTION_REASON|TRANSACTION NUMBER|
 ;get message from XMB(3.9)
 S XMZ=XQMSG,D=0,XMCHAN="SERVER" K XMER
 S LRVRD4="^TMP(""LRREAD-ERR"",$J)" K @LRVRD4
 S LRVRD5="^TMP(""LRREAD"",$J)" K @LRVRD5
 S LRVRD6="^TMP(""LRREAD-RAW"",$J)" K @LRVRD6
SLI ; start
 S K=0,(L,M,N,O)="",STRT=$$NOW^XLFDT
 ; get inbound message and now get the the start lines
 D GET^XML
 F  X XMREC Q:($D(XMER)&($G(XMER)<0))  I XMRG["base64" Q
 I $D(XMER)&($G(XMER)<0) G SL5Q
 S OK=0 F  X XMREC Q:($D(XMER)&($G(XMER)<0))  D  I OK=1 Q
 . S A=XMRG,B=$$B64DECD^XUSHSH(A)
 . I $E(B,1,32)="Station #-File #-IEN|Entry Name|" S OK=1
 I $D(XMER)&($G(XMER)<0) G SL5Q
 I OK'=1 G SL5Q
 I $E(B,1,32)="Station #-File #-IEN|Entry Name|" D
 . S N=$L(B,CR),I=1
 . D SL5S3(I,B)
SL5 ; loop through message
 X XMREC
 I $D(XMER) G SL5Q:XMER<0
 I XMRG="" G SL5
 I $E(XMRG,1,6)="--_004"&($E(XMRG,($L(XMRG)-1),($L(XMRG)))="--") G SL5Q
 S B=$$B64DECD^XUSHSH(XMRG),N=$L(B,CR) F I=1:1:N D SL5S3(I,B)
 G SL5
 ;
SL5S3(II,BB) ; set finish file
 ; II where in for loop
 ; NN number of CR pieces
 ; KK update counter
 ; BB data
 ; saved data
 N P
 S P=$P(BB,CR,II)
 S:$E(P,1)=$C(10) P=$E(P,2,9999)
 I II=1 S O=O_P
 I II>1 S K=K+1,@LRVRD6@(K,0)=O,O=P
 Q
 ;
 ;
SL5Q ;finish pulling message
 S DN=$$NOW^XLFDT
 S @LRVRD6@(0)=K_U_STRT_U_DN
 ;remove items from raw that are not for this facility
 S (A,B,C,D,E,G,LRGOOD)=0
 F  S A=$O(@LRVRD6@(A)) Q:'A  D
 . S B=$G(@LRVRD6@(A,0))
 . I B="" Q
 . I LRST'=$P(B,"-",1)&($P(B,"-",1)'["Station") D  Q
 . . ; save bad entry to send back to sender
 . . S C=$G(@LRVRD4@(0)),C=C+1,@LRVRD4@(0)=C,@LRVRD4@(C,0)=B
 . ; save into file for placing into LRMAP file
 . S D=$G(@LRVRD5@(0)),D=D+1,@LRVRD5@(0)=D,@LRVRD5@(D,0)=B,LRGOOD=D
 ;
 ; make sure there is one entry to place in 95.4 via LRMAP
 S A=$G(@LRVRD5@(1,0)) I A="" G CLOSE
 ;
 ; run purge of 95.4
 N LRDAYS,LRDATE,LRSTAT
 ;
 S LRDAYS=0
 S LRDATE=$$FMADD^XLFDT(DT,-LRDAYS,0,0,0)
 F LRSTAT=0,.5,.7,1,2 D PURGE^LRSRVR5(LRSTAT,LRDATE)
 K LRDAYS,LRDATE,LRSTAT
 ;
 ; save into LAB TEMP FILE
 K ^TMP($J,"LRMAP") M ^TMP($J,"LRMAP")=@LRVRD5 K ^TMP($J,"LRMAP",0)
 S LRTYPE=2,LRTYPE(0)="SCT",ZTQUEUED=1
 ;
 D IMPORT^LRSRVR8(LRTYPE) ; Process file from TMP global into file #95.4
 K ZTQUEUED
 ;
 ; send message to G.LMI
 S (LRMAILGROUP,LRMAILGROUPXQA)="G.LMI"
 S XMSUB="SITE: "_LRST_" "_LRSTN_" SNOMED UPDATE READY FOR PROCESSING "_DT
 S XMY(DUZ)="",XMY("G.LMI")=""
 K LRTEXT S LRTEXT(1)="The SNOMED update for files 61, 61.2, and 62 has been placed on your system"
 S LRTEXT(2)="and is ready for processing."
 S LRTEXT(3)="Use option [ LA7S LOAD MAPPING SCT ] to apply the update."
 S LRTEXT(4)="Select Item '2 Process previous loaded file'"
 S LRTEXT(4)=""
 S XMTEXT="LRTEXT(" D ^XMD
 K LRTEXT,XMTEXT
 ;
 ; send return message to sender
 ;
CLOSE ;
 S LRMSUBJ=LRST_" "_LRSTN_" SCTLOAD "_$$HTE^XLFDT($H,"1M")
 S LRRECORD=K
 S ^TMP($J,"LRDATA",6)="Total Number of Records: "_$J((LRRECORD-1),($L(LRRECORD)+1))
 S A=$$FMTE^XLFDT($P($G(@LRVRD6@(0)),U,3))
 S ^TMP($J,"LRDATA",7)="End Date..: "_$J(A,($L(A)+1))
 S ^TMP($J,"LRDATA",8)="Message Number: "_$J(XQMSG,($L(XQMSG)+1))
 S A=$G(@LRVRD4@(0))+0
 S ^TMP($J,"LRDATA",10)="Total Number of Records rejected Due to Station Number: "_$J(A,($L(A)+1))
 S A=$G(LRGOOD)+0
 S ^TMP($J,"LRDATA",11)="Total Number of Records accepted for processing by the site: "_$J(A,($L(A)+1))
 S ^TMP($J,"LRDATA",12)=" "
 S A=$$FMTE^XLFDT($$NOW^XLFDT)_" at "_LRSTN
 S ^TMP($J,"LRDATA",1)="File Uploaded.......: "_$J(A,($L(A)+1))
 S ^TMP($J,"LRDATA",2)="File Received.......: "_$J(LRSUB,($L(LRSUB)+1))
 S A=$P($G(@LRVRD6@(2,0)),"|",1)
 S ^TMP($J,"LRDATA",3)="First Record..........: "_$J(A,($L(A)+1))
 S A=$P($G(@LRVRD6@(LRRECORD,0)),"|",1)
 S ^TMP($J,"LRDATA",4)="Last Record.....: "_$J(A,($L(A)+1))
 S A=$$FMTE^XLFDT($P($G(@LRVRD6@(0)),U,2))
 S ^TMP($J,"LRDATA",5)="Start Date........: "_$J(A,($L(A)+1))
 S LRFILENM=$TR(LRSTN," ","_")_"-("_LRST_")-"_$P(LRSUB," ",1)_"-"_$P($$FMTHL7^XLFDT($$NOW^XLFDT),"-")_".TXT"
 S ^TMP($J,"LRDATA",13)="Attached LMOF file.....: "_$J(LRFILENM,($L(LRFILENM)+1))
 F I=14:1:16 S ^TMP($J,"LRDATA",I)=" "
 S ^TMP($J,"LRDATA",17)="begin 644 "_LRFILENM
 S LRSTR=""
 ; include e-mail statements into attachment
 ;F I=1:1:12 S A=$G(^TMP($J,"LRDATA",I)) S LRSTR=LRSTR D SETDATA
 ; check for errors
 S A=$G(@LRVRD4@(0)) I +A<1 D  G CLOSE1
 . S LRSTR=LRSTR_"No Errors Encountered with Station Number"_LRCRLF D SETDATA
 . I LRSTR'="" S LRNODE=LRNODE+1,^TMP($J,"LRDATA",LRNODE)=$$UUEN(LRSTR)
 . S ^TMP($J,"LRDATA",LRNODE+1)=" "
 . S ^TMP($J,"LRDATA",LRNODE+2)="end"
 ;
 ; loop through errors and place in file
 S ^TMP($J,"LRDATA",14)="Legend:"
 S A="Station #-File #-IEN|Entry Name|SNOMED I|SNOMED CT|STS_EXCEPTION|STS_EXCEPTION_REASON|TRANSACTION NUMBER|"
 S ^TMP($J,"LRDATA",15)=A
 S ^TMP($J,"LRDATA",16)=$$REPEAT^XLFSTR("-",($L(A)))
 S A=0
 F  S A=$O(@LRVRD4@(A)) Q:'A  S B=$G(@LRVRD4@(A,0)) S LRSTR=LRSTR_B_LRCRLF D SETDATA
 I LRSTR'="" S LRNODE=LRNODE+1,^TMP($J,"LRDATA",LRNODE)=$$UUEN(LRSTR)
 S ^TMP($J,"LRDATA",LRNODE+1)=" "
 S ^TMP($J,"LRDATA",LRNODE+2)="end"
 G CLOSE1
 ;
CLOSE1 ; send message back to sender
 S LRTO(XQSND)=""
 S LRINSTR("ADDR FLAGS")="R"
 S LRINSTR("FROM")="LAB_PACKAGE"
 S LRMSUBJ=$E(LRMSUBJ,1,65)
 D SENDMSG^XMXAPI(.5,LRMSUBJ,"^TMP($J,""LRDATA"")",.LRTO,.LRINSTR,.LRTASK)
 Q
 ;
CLEAN ;
 K @LRVRD4,@LRVRD5,@LRVRD6
 K I,D,LRCNT,LREND,LRL,LRMSUBJ,LRTXT,LRX,LRY,FIL,CR,XMZ,XMPOS,XMER,XMRG,XMCHAN
 K ZTQUEUED,DR,DIE,DTOUT,DROUT,II,LRTEXT,LRVRD4,LRVRD5,LRVRD6,LRSTR,CR,FIL,LRCRLF
 K A,B,C,E,G,L,LRINSTR,DN,LRGOOD
 D CLEAN^LRSRVR
 D ^%ZISC
 Q
 ;
SETDATA ; Set error data into report structure
 S LRNODE=$O(^TMP($J,"LRDATA",""),-1)
 S LRQUIT=0,LRLEN=$L(LRSTR)
 F  D  Q:LRQUIT
 . I $L(LRSTR)<45 S LRQUIT=1 Q
 . S LRX=$E(LRSTR,1,45)
 . S LRNODE=LRNODE+1,^TMP($J,"LRDATA",LRNODE)=$$UUEN(LRX)
 . S LRSTR=$E(LRSTR,46,LRLEN)
 Q
 ;
UUEN(STR) ; Uuencode string passed in.
 N J,K,LEN,LRI,LRX,S,TMP,X,Y
 S TMP="",LEN=$L(STR)
 F LRI=1:3:LEN D
 . S LRX=$E(STR,LRI,LRI+2)
 . I $L(LRX)<3 S LRX=LRX_$E("   ",1,3-$L(LRX))
 . S S=$A(LRX,1)*256+$A(LRX,2)*256+$A(LRX,3),Y=""
 . F K=0:1:23 S Y=(S\(2**K)#2)_Y
 . F K=1:6:24 D
 . . S J=$$DEC^XLFUTL($E(Y,K,K+5),2)
 . . S TMP=TMP_$C(J+32)
 S TMP=$C(LEN+32)_TMP
 Q TMP
 ;
UUBEGFN(LRFILENM) ; Construct uuencode "begin" coding
 ; Call with LRFILENM = name of uuencoded file attachment
 ; 
 ; Returns LRX = string with "begin..."_file name
 ;
 N LRX
 S LRX="begin 644 "_LRFILENM
 Q LRX
 ;
