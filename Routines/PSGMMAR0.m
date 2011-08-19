PSGMMAR0 ;BIR/CML3-GATHERS INFO FOR MD CMR ; 8/14/08 12:08pm
 ;;5.0; INPATIENT MEDICATIONS ;**8,15,20,111,145,196**;16 DEC 97;Build 13
 ;
 ; Reference to ^PS(55 supported by DBIA #2191.
 ; Reference to ^PS(59.7 supported by DBIA #2181.
 ;
ENQ ; start sort; where queue comes in at
 N SUB1,SUB2 S (SUB1,SUB2)=""
 S PSGMSORT=$P($G(^PS(59.7,1,26)),U,4)
 K PSGD S X=$P(PSGMARSD,"."),PSGDW="" F Q=0:1:PSGMARDF-1 S X1=$P(PSGMARSD,"."),X2=Q D:Q C^%DTC S PSGD(X)=$E(X,4,5)_"/"_$E(X,6,7),HX=X D DW^%DTC S $P(PSGD(HX),U,2)=X
 K ^TMP($J) D NOW^%DTC S PSGDT=%,PSGMARWN="",PSJACNWP=1 D @("G"_PSGSS)
 ;* K ^TMP($J),PSJACNWP D NOW^%DTC S PSGDT=%,PSGMARWN="" D @("G"_PSGSS)
 I $D(^TMP($J))<10 U IO W:$Y @IOF W !!,"(No data found for "_PSGMARDF_" day MAR run.)"
 ;
DONE ;
 Q
 ;
GG ; find individual wards in this ward group
 S ^TMP($J)=PSGMARWG F PSGMARWD=0:0 S PSGMARWD=$O(^PS(57.5,"AC",PSGMARWG,PSGMARWD)) Q:'PSGMARWD  D GW
 Q
 ;
GW ; find patients in each ward
 I $D(^DIC(42,PSGMARWD,0)),$P(^(0),U)]"" S PSGMARWN=$P(^(0),U)
 E  Q
 I 'PSGMARWG S PSGMARWG=+$O(^PS(57.5,"AB",PSGMARWD,0))
 I $D(^TMP($J))[0,PSGMARWG S ^($J)=PSGMARWG
 F PSGP=0:0 S PSGP=$O(^DPT("CN",PSGMARWN,PSGP)) Q:'PSGP  D PSJAC2^PSJAC(1) I PSGMARB!$O(^PS(55,PSGP,5,"AUS",PSGMARSD))!$O(^PS(55,PSGP,"IV","AIS",PSGMARSD)) D GPI
 Q
 ;
GP ; go thru selected patients
 F PSGP=0:0 S PSGP=$O(PSGPAT(PSGP)) Q:'PSGP  D PSJAC2^PSJAC(1) I PSGMARB!$O(^PS(55,PSGP,5,"AUS",PSGMARSD))!$O(^PS(55,PSGP,"IV","AIS",PSGMARSD)) D GPI
 Q
 ;
GL S CL="" F  S CL=$O(^PS(57.8,"AD",CG,CL)) Q:CL=""  D GC
 Q
GC S PSGAPWDN=$S($D(^SC(CL,0)):$P(^(0),"^"),1:"")
 S PSGP="" F  S PSGP=$O(^PS(53.1,"AD",CL,PSGP)) Q:PSGP=""  D PSJAC2^PSJAC(1)
 S PSGCAD=PSGMARSD
 F  S PSGCAD=$O(^PS(55,"AIVC",PSGCAD)) Q:PSGCAD=""  D
 . S PSGP=0
 . F  S PSGP=$O(^PS(55,"AIVC",PSGCAD,CL,PSGP)) Q:PSGP=""  D PSJAC2^PSJAC(1) D GPI
 S PSGCAD=PSGMARSD
 F  S PSGCAD=$O(^PS(55,"AUDC",PSGCAD)) Q:PSGCAD=""  D
 . S PSGP=0
 . F  S PSGP=$O(^PS(55,"AUDC",PSGCAD,CL,PSGP)) Q:PSGP=""  D PSJAC2^PSJAC(1) D GPI
 Q
 ;
GPI ; get patient info
 ; PSGTMALL=1(sort by all team), PSGTM=1(individual team(S) selected).
 S TM="" S:PSGSS="P"!(PSGSS="C")!(PSGSS="L") PSGMARWN=$S(PSJPWDN]"":PSJPWDN,1:"NOT FOUND")
 S:PSJPRB="" PSJPRB="zz"
 S:"GPCL"[PSGSS!('$G(PSGTM)&'$G(PSGTMALL)) TM="zz"
 S:$G(TM)="" TM=$S(PSJPRB="zz":0,1:+$O(^PS(57.7,"AWRT",PSGMARWD,PSJPRB,0))),TM=$S('TM:"zz",'$D(^PS(57.7,PSGMARWD,1,TM,0)):TM,$P(^(0),U)]"":$P(^(0),U),1:TM)
 Q:'$G(PSGTMALL)&$G(PSGTM)&'$D(PSGTM(TM))  ; Elimin. none selected team
 S PPN=$E($P(PSGP(0),U),1,15)_U_PSGP
 S:PSGRBPPN="P" SUB1=PPN,SUB2=PSJPRB S:PSGRBPPN="R" SUB1=PSJPRB,SUB2=PPN
 I PSGMARB=1 D SPN Q
 I PSGMTYPE[1 F XTYPE=2:1:6 D @XTYPE
 I PSGMTYPE'[1 F XTYPE=2:1:6 D:PSGMTYPE[XTYPE @XTYPE
 D ^PSGMMAR5
 D:$S(PSGSS["P"!(PSGSS="L")!(PSGSS="C"):$D(^TMP($J,PPN)),1:$D(^TMP($J,TM,PSGMARWN,SUB1,SUB2))) SPN
 I $D(^TMP($J))'>10,(PSGMARB=3) D SPN
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
 S PSGMARWC=PSGMARWN  ;DEM 04/19/2006 - Preserve original value of patients location. If location is changed, then restore to original value after call to OS.
 I PSGMARS'=2 F PST="C" F PSGMARED=PSGMARSD:0 S PSGMARED=$O(^PS(55,PSGP,5,"AU",PST,PSGMARED)) Q:'PSGMARED  F ON=0:0 S ON=$O(^PS(55,PSGP,5,"AU",PST,PSGMARED,ON)) Q:'ON  D OS S:PSGMARWN'=PSGMARWC PSGMARWN=PSGMARWC
 I PSGMARS'=1 F PST="O","OC","P" F PSGMARED=PSGMARSD:0 S PSGMARED=$O(^PS(55,PSGP,5,"AU",PST,PSGMARED)) Q:'PSGMARED  F ON=0:0 S ON=$O(^PS(55,PSGP,5,"AU",PST,PSGMARED,ON)) Q:'ON  D OS S:PSGMARWN'=PSGMARWC PSGMARWN=PSGMARWC
 S PST="R" F PSGMARED=PSGMARSD:0 S PSGMARED=$O(^PS(55,PSGP,5,"AU",PST,PSGMARED)) Q:'PSGMARED  F ON=0:0 S ON=$O(^PS(55,PSGP,5,"AU",PST,PSGMARED,ON)) Q:'ON  D OS S:PSGMARWN'=PSGMARWC PSGMARWN=PSGMARWC
 S PST="S" D ^PSGMMIV
 Q
3 ;Loop thru IV orders that are Piggy back and Syringes types.
 F PST="P","S" D ^PSGMMIV
 Q
4 ;Loop thru IV orders(Admixtures).
 S PST="A" D ^PSGMMIV
 Q
5 ;Loop thru IV orders(Hyperal).
 S PST="H" D ^PSGMMIV
 Q
6 ;Loop thru IV order(Chemo).
 S PST="C" D ^PSGMMIV
 Q
 ;
OS ; order record set
 N A
 S ND2=$G(^PS(55,PSGP,5,ON,2)),SD=$P(ND2,U,2) I $S($P(SD,".")>PSGMARFD:1,PSGMARS=1:$P(ND2,U)["PRN",1:0) Q
 S A=$G(^PS(55,PSGP,5,ON,8)) I $P(A,"^",1)]"" S PSGMARWN="C!"_$P(A,"^") I $G(SUB1)]"",$G(SUB2)]"",'$D(^TMP($J,TM,PSGMARWN,SUB1,SUB2)) D SPN
 S FD=$P($P(ND2,U,4),"."),T=$P(ND2,U,6)
 NEW MARX D DRGDISP^PSJLMUT1(PSGP,+ON_"U",20,0,.MARX,1) S DRG=MARX(1)_$E(SD,2,7)_U_+ON_"U"
 S QST=$S(PST="C"!(PST="O"):PST,PST="OC":"OA",PST="P":"OP",$P(ND2,U)["PRN":"OR",1:"CR")
 S QQ="" I QST["C" D DTS($P(ND2,U)) S SD=$P(SD,"."),QQ="" F X=0:0 S X=$O(PSGD(X)) Q:'X  S QQ=QQ_$S(X<SD:"",X>FD:"",'S:$P(PSGD(X),U),$D(S(X)):$P(PSGD(X),U),1:"")
 I $P(ND2,U,6)="D",$P(ND2,U,5)="" S $P(ND2,U,5)=$E($P($P(ND2,U,2),".",2)_"0000",1,4)
 S X=$S(QST["C"!(QST="O"):$P(ND2,U,5),1:"")_U_QQ
 ;
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
 ;
 Q:(PSGSS="L")!(PSGSS="C")
 ;
 ;DAM 5-01-07 Add check to see if user wants to include clinic orders when printing by WARD GROUP
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
 S X=PSGDEM      ;transfer contents of patient drug information contained in PSGDEM back to X
 ;End DAM modifications 5-01-07
 Q
 ;
DTS(SCHEDULE) ;
 K S S S=0 I SCHEDULE["@"!(T="D") S WD=$S(SCHEDULE["@":$P(SCHEDULE,"@"),1:SCHEDULE) F Q=0:0 S Q=$O(PSGD(Q)) Q:'Q  F QQ=1:1:$L(WD,"-") I $P($P(PSGD(Q),U,2),$P(WD,"-",QQ))="" S S(Q)="",S=S+1 Q
 Q:SCHEDULE["@"!(T="D")  Q:T'>1440  S WD=$P(PSGMARSD,".") I '(T#1440) S (SD,X)=$P(SD,"."),PSGT=T\1440 F QQ=0:1 S X1=SD,X2=QQ*PSGT D:X2 C^%DTC I X'<WD S S=S+1 Q:X>PSGMARFD  Q:X>FD  S S(X)=""
 K PSGT Q:'(T#1440)  S PSGT=T,X1=PSGMARSD,(ST,X2)=SD I PSGMARSD>SD D ^%DTC I X>1 S ST=$$EN^PSGCT(SD,X-1*1440\T*T)
 S (PSGS,X)=ST F PSGX=0:1 S AM=PSGT*PSGX,ST=PSGS S:AM X=$$EN^PSGCT(ST,AM) S X=$P(X,".") I X'<WD Q:X>PSGMARFD  Q:X>FD  I '$D(S(X)) S S=S+1,S(X)=""
 K AM,ST,PSGS,PSGT,PSGX Q
 ;
SPN ; set patient node
 D DIET^PSGMAR0
 S X=$P(PSGP(0),U)_U_$E($P(PSJPDOB,U,2),1,10)_";"_PSJPAGE_U_VA("PID")_U_PSJPDX_U_PSJPWT_U_PSJPWTD_U_PSJPHT_U_PSJPHTD_U_$P(PSJPAD,U,2)_U_$P(PSJPTD,U,2)_U_$P(PSJPSEX,U,2)_U_PSJPWD
 ;GMZ:PSJ*5*196;Set diet info for each patient.
 I (PSGSS="P")!(PSGSS="C")!(PSGSS="L") S ^TMP($J,PPN)=X_U_PSGMARWN_U_PSJPRB_U_$G(PSJDIET) Q
 ;
 ;DAM 5-01-07  Add check to see if user wants to include clinic orders when printing by ward.
 I PSGSS="W" Q:((PSGINCL="")&(PSGMARWN["C!"))  S ^TMP($J,TM,PSGMARWN,SUB1,SUB2)=X_U_U_U_$G(PSJDIET)
 ;
 ;DAM 5-01-07 Add check to see if user wants to include clinic orders when printing by ward group.
 I PSGSS="G" Q:((PSGINCLG="")&(PSGMARWN["C!"))  S ^TMP($J,TM,PSGMARWN,SUB1,SUB2)=X_U_U_U_$G(PSJDIET)
 ;
 ;PSJ*5.0*196 add diet information if sorted by patient.
 I ($P(X,"^",15)']"") S $P(X,"^",15)=$G(PSJDIET)
 ;
 ;DAM 5-01-07  Add an XTMP global to reverse location and patient name in the subscripts when printing MAR by WARD/PATIENT or WARD GROUP. 
 N PSGDEM S PSGDEM=X    ;transfer contents of patient demographics contained in "X" above to  a new variable temporarily
 S PSGREP="PSGM_"_$J
 S X1=DT,X2=1 D C^%DTC K %,%H,%T
 S ^XTMP(PSGREP,0)=X_U_DT
 I PSGRBPPN="P",PSGSS="W" Q:((PSGINCL="")&(PSGMARWN["C!"))  D    ;Construct XTMP global for printing by WARD
 . S ^XTMP(PSGREP,TM,SUB1,PSGMARWN,SUB2)=PSGDEM
 I PSGRBPPN="P",PSGSS="G" Q:((PSGINCLG="")&(PSGMARWN["C!"))  D   ;Construct XTMP global for printing by WARD GROUP
 . S ^XTMP(PSGREP,TM,SUB1,PSGMARWN,SUB2)=PSGDEM
 S X=PSGDEM    ;transfer contents of patient demographics contained in PSGDEM back to X
 ;End DAM modifications 5-01-07
 Q
