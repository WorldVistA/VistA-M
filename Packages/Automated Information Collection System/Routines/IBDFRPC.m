IBDFRPC ;ALB/AAS - AICS Return list of interfaces ; 2-JAN-96
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**1,23**;APR 24, 1997
 ;
CLNLSTI(RESULT,CLINIC) ; -- Procedure
 ; -- Broker call to return list of data entry elements for a clinic/patient/form
 ;    rpc := IBD GET INPUT OBJECT BY CLINIC
 ;
 ; -- input  CLINIC = pointer to hospital location file or clinic name
 ;           Result = called by reference or use a closed global root
 ;
 ; -- output  The format of the returned array is as follows
 ;        result(0) := count of array elements
 ;        result(n) := $p1 :=  pkg interface name
 ;                     $p2 :=  pkg interface ien
 ;                     $p3 :=  form name
 ;                     $p4 :=  form type
 ;                     $p5 :=  type of input object
 ;                     $p6 :=  input object ien.
 ;                     $P7 :=  Vital Name (vitals only)
 ;                     $p8 :=  manual data entry supported
 ;                     $p9 :=  Block ien
 ;                     $p10 := block row
 ;                     $p11 := block column
 ;
 N I,J,X,Y,CL1,FTYP,IBDX,FRM,CNT
 ;
 I $E($G(RESULT),1)="^" S ARRY=RESULT
 E  S ARRY="RESULT"
 ;
 K @ARRY S @ARRY@(0)="Clinic Not Found"
 I +CLINIC'=CLINIC,CLINIC'="" S CLINIC=+$O(^SC("B",CLINIC,0))
 G:'CLINIC CLNLSTQ
 ;
 ; -- find forms for clinic in clinic set up
 ;    if no form, use default form from parameters
 S CL1=$O(^SD(409.95,"B",CLINIC,0))
 I 'CL1 D  G CLNLSTQ
 .S @ARRY@(0)="No forms for Clinic"
 .S FRM=$$DEFAULT Q:'FRM
 .S @ARRY@(0)="Using Default Form"
 .D FRMLSTI(.RESULT,FRM,11,0)
 ;
 S IBDX=$G(^SD(409.95,CL1,0)) F FTYP=2,3,4,5,6,8,9 I $P(IBDX,"^",FTYP)'="" S FRM=$P(IBDX,"^",FTYP) D FRMLSTI(.RESULT,FRM,FTYP,0)
 ;
CLNLSTQ Q
 ;
