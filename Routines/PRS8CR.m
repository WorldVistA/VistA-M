PRS8CR ;HISC/MRL-DECOMPOSITION, CREATE STRING ;01/17/07
 ;;4.0;PAID;**2,6,45,69,112,117**;Sep 21, 1995;Build 32
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;This routine take the information contained in the WK array
 ;and creates the activity string to be passed to Austin.  The
 ;WK(1) node contains those items pertaining to Week 1 activity,
 ;WK(2) contains those items pertaining to Week 2 activity and
 ;WK(3) contains the Miscellaneous information shown on the bottom
 ;of the timecard.
 ;
 ;Called by Routines:  PRS8DR
 ;
 ;Variable S contains the lengths of each of the Values for the
 ;different time codes.  Used to format values with leading and
 ;trailing zero's
 N MLINHRS
 S MLINHRS=$$MLINHRS^PRSAENT(DFN)
 S S="3333333333333333333333333333333334436232333333333333333"
 S E(1)="ANSKWDNOAURTCECUUNNANBSPSASBSCDADBDCTFOAOBOCYAOKOMRARBRCHAHBHCPTPAONYDHDVCEA  EB  TATCFAFCADNTRSSRSDNDCFCHCPCR"
 S E(2)="ALSLWPNPABRLCTCOUSNRNSSQSESFSGDEDFDGTGOEOFOGYEOSOURERFRGHLHMHNPHPBCLYHHOVSEC  ED  TBTDFBFDAFNHRNSSSHNUCGCICQCS"
 S E(3)="NLDWINTLLULNLDDTTOLAMLCAPCCYRRFFFECD"
 K V S V="" F I=1,2,3 S V(I)=""
 ;
 ;Next section gets Week 1 and Week 2 data and stores in V(WK)
 F J=1,2 F I=1:1:38,40,42:1:55 S X=+$P(WK(J),"^",I) I X]"" D
 .; Don't report PT/PT for nurses on AWS schedules
 .Q:$E(AC,2)=1&($P(C0,U,16)=72)&(I=32)  ; 36/40 AWS
 .Q:$E(AC,2)=2&($P(C0,U,16)=80)&(I=32)  ; 9month AWS
 .;
 .I TYP'["D",I'=38,I'=40 D QH
 .I TYP["D" S X=+X_"0"
 .I TYP["Pd",$E(ENT,2)'="D",$P(WK(J),"^",32)="",V(J)="" S V(J)=V(J)_$S(J=1:"PT000",J=2:"PH000",1:"") ;for p/t drs put PT,PH in 8B string even if they are 0 (PT+PH=NH)
 .I I=32,TYP["P",TYP["N",TYP'["B"!(TYP["H"),'X D  Q
 ..S X=$E("0000000",0,+$E(S,I)-$L(X))_X
 ..S V(J)=V(J)_$E(E(J),I+(I-1),I*2)_X
 ..Q
 .I I=37,$P(C0,"^",20)="P",$P(C0,"^",21)="U" D
 ..S X=$E("0000000",0,+$E(S,I)-$L(X))_X
 ..I 'X S V(J)=V(J)_$E(E(J),I+(I-1),I*2)_X
 ..Q
 .S X=+X I I=32,TYP["Pd",X=0 S X=1
 .Q:'X
 .I I=32,TYP["Pd",X=1 S X=0
 .I I=38!(I=40) D
 ..S Z=X,X=4*$P(WK(J),"^",I+1) D QH
 ..S X=($E("00",0,$E(S,I)-$L(Z))_+Z)_($E("000",0,$E(S,I+1)-$L(+X))_+X) ;combine env. diff. % and hours
 ..Q
 .E  S X=$E("0000000",0,+$E(S,I)-$L(X))_+X
 .I +X S V(J)=V(J)_$E(E(J),I+(I-1),I*2)_X,V=V+X
 ;
 ;Now we get miscellaneous data
 ;
 S S="22134446114423146"
 F I=1:1:17 S X=$P(WK(3),"^",I) I X'="" D
 .I I=11 D
 . . I MLINHRS D QH ; Convert to 1/4 hours.
 . . I MLINHRS=0 S X=X_"0" ; Convert to 1/4 hours.
 .S X=$E("000000",0,+$E(S,I)-$L(X))_X
 .I $D(X) S V(3)=V(3)_$E(E(3),I+(I-1),I*2)_X,V=V+X
 ;
 ;finish up
 ;
 S VAL="" I $L(V(1))!($L(V(2)))!($L(V(3))) S X=V(1)_V(2)_V(3)_"CD"_$E("000000",0,6-$L(+V))_+V,VAL=X
 ;
STUB ; --- enter here to create stub only
 I '($D(VAL)#2) S VAL=""
 ; code below to add CP field to STUB record (32nd position)
 S CPFX=""
 S CPFX=$P($G(^PRST(458,PY,"E",DFN,0)),"^",6) ;get CP from 458
 I CPFX="" S CPFX=$P($G(^PRSPC(DFN,1)),"^",7) ;if 458 null get from 450
 I "0"[CPFX S CPFX=" " ;if it is 0 or "" set CPFX = " "
 S PPE=$G(^PRST(458,+PY,0)),PPE=$P(PPE,"^",1),PPI=+PY D ^PRSAXSR
 S VAL=HDR_CPFX_VAL ;decomp no longer saves 8B in 5 node (6/95)
 K I,J,S Q
 ;
QH ; --- for persons paid hourly/convert to Quarter Hours
 ;
 I I'=37 S X1=X#4,X=X\4_+X1 K X1
 Q
