XTVSLPD1 ;Albany FO/GTS - VistA Package Sizing Manager - Caption display APIs; 12-JUL-2016
 ;;7.3;TOOLKIT;**143**;Apr 25, 1995;Build 116
 ;
 ;APIs
BADRNG(X) ;Checks user entered File Range (used by DIR call)
 SET RESULT=0
 IF ((X'?1.N."."0.6N1"-"1.N."."0.6N)!($P(X,"-",2)<$P(X,"-"))) SET RESULT=1
 QUIT RESULT
 ;
SETSTR(CAPARY) ;Return a string of Package File Lineitem (Concatonate fields to 1 HDR line)
 NEW LINEITM,LPCNT,FLD
 SET LINEITM=""
 SET LPCNT=0
 FOR  SET LPCNT=$O(@CAPARY@(LPCNT)) Q:LPCNT=""  DO
 . SET FLD=$O(@CAPARY@(LPCNT,""))
 . SET LINEITM=LINEITM_@CAPARY@(LPCNT,FLD)_$S(LPCNT<9:"^",1:"")
 QUIT LINEITM
 ;
EDPKGPRM(PKGNME) ; Edit Package Parameters
 NEW DATANUM,EDITARY,DATANAME,GETOUT,UPDATLST
 SET EDITARY="^TMP(""XTVS-PARAM-CAP"","_$J_","""_PKGNME_""")"
 SET DATANUM=0
 FOR  SET DATANUM=$O(@EDITARY@(DATANUM)) QUIT:+DATANUM=0  QUIT:($D(DTOUT)!($D(DUOUT)))  DO
 . SET DATANAME=$O(@EDITARY@(DATANUM,""))
 . NEW DIR,X,Y
 . SET DIR("A")=DATANAME_": " ;Set DIR("A") default prompt
 . IF @EDITARY@(DATANUM,DATANAME)]"" SET DIR("B")=@EDITARY@(DATANUM,DATANAME) ;Set Prompt for DIR read
 . ;
 . ;Primary Prefix (2)
 . IF (DATANUM=2) DO PRIMPFX^XTVSLPD2(DIR("A"),$G(DIR("B")))
 . ;
 . ;*Lowest File# (3) & *Highest File# (4)
 . IF ((DATANUM=3)!(DATANUM=4)) DO HILOFLE^XTVSLPD2(DIR("A"),$G(DIR("B")))
 . ;
 . ;Additional Prefixes (5) & Excepted Prefixes (6)
 . IF ((DATANUM=5)!(DATANUM=6)) DO EXADPFX^XTVSLPD2(DIR("A"),$G(DIR("B")))
 . ;
 . ; File Numbers (7)
 . IF (DATANUM=7) DO FLENUM^XTVSLPD2(DIR("A"),$G(DIR("B")))
 . ;
 . ; File Ranges (8)
 . IF (DATANUM=8) DO FLERNG^XTVSLPD2(DIR("A"),$G(DIR("B")))
 . ;
 . ;Parent Package (9)
 . IF (DATANUM=9) DO PRNTPKG^XTVSLPD2(DIR("A"),$G(DIR("B")))
 . ;
 . KILL DIR,X,Y
 ;
 KILL DIR,DIRUT,DTOUT,DUOUT,X,Y
 QUIT
 ;
EDCHK(PKGNME) ; Check for edit
 ; Input  PKGNME - Name of selected package
 ; Output XTEDIT - 0: Not Edited
 ;                 1: Edited
 NEW XTEDIT
 SET XTEDIT=0
 SET:'XTEDIT XTEDIT=(^TMP("XTVS-PARAM-BI",$J,PKGNME,2,"Primary Prefix")'=$G(^TMP("XTVS-PARAM-CAP",$J,PKGNME,2,"Primary Prefix")))
 SET:'XTEDIT XTEDIT=(^TMP("XTVS-PARAM-BI",$J,PKGNME,3,"*Lowest File#")'=$G(^TMP("XTVS-PARAM-CAP",$J,PKGNME,3,"*Lowest File#")))
 SET:'XTEDIT XTEDIT=(^TMP("XTVS-PARAM-BI",$J,PKGNME,4,"*Highest File#")'=$G(^TMP("XTVS-PARAM-CAP",$J,PKGNME,4,"*Highest File#")))
 IF 'XTEDIT DO  ;If no edit yet, first check for a difference in BI and CAP nodes
 . SET XTEDIT=(^TMP("XTVS-PARAM-BI",$J,PKGNME,5,"Additional Prefixes")'=$G(^TMP("XTVS-PARAM-CAP",$J,PKGNME,5,"Additional Prefixes")))
 . IF XTEDIT DO  ;If a difference between BI and CAP nodes, check for data reorg
 .. NEW BIDATA,EDDATA
 .. SET BIDATA=$G(^TMP("XTVS-PARAM-BI",$J,PKGNME,5,"Additional Prefixes"))
 .. SET EDDATA=$G(^TMP("XTVS-PARAM-CAP",$J,PKGNME,5,"Additional Prefixes"))
 .. SET XTEDIT=$$DATCHK(BIDATA,EDDATA)
 IF 'XTEDIT DO
 . SET XTEDIT=(^TMP("XTVS-PARAM-BI",$J,PKGNME,6,"Excepted Prefixes")'=$G(^TMP("XTVS-PARAM-CAP",$J,PKGNME,6,"Excepted Prefixes")))
 . IF XTEDIT DO
 .. NEW BIDATA,EDDATA
 .. SET BIDATA=$G(^TMP("XTVS-PARAM-BI",$J,PKGNME,6,"Excepted Prefixes"))
 .. SET EDDATA=$G(^TMP("XTVS-PARAM-CAP",$J,PKGNME,6,"Excepted Prefixes"))
 .. SET XTEDIT=$$DATCHK(BIDATA,EDDATA)
 IF 'XTEDIT DO
 . SET XTEDIT=(^TMP("XTVS-PARAM-BI",$J,PKGNME,7,"File Numbers")'=$G(^TMP("XTVS-PARAM-CAP",$J,PKGNME,7,"File Numbers")))
 . IF XTEDIT DO
 .. NEW BIDATA,EDDATA
 .. SET BIDATA=$G(^TMP("XTVS-PARAM-BI",$J,PKGNME,7,"File Numbers"))
 .. SET EDDATA=$G(^TMP("XTVS-PARAM-CAP",$J,PKGNME,7,"File Numbers"))
 .. SET XTEDIT=$$DATCHK(BIDATA,EDDATA)
 IF 'XTEDIT DO
 . SET XTEDIT=(^TMP("XTVS-PARAM-BI",$J,PKGNME,8,"File Ranges")'=$G(^TMP("XTVS-PARAM-CAP",$J,PKGNME,8,"File Ranges")))
 . IF XTEDIT DO
 .. NEW BIDATA,EDDATA
 .. SET BIDATA=$G(^TMP("XTVS-PARAM-BI",$J,PKGNME,8,"File Ranges"))
 .. SET EDDATA=$G(^TMP("XTVS-PARAM-CAP",$J,PKGNME,8,"File Ranges"))
 .. SET XTEDIT=$$DATCHK(BIDATA,EDDATA)
 SET:'XTEDIT XTEDIT=(^TMP("XTVS-PARAM-BI",$J,PKGNME,9,"Parent Package")'=$G(^TMP("XTVS-PARAM-CAP",$J,PKGNME,9,"Parent Package")))
 QUIT XTEDIT
 ;
DATCHK(BIDATA,EDDATA) ;Compare data for Add, Change, Delete OR find if all same data in different '|' pces
 NEW XTEDIT,BIPCE,EDPCE,BICHK,EQDATFND
 SET XTEDIT=($L(BIDATA,"|")'=$L(EDDATA,"|")) ;NOT same # '|' pces, then EDITED no need to continue
 IF 'XTEDIT DO
 .FOR BIPCE=1:1 QUIT:XTEDIT  QUIT:$P(BIDATA,"|",BIPCE)=""  DO  ;Check each '|' pce of Before Image
 .. SET BICHK=$P(BIDATA,"|",BIPCE)
 .. SET EQDATFND=0
 .. FOR EDPCE=1:1 QUIT:$P(EDDATA,"|",EDPCE)=""  QUIT:EQDATFND  SET EQDATFND=(BICHK=$P(EDDATA,"|",EDPCE))
 .. SET XTEDIT='EQDATFND ;If BICHK not found on EDDATA, then EDITED
 QUIT XTEDIT
 ;
BEFORIMG(PKGNME) ; Create "^TMP(""XTVS-PARAM-BI"","_$J_","""_PKGNME_""")" to record initial package definitions before edits
 IF '$D(^TMP("XTVS-PARAM-BI",$J,PKGNME)) DO
 . SET ^TMP("XTVS-PARAM-BI",$J,PKGNME,2,"Primary Prefix")=$G(^TMP("XTVS-PARAM-CAP",$J,PKGNME,2,"Primary Prefix"))
 . SET ^TMP("XTVS-PARAM-BI",$J,PKGNME,3,"*Lowest File#")=$G(^TMP("XTVS-PARAM-CAP",$J,PKGNME,3,"*Lowest File#"))
 . SET ^TMP("XTVS-PARAM-BI",$J,PKGNME,4,"*Highest File#")=$G(^TMP("XTVS-PARAM-CAP",$J,PKGNME,4,"*Highest File#"))
 . SET ^TMP("XTVS-PARAM-BI",$J,PKGNME,5,"Additional Prefixes")=$G(^TMP("XTVS-PARAM-CAP",$J,PKGNME,5,"Additional Prefixes"))
 . SET ^TMP("XTVS-PARAM-BI",$J,PKGNME,6,"Excepted Prefixes")=$G(^TMP("XTVS-PARAM-CAP",$J,PKGNME,6,"Excepted Prefixes"))
 . SET ^TMP("XTVS-PARAM-BI",$J,PKGNME,7,"File Numbers")=$G(^TMP("XTVS-PARAM-CAP",$J,PKGNME,7,"File Numbers"))
 . SET ^TMP("XTVS-PARAM-BI",$J,PKGNME,8,"File Ranges")=$G(^TMP("XTVS-PARAM-CAP",$J,PKGNME,8,"File Ranges"))
 . SET ^TMP("XTVS-PARAM-BI",$J,PKGNME,9,"Parent Package")=$G(^TMP("XTVS-PARAM-CAP",$J,PKGNME,9,"Parent Package"))
 QUIT
