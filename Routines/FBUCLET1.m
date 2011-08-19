FBUCLET1 ;ALBISC/TET - UNAUTHORIZED CLAIM LETTER (continued) ;29/NOV/2006
 ;;3.5;FEE BASIS;**12,23,32,38,101**;JAN 30, 1995;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
PRINT ;print letter, don't update if variable fbnoup exists
 ;INPUT:  FBDA = ien of unauthorized claim, file 162.7
 ;        FBORDER = (optional) order number of status
 ;        FBUCA = current (after) zero node of unauthorized claim (162.7)
 ;        FBUC = unauthorized claim node in parameter file
 ;        FBNOUP = 1 if no update is to occur, optional, set in reprint
 ;        FBFF = counter flag, suppresses formfeed if = 0
 ;        FBCOPIES = # of copies to print, optional, not set from auto
 ;        FBSTANUM = station number
 ;        FBSADD( array = station address, if site parameter designates letterhead not used
 ;VAR     FBADD( = address array to where letter is mailed
 ;        FBADDCC( = address array for carbon copy
 ;        FBCC = flag, true if CC address should print at bottom of page
 ;        FBCCI = # used to determine where CC address prints
 ;        FBTAMT = $ amount calculated in routine FBUCLET2 for an
 ;                 approved or approved to stabilization disposition
 ;                 letter. Used to populate field #14 in file #162.7.
 ;OUTPUT: none - print letter and update fields, if '$d(fbnoup), upon completion
 N FBADD,FBADDCC,FBAUTH,FBC,FBEP,FBLETDT,FBLIEN,FBMCODE,FBNAM,FBNAM1
 N FBPROG,FBRE,FBSUBMIT,FBTAMT,FBCC,FBCCI
 S FBLETDT=0 S:FBORDER']"" FBORDER=$$ORDER^FBUCUTL(FBDA) S ZTSTOP=$$S^%ZTLOAD
 D ADDRESS^FBUCUTL2(FBUCA)
 S FBSUBMIT=$P(FBUCA,U,23),FBPROG=$$PROG^FBUCUTL(+$P(FBUCA,U,2))
 S FBNAM=$S(FBSUBMIT["FBAAV("!(FBSUBMIT["VA(200,"):$$VET^FBUCUTL(+$P(FBUCA,U,4)),1:$$VEN^FBUCUTL(+$P(FBUCA,U,3))) I FBNAM["," S FBNAM=$P(FBNAM,",",2)_" "_$P(FBNAM,",")
 I FBSUBMIT'["DPT(" S FBNAM1=$$VEN^FBUCUTL(+$P(FBUCA,U,3)) I FBNAM1["," S FBNAM1=$P(FBNAM1,",",2)_" "_$P(FBNAM1,",")
 ;
 ; Utilize new API for Name Standardization
 ;
 I FBNAM'="UNKNOWN",FBSUBMIT["FBAAV("!(FBSUBMIT["VA(200,") D
 .S FBNAM=$$GETNAME(+$P(FBUCA,U,4),2,"G","")
 .Q
 ;
 S FBRE=$S(FBSUBMIT']""!(FBSUBMIT["DPT("):"VENDOR:",1:"VETERAN:")
 S FBEP=$$FMTE^XLFDT(+$P(FBUCA,U,5)) S:$P(FBUCA,U,6)'=$P(FBUCA,U,5) FBEP=FBEP_"^"_$$FMTE^XLFDT(+$P(FBUCA,U,6))
 S FBAUTH=$$FMTE^XLFDT(+$P(FBUCA,U,13)) S:$P(FBUCA,U,14)'=$P(FBUCA,U,13) FBAUTH=FBAUTH_"^"_$$FMTE^XLFDT(+$P(FBUCA,U,14))
 S FBLIEN=$$LETTER^FBUCUTL2(FBORDER,+$P(FBUCA,U,28))
 S FBMCODE=$$GET1^DIQ(161.4,1,5.5) ; Load Mail Code
 I '$D(FBCOPIES) S FBCOPIES=$S($P(FBUC,U,4):$P(FBUC,U,4),1:1)
 I FBLIEN F FBC=1:1:FBCOPIES D
 .N DIWF,DIWL,FBEXP,FBI,FBDL1
 .;set flag true when disposition letter to indicate that a CC address
 .;needs to be printed at the bottom of the first page
 .S FBCC=$S(FBORDER>20:1,1:0)
 .;set FBCCI = blank lines before address (2) + max address lines (5) +
 .; # of lines after address from site parameters + a constant (2)
 .;S FBCCI=2+5+$S($P(FBUC,U,10)]"":$P(FBUC,U,10),1:9)+2 ; default param
 .S FBCCI=2+5+$P(FBUC,U,10)+2
 .S FBFF=FBFF+1 W:FBFF&(FBFF>1) @IOF W !
 .W:$P(FBUC,U,8) !!!!! D:'$P(FBUC,U,8)
 ..N FBI,FBX,FBCT S (FBCT,FBI)=0 F  S FBI=$O(FBSADD(FBI)) Q:'FBI  S FBX=FBSADD(FBI) W !?(IOM-$L(FBX)/2),FBX S FBCT=FBCT+1
 ..S FBCT=5-FBCT I FBCT>0 F FBI=1:1:FBCT W ! ;ensure length of header is consistant
 .W !?4,$$PDATE^FBUCUTL2(DT),!
 .W:'$P(FBUC,U,8) ?47,"In Reply Refer To: " W ?66,FBSTANUM,"/",FBMCODE
 .W !?50,$$GETNAME(+$P(FBUCA,U,4),2,"F","C")
 .S (FBCT,FBI)=0 F  S FBI=$O(FBADD(FBI)) Q:'FBI  W !?4,FBADD(FBI) S FBCT=FBCT+1 I FBI=1 W ?50,$$SSNL4^FBAAUTL($$SSN^FBAAUTL(+$P(FBUCA,U,4)))
 .D HED
 .S DIWF="WC79I4",DIWL=1 D:$Y+$S(FBCCI>10&FBCC:FBCCI,1:10)>IOSL PAGE D TXT^FBUCUTL2("^FBAA(161.3,",FBLIEN,1,DIWF,DIWL,1,.FBCC,FBCCI) W !
 .S DIWF="WC72I8",DIWL=1
 .I FBORDER>20 D:$Y+$S(FBCCI>10&FBCC:FBCCI,1:10)>IOSL PAGE D TXT^FBUCUTL2("^FB(162.91,",+$P(FBUCA,U,11),$S(+$P(FBUCA,U,28):2,1:1),DIWF,DIWL,1,.FBCC,FBCCI) D
 ..; if approved (or approved to stabilization) then include details
 ..I $P(FBUCA,U,11)=1!($P(FBUCA,U,11)=4) D AUTHPR^FBUCLET2
 ..I +$P(FBUCA,U,11)'=1,+$O(^FB583(FBDA,"D",0)) D:$Y+$S(FBCCI>10&FBCC:FBCCI,1:10)>IOSL PAGE W !?8,"Reason(s) for not approving "_$S($P(FBUCA,U,11)=4:"entire ",1:"")_"claim:" D
 ...N DIWF,FBI,FBZ S DIWF="WC69I8",FBI=0 F  S FBI=$O(^FB583(FBDA,"D",FBI)) Q:'FBI  S FBZ=^(FBI,0) D:$Y+$S(FBCCI>8&FBCC:FBCCI,1:8)>IOSL PAGE W ! D TXT^FBUCUTL2("^FB(162.94,",+FBZ,1,DIWF,DIWL,1,.FBCC,FBCCI)
 ..;
 ..;print optional disposition remarks for the claim
 ..I FBORDER>20 D
 ...N DIWF,DIWL,FBN
 ...; select appropriate wp field based on status (appeal, cova, initial)
 ...S FBN=$S(FBORDER=70:"""A1""",FBORDER=90:"""A2""",1:4)
 ...Q:'$O(^FB583(FBDA,FBN,0))  ; no remarks on file
 ...D:$Y+$S(FBCCI>7&FBCC:FBCCI,1:7)>IOSL PAGE
 ...W !
 ...S DIWF="WC72I8",DIWL=1
 ...D TXT^FBUCUTL2("^FB583(",FBDA,FBN,DIWF,DIWL,1,.FBCC,FBCCI)
 ..;
 ..;print additional description text (if any) for disposition
 ..I $O(^FB(162.91,+$P(FBUCA,U,11),3,0)) D
 ...N DIWF,DIWL
 ...D:$Y+$S(FBCCI>10&FBCC:FBCCI,1:10)>IOSL PAGE
 ...W !
 ...S DIWF="WC72I8",DIWL=1
 ...D TXT^FBUCUTL2("^FB(162.91,",+$P(FBUCA,U,11),3,DIWF,DIWL,1,.FBCC,FBCCI)
 .I FBORDER'>20 S FBI=0 F  S FBI=$O(^FBAA(162.8,"AC",FBDA,FBI)) Q:'FBI  S FBZ=$G(^FBAA(162.8,FBI,0)) I '$P(FBZ,U,5) D:$Y+$S(FBCCI>12&FBCC:FBCCI,1:12)>IOSL PAGE D
 ..N FBX W ! S FBX=$P($G(^FB(162.93,+$P(FBZ,U,3),0)),U) I FBX="OTHER" S:$P(FBZ,U,4)]"" FBX=$P(FBZ,U,4) W ?8,FBX,! Q
 ..D TXT^FBUCUTL2("^FB(162.93,",+$P(FBZ,U,3),1,DIWF,DIWL,1,.FBCC,FBCCI)
 .S DIWF="WC79I4",DIWL=1 D:($Y+4+$S(FBCCI>$S(FBORDER>20:15,1:22)&FBCC:FBCCI,FBORDER>20:15,1:22))>IOSL PAGE W ! D TXT^FBUCUTL2("^FBAA(161.3,",FBLIEN,2,DIWF,DIWL,1,.FBCC,FBCCI)
 .;print postscript (if any) on request info. letter
 .I FBORDER'>20 S FBI=0 F  S FBI=$O(^FBAA(162.8,"AC",FBDA,FBI)) Q:'FBI  S FBZ=$G(^FBAA(162.8,FBI,0)) I '$P(FBZ,U,5) D
 ..N FBX,FBPS
 ..Q:'$O(^FB(162.93,+$P(FBZ,U,3),2,0))  ; no postscript to print
 ..;start new page
 ..S FBPS=1 D PAGE S FBPS=0
 ..W !!
 ..;print text
 ..S FBX=$P($G(^FB(162.93,+$P(FBZ,U,3),0)),U)
 ..I FBX="SIGNED STATEMENT FROM CLAIMANT",$P(FBZ,U,4)]"",$E($P(FBZ,U,4),1)=0 D
 ...; just print statement since user specified that regulations should
 ...; not be printed (stop after line 11 of postscript)
 ...N FBI,FBTXT
 ...S FBI=0 F  S FBI=$O(^FB(162.93,+$P(FBZ,U,3),2,FBI)) Q:FBI>11!'FBI  D
 ....S FBTXT=^FB(162.93,+$P(FBZ,U,3),2,FBI,0),X=FBTXT
 ....I $Y+$S(FBCCI>7&FBCC:FBCCI,1:7)>IOSL D PAGE
 ....D ^DIWP
 ...I $Y+$S(FBCCI>7&FBCC:FBCCI,1:7)>IOSL D PAGE
 ...D:$D(FBTXT) ^DIWW
 ..E  D TXT^FBUCUTL2("^FB(162.93,",+$P(FBZ,U,3),2,DIWF,DIWL,1,.FBCC,FBCCI) ;entire ps
 .;if still on 1st page of disposition letter then print the CC address
 .I FBCC D CCADDR
 ;
 I '$D(FBNOUP) D
 .D:$D(XRTL) T0^%ZOSV ;start monitor
 .S FBEXP=$$EXPIRE^FBUCUTL8(FBDA,DT,FBUCA,FBORDER)
 .D EDITL^FBUCED(FBDA,FBEXP,"@",DT,$G(FBTAMT))
 .S:$D(XRT0) XRTN=$T(+0) D:$D(XRT0) T1^%ZOSV ;stop monitor
 Q
 ;
GETNAME(FBIEN,FBFILE,FBFMT,FBFLAG) ;
 N FBNAMES
 I FBIEN=""!(FBFILE)="" Q ""  ; Quit if there is no IEN or File number
 S FBFMT=$G(FBFMT),FBFLAG=$G(FBFLAG)
 S FBNAMES("FILE")=FBFILE,FBNAMES("IENS")=FBIEN,FBNAMES("FIELD")=.01
 S FBNAMES=$$NAMEFMT^XLFNAME(.FBNAMES,FBFMT,FBFLAG)
 Q FBNAMES
 ;
PAGE ;new page
 ;print CC address at bottom of 1st page on disposition letters
 I FBCC D CCADDR
 W @IOF,!!!!!!!
 ; if called from 1st page of postscript print then include more info
 I $G(FBPS)=1 D
 .W:'$P(FBUC,U,8) ?47,"In Reply Refer To: " W ?66,FBSTANUM,"/",FBMCODE
 .W !?50,$$GETNAME(+$P(FBUCA,U,4),2,"F","C")
 .W !?50,$$SSNL4^FBAAUTL($$SSN^FBAAUTL(+$P(FBUCA,U,4)))
HED ;header to print after address and on each new page
 W !!!!?8,"REGARDING:",?20,FBRE,?38,FBNAM I $D(FBNAM1) W !?20,"VENDOR:",?38,FBNAM1
 W !?20,"FEE PROGRAM:",?38,FBPROG
 W !?20,"EPISODE OF CARE:",?38,$P(FBEP,U) W:$P(FBEP,U,2)]"" " to ",$P(FBEP,U,2)
 W !!
 Q
CCADDR ; print CC address at bottom of page
 ; advance to bottom of page
 N FBI
 F FBI=$Y+FBCCI-1:1:$S(IOSL>120:$Y+FBCCI,1:IOSL) W !
 ; print CC address lines
 S FBI=0
 F  S FBI=$O(FBADDCC(FBI)) Q:'FBI  W ! W:FBI=1 " CC:" W ?4,FBADDCC(FBI)
 ;set flag to false since CC address has been printed
 S FBCC=0
 Q
