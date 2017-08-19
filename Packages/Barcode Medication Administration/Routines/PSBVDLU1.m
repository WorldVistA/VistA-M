PSBVDLU1 ;BIRMINGHAM/EFC-VIRTUAL DUE LIST (VDL) UTILITIES ;03/06/16 3:06pm
 ;;3.0;BAR CODE MED ADMIN;**13,32,68,70,83,92**;Mar 2004;Build 9
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference/IA
 ; EN^PSJBCMA/2828
 ; EN^PSJBCMA1/2829
 ; GETSIOPI^PSJBCMA5/5763
 ;
 ;*68 - add call to add special instructions (SI) entries to the
 ;      ^TMP("PSB")  global that ends up in the RESULTS ARRAY of
 ;      RPC PSB GETORDERTAB.
 ;*70 - add tags to rebuild TMP array built by PSJBCMA to filter
 ;      in or out Clinic Orders per request.
 ;*83 - define new var PSBDOA (duration On time in min for MRR meds)
 ;        and add flag and remove time to PSBREC(34 & 35)
 ;
ODDSCH(PSBTABX) ;
 I (PSBOST'<PSBWBEG)&(PSBOST'>PSBWEND) D ADD(PSBREC,PSBOTXT,PSBOST,PSBDDS,PSBSOLS,PSBADDS,PSBTABX)  ;Include start date/time as admin
 S PSBQUIT=0,PSBCDT=PSBOST F  S PSBCDT=$$FMADD^XLFDT(PSBCDT,"","",PSBFREQ) Q:PSBQUIT=1  D
 .I $P(PSBCDT,".",2)="" S PSBCDT=PSBCDT-1_".24"
 .I PSBCDT>PSBWEND S PSBQUIT=1 Q
 .I PSBCDT'<PSBWBEG,PSBCDT<PSBOSP D ADD(PSBREC,PSBOTXT,PSBCDT,PSBDDS,PSBSOLS,PSBADDS,PSBTABX) Q
 Q
GETFREQ(PSBDFN,PSBORDN) ;
 K ^TMP("PSJ1",$J)
 D EN^PSJBCMA1(PSBDFN,PSBORDN,1)
 S PSBFREQ=$P(^TMP("PSJ1",$J,4),U,11)
 S PSBSCHBR=$P(^TMP("PSJ1",$J,2),"^",5)
 I $$PSBDCHK1^PSBVT1(PSBSCHBR) S PSBFREQ=""
 K ^TMP("PSJ1",$J)
 Q PSBFREQ
 ;
GETADMIN(PSBDFN,PSBORDN,PSBSTRT,PSBFREQ,PSBEVDT) ;
 ;Determine administration times of an odd schedule for today
 N PSBADMIN
 K ^TMP("PSB",$J,"GETADMIN")
 D EN^PSJBCMA1(PSBDFN,PSBORDN,1)
 S PSBADMIN=$P(^TMP("PSJ1",$J,4),U,9),PSBFREQ=$P(^TMP("PSJ1",$J,4),U,11),^TMP("PSB",$J,"GETADMIN",0)=PSBADMIN
 I $E(PSBFREQ)'?1N K ^TMP("PSJ1",$J) Q $G(^TMP("PSB",$J,"GETADMIN",0))
 I PSBFREQ=0 K ^TMP("PSJ1",$J) Q $G(^TMP("PSB",$J,"GETADMIN",0))
 I PSBSTRT'<PSBEVDT S PSBADMIN=$E($P(PSBSTRT,".",2)_"0000",1,4),^TMP("PSB",$J,"GETADMIN",0)=PSBADMIN
 S PSBCDT=PSBSTRT,(PSBADTMX,PSBQUIT)=0 F  S PSBCDT=$$FMADD^XLFDT(PSBCDT,"","",PSBFREQ) D  Q:PSBQUIT=1
 .I $P(PSBCDT,".",2)="" S PSBCDT=PSBCDT-1_".24"
 .I (PSBCDT\1)>(PSBEVDT\1) S PSBQUIT=1 Q
 .I (PSBCDT\1)=(PSBEVDT\1) S PSBADMIN=PSBADMIN_$S(PSBADMIN="":"",1:"-")_$E($P(PSBCDT,".",2)_"0000",1,4)
 .S ^TMP("PSB",$J,"GETADMIN",PSBADTMX)=PSBADMIN
 .S:($L(PSBADMIN)+5)>255 PSBADTMX=PSBADTMX+1,PSBADMIN=""
 K ^TMP("PSJ1",$J),PSBADTMX
 Q $G(^TMP("PSB",$J,"GETADMIN",0))
 ;
