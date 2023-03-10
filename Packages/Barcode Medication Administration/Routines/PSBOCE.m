PSBOCE ;BIRMINGHAM/TEJ-Expired/DC'd/EXPIRING ORDERS REPORT ;03/06/16 3:06pm
 ;;3.0;BAR CODE MED ADMIN;**32,50,68,70,83,134**;Mar 2004;Build 1
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ; Reference/IA
 ; GETSIOPI^PSJBCMA5/5763
 ; 
 ;*68 - allow SIOPI builder to accomodate more than 1 line in SI array
 ;*70 - pass global var PSBCLINORD when Rpc Psbcsutl is called again
 ;    - add clinic name to new array PSBCLIN to track clinic name per 
 ;       order for printed output.
 ;    - pass global var PSBCLINORD when RPC psbcsutl is called again
 ;    - convert date/time fields to date only for CO and admin window 
 ;       to 7 days +/-.
 ;*83 - add Removes as new event for Next Action column:
 ;         Remove date@time
 ;
EN ;
 N PSBX1X,RESULTS,RESULT,PSBFUTR,X2,X3,QQ,PSBCLIN,PSBSRCHL,PSBHDR,EXPIREHDG,FUTUREHDG,FUTUREX,REMOV,PSBNXTX,PSBNXTX1,PSBNXTX2      ;*83
 S PSBCLINORD=$S($P($G(PSBRPT(4)),U,2)="C":1,1:0)                 ;*70
 S EXPIREHDG=$S(PSBCLINORD:"Expired/DC'd within last 7 days",1:"Expired/DC'd")
 S FUTUREHDG=$S(PSBCLINORD:"Expiring within next 7 days",1:"Expiring Tomorrow")
 S PSBFUTR=$TR(PSBRPT(1),"~",U)
 S (PSBOCRIT,PSBXFLG,PSBCFLG)=""   ; Ord Status srch crit - "A"ctve, "D"C ed, "E"xpred"
 S:$P(PSBFUTR,U,7) PSBOCRIT=PSBOCRIT_EXPIREHDG S:$P(PSBFUTR,U,8) PSBOCRIT=PSBOCRIT_EXPIREHDG S:$P(PSBFUTR,U,9) PSBOCRIT=PSBOCRIT_"Expiring Today"
 S:$P(PSBFUTR,U,10) PSBOCRIT=PSBOCRIT_FUTUREHDG
 S:$P(PSBFUTR,U,11) PSBXFLG=1
 I $D(PSBRPT(.2)) I $P(PSBRPT(.2),U,8) S PSBCFLG=1
 ;check Clinic search list                *70
 S PSBSRCHL=$$SRCHLIST^PSBOHDR()
 D:$P(PSBRPT(4),U,2)="C"
 .S:PSBSRCHL="" PSBSRCHL="All Clinics"
 .S PSBSRCHL="Clinic Search List: "_PSBSRCHL
 ;
 K PSBSRTBY,PSBCMT,PSBADM,PSBDATA,PSBOUTP,PSBLGD
 S PSBSORT=1
 D NOW^%DTC S (Y,PSBNOWX)=% D DD^%DT S PSBDTTM=Y
 D GETPAR^PSBPAR("ALL","PSB ADMIN BEFORE")
 S PSBB4=0 S:RESULTS(0)>0 PSBB4=+RESULTS(0)
 D GETPAR^PSBPAR("ALL","PSB ADMIN AFTER")
 S PSBAFT=0 S:RESULTS(0)>0 PSBAFT=+RESULTS(0)
 I PSBCLINORD S (PSBB4,PSBAFT)=7                                  ;*70
 K ^XTMP("PSBO",$J,"PSBLIST")
 S (PSBPGNUM,PSBLNTOT,PSBTOT,PSBX1X)=""
 K PSBLIST,PSBLIST2
 S PSBXDFN=$P(PSBRPT(.1),U,2)
 S PSBLIST(PSBXDFN)=""
 S (PSBX1X,PSBTOT)=0
 F  S PSBX1X=$O(PSBLIST(PSBX1X)) Q:+PSBX1X=0  D
 .D RPC^PSBCSUTL(.PSBAREA,PSBX1X,,,PSBCLINORD)                    ;*70
 .M PSBDATA=@PSBAREA
 .D GETREMOV^PSBO1(PSBXDFN)      ;get all removes for this patient *83
 .S PSBX2X=1
 .S (PSBLIST2(FUTUREHDG),PSBLIST2("Expiring Today"),PSBLIST2(EXPIREHDG),PSBLIST2(" * NO * "))=0
 .F  S PSBX2X=$O(PSBDATA(PSBX2X)) Q:+PSBX2X=0  D
 ..S PSBDATA=PSBDATA(PSBX2X)
 ..I $P(PSBDATA,U)="ORD" D  Q
 ...K PSBDRUGN
 ...S PSBORDN=$P(PSBDATA,U,3)
 ...S PSBCLIN(PSBORDN)=$S($P(PSBDATA,U,32)]"":"Location: ",1:"")_$P(PSBDATA,U,32)                      ;*70
 ...S PSBTB=$P(PSBDATA,U,29) S PSBTB=$S(PSBTB=1:"UD",PSBTB=2:"IVPB",PSBTB=3:"IV",1:" * ERROR * ")
 ...S PSBTB(PSBORDN,PSBTB)=""
 ...S PSBSTS=$P(PSBDATA,U,23) S PSBSTS=$S((PSBSTS="A")&(($P(PSBDATA,U,27)>PSBNOWX)):"Active",PSBSTS="H":"On Hold",PSBSTS="D":"Discontinued",PSBSTS="DE":"Discontinued (Edit)",(PSBSTS="E")!($P(PSBDATA,U,27)'>PSBNOWX):"Expired",1:" * ERROR * ")
 ...S PSBSTS(PSBORDN,PSBSTS)=""
 ...S X2=$P(PSBDATA,U,27),X3=$P(PSBNOWX,".")
 ...;add ability to use a different calculation and heading for future
 ...;expired IM and CO meds
 ...S FUTUREX=$S(PSBCLINORD:8,1:2)
 ...S PSBSTSX=$S((X2<PSBNOWX):EXPIREHDG,(X3'>X2)&($$FMADD^XLFDT(X3,1)>X2):"Expiring Today",($$FMADD^XLFDT(X3,1)'>X2)&(X2'>$$FMADD^XLFDT(X3,FUTUREX)):FUTUREHDG,1:" * NO * ")   ;*70
 ...;
 ...I PSBSTS["Discontinued" S PSBSTSX=EXPIREHDG
 ...S PSBLIST2(PSBSTSX,$P(PSBDATA,U,9),PSBORDN)=$P(PSBDATA,U,32) S PSBLIST2(PSBSTSX)=PSBLIST2(PSBSTSX)+1   ;*70 clin name
 ...S:PSBOCRIT[PSBSTSX PSBTOT=PSBTOT+1
 ...S PSBSCHTY=$P(PSBDATA,U,6)
 ...S PSBSCHTY(PSBORDN,PSBSCHTY)=""
 ...S PSBSCHD=$P(PSBDATA,U,7) I PSBSCHD="" S PSBSCHD=" "
 ...S PSBSCHD(PSBORDN,PSBSCHD)=""
 ...S PSBDOSR=$P(PSBDATA,U,10)_", "_$P(PSBDATA,U,11)
 ...S PSBDOSR=$TR($E(PSBDOSR,1)," ")_$E(PSBDOSR,2,999)
 ...S PSBDOSR(PSBORDN,PSBDOSR)="" K PSBOMDR(PSBORDN)
 ...S PSBNXTX1=$$NEXTADM^PSBCSUTX(PSBX1X,PSBORDN)
 ...S PSBNXTX2=""                                            ;init *83
 ...I PSBSTS["Hold" S PSBNXTX2="Provider Hold"
 ...I PSBSTS'["Hold" D 
 ...;
 ...;Next admin date triggers data for Next Action col, and also   *83
 ...;  if a remove action is pending use that text for NA col.     *83
 ...S REMOV=$O(^TMP("PSB",$J,"RM","B",PSBORDN,0))
 ...I PSBSTS'["Hold",((PSBNXTX1)!(REMOV)) D
 ....;build Admin Next Action text
 ....D:PSBNXTX1
 .....S NXTADM=$$FMADD^XLFDT(PSBNXTX1,,,PSBAFT)
 .....S PSBNXTX2=$S(PSBNOWX>NXTADM:"MISSED ",1:"DUE ")_PSBNXTX1
 ....;Removal tests and Next Action text build                     *83
 ....S REMOV=$O(^TMP("PSB",$J,"RM","B",PSBORDN,0))
 ....D:REMOV
 .....S MRR=$P(PSBDATA(PSBX2X),U,35)
 .....S RMVTIM=$P(^TMP("PSB",$J,"RM",REMOV),U)
 .....;Sched types below have no admin nor removal times, but do know
 .....; this MRR was given and next is Removal
 .....I ("^P^OC^"[("^"_PSBSCHTY_"^")) S:PSBSTS'["Hold" PSBNXTX2="(Removal)" Q
 .....;sys err tst, sched rmv dt/tm empty, if null use nxt adm for rmv
 .....I MRR=1,'RMVTIM S RMVTIM=PSBNXTX1
 .....I PSBNOWX>$$FMADD^XLFDT(RMVTIM,,,PSBAFT) D    ;missed rm
 ......S PSBNXTX2="MISSED "_RMVTIM_"  (Removal)"
 ......S:'RMVTIM PSBNXTX2="REMOVE"  ;err, rmv empty
 .....E  D                                          ;due rm
 ......S PSBNXTX2="REMOVE "_RMVTIM
 .....K MRR,NXTADM,RMVTIM
 ...;
 ...S PSBNXTX1=$$FMTDT^PSBOCE1(PSBNXTX1)
 ...;don't do if Expired Next action is a Removal                  *83
 ...I PSBNXTX2'["Removal",PSBNXTX2'["REMOVE" D
 ....I ("^P^OC^O"[(U_PSBSCHTY))!(PSBTB="IV")!(PSBSTS["Discontinued")!(PSBSTS["Expired") S:PSBSTS'["Hold" PSBNXTX2=" "
 ....I PSBNXTX2="" S PSBNXTX2=" "   ;P134
 ...S PSBNXTX(PSBORDN,PSBNXTX2)=""
 ...; ** SPC INSTR  **
 ...S PSBX2X=PSBX2X+1
 ...;  *68
 ...K ^TMP("PSJBCMA5",$J)
 ...I PSBSIFLG D GETSIOPI^PSJBCMA5(PSBX1X,PSBORDN,1)
 ...F QQ=0:0 S QQ=$O(^TMP("PSJBCMA5",$J,PSBX1X,PSBORDN,QQ)) Q:'QQ  D
 ....S PSBSI(PSBORDN,QQ)=^TMP("PSJBCMA5",$J,PSBX1X,PSBORDN,QQ)
 ...;  *68 end
 ...S PSBOSTDT=$P(PSBDATA,U,22)
 ...S PSBOSTDT(PSBORDN,PSBOSTDT)=""
 ...S PSBOSPDT=$P(PSBDATA,U,27)
 ...S PSBOSPDT(PSBORDN,PSBOSPDT)=""
 ..I "^DD^ADD^SOL"[(U_$P(PSBDATA,U)) D  Q
 ...F I=PSBX2X:1 S PSBDATA1=PSBDATA(I) D  Q:$D(PSBOMDR(PSBORDN))
 ....I "^DD^ADD^SOL"[(U_$P(PSBDATA1,U)) S PSBX2X=I S PSBDRUGN=$G(PSBDRUGN,"")_$P(PSBDATA1,U,3)_", " Q
 ....S $E(PSBDRUGN,$L(PSBDRUGN)-1)="" S PSBDRUGN(PSBORDN,$E(PSBDRUGN,1,250))=PSBDRUGN
 ....S PSBOMDR(PSBORDN,$E((PSBDRUGN_"; "_PSBDOSR),1,250))=PSBDRUGN_"; "_PSBDOSR
 ..I $P(PSBDATA,U)="END" Q
 ..I $P(PSBDATA(PSBX2X+1),U)="ORF" D  Q
 ...S PSBX2X=PSBX2X+1 S PSBDATA=PSBDATA(PSBX2X)
 ...S:$P(PSBDATA,U,2)]"" PSBFLGD(PSBORDN,$P(PSBDATA,U,3)_" - "_$P(PSBDATA,U,4))=""
 ..I ($P(PSBDATA,U)="ADM")&($P(PSBDATA,U,4)]"") D
 ...S PSBXID=$P(PSBDATA,U,6)_U_$P(PSBDATA,U,4),PSBADM(PSBORDN,(-1*($P(PSBDATA,U,6))),PSBXID)=PSBDATA
 ...I $O(PSBSCHTY(PSBORDN,""))="P" S PSBPRNR(PSBORDN,$P(PSBDATA,U,4))=$P(PSBDATA,U,9)
 ...I $P(PSBDATA,U,3)]"" S PSBBID(PSBORDN,$P(PSBDATA,U,4))=$P(PSBDATA,U,3)
 ...S:PSBXFLG PSBLGD(PSBORDN,"X","INITIALS",$P(PSBDATA,U,8))=""
 ...K PSBDATA(PSBX2X)
 ...I ($P(PSBDATA(PSBX2X+1),U)="CMT")  F  S PSBDATA=PSBDATA(PSBX2X+1) Q:($P(PSBDATA,U)'="CMT")  D
 ....S PSBX2X=PSBX2X+1
 ....S PSBDATA=PSBDATA(PSBX2X)
 ....K PSBDATA(PSBX2X)
 ....S:$P(PSBDATA,U,3)]"" PSBPRNEF(PSBORDN,$P(PSBXID,U,2))=$P(PSBDATA,U,3)
 ....I 'PSBCFLG S PSBDATA=PSBDATA(PSBX2X+1) Q
 ....I $P(PSBDATA,U,2)'="" D
 .....S PSBLGD(PSBORDN,"C","INITIALS",$P(PSBDATA,U,4))=""
 .....S PSBCMT(PSBORDN,$P(PSBXID,U,2),(-1*$P(PSBDATA,U,6)),PSBX2X)=PSBDATA
STOP I '$D(PSBLIST2) K PSBLIST,^XTMP("PSBO",$J,"PSBLIST")
 D CREATHDR
 D SUBHDR
 D BLDRPT
 D WRTRPT
 Q
BLDRPT ; Buld RPT DATA
 S X0="" K PSBLIST2(" * NO * "),PSBL2ULN
 S PSBTOPHD=PSBLNTOT-2
 I '$D(PSBLIST2) D  Q
 .S PSBOUTP(0,PSBLNTOT)="W !!,""<<<< NO ORDERS TO DISPLAY >>>>"",!!"
 S PSBMORE=5 F PSBX1X=EXPIREHDG,"Expiring Today",FUTUREHDG D
 .I PSBX1X'=" * ERROR * " S PSBSUM=PSBX1X_" ["_PSBLIST2(PSBX1X)_$S(PSBLIST2(PSBX1X)=1:" Order",1:" Orders")_"]" S PSBOUTP($$PGTOT,PSBLNTOT)="W !!,"""_PSBSUM_""""
 .Q:PSBLIST2(PSBX1X)=0
 .Q:PSBOCRIT'[PSBX1X
 .S:$L(PSBSUM)>$G(PSBL2ULN,0) PSBL2ULN=$L(PSBSUM)
 .S PSBOUTP($$PGTOT(2),PSBLNTOT)="W !,$TR($J("""",PSBL2ULN),"" "",""=""),!"
 .S PSBOUTP($$PGTOT,PSBLNTOT)="W !"
 .K PSBDATA
 .S X0="",PSBTOT1=0
 .F  S X0=$O(PSBLIST2(PSBX1X,X0))  Q:X0=""  F  S PSBX2X=$O(PSBLIST2(PSBX1X,X0,PSBX2X)) Q:PSBX2X=""  D
 ..M PSBLGD("INITIALS")=PSBLGD(PSBX2X,"X","INITIALS") M PSBLGD("INITIALS")=PSBLGD(PSBX2X,"C","INITIALS")
 ..S PSBDATA(1,1)=$O(PSBTB(PSBX2X,""))
 ..S PSBDATA(1,2)=$O(PSBSTS(PSBX2X,""))
 ..S PSBDATA(1,3)=$O(PSBSCHTY(PSBX2X,""))
 ..S Y0=$O(PSBOMDR(PSBX2X,"")) I Y0]"" S PSBDATA(1,4)="("_X0_")",PSBDATA(1,4,0)=PSBOMDR(PSBX2X,Y0)
 ..S PSBDATA(1,5)=$O(PSBSCHD(PSBX2X,""))
 ..S PSBDATA(1,6)=$O(PSBNXTX(PSBX2X,""))
 ..S:PSBDATA(1,6)'["Hold" $P(PSBDATA(1,6)," ",2)=$$FMTDT^PSBOCE1($P(PSBDATA(1,6)," ",2))
 ..S PSBDATA(1,7)=$$FMTDT^PSBOCE1($O(PSBOSTDT(PSBX2X,"")))
 ..S PSBDATA(1,8)=$$FMTDT^PSBOCE1($E($O(PSBOSPDT(PSBX2X,"")),1,12))
 ..K PSBSIDAT M PSBSIDAT=PSBSI(PSBX2X)                  ;*68
 ..S PSBTOT1=PSBTOT1+1
 ..K PSBDATA(2),PSBDATA(3),PSBSILN
 ..D BUILDLN^PSBOCE1,SIOPI^PSBOCM(.PSBSIDAT,PSBTAB8,$S(PSBX2X["V":"Other Print Info: ",1:""))
 ..I $D(PSBRPLN) S PSBMORE=$O(PSBRPLN(""),-1)+6 I $D(PSBSILN) S PSBMORE=PSBMORE+$O(PSBSILN(""),-1)
 ..K PSB1 I $D(PSBFLGD(PSBX2X)) S PSB="" F  S PSB=$O(PSBFLGD(PSBX2X,PSB)) Q:PSB=""  I ($P(PSB,":")'="NOX")&($P(PSB,":")'="STAT") S PSB1=$G(PSB1,"")_PSB
 ..;*70 build write clinic stmt      
 ..S PSBOUTP($$PGTOT,PSBLNTOT)="W """_$G(PSBCLIN(PSBX2X))_""""_",!"
 ..S PSBCNT=PSBTOT1_"   "_$G(PSB1,"")
 ..S PSBOUTP($$PGTOT,PSBLNTOT)="W """_PSBCNT_""""
 ..S I="" F  S I=$O(PSBRPLN(I)) Q:+I=0  D
 ...S PSBOUTP($$PGTOT,PSBLNTOT)="W !,"""_PSBRPLN(I)_""""
 ..S I="" F  S I=$O(PSBSILN(I)) Q:+I=0  D
 ...S PSBOUTP($$PGTOT,PSBLNTOT)="W !,"""_PSBSILN(I)_""""
 ..S PSBOUTP($$PGTOT(2),PSBLNTOT)="W !,$TR($J("""",PSBTAB8),"" "",""-""),!"
 ..K PSBRPLN,PSBDATA,PSBSILN
 D:+PSBTOT>0 LGD^PSBOCM
 Q
WRTRPT ;  writ
 I $O(PSBOUTP(""),-1)<1 D  Q
 .X PSBOUTP($O(PSBOUTP(""),-1),21)
 .D FTR
 S PSBPGNUM=1
 S PSBZ="" F  S PSBZ=$O(PSBOUTP(PSBZ)) Q:PSBZ=""  D
 .I PSBPGNUM'=PSBZ D FTR S PSBPGNUM=PSBZ D HDR,SUBHDR
 .S PSBX2X="" F  S PSBX2X=$O(PSBOUTP(PSBZ,PSBX2X)) Q:PSBX2X=""  D
 ..X PSBOUTP(PSBZ,PSBX2X)
 D FTR
 K ^XTMP("PSBO",$J,"PSBLIST"),PSBOUTP
 Q
HDR ;  Hder
 W:$Y>1 @IOF
 W:$X>1 !
 S PSBRPNM="BCMA COVERSHEET EXPIRED/DC'd/EXPIRING ORDERS REPORT"
 D:$P(PSBRPT(.1),U,1)="P"
 .S PSBHDR(0)=PSBRPNM
 .S PSBHDR(1)="Order Status(es): --"
 .F Y=7,8,9,10 I $P(PSBFUTR,U,Y) S $P(PSBHDR(1),": ",2)=$P(PSBHDR(1),": ",2)_$S(PSBHDR(1)["--":"",1:"/ ")_$P("^^^^^^Expired^DC'd^Expiring Today^"_FUTUREHDG_"^^^^^^^^",U,Y)_" " S PSBHDR(1)=$TR(PSBHDR(1),"-","")
 .I $P(PSBFUTR,U,11) S PSBHDR(2)="Include Action(s)"_$S(PSBCFLG:" & Comments/Reasons",1:"")
 .S:$G(PSBSRCHL)]"" PSBHDR(3)="",PSBHDR(4)=PSBSRCHL          ;*70
 .D PT^PSBOHDR(PSBXDFN,.PSBHDR)
 Q
SUBHDR ;
 N PSBAL S PSBAL=$O(PSBHDR("ALERGY",""),-1) S PSBAL=$S((PSBAL/12)>(PSBAL\12):(PSBAL\12)+1,1:(PSBAL\12))
 N PSBRE S PSBRE=$O(PSBHDR("REAC",""),-1) S PSBRE=$S((PSBRE/12)>(PSBRE\12):(PSBRE\12)+1,1:(PSBRE\12))
 S PSBLNTOT=$O(PSBHDR(""),-1)+9+PSBAL+PSBRE+1
 I $G(PSBPGNUM,0)=1 W !,?(PSBTAB8-($L("Total Orders reported: "_+PSBTOT))),"Total Orders reported: "_+PSBTOT,! S PSBLNTOT=PSBLNTOT+2
 W !,$TR($J("",PSBTAB8)," ","_") S PSBLNTOT=PSBLNTOT+1
 W !,$G(PSBHD1,"") S PSBLNTOT=PSBLNTOT+1
 W !,$G(PSBHD2,"") S PSBLNTOT=PSBLNTOT+1
 W !,$TR($J("",PSBTAB8)," ","="),! S PSBLNTOT=PSBLNTOT+2
 I $D(NOTE(PSBPGNUM)) W NOTE(PSBPGNUM),!! S PSBLNTOT=PSBLNTOT+2
 Q
FTR ;  Footr
 D PTFTR^PSBOHDR()
 S PSBPG="Page: "_PSBPGNUM_" of "_$S($O(PSBOUTP(""),-1)=0:1,1:$O(PSBOUTP(""),-1))
 S PSBPGRM=PSBTAB8-($L(PSBPG))
 W !,PSBRPNM,"     ",?(PSBPGRM-($L(PSBDTTM)+3)),PSBDTTM_"  "_PSBPG
 Q
PGTOT(X) ;mnt PAGE Number
 I (PSBLNTOT+PSBMORE)>(IOSL) D PGC^PSBOCE1
 I $G(X,1) S PSBLNTOT=PSBLNTOT+$G(X,1),PSBMORE=PSBMORE-$G(X,1)
 Q PSBPGNUM
CREATHDR ;
 K PSBHD1,PSBHD2
 I IOM'<132 S PSBMORE=4,PSBHD1=$P($T(HD132A),"~",2),PSBHD2=$P($T(HD132B),";",2),PSBBLANK=$P($T(H132BLK),";",2)
 E  S PSBHD1="THIS REPORT SUPPORTS >131 CHAR./LINE PRINT FORMATS ONLY" K PSBLIST2 Q
 ; tabs
 S PSBTAB0=1 F PSBI=0:1:($L(PSBHD1,"|")-1) S:PSBI>0 @("PSBTAB"_PSBI)=($F(PSBHD1,"|",@("PSBTAB"_(PSBI-1))+1))-1
 S PSBPGNUM=1
 D HDR
 Q
HD132A ;~ VDL |    Status     |Type|       Medication; Dosage, Route      |    Schedule    |     Next      |   Order Start  |   Order Stop  |
 Q
HD132B ; Tab |               |    |                                      |                |   Action      |     Date       |    Date       |
 Q
H132BLK ;;     |               |    |                                      |                |                |               |               |
 Q
