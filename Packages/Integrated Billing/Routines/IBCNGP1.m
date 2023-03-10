IBCNGP1 ;ALB/CKB - REPORT OF COVERAGE LIMITATIONS (COMPILE/PRINT) ; 07-OCT-2021
 ;;2.0;INTEGRATED BILLING;**702**;21-MAR-94;Build 53
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
COMPILE(IBCNGPRTN,IBCNGP) ; Entry Point called from EN^XUTMDEVQ.
 ; IBCNGPRTN = Routine name for ^TMP($J,...
 ;    IBCNGP = Array of params
 ; Input:
 ;       IBCNGP("IBI")    0-Selected, 1-All Insurance Companies
 ;       IBCNGP("IBIA")   0-Active, 1-Both Active and Inactive, 2-Inactive Insurance Companies
 ;       IBCNGP("IBIP")   0-Selected, 1-All Group Plans
 ;       IBCNGP("IBIPA")  0-Active, 1-Both Active and Inactive, 2-Inactive Group Plans
 ;       IBCNGP("IBIGN")  1-Group Name, 2-Group Number, 3-Both Group Name and Group Number
 ;       IBCNGP("IBFIL")  A^B^C where"
 ;                        A - 1-Begin with, 2-Contains, 3-Range
 ;                         B - A=1 Begin with text, A=2 Contains text, A=3 Range start text
 ;                          C - only if A=3 Range End text
 ;       IBCNGP("IBICS")  1-Covered, 2-Not Covered, 3-Conditional
 ;                  4-By Default (blank status), 5-All Coverage Statuses
 ;       IBCNGP("IBOUT")  E-EXCEL, R-REPORT
 ;
 ;    ^TMP("IBCNGP",$J,"INS",ICT)=IEN of the selected Insurance Company, file 36
 ;               ICT  - count of Insurance Companies
 ;    ^TMP("IBCNGP",$J,"INS",ICT,"GRP",GCT)=IEN of the selected Group Plan, file 355.3
 ;               GCT  - count of Group Plans
 ;
 ; Compile and Print Report
 N GDATA,GCT,GIEN,IBCT,IBPGN,ICT,IIEN,PLANOK
 K ^TMP($J,"PR")
 ;
 I $G(IOST)["C-",IBCNGP("IBOUT")="R" W !,"Compiling report data ...",!
 ;
 ;If ALL Group Plans, add groups to ^TMP("IBCNGP")
 I IBCNGP("IBIP") D
 . S IBCT=""
 . F  S IBCT=$O(^TMP("IBCNGP",$J,"INS",IBCT)) Q:IBCT=""  D
 . . S IIEN=^TMP("IBCNGP",$J,"INS",IBCT)
 . . I $D(^IBA(355.3,"B",IIEN)) D
 . . . S GCT=0
 . . . S GIEN=0 F  S GIEN=$O(^IBA(355.3,"B",IIEN,GIEN)) Q:'GIEN  D
 . . . . ; checks to see if Group Plan should be included on the report
 . . . . K GDATA
 . . . . D GETS^DIQ(355.3,GIEN_",",".05;.06;.07;.08;.09;.11;2.01;2.02","EI","GDATA")
 . . . . S PLANOK=$$PLANOK^IBCNSU21(.GDATA,IBCNGP("IBIPA"),IBCNGP("IBIGN"),IBCNGP("IBFIL"))
 . . . . I 'PLANOK Q
 . . . . S GCT=GCT+1
 . . . . S ^TMP("IBCNGP",$J,"INS",IBCT,"GRP",GCT)=GIEN
 ;
 S ICT=0
 F  S ICT=$O(^TMP("IBCNGP",$J,"INS",ICT)) Q:'ICT  D
 . S IIEN=^TMP("IBCNGP",$J,"INS",ICT)
 . S GCT=0
 . F  S GCT=$O(^TMP("IBCNGP",$J,"INS",ICT,"GRP",GCT)) Q:'GCT  D
 . . S GIEN=^TMP("IBCNGP",$J,"INS",ICT,"GRP",GCT)
 . . D GETDATA
 ;
 D PRINT
 ;
 K ^TMP("IBCNGP",$J)
 Q
 ;
GETDATA ; Get Insurance Company and Group Plan data
 ;  Input: IIEN - IEN of the Insurance Company, file 36
 ;         GIEN - IEN of the Group Plan, file 355.3
 ; Output: ^TMP($J,"PR",INSNAME,ICT,GNAME,GCT,IBCAT,CCT)) - C1^C2^..^C4 Where:
 ;              INSNAME - Insurance Company name
 ;                  ICT - Insurance Company counter from ^TMP("IBCNGP")
 ;                GNAME - Group Plan name
 ;                  GCT - Group Plans counter from ^TMP("IBCNGP")
 ;                IBCAT - Coverage Category
 ;                  CCT - Coverage Category counter
 ;                         C1=Coverage Category, C2=Effective Date
 ;                         C3=Coverage Status, C4=Limitation Comment
 ;           
 N CATARR,CCT,CDATA,CTR,GINACT,GIND,GNAME,GNUM,GTYP,I,IBCAT,IBCOV,IBCSTA,IBDT,IBEFDT,IBINS
 N IBLIMCOM,IBRECDT,IBRECN,INSNAME,PRINT,STATE,STATECD,XX
 ;
 ; NOTE: If a category has at least one instance where the Coverage matches the Coverage
 ; selected by the user, all instances for that Category will be displayed on the report.
 ;
 ; Compile Plans Coverage Limitation info
 ; File# 355.31 PLAN LIMITATION CATEGORY contains ALL coverage categories
 F I=1:1:$O(^IBE(355.31,"B"),-1) S IBCAT=I D 
 . ; If the Category doesn't exist for the Plan the Coverage Status is BY DEFAULT
 . I '$D(^IBA(355.32,"APCD",GIEN,I)) D  Q
 . . S IBCSTA="BY DEFAULT"                ; Coverage Status
 . . S IBCOV=$$GET1^DIQ(355.31,I,.01,"E") ; Coverage Category
 . . S CATARR(IBCAT,0,0)=IBCOV_U_U_IBCSTA
 . . D COVOK
 . S IBRECDT=""
 . F  S IBRECDT=$O(^IBA(355.32,"APCD",GIEN,IBCAT,IBRECDT)) Q:IBRECDT=""  D
 . . S IBRECN=""
 . . F  S IBRECN=$O(^IBA(355.32,"APCD",GIEN,IBCAT,IBRECDT,IBRECN)) Q:IBRECN=""  D
 . . . S IBCOV=$$GET1^DIQ(355.32,IBRECN,.02)                      ; Coverage Category
 . . . S IBEFDT=$$DAT3^IBOUTL($$GET1^DIQ(355.32,IBRECN,.03,"I"))  ; Effective Date
 . . . S IBCSTA=$$GET1^DIQ(355.32,IBRECN,.04,"I")                 ; Coverage Status
 . . . S IBCSTA=$S(IBCSTA="":"BY DEFAULT",IBCSTA=0:"NO",IBCSTA=1:"YES",1:"CONDITIONAL")
 . . . S IBLIMCOM=""
 . . . I $O(^IBA(355.32,IBRECN,2,0))'="" S IBLIMCOM="YES"         ; Limit Comments?
 . . . ; Build local array by Category and Date
 . . . S CATARR(IBCAT,IBRECDT,IBRECN)=IBCOV_U_IBEFDT_U_IBCSTA_U_IBLIMCOM
 . . . ; Check Coverage to see if it should be displayed
 . . . D COVOK
 ;
CATARR ; Loop thru CATARR, add the Categories that should be displayed to the Print array.
 S IBCAT=0 F  S IBCAT=$O(CATARR(IBCAT)) Q:IBCAT=""  D
 . I $G(CATARR(IBCAT))'=1 Q
 . S CCT=0
 . S IBDT="" F  S IBDT=$O(CATARR(IBCAT,IBDT)) Q:IBDT=""  D
 . . S CTR="" F  S CTR=$O(CATARR(IBCAT,IBDT,CTR)) Q:CTR=""  D
 . . . S CDATA=CATARR(IBCAT,IBDT,CTR)
 . . . S IBCOV=$P(CDATA,U)
 . . . S IBEFDT=$P(CDATA,U,2)
 . . . S IBCSTA=$P(CDATA,U,3)
 . . . S IBLIMCOM=$P(CDATA,U,4)
 . . . S CCT=CCT+1
 . . . ;  The Insurance & Group info only need to be added once (the first category) 
 . . . ; Build the Print array
 . . . I CCT=1 D GETINS,GETGRP ; builds Insurance & Group Plan print array
 . . . S ^TMP($J,"PR",INSNAME,ICT,GNAME,GCT,IBCAT,CCT)=IBCOV_U_IBEFDT_U_IBCSTA_U_IBLIMCOM
 Q
 ;
GETINS ; Get Insurance info
 S INSNAME=$$GET1^DIQ(36,IIEN,.01)
 S $P(IBINS,U)=INSNAME
 S $P(IBINS,U,2)=$S($$GET1^DIQ(36,IIEN,.111)'="":$$GET1^DIQ(36,IIEN,.111),1:"<STREET ADDR 1 MISSING>")
 S $P(IBINS,U,3)=$$GET1^DIQ(36,IIEN,.114)
 S XX=$$GET1^DIQ(36,IIEN,.115) I XX'="" S STATECD=$O(^DIC(5,"B",XX,""))
 S $P(IBINS,U,4)=$S(XX'="":$P($G(^DIC(5,STATECD,0)),U,2),1:"<STATE MISSING>")
 S $P(IBINS,U,5)=$$GET1^DIQ(36,IIEN,.116)
 S ^TMP($J,"PR",INSNAME,ICT)=IBINS
 Q
 ;
GETGRP ; Get Group Plan info
 S GIND=$$GET1^DIQ(355.3,GIEN,.1,"I")
 S GINACT=$$GET1^DIQ(355.3,GIEN,.11,"I")
 S GNAME=$S($$GET1^DIQ(355.3,GIEN,2.01)'="":$$GET1^DIQ(355.3,GIEN,2.01),1:"<NO GROUP NAME>")
 S GNUM=$S($$GET1^DIQ(355.3,GIEN,2.02)'="":$$GET1^DIQ(355.3,GIEN,2.02),1:"<NO GROUP NUMBER>")
 ; Add '+'=individual and/or '*'=inactive
 I GIND'="" S GNAME="+"_GNAME
 I GINACT S GNUM="*"_GNUM
 S GTYP=$S($$GET1^DIQ(355.3,GIEN,.09)'="":$$GET1^DIQ(355.3,GIEN,.09),1:"<NO TYPE OF PLAN>")
 S ^TMP($J,"PR",INSNAME,ICT,GNAME,GCT)=GNAME_U_GNUM_U_GTYP
 Q
 ;
COVOK ; If the Coverage matches what the user selected, flag the Category and set PRINT=1.
 ; This Coverage, it's Insurance and Group, will be displayed on the report.
 ;  IBCNGP("IBICS") - 1-Covered, 2-Not Covered, 3-Conditional
 ;                    4-By Default (blank status), 5-All Coverage Statuses
 I IBCNGP("IBICS")=5 S CATARR(IBCAT)=1,PRINT=1 Q
 I IBCNGP("IBICS")=1,IBCSTA="YES" S CATARR(IBCAT)=1,PRINT=1
 I IBCNGP("IBICS")=2,IBCSTA="NO" S CATARR(IBCAT)=1,PRINT=1
 I IBCNGP("IBICS")=3,IBCSTA="CONDITIONAL" S CATARR(IBCAT)=1,PRINT=1
 I IBCNGP("IBICS")=4,IBCSTA="BY DEFAULT" S CATARR(IBCAT)=1,PRINT=1
 Q
 ;
 ;============================PRINT==================================
PRINT ;
 ;  Input: ^TMP($J,"PR",INSNAME,ICT,GNAME,GCT,IBCAT,CCT)) - C1^C2^..^C4 Where:
 ;              INSNAME - Insurance Company name
 ;                  ICT - Insurance Company counter from ^TMP("IBCNGP")
 ;                GNAME - Group Plan name
 ;                  GCT - Group Plans counter from ^TMP("IBCNGP")
 ;                IBCAT - Coverage Category
 ;                  CCT - Coverage Category counter
 ;                         C1=Coverage Category, C2=Effective Date
 ;                         C3=Coverage Status, C4=Limitation Comment
 ;
 N CRT,DASHES,EORMSG,FIRST,HDRDATE,HDRNAME,IBPGC,IBPXT,MAXCNT,NONEMSG,SPACES,STOP,ZTSTOP
 S (STOP,ZSTOP)=0
 S EORMSG="*** End of Report ***"
 S NONEMSG="* * * N o   D a t a   F o u n d * * *"
 S HDRNAME="COVERAGE LIMITATION REPORT"
 D NOW^%DTC
 S HDRDATE=$$DAT2^IBOUTL($E(%,1,12))
 S $P(DASHES,"-",132)=""
 S $P(SPACES," ",130)=""
 S (IBPXT,IBPGC)=0
 S MAXCNT=IOSL-3,CRT=1
 I 'IOST["C-" S MAXCNT=IOSL-6,CRT=0
 ;
 ; Print report
 D PRT Q:(IBPXT!$G(ZTSTOP))
 I CRT,IBPGC>0,$E(IOST,1,2)["C-" D
 . I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
 I IBCNGP("IBOUT")="E",CRT,$E(IOST,1,2)["C-" S DIR(0)="E" D ^DIR K DIR
EXIT ; PRINT exit
 K ^TMP($J,"PR")
 Q
 ;
PRT ; Print report
 N BLANK,CAT,CCT,CDATA,DISPDATA,GCT,GPLAN,GDATA,ICT,IDATA,INS
 N GDATALN,IDATALN ;702/DTG line spacing
 ;
 ; EXCEL Format
 I IBCNGP("IBOUT")="E" D  G PRTEX
 . D EHDR     ; EXCEL Header
 . I '$D(^TMP($J,"PR")) D  G PRTEX
 . . W !,NONEMSG ; No Data Found
 . S INS=0 F  S INS=$O(^TMP($J,"PR",INS)) Q:INS=""  D
 . . S ICT=0 F  S ICT=$O(^TMP($J,"PR",INS,ICT)) Q:ICT=""  D
 . . . S IDATA=^TMP($J,"PR",INS,ICT)
 . . . S GPLAN=0 F  S GPLAN=$O(^TMP($J,"PR",INS,ICT,GPLAN)) Q:GPLAN=""  D
 . . . . S GCT=0 F  S GCT=$O(^TMP($J,"PR",INS,ICT,GPLAN,GCT)) Q:GCT=""  D
 . . . . . S GDATA=^TMP($J,"PR",INS,ICT,GPLAN,GCT)
 . . . . . S CAT=0 F  S CAT=$O(^TMP($J,"PR",INS,ICT,GPLAN,GCT,CAT)) Q:CAT=""  D
 . . . . . . S CCT=0 F  S CCT=$O(^TMP($J,"PR",INS,ICT,GPLAN,GCT,CAT,CCT)) Q:CCT=""  D
 . . . . . . . K DISPDATA ; Init dispdata
 . . . . . . . S CDATA=^TMP($J,"PR",INS,ICT,GPLAN,GCT,CAT,CCT)
 . . . . . . . ; build/display data
 . . . . . . . S DISPDATA=IDATA_U_GDATA_U_CDATA
 . . . . . . . W !,DISPDATA
 ;
 ; REPORT Format
 D HEADER(HDRNAME,HDRDATE)
 ;
 ; Nothing to print
 I '$D(^TMP($J,"PR")) D  G PRTEX
 . W !,?40,NONEMSG ; No Data Found
 ; Process through the Print array
 N FGP,FGCT,FINS,FICT
 S INS=0 F  S INS=$O(^TMP($J,"PR",INS)) Q:INS=""  D  I STOP G PRTEX
 . S FINS=$O(^TMP($J,"PR","")),FICT=$O(^TMP($J,"PR",FINS,""))
 . S ICT=0 F  S ICT=$O(^TMP($J,"PR",INS,ICT)) Q:ICT=""  D  I STOP G PRTEX
 . . K INSDATA,GPDATA,COVDATA
 . . ; Blank line in between ins companies if it's not the first ins company
 . . I INS'=FINS!(ICT'=FICT) D LINE(SPACES)
 . . D INSDATA,LINE(INSDATA) I (IBPXT!$G(ZTSTOP)) S STOP=1 Q         ; build/display data
 . . S GPLAN=0 F  S GPLAN=$O(^TMP($J,"PR",INS,ICT,GPLAN)) Q:GPLAN=""  D  I STOP G PRTEX
 . . . S FGP=$O(^TMP($J,"PR",INS,ICT,"")),FGCT=$O(^TMP($J,"PR",INS,ICT,FGP,""))
 . . . S GCT=0 F  S GCT=$O(^TMP($J,"PR",INS,ICT,GPLAN,GCT)) Q:GCT=""  D  I STOP G PRTEX
 . . . . ; Blank line in between group plans if it's not the first group plan
 . . . . I GPLAN'=FGP!(GCT'=FGCT) D LINE(SPACES)
 . . . . D GPDATA,LINE(GPDATA) I (IBPXT!$G(ZTSTOP)) S STOP=1 Q       ; build/display data
 . . . . S CAT=0 F  S CAT=$O(^TMP($J,"PR",INS,ICT,GPLAN,GCT,CAT)) Q:CAT=""  D  I STOP G PRTEX
 . . . . . S CCT=0 F  S CCT=$O(^TMP($J,"PR",INS,ICT,GPLAN,GCT,CAT,CCT)) Q:CCT=""  D  I STOP G PRTEX
 . . . . . . D COVDATA,LINE(COVDATA) I (IBPXT!$G(ZTSTOP)) S STOP=1 Q  ; build/display data
 ;
PRTEX ;
 I IBPXT!$G(ZTSTOP) Q
 I IBCNGP("IBOUT")="E" W !,EORMSG
 I IBCNGP("IBOUT")="R" D  Q:(IBPXT!$G(ZTSTOP))
 . I $Y+1>MAXCNT!('IBPGC) D HEADER(HDRNAME,HDRDATE)
 . W !!,?40,EORMSG
 Q
 ;
HEADER(HDRNAME,HDRDATE) ; Report header
 N DIR,DTOUT,DUOUT,LIN,OFFSET,X,Y
 I IBPGC>0,$E(IOST,1,2)["C-" D  Q:(IBPXT!$G(ZTSTOP))
 . I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
 . I $D(DTOUT)!($D(DUOUT)) S IBPXT=1 Q
 I $E(IOST,1,2)'["C-",$$S^%ZTLOAD() S ZTSTOP=1 Q
 S IBPGC=IBPGC+1 I IBPGC>1!($E(IOST,1,2)["C-") W @IOF
 W HDRNAME
 S HDRDATE=HDRDATE_" Page: "_+IBPGC,OFFSET=(132-($L(HDRDATE)+1))
 W ?OFFSET,HDRDATE,!
 W DASHES
 ; Excel and Report Page 1 Header only
 I IBCNGP("IBOUT")="E"!(IBPGC=1) D HDR1
 I IBCNGP("IBOUT")="R" D HDR2
 Q
 ;
EHDR ; EXCEL header
 N HDR,HDR2
 S HDR="COVERAGE LIMITATION REPORT"_U_HDRDATE
 W HDR
 D HDR1
 S HDR2="INS COMPANY NAME^ADDRESS STREET^CITY^STATE^ZIP"
 S HDR2=HDR2_"^GROUP NAME^GROUP NUMBER^TYPE OF PLAN"
 S HDR2=HDR2_"^CATEGORY^EFFECTIVE DATE^COVERED?^LIMIT COMMENTS?"
 W HDR2
 Q 
 ;
HDR1 ; Report Header for Page 1 and Excel report
 W !,"+ =>INDIV. PLAN    * => INACTIVE"
 W !,"Filters: ",$S(IBCNGP("IBI")=1:"All",1:"Selected")," Insurances"
 W ", ",$S(IBCNGP("IBIP")=1:"All",1:"Selected")," Group Plans"
 W ", ",$S(+IBCNGP("IBFIL")=2:"Contains = ",+IBCNGP("IBFIL")=3:"Range = ",+IBCNGP("IBFIL")=4:"BLANK",1:"Begins with = ")
 W $S(+IBCNGP("IBFIL")=3:$P(IBCNGP("IBFIL"),U,2)_"-"_$P(IBCNGP("IBFIL"),U,3),1:$P(IBCNGP("IBFIL"),U,2))
 W ", "
 I IBCNGP("IBICS")=5 W "All Coverage Statuses"
 I IBCNGP("IBICS")'=5 D
 . W "Coverage Status: "
 . W $S(IBCNGP("IBICS")=1:"COVERED",IBCNGP("IBICS")=2:"NOT COVERED",IBCNGP("IBICS")=3:"CONDITIONAL",1:"BY DEFAULT")
 W !
 Q
 ;
HDR2 ; Column Headers for the Report format, for all pages
 W !,"COMPANY",?15,"GROUP NAME",?38,"GROUP NUMBER",?58,"CATEGORY",?86,"EFFECTIVE DATE"
 W ?103,"COVERED?",?116,"LIMIT COMMENTS?"
 ; At the beginning of a new page, redisplayed the Insurance Company. Don't display
 ; the Group Plan if you're starting a new group on the new page
 I IBPGC>1,GPLAN'="" D LINE(INSDATA) I $G(CCT)'="" D LINE(GPDATA)
 Q
 ;
INSDATA ; Insurance Company info
 S IDATA=^TMP($J,"PR",INS,ICT)
 S INSDATA=$$FO^IBCNEUT1($P(IDATA,U,1),"40T","L")_$E(SPACES,1,2)
 S INSDATA=INSDATA_$P(IDATA,U,2)_", "_$P(IDATA,U,3)_", "
 S INSDATA=INSDATA_$P(IDATA,U,4)_" "_$P(IDATA,U,5)
 S IDATALN=1,GDATALN=0 ;702/DTG line spacing
 Q
 ;
GPDATA ; Group Plan info
 S GDATA=^TMP($J,"PR",INS,ICT,GPLAN,GCT)
 S GPDATA=$E(SPACES,1,15)_$$FO^IBCNEUT1($P(GDATA,U,1),21,"L")_$E(SPACES,1,2)
 S GPDATA=GPDATA_$$FO^IBCNEUT1($P(GDATA,U,2),18,"L")_$E(SPACES,1,2)
 S GPDATA=GPDATA_"<< "_$P(GDATA,U,3)_" >>"
 S GDATALN=1 ;702/DTG line spacing
 Q
 ;
COVDATA ; Coverage info
 S CDATA=^TMP($J,"PR",INS,ICT,GPLAN,GCT,CAT,CCT)
 S COVDATA=$E(SPACES,1,58)_$$FO^IBCNEUT1($P(CDATA,U,1),"26T","L")_$E(SPACES,1,2)
 S COVDATA=COVDATA_$$FO^IBCNEUT1($P(CDATA,U,2),15,"L")_$E(SPACES,1,2)
 S COVDATA=COVDATA_$$FO^IBCNEUT1($P(CDATA,U,3),"11T","L")_$E(SPACES,1,2)
 S COVDATA=COVDATA_$$FO^IBCNEUT1($P(CDATA,U,4),5,"L")
 Q
 ;
LINE(DISPDATA) ; Print data
 N NWPG
 S NWPG=0
 I $TR(DISPDATA," ","")="" G LINEX
 I IBCNGP("IBOUT")="R" D  Q:(IBPXT!$G(ZTSTOP))
 . ; 702/DTG start line spacing
 . I IDATALN=1 S IDATALN=0 I ($Y+4)>MAXCNT D HEADER(HDRNAME,HDRDATE) S NWPG=1 Q
 . I GDATALN=1 S GDATALN=0 I ($Y+3)>MAXCNT D HEADER(HDRNAME,HDRDATE) S NWPG=1 Q
 . ; 702/DTG end line spacing
 . I ($Y+2)>MAXCNT!('IBPGC) D HEADER(HDRNAME,HDRDATE) S NWPG=1 I (IBPXT!$G(ZTSTOP)) Q
LINEX ;
 S IDATALN=0
 W !,DISPDATA
 Q
 ;
CENTER(LINE,XWIDTH) ;return centered line OFFSET
 N LENGTH,OFFSET
 S LENGTH=$L(LINE),OFFSET=XWIDTH-$L(LINE)\2
 Q OFFSET
