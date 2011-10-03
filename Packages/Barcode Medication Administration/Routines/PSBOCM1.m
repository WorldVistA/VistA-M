PSBOCM1 ;BIRMINGHAM/TEJ-COVERSHEET MEDICATION OVERVIEW REPORT ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;**32,50**;Mar 2004;Build 78
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
BUILDLN ; Constr recs
 K J S J(0)="" F PSBFLD=1:1:8 S J=1 D FORMDAT(PSBFLD) S J($O(PSBRPLN(""),-1))=""
 ; Write administration info...
 Q:'PSBXFLG
 S J=($O(J(""),-1)+1),PSBRPLN(J)=PSBBLANK,J(J)="",J=J+1
 S (N,Y)="",J=($O(J(""),-1)+1)
 F  S Y=$O(PSBADM(PSBX2X,Y)) Q:Y']""  D
 .F  S N=$O(PSBADM(PSBX2X,Y,N)) Q:N']""  D
 ..I $D(PSBBID(PSBX2X,$P(N,U,2))) S PSBDATA(2,0)="BAG ID: "_PSBBID(PSBX2X,$P(N,U,2))
 ..S $E(PSBDATA(2,0),25)="ACTION BY: "_$P(PSBADM(PSBX2X,Y,N),U,7)_" "_$$FMTDT^PSBOCE1($E($P(PSBADM(PSBX2X,Y,N),U,6),1,12))
 ..S X=$P(PSBADM(PSBX2X,Y,N),U,5) S $E(PSBDATA(2,0),56)="ACTION: "_$S(X="G":"GIVEN",X="R":"REFUSED",X="RM":"REMOVED",X="H":"HELD",X="S":"STOPPED",X="I":"INFUSING",X="C":"COMPLETED",X="M":"MISSING DOSE",X=" ":"*UNKNOWN*",1:" ")
 ..I $D(PSBPRNR(PSBX2X)) S $E(PSBDATA(2,0),72)="PRN REASON: "_PSBPRNR(PSBX2X,$P(N,U,2))
 ..I $G(PSBDATA(2,0))]" " D WRAPPER(1,132-1,PSBDATA(2,0)) K PSBDATA(2) S J=J+1
 ..N PSBEIECMT S PSBEIECMT="" I $D(PSBPRNEF(PSBX2X,$P(N,U,2))),$P($G(PSBRPT(.2)),U,8)=0 S PSBEIECMT=$$PRNEFF^PSBO(PSBEIECMT,$P(N,U,2))
 ..I $D(PSBPRNEF(PSBX2X,$P(N,U,2))) S PSBDATA(2,0)="PRN EFFECTIVENESS: "_PSBPRNEF(PSBX2X,$P(N,U,2))_PSBEIECMT
 ..I $G(PSBDATA(2,0))]" " D WRAPPER(30,132-30,PSBDATA(2,0)) K PSBDATA(2) S J=J+1
 ..I ('PSBCFLG)!('$D(PSBCMT(PSBX2X,$P(N,U,2)))) S PSBRPLN(J)=PSBBLANK,J(J)="",J=J+1 Q
 ..S X="" F   S X=$O(PSBCMT(PSBX2X,$P(N,U,2),X)) Q:X']""  D
 ...N PSBDAT S PSBDAT="" F  S PSBDAT=$O(PSBCMT(PSBX2X,$P(N,U,2),X,PSBDAT)) Q:PSBDAT']""  D
 ....S PSBDATA(2,0)="COMMENT BY: "_$S($P(PSBCMT(PSBX2X,$P(N,U,2),X,PSBDAT),U,5)]"":$P(PSBCMT(PSBX2X,$P(N,U,2),X,PSBDAT),U,5)_" "_$$FMTDT^PSBOCE1($E($P(PSBCMT(PSBX2X,$P(N,U,2),X,PSBDAT),U,6),1,12)),1:" n/a ")
 ....S PSBDATA(2,0)=PSBDATA(2,0)_"  COMMENT: "_$S($P(PSBCMT(PSBX2X,$P(N,U,2),X,PSBDAT),U,2)]"":$P(PSBCMT(PSBX2X,$P(N,U,2),X,PSBDAT),U,2),1:" ")
 ....I $G(PSBDATA(2,0))]" " D WRAPPER(30,132-30,PSBDATA(2,0)) K PSBDATA(2) S J=J+1
 ..S PSBRPLN(J)=PSBBLANK,J(J)="",J=J+1
 Q
FORMDAT(FLD) ;
 K PSBVAL
 Q:'$D(PSBDATA(1,FLD))
 S PSBVAL=PSBDATA(1,FLD)
 D WRAPPER(@("PSBTAB"_(FLD-1))+1,((@("PSBTAB"_(FLD))-(@("PSBTAB"_(FLD-1))+1))),PSBVAL)
 I FLD=4 S J=$O(J(""),-1)+1,PSBVAL=PSBDATA(1,4,0) D WRAPPER(@("PSBTAB"_(FLD-1))+1,((@("PSBTAB"_(FLD))-(@("PSBTAB"_(FLD-1))+1))),PSBVAL)
 Q
