LRSRVR6 ;DALIO/JMC - LAB DATA SERVER CONT'D SNOMED EXTRACT ;Aug 17, 2006
 ;;5.2;LAB SERVICE;**346,378**;Sep 27, 1994;Build 1
 ; Produces SNOMED extract via LRLABSERVER option
 ;
 Q
 ;
 ;
SERVER ; Server entry Point
 N I,LRCNT,LREND,LRL,LRMSUBJ,LRST,LRSTN,LRTXT,LRX,LRY
 D BUILD
 S LRMSUBJ=LRST_" "_LRSTN_" SNOMED EXTRACT "_$$HTE^XLFDT($H,"1M")
 D MAILSEND(LRMSUBJ)
 D CLEAN
 Q
 ;
 ;
BUILD ; Build extract
 N J,LRCNT,LRCRLF,LRETIME,LRFN,LRLEX,LRNAME,LRQUIT,LRROOT,LRSCT,LRSCTEC,LRSCTVER,LRSCTX,LRSPEC,LRSTIME,LRSTR,LRVAL,LRVUID,LRX,LRY,X,Y
 ;
 S LRSTIME=$$NOW^XLFDT,LRVAL=$$SITE^VASITE,LRST=$P(LRVAL,"^",3),LRSTN=$P(LRVAL,"^",2),LRSCTVER=""
 I LRST="" S LRST="???"
 K ^TMP($J,"LRDATA")
 S (LRCNT,LRCNT("SCT"))=0,LRCRLF=$C(13,10),LRSTR=""
 F I=61,61.1,61.2,61.3,61.4,61.5,61.6,62 S LRCNT(I)=0,LRCNT(I,"SCT")=0
 D HDR
 ;
 ; Flag to indicate if SNOMED CT is available from LEXICON.
 S LRLEX=0
 I $T(CODE^LEXTRAN)'="" S LRLEX=1
 ;
 F LRFN=61,61.1,61.2,61.3,61.4,61.5,61.6,62  D
 . S LRROOT="^LAB("_LRFN_",""B"")"
 . D FILE
 ;
 S LRETIME=$$NOW^XLFDT
 ; Set the final info into the ^TMP message global
 S LRNODE=$O(^TMP($J,"LRDATA",""),-1)
 I LRSTR'="" S LRNODE=LRNODE+1,^TMP($J,"LRDATA",LRNODE)=$$UUEN^LRSRVR4(LRSTR)
 S ^TMP($J,"LRDATA",LRNODE+1)=" "
 S ^TMP($J,"LRDATA",LRNODE+2)="end"
 ;
 S ^TMP($J,"LRDATA",1)=^TMP($J,"LRDATA",1)_" (Run time:"_$$FMDIFF^XLFDT(LRETIME,LRSTIME,3)_")"
 S ^TMP($J,"LRDATA",3)="SNOMED CT version......: "_LRSCTVER
 S J=6
 S ^TMP($J,"LRDATA",J)="Number of records per file:"
 F I=61,61.1,61.2,61.3,61.4,61.5,61.6,62 D
 . S J=J+1
 . S ^TMP($J,"LRDATA",J)=" "_$$LJ^XLFSTR($$GET1^DID(I,"","","NAME")_" File (#"_I_")",32,".")_": "_$J(LRCNT(I),5)_"  ("_LRCNT(I,"SCT")_" mapped)"
 S ^TMP($J,"LRDATA",J+1)=$$LJ^XLFSTR("Total number of records",33,".")_": "_$J(LRCNT,5)_"  ("_LRCNT("SCT")_" mapped)"
 ;
 Q
 ;
 ;
CLEAN ;
 K ^TMP($J,"LR61")
 K LRIEN,LRLEN,LRNODE,LRSNM,LRSPECN
 D CLEAN^LRSRVR
 D ^%ZISC
 Q
 ;
 ;
