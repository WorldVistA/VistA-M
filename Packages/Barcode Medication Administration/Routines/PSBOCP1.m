PSBOCP1 ;BIRMINGHAM/TEJ-COVERSHEET PRN OVERVIEW REPORT ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;**32**;Mar 2004;Build 32
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
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
CREATHDR ;
 K PSBHD1,PSBHD2
 I IOM'<132 S PSBHD1=$P($T(HD132A),"~",2),PSBHD2=$P($T(HD132B),";",2),PSBBLANK=$P($T(C132BLK),";",2)
 E  S PSBHD1="THIS REPORT SUPPORTS >131 CHAR./LINE PRINT FORMATS ONLY" Q
 ; reset tabs
 S PSBTAB0=1 F PSBI=0:1:($L(PSBHD1,"|")-1) S:PSBI>0 @("PSBTAB"_PSBI)=($F(PSBHD1,"|",@("PSBTAB"_(PSBI-1))+1))-1
 S PSBPGNUM=1
 D HDR
 Q
HD132A ;~ VDL |    Status   |Type|      Medication; Dosage, Route      |   Last Given  |      Since    |    Order Start   |    Order Stop   |
 Q
HD132B ; Tab |             |    |                                     |               |   Last Given  |    Date          |    Date         |
 Q
C132BLK ;;     |             |    |                                     |               |               |                  |                 |
 Q
HDR ;  Header
 W:$Y>1 @IOF
 W:$X>1 !
 S PSBRPNM="BCMA COVERSHEET PRN OVERVIEW REPORT"
 D:$P(PSBRPT(.1),U,1)="P"
 .S PSBHDR(0)=PSBRPNM
 .S PSBHDR(1)="Order Status(es): --"
 .F Y=4,5,7,8 I $P(PSBFUTR,U,Y) S $P(PSBHDR(1),": ",2)=$P(PSBHDR(1),": ",2)_$S(PSBHDR(1)["--":"",1:"/ ")_$P("^^^Future^Active^^Expired^DC'd^^^^^^^^^^",U,Y)_" " S PSBHDR(1)=$TR(PSBHDR(1),"-","")
 .I $P(PSBFUTR,U,11) S PSBHDR(2)="Include Action(s)"_$S(PSBCFLG:" & Comments/Reasons",1:"")
 .D PT^PSBOHDR(PSBXDFN,.PSBHDR)
 Q
FTR ;  Fter
 S PSBPG="Page: "_PSBPGNUM_" of "_$S($O(PSBOUTP(""),-1)=0:1,1:$O(PSBOUTP(""),-1))
 S PSBPGRM=PSBTAB8-($L(PSBPG))
 D PTFTR^PSBOHDR()
 W !,PSBRPNM,"     ",?(PSBPGRM-($L(PSBDTTM)+3)),PSBDTTM_"  "_PSBPG
 Q