WRAPPER(X,Y,Z) ;  Text WRAP
 N PSB
 I ($L(Z)>0),$F(Z,"""")>1 F  Q:$F(Z,"""")'>1  S Z=$TR(Z,"""","^")
 F  Q:'$L(Z)  D
 .I $L(Z)<Y S $E(PSBRPLN(J),X)=Z S Z="" D  Q
 ..I $L(PSBRPLN(J),"^")>1 F X=1:1:$L(PSBRPLN(J),"^")-1 S $P(PSBRPLN(J),"^",X)=$P(PSBRPLN(J),"^",X)_""""
 ..S PSBRPLN(J)=$TR(PSBRPLN(J),"^","""")
 .F PSB=Y:-1:0 Q:($E(Z,PSB)=" ")  Q:($E(Z,PSB)="-")
 .S:PSB<1 PSB=Y
 .S $E(PSBRPLN(J),X)=$E(Z,1,PSB)
 .S Z=$E(Z,PSB+1,250)
 .I $L(PSBRPLN(J),"^")>1 F X=1:1:$L(PSBRPLN(J),"^")-1 S $P(PSBRPLN(J),"^",X)=$P(PSBRPLN(J),"^",X)_""""
 .S PSBRPLN(J)=$TR(PSBRPLN(J),"^","""")
 .S J=J+1,J(J)=""
 Q ""
CREATHDR ;
 K PSBHD1,PSBHD2
 I IOM'<132 S PSBHD1=$P($T(HD132A),"~",2),PSBHD2=$P($T(HD132B),";",2),PSBBLANK=$P($T(C132BLK),";",2)
 E  S PSBHD1="THIS REPORT SUPPORTS >131 CHAR./LINE PRINT FORMATS ONLY" Q
 ; reset tabs
 S PSBTAB0=1 F PSBI=0:1:($L(PSBHD1,"|")-1) S:PSBI>0 @("PSBTAB"_PSBI)=($F(PSBHD1,"|",@("PSBTAB"_(PSBI-1))+1))-1
 S PSBPGNUM=1
 D HDR
 Q
HD132A ;~VDL  |   Order    |Type|       Medication; Dosage, Route      |  Schedule   |      Next Action      |  Order Start  |   Order Stop  |
 Q
HD132B ;Tab  |   Status   |    |                                      |             |                       |   Date        |    Date       |
 Q
C132BLK ;;
 Q
WRTRPT ;  writ
 I $O(PSBOUTP(""),-1)<1 D  Q
 .X PSBOUTP($O(PSBOUTP(""),-1),14)
 .D FTR
 S PSBPGNUM=1
 S PSBZ="" F  S PSBZ=$O(PSBOUTP(PSBZ)) Q:PSBZ=""  D
 .I PSBPGNUM'=PSBZ D FTR S PSBPGNUM=PSBZ D HDR,SUBHDR^PSBOCE
 .S PSBX2X="" F  S PSBX2X=$O(PSBOUTP(PSBZ,PSBX2X)) Q:PSBX2X=""  D
 ..X PSBOUTP(PSBZ,PSBX2X)
 D FTR
 K ^XTMP("PSBO",$J,"PSBLIST"),PSBOUTP
 Q
HDR ;  Header
 W:$Y>1 @IOF
 W:$X>1 !
 S PSBRPNM="BCMA COVERSHEET MEDICATION OVERVIEW REPORT"
 D:$P(PSBRPT(.1),U,1)="P"
 .S PSBHDR(0)=PSBRPNM
 .S PSBHDR(1)="Order Status(es): --"
 .F Y=4,5,7,8 I $P(PSBFUTR,U,Y) S $P(PSBHDR(1),": ",2)=$P(PSBHDR(1),": ",2)_$S(PSBHDR(1)["--":"",1:"/ ")_$P("^^^Future^Active^^Expired^DC'd^^^^^^^^^^",U,Y)_" " S PSBHDR(1)=$TR(PSBHDR(1),"-","")
 .I $P(PSBFUTR,U,11) S PSBHDR(2)="Include Action(s)"_$S(PSBCFLG:" & Comments/Reasons",1:"")
 .D PT^PSBOHDR(PSBXDFN,.PSBHDR)
 Q
FTR ;  Fter
 D PTFTR^PSBOHDR()
 S PSBPG="Page: "_PSBPGNUM_" of "_$S($O(PSBOUTP(""),-1)=0:1,1:$O(PSBOUTP(""),-1))
 S PSBPGRM=PSBTAB8-($L(PSBPG))
 W !,PSBRPNM,"     ",?(PSBPGRM-($L(PSBDTTM)+3)),PSBDTTM_"  "_PSBPG
 Q
