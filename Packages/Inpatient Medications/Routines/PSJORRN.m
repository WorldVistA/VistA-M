PSJORRN ;BIR/MV - RETURN INPATIENT ACTIVE MEDS (CONDENSED) NEW SORT ;Jun 17, 2020@13:03:40
 ;;5.0;INPATIENT MEDICATIONS;**134,213,225,275,255,399**;16 DEC 97;Build 64
 ;
 ;Reference to ^PS(52.6 is supported by DBIA 1231.
 ;Reference to ^PS(52.7 is supported by DBIA 2173.
 ;Reference to ^PS(55 is supported by DBIA 2191.
 ;Reference to ^PS(50.7 is supported by DBIA #2180.
 ;Reference to ^TMP("PS" is documented in DBIA #2383.
 ;
OCL(DFN,BDT,EDT,TFN) ; return condensed list of inpat meds
 ; MVIEW=2   -  This is the new sort with GUI 27
 ; Execute this section if MVIEW=2
 N ADM,CNT,DN,DO,F,FON,INFUS,INST,MR,ND,ND0,ND2,ND6,ON,PON,PST,SCH,SIO,STAT,TYPE,UNITS,WBDT,X,Y,PSJCLIN,A,TFN2,%
 S TFN2=0
 ; PON=placer order number (oerr), FON=filler order number
 ; *225 Add time or base on now
 D NOW^%DTC S:BDT="" BDT=% S:BDT'["." BDT=BDT_".000001"
 S:EDT="" EDT=9999999
 S:EDT'["." EDT=EDT_".999999"
 ;*225 Correct Display Calcualtion
 S F="^PS(55,DFN,5,",WBDT=BDT F  S WBDT=$O(^PS(55,DFN,5,"AUS",WBDT)) Q:'WBDT  F ON=0:0 S ON=$O(^PS(55,DFN,5,"AUS",WBDT,ON)) Q:'ON  D UDTMP
 S F="^PS(53.1," F PST="P","N" S ON=0 F  S ON=$O(^PS(53.1,"AS",PST,DFN,ON)) Q:'ON  S X=$P($G(^PS(53.1,+ON,0)),U,4) D @$S(X="U":"UDTMP",1:"IVTMP")
 S F="^PS(55,"_DFN_",""IV"",",WBDT=BDT F  S WBDT=$O(^PS(55,DFN,"IV","AIS",WBDT)) Q:'WBDT  S ON=0 F  S ON=$O(^PS(55,DFN,"IV","AIS",WBDT,ON)) Q:'ON  D IVTMP
 S X1="" F  S X1=$O(^TMP("PSJTMP",$J,X1)) Q:X1=""  S X2="" F  S X2=$O(^TMP("PSJTMP",$J,X1,X2)) Q:X2=""  D
 .S X3="" F  S X3=$O(^TMP("PSJTMP",$J,X1,X2,X3)) Q:X3=""  S X4="" F  S X4=$O(^TMP("PSJTMP",$J,X1,X2,X3,X4)) Q:X4=""  D
 ..S X5="" F  S X5=$O(^TMP("PSJTMP",$J,X1,X2,X3,X4,X5)) Q:X5=""  S TFN=$G(TFN)+1 D
 ...; The merge below sends the proper ^TMP("PS",$J structure back to the calling
 ...; routine PSJORRE
 ...M ^TMP("PS",$J,TFN)=^TMP("PSJTMP",$J,X1,X2,X3,X4,X5) S ^TMP("PS",$J,"PC",0)=TFN
 K ^TMP("PSJTMP",$J)
 Q
 ;
UDTMP ;*** Set ^TMP for Unit dose orders.
 N PROVIDER,ND8,RNWDT,EDTCMPLX,NDP2,PSJOINM,PSJOI,PSJDDNM,LOC,PRIO,NDDSS
 S (MR,SCH,INST,PON,NDDSS)="",FON=+ON_$S(F["53.1":"P",1:"U")
 D TYPE
 S RNWDT=$$LASTREN^PSJLMPRI(DFN,FON) I RNWDT S RNWDT=+RNWDT
 S NDP2=$G(@(F_ON_",.2)")) S EDTCMPLX=$P(NDP2,"^",8),PRIO=$P(NDP2,"^",4)
 S ND2=$G(@(F_ON_",2)")) I 'EDTCMPLX I F'["53.1",($P(ND2,U,2)>EDT) Q
 S ND0=$G(@(F_ON_",0)")) I 'EDTCMPLX I F["53.1",($P(ND0,U,16)>EDT) Q
 S ND8=$G(@(F_ON_",8)")),NDP2=$P($G(@(F_ON_",.2)")),"^")
 S STAT=$$CODES^PSIVUTL($P(ND0,U,9),$S(FON["P":53.1,1:55.06),28)
 S ND6=$P($G(@(F_ON_",6)")),"^"),INST=$G(@(F_+ON_",.3)"))
 S:ND6["Instructions too long. See Order View or BCMA for full text" ND6="Instructions too long. See order details for full text."
 S FON=+ON_$S(F["53.1":"P",1:"U"),DO=$P($G(@(F_ON_",.2)")),"^",2)
 D DRGDISP^PSJLMUT1(DFN,FON,40,0,.DN,1)
 ;*225 Don't allow 0 Units
 S UNITS="" I '$O(@(F_+ON_",1,1)")) S UNITS=$P($G(@(F_+ON_",1,1,0)")),U,2) S:(FON["U")&(+UNITS=0) UNITS=1
 S:+$P(ND0,U,3) MR=$$MR^PSJORRE1(+$P(ND0,U,3))
 N NOTGIVEN S NOTGIVEN=$S(FON["U":$P($G(^PS(55,DFN,5,+ON,0)),"^",22),1:"")
 ;******** GUI 27 new sort for Meds Tab
 I F[53.1 S NDDSS=$G(@(F_ON_",""DSS"")")),LOC=$P(NDDSS,"^")
 S:F'[53.1 LOC=$P(ND8,"^") S LOC=$S($P($G(NDDSS),"^",2):LOC,1:"~") I LOC S LOC=$P($G(^SC(LOC,0)),"^")
 S PSJST=$P(ND0,"^",9)
 S GP=$S((",A,R,H,RE,")[(","_PSJST_","):1,(",P,N,")[(","_PSJST_","):2,PSJST="E":3,(",D,DE,DR,")[(","_PSJST_","):4,1:0)
 S PSJST2=$S(PSJST="A":1,PSJST="R":2,PSJST="H":3,PSJST="S":4,PSJST="P":5,PSJST="O":6,PSJST="N":7,PSJST="I":8,PSJST="P":9,GP=4&($G(PRIO)="D"):10,PSJST="E":11,PSJST="D":12,PSJST="DE":13,PSJST="RE":14,PSJST="R":15,1:0)
 S PSJOI=$P(NDP2,"^"),PSJOINM=$P($G(^PS(50.7,+PSJOI,0)),"^")
 ;*******
 S TFN2=$G(TFN2)+1
 S CNT=0,PSJOINM=$$UP^XLFSTR($S(PSJOINM]"":PSJOINM,1:"UNKNOWN"))
 S ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,0)=FON_";I"_U_DN(1)_"^^"_$P(ND2,U,4)_"^^"_DO_U_UNITS_U_$P(ND0,U,21)_U_STAT_U_U_U_U_NOTGIVEN_U_($P(ND0,U,9)="P"&($P(ND0,U,24)="R"))_U_$P(ND2,U,2)_U_$G(RNWDT)
 K ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"CLINIC",0) I PSJCLIN]"" S ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"CLINIC",0)=PSJCLIN
 S PROVIDER=$P($G(@(F_+ON_",0)")),"^",2)
 I PROVIDER S ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"P",0)=PROVIDER_"^"_$P($G(^VA(200,PROVIDER,0)),"^")
 S ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"MDR",0)=MR]"" S:MR]"" ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"MDR",1,0)=MR
 S ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"SCH",0)=$P(ND2,U)]"" S:$P(ND2,U)]"" ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"SCH",1,0)=$P(ND2,U)
 S ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"SIG",0)=INST]"" S:INST]"" ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"SIG",1,0)=INST
 S ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"ADM",0)=$P(ND2,U,5)]"" S:$P(ND2,U,5)]"" ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"ADM",1,0)=$P(ND2,U,5)
 S ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"SIO",0)=ND6]"" S:ND6]"" ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"SIO",1,0)=ND6
 S:$P($G(@(F_ON_",18)")),U)]"" ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"IND",0)=$P($G(@(F_ON_",18)")),U)  ;*399-IND
 Q
 ;