ADD(PSBREC,PSBSI,PSBDT,PSBDD,PSBSOL,PSBADD,PSBTAB) ;
 ;
 ; Description: Add order to ^TMP("PSB",$J,PSBTAB,...) for RPC Return RESULTS
 ;
 ; PSBREC=order hdr from above
 ; PSBSI=special instructions
 ; PSBDT=admin date/time
 ; PSBDD=Dispense Drugs
 ; PSBSOL=Solutions
 ; PSBADD=Additives
 ;
 N PSB
 S PSBDT=$E(PSBDT,1,12),PSBQR=0
 S PSB=$O(^TMP("PSB",$J,PSBTAB,""),-1) ; Get next node
 S $P(PSBREC,U,14)=PSBDT ; Admin Time sits in ^14
 ;
 ; *83 If MRR Med, add Remove code & Remove time, (34,35)
 D REMOVETM(PSBMRRFL,PSBSCHT)
 ;
 I $P(PSBREC,U,5)'="O" S X=$O(^PSB(53.79,"AORD",DFN,PSBONX,PSBDT,0)) D:X
 .S $P(PSBREC,U,12)=X
 .K PSBLCK L +^PSB(53.79,X):1  I  L -^PSB(53.79,X) S PSBLCK=1
 .S PSBSTUS=$P(^PSB(53.79,X,0),U,9),$P(PSBREC,U,13)=$S(PSBSTUS="N":"",(PSBSTUS="")&$G(PSBLCK):"U",1:PSBSTUS),$P(PSBREC,U,23)=$P(^PSB(53.79,X,0),U,10),$P(PSBREC,U,24)=$P(^PSB(53.79,X,0),U,7)
 .I $D(^PSB(53.79,X)) I PSBDOSEF="PATCH",PSBSTUS="G",PSBDT=$P(^PSB(53.79,X,.1),U,3),PSBQRR=0 S PSBQR=1
 .I PSBSTUS="G",$G(PSBFLAG) D CHECK ;Get the correct dispense drug
 I ($P(PSBREC,U,5)="O") D
 .S X=$O(^PSB(53.79,"AORDX",DFN,PSBONX,"")) Q:X=""
 .S Y=$O(^PSB(53.79,"AORDX",DFN,PSBONX,X,"")) Q:Y=""  S $P(PSBREC,U,12)=Y
 .K PSBLCK L +^PSB(53.79,Y):1  I  L -^PSB(53.79,Y) S PSBLCK=1
 .S PSBSTUS=$P(^PSB(53.79,Y,0),U,9),$P(PSBREC,U,13)=$S(PSBSTUS="N":"",(PSBSTUS="")&$G(PSBLCK):"U",1:PSBSTUS),$P(PSBREC,U,24)=$P(^PSB(53.79,Y,0),U,7)
 .I $D(^PSB(53.79,Y)) I PSBDOSEF="PATCH",PSBSTUS="G",PSBDT=$P(^PSB(53.79,Y,.1),U,3),PSBQRR=0 S PSBQR=1
 .I PSBSTUS="G",$G(PSBFLAG) D CHECK
 Q:PSBQR=1
 ;
 S $P(PSBREC,U,25)=0 I $G(PSBTRFL),$P(PSBREC,U,11)]"",$P(PSBREC,U,11)'<$G(PSBNTDT),$P(PSBREC,U,11)'>$G(PSBTRDT) S $P(PSBREC,U,25)=1
 S PSB=PSB+1,^TMP("PSB",$J,PSBTAB,PSB)=PSBREC ; Order Hdr
 I $P(PSBREC,U,12)]"" S PSBONVDL($P(PSBREC,U,12))=""
 S PSB=PSB+1,^TMP("PSB",$J,PSBTAB,PSB)=PSBSI ; Special Instructions
 ; add dispense drugs
 I $D(PSBDDA) S X="" F  S X=$O(PSBDDA(X)) Q:X=""  S PSB=PSB+1,^TMP("PSB",$J,PSBTAB,PSB)=PSBDDA(X)
 S PSBCHDT=0
 I (PSBTAB'["CVRSHT"),(PSBONX["V"),(PSBOSTS="D"),($G(PSBFOR)="") D  Q  ;get infusing bag from DCed but not DEed orders
 .D PSJ^PSBVT(PSBX)
 .D INFUSING^PSBVDLU2 I PSBCOMP=0 Q
 .I $D(PSBSOLA) S X="" F  S X=$O(PSBSOLA(X)) Q:X=""  S PSB=PSB+1,^TMP("PSB",$J,PSBTAB,PSB)=PSBSOLA(X)
 .I $D(PSBADA) S X="" F  S X=$O(PSBADA(X)) Q:X=""  S PSB=PSB+1,^TMP("PSB",$J,PSBTAB,PSB)=PSBADA(X)
 .S X="" F  S X=$O(PSBPORA(PSBONX,X)) S PSBUID=$P(PSBPORA(PSBONX,X),U,1) Q:PSBUID]""  Q:X=""
 .I PSBUID["P" Q
 .I PSBUID["WS" D
 ..S PSBNODE=$O(^PSB(53.79,"AUID",DFN,X,PSBUID,""))
 ..S PSBUIDA(PSBUID)="ID"_U_PSBUID
 ..S X=0 F  S X=$O(^PSB(53.79,PSBNODE,.6,X)) Q:'X  S PSBUIDA(PSBUID)=PSBUIDA(PSBUID)_U_"ADD;"_$P(^PSB(53.79,PSBNODE,.6,X,0),U,1)
 ..S X=0 F  S X=$O(^PSB(53.79,PSBNODE,.7,X)) Q:'X  S PSBUIDA(PSBUID)=PSBUIDA(PSBUID)_U_"SOL;"_$P(^PSB(53.79,PSBNODE,.7,X,0),U,1)
 .S PSBSONX=PSBONX
 .I '$D(PSBUIDA(PSBUID)) S PSBCKOR="" F  S PSBCKOR=$O(PSBPORA(PSBSONX,PSBCKOR)) Q:PSBCKOR=""  D CLEAN^PSBVT,PSJ1^PSBVT(DFN,PSBCKOR) Q:$D(PSBUIDA(PSBUID))
 .S PSBONX=PSBSONX
 .S:$D(PSBUIDA(PSBUID)) PSB=PSB+2,^TMP("PSB",$J,PSBTAB,PSB-1)=PSBUIDA(PSBUID),^TMP("PSB",$J,PSBTAB,PSB)="END"
 .D CLEAN^PSBVT,PSJ1^PSBVT(DFN,$O(PSBPORA("")))
 ; add additives
 I $D(PSBADA) S X="" F  S X=$O(PSBADA(X)) Q:X=""  S PSB=PSB+1,^TMP("PSB",$J,PSBTAB,PSB)=PSBADA(X)
 ; add solutions
 I $D(PSBSOLA) S X="" F  S X=$O(PSBSOLA(X)) Q:X=""  S $P(PSBSOLA(X),U,5)="",PSB=PSB+1,^TMP("PSB",$J,PSBTAB,PSB)=PSBSOLA(X)
 I PSBONX["V" D EN^PSBPOIV(DFN,PSBONX)  ; get bags
 I $D(^TMP("PSBAR",$J)) S PSBUID=DFN_"V"_99999 F  S PSBUID=$O(^TMP("PSBAR",$J,PSBUID),-1) Q:PSBUID=""  D
 .S PSBUIDS=^TMP("PSBAR",$J,PSBUID)
 .I $P(PSBUIDS,U,1)="I",$P(PSBUIDS,U,2)'="I",$P(PSBUIDS,U,2)'="S" Q  ; bag has invalid IV parameter, is not infusing or stopped
 .I $P(PSBUIDS,U,2)'="I",$P(PSBUIDS,U,2)'="S",$P(PSBUIDS,U,8)'="" Q  ; label is no longer valid, bag is not infusing or stopped
 .I $P(PSBUIDS,U,2)="C" Q  ; bag is completed
 .I $P(PSBUIDS,U,2)="G" Q  ; bag is given (PBTAB)
 .S PSB=PSB+1,^TMP("PSB",$J,PSBTAB,PSB)=$P(PSBUIDS,U,10,999)
 K ^TMP("PSBAR",$J)
 D:PSBSIOPI GETSI(DFN,PSBONX,PSBTAB)                    ;*68
 S PSB=PSB+1,^TMP("PSB",$J,PSBTAB,PSB)="END"
 S ^TMP("PSB",$J,PSBTAB,0)=PSB
 Q
 ;
CHECK S FILE=53.795,PSBNODE=.5,PSBIENS=X_","
 F I=0:0 S I=$O(^PSB(53.79,X,PSBNODE,I)) Q:'I  S $P(PSBDDS,U,3,4)=$$GET1^DIQ(FILE,I_","_PSBIENS,.01,"I")_U_$$GET1^DIQ(FILE,I_","_PSBIENS,.01)
 Q
 ;
VNURSE(PSBTAB) ;add initials of verifying pharmacist/verifying nurse
 F PSBLP=1:1:$P(^TMP("PSB",$J,PSBTAB,0),U,1) S X=^TMP("PSB",$J,PSBTAB,PSBLP) I $P(X,U)=DFN D
 .K ^TMP("PSJ1",$J)
 .D PSJ1^PSBVT(DFN,$P(X,U,2))
 .S $P(^TMP("PSB",$J,PSBTAB,PSBLP),U,19)=$S(PSBVNI]"":PSBVNI,PSBVNX]"":$E($P(PSBVNX,",",2))_$E(PSBVNX),1:"***") ;Use first and last initial from name field if Initial field blank, PSB*3*92
 K PSBLP,PSBTAB
 Q
 ;
OKAY(PSBSTRT,PSBADMIN,PSBSCH,PSBORDER,PSBDRUG,PSBFREQ,PSBOSTS) ;
 ;
 ; Description: Determines if an order schedule is valid for
 ;  the date in PSBADMIN (i.e. Q4D, is it valid today)
 ;
 ; PSBSTRT:  Start Date of order (Time ignored)
 ; PSBADMIN: Date of administration to check (Time ignored)
 ; PSBSCH:  Schedule (i.e. MO-WE-FR@0900 or Q48H...)
 ; PSBORDER: Order reference
 ; PSBDRUG:  Drug ordered (Orderable Item)
 ; PSBOSTS: The status of the order
 ;
 N PSBOKAY,PSBDAYS,PSBDOW
 S PSBOSTS=$G(PSBOSTS)
 ;
 S PSBOKAY=0  ; Default Flag
 I PSBFREQ'="",PSBFREQ'="D",PSBFREQ'>1440 Q 1
 ;PRN and ONE TIMES show everyday
 I (PSBSCHT="P")!(PSBSCHT="O") Q 1
 S PSBDAYS=$$DAYS(PSBSCH)
 ;
 I PSBDAYS=1 S PSBOKAY=1 Q PSBOKAY  ; Order is everyday
 ;
 ; find out if today is a good day for multi days
 S PSBOKAY=0,PSBRDTE=PSBSTRT
 S PSBADBR=PSBADMIN\1
 S PSBENR=(PSBADMIN\1)+1
 I PSBDAYS>1 D  Q PSBOKAY
 .I PSBADBR=(PSBSTRT\1) S PSBOKAY=1
 .F  S PSBRDTE=$$FMADD^XLFDT(PSBRDTE,"","",PSBFREQ) Q:PSBRDTE>PSBENR  D
 ..I $P(PSBRDTE,".",2)="" S PSBRDTE=PSBRDTE-1_".24"
 ..I PSBRDTE\1=PSBADBR S PSBOKAY=1
 ..I PSBOKAY="1" Q
 ;
 ; Try the MO-WE-FR@0800 thing as last resort
 S X=PSBADMIN D H^%DTC I %Y=-1 D  Q PSBOKAY  ; Error
 .S PSBOKAY=0
 .Q:PSBOSTS="E"
 .Q:$G(PSBMHND)="PSBOMH"
 .D ERROR^PSBMLU($G(PSBORDER,"UNKNOWN"),$G(PSBDRUG,""),DFN,"Unable to determine schedule "_PSBSCH,PSBSCH)
 S PSBDOW=$P("SU^MO^TU^WE^TH^FR^SA",U,%Y+1)
 I $F(PSBSCH,PSBDOW)>0 S PSBOKAY=1 Q PSBOKAY
 S PSBOKAY=0
 Q PSBOKAY
 ;
DAYS(PSB) ; Return days between doses (-1: error, 1:everyday 2: QOD...)
 ;
 ; Is it a PRN
 I PSB?.E1"PRN".E Q 1  ; Straight PRN - As Needed
 ;
 S PSB=$TR(PSB," ","")
 I PSB?2.4N.E Q 1
 S X=PSBFREQ/1440 Q X
 ;
 Q
 ;
LAST ;
 S PSBCC=0
 S ZZ="" F  S ZZ=$O(^PSB(53.79,X,.3,ZZ),-1) Q:'ZZ  Q:PSBFLAG=1  S PSBDATA2=$G(^(ZZ,0)) D
 .S PSBCC=PSBCC+1
 .I (PSBCC=2)!($P($P(PSBDATA2,U)," ")="Refused:")!($P($P(PSBDATA2,U)," ")="Held:") S $P(PSBREC,U,11)=$P(PSBDATA2,U,3),PSBFLAG=1
 Q
 ;
GETSI(DFN,ORD,TAB) ;Get Special Instructions/Other Print Info from IM   ;*68
 ;
 ; This Tag will load the SIOPI WP text into the TMP global used by
 ; the PSB GETORDERTAB RPC, which ends up in the RESULTS array passed
 ; back to the BCMA GUI.
 ;
 N QQ
 K ^TMP("PSJBCMA5",$J,DFN,ORD)
 D GETSIOPI^PSJBCMA5(DFN,ORD,1)
 Q:'$D(^TMP("PSJBCMA5",$J,DFN,ORD))
 F QQ=0:0 S QQ=$O(^TMP("PSJBCMA5",$J,DFN,ORD,QQ)) Q:'QQ  D
 .S PSB=PSB+1
 .S ^TMP("PSB",$J,TAB,PSB)="SI^"_^TMP("PSJBCMA5",$J,DFN,ORD,QQ)
 K ^TMP("PSJBCMA5",$J,DFN,ORD)
 Q
 ;
INCLUDCO ;Rebuild TMP global from PSJBCMA, RETAIN CLINC ORDERS ONLY  *70
 N QQ,IMCNT,COCNT
 S (IMCNT,COCNT)=0 K ^TMP("PSJTMP",$J)
 F QQ=0:0 S QQ=$O(^TMP("PSJ",$J,QQ)) Q:'QQ  D
 . I $P($G(^TMP("PSJ",$J,QQ,0)),U,11)]"" D
 .. S COCNT=COCNT+1
 .. M ^TMP("PSJTMP",$J,COCNT)=^TMP("PSJ",$J,QQ)
 K ^TMP("PSJ",$J) M ^TMP("PSJ",$J)=^TMP("PSJTMP",$J)
 K ^TMP("PSJTMP",$J)
 S:'$D(^TMP("PSJ",$J)) ^TMP("PSJ",$J,1,0)=-1
 Q
 ;
