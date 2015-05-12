IBCNERPD ;DAOU/RO - eIV PAYER LINK REPORT PRINT;AUG-2003
 ;;2.0;INTEGRATED BILLING;**184,252,416,521**;21-MAR-94;Build 33
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
 I IOST["C-" S MAXCNT=IOSL-3,CRT=1
 E  S MAXCNT=IOSL-6,CRT=0
 D PRINT(IBCNERTN,IBREP,IBDET,IBTYP,IBSRT,.IBPGC,.IBPXT,MAXCNT,CRT)
 I $G(ZTSTOP)!IBPXT G EXIT3
 I CRT,IBPGC>0,'$D(ZTQUEUED) D
 . I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
EXIT3 ; Exit pt
 Q
 ;
PRINT(RTN,REP,DET,TYP,SRT,PGC,PXT,MAX,CRT) ; Print data
 ; Input: RTN="IBCENRPB"
 ;   PGC=page ct, PXT=exit flg,
 ;  MAX=max line ct/pg, CRT=1/0
 N EORMSG,NONEMSG,SORT1,SORT2,CNT,DASH
 S EORMSG="*** END OF REPORT ***"
 S NONEMSG="* * * N O  D A T A  F O U N D * * *"
 S (SORT1,SORT2)="",$P(DASH,"-",133)=""
 I '$D(^TMP($J,RTN)) D HEADER W !,?(80-$L(NONEMSG)\2),NONEMSG,!!
 F  S SORT1=$O(^TMP($J,RTN,SORT1)) Q:SORT1=""  D  Q:PXT!$G(ZTSTOP)
 . S SORT2="" F  S SORT2=$O(^TMP($J,RTN,SORT1,SORT2)) Q:SORT2=""  D  Q:PXT!$G(ZTSTOP)
 . . S CNT="" F  S CNT=$O(^TMP($J,RTN,SORT1,SORT2,CNT)) Q:CNT=""  D  Q:PXT!$G(ZTSTOP)
 . . . K DISPDATA  ; Init disp
 . . . D DATA(.DISPDATA),LINE(.DISPDATA)  ; build/display data
 ;
 I $G(ZTSTOP)!PXT G PRINTX
 I $Y+1>MAX!('PGC) D HEADER I $G(ZTSTOP)!PXT G PRINTX
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
 . ; IB*2.0*521 add validated HPID to report
 . ;W !?39,"National",?54,"# Linked",?67,"Nationally",?82,"Locally",?94,"Prof.",?115,"Inst."
 . ;W !,"Payer Name:",?39,"Payer ID",?54,"Ins. Co.",?67,"Active?",?82,"Active?",?94,"EDI#",?115,"EDI#"
 . W !?39,"National",?54,"# Linked",?64,"Nationally",?77,"Locally",?87,"Prof.",?104,"Inst." W:DET=1 ?121,"HPID/"
 . W !,"Payer Name:",?39,"Payer ID",?54,"Ins. Co.",?65,"Active?",?77,"Active?",?87,"EDI#",?104,"EDI#" W:DET=1 ?121,"OEID"
 I REP=2 D
 . I IBMAT'="" W ?1,"Only Insurance Companies that match: ",IBMAT
 . ; IB*2.0*521 add validated HPID to report
 . ;W !?56,"Nat.",?71,"Loc.",?83,"Prof.",?104,"Inst."
 . ;W !,"Insurance Company:",?56,"Act?",?71,"Act?",?83,"EDI#",?104,"EDI#"
 . W !?56,"Nat.",?71,"Loc.",?83,"Prof.",?104,"Inst.",?121,"HPID/"
 . W !,"Insurance Company:",?56,"Act?",?71,"Act?",?83,"EDI#",?104,"EDI#",?121,"OEID"
 . I TYP'=1 W !,"   Payer:",?41,"VA ID"
 W !,DASH
HEADERX ;
 Q
 ;
LINE(DISPDATA) ;  Print data
 N LNCT,LNTOT,NWPG
 S LNTOT=+$O(DISPDATA(""),-1)
 S NWPG=0
 F LNCT=1:1:LNTOT D  Q:$G(ZTSTOP)!PXT
 . I $Y+1>MAX!('PGC) D HEADER S NWPG=1 I $G(ZTSTOP)!PXT Q
 . W !,?1,DISPDATA(LNCT) Q
 . I 'NWPG!(NWPG&(DISPDATA(LNCT)'="")) W !,?1,DISPDATA(LNCT)
 . I NWPG S NWPG=0
 . Q
LINEX Q
 ;
DATA(DISPDATA) ;  Build disp lines
 N LCT,CT,CT2,RPTDATA,XX,YY,ZZ,IBHPD
 ; Merge into local array
 M RPTDATA=^TMP($J,RTN,SORT1,SORT2,CNT)
 ; Build
 ;
 ; PAYER REPORT
 I REP=1 D
 . ; 1st line is payer
 . ; IB*2.0*521 add validated HPID to report
 . ;S LCT=1,DISPDATA(1)=$$FO^IBCNEUT1(SORT2,35,"L")_"   "_$$FO^IBCNEUT1($P(RPTDATA,U,1),10,"L")_"     "_$$FO^IBCNEUT1($P(RPTDATA,U,6),5,"R")_"        "_$$FO^IBCNEUT1($S($P(RPTDATA,U,4)=1:"YES",1:"NO"),15,"L")
 . ;S DISPDATA(1)=DISPDATA(1)_$$FO^IBCNEUT1($S($P(RPTDATA,U,5)=1:"YES",1:"NO"),12,"L")_$$FO^IBCNEUT1($P(RPTDATA,U,2),16,"L")_"     "_$$FO^IBCNEUT1($P(RPTDATA,U,3),16,"L")
 . S LCT=1,DISPDATA(1)=$$FO^IBCNEUT1(SORT2,35,"L")_"   "_$$FO^IBCNEUT1($P(RPTDATA,U,1),10,"L")_"     "_$$FO^IBCNEUT1($P(RPTDATA,U,6),5,"R")_"        "_$$FO^IBCNEUT1($S($P(RPTDATA,U,4)=1:"YES",1:"NO"),12,"L")
 . S DISPDATA(1)=DISPDATA(1)_$$FO^IBCNEUT1($S($P(RPTDATA,U,5)=1:"YES",1:"NO"),8,"L")_$$FO^IBCNEUT1($P(RPTDATA,U,2),16,"L")_" "_$$FO^IBCNEUT1($P(RPTDATA,U,3),16,"L")
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
 . ; Ins carrier
 . S DISPDATA(1)=$$FO^IBCNEUT1(SORT2,82,"L")
 . ; Ins address
 . ; IB*2.0*521 add validated HPID to report
 . S IBHPD=$$HPD^IBCNHUT1(CNT,1)
 . ;S ZZ=$P(RPTDATA,"~",2),DISPDATA(1)=DISPDATA(1)_$$FO^IBCNEUT1($P(ZZ,U,2),16,"L")_"     "_$$FO^IBCNEUT1($P(ZZ,U,4),16,"L")
 . S ZZ=$P(RPTDATA,"~",2),DISPDATA(1)=DISPDATA(1)_$$FO^IBCNEUT1($P(ZZ,U,2),16,"L")_"     "_$$FO^IBCNEUT1($P(ZZ,U,4),16,"L")_" "_IBHPD
 . S DISPDATA(2)="        "_$P(RPTDATA,U,8)_"  "_$P(RPTDATA,U,11)
 . ; Add state/zip if defined
 . I $P(RPTDATA,U,12)'="" S DISPDATA(2)=DISPDATA(2)_", "_$P($G(^DIC(5,$P(RPTDATA,U,12)+0,0)),U,2)_" "_$$FO^IBCNEUT1($P(RPTDATA,U,13),5,"L")
 . ; if no payer is linked AND displaying payers
 . I $P(RPTDATA,U)="",TYP'=1 S DISPDATA(3)="   ** NOT CURRENTLY LINKED **",LCT=4,DISPDATA(4)="  " Q
 . ; if no payer and not displaying then quit
 . I $P(RPTDATA,U)="" S LCT=3,DISPDATA(3)="  " Q
 . ; Display Payer Info Line
 . S DISPDATA(3)="  "_$$FO^IBCNEUT1($P(RPTDATA,U,1),35,"L")_"   "_$$FO^IBCNEUT1($P(RPTDATA,U,2),15,"L")_$$FO^IBCNEUT1($S($P(RPTDATA,U,5)=1:"YES",1:"NO"),15,"L")
 . ; IB*2.0*521 add validated HPID to report
 . ;S DISPDATA(3)=DISPDATA(3)_$$FO^IBCNEUT1($S($P(RPTDATA,U,6)=1:"YES",1:"NO"),12,"L")_$$FO^IBCNEUT1($P(RPTDATA,U,4),16,"L")_"     "_$$FO^IBCNEUT1($P(RPTDATA,U,4),16,"L")
 . S DISPDATA(3)=DISPDATA(3)_$$FO^IBCNEUT1($S($P(RPTDATA,U,6)=1:"YES",1:"NO"),12,"L")_$$FO^IBCNEUT1($P(RPTDATA,U,4),16,"L")_"     "_$$FO^IBCNEUT1($P(RPTDATA,U,4),16,"L")
 . S LCT=4,DISPDATA(4)=" "
 S LCT=LCT+1
 Q
