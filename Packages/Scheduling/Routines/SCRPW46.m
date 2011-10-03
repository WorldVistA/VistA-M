SCRPW46 ;RENO/KEITH/MLR - Outpatient Diagnosis/Procedure Search (cont.) ; 9/27/00 10:29am
 ;;5.3;Scheduling;**144,180,199,295,324,351**;AUG 13, 1993
 ;  *199* 
 ;  - Creation of Division subscript in ^TMP after DFN to capture,
 ;    display, & count multi-divisional patients in Summary Section.
 ;  - Filtering out on Sub-header those Division names not having
 ;    patients meeting search criteria.
 ;
PDIS ;Parameter display
 D SUBT^SCRPW50("**** Report Parameters Selected ****")
 W ! D PD1^SCRPW47(0) S SDOUT=0
 ;
PDIS1 K DIR
 S DIR(0)="S^C:CONTINUE;R:RE-DISPLAY PARAMETERS;P:PRINT PARAMETERS;Q:QUIT"
 S DIR("A")="Select report action"
 S DIR("B")="CONTINUE"
 D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 Q:Y="C"  G:Y="R" PDIS I Y="Q" S SDOUT=1 Q
 N ZTSAVE
 F SDI="SDDIV","SDDIV(","SD(","SDPAR(","SDCRI(","SDFMT","SDAPF(" S ZTSAVE(SDI)=""
 W ! D EN^XUTMDEVQ("PPRT^SCRPW46","Print Report Parameters",.ZTSAVE)
 G PDIS1
 ;
PPRT ;Print report parameters
 D:$E(IOST)="C" DISP0^SCRPW23
 S SDTIT(1)="<*>  OUTPATIENT DIAGNOSTIC/PROCEDURE CODE SEARCH  <*>"
 S SDTIT(2)="Report Search Parameters" D HINI,HDR
 D:'SDOUT PD1^SCRPW47(0) I $E(IOST)="P",$D(ZTQUEUED) G EXIT^SCRPW47
 Q  ;PPRT
 ;
