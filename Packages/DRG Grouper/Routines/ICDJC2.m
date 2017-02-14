ICDJC2 ;ALB/ARH - DRG GROUPER CALCULATOR 2015 - CODE SETS ;05/26/2016
 ;;18.0;DRG Grouper;**89**;Oct 20, 2000;Build 9
 ;
 ; DRG Calcuation for re-designed grouper ICD-10 2015, continuation
 ;
CDSET(ICDDX,ICDPR,ICDDATE,CDSARR) ; get all Code Sets defined by event Diagnosis and Procedure codes
 ; most Code Sets are specific to an event code, either Diagnosis (83.5,20) or Procedure (83.6,20)
 ; Dx Code Sets may be specific to primary or secondary event dx, all members of procedure Clusters must be defined
 ; an 'ONLY' Code Set is selected only if all the codes defined for the event are in the Code Set
 ; computed generic and linked group Code Sets are selected if all criteria are met
 ; 
 ; Input:   ICDDX(x) and ICDPR(x)  - array of Dx/procedures input to API, ICDDATE - date of event
 ; Output:  CDSARR - array of all Code Sets (83.3) satisfied by the event diagnosis and procedures
 ;          CDSARR(code set ifn, icdxx number) = code ien (80/80.1) ^ DX/PR ^ single(1)/cluster only(0) ^ cluster ien
 ;          CDSARR(code set ifn, 99_cmpt #) = ^ type of codes in set 'DX' or 'PR' - for computed codes sets
 N LINE,PDX,DXI,DX,DXIFN,PRI,PR,PRIFN,SETIFN,ONLY,LINK,ARRCDS S ICDDATE=$G(ICDDATE) K CDSARR
 S PDX=$O(ICDDX(0))
 ;
 ;
 ; get all Diagnosis Code Sets
 S DXI=0 F  S DXI=$O(ICDDX(DXI)) Q:'DXI  D
 . ;
 . ; get all code sets the dx is assigned to on date
 . S DX=+$G(ICDDX(DXI)) S DXIFN=$O(^ICDD(83.5,"B",DX,0)) Q:'DXIFN  D GETCDS("DX",DXIFN,ICDDATE,.ARRCDS)
 . ;
 . ; for each code set the dx is assigned to check that for this event it passes the set criteria
 . S SETIFN=0 F  S SETIFN=$O(ARRCDS(SETIFN)) Q:'SETIFN  D
 .. S LINE=$G(^ICDD(83.3,SETIFN,0))
 .. ;
 .. I $P(LINE,U,3)'="DX" Q
 .. I $P(LINE,U,4)="P",DXI'=PDX Q  ; code set for primary dx
 .. I $P(LINE,U,4)="S",DXI=PDX Q  ; code set for secondary dx
 .. ;
 .. I $P(LINE,U,7)'="" S LINK($P(LINE,U,7),SETIFN)=$G(LINK($P(LINE,U,7),SETIFN))+1 ; linked set
 .. I $P(LINE,U,5)=2 S ONLY(DXI)=SETIFN_U_DX_U_"DX" Q  ; only secondary dxs contained in the set allowed
 .. ;
 .. S CDSARR(SETIFN,DXI)=DX_U_"DX"_U_1
 ;
 I $O(ONLY(0)) D ONLY(.ONLY,.ICDDX,.CDSARR) ; add ONLY code sets that may apply
 K ARRCDS,ONLY
 ;
 ;
 ; get all Procedure Code Sets
 S PRI=0 F  S PRI=$O(ICDPR(PRI)) Q:'PRI  D
 . ;
 . ; get all code sets the procedure is assigned to on date
 . S PR=+$G(ICDPR(PRI)) S PRIFN=$O(^ICDD(83.6,"B",PR,0)) Q:'PRIFN  D GETCDS("PR",PRIFN,ICDDATE,.ARRCDS,.ICDPR)
 . ;
 . ; for each code set the procedure is assigned to check that for this event it passes the set criteria
 . S SETIFN=0 F  S SETIFN=$O(ARRCDS(SETIFN)) Q:'SETIFN  D
 .. S LINE=$G(^ICDD(83.3,SETIFN,0))
 .. ;
 .. I $P(LINE,U,3)'="PR" Q
 .. ;
 .. I $P(LINE,U,7)'="" S LINK($P(LINE,U,7),SETIFN)=$G(LINK($P(LINE,U,7),SETIFN))+1 ; linked set
 .. I $P(LINE,U,5)=2 S ONLY(PRI)=SETIFN_U_PR_U_"PR" Q  ; only procedures contained in the set allowed
 .. ;
 .. S CDSARR(SETIFN,PRI)=PR_U_"PR"_U_$P(ARRCDS(SETIFN),U,3,4)
 ;
 I $O(ONLY(0)) D ONLY(.ONLY,.ICDPR,.CDSARR) ; add ONLY code sets that may apply
 ;
 ;
 I $O(LINK(""))'="" D LINK(.LINK,.CDSARR) ; add any computed LNK code sets that may apply
 ;
 ; check for generic or calculated code sets that may apply
 S SETIFN=$$CALC1(.ICDPR,ICDDATE) I +SETIFN S CDSARR(+SETIFN,991)=U_"PR"  ; ANY OPERATING ROOM PROCEDURE
 S SETIFN=$$CALC2(.ICDPR,ICDDATE) I +SETIFN S CDSARR(+SETIFN,992)=U_"PR"  ; NO OPERATING ROOM PROCEDURE
 S SETIFN=$$CALC3(.ICDDX) I +SETIFN S CDSARR(+SETIFN,993)=U_"DX"  ; NO SECONDARY DIAGNOSIS
 Q
 ;
GETCDS(TYP,CDIFN,DATE,ARRCDS,ICDPR) ; get Code Sets for a single code on a date, either diagnosis (83.5,20) or procedure (83.6,20)
 ; input:  TYP - type of codes 'DX' or 'PR', CDIFN - ptr to code in 83.5 or 83.6
 ; output: ARRCDS - array of code sets the code is a member of on the date
 ;         ARRCDS(code set ifn (83.3)) = TYP ^ code set ifn ^ single(1)/cluster only(0) in set ^ cluster ptr 83.61
 ; a procedure may be assigned to a Code Set as a single procedure and/or as a member of a cluster, all members 
 ; of a cluster (83.6,20,.04) must be defined for the cluster only procedures to select a Code Set
 N IX,CDFILE,LINE,BEGIN,END,SETIFN,CLUSTER,SINGLE S TYP=$G(TYP),CDIFN=+$G(CDIFN) K ARRCDS I '$G(DATE) S DATE=DT
 S CDFILE=$S(TYP="DX":83.5,TYP="PR":83.6,1:0) I 'CDFILE Q
 ;
 S IX=0 F  S IX=$O(^ICDD(CDFILE,CDIFN,20,IX)) Q:'IX  D
 . S LINE=$G(^ICDD(CDFILE,CDIFN,20,IX,0)),SETIFN=+$P(LINE,U,3)
 . S BEGIN=$P(LINE,U,1),END=$P(LINE,U,2) I 'END S END=9999999
 . I (BEGIN>DATE)!(END<DATE) Q
 . ;
 . I TYP="DX" S ARRCDS(SETIFN)=TYP_U_SETIFN_U_1 Q
 . ;
 . S CLUSTER=$P(LINE,U,4) I +CLUSTER,'$$CLSTR(CLUSTER,.ICDPR) Q
 . S SINGLE=1 I '$D(ARRCDS(SETIFN)),+CLUSTER S SINGLE=0
 . ;
 . S ARRCDS(SETIFN)=TYP_U_SETIFN_U_SINGLE_U_CLUSTER Q
 Q
 ;
CLSTR(CLUSTER,ICDPR) ; determine if the event procedures satisfy the cluster
 ; returns true if all the procedures assigned to the cluster (83.61) are defined on the event
 ; input:  CLUSTER - ptr to a cluster (83.61),  ICDPR - array of event procedures
 N PR,PRI,FND,ARRPR S CLUSTER=+$G(CLUSTER) S FND=0
 ; 
 ; get list of event procedures by procedure ifn
 S PRI=0 F  S PRI=$O(ICDPR(PRI)) Q:'PRI  S PR=+$G(ICDPR(PRI)) S ARRPR(PR)=PRI
 ;
 ; determine if all procedures assigned to the cluster are assigned to the event
 S PR=0 F  S PR=$O(^ICDD(83.61,CLUSTER,10,"B",PR)) Q:'PR  S FND=0 S:+$G(ARRPR(PR)) FND=1  I 'FND Q
 ;
 Q FND
 ;
 ;
CALC1(ICDPR,ICDDATE) ; Computed generic Code Set:  ANY OPERATING ROOM PROCEDURE
 ; returns the generic Code Set IFN if there is one or more O.R. or Surgical event procedures
 N CMPTSET1,PRI,PR,PRIFN,PRATT,FND S FND=0
 ;
 S CMPTSET1=$O(^ICDD(83.3,"ACSC",1,0))
 ;
 S PRI=0 F  S PRI=$O(ICDPR(PRI)) Q:'PRI  D  Q:FND
 . S PR=+$G(ICDPR(PRI)) S PRIFN=$O(^ICDD(83.6,"B",PR,0)) Q:'PRIFN
 . S PRATT=$$GETATT^ICDJC1("PR",PRIFN,$G(ICDDATE)) I $P(PRATT,U,3)="O" S FND=1
 ;
 I +FND S FND=+CMPTSET1
 ;
 Q FND
 ;
CALC2(ICDPR,ICDDATE) ; Computed generic Code Set:  NO OPERATING ROOM PROCEDURE
 ; returns the generic Code Set IFN if there are no O.R or Surgical event procedures
 N CMPTSET2,PRI,PR,PRIFN,PRATT,FND S FND=1
 ;
 S CMPTSET2=$O(^ICDD(83.3,"ACSC",2,0))
 ;
 S PRI=0 F  S PRI=$O(ICDPR(PRI)) Q:'PRI  D  Q:'FND
 . S PR=+$G(ICDPR(PRI)) S PRIFN=$O(^ICDD(83.6,"B",PR,0)) Q:'PRIFN
 . S PRATT=$$GETATT^ICDJC1("PR",PRIFN,$G(ICDDATE)) I $P(PRATT,U,3)="O" S FND=0
 ;
 I +FND S FND=+CMPTSET2
 ;
 Q FND
 ;
CALC3(ICDDX) ; Computed generic Code Set:  NO SECONDARY DIAGNOSIS
 ; returns the generic Code Set IFN if there are no Secondary diagnosis on the event (only 1 dx)
 N IX,CMPTSET3,FND S FND=1
 ;
 S CMPTSET3=$O(^ICDD(83.3,"ACSC",3,0))
 ;
 S IX=$O(ICDDX(0)) S IX=$O(ICDDX(IX)) I +IX S FND=0
 ;
 I +FND S FND=+CMPTSET3
 ;
 Q FND
 ;
ONLY(ONLYARR,ICDARR,CDSARR) ; add 'ONLY' Code Set if all codes assigned to the event are in the Set
 ; if all the event codes are in the set then add the Only Code Set to the list of all selected Code Sets
 ; for diagnosis this is only applied to the secondary codes
 ; for procedures this is only applied to operating room procedures, non-or procedures outside the set are allowed
 ; input:  ONLYARR(icdxx number) = ONLY code set ifn ^ code ifn (ptr #80, #80.1) ^ code type
 ;         ICDARR - may be either ICDDX or ICDPRC
 ; output: CDSARR modified - if meets criteria the ONLY Code Set is added to CDSARR array of selected code sets
 ;         CDSARR(ONLY code set ifn, idcxx number) = code ien (80/80.1) ^ code type ^ 1 (single)
 N IX,LINE,CODTYP,PR,PRIFN,CNT,FND S CNT=0,FND=0
 ;
 S IX=$O(ONLYARR(0)) Q:'IX  S CODTYP=$P(ONLYARR(IX),U,3)
 ;
 I CODTYP="DX" S IX=$O(ICDARR(0)) F  S IX=$O(ICDARR(IX)) Q:'IX  S CNT=CNT+1 I $D(ONLYARR(IX)) S FND=FND+1
 ;
 I CODTYP="PR" S IX=0 F  S IX=$O(ICDARR(IX)) Q:'IX  D  I CODTYP="O" S CNT=CNT+1 I $D(ONLYARR(IX)) S FND=FND+1
 . S PR=+$G(ICDARR(IX)) S PRIFN=$O(^ICDD(83.6,"B",PR,0)) S CODTYP=$P($$GETATT^ICDJC1("PR",PRIFN,$G(ICDDATE)),U,3)
 ;
 I +FND,FND=CNT S IX=0 F  S IX=$O(ONLYARR(IX)) Q:'IX  S LINE=ONLYARR(IX) S CDSARR(+LINE,IX)=$P(LINE,U,2,3)_U_1
 Q
 ;
LINK(LINKARR,CDSARR) ; add any Computed LNK Code Set that apply
 ; for any selected Code Set in a Linked group, check if the Link criteria is satisfied 
 ; if the Link criteria is met then add the generic LNK Computed Code Set to the list of selected Code Sets
 ; input:  LINKARR(link group, LINKED code set ifn) = count of selected Code Sets with the link group
 ;         CDSARR(code set ifn, icdxx number) = code ifn (ptr #80, #80.1) ^ code type
 ; output: CDSARR modified, any LNK Computed Code Set satisfied is added to CDSARR array of all selected Sets
 ;         CDSARR(LNK Computed code set ifn, 99x) =  ^ code type   w/x is the LNK set value
 ; difference between CDN and MLT is Condition is not exclusive, one code can satisfy more than one condition
 ; number of sets required is in link text after '-', count link number a group satisfies is in the set name
 N LINK,CMPTSET,CSET0,LINE,SETIFN,MDCCAT,CMPTD,NUM,COUNT,CNT,IX,ARRLNK
 ;
 ; find the generic LNK Computed Code Set for any of the Linked Code Sets defined by the event
 S LINK="" F  S LINK=$O(LINKARR(LINK)) Q:LINK=""  D
 . S CMPTSET=0 F  S CMPTSET=$O(^ICDD(83.3,"ACSL",LINK,CMPTSET)) Q:'CMPTSET  D
 .. S LINE=$G(^ICDD(83.3,CMPTSET,0)) I +$P(LINE,U,6) S ARRLNK(CMPTSET)=""  ; computed set
 ;
 ; for each generic LNK Computed Code Set found, determine if all linked sets defined and/or criteria met
 ; if they are then add the generic set to the list of Code Sets defined for the event.
 S CMPTSET=0 F  S CMPTSET=$O(ARRLNK(CMPTSET)) Q:'CMPTSET  D
 . S CSET0=$G(^ICDD(83.3,CMPTSET,0))
 . S MDCCAT=$P(CSET0,U,2),CMPTD=$P(CSET0,U,6),LINK=$P(CSET0,U,7),NUM=$P(LINK,"-",2),CNT=0
 . ;
 . S SETIFN=0 F  S SETIFN=$O(^ICDD(83.3,"ACSL",LINK,SETIFN)) Q:'SETIFN  I SETIFN'=CMPTSET D
 .. S LINE=$G(^ICDD(83.3,SETIFN,0)) S COUNT=$P($P(LINE,U,8)," ",1) I $P(LINE,U,2)'=MDCCAT Q
 .. ;
 .. I CMPTD=6 I $D(CDSARR(SETIFN)) S CNT=CNT+1 ; one or more sets in group required
 .. ;
 .. I CMPTD=5 I $D(CDSARR(SETIFN)) S CNT=CNT+1 ; one or more sets necessary for condition
 .. ;
 .. I CMPTD=4 S CNT=CNT+($S(COUNT="ONE":1,COUNT="TWO":2,COUNT="THREE":3,COUNT="FOUR":4,1:0)*$G(LINKARR(LINK,SETIFN)))
 . ;
 . I +CNT,CNT'<NUM S IX=99_CMPTD S CDSARR(CMPTSET,IX)=U_$P(CSET0,U,3)
 ;
 Q
