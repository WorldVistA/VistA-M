GMRCART ;SLC/DCM,DLT,JFR - Result display logic ;12/17/01 22:39
 ;;3.0;CONSULT/REQUEST TRACKING;**4,15,17,23,22,38**;DEC 27, 1997
 ;
 ; This routine invokes IA #2638,#10060
 ;
RT(GMRCO) ;Result Display logic - called from GMRCA1
 N GMRCCT,GMRCTMP,GMRCSR,GMRCTUFN,GMRCSTS,GMRCMSG
 ;
 S GMRCSR=$P($G(^GMR(123,+GMRCO,0)),"^",15),GMRCTUFN=$P(^(0),"^",20)
 S GMRCSTS=$P($G(^GMR(123,+GMRCO,0)),"^",12)
 I '$$RESOLUS^GMRCAU(GMRCSTS),('+GMRCSR&('GMRCTUFN)) S GMRCMSG="No results available for review." D EXAC^GMRCADC(GMRCMSG),END S GMRCQUT=1 Q
 ;
 W !,"Compiling Result Display..."
 I $D(IOTM),$D(IOBM),$D(IOSTBM) D FULL^VALM1
 K ^TMP("GMRCR",$J,"DT") S GMRCCT=1
 S XQORM("A")="Select Action: "
 S:$D(VALMAR) GMRCVAL=VALMAR
 S GMRCTMP="^TMP(""GMRCR"",$J,""DT"")"
 S GMRCDVL="",$P(GMRCDVL,"-",41)=""
 ;
 D GETRSLT(GMRCTMP)
 ;
 D EN^VALM("GMRC RESULTS DISPLAY")
 S:$D(GMRCVAL) VALMAR=GMRCVAL S:$D(LNCT) VALMCNT=LNCT
 D KILL^VALM10()
 K OREND,ORAGE,ORIO,ORDOB,ORFT,ORHI,ORIFN,ORNP,ORL,ORPD,ORPNM,ORPV,ORSEQ,ORSEX,ORWARD,ORDG
 K GMRCDVL,GMRCLCT,GMRCRPT,GMRCTUFN,GMRCVAL,MCFILE,MCPROC,GMRCX,GMRCTO,GMRCPRNM
 D END
 Q
 ;
GETRSLT(TMPGLOB,GMRCDET) ;load the results into global defined in TMPGLOB
 ;used for GUI formated results and list manager
 ;
 ;I GMRCDET=1 coming from a detailed display not results display
 ;
 N GMRCCT,GMRCCTS,SF,TAB
 S TAB="",$P(TAB," ",31)=""
 S GMRCDVL="",$P(GMRCDVL,"-",41)=""
 K @TMPGLOB,^TMP("GMRCR",$J,"CP")
 S GMRCCT=1
 S:'$D(GMRCDET) GMRCDET=0
 I $L($P(^GMR(123,GMRCO,0),"^",19)) S SF=$P(^(0),"^",19),@TMPGLOB@(GMRCCT,0)="Significant Findings: "_$S(SF="Y":"**Yes**",SF="N":"No",1:"Unknown"),GMRCCT=GMRCCT+1
 ;S @TMPGLOB@(GMRCCT,0)=GMRCDVL_GMRCDVL,GMRCCT=GMRCCT+1 ;GMRCDVL_GMRCDVL
 D PRINT^GMRCTIUP(GMRCO,GMRCCT,1,GMRCDET)
 S GMRCCTS=GMRCCT ;save the line count before printing med and TIU notes
 D GETMCAR
 D GETCP
 D GETRES
 ; I '$D(GMRCDET) D GETREMOT(GMRCO,TMPGLOB,.GMRCCT)
 I GMRCCT=GMRCCTS D  ;check if count changed for notes or med results
 . S:+$L($G(SF)) @TMPGLOB@(GMRCCT,0)=GMRCDVL_GMRCDVL,GMRCCT=GMRCCT+1 ;GMRCDVL_GMRCDVL
 . S @TMPGLOB@(GMRCCT,0)="No local TIU results or Medicine results available for this consult"
 . S GMRCCT=GMRCCT+1
 ;
 I '$D(GMRCDET) D GETCOM
 I GMRCCT>2 S @TMPGLOB@(GMRCCT,0)="",$P(@TMPGLOB@(GMRCCT,0),"=",81)="",GMRCCT=GMRCCT+1
 Q
 ;
GETMCAR ;load the medicine results into TMPGLOB
 Q:'$O(^TMP("GMRCR",$J,"MCAR",0))
 N ND,ND1
 S ND=0 F  S ND=$O(^TMP("GMRCR",$J,"MCAR",ND)) Q:ND=""!(ND?1A.E)  D
 .S @TMPGLOB@(GMRCCT,0)="",$P(^(0),"-",80)="",GMRCCT=GMRCCT+1
 .S @TMPGLOB@(GMRCCT,0)=TAB_"Medicine Package Report",GMRCCT=GMRCCT+1
 .S ND1=0 F  S ND1=$O(^TMP("GMRCR",$J,"MCAR",ND,ND1)) Q:ND1=""  S @TMPGLOB@(GMRCCT,0)=^TMP("GMRCR",$J,"MCAR",ND,ND1,0),GMRCCT=GMRCCT+1
 .Q
 K ^TMP("GMRCR",$J,"MCAR")
 Q
 ;
GETCP ; Load up any Clin. Proc. results
 Q:'$O(^TMP("GMRCR",$J,"CP",0))
 N ND,ND1
 S ND=0 F  S ND=$O(^TMP("GMRCR",$J,"CP",ND)) Q:ND=""!(ND?1A.E)  D
 .S @TMPGLOB@(GMRCCT,0)="",$P(^(0),"-",80)="",GMRCCT=GMRCCT+1
 .S @TMPGLOB@(GMRCCT,0)=TAB_"Clinical Procedure Report",GMRCCT=GMRCCT+1
 .S ND1=0 F  S ND1=$O(^TMP("GMRCR",$J,"CP",ND,ND1)) Q:ND1=""  D
 .. S @TMPGLOB@(GMRCCT,0)=^TMP("GMRCR",$J,"CP",ND,ND1,0),GMRCCT=GMRCCT+1
 .Q
 K ^TMP("GMRCR",$J,"CP")
 Q
 ;
GETRES ;load the TIU notes into TMPGLOB
 Q:'+$O(^TMP("GMRCR",$J,"RES",0))
 ;
 N ND,ND1
 S ND=0 F  S ND=$O(^TMP("GMRCR",$J,"RES",ND)) Q:(ND="")!(ND?1A.E)  D
 . I $D(^TMP("GMRCR",$J,"RES",ND,"TEXT","GMRCRPT")) D
 . . S @TMPGLOB@(GMRCCT,0)="",GMRCCT=GMRCCT+1
 . . S @TMPGLOB@(GMRCCT,0)=$E(GMRCDVL,1,80-$L(^TMP("GMRCR",$J,"RES",ND,"TEXT","GMRCRPT"))\2)_^("GMRCRPT")_$E(GMRCDVL,1,80-$L(^("GMRCRPT"))\2)
 . . S GMRCCT=GMRCCT+1
 . S:'$D(^TMP("GMRCR",$J,"RES",ND,"TEXT","GMRCRPT")) @TMPGLOB@(GMRCCT,0)=GMRCDVL_GMRCDVL,GMRCCT=GMRCCT+1
 . S:$O(^TMP("GMRCR",$J,"RES",ND,"TEXT",0)) @TMPGLOB@(GMRCCT,0)="",GMRCCT=GMRCCT+1
 . S ND1=0 F  S ND1=$O(^TMP("GMRCR",$J,"RES",ND,"TEXT",ND1)) Q:ND1?1A.E!(ND1="")  S @TMPGLOB@(GMRCCT,0)=^TMP("GMRCR",$J,"RES",ND,"TEXT",ND1,0),GMRCCT=GMRCCT+1
 . I $O(^TMP("GMRCR",$J,"RES",ND,"ADD",0)) S ND1=0 F  S ND1=$O(^TMP("GMRCR",$J,"RES",ND,"ADD",ND1)) Q:ND1=""   D
 . . S @TMPGLOB@(GMRCCT,0)="",GMRCCT=GMRCCT+1
 . . S @TMPGLOB@(GMRCCT,0)=TAB_"ADDENDUM TO REPORT",GMRCCT=GMRCCT+1
 . . S ND2=0 F  S ND2=$O(^TMP("GMRCR",$J,"RES",ND,"ADD",ND1,ND2)) Q:ND2=""!(ND2?1A.E)  S @TMPGLOB@(GMRCCT,0)=^TMP("GMRCR",$J,"RES",ND,"ADD",ND1,ND2,0),GMRCCT=GMRCCT+1
 . . Q
 . Q
 K ^TMP("GMRCR",$J,"RES")
 Q
 ;
GETCOM ;Get the comments for resolution actions
 S GMRCSTS=$P($G(^GMR(123,+GMRCO,0)),"^",12)
 Q:'$$RESOLUS^GMRCAU(+GMRCSTS) 
 ;
 ;Loop thru actions to find the resolution type actions
 N ND,ND1,ND2
 S ND="" F  S ND=$O(^GMR(123,+GMRCO,40,"B",ND)) Q:ND=""  S ND1=$O(^GMR(123,+GMRCO,40,"B",ND,"")) D
 . ;
 . ;Check for resulting action types:complete,sig finding,dc,cancel
 . N GMRCAIEN
 . S GMRCAIEN=$P($G(^GMR(123,+GMRCO,40,ND1,0)),"^",2)
 . I '$$RESOLUA^GMRCAU(GMRCAIEN) Q
 . ;
 . ;save the action header info in case there are comments
 . N GMRCAHDR,GMRCPROV,GMRCENBY,GMRCENDT
 . D SAVEHDR
 . ;
 . ;check for comments, print header on first pass
 . S ND2=0
 . F  S ND2=$O(^GMR(123,GMRCO,40,ND1,1,ND2)) Q:ND2=""  D
 . . I +$G(GMRCAHDR) D GETHDR ;GMRCAHDR will =1 on first pass
 . . S @TMPGLOB@(GMRCCT,0)=^GMR(123,GMRCO,40,ND1,1,ND2,0),GMRCCT=GMRCCT+1
 . . Q
 . Q
 Q
 ;
SAVEHDR ;Save the action header info to print later if there are comments
 S GMRCAHDR=1 ;flag to print action header on first pass of comments
 ;save the provider, entered by and date
 S GMRCPROV=$P(^GMR(123,GMRCO,40,ND1,0),"^",4),GMRCENBY=$P(^(0),"^",5)
 S GMRCENDT=$$FMTE^XLFDT($P($G(^GMR(123,GMRCO,40,ND1,0)),"^",3))
 Q
 ;
GETHDR ;Print the comment header if the action had a comment
 S @TMPGLOB@(GMRCCT,0)="",GMRCCT=GMRCCT+1
 S @TMPGLOB@(GMRCCT,0)=$$CENTER^GMRCP5D("("_$P($G(^GMR(123.1,GMRCAIEN,0)),"^",8)_" Comment)"),GMRCCT=GMRCCT+1
 S @TMPGLOB@(GMRCCT,0)="      Entered by: "_$S($L(GMRCENBY):$P(^VA(200,GMRCENBY,0),"^",1),1:"")_" - "_GMRCENDT,GMRCCT=GMRCCT+1
 I +GMRCPROV S @TMPGLOB@(GMRCCT,0)="      Responsible Clinician: "_$P($G(^VA(200,GMRCPROV,0)),"^",1),GMRCCT=GMRCCT+1
 K GMRCAHDR
 Q
 ;
GETREMOT(GMRCDA,GMRCAR,GMRCNT) ;retrieve remote results and load up in display
 ; Input:
 ; GMRCDA  = consult ien from file 123
 ; GMRCAR  = array to return results in (e.g. $NA(^TMP("GMRCAR",$J)) )
 ; GMRCNT  = number within GMRCAR to start placing results (pass by ref)
 ;
 ;Output:
 ; array containing remote results in format:
 ;   ^TMP("GMRCAR",$J,1,0)= result text line 1
 ;   ^TMP("GMRCAR",$J,2,0)= result text line 2
 ;
 I '$O(^GMR(123,GMRCDA,51,0)) Q  ;no remote results
 N HDR,GMRCREM,GMRCDATA,FTR,GMRCIO
 S @GMRCAR@(GMRCNT,0)="",GMRCNT=GMRCNT+1
 S HDR=$$REPEAT^XLFSTR("*",31)_" REMOTE RESULTS "_$$REPEAT^XLFSTR("*",31)
 S FTR=$$REPEAT^XLFSTR("*",27)_" END OF REMOTE RESULTS "_$$REPEAT^XLFSTR("*",28)
 S @GMRCAR@(GMRCNT,0)=HDR,GMRCNT=GMRCNT+1
 S @GMRCAR@(GMRCNT,0)="",GMRCNT=GMRCNT+1
 S GMRCREM=0 F  S GMRCREM=$O(^GMR(123,GMRCDA,51,GMRCREM)) Q:'GMRCREM  D
 . N GMRCSITE,GMRCRES,GMRCSTA,GMRCRPC,GMRCREM0
 . S GMRCREM0=^GMR(123,GMRCDA,51,GMRCREM,0) Q:'$L(GMRCREM0)
 . S GMRCSTA=$$STA^XUAF4($P(GMRCREM0,U,3))
 . D F4^XUAF4(GMRCSTA,.GMRCSITE) I '+GMRCSITE Q
 . S GMRCRES=$P(GMRCREM0,U,2)_","
 . I GMRCRES["TIU" S GMRCRPC="TIU GET RECORD TEXT",GMRCRES=+GMRCRES
 . I GMRCRES["MCAR" S GMRCRPC="ORQQCN GET MED RESULT DETAILS"
 . D SAVDEV^%ZISUTL("GMRCIO") ; save off current device settings
 . D DIRECT^XWB2HL7(.GMRCDATA,GMRCSTA,GMRCRPC,"0",GMRCRES)
 . D USE^%ZISUTL("GMRCIO") ; restore IO to previous settings
 . D RMDEV^%ZISUTL("GMRCIO") ; kills data saved in GMRCIO
 . I '$D(GMRCDATA) Q
 . S @GMRCAR@(GMRCNT,0)=$$CJ^XLFSTR($S(GMRCRES["MCAR":"Medicine report from:",1:"TIU Document from:"),80),GMRCNT=GMRCNT+1
 . S @GMRCAR@(GMRCNT,0)=$$CJ^XLFSTR(GMRCSITE("NAME"),80)
 . S GMRCNT=GMRCNT+1
 . S @GMRCAR@(GMRCNT,0)=$$CJ^XLFSTR("Associated on: "_$$FMTE^XLFDT(+GMRCREM0),80),GMRCNT=GMRCNT+1
 . S @GMRCAR@(GMRCNT,0)="",GMRCNT=GMRCNT+1
 . N GMRCQT S GMRCQT=0
 . I '$L($G(GMRCDATA)) D
 .. N I S I="" F  S I=$O(GMRCDATA(I)) Q:I=""!(GMRCQT)  D
 ... I $P(GMRCDATA(I),U)=-1 D  S GMRCQT=1 Q
 .... S @GMRCAR@(GMRCNT,0)="Report not currently available"
 .... S GMRCNT=GMRCNT+1
 ... S @GMRCAR@(GMRCNT,0)=GMRCDATA(I),GMRCNT=GMRCNT+1
 . I $L($G(GMRCDATA)),$D(@GMRCDATA) D
 .. N I S I="" F  S I=$O(@GMRCDATA@(I)) Q:I=""!(GMRCQT)  D
 ... I $P(@GMRCDATA@(I),U)=-1 D  S GMRCQT=1 Q
 .... S @GMRCAR@(GMRCNT,0)="Report not currently available"
 .... S GMRCNT=GMRCNT+1
 ... S @GMRCAR@(GMRCNT,0)=@GMRCDATA@(I),GMRCNT=GMRCNT+1
 .. K @GMRCDATA
 . K GMRCDATA
 . Q
 S @GMRCAR@(GMRCNT,0)="",GMRCNT=GMRCNT+1
 S @GMRCAR@(GMRCNT,0)=FTR,GMRCNT=GMRCNT+1
 S @GMRCAR@(GMRCNT,0)=""
 Q
 ;
END ;kill off variables and exit
 I $D(DTOUT)!$D(DIROUT) S GMRCQIT=""
 K DTOUT,DIROUT,DUOUT
 S:$D(^TMP("GMRC",$J,"CURRENT","MENU")) XQORM("HIJACK")=^("MENU")
 Q
