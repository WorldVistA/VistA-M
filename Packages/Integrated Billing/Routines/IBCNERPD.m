IBCNERPD ;DAOU/RO - eIV PAYER LINK REPORT PRINT;AUG-2003
 ;;2.0;INTEGRATED BILLING;**184,252,416,521,528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; eIV - Insurance Verification
 ;
 ; Called by IBCNERPB
 ; Input from IBCNERPB/C:
 ;  
 ;  ^TMP($J,IBCNERTN,S1,S2,CT,0)
 ;    IBCNERTN="IBCNERPB", 
 ;    CT=Seq ct
 ;  ^TMP($J,IBCNERTN,S1,S2,CT,1) 
 ;  IBOUT
 ;
EN3(IBCNERTN,IBCNESPC) ; Entry pt.  
 N IBTYP,IBSRT,CRT,MAXCNT,IBPXT
 N IBPGC,X,Y,DIR,DTOUT,DUOUT,LIN,IBTRC,IBMAT,IBREP,IBDET,IBPPYR,ZZ
 S IBREP=$G(IBCNESPC("REP"))
 S IBDET=$G(IBCNESPC("PDET"))
 S IBTYP=$G(IBCNESPC("PTYPE"))
 S IBSRT=$G(IBCNESPC("PSORT"))
 S IBPPYR=$G(IBCNESPC("PPYR"))
 ; Ins Report
 I IBREP=2 D
 . S IBTYP=$G(IBCNESPC("ITYPE"))
 . S IBSRT=$G(IBCNESPC("ISORT"))
 . S IBMAT=$G(IBCNESPC("IMAT"))
 S (IBPXT,IBPGC)=0
 ; Determine IO params
 I "^R^E^"'[(U_$G(IBOUT)_U) S IBOUT="R"
 I IOST["C-" S MAXCNT=IOSL-3,CRT=1
 E  S MAXCNT=IOSL-6,CRT=0
 D PRINT(IBCNERTN,IBREP,IBDET,IBTYP,IBSRT,.IBPGC,.IBPXT,MAXCNT,CRT,IBOUT)
 I $G(ZTSTOP)!IBPXT G EXIT3
 I CRT,IBPGC>0,'$D(ZTQUEUED) D
 . I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
EXIT3 ; Exit pt
 Q
 ;
PRINT(RTN,REP,DET,TYP,SRT,PGC,PXT,MAX,CRT,IBOUT) ; Print data
 ; Input: RTN="IBCENRPB", PGC=page ct,
 ;   PXT=exit flg, MAX=max line ct/pg,
 ;  CRT=1/0, IBOUT="R"/"E"
 N EORMSG,NONEMSG,SORT1,SORT2,CNT,DASH
 S EORMSG="*** END OF REPORT ***"
 S NONEMSG="* * * N O  D A T A  F O U N D * * *"
 S (SORT1,SORT2)="",$P(DASH,"-",133)=""
 ;
 ;Excel header
 I IBOUT="E" D PHDL
 ;
 I '$D(^TMP($J,RTN)) D HEADER:(IBOUT="R") W !,?(80-$L(NONEMSG)\2),NONEMSG,!!
 F  S SORT1=$O(^TMP($J,RTN,SORT1)) Q:SORT1=""  D  Q:PXT!$G(ZTSTOP)
 . S SORT2="" F  S SORT2=$O(^TMP($J,RTN,SORT1,SORT2)) Q:SORT2=""  D  Q:PXT!$G(ZTSTOP)
 . . S CNT="" F  S CNT=$O(^TMP($J,RTN,SORT1,SORT2,CNT)) Q:CNT=""  D  Q:PXT!$G(ZTSTOP)
 . . . K DISPDATA  ; Init disp
 . . . D DATA(.DISPDATA),LINE(.DISPDATA)  ; build/display data
 ;
 I $G(ZTSTOP)!PXT G PRINTX
 I IBOUT="R" D
 . I $Y+1>MAX!('PGC) D HEADER I $G(ZTSTOP)!PXT G PRINTX
 W !,?(80-$L(EORMSG)\2),EORMSG
PRINTX ;
 Q
 ;
HEADER ; Print hdr info
 N X,Y,DIR,DTOUT,DUOUT,OFFSET,HDR,LIN,HDR
 I CRT,PGC>0,'$D(ZTQUEUED) D  I PXT G HEADERX
 . I MAX<51 F LIN=1:1:(MAX-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
 . I $D(DTOUT)!($D(DUOUT)) S PXT=1 Q
 I $D(ZTQUEUED),$$S^%ZTLOAD() S ZTSTOP=1 G HEADERX
 S PGC=PGC+1
 W @IOF,!,?1,"eIV Payer Link Report"
 S HDR=$$FMTE^XLFDT($$NOW^XLFDT,1)_"  Page: "_PGC,OFFSET=131-$L(HDR)
 W ?OFFSET,HDR
 W !,?1,"Report Option: "_$S(REP=1:"Payer List",1:"Insurance Company List")
 I REP=1 D
 . S HDR=$S(TYP=1:"Unlinked Payers Only",TYP=2:"Linked Payers Only",1:"All Payers")
 . I TYP=3 S HDR=HDR_", "_$S(DET=1:"With Ins. Co. Detail",1:"Without Ins. Co. Detail")
 I REP=2 D
 . S HDR=$S(TYP=1:"Unlinked Insurance Companies Only",TYP=2:"Linked Insurance Companies Only",1:"All Insurance Companies")
 S OFFSET=79-$L(HDR)
 W ?OFFSET,HDR
 ; IB*2.0*521 add validated HPID to report
 I REP=2 W !,"'*' indicates the Insurance Company HPID/OEID failed validation checks"
 I REP=1,DET=1 W !,"'*' indicates the Linked Insurance Company HPID/OEID failed validation checks"
 W !
 I REP=1 D
 . I IBPPYR'="" W ?1,"For Single Payer: ",$P(IBPPYR,"^",2)
 . ; IB*2.0*528 add Trusted flag to report
 . ;W !?39,"National",?54,"# Linked",?64,"Nationally",?77,"Locally",?87,"Prof.",?104,"Inst." W:DET=1 ?121,"HPID/"
 . ;W !,"Payer Name:",?39,"Payer ID",?54,"Ins. Co.",?65,"Active?",?77,"Active?",?87,"EDI#",?104,"EDI#" W:DET=1 ?121,"OEID"
 . W !?31,"National",?46,"# Linked",?56,"Nationally",?69,"Locally",?78,"FSC",?87,"Prof.",?104,"Inst." W:DET=1 ?121,"HPID/"
 . W !,"Payer Name:",?31,"Payer ID",?46,"Ins. Co.",?57,"Active?",?69,"Active?",?78,"Trusted?",?87,"EDI#",?104,"EDI#" W:DET=1 ?121,"OEID"
 I REP=2 D
 . I IBMAT'="" W ?1,"Only Insurance Companies that match: ",IBMAT
 . ; IB*2.0*528 add Trusted flag and Number of Active Groups to report
 . ;W !?56,"Nat.",?71,"Loc.",?83,"Prof.",?104,"Inst.",?121,"HPID/"
 . ;W !,"Insurance Company:",?56,"Act?",?71,"Act?",?83,"EDI#",?104,"EDI#",?121,"OEID"
 . W !?32,"# Active",?56,"Nat.",?66,"Loc.",?73,"FSC",?83,"Prof.",?104,"Inst.",?121,"HPID/"
 . W !,"Insurance Company:",?33,"Groups",?56,"Act?",?66,"Act?",?73,"Trusted?",?83,"EDI#",?104,"EDI#",?121,"OEID"
 . I TYP'=1 W !,"   Payer:",?44,"VA ID"
 W !,DASH
HEADERX ;
 Q
 ;
LINE(DISPDATA) ;  Print data
 N LNCT,LNTOT,NWPG
 S LNTOT=+$O(DISPDATA(""),-1)
 S NWPG=0
 F LNCT=1:1:LNTOT D  Q:$G(ZTSTOP)!PXT
 . I IBOUT="R" D
 . . I $Y+1>MAX!('PGC) D HEADER S NWPG=1 I $G(ZTSTOP)!PXT Q
 . W ! W:IBOUT="R" ?1 W DISPDATA(LNCT) Q
 . I 'NWPG!(NWPG&(DISPDATA(LNCT)'="")) W !,?1,DISPDATA(LNCT)
 . I NWPG S NWPG=0
 . Q
LINEX Q
 ;
DATA(DISPDATA) ;  Build disp lines
 N LCT,CT,CT2,RPTDATA,WW,XX,YY,ZZ,IBHPD
 ; Merge into local array
 M RPTDATA=^TMP($J,RTN,SORT1,SORT2,CNT)
 ; Build
 ;
 ; PAYER REPORT
 I REP=1 D
 . ; Excel format
 . I IBOUT="E" D  Q
 . . S LCT=0,DISPDATA(1)=SORT2_U_$P(RPTDATA,U)_U_$P(RPTDATA,U,6)_U_$S($P(RPTDATA,U,4)=1:"YES",1:"NO")_U_$S($P(RPTDATA,U,4)=1:"YES",1:"NO")_U_$P(RPTDATA,U,7)_U_$P(RPTDATA,U,2)_U_$P(RPTDATA,U,3)
 . . I DET=1 S WW=DISPDATA(1) D DET
 . ;
 . ; 1st line is payer
 . ; IB*2.0*528 add Trusted flag to report
 . ;S LCT=1,DISPDATA(1)=$$FO^IBCNEUT1(SORT2,35,"L")_"   "_$$FO^IBCNEUT1($P(RPTDATA,U,1),10,"L")_"     "_$$FO^IBCNEUT1($P(RPTDATA,U,6),5,"R")_"        "_$$FO^IBCNEUT1($S($P(RPTDATA,U,4)=1:"YES",1:"NO"),12,"L")
 . ;S DISPDATA(1)=DISPDATA(1)_$$FO^IBCNEUT1($S($P(RPTDATA,U,5)=1:"YES",1:"NO"),8,"L")_$$FO^IBCNEUT1($P(RPTDATA,U,2),16,"L")_" "_$$FO^IBCNEUT1($P(RPTDATA,U,3),16,"L")
 . S LCT=1,DISPDATA(1)=$$FO^IBCNEUT1(SORT2,27,"L")_"   "_$$FO^IBCNEUT1($P(RPTDATA,U,1),10,"L")_"     "_$$FO^IBCNEUT1($P(RPTDATA,U,6),5,"R")_"        "_$$FO^IBCNEUT1($S($P(RPTDATA,U,4)=1:"YES",1:"NO"),12,"L")
 . S DISPDATA(1)=DISPDATA(1)_$$FO^IBCNEUT1($S($P(RPTDATA,U,5)=1:"YES",1:"NO"),9,"L")_$$FO^IBCNEUT1($P(RPTDATA,U,7),7,"L")_$$FO^IBCNEUT1($P(RPTDATA,U,2),16,"L")_" "_$$FO^IBCNEUT1($P(RPTDATA,U,3),16,"L")
 . ; See if detail is required
 . I DET=1 D
 . . I $O(RPTDATA(""))'="" S LCT=LCT+1,DISPDATA(LCT)="   Linked Insurance Companies:"
 . . S (XX,YY,ZZ)="" F  S XX=$O(RPTDATA(XX)) Q:XX=""  F  S YY=$O(RPTDATA(XX,YY)) Q:YY=""  D
 . . . S ZZ=RPTDATA(XX,YY)
 . . . S LCT=LCT+1,DISPDATA(LCT)="   "_$$FO^IBCNEUT1(XX,35,"L")_"  "_$$FO^IBCNEUT1($P(ZZ,U,1),20,"L")_" "_$E($P(ZZ,U,4),1,15)
 . . . ; don't display ','s if no address/state on file
 . . . I $P(ZZ,U,5)'="" S DISPDATA(LCT)=DISPDATA(LCT)_", "_$P($G(^DIC(5,$P(ZZ,U,5)+0,0)),U,2)
 . . . ; IB*2.0*521 add validated HPID to report
 . . . S IBHPD=$$HPD^IBCNHUT1(YY,1)
 . . . ;S DISPDATA(LCT)=DISPDATA(LCT)_$$FO^IBCNEUT1(" ",93-$L(DISPDATA(LCT)),"L")
 . . . S DISPDATA(LCT)=DISPDATA(LCT)_$$FO^IBCNEUT1(" ",86-$L(DISPDATA(LCT)),"L")
 . . . ; display EDI#'s
 . . . ;S DISPDATA(LCT)=DISPDATA(LCT)_$$FO^IBCNEUT1($P(ZZ,U,7),16,"L")_"     "_$$FO^IBCNEUT1($P(ZZ,U,8),16,"L")
 . . . S DISPDATA(LCT)=DISPDATA(LCT)_$$FO^IBCNEUT1($P(ZZ,U,7),16,"L")_" "_$$FO^IBCNEUT1($P(ZZ,U,8),16,"L")_" "_IBHPD
 ;
 ; Insurance Company Report
 I REP=2 D
 . ; Excel format
 . I IBOUT="E" D  Q
 . . ;S LCT=1,DISPDATA(1)=SORT2_U_$P(RPTDATA,U,1)_U_$P(RPTDATA,U,6)_U_$S($P(RPTDATA,U,4)=1:"YES",1:"NO")_U_$S($P(RPTDATA,U,4)=1:"YES",1:"NO")_U_$P(RPTDATA,U,7)_U_$P(RPTDATA,U,2)_U_$P(RPTDATA,U,3)
 . . S LCT=1,DISPDATA(1)=SORT2_U_$P(RPTDATA,U,10)_U_$P(RPTDATA,U,13)
 . . I $P(RPTDATA,U,14)'="" S DISPDATA(1)=DISPDATA(1)_", "_$P($G(^DIC(5,$P(RPTDATA,U,14)+0,0)),U,2)_" "_$P(RPTDATA,U,15)
 . . S IBHPD=$$HPD^IBCNHUT1(CNT,1),ZZ=$P(RPTDATA,"~",2)
 . . S DISPDATA(1)=DISPDATA(1)_U_$P(RPTDATA,U,8)_U_$P(ZZ,U,2)_U_$P(ZZ,U,4)_U_IBHPD_U
 . . I $P(RPTDATA,U)="" S:TYP'=1 DISPDATA(1)=DISPDATA(1)_"** NOT CURRENTLY LINKED **" Q
 . . S DISPDATA(1)=DISPDATA(1)_$P(RPTDATA,U,1,2)_U_$S($P(RPTDATA,U,5)=1:"YES",1:"NO")_U_$S($P(RPTDATA,U,6)=1:"YES",1:"NO")_U_$P(RPTDATA,U,9)_U_$P(RPTDATA,U,3,4)
 . ;
 . ; Ins carrier
 . ; IB*2.0*528 add number of active groups to report
 . S DISPDATA(1)=$$FO^IBCNEUT1(SORT2,30,"L")_"  "_$$FO^IBCNEUT1($P(RPTDATA,U,8),5,"R")_$$FO^IBCNEUT1(" ",45,"L")
 . ; Ins address
 . S IBHPD=$$HPD^IBCNHUT1(CNT,1)
 . S ZZ=$P(RPTDATA,"~",2),DISPDATA(1)=DISPDATA(1)_$$FO^IBCNEUT1($P(ZZ,U,2),16,"L")_"     "_$$FO^IBCNEUT1($P(ZZ,U,4),16,"L")_" "_IBHPD
 . S DISPDATA(2)="        "_$P(RPTDATA,U,10)_"  "_$P(RPTDATA,U,13)
 . ; Add state/zip if defined
 . I $P(RPTDATA,U,14)'="" S DISPDATA(2)=DISPDATA(2)_", "_$P($G(^DIC(5,$P(RPTDATA,U,14)+0,0)),U,2)_" "_$$FO^IBCNEUT1($P(RPTDATA,U,15),5,"L")
 . ; if no payer is linked AND displaying payers
 . I $P(RPTDATA,U)="",TYP'=1 S DISPDATA(3)="   ** NOT CURRENTLY LINKED **",LCT=4,DISPDATA(4)="  " Q
 . ; if no payer and not displaying then quit
 . I $P(RPTDATA,U)="" S LCT=3,DISPDATA(3)="  " Q
 . ; Display Payer Info Line
 . S DISPDATA(3)="  "_$$FO^IBCNEUT1($P(RPTDATA,U,1),35,"L")_"      "_$$FO^IBCNEUT1($P(RPTDATA,U,2),12,"L")_$$FO^IBCNEUT1($S($P(RPTDATA,U,5)=1:"YES",1:"NO"),10,"L")
 . ; IB*2.0*528 add Trusted flag to report
 . ;S DISPDATA(3)=DISPDATA(3)_$$FO^IBCNEUT1($S($P(RPTDATA,U,6)=1:"YES",1:"NO"),12,"L")_$$FO^IBCNEUT1($P(RPTDATA,U,4),16,"L")_"     "_$$FO^IBCNEUT1($P(RPTDATA,U,4),16,"L")
 . S DISPDATA(3)=DISPDATA(3)_$$FO^IBCNEUT1($S($P(RPTDATA,U,6)=1:"YES",1:"NO"),7,"L")_$$FO^IBCNEUT1($P(RPTDATA,U,9),10,"L")_$$FO^IBCNEUT1($P(RPTDATA,U,3),16,"L")_"     "_$$FO^IBCNEUT1($P(RPTDATA,U,4),16,"L")
 . S LCT=4,DISPDATA(4)=" "
 S LCT=LCT+1
 Q
 ;
DET ; - Print insurance company detail in Excel Payer report
 S (XX,YY,ZZ)="" F  S XX=$O(RPTDATA(XX)) Q:XX=""  F  S YY=$O(RPTDATA(XX,YY)) Q:YY=""  D
 . S ZZ=RPTDATA(XX,YY)
 . S LCT=LCT+1,DISPDATA(LCT)=WW_U_XX_U_$P(ZZ,U,1)_U_$P(ZZ,U,4)
 . I $P(ZZ,U,5)'="" S DISPDATA(LCT)=DISPDATA(LCT)_", "_$P($G(^DIC(5,$P(ZZ,U,5)+0,0)),U,2)
 . S IBHPD=$$HPD^IBCNHUT1(YY,1)
 . S DISPDATA(LCT)=DISPDATA(LCT)_U_$P(ZZ,U,7)_U_$P(ZZ,U,8)_U_IBHPD
 Q
 ;
PHDL ; - Print the header line for the Excel spreadsheet
 N X
 I REP=1 D
 .S X="Payer Name^National Payer ID^# Linked Ins. Co.^Nationally Active?^Locally Active?^FSC Trusted?^Professional EDI#^Institutional EDI#"
 .I DET=1 S X=X_"^Linked Insurance Company Name^Street Address^City, ST^Professional EDI#^Institutional EDI#^HPID/OEID"
 I REP=2 D
 .S X="Insurance Company Name^Street Address^City, ST Zip^# Active Groups^Professional EDI#^Institutional EDI#^HPID/OEID^"
 .S X=X_"Linked Payer^VA ID^Nationally Active?^Locally Active?^FSC Trusted?^Professional EDI#^Institutional EDI#"
 W X
 Q
