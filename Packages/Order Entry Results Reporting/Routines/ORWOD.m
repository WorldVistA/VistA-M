ORWOD ; SLC/GSS - Utility for Order Dialogs ; 7/24/09 9:55am
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**243,296,280,322**;DEC 17, 1997;Build 15
 ;
 ; DBIA 5133: reading ^PXRMD file #801.41
 ; 
 Q
 ;
INSTALL ;Post-install entry point for OR*3*243
 D MAIN
 Q
 ;
ATWILL ;Entry point for ORDER MENU MANAGEMENT menu - ORCM MGMT opt MR
 W !,"This option generates two Quick Order (QO) reports to assist in the"
 W !,"evaluation of Med QOs that may need to be updated to accommodate the"
 W !,"three new fields exported in CPRS GUI v27:  Route, IV Type and Schedule."
 W !,"One report lists Med QOs that are contained in another entry such as an"
 W !,"order menu, order set or reminder dialog. The other report lists Med QOs"
 W !,"that are stand alone and are not included in another entry. These reports"
 W !,"will be sent to you via Mailman.",!
 S DIR(0)="FAO",DIR("A")="Do you wish to continue? " D ^DIR Q:X=""!(X="^")
 S ORCDD=$TR(X,"yn","YN") I ORCDD'="Y",ORCDD'="N" W "  Enter Y or N",! G ATWILL
 I ORCDD="N" W "...report not compiled" Q  ;DJE/VM *322 X changed to ORCDD
 W !,"Compiling Med Quick Order check report..."
 D MAIN
 W !,"...QO check report compiled and mailed to ",$P(^VA(200,DUZ,0),U)
 Q
 ;
MAIN ;Main calls for QO Reports
 N ANCSTR,I,PSJNOPC,XMDUN,XMSUB
 D NTRY
 ; ANCSTR='ancestors', i.e., QO being used on a menu/Reminder Dialogs
 F ANCSTR="Y","N" D
 . D MAILSU
 . D SEND(XMSUB,DUZ)
 D CLEANUP
 Q
 ;
ANCSTR ;Determine QO usage - called by XSET and MM
 S ANCSTR="N"
 I $O(^ORD(101.41,"AD",ODIENXT,0))!($D(^TMP("OR",$J,"RD",ODIENXT))=0) S ANCSTR="Y"
 Q
 ;
XSET ;Set QO record for display
 D ANCSTR
 S RC=ODIENXT_U_$P(REC,U)_U_$P(REC,U,2)_U_$G(ODATYPE)_U_$G(ODAROUTE)_U_$G(ODASCHD)_U_$G(ODARATE)_U_$G(ODALIMIT)
 Q
 ;
