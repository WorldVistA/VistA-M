DGPTRI4 ;ALB/JDS/MJK/MTC/ADL/TJ - ALB/BOK  PTF TRANSMISSION ;03 Dec 2012  10:40 PM
 ;;5.3;Registration;**850**;Aug 13, 1993;Build 171
 ;
701 ; -- setup 701 transaction
 S Y=$S(T1:"C",1:"N")_"701"_DGHEAD,DGDDX=$P(+DG70,".")_"       ",Y=Y_$E(DGDDX,4,5)_$E(DGDDX,6,7)_$E(DGDDX,2,3)_$E($P(+DG70,".",2)_"0000",1,4)
 S X=DG70
 ;replace specialty pointer (ien) with ptf code (alpha-numeric)
 N DGARRX,DGARRY ;DG729
 S DGARRX=$$TSDATA^DGACT(42.4,$P(X,U,2),.DGARRY)
 S $P(X,U,2)=$G(DGARRY(7))
 S (L,Z)=2 D ENTER0 K DGDDX
 S X=DG70 I "467"[($P(X,U,3)\1) S Y=Y_$P(X,U,3)_"         " G J
 S L=1 F Z=3:1:5 D ENTER
 S Y=Y_$S($D(^DIC(45.6,+$P(X,U,6),0)):$P(^(0),U,2),1:" "),L=3,Z=12 D ENTER S Y=Y_$E($P(X,U,13)_"   ",1,3)
J S L=3,Z=8 D ENTER0
 S Y=Y_"X"_$J($P(DG70,U,9),1)
 N EFFDATE,IMPDATE,DGPTDAT D EFFDATE^DGPTIC10(J)
 S DGPTTMP=$$ICDDATA^ICDXCODE("DIAG",+$P(DG70,U,10),EFFDATE,"I")
 S DGXLS=$S(+DGPTTMP>0&($P(DGPTTMP,U,10)):$P(DGPTTMP,U,2),1:""),Y=Y_$S(DGXLS[".":$J($P(DGXLS,".",1),3)_$E($P(DGXLS,".",2)_"    ",1,4),1:$J(DGXLS,7))
 ;
 S L=$P(DG70,U,16,24)_U_DG71 S DG702=""
 F K=1:1:12 S DGPTTMP=$$ICDDATA^ICDXCODE("DIAG",+$P(L,U,K),EFFDATE,"I") D
 . I +DGPTTMP>0&($P(DGPTTMP,U,10)) S DG702=DG702_$P(DGPTTMP,U,2)_U
 S Y=Y_$S(DG702']"":"X",1:" ")
 ; -- get phy cdr @ d/c
 S X="",Z=+$O(^DGPT(J,535,"AM",DG70-.0000001)) I $D(^DGPT(J,535,+$O(^(Z,0)),0)) S X=^(0)
 ; -- set phy cdr
 S Z=$P(X,U,16) D CDR
 ; -- set phy spec
 ;replace specialty pointer (ien) with ptf code (alpha-numeric)
 N DGARRX,DGARRY ;DG729
 S DGARRX=$$TSDATA^DGACT(42.4,$P(X,U,2),.DGARRY)
 S $P(X,U,2)=$G(DGARRY(7))
 S L=2,Z=2 D ENTER0
 S X=$S($P(DG3,U)="Y":$$RTEN($P(DG3,U,2)),1:"0"),L=3,Z=1 D ENTER0
 ;-- additional ptf questions
 S DGAUX=$S($D(^DGPT(J,300)):^(300),1:"")
 D ADDQUES
 K DGAUX,DGDRUG
 ;
 ;-- sc,ao,ir,ec questions
 S X=DG70
 ;-- sc
 S Y=Y_$E($P(DG70,U,25)_" ") ; col 88
 ;-- ao
 S Y=Y_$E($P(DG70,U,26)_" ") ; col 89
 ;-- ir
 S Y=Y_$E($P(DG70,U,27)_" ") ; col 90
 ;-- SW Asia conditions/ec
 S Y=Y_$E($P(DG70,U,28)_" ") ; col 91
 ;-- mst
 S Y=Y_$E($P(DG70,U,29)_" ") ; col 92
 ;-- Head/Neck CA
 S Y=Y_$E($P(DG70,U,30)_" ")
 D ETHNIC
 D RACE
 ;Combat vet
 S Y=Y_$E($P(DG70,U,31)_" ")
 ;Project 112/SHAD
 S Y=Y_$E($P(DG70,U,32)_" ")
 D FILL
 I T1 F K=41:1:55,65:1:73 S Y=$E(Y,1,K-1)_" "_$E(Y,K+1,125)
 I T1 D CEN^DGPTRI1 S:'DGERR ^XMB(3.9,DGXMZ,2,DGCNT,0)=Y,DGCNT=DGCNT+1 Q
 I 'T1 D SAVE
 ;
702 ;
 I DG702']"" D 704 Q
 S Y="N702"_$E(Y,5,40)
 F K=1:1:12 S F=$P(DG702,U,K),F=$P(F,".",1)_$E($P(F,".",2)_"    ",1,4),F=F_$E("       ",1,7-$L(F)),Y=Y_F
 D FILL
 I 'DGERR S ^XMB(3.9,DGXMZ,2,DGCNT,0)=Y,DGCNT=DGCNT+1
 I DGERR'>0 S DGACNT=DGACNT+1,^TMP("AEDIT",$J,$E(Y,1,4),DGACNT)=Y
 S DG702=$P(DG702,U,6,9)
 D 704
 Q
 ;
704 ; -- Build segment 704 for 501 POA transmission
 N Y,I
 S Y=$S(T1:"C",1:"N")_"704"_DGHEAD,X=$P(DGTD,".")_"       "
 S Y=Y_$E(X,4,5)_$E(X,6,7)_$E(X,2,3)_$E($P(DGTD,".",2)_"0000",1,4)_" "
 ;
 F I=1:1:13 S Y=Y_$E($G(DGRPOA(I))_"      ",1,6)
 D FILL^DGPTRI2,SAVE
 ;only send 705 if more than 15 movements
 I DGPTMCNT>13 D 705
 ;always send 705 (Save For future implementation)
 ;D 705
 K DGPTMCNT,DGRPOA
 Q
 ;
705 ; -- Build the 705 segment for 501 POA transmission
 S Y=$S(T1:"C",1:"N")_"705"_DGHEAD,X=$P(DGTD,".")_"       "
 S Y=Y_$E(X,4,5)_$E(X,6,7)_$E(X,2,3)_$E($P(DGTD,".",2)_"0000",1,4)_" "
 S CNT=DGPTMCNT
 F I=1:1:12 S Y=Y_$E($G(DGRPOA(I+13))_"      ",1,6)
 D FILL^DGPTRI2,SAVE
 Q
 ;
 ;
POA(Y) ;-- Add POA to end of 101 segment with POA
 N DGPOA,L,K S DGPOA=$G(^DGPT(J,82))
 S L=$P(DG70,U,10)_U_$P(DG70,U,16,24)_U_DG71
 F K=1:1:13 S Y=Y_$S($P(L,U,K)'="":$$POAVAL($P(DGPOA,U,K)),1:" ") ;6/18/2012 send what is stored per call with Dorothea Garrett.
 Q
 ;
POAVAL(POA) ; -- Convert POA indicator to a 1 or 0 for use in calculating DRG
 ; -- note:  Transmission of space " " if no corresponding DIAGNOSIS
 ; -- see POA^DGPTFD, same logic, different return values.
 S POA=$G(POA)
 ;
 ; -- On 8/9/2012 the ADT SME Determined that null POA should be defaulted to Yes
 ;    Due to the fact that the COTS PTF software was not uploading POA information.
 Q $S(POA="Y":"Y",POA="N":"N",POA="":"Y",POA="U":"U",POA="W":"W",1:"Y")
 ;
ENTER S Y=Y_$J($P(X,U,Z),L)
 Q
 ;
ENTER0 S Y=Y_$S($P(X,U,Z)]"":$E("00000",$L($P(X,U,Z))+1,L)_$P(X,U,Z),1:$J($P(X,U,Z),L))
 Q
 ;
SAVE D START^DGPTRI1 S:'DGERR ^XMB(3.9,DGXMZ,2,DGCNT,0)=Y,DGCNT=DGCNT+1
 I DGERR'>0 S DGACNT=DGACNT+1,^TMP("AEDIT",$J,$E(Y,1,4),DGACNT)=Y
Q Q
 ;
FILL F K=$L(Y):1:124 S Y=Y_" "
 Q
 ;
CDR S Y=Y_$E($P(Z,".")_"0000",1,4)_$E($P(Z,".",2)_"00",1,2)
 Q
ADDQUES ;-- additional PTF questions load records for trans 501/701
 N DGADDQ
 F DGADDQ=2,3,4 D  ;null results if discharge>inactive date. DG/729
 . I +$P($G(^DIC(45.88,DGADDQ,0)),U,3) S $P(DGAUX,U,DGADDQ)=$S((+$G(^DGPT(J,70))<$P(^DIC(45.88,DGADDQ,0),U,3)):$P(DGAUX,U,DGADDQ),1:"")
 S DGDRUG=$S($D(^DIC(45.61,+$P(DGAUX,U,4),0)):$P(^(0),U,2),1:"    ")
 S Y=Y_$E($P(DGAUX,U,3)_" ")_$E($P(DGAUX,U,2)_" ")_$J($P(DGDRUG,U),4) ; Substance abuse col 79 (4) 
 S Y=Y_$E($P(DGAUX,U,5)_" ") ;physical axis class col 83 (1)
 S DGT=0,X=$P(DGAUX,U,6) I X]"" S DGT=1,Z=1,L=2 D ENTER0 ;physical axis assessment col 84 (4)
 I 'DGT S Y=Y_"  "
 S DGT=0,X=$P(DGAUX,U,7) I X]"" S DGT=1,Z=1,L=2 D ENTER0
 I 'DGT S Y=Y_"  "
 Q
RTEN(X) ; This function will round X to the nearest multiple of ten.
 ; 0-4 ->DOWN; 5-9->UP
 Q (X\10)*10+$S(X#10>4:10,1:0)
ETHNIC ;-- Ethnicity (use first active value)
 N NODE,NUM,ETHNIC,I,X
 S ETHNIC=""
 S I=0
 S NUM=1
 F  S I=+$O(DG06(I)) Q:'I  D  Q:NUM>1
 .S NODE=$G(DG06(I,0))
 .Q:('NODE)!('$D(^DIC(10.2,+NODE,0)))
 .Q:$$INACTIVE^DGUTL4(+NODE)
 .S X=$$PTR2CODE^DGUTL4(+NODE,2,4)
 .S ETHNIC=$S(X="":" ",1:X)
 .S X=$$PTR2CODE^DGUTL4(+$P(NODE,"^",2),3,4)
 .S ETHNIC=ETHNIC_$S(X="":" ",1:X)
 .S NUM=NUM+1
 S Y=Y_$S(ETHNIC="":"  ",1:ETHNIC)
 Q
RACE ;-- Race (use first 6 active values)
 N NODE,NUM,RACE,I,X
 S RACE=""
 S I=0
 S NUM=1
 F  S I=+$O(DG02(I)) Q:'I  D  Q:NUM>6
 .S NODE=$G(DG02(I,0))
 .Q:('NODE)!('$D(^DIC(10,+NODE,0)))
 .Q:$$INACTIVE^DGUTL4(+NODE)
 .S X=$$PTR2CODE^DGUTL4(+NODE,1,4)
 .S RACE=RACE_$S(X="":" ",1:X)
 .S X=$$PTR2CODE^DGUTL4(+$P(NODE,"^",2),3,4)
 .S RACE=RACE_$S(X="":" ",1:X)
 .S NUM=NUM+1
 S X="" S $P(X," ",12)=""
 S RACE=$S(RACE="":"  ",1:RACE)_X
 S Y=Y_$E(RACE,1,12)
 Q