REMOVECO ;Rebuild TMP global from PSJBCMA, RETAIN IM ORDERS ONLY         *70
 N QQ,IMCNT
 S IMCNT=0 K ^TMP("PSJTMP",$J)
 F QQ=0:0 S QQ=$O(^TMP("PSJ",$J,QQ)) Q:'QQ  D
 . I $P($G(^TMP("PSJ",$J,QQ,0)),U,11)="" D  Q
 .. S IMCNT=IMCNT+1
 .. M ^TMP("PSJTMP",$J,IMCNT)=^TMP("PSJ",$J,QQ)
 K ^TMP("PSJ",$J) M ^TMP("PSJ",$J)=^TMP("PSJTMP",$J)
 K ^TMP("PSJTMP",$J)
 S:'$D(^TMP("PSJ",$J)) ^TMP("PSJ",$J,1,0)=-1
 Q
 ;
MODELITE() ;
 N ORDCNT,CLIN,ORDNO,STRT,STOP,STAT,PSBIMNOW,PSBIMDT
 S ORDCNT=""
 K ^TMP("PSJ",$J)
 S PSBIMNOW=+$E($$NOW^XLFDT,1,10),PSBIMDT=$P(PSBIMNOW,".")
 D EN^PSJBCMA(DFN,PSBIMNOW,PSBIMDT)
 Q:^TMP("PSJ",$J,1,0)=-1 ""
 F QQ=0:0 S QQ=$O(^TMP("PSJ",$J,QQ)) Q:'QQ  D
 . S CLIN=$P(^TMP("PSJ",$J,QQ,0),U,11)
 . S ORDNO=$P(^TMP("PSJ",$J,QQ,0),U,3)
 . S STRT=$P($P(^TMP("PSJ",$J,QQ,1),U,4),".")
 . S STOP=$P($P(^TMP("PSJ",$J,QQ,1),U,5),".")
 . S STAT=$P(^TMP("PSJ",$J,QQ,1),U,7)
 . D:CLIN]""
 .. I ORDNO'["P",(STAT="A"!(STAT="H")!(STAT="R")!(STAT="O")),STRT'>DT,STOP'<DT S $P(ORDCNT,U,2)=1 ;modelite display for held, renewed, and on call PSB*3*92
 . D:CLIN=""
 .. I ORDNO'["P",(STAT="A"!(STAT="H")!(STAT="R")!(STAT="O")),STRT'>DT,STOP'<DT S $P(ORDCNT,U)=1 ;modelite display for held and renewed, and on call PSB*3*92
 Q ORDCNT
 ;
