PRCOEC3 ;WISC/DJM-IFCAP SEGMENTS HE,MI ;11/24/93  15:03
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
HE(VAR1,VAR2) ;PO HEADER INFORMATION SEGMENT
 N A,A1,A12,DD,P,PHN,POD,X,Y
 S A=$G(^PRC(442,VAR1,0)),A1=$G(^PRC(442,VAR1,1)),A12=$G(^PRC(442,VAR1,12)) S:A12="" VAR2="ERROR" W:A12="" !,"NP12-No node 12 in file 442 for this P.O." Q:A12=""
 S X=$P(A1,U,15) S:X="" VAR2="ERROR" W:X="" !,"NPOD No purchase order date in file 442 for this P.O." Q:X=""
 S X=$P(A,U,10) S:X="" VAR2="ERROR" W:X="" !,"NDD No delivery date for this P.O. in file 442." Q:X=""  S P=$P(A1,U,10)
 S:P="" VAR2="ERROR" W:P="" !,"NPPM No purchasing agent entry in file 442 for this P.O." Q:P=""
 S PHN=$P($G(^VA(200,P,.13)),"^",5) I PHN="",'$G(PRCHPC) S VAR2="ERROR" W !,"NPHN No phone number node in the person file for this PPM."
 S PHN=$P(PHN,U) I PHN="",'$G(PRCHPC) S VAR2="ERROR" W !,"NPH No phone number for this PPM in the person file."
 Q
MI(VAR1,VAR2) ;MISCELLANEOUS INFORMATION SEGMENT
 N M1,PR
 S M0=$G(^PRC(442,VAR1,0)),M1=$G(^PRC(442,VAR1,1)),PR=$P(M1,U,8) S:$P(M0,U,19)=2 PR="N/A" S:PR="" VAR2="ERROR" W:PR="" !,"NOPR No PROPOSAL entry in file 442 for this P.O." Q
