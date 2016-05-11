VPSVTL01 ;ALBANY/KC - Patient Vitals RPC;08/14/14 09:28
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**10**;July 8, 2015;Build 16
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External Reference DBIA#
 ; ------------------------
 ; #5047  - $$GETIEN^GMVGETVT         (supported)
 ; #3647  - EN1^GMRVUT0               (Supported)
 ; #10040 - File #44 ^SC( references  (Supported)
 Q
GET(VPSARR,VPSNUM,VPSTYP,VTYP,BDT,EDT) ;
 ;
 ; INPUT
 ;   VPSNUM  - Parameter Value - patient SSN OR DFN OR ICN OR VIC/CAC (REQUIRED)
 ;   VPSTYP  - Parameter TYPE - SSN or DFN OR ICN OR VIC/CAC (REQUIRED)
 ;   VTYP    - Parameter for Vital Type
 ;   BDT     - Parameter Begin Date
 ;   EDT     - Parameter End Date
 ;
 ; OUTPUT
 ;   VPSARR  - passed in by reference; return array of patient Vitals
 ;           If error 
 ;                   VPSARR(1)=99^Error message
 ;           otherwise
 ;                   VPSRES(0)=1^Total number of Vitals being returned
 ;                   VPSARR(1)= Vital Date/Time ^ Vital Type ^ Rate ^ High Risk Flag ^ Location ^ Q1 ; Q2 ^ Sup O2
 ;                   VPSARR(n)= Vital Date/Time ^ Vital Type ^ Rate ^ High Risk Flag ^ Location ^ Q1      ^ Sup O2
 ;                                     Where Q1, Q2, .. Qn are the Qualifiers
 ;
 ;
 N CNT,DFN
 S CNT=0
 K VPSARR
 S DFN=$$VALIDATE^VPSRPC1($G(VPSTYP),$G(VPSNUM))
 I +DFN<0 S VPSARR(1)="99^"_$P(DFN,"^",2) Q
 ;
 N VID,VDAT,I
 S VID=""
 S VTYP=$G(VTYP)
 G:VTYP="LAST"!(VTYP="ALL") C1
 F I=1:1:$L(VTYP,";") D
 . S VDAT=$P(VTYP,";",I)
 . S VID=$$GETIEN^GMVGETVT(VTYP,2)
 . I VID=""!(VID=-1) S VPSARR="99^Invalid Vital Type"
 Q:$G(VPSARR)]""
C1 ;
 I $G(BDT)="" D NOW^%DTC S BDT=$P(%,".")_".0000"
 I $G(EDT)="" D
 . N X,%H
 . S X=BDT
 . D H^%DTC
 . S %H=%H+1
 . S X=0
 . D YMD^%DTC
 . S EDT=X_".0001"
 I $$DTCHK($G(BDT)) S VPSARR="99^Invalid or missing Start Date" Q
 I $$DTCHK($G(EDT)) S VPSARR="99^Invalid or missing End Date" Q
 I $P(EDT,".",2)="" S EDT=EDT_".2400"
 I BDT>EDT S VPSARR="99^Start date is after end date" Q
 ;
 N GMRVSTR
 I VTYP="ALL" S GMRVSTR="AG;AUD;BP;CG;CVP;FH;FT;HC;HE;HT;P;PN;PO2;R;T;TON;VC;VU;WT"
 I VTYP'="LAST",VTYP'="ALL" S GMRVSTR=VTYP
 S GMRVSTR(0)=BDT_"^"_EDT_"^99^1"
 I VTYP="LAST" S GMRVSTR="AG;AUD;BP;CG;CVP;FH;FT;HC;HE;HT;P;PN;PO2;R;T;TON;VC;VU;WT",$P(GMRVSTR(0),U,3)=1
 K ^UTILITY($J,"GMRVD")
 D EN1^GMRVUT0
 ; The utility will create an array with the desired information.  The
 ; array structure will be as follows if '$P(GMRVSTR(0),"^",4):
 ;      ^UTILITY($J,"GMRVD",GMRVTYP,GMRVRDT,GMRVIEN)=GMRVDATA
 ; or if $P(GMRVSTR(0),"^",4) then the following will be returned:
 ;      ^UTILITY($J,"GMRVD",GMRVRDT,GMRVTYP,GMRVIEN)=GMRVDATA
 ; where GMRVRDT  = Reverse FileMan date/time.
 ;                  9999999-Date/time vital/measurement was taken.
 ;       GMRVTYP  = The abbreviation used in the GMRVSTR string for the
 ;                  type of vital/measurement taken.
 ;       GMRVIEN  = Entry number in FILE 120.5 or
 ;                  pseudo entry number for File 704.117
 ;       GMRVDATA = $P(^GMR(120.5,GMRVIEN,0),"^",1,9) will be the patient data as
 ;                  currently defined in the DD for file 120.5.
 ;       $P(GMRVDATA,"^",10) = the first qualifier
 ;       $P(GMRVDATA,"^",11) = the second qualifier
 ;       $P(GMRVDATA,"^",12)= "*" for abnormal measurement, otherwise = ""
 ;       $P(GMRVDATA,"^",13)= values in centigrade for T; KG for WT; 
 ;                            in centimeter for HT and Circumference/Girth;
 ;                            in mmHg for CVP.
 ;       $P(GMRVDATA,"^",14)= Body Mass Index.
 ;       $P(GMRVDATA,"^",15)= L/Min of supplemental O2.
 ;       $P(GMRVDATA,"^",16)= % of supplemental O2.
 ;       $P(GMRVDATA,"^",17)= all qualifiers.
 ; ^UTILITY(551103247,"GMRVD",6849277.86,"HT",20)="3150721.14^7169761^8^3150721.141^5^123458951^^76^^ACTUAL^^^193.04^^^^ACTUAL"
 N TY,IEN,DAT,LOC
 S I="",TY="",IEN=""
 F  S I=$O(^UTILITY($J,"GMRVD",I)) Q:I=""  F  S TY=$O(^UTILITY($J,"GMRVD",I,TY)) Q:TY=""  F  S IEN=$O(^UTILITY($J,"GMRVD",I,TY,IEN)) Q:IEN=""  D
 . S DAT=^UTILITY($J,"GMRVD",I,TY,IEN)
 . S CNT=CNT+1
 . S LOC=$$GET1^DIQ(44,$P(DAT,U,5)_",",.01)
 . S VPSARR(CNT)=$P(DAT,U)_U_TY_U_$P(DAT,U,8)_U_$S($P(DAT,U,12)="*":1,1:"")_U_LOC_U_$P(DAT,U,17)_U_$P(DAT,U,16)
 S VPSARR(0)="1^"_CNT
 Q
 ;
 ; Date check function
DTCHK(DDT) ;
 N H,FM,MN,FLG
 Q:+$G(DDT)=0 1
 S MN=$P(DDT,".",2)
 S MN=$E(MN_"000000",1,6)
 S FLG=0
 I MN<0 S FLG=1
 I $E(MN,1)>2 S FLG=1
 I $E(MN,3)>5 S FLG=1
 I $E(MN,5)>5 S FLG=1
 Q:FLG 1
 S H=$$FMTH^XLFDT(DDT)
 I $P(H,",",2)=0 S FM=$$HTFM^XLFDT($P(H,","))
 E  S FM=$$HTFM^XLFDT(H)
 I +$P(DDT,".",2)=0 S DDT=$P(DDT,".")
 S $P(DDT,".",2)=$E($P(DDT,".",2)_"000000",1,6)
 S $P(FM,".",2)=$E($P(FM,".",2)_"000000",1,6)
 Q:FM=DDT 0
 Q 1