INITTAB ;*70
 K ^TMP("PSB",$J,PSBTAB)
 S ^TMP("PSB",$J,PSBTAB,0)=1
 S ^TMP("PSB",$J,PSBTAB,1)="-1^No Administration(s) due at this time."
 Q
 ;
FINDORD(BWDFWD,DFN,PSBDT,PSBTAB) ;Search a patient's orders Bwd or Fwd    *70
 ; Find the next day that contains an Active admin time not Given.
 ;
 N QQ,SPDT,STARTDT,STDT,STOPDT,STPDT
 S PSBSIOPI="",PSBCLINORD=1
 N NODE1,ENDDT,STRDT,STOPDT,STDT,SPDT,STARTDT,STOPDT,SDT,QUIT,REC,QQ
 N PSBWBEG,PSBWEND,PSBWADM,FOUND,GIVE,PDT
 K ^TMP("PSJ",$J)
 D EN^PSJBCMA(DFN,PSBDT,PSBDT),INCLUDCO^PSBVDLU1
 Q:^TMP("PSJ",$J,1,0)=-1 -1
 ;
 ;read thru psj tmp and create start date xref
 F QQ=0:0 S QQ=$O(^TMP("PSJ",$J,QQ)) Q:'QQ  D
 . S NODE1=$G(^TMP("PSJ",$J,QQ,1))
 . Q:$P(NODE1,U,7)'="A"              ;not active sts
 . S STRDT=$P($P(NODE1,U,4),"."),STDT(STRDT)=""
 . S STPDT=$P($P(NODE1,U,5),"."),SPDT(STPDT)=""
 S STARTDT=+$O(STDT(0))
 Q:(BWDFWD=-1)&('STARTDT) -1
 S STOPDT=+$O(SPDT(999999999),-1)
 Q:(BWDFWD=1)&('STOPDT) -1
 ;
 D:BWDFWD=-1 LOOPBWD
 D:BWDFWD=1 LOOPFWD
 Q PDT
 ;
LOOPBWD ; Loop thru days backwards and quit when pass End date.    *70
 S (REC,QUIT,FOUND)=0
 F QQ=BWDFWD:BWDFWD S PDT=$$FMADD^XLFDT(PSBDT,QQ) Q:PDT<STARTDT  D  Q:FOUND!QUIT
 . I PDT<STARTDT S QUIT=1 Q
 . D INITTAB^PSBVDLU1
 . S PSBWBEG=$P(PDT,".")_".0000"
 . S PSBWEND=$P(PDT,".")_".2400"
 . S PSBWADM=99999
 . S PSBWADM=$$FMADD^XLFDT(PDT,"","",+PSBWADM)
 . D:PSBTAB="UDTAB" EN^PSBVDLUD(DFN,PDT)
 . D:PSBTAB="PBTAB" EN^PSBVDLPB(DFN,PDT)
 . S FOUND=+$G(^TMP("PSB",$J,PSBTAB,2))          ;=dfn, if data found
 . S GIVE=$P($G(^TMP("PSB",$J,PSBTAB,2)),U,13)   ;get give sts
 . S:GIVE="G" FOUND=0                            ;skip, as was given
 S:'FOUND PDT=-1
 Q
 ;
LOOPFWD ; Loop thru days forwards and quit when pass End date.    *70
 S (REC,QUIT,FOUND)=0
 F QQ=BWDFWD:BWDFWD S PDT=$$FMADD^XLFDT(PSBDT,QQ) Q:PDT>STOPDT  D  Q:FOUND!QUIT
 . I PDT>STOPDT S QUIT=1 Q
 . D INITTAB^PSBVDLU1
 . S PSBWBEG=$P(PDT,".")_".0000"
 . S PSBWEND=$P(PDT,".")_".2400"
 . S PSBWADM=99999
 . S PSBWADM=$$FMADD^XLFDT(PDT,"","",+PSBWADM)
 . D:PSBTAB="UDTAB" EN^PSBVDLUD(DFN,PDT)
 . D:PSBTAB="PBTAB" EN^PSBVDLPB(DFN,PDT)
 . S FOUND=+$G(^TMP("PSB",$J,PSBTAB,2))          ;=dfn, if data found
 . S GIVE=$P($G(^TMP("PSB",$J,PSBTAB,2)),U,13)   ;get give sts
 . S:GIVE="G" FOUND=0                            ;skip, as was given
 S:'FOUND PDT=-1
 Q
 ;
PATCHON(DFN,ORDR) ;check if any patches are still Given & Not Removed per this patient
 ;  Return values:
 ;    Func:   True/False (1/0) for patches do exist on a patient.
 ;    ORDR(): array element "C"linic or "I"npatient order = 1 when
 ;             at least 1 order of this type exists.
 ;
 N ON,DAYSBK,ORDNO,STOPDT,IMCL
 S ON=0,ORDR("C")=0,ORDR("I")=0
 Q:'$D(^PSB(53.79,"APATCH",DFN)) ON
 F QQ=0:0 S QQ=$O(^PSB(53.79,"APATCH",DFN,QQ)) Q:'QQ  D
 . F RR=0:0 S RR=$O(^PSB(53.79,"APATCH",DFN,QQ,RR)) Q:'RR  D
 .. I $P(^PSB(53.79,RR,0),U,9)="G" D
 ... S ORDNO=$P(^PSB(53.79,RR,.1),"^")
 ... D CLEAN^PSBVT
 ... D PSJ1^PSBVT(DFN,ORDNO) Q:'$G(PSBOSP)
 ... S STOPDT=PSBOSP
 ... S DAYSBK=+($$GET^XPAR("DIV","PSB VDL PATCH DAYS"))
 ...; simulate PSBVDLPA logic to look back Kernel param days
 ... I DAYSBK D NOW^%DTC I $$FMADD^XLFDT($P(STOPDT,"."),DAYSBK)<X Q
 ... S ON=1
 ... S IMCL=$S($G(PSBCLORD)]"":"C",1:"I"),ORDR(IMCL)=1
 ... D CLEAN^PSBVT
 Q ON
 ;
INFUSING(DFN,ORDR) ;check if any IV's have bags infusing per this patient
 ;  Return values:
 ;    Func:   True/False (1/0) for patches do exist on a patient.
 ;    ORDR(): array element "C"linic or "I"npatient order = 1 when
 ;             at least 1 order of this type exists.
 ;
 N ON,DAYSBK,ORDNO,STOPDT,IMCL,PSBCLIEN
 S ON=0,ORDR("C")=0,ORDR("I")=0
 Q:'$D(^PSB(53.79,"AINFUSING",DFN)) ON
 F QQ=0:0 S QQ=$O(^PSB(53.79,"AINFUSING",DFN,QQ)) Q:'QQ  D
 . F RR=0:0 S RR=$O(^PSB(53.79,"AINFUSING",DFN,QQ,RR)) Q:'RR  D
 .. S ORDNO=$P(^PSB(53.79,RR,.1),"^")
 .. D CLEAN^PSBVT
 .. D PSJ1^PSBVT(DFN,ORDNO) Q:'$G(PSBOSP)
 .. S STOPDT=PSBOSP
 .. ; simulate IV VDL logic to look 3 days back for IM meds or 7 days
 .. ; for CO med.
 .. D NOW^%DTC
 .. I '$G(PSBCLIEN),$$FMADD^XLFDT($P(STOPDT,"."),3)<X Q
 .. I $G(PSBCLIEN),$$FMADD^XLFDT($P(STOPDT,"."),7)<X Q
 .. S ON=1
 .. S IMCL=$S($G(PSBCLORD)]"":"C",1:"I"),ORDR(IMCL)=1
 .. D CLEAN^PSBVT
 Q ON
 ;
