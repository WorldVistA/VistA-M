PSGMAR0 ;BIR/CML3-GATHERS INFO FOR 24 HOUR MAR ; 7/21/08 9:34am
 ;;5.0; INPATIENT MEDICATIONS ;**8,15,20,111,145,196**;16 DEC 97;Build 13
 ;
 ; Reference to ^PS(55 supported by DBIA #2191.
 ; Reference to ^PS(59.7 supported by DBIA #2181.
 ; Reference to CUR^FHORD7 supported by DBIA #2019.
ENQ ;
 S PSGMSORT=$P($G(^PS(59.7,1,26)),U,4)
 K ^TMP($J) D NOW^%DTC S PSGDT=%,PSGMARWN="",PSJACNWP=1 D @("G"_PSGSS) I $D(^TMP($J))<10 U IO W:$Y @IOF W !!,"(No data found for 24 hour MAR run.)"
 ;
 ;
DONE ;
 K PSGMFOR
 Q
 ;
GG ; find individual wards in this ward group
 F PSGMARWD=0:0 S PSGMARWD=$O(^PS(57.5,"AC",PSGMARWG,PSGMARWD)) Q:'PSGMARWD  D GW
 Q
 ;
GW ; find patients in each ward
 I $D(^DIC(42,PSGMARWD,0)),$P(^(0),"^")]"" S PSGMARWN=$P(^(0),"^")
 E  Q
 ;
 I 'PSGMARWG S PSGMARWG=+$O(^PS(57.5,"AB",PSGMARWD,0))
 F PSGP=0:0 S PSGP=$O(^DPT("CN",PSGMARWN,PSGP)) Q:'PSGP  D PSJAC2^PSJAC(1),DTSET:'$P(PSGMARDT,".",2) D GPI
 Q
 ;
GP ; go thru selected patients
 F PSGP=0:0 S PSGP=$O(PSGPAT(PSGP)) Q:'PSGP  D PSJAC2^PSJAC(1),DTSET:'$P(PSGMARDT,".",2) D GPI
 Q
 ;
GL S CL="" F  S CL=$O(^PS(57.8,"AD",CG,CL)) Q:CL=""  D GC
 Q
GC S PSGAPWDN=$S($D(^SC(CL,0)):$P(^(0),"^"),1:"")
 D DTSET:'$P(PSGMARDT,".",2)
 ;DEM 04/19/2006 - PSGCAD = User selected start date/time minus .0001
 S PSGCAD=PSGPLS-.0001
 F  S PSGCAD=$O(^PS(55,"AIVC",PSGCAD)) Q:PSGCAD=""  D  ;DEM 04/19/2006 - Index by order stop date/time.
 . S PSGP=0
 . F  S PSGP=$O(^PS(55,"AIVC",PSGCAD,CL,PSGP)) Q:PSGP=""  D PSJAC2^PSJAC(1),DTSET:'$P(PSGMARDT,".",2) D GPI  ;DEM 04/19/2006 - Removed S PSJPWDN="C!"_CL D GPI. Want to rollup patients non-clinic orders under patients location.
 ;DEM 04/19/2006 - PSGCAD = User selected start date/time minus .0001
 S PSGCAD=PSGPLS-.0001
 F  S PSGCAD=$O(^PS(55,"AUDC",PSGCAD)) Q:PSGCAD=""  D  ;DEM 04/19/2006 - Index by order stop date/time.
 . S PSGP=0
 . F  S PSGP=$O(^PS(55,"AUDC",PSGCAD,CL,PSGP)) Q:PSGP=""  D PSJAC2^PSJAC(1),DTSET:'$P(PSGMARDT,".",2) D GPI  ;DEM 04/19/2006 - Removed S PSJPWDN="C!"_CL D GPI. Want to rollup patients non-clinic orders under patients location.
 Q
GPI ; get patient info
 ; PSGTMALL=1(sort by all team), PSGTM=1(individual team(S) selected).
 S TM="" S:PSGSS="P"!(PSGSS="C")!(PSGSS="L") PSGMARWN=$S(PSJPWDN]"":PSJPWDN,1:"NOT FOUND")
 S:PSJPRB="" PSJPRB="zz"
 S:"GPCL"[PSGSS!('$G(PSGTM)&'$G(PSGTMALL)) TM="zz"
 S:$G(TM)="" TM=$S(PSJPRB="zz":0,1:+$O(^PS(57.7,"AWRT",PSGMARWD,PSJPRB,0))),TM=$S('TM:"zz",'$D(^PS(57.7,PSGMARWD,1,TM,0)):TM,$P(^(0),"^")]"":$P(^(0),"^"),1:TM)
 Q:'$G(PSGTMALL)&$G(PSGTM)&'$D(PSGTM(TM))
 S PPN=$E($P(PSGP(0),"^"),1,15)_"^"_PSGP
 N SUB1,SUB2 S:PSGRBPPN="P" SUB1=PPN,SUB2=PSJPRB S:PSGRBPPN="R" SUB1=PSJPRB,SUB2=PPN
 I PSGMARB=1 D SPN Q
 I PSGMTYPE[1 F XTYPE=2:1:6 D @XTYPE
 I PSGMTYPE'[1 F XTYPE=2:1:6 D:PSGMTYPE[XTYPE @XTYPE
 N PSGMAR24  ;DEM 04/19/2006 - 24 Hour MAR flag for call to shared routine ^PSGMMAR5 (24 Hour MAR Reports and 7 Day/14 Day MAR Reports both call ^PSGMMAR5).
 S PSGMAR24=1
 D ^PSGMMAR5
 K PSGMAR24
 D:$S(PSGSS["P"!(PSGSS="C")!(PSGSS="L"):$D(^TMP($J,PPN)),1:$D(^TMP($J,TM,PSGMARWN,SUB1,SUB2))) SPN
 Q
 ;
2 ;Loop thru UD orders
 ;DEM 04/19/2006
 ;       Location variable PSGMARWC added to correctly rollup orders
 ;       under location. The location can change if the UD order is
 ;       assoicated with a clinic location. If the location changes
 ;       under the aforementioned scenario, then PSGMARWC preserves
 ;       the original value and is used to restore location to it's
 ;       original value.
 ;
 N PSGMARWC
 S PSGMARWC=PSGMARWN    ;DEM 04/19/2006 - Preserve original value of patients location. If location is changed, then restore to original value after call to ORSET.
 F PST="C","O","OC","P","R" F PSGMARED=PSGPLS-.0001:0 S PSGMARED=$O(^PS(55,PSGP,5,"AU",PST,PSGMARED)) Q:'PSGMARED  F PSGMARO=0:0 S PSGMARO=$O(^PS(55,PSGP,5,"AU",PST,PSGMARED,PSGMARO)) Q:'PSGMARO  D ORSET S:PSGMARWN'=PSGMARWC PSGMARWN=PSGMARWC
 S PST="S" D ^PSGMIV
 Q
3 ;Loop thru IV orders that are Piggy back and Syringes types. 
 F PST="P","S" D ^PSGMIV
 Q
4 ;Loop thru IV orders(Additives).
 S PST="A" D ^PSGMIV
 Q
5 ;Loop thru IV orders(Hyperal).
 S PST="H" D ^PSGMIV
 Q
6 ;Loop thru IV order(Chemo).
 S PST="C" D ^PSGMIV
 Q
 ;
 ; PSGMFOR is set to bypass "fill on request" when call ^PSGPL0.
ORSET ; order record set
 S PSGMFOR="",ND2=$G(^PS(55,PSGP,5,PSGMARO,2)),(SD,X)=$P($P(ND2,"^",2),".") Q:X>PSGPLF  S FD=$P($P(ND2,"^",4),"."),T=$P(ND2,"^",6)
 ; 
 S A=$G(^PS(55,PSGP,5,PSGMARO,8)) I $P(A,"^")]"" S PSGMARWN="C!"_$P(A,"^") I $G(SUB1)]"",$G(SUB2)]"",'$D(^TMP($J,TM,PSGMARWN,SUB1,SUB2)) D SPN
 ;
 NEW MARX D DRGDISP^PSJLMUT1(PSGP,+PSGMARO_"U",20,0,.MARX,1)
 S DRG=MARX(1)_U_PSGMARO_"U",QST=$S(PST="C"!(PST="O"):PST,PST="OC":"OA",PST="P":"OP",$P(ND2,"^")["PRN":"OR",1:"CR")
 ;
 S X="" I "OB"]QST,$P(ND2,U)'["@",$P(ND2,U,2)'>PSGPLS,$P(ND2,U,4)'<PSGPLF,$P(ND2,U,5),$P(ND2,U,6)<1441,$P(ND2,U,6)'="D" S X=$P(ND2,U,5),PSGPLC=1
 E  I "OB"]QST S PSGPLO=PSGMARO K PSGMAR D ^PSGPL0 S (Q,X)="" F QX=0:0 S Q=$O(PSGMAR(Q)) Q:Q=""  S X=X_$E("0",2-$L(Q))_Q_"-"
 S X=$S(QST["C"!(QST["O"):$P(ND2,"^",5),1:"")_"^"_X
 ;
 ;DAM 5-01-07 Add next line to include non-IV meds when printing by PATIENT and choosing to print "ALL MEDS"
 I PSGSS="P" S ^TMP($J,PPN,PSGMARWN,$S(+PSGMSORT:$E(QST,1),1:QST),DRG)=X Q
 ;
 ;DAM 5-01-07  Add check to see if user wants to include ward orders when printing by CLINIC GROUP
 I PSGSS="L" Q:((PSGINWDG="")&(PSGMARWN'["C!"))  S ^TMP($J,PPN,PSGMARWN,$S(+PSGMSORT:$E(QST,1),1:QST),DRG)=X Q
 ;
 ;DAM 5-01-07 Add check to see if user wants to include ward orders when printing by CLINIC  
 I PSGSS="C" Q:((PSGINWD="")&(PSGMARWN'["C!"))  I ((PSGMARWN[PSGCLNC)!(PSGMARWN'["C!")) D  Q
 . S ^TMP($J,PPN,PSGMARWN,$S(+PSGMSORT:$E(QST,1),1:QST),DRG)=X
 Q:(PSGSS="L")!(PSGSS="C")
 ;
 ; DAM 5-01-07 Add check to see if user wants to include clinic orders when printing by WARD GROUP
 I PSGSS="G" Q:((PSGINCLG="")&(PSGMARWN["C!"))  S ^TMP($J,TM,PSGMARWN,SUB1,SUB2,$S(+PSGMSORT:$E(QST,1),1:QST),DRG)=X
 ;
 ;DAM 5-01-07 Add check to see if user wants to include clinic orders when printing by WARD. 
 I (PSGSS="W") Q:((PSGINCL="")&(PSGMARWN["C!"))  S ^TMP($J,TM,PSGMARWN,SUB1,SUB2,$S(+PSGMSORT:$E(QST,1),1:QST),DRG)=X
 ;
 ;DAM 5-01-07  Add an XTMP global to swap location and patient name in the subscripts when printing MAR by WARD/PATIENT or WARD GROUP.
 N PSGDEM S PSGDEM=X    ;transfer contents of patient drug information contained in "X" above to  a new variable temporarily
 S PSGREP="PSGM_"_$J
 S X1=DT,X2=1 D C^%DTC K %,%H,%T
 S ^XTMP(PSGREP,0)=X_U_DT
 I PSGRBPPN="P",PSGSS="W" Q:((PSGINCL="")&(PSGMARWN["C!"))  D        ;Construct XTMP global for printing by WARD
 . S ^XTMP(PSGREP,TM,SUB1,PSGMARWN,SUB2,$S(+PSGMSORT:$E(QST,1),1:QST),DRG)=PSGDEM
 I PSGRBPPN="P",PSGSS="G" Q:((PSGINCLG="")&(PSGMARWN["C!"))  D       ;Construct XTMP global for printing by WARD GROUP
 . S ^XTMP(PSGREP,TM,SUB1,PSGMARWN,SUB2,$S(+PSGMSORT:$E(QST,1),1:QST),DRG)=PSGDEM
 S X=PSGDEM    ;transfer contents of patient drug information contained in PSGDEM back to X
 ;End DAM modifications 5-01-07
 Q
 ;
SPN ; set patient node
 D DIET
 S X=$P(PSGP(0),U)_U_$E($P(PSJPDOB,U,2),1,10)_";"_PSJPAGE_U_VA("PID")_U_PSJPDX_U_PSJPWT_U_PSJPWTD_U_PSJPHT_U_PSJPHTD_U_$P(PSJPAD,U,2)_U_$P(PSJPTD,U,2)_U_$P(PSJPSEX,U,2)_U_PSJPWD_U_PSGPLS_U_PSGPLF_U_PSGMARSD_U_PSGMARFD_U_PSGMARSP_U_PSGMARFP
 ;GMZ:PSJ*5*196;Set diet info for each patient.
 I PSGSS="P"!(PSGSS="C")!(PSGSS="L") S ^TMP($J,PPN)=X_U_PSGMARWN_U_PSJPRB_U_$G(PSJDIET) Q
 ;
 ;DAM 5-01-07  Add check to see if user wants to include clinic orders when printing by ward. 
 I PSGSS="W" Q:((PSGINCL="")&(PSGMARWN["C!"))  S ^TMP($J,TM,PSGMARWN,SUB1,SUB2)=X_U_U_U_$G(PSJDIET)
 ;
 ;DAM 5-01-07 Add check to see if user wants to include clinic orders when printing by ward group.
 I PSGSS="G" Q:((PSGINCLG="")&(PSGMARWN["C!"))  S ^TMP($J,TM,PSGMARWN,SUB1,SUB2)=X_U_U_U_$G(PSJDIET)
 ;
 ;DAM 5-01-07  Add an XTMP global to reverse location and patient name in the subscripts when printing MAR by WARD/PATIENT or WARD GROUP.
 N PSGDEM S PSGDEM=X_U_U_U_$G(PSJDIET) ;transfer contents of patient demographics contained in "X" above to  a new variable temporarily
 S PSGREP="PSGM_"_$J
 S X1=DT,X2=1 D C^%DTC K %,%H,%T
 S ^XTMP(PSGREP,0)=X_U_DT
 I PSGRBPPN="P",PSGSS="W" Q:((PSGINCL="")&(PSGMARWN["C!"))  D    ;Construct XTMP global for printing by WARD
 . S ^XTMP(PSGREP,TM,SUB1,PSGMARWN,SUB2)=PSGDEM
 I PSGRBPPN="P",PSGSS="G" Q:((PSGINCLG="")&(PSGMARWN["C!"))  D   ;Construct XTMP global for printing by WARD GROUP
 . S ^XTMP(PSGREP,TM,SUB1,PSGMARWN,SUB2)=PSGDEM
 S X=PSGDEM    ;transfer contents of patient demographics contained in PSGDEM back to X
 ;End DAM modifications 3-7-07
 Q
DIET ; Include abbr. diet label if indicated in the Site par.
 NEW ADM,DFN,PSJMPAR K PSJDIET
 S PSJMPAR=$G(^PS(59.7,1,26))
 Q:'$P(PSJMPAR,U,3)
 S DFN=PSGP,ADM=$G(^DPT("CN",PSGMARWN,DFN))
 I +ADM D CUR^FHORD7 S PSJDIET=Y
 Q
 ;
DTSET ;
 S (PSGPLS,PSGPLF)=PSGMARDT
 S PSJSYSW=$O(^PS(59.6,"B",+$G(PSJPWD),0))
 S:PSJSYSW PSJSYSW0=$G(^PS(59.6,PSJSYSW,0))
 I $D(PSJSYSW0),$P(PSJSYSW0,"^",8) S ST=$P(PSJSYSW0,"^",8),FT=$P(PSJSYSW0,"^",9)
 E  S ST="0001",FT=24
SET S PSGMARSD=$E(ST,1,2),PSGMARFD=$E(FT,1,2) S:'PSGMARSD PSGMARSD="01" S PSGMARFD=$S(+PSGMARSD=1:24,PSGMARSD=PSGMARFD:PSGMARSD-1,1:PSGMARFD) S:$L(PSGMARFD)<2 PSGMARFD=0_PSGMARFD
 I ST>1 S X1=$P(PSGPLF,"."),X2=1 D C^%DTC S PSGPLF=X
 S PSGPLS=+(PSGPLS_"."_ST),PSGPLF=+(PSGPLF_"."_FT)
 S PSGMARSP=$$ENDTC2^PSGMI(PSGPLS),PSGMARFP=$$ENDTC2^PSGMI(PSGPLF)
 Q
