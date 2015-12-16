DGPTRI2 ;ALB/JDS/MJK/MTC/ADL/TJ/BOK,ISF/GJW,HIOFO/FT - PTF TRANSMISSION ;4/20/15 9:18am
 ;;5.3;Registration;**850,884**;Aug 13, 1993;Build 31
 ;;ADL;Update for CSV Project;;Mar 27,2003
 ;
 ; ^XMB(3.9) - #10113
 ; ICDXCODE APIs - #5699
 ; XLFSTR APIs - #10104
 ;
501 ; -- setup 501 transactions
 ; DG*636
 N DGPTMVDT,DGMPOA,DGEC,DGHNC,DGIR,DGM2,DGMST,DGPTMCNT,DGSC
 K DGCMVT I T2'=9999999 S DGCMVT=$O(^DGPT(J,"M","AM",+$P(T2,".")_".2359")),DGCMVT=$S('DGCMVT:1,$O(^(DGCMVT,0)):$O(^(0)),1:1)
 ;$P(DGM,U,10) - MOVEMENT DATE
 ;$P(DGM,U,18) - TREATED FOR SC CONDITION
 ;$P(DGM,U,26) - TREATED FOR AO CONDITION
 ;$P(DGM,U,27) - TREATED FOR IR CONDITION
 ;$P(DGM,U,28) - EXPOSED TO SW ASIA CONDITIONS
 ;$P(DGM,U,29) - TREATMENT FOR MST
 ;$P(DGM,U,30) - TREATED FOR HEAD/NECK CANCER
 F I=0:0 S I=$O(^DGPT(J,"M",I)) G 535:I'>0 I $D(^DGPT(J,"M",I,0)) S DGM=^DGPT(J,"M",I,0),DGM2=$G(^DGPT(J,"M",I,81)),DGMPOA=$G(^DGPT(J,"M",I,82)) D
 . S DGPTMCNT=$G(DGPTMCNT)+1,DGSC=$P(DGM,U,18),DGAO=$P(DGM,U,26),DGIR=$P(DGM,U,27)
 . S DGEC=$P(DGM,U,28),DGMST=$P(DGM,U,29),DGHNC=$P(DGM,U,30),DGTD=$P(DGM,U,10),DGPTMVDT=$P(DGM,U,10)
 . S:$D(DGCMVT) DGTD=$S(I=DGCMVT:$P(T2,".")_".2359",1:DGTD)
 . I $P(DGM,U,17)'="n",DGTD,DGTD'<T1,DGTD'>T2 D MOV
 Q