STOPPED(DFN,ORDR) ;check if any IV's have bags infusing per this patient
 ;  Return values:
 ;    Func:   True/False (1/0) for patches do exist on a patient.
 ;    ORDR(): array element "C"linic or "I"npatient order = 1 when
 ;             at least 1 order of this type exists.
 ;
 N ON,DAYSBK,ORDNO,STOPDT,IMCL,PSBCLIEN
 S ON=0,ORDR("C")=0,ORDR("I")=0
 Q:'$D(^PSB(53.79,"ASTOPPED",DFN)) ON
 F QQ=0:0 S QQ=$O(^PSB(53.79,"ASTOPPED",DFN,QQ)) Q:'QQ  D
 . F RR=0:0 S RR=$O(^PSB(53.79,"ASTOPPED",DFN,QQ,RR)) Q:'RR  D
 .. S ORDNO=$P(^PSB(53.79,RR,.1),"^")
 .. D CLEAN^PSBVT
 .. D PSJ1^PSBVT(DFN,ORDNO) Q:'$G(PSBOSP)
 .. S STOPDT=PSBOSP
 .. ; simulate IV VDL logic to look 3 days back for IM meds or 7 days
 .. ; for CO med.
 .. D NOW^%DTC
 .. I 'PSBCLIEN,$$FMADD^XLFDT($P(STOPDT,"."),3)<X Q
 .. I PSBCLIEN,$$FMADD^XLFDT($P(STOPDT,"."),7)<X Q
 .. S ON=1
 .. S IMCL=$S($G(PSBCLORD)]"":"C",1:"I"),ORDR(IMCL)=1
 .. D CLEAN^PSBVT
 Q ON
 ;
