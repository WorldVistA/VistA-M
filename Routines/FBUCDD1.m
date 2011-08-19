FBUCDD1 ;ALBISC/TET - DD UTILITY (cont'd.) ;5/27/93
 ;;3.5;FEE BASIS;**60,72**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
DEL(DA) ;del node on .01 field of 162.7, unauthorized claim file
 ;INPUT:  DA = ien of 162.7
 I 1 N FBORDER,FBZ S FBZ=$$FBZ^FBUCUTL(DA) S FBORDER=$$ORDER^FBUCUTL(+$P(FBZ,U,24)) W ! W:FBORDER'<40 "Disposition to Cancel/Withdrawn." W:FBORDER<40 "Use the Delete Unauthorized Claim option." W !
 Q
DEV(X) ;input transform on field 33, UNAUTHORIZED CLAIM PRINTER, file 161.4
 ;check x, and if x is a device, with subtype beginning with p(rinter)
 ;INPUT:  X - FM variable, input
 ;OUTPUT: 1 to kill x (invalid entry), otherwise 0
 Q $S('$D(X):1,'$$DEVICE(X):1,1:0)
 ;
SUBTYPE(X) ;extrinsic call for subtype check
 ;INPUT:  X = internal entry of device
 ;OUTPUT: 1 if subtype is a printer
 N Z1,Z2 S Z1=$S('$D(X):0,'+X:0,1:X),Z2=0 S Z2=+$G(^%ZIS(1,X,"SUBTYPE")),Z2=$P($G(^%ZIS(2,Z2,0)),U)
 Q $S(Z2']"":0,$E(Z2,1)="P":1,1:0)
 ;
DEVICE(X) ;extrinsic call for device ien
 ;INPUT:  X = name
 ;OUTPUT: 1 if device with printer subtype
 N Z1 S Z1=0,Z1=+$O(^%ZIS(1,"B",X,0))
 Q $S('Z1:0,'$$SUBTYPE(Z1):0,1:1)
 ;
XHELP ;executable help from field 33, UNAUTHORIZED CLAIM PRINTER, file 161.4
 ;displays printer selection
 D HOME^%ZIS H 1 W @IOF,!,"Select a printer device name.",!,"NOTE:  This is not a pointer field, the exact name must be entered."
 W !!,?5,"Printer name:",?40,"Location:",!,?5,"-------------",?40,"---------"
 N FBX,FBXZ,FBX1 S FBX=0 F  S FBX=$O(^%ZIS(1,FBX)) Q:'FBX  I $$SUBTYPE(FBX) S FBXZ=$G(^%ZIS(1,FBX,0)),FBX1=$G(^(1)) D  G:$D(DTOUT)!($D(DUOUT)) XHELPQ
 .I ($Y+5)>IOSL S DIR(0)="E" D ^DIR K DIR Q:$D(DTOUT)!($D(DUOUT))  W @IOF,!!,?5,"Printer name:",?40,"Location:",!,?5,"-------------",?40,"---------"
 .W !?5,$P(FBXZ,U),?40,$P(FBX1,U)
XHELPQ W ! K DIR,DTOUT,DUOUT Q
ID(Y) ;display identifiers
 N FBZ S FBZ=$$FBZ^FBUCUTL(+Y)  Q:Y']""  W ?15,$E($$VET^FBUCUTL(+$P(FBZ,U,4)),1,20),?38,$E($$VEN^FBUCUTL(+$P(FBZ,U,3)),1,20)
 W ?61,$E($$PROG^FBUCUTL(+$P(FBZ,U,2)),1,14),!,$E($P($$PTR^FBUCUTL("^FB(162.92,",+$P(FBZ,U,24)),U),1,16)
 W ?19,"TREATMENT FROM: ",$$DATX^FBAAUTL(+$P(FBZ,U,5)),?44,"TREATMENT TO: ",$$DATX^FBAAUTL(+$P(FBZ,U,6))
 W ! Q
 ;
DELA(DA,M) ;delete authorization node
 ;INPUT:  DA = ien of authorization (161.01)
 ;        DA(1)= ien of patient (161)
 ;        M=message (optional) 1 to print;0 to not print
 ;VAR:  M, 2nd piece = message to print:  1 for payments, 2 for 7078/583
 ;OUTPUT: 1 if ok to delete; 0 if should not delete
 ;        message may write explaining why cannot delete
 I $S('$G(DA):1,'$G(DA(1)):1,1:0) G DELAQ
 S:'$G(M) M=0
 N FBI,FBV,FBVAR
 S FBVAR=$P($G(^FBAAA(DA(1),1,DA,0)),U,9),FBV=+$P($G(^FBAAA(DA(1),1,DA,0)),U,4)
 I 'FBV="0" S FBV=FBV-1
 F  S FBV=$O(^FBAAC(DA(1),1,FBV)) Q:'FBV!($P(M,U,2))  D
 .S FBI=0
 .F  S FBI=$O(^FBAAC(DA(1),1,FBV,1,FBI)) Q:'FBI!($P(M,U,2))  S FBI(0)=$G(^FBAAC(DA(1),1,FBV,1,FBI,0)) I $P(FBI(0),U,4)=DA,$O(^FBAAC(DA(1),1,FBV,1,FBI,1,1,0)) S $P(M,U,2)=1
 I FBVAR]"",$$PAY^FBUCUTL($P(FBVAR,";"),$P(FBVAR,";",2)) S $P(M,U,2)=1
 I '$P(M,U,2),FBVAR]"" S $P(M,U,2)=2
 I +M,$P(M,U,2) W !! D  W !
 .W:$P(M,U,2)=1 "Cannot delete Authorization because payments already exist!"
 .W:$P(M,U,2)=2 "Cannot delete Authorization because a 7078/583 entry has already been established!"
DELAQ Q $S('+$P($G(M),U,2):0,$P(M,U,2):1,1:0)