FILE ; Search file entry and build record.
 ;
 F  S LRROOT=$Q(@LRROOT) Q:LRROOT=""  Q:$QS(LRROOT,2)'="B"  D
 . Q:$G(@LRROOT)
 . S LRIEN=$QS(LRROOT,4),LRSPEC=""
 . S LRNAME=$P($G(^LAB(LRFN,LRIEN,0)),"^"),LRNAME=$$TRIM^XLFSTR(LRNAME,"RL"," ")
 . S X=$P($G(^LAB(LRFN,LRIEN,0)),"^",2)
 . S LRSNM=$S(LRFN'=62:X,1:"")
 . I LRFN=62 S LRSPEC=X
 . I LRSNM'="",LRFN>60.9,LRFN<61.61 S LRX=((LRFN*10)#610)+1,LRSNM=$E("TMEFDPJ",LRX)_"-"_LRSNM
 . S LRSCT=$P($G(^LAB(LRFN,LRIEN,"SCT")),"^"),(LRSCTEC,LRSCTX,LRVUID)=""
 . I LRLEX,LRSCT'="" D
 . . K LRX
 . . S LRX=$$CODE^LEXTRAN(LRSCT,"SCT",DT,"LRX")
 . . S LRSCTX=$G(LRX("F")),LRSCTEC=$S(LRX<1:$P(LRX,"^",2),1:"")
 . . I LRSCTVER="",LRX>0 S LRSCTVER=$P($G(LRX(0)),"^",3)
 . S LRSTR=LRSTR_LRST_"-"_LRFN_"-"_LRIEN_"|"_LRNAME_"|"_LRSNM_"|"_LRVUID_"|"_LRSCT_"|"_LRSCTX_"|"_LRSCTEC_"|"
 . S LRSPECN="|"
 . I LRFN=62,LRSPEC D
 . . S LRSPECN=$P($G(^LAB(61,LRSPEC,0)),"^")
 . . S LRSPECN=LRSPECN_"|"_LRST_"-61-"_LRSPEC
 . S LRSTR=LRSTR_LRSPECN_"|1.1|"
 . S LRCNT=LRCNT+1,LRCNT(LRFN)=LRCNT(LRFN)+1 S:LRSCT LRCNT("SCT")=LRCNT("SCT")+1,LRCNT(LRFN,"SCT")=LRCNT(LRFN,"SCT")+1
 . D SETDATA
 Q
 ;
 ;
SETDATA ; Set data into report structure
 S LRSTR=LRSTR_LRCRLF
 S LRNODE=$O(^TMP($J,"LRDATA",""),-1)
 D ENCODE^LRSRVR4(.LRSTR)
 Q
 ;
 ;
HDR ; Set the header information
 N LRFILENM
 S LRFILENM=$TR(LRSTN," ","_")_"-"_LRSUB_"-"_$P($$FMTHL7^XLFDT(LRSTIME),"-")_".TXT"
 S ^TMP($J,"LRDATA",1)="Report Generated.......: "_$$FMTE^XLFDT(LRSTIME)_" at "_LRSTN
 S ^TMP($J,"LRDATA",2)="Report requested.......: "_LRSUB
 S ^TMP($J,"LRDATA",3)="SNOMED CT version......: "
 S ^TMP($J,"LRDATA",4)="Extract version........: 1.1"
 F I=5,15,16,18,23 S ^TMP($J,"LRDATA",I)=" "
 S ^TMP($J,"LRDATA",17)="Attached file..........: "_LRFILENM
 S ^TMP($J,"LRDATA",19)="Legend:"
 S X="Station #-File #-IEN|Entry Name|SNOMED I|VUID|SNOMED CT|SNOMED CT TERM|Mapping Exception|Related Specimen|Related Specimen ID|Extract Ver|"
 S ^TMP($J,"LRDATA",20)=X
 S X="           1        |     2    |   3    |  4 |    5    |       6      |        7        |        8       |        9          |    10     |"
 S ^TMP($J,"LRDATA",21)=X
 S ^TMP($J,"LRDATA",22)=$$REPEAT^XLFSTR("-",$L(X))
 S ^TMP($J,"LRDATA",24)=$$UUBEGFN^LRSRVR2A(LRFILENM)
 Q
 ;
 ;
MAILSEND(LRMSUBJ) ; Send extract back to requestor.
 ;
 N LRINSTR,LRTASK,LRTO,XMERR,XMZ
 S LRTO(XQSND)=""
 S LRINSTR("ADDR FLAGS")="R"
 S LRINSTR("FROM")="LAB_PACKAGE"
 S LRMSUBJ=$E(LRMSUBJ,1,65)
 D SENDMSG^XMXAPI(.5,LRMSUBJ,"^TMP($J,""LRDATA"")",.LRTO,.LRINSTR,.LRTASK)
 Q