REMOVETM(MRR,STYP) ;** Check if MRR med & add to Results array (34,35)   *83
 ;
 ; Add MRR code to Results(34) and if MRR > 0 then add remove time
 ; to Results(35).
 ;
 N RMDT,RMTIM
 S $P(PSBREC,U,34)=MRR           ;set MRR flag in 34
 ;
 Q:'MRR                          ;Quit, not MRR med, no remove time
 Q:(PSBSCHT="OC")!(PSBSCHT="P")  ;Quit, schd types have no admin times
 Q:$P(PSBREC,U,35)               ;Quit, already set from get MRR rtns
 ;
 ; Remove date/time Calculation method will correctly compute a future
 ;  Remove date/time per this admin time, by using the FMADD function
 ;  to add the DOA value to the admin time.  DOA value is the time the
 ;  med is to be on the patient and must be removed after that time.
 ;
 ; **Notice: Sched Type of "O", Remove time = Order Stop date/time
 ;
 ;   e.g.  if sched is Q7D and Freq=10080, then DOA=10080 also, and is
 ;         returned by PSJBCMA1
 ;
 S ADMTIM=$P(PSBREC,U,14)                      ;admin time
 S:PSBDOA RMTIM=$$FMADD^XLFDT(ADMTIM,,,PSBDOA) ;calc RM time if DOA
 I (PSBDOA<1!(PSBOSP>$$NOW^XLFDT)),STYP="O" S RMTIM=PSBOSP ;RM time for One-Time, non-expired orders, PSB*3*92 
 S $P(PSBREC,U,35)=$G(RMTIM)                   ;Add RM date/time
 Q