IVTMP ;*** Set ^TMP for IV orders.
 N PROVIDER,START,STOP,EDTCMPLX,NDP2,IVLIM,PRIO,LOC,NDDSS
 S (PROVIDER,START,STOP,EDTCMPLX,NDP2,IVLIM,PRIO,LOC,NDDSS)=""
 S NDP2=$G(@(F_ON_",.2)")) S EDTCMPLX=$P(NDP2,"^",8),PRIO=$P(NDP2,"^",4)
 S ND0=$G(@(F_ON_",0)")) I 'EDTCMPLX I F'["53.1",($P(ND0,U,2)>EDT) Q
 D TYPE
 S FON=+ON_$S(F["53.1":"P",1:"V"),TFN2=TFN2+1,CNT=0
 S RNWDT=$$LASTREN^PSJLMPRI(DFN,FON) I RNWDT S RNWDT=+RNWDT
 ;******** GUI 27 new sort for Meds Tab
 S NDDSS=$G(@(F_ON_",""DSS"")")),NDP2=$G(@(F_ON_",.2)"))
 S PSJOI=$P(NDP2,"^")
 I F[53.1 S PSJST=$P(ND0,"^",9)
 I F'[53.1 S PSJST=$P(ND0,"^",17)
 S GP=$S((",A,R,H,RE,")[(","_PSJST_","):1,(",P,N,")[(","_PSJST_","):2,PSJST="E":3,(",D,DE,DR,")[(","_PSJST_","):4,1:0)
 S PSJST2=$S(PSJST="A":1,PSJST="R":2,PSJST="H":3,PSJST="S":4,PSJST="P":5,PSJST="O":6,PSJST="N":7,PSJST="I":8,PSJST="P":9,GP=4&($G(PRIO)="D"):10,PSJST="E":11,PSJST="D":12,PSJST="DE":13,PSJST="RE":14,PSJST="R":15,1:0)
 S LOC=$P(NDDSS,"^") S LOC=$S($P(NDDSS,"^",2):LOC,1:"~") I LOC S LOC=$P($G(^SC(LOC,0)),"^")
 I PSJOI'="" S PSJOINM=$P($G(^PS(50.7,+PSJOI,0)),"^")
 I PSJOI="" S PSJOINM="Orderable Item Not Found"
 ;********
 S CNT=0,PSJOINM=$S(PSJOINM]"":PSJOINM,1:"UNKNOWN")
 F X=0:0 S X=$O(@(F_ON_",""AD"","_X_")")) Q:'X  S ND=$G(@(F_ON_",""AD"","_X_",0)")),DN=$P($G(^PS(52.6,+ND,0)),U),Y=DN_U_$P(ND,U,2) S:$P(ND,U,3) Y=Y_U_$P(ND,U,3) S CNT=CNT+1,^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"A",CNT,0)=Y
 S ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"A",0)=CNT,CNT=0
 F X=0:0 S X=$O(@(F_ON_",""SOL"","_X_")")) Q:'X  S ND=$G(@(F_ON_",""SOL"","_X_",0)")),DN=$G(^PS(52.7,+ND,0)),CNT=CNT+1,^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"B",CNT,0)=$P(DN,U)_U_$P(ND,U,2)_U_$P(DN,U,4)
 S ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"B",0)=CNT
 S TYPE=$P(ND0,U,4),(MR,SCH,INST,INFUS)=""
 I FON["P" S ND2=$G(^PS(53.1,+ON,2)),SCH=$P(ND2,U),START=$P(ND2,U,2),STOP=$P(ND2,U,4),MR=$P(ND0,U,3),INFUS=$P($G(^PS(53.1,+ON,8)),U,5),STAT=$$CODES^PSIVUTL($P(ND0,U,9),53.1,28),ADM=$P(ND2,U,5),SIO=$P($G(@(F_+ON_",6)")),"^")
 I FON'["P" S START=$P(ND0,U,2),STOP=$P(ND0,U,3),SCH=$P(ND0,U,9),INFUS=$P(ND0,U,8),MR=$P($G(^PS(55,DFN,"IV",+ON,.2)),U,3),STAT=$$CODES^PSIVUTL($P(ND0,U,17),55.01,100),ADM=$P(ND0,U,11),SIO=$P($G(@(F_+ON_",3)")),"^")
 S:($G(SIO)["Instructions too long. See Order View or BCMA for full text") SIO="Instructions too long. See order details for full text."
 S DN=$G(@(F_+ON_",.2)")),DO=$P(DN,U,2)
 S DN=$S(+$P(DN,U):$$OIDF^PSJLMUT1($P(DN,U)),1:"")
 S:MR MR=$$MR^PSJORRE1(+MR),INST=$G(@(F_+ON_",.3)"))
 S ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,0)=FON_";I"_U_DN_U_INFUS_U_STOP_"^^"_DO_"^^"_$P(ND0,"^",21)_U_STAT_U_U_U_U_U_($P(ND0,U,9)="P"&($P(ND0,U,24)="R"))_U_START_U_$G(RNWDT)
 K ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"CLINIC",0) I PSJCLIN]"" S ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"CLINIC",0)=PSJCLIN
 S PROVIDER=$P($G(@(F_+ON_",0)")),"^",6)
 I PROVIDER S ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"P",0)=PROVIDER_"^"_$P($G(^VA(200,PROVIDER,0)),"^")
 S ND2P5=$G(@(F_+ON_",2.5)")) S IVLIM=$P(ND2P5,U,4) I $E(IVLIM)="a" S IVLIM="doses"_$P(IVLIM,"a",2)
 I IVLIM="" S IVLIM=$P(ND2P5,U,2) S:(IVLIM'["d")&(IVLIM'["h") IVLIM=""
 S ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"MDR",0)=MR]"" S:MR]"" ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"MDR",1,0)=MR
 S ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"SIG",0)=INST]"" S:INST]"" ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"SIG",1,0)=INST
 S ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"SCH",0)=SCH]"" S:SCH]"" ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"SCH",1,0)=SCH
 S ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"ADM",0)=ADM]"" S:ADM]"" ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"ADM",1,0)=ADM
 S ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"SIO",0)=SIO]"" S:SIO]"" ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"SIO",1,0)=SIO
 I $G(IVLIM)]"" S ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"IVLIM",0)=IVLIM
 S:$P($G(@(F_ON_",18)")),U)]"" ^TMP("PSJTMP",$J,GP,PSJST,LOC,PSJOINM,TFN2,"IND",0)=$P($G(@(F_ON_",18)")),U)  ;*399-IND
 Q
STAT(Y,X) ;* Return the full status instead of just the code for U/D.
 S X=$P($P(";"_$P(Y,U,3),";"_X_":",2),";")
 Q X
TYPE ;determine if this is an IMO order or not
 S (A,PSJCLIN)="" I F["PS(53.1" S A=$G(^PS(53.1,ON,"DSS"))
 I F["PS(55" S A=$S(F["IV":$G(^PS(55,DFN,"IV",ON,"DSS")),1:$G(^PS(55,DFN,5,ON,8)))
 I $P(A,"^",2)'="" S PSJCLIN=+A
 Q
