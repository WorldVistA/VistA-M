SCRPW241 ;BPCIOFO/ACS - ACRP Ad Hoc Report (cont.) ;06/30/99
 ;;5.3;Scheduling;**180,254,351**;AUG 13, 1993
 ;
 ;----------------------------------------------------------------
 ; This routine was created due to the max number of bytes
 ; being reached in SCRPW24
 ;
 ; This routine is called by SCRPW24, and it contains CPT API calls
 ;
 ;----------------------------------------------------------------
 ;
APAC(SDX) ;Get all procedure codes
 ; INPUT - .SDX  array reference
 ; OUTPUT-  SDX  array with CPT pointer, CPT code, quantity
 ;
 K SDX
 N SDY,SDI,CPTINFO,CPTCODE
 ; array SDY will contain the CPT information
 D GETCPT^SDOE(SDOE,"SDY")
 ; Spin through CPT array and get CPT code and quantity
 S SDI=0 F  S SDI=$O(SDY(SDI)) Q:'SDI  D
 . I $D(SDY(SDI,0)) S SDX=$P(SDY(SDI,0),U)
 . E  Q
 . S CPTINFO=$$CPT^ICPTCOD(+SDX,+SDOE0,1)
 . Q:CPTINFO'>0
 . S CPTCODE=$P(CPTINFO,U,2)
 . S SDX=SDX_U_CPTCODE_U_$P(SDY(SDI,0),U,16)
 . I $L($P(SDX,U,2)) D APOTR(.SDX) S SDX(SDI)=SDX
 . Q
 Q
 ;
APOTR(SDX) ;Transform procedure external value
 ; INPUT - .SDX  CPT pointer
 ; OUTPUT-  SDX  text string containing CPT code, CPT text
 ;
 N CPTINFO,CPTTEXT,ENCDT
 S ENCDT=+$G(SDOE0)
 I 'ENCDT D
 .I '$G(SDOE) S ENCDT=$$NOW^XLFDT() Q
 .D GETGEN^SDOE(SDOE,"SDY")
 .S ENCDT=+$G(SDY(0))
 .K SDY
 S CPTINFO=$$CPT^ICPTCOD(+SDX,ENCDT,1)
 Q:CPTINFO'>0
 S CPTTEXT=$P(CPTINFO,U,3)
 S $P(SDX,U,2)=$P(SDX,U,2)_" "_CPTTEXT
 Q
 ;
APAP(SDX) ;Get ambulatory procedures (no E&M codes)
 ; INPUT - .SDX  array reference
 ; OUTPUT-  SDX  array containing CPT pointer, CPT code, CPT text
 ;
 K SDX
 N SDY,SDI,CPTINFO,CPTCODE
 D GETCPT^SDOE(SDOE,"SDY")
 ; Spin through CPT array and get CPT code
 S SDI=0 F  S SDI=$O(SDY(SDI)) Q:'SDI  D
 . I $D(SDY(SDI,0)) S SDX=$P(SDY(SDI,0),U)
 . E  Q
 . I '$D(^IBE(357.69,"B",SDX)) D
 .. S CPTINFO=$$CPT^ICPTCOD(+SDX,+SDOE0,1)
 .. Q:CPTINFO'>0
 .. S CPTCODE=$P(CPTINFO,U,2)
 .. S SDX=SDX_U_CPTCODE
 .. I $L($P(SDX,U,2)) D APOTR(.SDX) S SDX(SDI)=SDX
 .. Q
 . Q
 Q
 ;
APEM(SDX) ;Get evaluation and management codes
 ; INPUT - .SDX  array reference
 ; OUTPUT-  SDX  array containing CPT pointer, CPT code, CPT text
 ;
 K SDX
 N SDY,SDI,CPTINFO,CPTCODE
 D GETCPT^SDOE(SDOE,"SDY")
 ; Spin through CPT array and get CPT code
 S SDI=0 F  S SDI=$O(SDY(SDI)) Q:'SDI  D
 . I $D(SDY(SDI,0)) S SDX=$P(SDY(SDI,0),U)
 . E  Q
 . I $D(^IBE(357.69,"B",SDX)) D
 .. S CPTINFO=$$CPT^ICPTCOD(+SDX,+SDOE0,1)
 .. Q:CPTINFO'>0
 .. S CPTCODE=$P(CPTINFO,U,2)
 .. S SDX=SDX_U_CPTCODE
 .. I $L($P(SDX,U,2)) D APOTR(.SDX) S SDX(SDI)=SDX
 .. Q
 . Q
 Q
 ;
PDPE(SDX)       ;Get patient's ethnicities
 K SDX
 N DFN,VADM,NUM,CNT,ABB,TXT
 S DFN=$P(SDOE0,U,2)
 I DFN D DEM^VADPT I VADM(11) S CNT=1,NUM=0 F  S NUM=+$O(VADM(11,NUM)) Q:'NUM  D
 .I VADM(11,NUM) D
 ..S TXT=$$PTR2TEXT^DGUTL4(+VADM(11,NUM),2) S:TXT="" TXT="?"
 ..S ABB=$$PTR2CODE^DGUTL4(+$G(VADM(11,NUM,1)),3,1) S:ABB="" ABB="?"
 ..S SDX(CNT)=+VADM(11,NUM)_"^"_TXT_" ("_ABB_")",CNT=CNT+1
 S:$D(SDX)<10 SDX(1)="~~~NONE~~~^~~~UNANSWERED~~~"
 Q
 ;
PDPR(SDX)       ;Get patient's race
 K SDX
 N DFN,VADM,NUM,CNT,ABB,TXT
 S DFN=$P(SDOE0,U,2)
 I DFN D DEM^VADPT I VADM(12) S CNT=1,NUM=0 F  S NUM=+$O(VADM(12,NUM)) Q:'NUM  D
 .I VADM(12,NUM) D
 ..S TXT=$$PTR2TEXT^DGUTL4(+VADM(12,NUM),1) S:TXT="" TXT="?"
 ..S ABB=$$PTR2CODE^DGUTL4(+$G(VADM(12,NUM,1)),3,1) S:ABB="" ABB="?"
 ..S SDX(CNT)=+VADM(12,NUM)_"^"_TXT_" ("_ABB_")",CNT=CNT+1
 S:$D(SDX)<10 SDX(1)="~~~NONE~~~^~~~UNANSWERED~~~"
 Q