STOP ;Check for stop task request
 S:$D(ZTQUEUED) (SDOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
 ;
HINI ;Initialize header variables
 S SDLINE="",$P(SDLINE,"-",(IOM+1))=""
 D NOW^%DTC S Y=% X ^DD("DD") S SDPNOW=$P(Y,":",1,2),SDPAGE=1,SDFF=0 Q
 ;
HDR ;Print report header
 I $E(IOST)="C",SDFF N DIR S DIR(0)="E" W ! D ^DIR S SDOUT=Y'=1 Q:SDOUT
 D STOP Q:SDOUT
 I SDFF!('SDFF&($E(IOST)="C")) W $$XY^SCRPW50(IOF,1,0)
 I $X W $$XY^SCRPW50("",0,0)
 N SDI W SDLINE S SDI=0
 F  S SDI=$O(SDTIT(SDI)) Q:'SDI  W !?(IOM-$L(SDTIT(SDI))\2),SDTIT(SDI)
 W !,SDLINE,!,"For date range: ",SD("PBDT")," to ",SD("PEDT")
 W !,"Date printed: ",SDPNOW,?(IOM-6-$L(SDPAGE)),"Page: ",SDPAGE
 W !,SDLINE S SDPAGE=SDPAGE+1,SDFF=1
 Q  ;HDR
 ;
DHDR(SDIV,SDI,SDTIT) ;Set up division subheaders
 ;Required input: SDIV=division ifn or '0' for summary
 ;Required input: SDI=array number to start with
 ;Required input: SDTIT=array to store subheaders in (pass by reference)
 D  ;
 . I 'SDIV S SDTIT(SDI)="Summary for "_$P(SDDIV,U,2) Q
 . I SDDIV,($P(SDDIV,U,2)="ALL DIVISIONS") S SDTIT(SDI)="For division: "_SDIVN_" "_SDIVL(SDIVN) Q  ; SD*5.3*324
 . S SDTIT(SDI)="For facility: "_SDIVN Q
 ;S SDTIT(SDI)=$S('SDIV:"Summary for "_$P(SDDIV,U,2),SDDIV!($P(SDDIV,U,2)="ALL DIVISIONS"):"For division: "_SDIVN_" "_SDIVL(SDIVN),1:"For facility: "_SDIVN)
 ;
 I 'SDIV,$P(SDDIV,U,2)="SELECTED DIVISIONS" N SDIVN S SDIVN="" D  Q
 .F  S SDIVN=$O(SDDIV(SDIVN)) Q:SDIVN=""  S SDI=SDI+1,SDTIT(SDI)="Division: "_SDDIV(SDIVN)
 .Q
 ;
 I 'SDIV,$P(SDDIV,U,2)="ALL DIVISIONS" D
 .N SDIV S SDIV=0 F  S SDIV=$O(^TMP("SCRPW",$J,SDIV)) Q:'SDIV  D
 .. Q:'$D(^TMP("SCRPW",$J,SDIV,2))
 .. S SDI=SDI+1
 .. S SDTIT(SDI)="Division: "_$P($G(^DG(40.8,SDIV,0)),U)_"  "_SDIV
 .Q
 Q
 ;
START ;Print report
 K ^TMP("SCRPW",$J) S (SDOUT,SDSTOP)=0,SDMD="",SDMD=$O(SDDIV(SDMD)),SDMD=$O(SDDIV(SDMD)) S:$P(SDDIV,U,2)="ALL DIVISIONS" SDMD=1
 ;Iterate through list of patient encounters
 S DFN=0 F  S DFN=$O(^SCE("ADFN",DFN)) Q:'DFN  K SDPDIV S SDSTOP=SDSTOP+1 D:SDSTOP#100=0 STOP Q:SDOUT  D
 .S SDT=SD("BDT") F  S SDT=$O(^SCE("ADFN",DFN,SDT)) Q:'SDT!SDOUT!(SDT>SD("EDT"))  D
 ..S SDOE=0 F  S SDOE=$O(^SCE("ADFN",DFN,SDT,SDOE)) Q:'SDOE!SDOUT  D
 ...S SDOE0=$$GETOE^SDOE(SDOE) S SDIV=$P(SDOE0,"^",11) Q:'SDIV!$P(SDOE0,"^",6)!'$$DIV()  S SDPDIV(SDIV)=""
 ...;Build initial patient diagnosis/procedure lists
 ...I $D(SD("LIST","D")) K SDLIST D GETDX^SDOE(SDOE,"SDLIST") S SDI=0 F  S SDI=$O(SDLIST(SDI)) Q:'SDI  D
 ....S SDDX=$P(SDLIST(SDI),"^") S:SDDX ^TMP("SCRPW",$J,0,0,DFN,SDIV,"DX",SDDX)=""
 ....Q
 ...I $D(SD("LIST","P")) K SDLIST D GETCPT^SDOE(SDOE,"SDLIST") S SDI=0 F  S SDI=$O(SDLIST(SDI)) Q:'SDI  D
 ....S SDCPT=$P(SDLIST(SDI),"^") S:SDCPT ^TMP("SCRPW",$J,0,0,DFN,SDIV,"CPT",SDCPT)=""
 ....;Loop through modifiers and add to CPT array
 .... N SDMODN,SDMOD  ; SDMODN=modifier node, SDMOD=mod pointer
 .... S SDMODN=0
 .... F  S SDMODN=+$O(SDLIST(SDI,1,SDMODN)) Q:'SDMODN  D
 ..... S SDMOD=$P(SDLIST(SDI,1,SDMODN,0),"^",1)
 ..... S:SDMOD ^TMP("SCRPW",$J,0,0,DFN,SDIV,"CPT",SDCPT,SDMOD)=""
 ..... Q
 .... Q
 ...S:$P(SDFMT,"^")="E" ^TMP("SCRPW",$J,SDIV,1,DFN,SDIV,"ACT",SDT,SDOE)=SDOE0
 ...S:$P(SDFMT,"^")="V" ^TMP("SCRPW",$J,SDIV,1,DFN,SDIV,"ACT",$P(SDT,"."))=""
 ...S:$P(SDFMT,"^")="P" ^TMP("SCRPW",$J,SDIV,1,DFN,SDIV,"ACT")=""
 ...Q
 ..Q
 .I '$D(^TMP("SCRPW",$J,0,0,DFN)) D  Q
 ..N SDIV S SDIV="" F  S SDIV=$O(SDPDIV(SDIV)) Q:SDIV=""  K ^TMP("SCRPW",$J,SDIV,1,DFN)
 ..Q
 .;Build text lists for Diagnosis ranges if necessary
 .I $D(SD("LIST","D","R")) D
 .. N SDIV S SDIV="" F  S SDIV=$O(SDPDIV(SDIV)) Q:'SDIV  D
 ... S SDI=0 F  S SDI=$O(^TMP("SCRPW",$J,0,0,DFN,SDIV,"DX",SDI)) Q:'SDI  D
 ....S SDX=$$ICDDX^ICDCODE(SDI,+SDOE0),SDX=$P(SDX,"^",2)_" "_$P(SDX,"^",4)
 .... S:$L(SDX)>1 ^TMP("SCRPW",$J,0,0,DFN,SDIV,"DXR",SDX)=SDI
 .;Building text list for Procedure ranges
 .I $D(SD("LIST","P","R")) S SDI=0 F  S SDI=$O(^TMP("SCRPW",$J,0,0,DFN,SDIV,"CPT",SDI)) Q:'SDI  D
 ..; SDI=CPT pointer, SDI2=mod ptr, SDX=CPT+desc, SDX2=mod+desc
 ..; get CPT and description and build array entry
 .. N CPTINFO,CPTCODE,CPTTEXT
 .. S CPTINFO=$$CPT^ICPTCOD(SDI,+SDOE0,1)
 .. Q:CPTINFO'>0
 .. S CPTCODE=$P(CPTINFO,"^",2)
 .. S CPTTEXT=$P(CPTINFO,"^",3)
 .. S SDX=CPTCODE_" "_CPTTEXT
 .. S:$L(SDX)>1 ^TMP("SCRPW",$J,0,0,DFN,SDIV,"CPTR",SDX)=SDI
 ..;
 ..; loop through mods in CPT array and call API to get mod code/desc
 .. S SDI2="" F  S SDI2=$O(^TMP("SCRPW",$J,0,0,DFN,SDIV,"CPT",SDI,SDI2)) Q:'SDI2  D
 ... N MODINFO,MODCODE,MODTEXT
 ... S MODINFO=$$MOD^ICPTMOD(SDI2,"I",+SDOE0,1)
 ... Q:MODINFO'>0
 ... S MODCODE=$P(MODINFO,"^",2)
 ... S MODTEXT=$P(MODINFO,"^",3)
 ... S SDX2=MODCODE_" "_MODTEXT
 ... ; add mod code/desc to array
 ... S:$L(SDX2)>1 ^TMP("SCRPW",$J,0,0,DFN,SDIV,"CPTR",SDX,SDX2)=SDI2
 ... Q
 ..Q
 .;Iterate through criteria combine logic
 .;Loop through secondary Division (SDIV) for multiple division episodes
 . N SDIV S SDIV="" F  S SDIV=$O(SDPDIV(SDIV)) Q:SDIV=""  D
 .. S SDCRI="" F  S SDCRI=$O(SDCRI(SDCRI)) Q:SDCRI=""  D
 ... S SDCL=$TR($TR(SDCRI,"'",""),"&","") F SDI=1:1:$L(SDCL) S SDC=$E(SDCL,SDI) D:'$D(^TMP("SCRPW",$J,0,0,DFN,SDIV,"CRI",SDC))
 ....;Build list of true items for each criteria element
 .... S SDZ=$P(SDPAR(SDC),"^")
 .... I SDZ="DL" S SDI=0 F  S SDI=$O(^TMP("SCRPW",$J,0,0,DFN,SDIV,"DX",SDI)) Q:'SDI  D
 ..... S:$D(SDPAR(SDC,SDI)) ^TMP("SCRPW",$J,0,0,DFN,SDIV,"CRI",SDC,SDI)=""
 ..... Q
 .... I SDZ="DR" S SDR1="",SDR1=$O(SDPAR(SDC,SDR1)),SDR2=$O(SDPAR(SDC,SDR1)),SDI="" D
 ..... F  S SDI=$O(^TMP("SCRPW",$J,0,0,DFN,SDIV,"DXR",SDI)) Q:SDI=""  D
 ...... I SDR1']SDI,SDI']SDR2 S ^TMP("SCRPW",$J,0,0,DFN,SDIV,"CRI",SDC,SDI)=""  Q
 ..... Q
 .... I SDZ="PL" S SDI=0 F  S SDI=$O(^TMP("SCRPW",$J,0,0,DFN,SDIV,"CPT",SDI)) Q:'SDI  D
 ..... I $D(SDPAR(SDC,SDI)) M ^TMP("SCRPW",$J,0,0,DFN,SDIV,"CRI",SDC,SDI)=^TMP("SCRPW",$J,0,0,DFN,SDIV,"CPT",SDI)
 ..... Q
 .... I SDZ="PR" S SDR1="",SDR1=$O(SDPAR(SDC,SDR1)),SDR2=$O(SDPAR(SDC,SDR1)),SDI="" D
 ..... F  S SDI=$O(^TMP("SCRPW",$J,0,0,DFN,SDIV,"CPTR",SDI)) Q:SDI=""  D
 ...... I SDR1']SDI,SDI']SDR2 M ^TMP("SCRPW",$J,0,0,DFN,SDIV,"CRI",SDC,SDI)=^TMP("SCRPW",$J,0,0,DFN,SDIV,"CPTR",SDI)
 ......Q
 .....Q
 ....S ^TMP("SCRPW",$J,0,0,DFN,SDIV,"CRI",SDC)=($D(^TMP("SCRPW",$J,0,0,DFN,SDIV,"CRI",SDC))>0)_U_SDZ
 .... Q
 ...;Apply criteria combine logic
 ...N A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z
 ...F SDI=1:1:$L(SDCL) S SDC=$E(SDCL,SDI),@SDC=$P(^TMP("SCRPW",$J,0,0,DFN,SDIV,"CRI",SDC),"^")
 ...;If combine logic is "true", move items to final list
 ...I @SDCRI F SDI=1:1:$L(SDCL) S SDC=$E(SDCL,SDI),SDX=^TMP("SCRPW",$J,0,0,DFN,SDIV,"CRI",SDC) D
 ....I SDX M ^TMP("SCRPW",$J,0,1,DFN,SDIV,$P(SDX,"^",2))=^TMP("SCRPW",$J,0,0,DFN,SDIV,"CRI",SDC)
 ....Q
 ...Q
 .I '$D(^TMP("SCRPW",$J,0,1,DFN)) D  Q
 ..S SDIV="" F  S SDIV=$O(SDPDIV(SDIV)) Q:SDIV=""  K ^TMP("SCRPW",$J,SDIV,1,DFN)
 ..Q
 .;Move item ifn lists to text lists
 .N SDIV S SDIV="" F  S SDIV=$O(SDPDIV(SDIV)) Q:SDIV=""  D
 .. S SDI=0 F  S SDI=$O(^TMP("SCRPW",$J,0,1,DFN,SDIV,"DL",SDI)) Q:'SDI  D
 ... S SDX=$$ICDDX^ICDCODE(SDI,+SDOE0),SDX=$P(SDX,"^",2)_" "_$P(SDX,"^",4) S:$L(SDX)>1 ^TMP("SCRPW",$J,0,1,DFN,SDIV,"DR",SDX)=$G(SDT)
        ... Q
 .N SDIV S SDIV="" F  S SDIV=$O(SDPDIV(SDIV)) Q:SDIV=""  D
 .. S SDI=0 F  S SDI=$O(^TMP("SCRPW",$J,0,1,DFN,SDIV,"PL",SDI)) Q:'SDI  D
 ... N CPTINFO,CPTCODE,CPTTEXT
 ... S CPTINFO=$$CPT^ICPTCOD(SDI,+SDOE0,1)
 ... Q:CPTINFO'>0
 ... S CPTCODE=$P(CPTINFO,"^",2)
 ... S CPTTEXT=$P(CPTINFO,"^",3)
 ... S SDX=CPTCODE_" "_CPTTEXT
 ... S:$L(SDX)>1 ^TMP("SCRPW",$J,0,1,DFN,SDIV,"PR",SDX)=""
 ... ;
 ... ;loop through mods in CPT array and call API to get mod code/desc
 ... S SDI2=""
 ... F  S SDI2=$O(^TMP("SCRPW",$J,0,1,DFN,SDIV,"PL",SDI,SDI2)) Q:'SDI2  D
 .... N MODINFO,MODCODE,MODTEXT
 .... S MODINFO=$$MOD^ICPTMOD(SDI2,"I",+SDOE0,1)
 .... Q:MODINFO'>0
 .... S MODCODE=$P(MODINFO,"^",2)
 .... S MODTEXT=$P(MODINFO,"^",3)
 .... S SDX2=MODCODE_" "_MODTEXT
 .... ; add mod code/desc to array
 .... S:$L(SDX2)>1 ^TMP("SCRPW",$J,0,1,DFN,SDIV,"PR",SDX,SDX2)=""
 .... Q 
 ...Q
 . ; delete procedure list array
 . N SDIV S SDIV="" F  S SDIV=$O(SDPDIV(SDIV)) Q:SDIV=""  D
 ..;Merge activity list
 .. M ^TMP("SCRPW",$J,SDIV,1,DFN,SDIV,"ACT")=^TMP("SCRPW",$J,SDIV,0,DFN,SDIV,"ACT")
 ..;Kill scratch list, merge to summary global if multidivisional
 ..I SDMD,SDFMT'="P" M ^TMP("SCRPW",$J,0,1,DFN,SDIV,"ACT")=^TMP("SCRPW",$J,SDIV,1,DFN,SDIV,"ACT")
 ..;Delete scratch levels and arrays after merge
 .. K ^TMP("SCRPW",$J,0,1,DFN,"DL")
 .. K ^TMP("SCRPW",$J,0,1,DFN,"PL")
 ..Q
 .Q
 ;Delete 0,0 scratch level prior to printing
 K ^TMP("SCRPW",$J,0,0)
 G:SDOUT EXIT^SCRPW47 G ^SCRPW47
 ;
DIV() ;Check division
 Q:'SDDIV 1  Q $D(SDDIV(+SDIV))
