PXVRPC1 ;BIR/ADM - IMM MANUFACTURER API ;08/16/2016
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**215,216**;Aug 12, 1996;Build 11
 ;
 Q
ILOT(PXVRETRN,PXVLK,PXVI,PXLOC) ; return list of immunization lot information
 ;Input:
 ;  PXVRETRN - (required) return array of external field values
 ;  PXVLK    - (optional) information to be returned - defaults to list all entries (S:B)
 ;               "R:XXX" - return entry with ien XXX
 ;               "N:XXX" - return entry with lot number XXX
 ;               "S:A"   - return list of all active lot numbers
 ;               "S:I"   - return list of all inactive lot numbers
 ;               "S:B"   - return list of all lot numbers, active and inactive
 ;  PXVI     - (optional) 
 ;               1     - return alternate array with internal values in delimited string
 ;  PXLOC    - (optional) Used to determine Institution (used when filtering Lot)
 ;             Possible values are:
 ;              "I:X": Institution (#4) IEN #X
 ;              "V:X": Visit (#9000010) IEN #X
 ;              "L:X": Hopital Location (#44) IEN #X
 ;             If determination cannot be made based off input, then default to DUZ(2),
 ;             and if DUZ(2) is not defined, default to Default Institution.
 ;
 ;Output:
 ;  PXVRETRN  - returned information is stored in ^TMP("PXVLST",$J))
 ;            - return info format: Field Name^Field Value
 ;            -       error format: -1^error message
 ;            -    alternate array: caret delimited string with differing internal and
 ;                                  external values separated by a tilde
 ;
 N PXVARAY,PXVFLG,PXVNAME,PXVVAL,PXVCT,PXVIEN,PXVSUM,PXFIL,PXINST,PXINVAL,PXVF
 S PXVARAY="^TMP(""PXVLST"",$J)" K @PXVARAY
 S PXVLK=$S('$L($G(PXVLK)):"S:B",1:PXVLK)
 I $G(PXVI)'=1 S PXVI=0
 S PXINVAL=0 I $L($G(PXLOC)) D  I PXINVAL D IIV Q
 .S PXFIL=$P(PXLOC,":") I $L(PXFIL)>1!("IVL"'[PXFIL) S PXINVAL=1 Q
 .S PXVF=$P(PXLOC,":",2) I 'PXVF S PXINVAL=1
 I $L($G(PXLOC)) S PXINST=$$INST^PXVUTIL($G(PXLOC))
 S PXVFLG=$P(PXVLK,":"),PXVVAL=$P(PXVLK,":",2)
 I $L(PXVFLG)>1!("RNS"'[PXVFLG) D IIV Q
 I PXVFLG="R",'$G(PXVVAL) S @PXVARAY@(0)="-1^Invalid input for immunization lot IEN" D TMPRET Q
 I PXVFLG="R",'$D(^AUTTIML(PXVVAL)) S @PXVARAY@(0)="-1^Invalid input for immunization lot IEN" D TMPRET Q
 I PXVFLG="N",'$L(PXVVAL) S @PXVARAY@(0)="-1^Invalid input for lot number" D TMPRET Q
 I PXVFLG="N",'$D(^AUTTIML("B",PXVVAL)) S @PXVARAY@(0)="-1^Invalid input for lot number" D TMPRET Q
 I PXVFLG="S",(PXVVAL'="A"&(PXVVAL'="B")&(PXVVAL'="I")) D IIV Q
 S (PXVCT,PXVSUM)=0
 I PXVFLG="R" S PXVIEN=PXVVAL D ONEL
 I PXVFLG="N" S PXVIEN=0 F  S PXVIEN=$O(^AUTTIML("B",PXVVAL,PXVIEN)) Q:'PXVIEN  D ONEL
 I PXVFLG="S" S PXVIEN=0 F  S PXVIEN=$O(^AUTTIML(PXVIEN)) Q:'PXVIEN  D ONEL
 I 'PXVI S PXVNAME="" F  S PXVNAME=$O(@PXVARAY@(PXVNAME)) Q:PXVNAME=""  S PXVCT=PXVCT+1,@PXVARAY@(PXVNAME,0)="RECORD^"_PXVCT_" OF "_PXVSUM
 I PXVI S @PXVARAY@(0)=PXVSUM_" RECORD"_$S(PXVSUM'>1:"",1:"S")
 I PXVSUM=0 S @PXVARAY@(0)="0 RECORDS"
 D TMPRET
 Q
 ;
ONEL ; return array containing info for selected immunization lot
 N PXV0,PXVFLD,PXVIENC,PXVY,PXVZ
 S PXVIENC=PXVIEN_",",PXV0=^AUTTIML(PXVIEN,0)
 I $G(PXINST),$P(PXV0,"^",10)'="",$P(PXV0,"^",10)'=PXINST Q
 I PXVFLG="S",PXVVAL="A",$P(PXV0,"^",3) Q
 I PXVFLG="S",PXVVAL="I",'$P(PXV0,"^",3) Q
 S PXVSUM=PXVSUM+1
 I 'PXVI D
 .D GETS^DIQ(9999999.41,PXVIENC,".01;.02;.03;.04;.09;.1;.12;.15;.18","","PXVY")
 .S PXVZ=0 F  S PXVZ=$O(PXVY(9999999.41,PXVIENC,PXVZ)) Q:'PXVZ  D
 ..D FIELD^DID(9999999.41,PXVZ,"","LABEL","PXVFLD")
 ..I PXVZ=.01 S PXVNAME=PXVY(9999999.41,PXVIENC,PXVZ),PXVNAME=PXVNAME_" "_PXVSUM
 ..S @PXVARAY@(PXVNAME,PXVZ)=PXVFLD("LABEL")_"^"_PXVY(9999999.41,PXVIENC,PXVZ)
 .S @PXVARAY@(PXVNAME,.001)="IEN^"_PXVIEN
 I PXVI D
 .D GETS^DIQ(9999999.41,PXVIENC,".02;.03;.04;.09;.1;.18","E","PXVY")
 .S PXVZ=PXVIEN_"^"_$P(PXV0,"^")_"^"_$P(PXV0,"^",2)_"~"_PXVY(9999999.41,PXVIENC,.02,"E")_"^"_$P(PXV0,"^",3)_"~"_PXVY(9999999.41,PXVIENC,.03,"E")
 .S PXVZ=PXVZ_"^"_$P(PXV0,"^",4)_"~"_PXVY(9999999.41,PXVIENC,.04,"E")_"^"_$P(PXV0,"^",9)_"~"_PXVY(9999999.41,PXVIENC,.09,"E")
 .S PXVZ=PXVZ_"^"_$P(PXV0,"^",12)_"^"_$P(PXV0,"^",15)_"^"_$P(PXV0,"^",18)_"~"_PXVY(9999999.41,PXVIENC,.18,"E")
 .S PXVZ=PXVZ_"^"_$P(PXV0,"^",10)_"~"_PXVY(9999999.41,PXVIENC,.1,"E")
 .S @PXVARAY@(PXVIEN)=PXVZ
 Q
 ;
IMAN(PXVRETRN,PXVLK,PXVDATE,PXVI) ; rpc to return immunization manufacturer information
 ;Input:
 ;  PXVRETRN - (required) return array
 ;  PXVLK    - (optional) information to be returned - defaults to list all entries (S:B)
 ;               R:XXX - return entry with ien XXX
 ;               M:XXX - return entry with MVX code XXX
 ;               N:XXX - return entry with imm manufacturer name XXX
 ;               S:A   - return list of all active manufacturers
 ;               S:I   - return list of all inactive manufacturers
 ;               S:B   - return list of all manufacturers, active and inactive
 ;  PXVDATE  - (optional) date for use in determining status - defaults to TODAY
 ;  PXVI     - (optional) 
 ;               1     - return alternate array with internal values in delimited string
 ;
 ;Output:
 ;  PXVRETRN  - returned information is stored in ^TMP("PXVLST",$J))
 ;            - return info format: Field Name^Field Value
 ;            -       error format: -1^error message
 ;            -    alternate array: caret delimited string with differing internal and
 ;                                  external values separated by a tilde
 ;
 N PXVARAY,PXVFLG,PXVNAME,PXVVAL,PXVCT,PXVIEN,PXVSUM
 S PXVARAY="^TMP(""PXVLST"",$J)" K @PXVARAY
 S PXVLK=$S('$L($G(PXVLK)):"S:B",1:PXVLK)
 I $G(PXVI)'=1 S PXVI=0
 S PXVFLG=$P(PXVLK,":"),PXVVAL=$P(PXVLK,":",2)
 I $L(PXVFLG)>1!("RMNS"'[PXVFLG) D IIV Q
 I PXVFLG="R",'$G(PXVVAL) S @PXVARAY@(0)="-1^Invalid input for manufacturer IEN" D TMPRET Q
 I PXVFLG="R",'$D(^AUTTIMAN(PXVVAL)) S @PXVARAY@(0)="-1^Invalid input for manufacturer IEN" D TMPRET Q
 I PXVFLG="M",'$L(PXVVAL) S @PXVARAY@(0)="-1^Invalid input for MVX code" D TMPRET Q
 I PXVFLG="M",'$D(^AUTTIMAN("M",PXVVAL)) S @PXVARAY@(0)="-1^Invalid input for MVX code" D TMPRET Q
 I PXVFLG="N",'$L(PXVVAL) S @PXVARAY@(0)="-1^Invalid input for manufacturer name" D TMPRET Q
 I PXVFLG="N",'$D(^AUTTIMAN("B",$G(PXVVAL))) S @PXVARAY@(0)="-1^Invalid input for manufacturer name" D TMPRET Q
 I PXVFLG="S",(PXVVAL'="A"&(PXVVAL'="B")&(PXVVAL'="I")) D IIV Q
 S PXVDATE=$S('$L($G(PXVDATE)):DT,1:PXVDATE)
 S (PXVCT,PXVSUM)=0
 I PXVFLG="R" S PXVIEN=PXVVAL D ONEM
 I PXVFLG="M" S PXVIEN=0 F  S PXVIEN=$O(^AUTTIMAN("M",PXVVAL,PXVIEN)) Q:'PXVIEN  D ONEM
 I PXVFLG="N" S PXVIEN=0 F  S PXVIEN=$O(^AUTTIMAN("B",PXVVAL,PXVIEN)) Q:'PXVIEN  D ONEM
 I PXVFLG="S" S PXVIEN=0 F  S PXVIEN=$O(^AUTTIMAN(PXVIEN)) Q:'PXVIEN  D ONEM
 I 'PXVI S PXVNAME="" F  S PXVNAME=$O(@PXVARAY@(PXVNAME)) Q:PXVNAME=""  S PXVCT=PXVCT+1,@PXVARAY@(PXVNAME,0)="RECORD^"_PXVCT_" OF "_PXVSUM
 I PXVI S @PXVARAY@(0)=PXVSUM_" RECORD"_$S(PXVSUM'>1:"",1:"S")
 I PXVSUM=0 S @PXVARAY@(0)="0 RECORDS"
 D TMPRET
 Q
 ;
ONEM ; return array containing info for selected manufacturer
 N PXVACT,PXVFILE,PXVFLD,PXVIENC,PXVP,PXVSTAT,PXV0,PXV2,PXVY,PXVZ,X
 S PXVIENC=PXVIEN_",",PXV0=^AUTTIMAN(PXVIEN,0),PXVFILE=9999999.04 D STAT
 I PXVFLG="S",PXVVAL="A",$P(PXV0,"^",3) Q
 I PXVFLG="S",PXVVAL="I",'$P(PXV0,"^",3) Q
 S PXVSUM=PXVSUM+1
 I 'PXVI D
 .D GETS^DIQ(9999999.04,PXVIENC,".01;.02;.03;201","","PXVY")
 .S PXVZ=0 F  S PXVZ=$O(PXVY(9999999.04,PXVIENC,PXVZ)) Q:'PXVZ  D
 ..D FIELD^DID(9999999.04,PXVZ,"","LABEL","PXVFLD")
 ..I PXVZ=.01 S PXVNAME=PXVY(9999999.04,PXVIENC,PXVZ),PXVNAME=PXVNAME_" "_PXVSUM
 ..S @PXVARAY@(PXVNAME,PXVZ)=PXVFLD("LABEL")_"^"_PXVY(9999999.04,PXVIENC,PXVZ)
 .S @PXVARAY@(PXVNAME,"STATUS")="STATUS^"_PXVSTAT
 .S @PXVARAY@(PXVNAME,.001)="IEN^"_PXVIEN
 I PXVI D
 .S PXVZ=PXVIEN_"^"_$P(PXV0,"^")_"^"_$P(PXV0,"^",2)_"^"_$P(PXV0,"^",3)_"~"_$S($P(PXV0,"^",3)=0:"ACTIVE",1:"INACTIVE")
 .S PXVZ=PXVZ_"^"_$P($G(^AUTTIMAN(PXVIEN,2)),"^")_"^"_PXVSTAT
 .S @PXVARAY@(PXVIEN)=PXVZ
 Q
 ;
IVIS(PXVRETRN,PXVLK,PXVDATE) ; rpc to return vaccine information statement information
 ;Input:
 ;  PXVRETRN - (required) return array
 ;  PXVLK    - (optional) information to be returned - defaults to list all entries (S:B)
 ;               R:XXX - return entry with ien XXX
 ;               N:XXX - return entry with VIS name XXX
 ;               S:A   - return list of all active VISs
 ;               S:I   - return list of all inactive VISs
 ;               S:B   - return list of all VISs, active and inactive
 ;  PXVDATE  - (optional) date for use in determining status - defaults to TODAY
 ;
 ;Output:
 ;  PXVRETRN  - returned information is stored in ^TMP("PXVLST",$J))
 ;            - return info format: Field Name^Field Value
 ;            -       error format: -1^error message
 ;
 N PXVARAY,PXVFLG,PXVNAME,PXVVAL,PXVCT,PXVIEN,PXVSUM
 S PXVARAY="^TMP(""PXVLST"",$J)" K @PXVARAY
 S PXVLK=$S('$L($G(PXVLK)):"S:B",1:PXVLK)
 S PXVFLG=$P(PXVLK,":"),PXVVAL=$P(PXVLK,":",2)
 I $L(PXVFLG)>1!("RNS"'[PXVFLG) D IIV Q
 I PXVFLG="R",'$G(PXVVAL) S @PXVARAY@(0)="-1^Invalid input for VIS IEN" D TMPRET Q
 I PXVFLG="R",'$D(^AUTTIVIS(PXVVAL)) S @PXVARAY@(0)="-1^Invalid input for VIS IEN" D TMPRET Q
 I PXVFLG="N",'$L(PXVVAL) S @PXVARAY@(0)="-1^Invalid input for VIS name" D TMPRET Q
 I PXVFLG="N",'$D(^AUTTIVIS("B",PXVVAL)) S @PXVARAY@(0)="-1^Invalid input for VIS name" D TMPRET Q 
 I PXVFLG="S",(PXVVAL'="A"&(PXVVAL'="B")&(PXVVAL'="I")) D IIV Q
 S PXVDATE=$S('$L($G(PXVDATE)):DT,1:PXVDATE)
 S (PXVCT,PXVSUM)=0
 I PXVFLG="R" S PXVIEN=PXVVAL D ONEV
 I PXVFLG="N" S PXVIEN=0 F  S PXVIEN=$O(^AUTTIVIS("B",PXVVAL,PXVIEN)) Q:'PXVIEN  D ONEV
 I PXVFLG="S" S PXVIEN=0 F  S PXVIEN=$O(^AUTTIVIS(PXVIEN)) Q:'PXVIEN  D ONEV
 S PXVNAME="" F  S PXVNAME=$O(@PXVARAY@(PXVNAME)) Q:PXVNAME=""  S PXVCT=PXVCT+1,@PXVARAY@(PXVNAME,0)="RECORD^"_PXVCT_" OF "_PXVSUM
 I PXVSUM=0 S @PXVARAY@(0)="0 RECORDS"
 D TMPRET
 Q
 ;
ONEV ; return array containing info for VIS
 N PXV,PXVACT,PXVFILE,PXVFLD,PXVIENC,PXVL,PXVP,PXVSTAT,PXVY,PXVZ
 S PXVIENC=PXVIEN_",",PXVFILE=920 D STAT
 I PXVFLG="S",PXVVAL="A",'PXVACT Q
 I PXVFLG="S",PXVVAL="I",PXVACT Q
 S PXVSUM=PXVSUM+1
 D GETS^DIQ(920,PXVIENC,".01;.02;.03;.04;2;100;101","","PXVP")
 S PXVZ=0 F  S PXVZ=$O(PXVP(920,PXVIENC,PXVZ)) Q:'PXVZ  D
 .D FIELD^DID(920,PXVZ,"","LABEL","PXVFLD")
 .I PXVZ=.01 S PXVNAME=PXVP(920,PXVIENC,PXVZ),PXVNAME=PXVNAME_" "_PXVSUM
 .I PXVZ=.04,PXVP(920,PXVIENC,PXVZ) N X S X=PXVP(920,PXVIENC,PXVZ) D  Q
 ..S PXV=$S(X=1:"ENGLISH",X=2:"GERMAN",X=3:"SPANISH",X=4:"FRENCH",X=5:"FINNISH",X=6:"ITALIAN",X=7:"PORTUGUESE",X=8:"ARABIC",X=11:"RUSSIAN",X=12:"GREEK",X=18:"HEBREW",1:X)
 ..S @PXVARAY@(PXVNAME,PXVZ)=PXVFLD("LABEL")_"^"_PXV
 .I PXVZ=2 D  Q
 ..I PXVP(920,PXVIENC,PXVZ)="" S @PXVARAY@(PXVNAME,PXVZ)=PXVFLD("LABEL")_"^"_PXVP(920,PXVIENC,PXVZ) Q
 ..S PXVL=0 F  S PXVL=$O(PXVP(920,PXVIENC,PXVZ,PXVL)) Q:'PXVL  D
 ...S @PXVARAY@(PXVNAME,PXVZ,PXVL)=PXVFLD("LABEL")_" "_PXVL_"^"_PXVP(920,PXVIENC,PXVZ,PXVL)
 .S @PXVARAY@(PXVNAME,PXVZ)=PXVFLD("LABEL")_"^"_PXVP(920,PXVIENC,PXVZ)
 S @PXVARAY@(PXVNAME,"STATUS")="STATUS^"_PXVSTAT
 S @PXVARAY@(PXVNAME,.001)="IEN^"_PXVIEN
 Q
 ;
STAT ;
 S PXVACT=$P($$GETSTAT^XTID(PXVFILE,,PXVIENC,$G(PXVDATE)),"^")
 I PXVACT="" S PXVACT=1
 S PXVSTAT=$S(PXVACT=0:"INACTIVE",1:"ACTIVE")
 Q
 ;
IIV ; return invalid input message
 S @PXVARAY@(0)="-1^Invalid input value"
TMPRET ;
 S PXVRETRN=$NA(@PXVARAY)
 Q
 ;