NTRY ;Compiling report
 N AFIND,DIEN,DOSE,DSPLGRP,DSPLGPTR,GETXT,HIT,NODE3,ODALIMIT,ODARATE,ODAROUTE,ODASCHD,ODATYPE,ODIEN,ODIENXT,ORDIALOG,PTEXT,PTYPE,RC,REC,TYPE,XSET
 K ^TMP("OR",$J)
 S (DSPLGRP,DSPLGPTR,ODIEN,ODIENXT,TYPE)=""
 S XSET="S RC=ODIENXT_U_$P(REC,U)_U_$P(REC,U,2)_U_$G(ODATYPE)_U_$G(ODAROUTE)_U_$G(ODASCHD)_U_$G(ODARATE)_U_$G(ODALIMIT)"
 S DOSE=+$O(^ORD(101.41,"B","OR GTX INSTRUCTIONS",0))  ;use for MM tag
 ;
 ; Order Dialogs Structure, Menus - orig code by A.Puleo
 ; Reminder Dialog Type: (PTYPE) E=Dialog Element, G=Dialog Group
 F PTYPE="G","E" S DIEN="" D
 . F  S DIEN=$O(^PXRMD(801.41,"TYPE",PTYPE,DIEN)) Q:DIEN'>0  D  ;DBIA 5133
 .. ; PTEXT is 'FINDING ITEM' where 101.41 refers to ^ORD(101.41)
 .. ; Example: ^PXRMD(801.41,2515,1)="^^3^^51;ORD(101.41,"
 .. S PTEXT=$P($G(^PXRMD(801.41,DIEN,1)),U,5),AFIND=""
 .. I PTEXT[101.41 S ^TMP("OR",$J,"RD",$P(PTEXT,";"))=DIEN
 .. F  S AFIND=$O(^PXRMD(801.41,DIEN,3,"B",AFIND)) Q:AFIND=""  D
 ... I AFIND[101.41 S ^TMP("OR",$J,"RD",$P(AFIND,";"))=DIEN
 ;
 ; find IEN for the 'PSJI OR PAT FLUID OE' entry in Order Dialog File
 S ODIEN=$O(^ORD(101.41,"AB","PSJI OR PAT FLUID OE",0))
 ; 
 ; loop thru Display Group File, file # 100.98 & store all
 ; Display Group entries that have a pointer to 'PSJI OR PAT FLUID OE'
 ; in field # 4 or Default Dialog field
 F  S DSPLGRP=$O(^ORD(100.98,DSPLGRP)) Q:DSPLGRP'?1N.N  D
 . I ODIEN=$P($G(^ORD(100.98,DSPLGRP,0)),U,4) S ^TMP("OR",$J,"DG",DSPLGRP)=ODIEN
 ;
 ; loop though Order Dialog file to
 ; find each entry that is an IV Quick Order. Do this by checking
 ; field #4 or TYPE field for a 'Q' & then check field #5 or
 ; DISPLAY GROUP field for a pointer to one of the display groups found
 ; above. If both conditions are true then continue to next step,
 ; if not, continue looping.
 F  S ODIENXT=$O(^ORD(101.41,ODIENXT)) Q:ODIENXT'?1N.N  D
 . D MM
 . S TYPE=$P($G(^ORD(101.41,ODIENXT,0)),U,4) Q:TYPE'="Q"
 . S DSPLGPTR=$P($G(^ORD(101.41,ODIENXT,0)),U,5) Q:$G(DSPLGPTR)=""  ;no display group pointer in QO
 . Q:'$G(^TMP("OR",$J,"DG",DSPLGPTR))  ;no such display group in compiled data
 . S REC=^ORD(101.41,ODIENXT,0)
 . ;
 . K ORDIALOG
 . ; call GETQDLG^ORCD to build the Order dialog array (ORDIALOG())
 . D GETQDLG^ORCD(ODIENXT) S (HIT)=0
 . ;
 . ;ZW ORDIALOG("B")  ;ORDIALOG() listing
 . ; set variables for 'TYPE' (IV TYPE), 'ROUTE', 'SCHEDULE', 'RATE', 'LIMITATION'
 . F I=1:1:5 S @($P("ODATYPE,ODAROUTE,ODASCHD,ODARATE,ODALIMIT",",",I))=$G(ORDIALOG($P($G(ORDIALOG("B",$P("TYPE,ROUTE,SCHEDULE,INFUSION RATE,LIMITATION",",",I))),U,2),1))
 . ;
 . ; Quick Orders to be displayed to end user in First List Message follow:
 . ;
 . ; IV TYPE is null or ROUTE is null
 . I (ODATYPE=""!(ODAROUTE="")) D XSET S ^TMP("OR",$J,"QO",ANCSTR,$P(REC,U),1,1,0)=RC,HIT=1
 . ;
 . ; IV TYPE is 'I' and SCHEDULE is null
 . I ODATYPE="I"&(ODASCHD="") D XSET S ^TMP("OR",$J,"QO",ANCSTR,$P(REC,U),2,1,0)=RC,HIT=1
 . ;
 . ; IV TYPE is not 'C' or null or RATE is not 1-4#.1#, integer or '@'
 . I ODATYPE="C"!(ODATYPE="") D
 .. Q:ODARATE["@"
 .. Q:ODARATE?1.4N!(ODARATE?1.4N1".".1N)  ;integers alone OK
 .. S GETXT=$$GETXT(ODARATE," ml/hr")
 .. Q:GETXT?1.4N!(GETXT?1.4N1".".1N)  ;# ml/hr & #.# ml/hr Rate OK
 .. D XSET S ^TMP("OR",$J,"QO",ANCSTR,$P(REC,U),3,1,0)=RC,HIT=1
 . ;
 . ; IV TYPE is 'I' but RATE not an integer minute or hour or null
 . I ODATYPE="I"&(ODARATE'?1.N)&(ODARATE'="") D  ;integer alone OK
 .. S GETXT=$$GETXT(ODARATE," Minutes| Hours")
 .. Q:GETXT?1.3N  ;integer # Minutes & # Hours Rate OK
 .. D XSET S ^TMP("OR",$J,"QO",ANCSTR,$P(REC,U),4,1,0)=RC,HIT=1
 . ;
 . ; IV LIMIT or Duration (LIMITATION) was not integer or null
 . I ODALIMIT'?.N,ODALIMIT'="" D
 .. Q:ODALIMIT?1.2N1"D"!(ODALIMIT?1.3N1"H")!(ODALIMIT?1.4N1"ML")!(ODALIMIT?1.4N1" ML")!(ODALIMIT?1.2N1"L")!(ODALIMIT?1.4N1"CC")!(ODALIMIT?1.4N1" CC")  ;#D, #H, #ML, #L, #CC Limit OK
 .. Q:ODALIMIT?1.2N1"d"!(ODALIMIT?1.3N1"h")!(ODALIMIT?1.4N1"ml")!(ODALIMIT?1.4n1" ml")!(ODALIMIT?1.2N1"l")!(ODALIMIT?1.4N1"cc")!(ODALIMIT?1.4N1" cc")  ;#d, #h, #ml, #l, #cc Limit OK
 .. Q:ODALIMIT?1"for "1.2N1" days"  ;for # days OK
 .. Q:ODALIMIT?1.5N1"DOSES"!(ODALIMIT?1"for a total of "1.5N1" doses")  ;for a total of # doses OK
 .. Q:ODALIMIT?1"with total volume "1.2N1"L"!(ODALIMIT?1"with total volume "1.4N1"ml")
 .. Q:ODALIMIT?1"for "1.2N1" hours"
 .. D XSET S ^TMP("OR",$J,"QO",ANCSTR,$P(REC,U),5,1,0)=RC,HIT=1
 . ;
 . ;AGP If IV TYPE="C" and the numbers Additive Frequency do not match the number
 . ;of additives
 . I ODATYPE="C",$$IVADFCHK^ORWDXM3(.ORDIALOG)=0 D
 ..D XSET S ^TMP("OR",$J,"QO",ANCSTR,$P(REC,U),8,1,0)=RC,HIT=1
 . ;
 . ; Go get next Order Dialog entry if no problems
 . I 'HIT Q
 . ;
 . ; If Quick Order is in First List message then check
 . ; the Order Dialog file #101.41, field #58 or AUTO-ACCEPT QUICK ORDER
 . ; field.  If field #58 is set to 'Y'es then set the field to 'N'o and
 . ; then display this Quick Order in the Second List.
 . I +$P($G(^ORD(101.41,ODIENXT,5)),U,8) D
 .. S $P(^ORD(101.41,ODIENXT,5),U,8)=""  ;uncommented, sets AUTO-ACCEPT QUICK ORDER field
 .. D XSET S ^TMP("OR",$J,"QO",ANCSTR,$P(REC,U),7,1,0)=RC
 Q
 ;
GETXT(LOOKIN,SUFFIX) ;Return text occuring prior to suffix
 ; e.g. LOOKIN="INFUSE OVER 30 MINUTES",SUFFIX=" MINUTES" returns '30'
 N I,ISUFFIX,RSTRG,RTXT,STRG
 S I=0,RTXT=""
 F  S I=I+1,ISUFFIX=$P(SUFFIX,"|",I) Q:ISUFFIX=""  D:$F(LOOKIN,ISUFFIX)  Q:$G(RTXT)'=""
 . S RSTRG=$RE($E(LOOKIN,1,$F(LOOKIN,ISUFFIX)-$L(ISUFFIX)-1))
 . S RTXT=$P(RSTRG," ")
 Q $RE(RTXT)
 ;
MM ;Looks for 'MM' in Order Dialog / original code logic by James Hartin
 N ANCSTR,MMREC,NEXT,NODE3,PROMPT,VALUE
 S NEXT=1,VALUE=""
 F  S NEXT=$O(^ORD(101.41,ODIENXT,6,NEXT))  Q:NEXT'?1N.N  D
 . S VALUE=$G(^ORD(101.41,ODIENXT,6,NEXT,1)),PROMPT=+$P($G(^(0)),U,2)
 . S MMREC=^ORD(101.41,ODIENXT,0)
 . ; ODIEN^NAME^DISPLAY TEXT^VALUE
 . I PROMPT=DOSE,(VALUE["MM ") D
 .. D ANCSTR
 .. S ^TMP("OR",$J,"QO",ANCSTR,$P(MMREC,U),6,1,0)=ODIENXT_U_$P(MMREC,U)_U_$P(MMREC,U,2)_U_VALUE
 Q
 ;
MAILSU ;Set-up MAILMAN variables and format ^TMP("OR",$J,"MAIL")
 N DASH,DISPNAME,HDRLINE,LEGEND,LEGENDS,NEXT,NUM,NXTLINE,ODIENXT,ODQONAME,ORLEGEND,OROUT,QONAM,QOTOT,QORECORD,SPC
 K ^TMP("OR",$J,"MAIL")
 ;
 ;Title of emails
 S:ANCSTR="Y" XMSUB="QOs ON ORDER MENUS/SETS OR REMINDER DIALOGS: "
 S:ANCSTR="N" XMSUB="QOs NOT ON ORDER MENUS/SETS OR REMINDER DIALOGS: "
 S XMSUB=XMSUB_$$HTE^XLFDT($H)
 ;
 ;Group 1/A="IV TYPE IS NULL OR ROUTE IS NULL"
 ;Group 2/B="IV TYPE IS 'I' AND SCHEDULE IS NULL"
 ;Group 3/C="IV TYPE IS NOT 'C' OR NULL OR RATE IS NOT 1-4#.1#, INTERGER OR '@'"
 ;Group 4/D="IV TYPE IS 'I' BUT RATE NOT AN INTEGER MINUTE OR HOUR"
 ;Group 5/E="IV LIMIT OR DURATION (LIMITATION) WAS NOT NULL OR INTEGER"
 ;Group 6/F="ORDER DIALOGS WITH 'MM' IN THE DISPLAY TEXT"
 ;Group 7/G="AUTO-ACCEPT QUICK ORDER WAS 'Y'es, NOW SET TO 'N'o"
 ;Group 8/H="Number of IV Bags and additives do not matches"
 ;
 D NTRY^ORWOD1
 S ODQONAME="@",SPC="                            ",QOTOT=0
 F  S ODQONAME=$O(^TMP("OR",$J,"QO",ANCSTR,ODQONAME)) Q:ODQONAME=""  D
 . S (LEGENDS,ORLEGEND,QORECORD)=""
 . F  S ORLEGEND=$O(^TMP("OR",$J,"QO",ANCSTR,ODQONAME,ORLEGEND)) D  Q:ORLEGEND=""
 .. I ORLEGEND'="" S LEGENDS=LEGENDS_$C(ORLEGEND+64) S:$G(QORECORD)="" QORECORD=^TMP("OR",$J,"QO",ANCSTR,ODQONAME,ORLEGEND,1,0) Q
 .. S NXTLINE=NXTLINE+1,QONAM=$P(QORECORD,U,2),DISPNAME=$P(QORECORD,U,3) S:DISPNAME="" DISPNAME=SPC
 .. S OROUT=$J($P(QORECORD,U,1),5)_" "_$E(QONAM,1,30)_$E(SPC,1,30-$L(QONAM))_" "_$E(DISPNAME,1,30)_$E(SPC,1,30-$L(DISPNAME))_" "_$J(LEGENDS,6)
 .. S ^TMP("OR",$J,"MAIL",NXTLINE,0)=OROUT,QOTOT=QOTOT+1
 S NXTLINE=NXTLINE+1,^TMP("OR",$J,"MAIL",NXTLINE,0)=""
 S NXTLINE=NXTLINE+1,^TMP("OR",$J,"MAIL",NXTLINE,0)=QOTOT_" = Med Quick Orders"
 Q
 ;
SEND(XMSUB,USER) ;Send MailMan message to USER
 ; Text of message is located in ^TMP("OR",$J,"MAIL",LineNumbers0-n)
 ; Subject is the string XMSUB.
 N MGIEN,MGROUP,NL,REF,XMDUZ,XMY,XMZ
 ;
 ;Subject '> 64 characters.
 S XMSUB=$E(XMSUB,1,64)
 ;Sender is Postmaster.
 S XMDUZ=0.5
 ;
RETRY ;Get message number.
 D XMZ^XMA2
 I XMZ<1 G RETRY
 ;
 ;Load message
 M ^XMB(3.9,XMZ,2)=^TMP("OR",$J,"MAIL")
 S NL=$O(^XMB(3.9,XMZ,2,""),-1)
 S ^XMB(3.9,XMZ,2,0)="^3.92^"_+NL_U_+NL_U_DT
 ;
 ;Send message to USER
 I $G(USER)'="" S XMY(DUZ)="" D ENT1^XMD Q
 W !,"Error: No USER defined..message not sent!"
 Q
 ;
CLEANUP ; Clean-up
 K ^TMP("OR",$J)
 Q