FRMLSTI(RESULT,FRM,FTYP,KILL,ALLOBJ) ; -- procedure
 ; -- Broker call to return list of data entry elemets for one form
 ;    rpc := IBD GET INPUT OBJECT BY FORM
 ;
 ; -- input     FRM := pointer to encounter form file (357) or form name
 ;           Result := Call by reference or use a closed global root
 ;             FTYP := type of form for clinic (optional)
 ;             KILL := 1 to kill results array prior to setting (default) (optional)
 ;           ALLOBJ := 1 to return all form objects, not just input objs
 ;                     0 to not kill array 
 ;
 ; -- output  The format of the returned array is as follows
 ;        Result(0) := count of array elements
 ;        Result(n)    $p1 :=  pkg interface name
 ;                     $p2 :=  pkg interface ien
 ;                     $p3 :=  form name
 ;                     $p4 :=  form type
 ;                     $p5 :=  type of input object
 ;                     $p6 :=  input object ien. 
 ;                     $p7 :=  Vital Name (vitals only)
 ;                     $p8 :=  manual data entry supported
 ;                     $p9 :=  Block ien
 ;                     $p10 := block row
 ;                     $p11 := block column
 ;
 N C,BLK,SEL,X,Y,ROW,COL,RESULT1,VITAL,CNT,ARRY,SEL1
 I $E($G(RESULT),1)="^" S ARRY=RESULT
 E  S ARRY="RESULT"
 ;
 I +FRM'=FRM,FRM'="" S FRM=+$O(^IBE(357,"B",FRM,0))
 I 'FRM S FRM=$$DEFAULT S:FRM @ARRY@(0)="Using default form" G:'FRM FRMLSTQ
 I $G(FTYP)="" S FTYP=1
 I $G(KILL)="" S KILL=1 K:KILL @ARRY
 I $G(@ARRY@(0))="" S @ARRY@(0)="Form Not Found"
 I '$G(ALLOBJ),$P($G(^IBE(357,FRM,0)),"^",12)'=1 S @ARRY@(0)="Form not scannable" G FRMLSTQ
 ;
 ; -- first find all the blocks
 S X=0 F  S X=$O(^IBE(357.1,"C",FRM,X)) Q:'X  S BLK=X D
 .; -- get row and column of block
 .S ROW=$P($G(^IBE(357.1,+BLK,0)),"^",4),COL=$P(^(0),"^",5)
 .Q:ROW=""!(COL="")
 .;
 .; -- now find all the selection lists with input interfaces
 .S Y=0 F  S Y=$O(^IBE(357.2,"C",BLK,Y)) Q:'Y  D
 ..S SEL=+$P($G(^IBE(357.2,+Y,0)),"^",11)
 ..;I $P($G(^IBE(357.6,+SEL,0)),"^",13)'=""!($G(ALLOBJ)) D  ; has input interface
 ..S SEL1=$P($G(^IBE(357.6,+SEL,0)),"^",13)
 ..I '$G(ALLOBJ) S SEL=SEL1
 ..I $G(ALLOBJ),SEL1'="" S SEL=SEL1
 ..Q:$G(^IBE(357.6,+SEL,0))=""
 ..D ADDIN(.RESULT1,FRM,FTYP,SEL,3,+Y,BLK,ROW,COL)
 ..Q
 .;
 .; -- find multiple choice fields
 .S Y=0 F  S Y=$O(^IBE(357.93,"C",BLK,Y)) Q:'Y  D
 ..S SEL=+$P($G(^IBE(357.93,+Y,0)),"^",6)
 ..I $P($G(^IBE(357.6,+SEL,0)),"^",13)'="" D
 ...S SEL=$P($G(^IBE(357.6,+SEL,0)),"^",13)
 ...Q:$G(^IBE(357.6,+SEL,0))=""
 ...D ADDIN(.RESULT1,FRM,FTYP,SEL,4,Y,BLK,ROW,COL)
 ..I $P($G(^IBE(357.6,+SEL,0)),"^",6)=1 D ADDIN(.RESULT1,FRM,FTYP,SEL,4,Y,BLK,ROW,COL)
 ..Q
 .;
 .; -- find Hand Print fields
 .S Y=0 F  S Y=$O(^IBE(359.94,"C",BLK,Y)) Q:'Y  D
 ..S SEL=+$P($G(^IBE(359.94,+Y,0)),"^",6)
 ..S VITAL=""
 ..I $P($G(^IBE(357.6,+SEL,0)),"^")["VITAL" S VITAL=$P($G(^IBE(359.1,+$P($G(^IBE(359.94,+Y,0)),"^",10),0)),"^")
 ..I $P($G(^IBE(357.6,+SEL,0)),"^",13)'="" D
 ...S SEL=$P($G(^IBE(357.6,+SEL,0)),"^",13)
 ...Q:$G(^IBE(357.6,+SEL,0))=""
 ...D ADDIN(.RESULT1,FRM,FTYP,SEL,5,Y,BLK,ROW,COL)
 ..I $P($G(^IBE(357.6,+SEL,0)),"^",6)=1 D ADDIN(.RESULT1,FRM,FTYP,SEL,5,Y,BLK,ROW,COL,VITAL)
 ..Q
 .;
 .I $G(ALLOBJ) D
 ..; find Data fields
 ..S Y=0 F  S Y=$O(^IBE(357.5,"C",BLK,Y)) Q:'Y  D ADDIN(.RESULT1,FRM,FTYP,+$P($G(^IBE(357.5,+Y,0)),"^",3),6,Y,BLK,ROW,COL)
 ..
 ..; find form lines
 ..S Y=0 F  S Y=$O(^IBE(357.7,"C",BLK,Y)) Q:'Y  D ADDIN(.RESULT1,FRM,FTYP,"FORM LINE",7,Y,BLK,ROW,COL)
 ..;
 ..; find text areas
 ..S Y=0 F  S Y=$O(^IBE(357.8,"C",BLK,Y)) Q:'Y  D ADDIN(.RESULT1,FRM,FTYP,"TEXT AREA",8,Y,BLK,ROW,COL)
 .Q
 ;
 ; -- now set results into single array
 S ROW="",CNT=+$G(@ARRY@(0))
 F  S ROW=$O(RESULT1(ROW)) Q:ROW=""  S COL="" F  S COL=$O(RESULT1(ROW,COL)) Q:COL=""  D
 .S C=0 F  S C=$O(RESULT1(ROW,COL,C)) Q:C=""  D
 ..S CNT=CNT+1
 ..S @ARRY@(CNT)=RESULT1(ROW,COL,C)
 S @ARRY@(0)=CNT
 K RESULT1
 ;
FRMLSTQ Q
 ;
ADDIN(RESULT1,FRM,FTYP,SEL,ITYP,ENTRY,BLK,ROW,COL,VITAL) ; --add to array
 N ITYPE1
 S ITYPE1=$S(ITYP=3:"LIST",ITYP=4:"MC",ITYP=5:"HP",ITYP=6:"DF",ITYP=7:"FL",ITYP=8:"TA",1:"OTHER")
 S RESULT1(0)=$G(RESULT1(0))+1
 S RESULT1(+ROW,+COL,RESULT1(0))=$S(+SEL:$P($G(^IBE(357.6,+SEL,0)),"^"),1:SEL)_"^"_SEL_"^"_$P($G(^IBE(357,+FRM,0)),"^")_"^"_$P($T(TYP+FTYP),";;",2)_"^"_ITYPE1_"^"_$G(ENTRY)_"^"_$G(VITAL)_"^"_$$MNL
 S RESULT1(+ROW,+COL,RESULT1(0))=RESULT1(+ROW,+COL,RESULT1(0))_"^"_$G(BLK)_"^"_$G(ROW)_"^"_$G(COL)
 Q
 ;
MNL() ; -- is manual data entry supported
 Q $S($G(^IBE(357.6,+SEL,18))'="":1,1:0)
 ;
DEFAULT() ; -- find default form from parameters
 N FRM
 S FRM=$P($G(^IBD(357.09,1,0)),"^",4)
 I FRM="" S FRM=$O(^IBE(357,"B","PRIMARY CARE SAMPLE V2.1",0))
 Q FRM
 ;
TESTC ; -- test list by clinic
 K TEST
 D CLNLSTI(.TEST,25)
 X "ZW TEST"
 Q
 ;
TESTF ; -- test list by form
 K TEST
 D FRMLSTI(.TEST,91)
 X "ZW TEST"
 Q
 ;
TYP ; types of forms/from piece in 409.95
 ;;
 ;;BASIC FORM
 ;;SUPPLIMENTAL FORM, EST. PATIENTS
 ;;SUPPLEMENTAL FORM, FIRST VISIT
 ;;FORM W/O PATIENT DATA
 ;;SUPPLEMENTAL FORM
 ;;
 ;;SUPPLEMENTAL FORM
 ;;SUPPLEMENTAL FORM
 ;;
 ;;DEFAULT FORM
 ;;
