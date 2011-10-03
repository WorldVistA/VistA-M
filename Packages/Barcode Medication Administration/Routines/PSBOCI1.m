PSBOCI1 ;BIRMINGHAM/TEJ-COVERSHEET IV OVERVIEW REPORT ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;**32**;Mar 2004;Build 32
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ;
BUILDLN ; Constr recs
 K J S J(0)="" F PSBFLD=1:1:7  S J=1 D FORMDAT^PSBOCE1(PSBFLD) S J($O(PSBRPLN(""),-1))=""
 ; Write administration info...
 Q:'PSBXFLG
 ; Get Actions
 K PSBXDTL S (PSBXDTL,N,Y)="",J=($O(J(""),-1)+1)
 D BAGDTL^PSBRPC2(.PSBXDTL,XI,PSBX2X)
 I $D(PSBXDTL(1)) I +$P(PSBXDTL(1),U)=-1 S PSBRPLN(J)=PSBBLANK,J(J)="",J=J+1 Q
 S J=($O(J(""),-1)+1),PSBRPLN(J)=PSBBLANK,J(J)="",J=J+1
 F Y=1:1:PSBXDTL(0)  S N=PSBXDTL(Y) D
 .Q:('PSBCFLG)&($P(N,U,3)']"")
 .S $E(PSBDATA(2,0),25)="BY: "_$P(N,U,2)_" "_$$FMTDT^PSBOCE1($E($P(N,U),1,12))
 .S $E(PSBDATA(2,0),49)="ACTION: "_$P(N,U,3)
 .I $G(PSBDATA(2,0))]" " D WRAPPER^PSBOCE1(1,132-1,PSBDATA(2,0)) K PSBDATA(2) S J=J+1
 .M PSBLGD("INITIALS")=PSBLGD(PSBX2X,"INITIALS")
 .Q:('PSBCFLG)!($P(N,U,4)']"")
 .S PSBDATA(2,0)=$G(PSBDATA(2,0),"")_"  COMMENT: "_$P(N,U,4)
 .I $G(PSBDATA(2,0))]" " D WRAPPER^PSBOCE1(49,132-49,PSBDATA(2,0)) K PSBDATA(2) S J=J+1
 S PSBRPLN(J)=PSBBLANK,J(J)="",J=J+1
 Q
PTFTR ;Patient Page footer
 I (IOSL<100) F  Q:$Y>(IOSL-7)  W !
 W !,$TR($J("",IOM)," ","=")
 S X="Ward: "_PSBHDR("WARD")_"  Room-Bed: "_PSBHDR("ROOM")
 W !,PSBHDR("NAME"),?(IOM-11\2),PSBHDR("SSN"),?(IOM-$L(X)),X
 S PSBPG="Page: "_PSBPGNUM_" of "_$S($O(PSBOUTP(""),-1)=0:1,1:$O(PSBOUTP(""),-1))
 S PSBPGRM=PSBTAB7-($L(PSBPG))
 W !,PSBRPNM,"     ",?(PSBPGRM-($L(PSBDTTM)+3)),PSBDTTM_"  "_PSBPG
 Q