MOV ; build movement record
 S DGCDR=$P(DGM,U,16)
 S DGM=$P(DGM,U,1,9)_U_$P(DGM,U,11,15),L=1
 ;
 S Y=$S(T1:"C",1:"N")_"501"_DGHEAD,X=$P(DGTD,".")_"       ",Y=Y_$E(X,4,5)_$E(X,6,7)_$E(X,2,3)_$E($P(DGTD,".",2)_"0000",1,4)
 ;SPECIALTY CDR CODE - $E(Y,41,46)
 S Z=DGCDR D CDR
 ;replace specialty pointer (ien) with ptf code (alpha-numeric)
 N DGARRX,DGARRY ;DG729
 S DGARRX=$$TSDATA^DGACT(42.4,$P(DGM,U,2),.DGARRY)
 S $P(DGM,U,2)=$G(DGARRY(7))
 ;SPECIALTY CODE - $E(Y,47,48)
 S L=2,X=DGM,Z=2 D ENTER0
 ; convert pass, leave days >999 to 999
 ;3 is LEAVE DAYS - $E(Y,49,51)
 ;4 is PASS DAYS - $E(Y,52,54)
 S L=3 F Z=3,4 S:$P(X,U,Z)>999 $P(X,U,Z)=999 D ENTER0
 ;SPINAL CORD INJURY INDICATOR - $E(Y,55)
 S L=1,X=DG57,Z=4 D ENTER S:I=1 DG502=Y
 ;DIAGNOSTIC CODES and POAs 1 thru 25 - $E(Y,56,255)
 N EFFDATE,IMPDATE
 D EFFDATE^DGPTIC10(J)
 N DG501DX,DG501POA,DGLOOP,DGSTRING,DG501CODES,DGPTTMP
 D PTFICD^DGPTFUT(501,J,I,.DG501CODES) ;get 501 values
 S DGLOOP=0,DGSTRING=""
 F  S DGLOOP=$O(DG501CODES(DGLOOP)) Q:DGLOOP=""  D
 .S DGPTTMP=$$ICDDATA^ICDXCODE("DIAG",$P(DG501CODES(DGLOOP),U,1),EFFDATE,"I") ;get dx code info
 .I +DGPTTMP>0&($P(DGPTTMP,U,10)) D  ;check ien and status
 ..S DG501DX=$P(DG501CODES(DGLOOP),U,3) ;external value
 ..S DG501DX=$$FMTICD^DGPTRNU(DG501DX) ;remove decimal point
 ..S DG501DX=$$LJ^XLFSTR(DG501DX,7," ") ;left justify & add spaces to the right to reach 7 characters
 ..S DG501POA=$P(DG501CODES(DGLOOP),U,2) ;get poa code
 ..S DG501POA=$S(DG501POA'="":DG501POA,1:" ") ;use space, if no POA code
 ..S DGSTRING=DGSTRING_DG501DX_DG501POA ;build string of dx and poa values
 S $E(Y,56,255)=DGSTRING_$$REPEAT^XLFSTR(" ",200-$L(DGSTRING))
  ;attending physician ssn - $E(Y,256,264)
 S X=$$GET1^DIQ(45,J_",",79.2),$E(Y,256,264)=$E(X_"         ",1,9)
 S X=""
 I 'T1 S Z=$S(I=1:+$O(^DGPT(J,535,"ADC",0)),1:+$O(^DGPT(J,535,"AM",DGTD-.0000001))) I $D(^DGPT(J,535,+$O(^(Z,0)),0)) S X=^(0)
 I T1 S Z=+$O(^DGPT(J,535,"AM",DGTD-.0000001)) S:'Z Z=+$O(^DGPT(J,535,"ADC",0)) I $D(^DGPT(J,535,+$O(^(Z,0)),0)) S X=^(0)
 ;PHYSICAL LOCATION CDR CODE - $E(Y,265,270)
 S Z=$P(X,U,16) D CDR
 ;replace specialty pointer (ien) with ptf code (alpha-numeric)
 N DGARRX,DGARRY ;DG729
 S DGARRX=$$TSDATA^DGACT(42.4,$P(X,U,2),.DGARRY)
 S $P(X,U,2)=$G(DGARRY(7))
 ;PHYSICAL LOCATION CODE - $E(Y,271,272)
 S L=2,Z=2 D ENTER0
 ;BED STATUS (DISCHARGE MOVEMENT ONLY) - $E(Y,273)
 I T1 S Y=Y_$S(I=1:$E($P(DG70,U,14)_" "),$P(+DGTD,".")=$P(T2,"."):5,1:1)
 I 'T1 S Y=Y_$S(I=1:$E($P(DG70,U,14)_" "),1:" ")
 ;[NOT ACTIVATED] - $E(Y,274,284)
 ;[RESERVED] - $E(Y,285,301)
 ;[NOT IN USE] - $E(Y,302,384)
 D SAVE
 Q
535 ; -- do 535's
 D 535^DGPTRI3
 ;
PROC ; -- setup 601 transactions
 K ^UTILITY($J,"PROC") S I=0
601 S I=$O(^DGPT(J,"P",I)) G 701:I'>0 S (X,DGPROC)=^(I,0) G 601:'DGPROC
 G 601:DGPROC<T1!(DGPROC>T2) S DGPROCD=+^DGPT(J,"P",I,0),^UTILITY($J,"PROC",DGPROCD)=$S($D(^UTILITY($J,"PROC",DGPROCD)):^(DGPROCD),1:0)+1
 I ^UTILITY($J,"PROC",DGPROCD)>1 W !,"More than one procedure record on same date/time" S DGERR=1 Q
 S Y=$S('T1:"N",1:"C")_"601"_DGHEAD_$E(DGPROCD,4,7)_$E(DGPROCD,2,3)_$E($P(+X,".",2)_"0000",1,4)
 ;replace specialty pointer (ien) with ptf code (alpha-numeric)
 N DGARRX,DGARRY ;DG729
 S DGARRX=$$TSDATA^DGACT(42.4,$P(X,U,2),.DGARRY)
 S $P(X,U,2)=$G(DGARRY(7))
 ;SPECIALTY - $E(Y,41,42)
 S L=2,Z=2 D ENTER0
 ;DIALYSIS TYPE - $E(Y,43)
 S L=1,Z=3 S $P(X,U,Z)="" D ENTER ;null dialysis type. DG729
 ;NUMBER OF DIALYSIS TREATMENTS - $E(Y44,46)
 S L=3,Z=4 D ENTER0
 N EFFDATE,IMPDATE,DGPTDAT D EFFDATE^DGPTIC10(J)
 ;procedure codes 1 thru 25 - $E(Y,47,246)
 N DG601CODES,DGLOOP,DGPCODE,DGPROCNODE,DGSTRING,DGPTTMP
 D PTFICD^DGPTFUT(601,J,I,.DG601CODES) ;get 601 values
 S DGLOOP=0,DGSTRING=""
 F  S DGLOOP=$O(DG601CODES(DGLOOP)) Q:DGLOOP=""  D  ;returns codes used, no null fields
 .S DGPCODE=$P(DG601CODES(DGLOOP),U,3) ;external value
 .S DGPTTMP=$$ICDDATA^ICDXCODE("PROC",$P(DG601CODES(DGLOOP),U,1),EFFDATE,"I") ;check data
 .Q:+DGPTTMP'>0  ;don't use if bad
 .S DGSTRING=DGSTRING_DGPCODE_" "
 S $E(Y,47,246)=DGSTRING_$$REPEAT^XLFSTR(" ",200-$L(DGSTRING))
 ;[NOT ACTIVATED] - $E(Y,247,255)
 ;[RESERVED] - $E(Y,256,290)
 ;[NOT ALLOCATED] - $E(Y,291,384)
 D SAVE G 601
 Q
 ;
701 ; -- setup 701 transaction
 D 701^DGPTRI4 Q
 ;
ENTER S Y=Y_$J($P(X,U,Z),L)
 Q
 ;
ENTER0 S Y=Y_$S($P(X,U,Z)]"":$E("00000",$L($P(X,U,Z))+1,L)_$P(X,U,Z),1:$J($P(X,U,Z),L))
 Q
 ;
SAVE ;save segment to MailMan message and ^TMP("AEDIT",$J), if data is valid
 N DGY1,DGY2
 S (DGY1,DGY2)=""
 D START^DGPTRI1 ;validate data in segment
 I DGERR'>0 S DGACNT=DGACNT+1,^TMP("AEDIT",$J,$E(Y,1,4),DGACNT)=Y ;^TMP("AEDIT",$J) used by DGPTAE* for more data validation
 ;AITC wants segment length of 384 characters.
 ;Break the segment at 240, if it does not affect a data field. Otherwise break line before data field.
 I 'DGERR D
 .D FILL
 .I $E(Y,2,4)=101 S DGY1=$E(Y,1,240),DGY2=$E(Y,241,384)
 .I $E(Y,2,4)=401 S DGY1=$E(Y,1,238),DGY2=$E(Y,239,384)
 .I $E(Y,2,4)=501 S DGY1=$E(Y,1,239),DGY2=$E(Y,240,384)
 .I $E(Y,2,4)=535 S DGY1=$E(Y,1,240),DGY2=$E(Y,241,384)
 .I $E(Y,2,4)=601 S DGY1=$E(Y,1,238),DGY2=$E(Y,239,384)
 .I $E(Y,2,4)=701 S DGY1=$E(Y,1,240),DGY2=$E(Y,241,384)
 .I $E(Y,2,4)=702 S DGY1=$E(Y,1,240),DGY2=$E(Y,241,384)
 .Q:DGY1=""!(DGY2="")
 .S ^XMB(3.9,DGXMZ,2,DGCNT,0)=DGY1,DGCNT=DGCNT+1
 .S ^XMB(3.9,DGXMZ,2,DGCNT,0)=DGY2,DGCNT=DGCNT+1
Q Q
 ;
FILL ;fill out segment with spaces
 F K=$L(Y):1 Q:$L(Y)>383  S Y=Y_" "
 S $E(Y,383)=1 ;383rd character=1 to indicate ICD10 record. DGPTR2 sets 383rd character=9 to indicate ICD9 record.
 Q
 ;
CDR S Y=Y_$E($P(Z,".")_"0000",1,4)_$E($P(Z,".",2)_"00",1,2)
 Q
